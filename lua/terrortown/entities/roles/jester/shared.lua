if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_jes.vmt")
end

roles.InitCustomTeam(ROLE.name, {
	icon = "vgui/ttt/dynamic/roles/icon_jes",
	color = Color(245, 48, 155, 255)
})

function ROLE:PreInitialize()
	self.color = Color(245, 48, 155, 255)

	self.abbr = "jes"
	self.score.surviveBonusMultiplier = 0
	self.score.aliveTeammatesBonusMultiplier = 0
	self.score.survivePenaltyMultiplier = -4
	self.score.timelimitMultiplier = -4
	self.score.killsMultiplier = 0
	self.score.teamKillsMultiplier = -16
	self.score.bodyFoundMuliplier = 0
	self.preventWin = true

	self.defaultTeam = TEAM_JESTER
	self.defaultEquipment = SPECIAL_EQUIPMENT

	self.conVarData = {
		pct = 0.17,
		maximum = 1,
		minPlayers = 6,
		togglable = true
	}
end

hook.Add("TTT2PlayerPreventPickupEnt", "TTT2ToggleJesPickupEnt", function(ply)
	if ply:GetSubRole() == ROLE_JESTER and not GetGlobalBool("ttt2_jes_carry", false) then
		return true
	end
end)

if SERVER then
	-- ConVar syncing
	local cv = {}
	cv.pickup_allowed = CreateConVar("ttt2_jes_carry", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	cv.announce = CreateConVar("ttt2_jes_announce", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	cv.pushing_allowed = CreateConVar("ttt2_jes_improvised", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	cv.ignitedmg = CreateConVar("ttt2_jes_ignitedmg", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	cv.explosiondmg = CreateConVar("ttt2_jes_explosiondmg", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	cv.exposed_to_all_evils = CreateConVar("ttt2_jes_exppose_to_all_evils", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE})

	function ROLE:GiveRoleLoadout(ply, isRoleChange)
		if not cv.ignitedmg:GetBool() then
			ply:GiveEquipmentItem("item_ttt_nofiredmg")
		end

		if not cv.explosiondmg:GetBool() then
			ply:GiveEquipmentItem("item_ttt_noexplosiondmg")
		end
	end

	function ROLE:RemoveRoleLoadout(ply, isRoleChange)
		if not cv.ignitedmg:GetBool() then
			ply:RemoveEquipmentItem("item_ttt_nofiredmg")
		end

		if not cv.explosiondmg:GetBool() then
			ply:RemoveEquipmentItem("item_ttt_noexplosiondmg")
		end
	end

	-- SYNC CONVAR - GLOBAL BOOL
	hook.Add("TTT2SyncGlobals", "TTT2JesSyncGlobals", function()
		SetGlobalBool("ttt2_jes_carry", cv.pickup_allowed:GetBool())
	end)

	cvars.AddChangeCallback(cv.pickup_allowed:GetName(), function(name, old, new)
		SetGlobalBool("ttt2_jes_carry", tonumber(new) == 1)
	end, cv.pickup_allowed:GetName())

	-- HANDLE PLAYER PUSH HOOK
	hook.Add("TTT2PlayerPreventPush", "TTT2ToggleJesPushing", function(ply)
		if ply:GetSubRole() == ROLE_JESTER and not cv.pushing_allowed:GetBool() then
			return true
		end
	end)

	-- HANDLE WINNING HOOK
	hook.Add("TTTCheckForWin", "JesterCheckWin", function()
		if roles.JESTER.shouldWin then
			roles.JESTER.shouldWin = false

			return TEAM_JESTER
		end
	end)

	local function ShouldShowJesterToTeam(ply)
		local overrideShow = hook.Run("TTT2JesterShouldShow", ply)

		if overrideShow ~= nil then return overrideShow end

		return (cv.exposed_to_all_evils:GetBool() and ply:GetTeam() ~= TEAM_INNOCENT and not ply:GetSubRoleData().unknownTeam)
			or (not cv.exposed_to_all_evils:GetBool() and ply:GetTeam() == TEAM_TRAITOR)
	end

	-- inform other players about the jesters in this round
	hook.Add("TTTBeginRound", "JesterRoundStartMessage", function()
		-- jester is not enabled so we don't want to notify players at all
		if not GetConVar("ttt_jester_enabled"):GetBool() then
			return
		end

		-- GET A LIST OF ALL JESTERS
		local jesPlys = util.GetFilteredPlayers(function(p)
			return p:GetTeam() == TEAM_JESTER
		end)

		hook.Run("TTT2JesterModifyList", jesPlys)

		local jester_amnt = 0
		local jester_string = ""

		for i = 1, #jesPlys do
			local ply = jesPlys[i]

			if jester_amnt > 0 then
				jester_string = jester_string .. ", "
			end

			jester_string = jester_string .. ply:Nick()

			jester_amnt = jester_amnt + 1
		end

		-- NOTIFY ALL PLAYERS IF THERE IS A JESTER THIS ROUND
		if cv.announce:GetBool() then
			if jester_amnt == 0 then
				LANG.MsgAll("ttt2_role_jester_info_no_jester", nil, MSG_MSTACK_PLAIN)
			else
				LANG.MsgAll("ttt2_role_jester_info_no_kill", nil, MSG_MSTACK_WARN)
			end
		end

		if jester_amnt == 0 then return end

		-- NOTIFY TRAITORS ABOUT JESTERS THIS ROUND
		local plys = player.GetAll()
		for i = 1, #plys do
			local ply = plys[i]

			if ply:GetTeam() == TEAM_JESTER or not ShouldShowJesterToTeam(ply) then continue end

			if jester_amnt == 1 then
				LANG.Msg(ply, "ttt2_role_jester_info_jester_single", {playername = jester_string}, MSG_MSTACK_ROLE)
			else
				LANG.Msg(ply, "ttt2_role_jester_info_jester_multiple", {playernames = jester_string}, MSG_MSTACK_ROLE)
			end
		end
	end)

	-- the jester is not able to pick up molotov cocktails or confgrenades
	hook.Add("PlayerCanPickupWeapon", "JesterPickupWeapon", function(ply, wep)
		if not IsValid(ply) or not IsValid(wep) or ply:GetSubRole() ~= ROLE_JESTER then return end

		if wep:GetClass() == "weapon_zm_molotov" then
			return false
		end

		if wep:GetClass() == "weapon_ttt_confgrenade" then
			return false
		end
	end)

	-- Show the roles of the jester to the respective opponents
	hook.Add("TTT2SpecialRoleSyncing", "TTT2RoleJesterSpecialSync", function(ply, tbl)
		if GetRoundState() == ROUND_POST or not IsValid(ply) or ply:GetTeam() == TEAM_JESTER
			or not ShouldShowJesterToTeam(ply)
		then return end

		for syncPly in pairs(tbl) do
			if syncPly:GetTeam() ~= TEAM_JESTER or not syncPly:IsTerror() or syncPly == ply then continue end

			tbl[syncPly] = hook.Run("TTT2JesterModifySyncedRole", ply, syncPly) or {syncPly:GetSubRole(), syncPly:GetTeam()}
		end
	end)

	hook.Add("TTT2ModifyRadarRole", "TTT2ModifyRadarRoleJester", function(ply, target)
		if not target:GetTeam() == TEAM_JESTER or not ShouldShowJesterToTeam(ply) then return end

		local roleAndTeam = hook.Run("TTT2JesterModifySyncedRole", ply, target)

		if roleAndTeam then
			return roleAndTeam[1], roleAndTeam[2]
		end
	end)
end

if CLIENT then
	function ROLE:AddToSettingsMenu(parent)
		local form = vgui.CreateTTT2Form(parent, "header_roles_additional")

		form:MakeCheckBox({
			serverConvar = "ttt2_jes_announce",
			label = "label_jes_announce"
		})

		form:MakeCheckBox({
			serverConvar = "ttt2_jes_improvised",
			label = "label_jes_improvised"
		})

		form:MakeCheckBox({
			serverConvar = "ttt2_jes_carry",
			label = "label_jes_carry"
		})

		form:MakeCheckBox({
			serverConvar = "ttt2_jes_ignitedmg",
			label = "label_jes_ignitedmg"
		})

		form:MakeCheckBox({
			serverConvar = "ttt2_jes_explosiondmg",
			label = "label_jes_explosiondmg"
		})

		form:MakeCheckBox({
			serverConvar = "ttt2_jes_exppose_to_all_evils",
			label = "label_jes_exppose_to_all_evils"
		})
	end
end
