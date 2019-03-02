if SERVER then
	AddCSLuaFile()

	resource.AddFile("sound/ttt2/birthdayparty.mp3")

	util.PrecacheSound("ttt2/birthdayparty.mp3")

	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_jes.vmt")
	resource.AddFile("materials/confetti.png")
end

CreateConVar("ttt2_jes_winstate", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_jes_winpoints", "6", {FCVAR_NOTIFY, FCVAR_ARCHIVE})

if SERVER then
	include("winstates.lua")
end

hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicJesCVars", function(tbl)
	tbl[ROLE_JESTER] = tbl[ROLE_JESTER] or {}

	table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate", checkbox = true, desc = "Jester winstate (Def. 1)"})
	table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate_1", checkbox = true, desc = "Jester winstate 1 (Def. 1)"})
	table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate_2", checkbox = true, desc = "Jester winstate 2 (Def. 1)"})
	table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate_3", checkbox = true, desc = "Jester winstate 3 (Def. 1)"})
	table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate_4", checkbox = true, desc = "Jester winstate 4 (Def. 1)"})
	table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate_5", checkbox = true, desc = "Jester winstate 5 (Def. 1)"})
end)

-- creates global var "TEAM_JESTER" and other required things
-- TEAM_[name], data: e.g. icon, color,...
roles.InitCustomTeam(ROLE.name, { -- this creates var "TEAM_JESTER"
		icon = "vgui/ttt/dynamic/roles/icon_jes",
		color = Color(245, 48, 155, 255)
})

ROLE.color = Color(245, 48, 155, 255) -- ...
ROLE.dkcolor = Color(229, 0, 125, 255) -- ...
ROLE.bgcolor = Color(181, 251, 49, 255) -- ...
ROLE.abbr = "jes" -- abbreviation
ROLE.defaultEquipment = INNO_EQUIPMENT -- here you can set up your own default equipment
ROLE.visibleForTraitors = true -- other traitors can see this role / sync them with traitors
ROLE.surviveBonus = 0 -- bonus multiplier for every survive while another player was killed
ROLE.scoreKillsMultiplier = 1 -- multiplier for kill of player of another team
ROLE.scoreTeamKillsMultiplier = -8 -- multiplier for teamkill
ROLE.preventWin = true -- set true if role can't win (maybe because of own / special win conditions)
ROLE.defaultTeam = TEAM_JESTER -- set/link default team to register it

ROLE.conVarData = {
	pct = 0.17, -- necessary: percentage of getting this role selected (per player)
	maximum = 1, -- maximum amount of roles in a round
	minPlayers = 6, -- minimum amount of players until this role is able to get selected
	togglable = true -- option to toggle a role for a client if possible (F1 menu)
}

