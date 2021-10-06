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
	self.score.surviveBonusMultiplier = -2
	self.score.timelimitMultiplier = -2
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

hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicJesCVars", function(tbl)
	tbl[ROLE_JESTER] = tbl[ROLE_JESTER] or {}

	table.insert(tbl[ROLE_JESTER], {
		cvar = "ttt2_jes_announce",
		checkbox = true,
		desc = "Announce if a jester is in the round (Def. 1)"
	})

	table.insert(tbl[ROLE_JESTER], {
		cvar = "ttt2_jes_improvised",
		checkbox = true,
		desc = "Jester can push other players (Def. 1)"
	})

	table.insert(tbl[ROLE_JESTER], {
		cvar = "ttt2_jes_carry",
		checkbox = true,
		desc = "Jester can pickup entities with the magneto stick (Def. 1)"
	})

	table.insert(tbl[ROLE_JESTER], {
		cvar = "ttt2_jes_ignitedmg",
		checkbox = true,
		desc = "Jester receives fire damage (Def. 1)"
	})

	table.insert(tbl[ROLE_JESTER], {
		cvar = "ttt2_jes_explosiondmg",
		checkbox = true,
		desc = "Jester receives explosion damage (Def. 1)"
	})

	table.insert(tbl[ROLE_JESTER], {
		cvar = "ttt2_jes_exppose_to_all_evils",
		checkbox = true,
		desc = "Exposes their role to all evil roles (Def. 0)"
	})
end)

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
		if JESTER.shouldWin then
			JESTER.shouldWin = false

			return TEAM_JESTER
		end
	end)

	local function ShouldShowJesterToTeam(ply)
		return (cv.exposed_to_all_evils:GetBool() and ply:GetTeam() ~= TEAM_INNOCENT and not ply:GetSubRoleData().unknownTeam)
			or (not cv.exposed_to_all_evils:GetBool() and ply:GetTeam() == TEAM_TRAITOR)
	end

	-- inform other players about the jesters in this round
	hook.Add("TTTBeginRound", "JesterRoundStartMessage", function()
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

		local roleAndTeam = hook.Run("TTT2JesterModifySyncedRole", ply, syncPly) or {syncPly:GetSubRole(), syncPly:GetTeam()}

		return roleAndTeam[1], roleAndTeam[2]
	end)
end
