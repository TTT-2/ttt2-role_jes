if SERVER then
	AddCSLuaFile()

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_jes.vmt")
end

-- creates global var "TEAM_JESTER" and other required things
-- TEAM_[name], data: e.g. icon, color,...
roles.InitCustomTeam(ROLE.name, { -- this creates var "TEAM_JESTER"
		icon = "vgui/ttt/dynamic/roles/icon_jes",
		color = Color(245, 48, 155, 255)
})

function ROLE:PreInitialize()
	self.color = Color(245, 48, 155, 255)

	self.abbr = "jes" -- abbreviation
	self.visibleForTraitors = true -- other traitors can see this role / sync them with traitors
	self.surviveBonus = 0 -- bonus multiplier for every survive while another player was killed
	self.scoreKillsMultiplier = 1 -- multiplier for kill of player of another team
	self.scoreTeamKillsMultiplier = -8 -- multiplier for teamkill
	self.preventWin = true -- set true if role can't win (maybe because of own / special win conditions)

	self.defaultTeam = TEAM_JESTER -- set/link default team to register it
	self.defaultEquipment = INNO_EQUIPMENT -- here you can set up your own default equipment

	self.conVarData = {
		pct = 0.17, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 6, -- minimum amount of players until this role is able to get selected
		togglable = true -- option to toggle a role for a client if possible (F1 menu)
	}
end

-- if roles loading has finished
function ROLE:Initialize()
	if CLIENT then
		-- Role specific language elements
		LANG.AddToLanguage("English", self.name, "Jester")
		LANG.AddToLanguage("English", self.defaultTeam, "TEAM Jesters")
		LANG.AddToLanguage("English", "hilite_win_" .. self.defaultTeam, "THE JESTER WON")
		LANG.AddToLanguage("English", "win_" .. self.defaultTeam, "The Jester has won!")
		LANG.AddToLanguage("English", "info_popup_" .. self.name, [[You are the JESTER! Make TROUBLE and let 'em kill you!]])
		LANG.AddToLanguage("English", "body_found_" .. self.abbr, "This was a Jester...")
		LANG.AddToLanguage("English", "search_role_" .. self.abbr, "This person was a Jester!")
		LANG.AddToLanguage("English", "ev_win_" .. self.defaultTeam, "The goofy Jester won the round!")
		LANG.AddToLanguage("English", "target_" .. self.name, "Jester")
		LANG.AddToLanguage("English", "ttt2_desc_" .. self.name, [[The Jester is visible for any traitor, but not for innocents or other "normal" roles (except custom traitor roles or the Clairvoyant).
The Jester can't do any damage or kill himself. But if he dies, he will WIN. So don't kill the Jester!]])

		LANG.AddToLanguage("Deutsch", self.name, "Narr")
		LANG.AddToLanguage("Deutsch", self.defaultTeam, "TEAM Narren")
		LANG.AddToLanguage("Deutsch", "hilite_win_" .. self.defaultTeam, "THE JESTER WON")
		LANG.AddToLanguage("Deutsch", "win_" .. self.defaultTeam, "Der Narr hat gewonnen!")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. self.name, [[Du bist DER NARR! Stifte Unruhe und geh drauf!]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. self.abbr, "Er war ein Narr...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. self.abbr, "Diese Person war ein Narr!")
		LANG.AddToLanguage("Deutsch", "ev_win_" .. self.defaultTeam, "Der trottelige Narr hat die Runde gewonnen!")
		LANG.AddToLanguage("Deutsch", "target_" .. self.name, "Narr")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. self.name, [[Der Narr ist für alle Verräter (und Serienkiller) sichtbar, aber nicht für Unschuldige oder andere "normale" Rollen (außer spezielle Varräter-Rollen oder den Hellseher).
Der Narr kann keinen Schaden anrichten und sich auch nicht selbst umbringen. Doch wenn er stirbt, GEWINNT er allein. Also töte NICHT den Narr!]])
	end
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
	table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate", slider = true, min = 0, max = 7, decimal = 0, desc = "ttt2_jes_winstate (Def. 1)"})
	table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_announce", checkbox = true, desc = "ttt2_jes_announce (Def. 1)"})
	table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_improvised", checkbox = true, desc = "Jester can push other players (Def. 1)"})
	table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_carry", checkbox = true, desc = "Jester can pickup entities with the magneto stick (Def. 1)"})
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
	cv.pushing_allowed = CreateConVar("ttt2_jes_improvised", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})

	hook.Add("TTT2SyncGlobals", "TTT2JesSyncGlobals", function()
		SetGlobalBool("ttt2_jes_carry", cv.pickup_allowed:GetBool())
	end)

	cvars.AddChangeCallback(cv.pickup_allowed:GetName(), function(name, old, new)
		SetGlobalBool("ttt2_jes_carry", tonumber(new) == 1)
	end, cv.pickup_allowed:GetName())

	hook.Add("TTT2PlayerPreventPush", "TTT2ToggleJesPushing", function(ply)
		if ply:GetSubRole() == ROLE_JESTER and not cv.pushing_allowed:GetBool() then
			return true
		end
	end)

	hook.Add("TTTCheckForWin", "JesterCheckWin", function()
		if jesterShouldWin then
			jesterShouldWin = false

			return TEAM_JESTER
		end
	end)

	-- inform other players about the jesters in this round
	hook.Add("TTT2TellTraitors", "JesterTraitorMsg", function()
		if not GetConVar("ttt_" .. JESTER.name .. "_enabled"):GetBool() then return end

		if GetConVar("ttt_" .. JESTER.name .. "_enabled"):GetInt() > #(player.GetAll()) then return end

		-- GET A LIST OF ALL JESTERS
		local jester_amnt = 0
		local jester_string = ""

		for _, v in ipairs(player.GetAll()) do
			if v:GetSubRole() == ROLE_JESTER then
				if jester_amnt > 0 then
					jester_string = jester_string .. ", "
				end

				jester_string = jester_string .. v:Nick()

				jester_amnt = jester_amnt + 1
			end
		end

		-- NOTOFY ALL PLAYERS IF THERE IS A JESTER THIS ROUND
		if cv.announce:GetBool() then
			if jester_amnt == 0 then
				LANG.MsgAll("Don't kill the Jester!", nil, MSG_MSTACK_WARN)
			else
				LANG.MsgAll("There are no Jesters!", nil, MSG_MSTACK_PLAIN)
			end
		end

		if jester_amnt == 0 then return end

		-- NOTIFY TRAITORS ABOUT JESTERS THIS ROUND
		for _, v in ipairs(player.GetAll()) do
			if v:GetTeam() == TEAM_TRAITOR then
				if jester_amnt == 1 then
					LANG.Msg(v, "'" .. jester_string .. "' is the Jester!", nil, MSG_MSTACK_ROLE)
				else
					LANG.Msg(v, "'" .. jester_string .. "' are the Jesters!", nil, MSG_MSTACK_ROLE)
				end
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
end