-- if roles loading has finished
hook.Add("TTT2FinishedLoading", "JesterInitT", function()
	if CLIENT then
		-- setup here is not necessary but if you want to access the role data, you need to start here
		-- setup basic translation !
		LANG.AddToLanguage("English", JESTER.name, "Jester")
		LANG.AddToLanguage("English", TEAM_JESTER, "TEAM Jesters")
		LANG.AddToLanguage("English", "hilite_win_" .. TEAM_JESTER, "THE JES WON") -- name of base role of a team -> maybe access with GetBaseRole(ROLE_JESTER) or JESTER.baserole
		LANG.AddToLanguage("English", "win_" .. TEAM_JESTER, "The Jester has won!") -- teamname
		LANG.AddToLanguage("English", "info_popup_" .. JESTER.name, [[You are the JESTER! Make TROUBLE and let 'em kill you!]])
		LANG.AddToLanguage("English", "body_found_" .. JESTER.abbr, "This was a Jester...")
		LANG.AddToLanguage("English", "search_role_" .. JESTER.abbr, "This person was a Jester!")
		LANG.AddToLanguage("English", "ev_win_" .. TEAM_JESTER, "The goofy Jester won the round!")
		LANG.AddToLanguage("English", "target_" .. JESTER.name, "Jester")
		LANG.AddToLanguage("English", "ttt2_desc_" .. JESTER.name, [[The Jester is visible for any traitor, but not for innocents or other "normal" roles (except custom traitor roles or the Clairvoyant).
The Jester can't do any damage or kill himself. But if he dies, he will WIN. So don't kill the Jester!]])

		---------------------------------

		-- maybe this language as well...
		LANG.AddToLanguage("Deutsch", JESTER.name, "Narr")
		LANG.AddToLanguage("Deutsch", TEAM_JESTER, "TEAM Narren")
		LANG.AddToLanguage("Deutsch", "hilite_win_" .. TEAM_JESTER, "THE JES WON")
		LANG.AddToLanguage("Deutsch", "win_" .. TEAM_JESTER, "Der Narr hat gewonnen!")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. JESTER.name, [[Du bist DER NARR! Stifte Unruhe und geh drauf!]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. JESTER.abbr, "Er war ein Narr...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. JESTER.abbr, "Diese Person war ein Narr!")
		LANG.AddToLanguage("Deutsch", "ev_win_" .. TEAM_JESTER, "Der trottelige Narr hat die Runde gewonnen!")
		LANG.AddToLanguage("Deutsch", "target_" .. JESTER.name, "Narr")
		LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. JESTER.name, [[Der Narr ist für alle Verräter (und Serienkiller) sichtbar, aber nicht für Unschuldige oder andere "normale" Rollen (außer spezielle Varräter-Rollen oder den Hellseher).
Der Narr kann keinen Schaden anrichten und sich auch nicht selbst umbringen. Doch wenn er stirbt, GEWINNT er allein. Also töte NICHT den Narr!]])
	end
end)

if SERVER then
	util.AddNetworkString("NewConfetti")

	--------

	hook.Add("TTT2ModifyDefaultLoadout", "ModifyJESLoadout", function(loadout_weapons, subrole)
		if subrole == ROLE_JESTER then
			for k, v in ipairs(loadout_weapons[subrole]) do
				if v == "weapon_zm_carry" then
					table.remove(loadout_weapons[subrole], k)

					local tbl = weapons.GetStored("weapon_zm_carry")

					if tbl and tbl.InLoadoutFor then
						for k2, sr in ipairs(tbl.InLoadoutFor) do
							if sr == subrole then
								table.remove(tbl.InLoadoutFor, k2)
							end
						end
					end
				elseif v == "weapon_zm_improvised" then
					table.remove(loadout_weapons[subrole], k)

					local tbl = weapons.GetStored("weapon_zm_improvised")

					if tbl and tbl.InLoadoutFor then
						for k2, sr in ipairs(tbl.InLoadoutFor) do
							if sr == subrole then
								table.remove(tbl.InLoadoutFor, k2)
							end
						end
					end
				end
			end
		end
	end)

	hook.Add("TTTCheckForWin", "JesterCheckWin", function()
		if GetConVar("ttt2_jes_winstate"):GetInt() == 0 then
			for _, v in ipairs(player.GetAll()) do
				if v:GetSubRole() == ROLE_JESTER and not v:Alive() then
					return TEAM_JESTER -- JESTER TEAM WINS
				end
			end
		end
	end)

	hook.Add("PlayerDeath", "JesterDeath", function(victim, infl, attacker)
		if victim:GetSubRole() == ROLE_JESTER and IsValid(attacker) and attacker:IsPlayer() and infl:GetClass() ~= env_fire and attacker:GetSubRole() ~= ROLE_JESTER then
			victim.jesterKiller = attacker

			if hook.Run("TTT2PreventJesterDeath", victim) then
				victim.jesterKiller = nil

				return
			end

			for _, v in ipairs(player.GetAll()) do
				v:PrintMessage(HUD_PRINTCENTER, "'" .. attacker:Nick() .. "' killed the Jester...")
			end

			if GetConVar("ttt2_jes_winstate"):GetInt() == 1 then
				victim:AddFrags(GetConVar("ttt2_jes_winpoints"):GetInt())
			end
		end
	end)

	hook.Add("TTT2PreventJesterDeath", "JesterMainPreventDeath", function(ply)
		if GetConVar("ttt2_jes_winstate"):GetInt() == 0 then
			return true
		end
	end)

	hook.Add("PostPlayerDeath", "JesterPostDeath", function(ply)
		if ply:GetSubRole() == ROLE_JESTER then
			if hook.Run("TTT2PreventJesterDeath", ply) then return end

			local killer = ply.jesterKiller

			ply.jesterKiller = nil

			if not IsValid(killer) then return end

			JesterWinstate(ply, killer)
		end
	end)

	hook.Add("TTTPrepareRound", "JesterInit", function()
		local minPlayers = GetConVar("ttt_" .. JESTER.name .. "_min_players"):GetInt()
		local players = player.GetAll()

		if #players >= minPlayers then
			for _, v in ipairs(players) do
				v:ChatPrint("Don't kill the Jester!")
			end
		end
	end)

	hook.Add("TTT2TellTraitors", "JesterTraitorMsg", function()
		local jesters = {}

		for _, v in ipairs(player.GetAll()) do
			if v:GetSubRole() == ROLE_JESTER then
				table.insert(jesters, v:Nick())
			end
		end

		for _, v in ipairs(player.GetAll()) do
			if #jesters < 1 then
				v:PrintMessage(HUD_PRINTTALK, "There are no Jesters!")
			else
				for _, ply in ipairs(jesters) do
					if v:HasTeam(TEAM_TRAITOR) or ROLE_JACKAL and v:IsRole(ROLE_JACKAL) then
						v:PrintMessage(HUD_PRINTTALK, "'" .. ply .. "' is the Jester!")
					end
				end
			end
		end
	end)

	hook.Add("PlayerShouldTakeDamage", "JesterShouldntTakeDamage", function(ply, attacker)
		if ply:GetSubRole() == ROLE_JESTER and (not IsValid(attacker) or not attacker:IsPlayer() or attacker == ply) then
			return false
		elseif IsValid(attacker) and attacker:IsPlayer() and attacker:GetSubRole() == ROLE_JESTER then
			return false
		end
	end)

	hook.Add("EntityTakeDamage", "JesterTakesNoDamage", function(ply, dmginfo)
		local attacker = dmginfo:GetAttacker()

		if IsValid(ply) and ply:IsPlayer() and ply:GetSubRole() == ROLE_JESTER and (not IsValid(attacker) or not attacker:IsPlayer() or attacker == ply) then
			return true -- block damage
		elseif IsValid(attacker) and attacker:IsPlayer() and attacker:GetSubRole() == ROLE_JESTER then
			return true -- block damage
		end
	end)

	hook.Add("DoPlayerDeath", "JesterDoDeath", function(ply, attacker, dmginfo)
		if ply:GetSubRole() == ROLE_JESTER and not (IsValid(attacker) and attacker:IsPlayer() and INFECTED and attacker:GetSubRole() == ROLE_INFECTED) then
			--local HeadIndex = ply:LookupBone("ValveBiped.bip01_pelvis")
			--local HeadPos, HeadAng = ply:GetBonePosition(HeadIndex)

			net.Start("NewConfetti")
			net.WriteEntity(ply)
			net.Broadcast()

			ply:EmitSound("ttt2/birthdayparty.mp3")
		end
	end)

	hook.Add("TTTBeginRound", "JesterBeginRound", function()
		for _, v in ipairs(player.GetAll()) do
			if v:GetSubRole() == ROLE_JESTER then
				v:StripWeapon("weapon_zm_molotov")
				v:StripWeapon("weapon_ttt_confgrenade")
			end
		end
	end)

	hook.Add("TTTEndRound", "JesterEndRound", function()
		for _, v in ipairs(player.GetAll()) do
			hook.Remove("PostPlayerDeath", "JesterWaitForKillerDeath_" .. v:Nick())
		end
	end)

	hook.Add("PlayerCanPickupWeapon", "JesterPickupWeapon", function(ply, wep)
		if IsValid(ply) and IsValid(wep) and ply:GetSubRole() == ROLE_JESTER then
			if wep:GetClass() == "weapon_zm_molotov" then
				return false
			end

			if wep:GetClass() == "weapon_ttt_confgrenade" then
				return false
			end
		end
	end)
end

-- following code by Jenssons
if CLIENT then
	local confetti = Material("confetti.png")

	net.Receive("NewConfetti", function()
		local ent = net.ReadEntity()

		if not IsValid(ent) then return end

		ent:EmitSound("ttt2/birthdayparty.mp3") -- Play the sound

		local pos = ent:GetPos() + Vector(0, 0, ent:OBBMaxs().z)

		if ent.GetShootPos then
			pos = ent:GetShootPos()
		end

		local velMax = 200
		local gravMax = 50

		local gravity = Vector(math.random(-gravMax, gravMax), math.random(-gravMax, gravMax), math.random(-gravMax, 0))

		--Handles particles
		local emitter = ParticleEmitter(pos, true)

		for i = 1, 150 do
			local p = emitter:Add(confetti, pos)
			p:SetStartSize(math.random(6, 10))
			p:SetEndSize(0)
			p:SetAngles(Angle(math.random(0, 360), math.random(0, 360), math.random(0, 360)))
			p:SetAngleVelocity(Angle(math.random(5, 50), math.random(5, 50), math.random(5, 50)))
			p:SetVelocity(Vector(math.random(-velMax, velMax), math.random(-velMax, velMax), math.random(-velMax, velMax)))
			p:SetColor(255, 255, 255)
			p:SetDieTime(math.random(4, 7))
			p:SetGravity(gravity)
			p:SetAirResistance(125)
		end
	end)
end
