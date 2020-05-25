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
	self.visibleForTeam = {TEAM_TRAITOR}
	self.surviveBonus = 0
	self.scoreKillsMultiplier = 1
	self.scoreTeamKillsMultiplier = -8
	self.preventWin = true

	self.defaultTeam = TEAM_JESTER
	self.defaultEquipment = INNO_EQUIPMENT

	self.conVarData = {
		pct = 0.17,
		maximum = 1,
		minPlayers = 6,
		togglable = true
	}
end

hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicJesCVars", function(tbl)
	tbl[ROLE_JESTER] = tbl[ROLE_JESTER] or {}

	-- WINSTATES
	-- 0: Selects a random winstate
	-- 1: Default, if the jester is killed, he has won
	-- 2: Jester respawns after three seconds with a random opposite role of his killer
	-- 3: Jester respawns after killer death with a random opposite role
	-- 4: Jester respawns after killer death with the role of his killer
	-- 5: Jester respawns after three seconds with the role of the killer and the killer dies
	-- 6: Jester respawns within three seconds with a role in an opposing team of the killer and the killer dies
	-- 7: Like 5, unless the killer is a traitor or serialkiller, then jester is killed normally
	table.insert(tbl[ROLE_JESTER], {
		cvar = "ttt2_jes_winstate",
		combobox = true,
		desc = "Winstate (Def. 1)",
		choices = {
			"0 - Select a random winstate",
			"1 - Jester wins if he's killed",
			"2 - Respawn with opposite killer role",
			"3 - Respawn with opposite killer role after killer death",
			"4 - Respawn with killer role after killer death",
			"5 - Respawn with killer role and killer dies",
			"6 - Respawn with opposite killer role and killer dies",
			"7 - like 5, unless killer is serialkiller or traitor"
		},
		numStart = 0
	})

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
		cvar = "ttt2_jes_announce_winstate",
		checkbox = true,
		desc = "Announce the current winstate to jesters (Def. 1)"
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
	cv.winstate = CreateConVar("ttt2_jes_winstate", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
	cv.announce = CreateConVar("ttt2_jes_announce", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	cv.announce_winstate = CreateConVar("ttt2_jes_announce_winstate", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	cv.pushing_allowed = CreateConVar("ttt2_jes_improvised", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	cv.ignitedmg = CreateConVar("ttt2_jes_ignitedmg", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	cv.explosiondmg = CreateConVar("ttt2_jes_explosiondmg", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})

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

	local function SetUpWinstate()
		-- SET WINSTATE AT ROUND BEGIN
		JESTER.winstate = cv.winstate:GetInt()

		if JESTER.winstate == 0 then
			JESTER.winstate = math.random(1, 7)
		end

		-- NOTIFY JESTERS ABOUT THE CURRENT WINSTATE
		if cv.announce_winstate:GetBool() then
			local players = player.GetAll()
			local jester_players = {}

			for i = 1, #players do
				local ply = players[i]

				if ply:GetSubRole() == ROLE_JESTER then
					jester_players[#jester_players + 1] = ply
				end
			end

			if cv.winstate:GetInt() == 0 then
				LANG.Msg(jester_players, "ttt2_role_jester_winstate_0", nil, MSG_MSTACK_ROLE)
			end

			LANG.Msg(jester_players, "ttt2_role_jester_winstate_" .. JESTER.winstate, nil, MSG_MSTACK_ROLE)
		end

		-- UPDATE RADAR VISIBILITY
		if JESTER.winstate == 7 then
			JESTER.visibleForTeam = {TEAM_TRAITOR, TEAM_SERIALKILLER}
		else
			JESTER.visibleForTeam = {TEAM_TRAITOR}
		end
	end

	-- SYNC CONVAR - GLOBAL BOOL
	hook.Add("TTT2SyncGlobals", "TTT2JesSyncGlobals", function()
		SetGlobalBool("ttt2_jes_carry", cv.pickup_allowed:GetBool())
	end)

	cvars.AddChangeCallback(cv.pickup_allowed:GetName(), function(name, old, new)
		SetGlobalBool("ttt2_jes_carry", tonumber(new) == 1)
	end, cv.pickup_allowed:GetName())

	-- REACT TO WINSTATE CHANGE
	cvars.AddChangeCallback(cv.winstate:GetName(), function(name, old, new)
		SetUpWinstate()
	end, cv.winstate:GetName())

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

	-- inform other players about the jesters in this round
	hook.Add("TTTBeginRound", "JesterTraitorMsg", function()
		if not GetConVar("ttt_" .. JESTER.name .. "_enabled"):GetBool() then return end

		if GetConVar("ttt_" .. JESTER.name .. "_enabled"):GetInt() > #(player.GetAll()) then return end

		-- GET A LIST OF ALL JESTERS
		local jester_amnt = 0
		local jester_string = ""

		local players = player.GetAll()
		for i = 1, #players do
			local ply = players[i]

			if ply:GetSubRole() == ROLE_JESTER then
				if jester_amnt > 0 then
					jester_string = jester_string .. ", "
				end

				jester_string = jester_string .. ply:Nick()

				jester_amnt = jester_amnt + 1
			end
		end

		-- SETUP WINSTATE AND NOTIFY JESTER
		SetUpWinstate()

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
		if jester_amnt == 1 then
			LANG.Msg(ROLE_TRAITOR, "ttt2_role_jester_info_jester_single", {playername = jester_string}, MSG_MSTACK_ROLE)
		else
			LANG.Msg(ROLE_TRAITOR, "ttt2_role_jester_info_jester_multiple", {playernames = jester_string}, MSG_MSTACK_ROLE)
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
end
