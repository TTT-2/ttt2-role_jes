if SERVER then
	AddCSLuaFile()

	include("winstates.lua")

	resource.AddFile("sound/ttt2/birthdayparty.mp3")

	resource.AddFile("materials/vgui/ttt/icon_jes.vmt")
	resource.AddFile("materials/vgui/ttt/sprite_jes.vmt")
	resource.AddFile("materials/confetti.png")
end

CreateConVar("ttt2_jes_winstate", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_jes_winpoints", "6", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})

-- creates global var "TEAM_JESTER" and other required things
-- TEAM_[name], data: e.g. icon, color,...
InitCustomTeam("JESTER", {
		icon = "vgui/ttt/sprite_jes",
		color = Color(255, 105, 180, 200)
})

InitCustomRole("JESTER", { -- first param is access for ROLES array => ROLES["JESTER"] or ROLES.JESTER or JESTER
		color = Color(255, 105, 180, 200), -- ...
		dkcolor = Color(255, 51, 153, 255), -- ...
		bgcolor = Color(255, 85, 100, 200), -- ...
		name = "jester", -- just a unique name for the script to determine
		abbr = "jes", -- abbreviation
		team = "jesters", -- the team name: roles with same team name are working together
		defaultEquipment = INNO_EQUIPMENT, -- here you can set up your own default equipment
		visibleForTraitors = true, -- other traitors can see this role / sync them with traitors
		surviveBonus = 0, -- bonus multiplier for every survive while another player was killed
		scoreKillsMultiplier = 1, -- multiplier for kill of player of another team
		scoreTeamKillsMultiplier = -8, -- multiplier for teamkill
		preventWin = true, -- set true if role can't win (maybe because of own / special win conditions)
		defaultTeam = TEAM_JESTER -- set/link default team to register it
	}, {
		pct = 0.17, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 6, -- minimum amount of players until this role is able to get selected
		togglable = true -- option to toggle a role for a client if possible (F1 menu)
})

-- if sync of roles has finished
hook.Add("TTT2FinishedLoading", "JesterInitT", function()
	hook.Add("TTTUlxDynamicRCVars", "TTTUlxDynamicJesCVars", function(tbl)
		tbl[ROLE_JESTER] = tbl[ROLE_JESTER] or {}

		table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate", checkbox = true, desc = "Jester winstate (Def. 1)"})
		table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate_1", checkbox = true, desc = "Jester winstate 1 (Def. 1)"})
		table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate_2", checkbox = true, desc = "Jester winstate 2 (Def. 1)"})
		table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate_3", checkbox = true, desc = "Jester winstate 3 (Def. 1)"})
		table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate_4", checkbox = true, desc = "Jester winstate 4 (Def. 1)"})
		table.insert(tbl[ROLE_JESTER], {cvar = "ttt2_jes_winstate_5", checkbox = true, desc = "Jester winstate 5 (Def. 1)"})
	end)

	if CLIENT then
		-- setup here is not necessary but if you want to access the role data, you need to start here
		-- setup basic translation !
		LANG.AddToLanguage("English", JESTER.name, "Jester")
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
		if hook.Run("TTT2PreventJesterDeath", ply) then return end

		if ply:GetSubRole() == ROLE_JESTER then
			local killer = ply.jesterKiller

			ply.jesterKiller = nil

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

	hook.Add("TTT2_TellTraitors", "JesterTraitorMsg", function()
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

	hook.Add("DoPlayerDeath", "JesterDoDeath", function(ply, attacker, dmginfo)
		if ply:GetSubRole() == ROLE_JESTER then
			--local HeadIndex = ply:LookupBone("ValveBiped.bip01_pelvis")
			--local HeadPos, HeadAng = ply:GetBonePosition(HeadIndex)

			net.Start("NewConfetti")
			net.WriteEntity(ply)
			net.Broadcast()

			ply:EmitSound("BirthdayParty.wav")
		end
	end)

	hook.Add("ScalePlayerDamage", "JesterDmgScale", function(ply, hitgroup, dmginfo)
		local attacker = dmginfo:GetAttacker()

		if ply:GetSubRole() == ROLE_JESTER and (
			not (dmginfo:IsBulletDamage()
				or dmginfo:IsFallDamage()
				or dmginfo:IsDamageType(DMG_CRUSH) and IsValid(attacker) and attacker:IsPlayer() and attacker ~= ply
				or dmginfo:IsDamageType(DMG_CLUB)
			) or dmginfo:IsExplosionDamage()
			or dmginfo:IsDamageType(DMG_DROWN)
			or dmginfo:IsDamageType(DMG_BURN)
		) then
			dmginfo:ScaleDamage(0)
		end

		if ply:IsPlayer()
		and attacker and IsValid(attacker) and attacker:IsPlayer()
		and attacker:GetSubRole() == ROLE_JESTER
		then
			dmginfo:ScaleDamage(0)
		end
	end)

	hook.Add("EntityTakeDamage", "JesterGivesDmg", function(ent, dmginfo)
		if ent:IsPlayer() and ent:GetSubRole() == ROLE_JESTER and (
			dmginfo:IsExplosionDamage()
			or dmginfo:IsDamageType(DMG_BURN)
			or dmginfo:IsDamageType(DMG_DROWN)
		) then -- check its burn, explosion or drown.
			dmginfo:ScaleDamage(0) -- no damages
		end

		local attacker = dmginfo:GetAttacker()

		if ent:IsPlayer()
		and attacker and IsValid(attacker) and attacker:IsPlayer()
		and attacker:GetSubRole() == ROLE_JESTER then
			dmginfo:ScaleDamage(0)
		end
	end)

	hook.Add("OnPlayerHitGround", "JesterHitGround", function(ply, in_water, on_floater, speed)
		if ply:GetSubRole() == ROLE_JESTER then
			return false
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

		ent:EmitSound("BirthdayParty.mp3") -- Play the sound

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
