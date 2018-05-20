AddCSLuaFile()

if SERVER then
   resource.AddFile("sound/ttt2/birthdayparty.mp3")
    
   resource.AddFile("materials/vgui/ttt/icon_jes.vmt")
   resource.AddFile("materials/vgui/ttt/sprite_jes.vmt")
   resource.AddFile("materials/confetti.png")
end

-- important to add roles with this function,
-- because it does more than just access the array ! e.g. updating other arrays
AddCustomRole("JESTER", { -- first param is access for ROLES array => ROLES["JESTER"] or ROLES.JESTER
	color = Color(255, 105, 180, 200), -- ...
	dkcolor = Color(255, 51, 153, 255), -- ...
	bgcolor = Color(255, 85, 100, 200), -- ...
	name = "jester", -- just a unique name for the script to determine
	printName = "Jester", -- The text that is printed to the player, e.g. in role alert
	abbr = "jes", -- abbreviation
	shop = false, -- can the role access the [C] shop ?
	team = "jesters", -- the team name: roles with same team name are working together
	defaultEquipment = INNO_EQUIPMENT, -- here you can set up your own default equipment
	visibleForTraitors = true, -- other traitors can see this role / sync them with traitors
    surviveBonus = 0, -- bonus multiplier for every survive while another player was killed
    scoreKillsMultiplier = 1, -- multiplier for kill of player of another team
    scoreTeamKillsMultiplier = -8, -- multiplier for teamkill
    preventWin = true -- set true if role can't win (maybe because of own / special win conditions)
}, {
    pct = 0.17, -- necessary: percentage of getting this role selected (per player)
    maximum = 1, -- maximum amount of roles in a round
    minPlayers = 6, -- minimum amount of players until this role is able to get selected
    togglable = true -- option to toggle a role for a client if possible (F1 menu)
})

-- if sync of roles has finished
hook.Add("TTT2_FinishedSync", "JesterInitT", function(ply, first)
	if CLIENT and first then -- just on client and first init !

		-- setup here is not necessary but if you want to access the role data, you need to start here
		-- setup basic translation !
		LANG.AddToLanguage("English", ROLES.JESTER.name, "Jester")
		LANG.AddToLanguage("English", "hilite_win_" .. ROLES.JESTER.name, "THE JES WON") -- name of base role of a team -> maybe access with GetTeamRoles(ROLES["JESTER"].team)[1].name
		LANG.AddToLanguage("English", "win_" .. ROLES.JESTER.team, "The Jester has won!") -- teamname
		LANG.AddToLanguage("English", "info_popup_" .. ROLES.JESTER.name, [[You are the JESTER! Make TROUBLE and let 'em kill you!]])
		LANG.AddToLanguage("English", "body_found_" .. ROLES.JESTER.abbr, "This was a Jester...")
		LANG.AddToLanguage("English", "search_role_" .. ROLES.JESTER.abbr, "This person was a Jester!")
        LANG.AddToLanguage("English", "ev_win_" .. ROLES.JESTER.abbr, "The goofy Jester won the round!")
		LANG.AddToLanguage("English", "target_" .. ROLES.JESTER.name, "Jester")
        LANG.AddToLanguage("English", "ttt2_desc_" .. ROLES.JESTER.name, [[The Jester is visible for any traitor, but not for innocents or other "normal" roles (except custom traitor roles or the Clairvoyant).
The Jester can't do any damage or kill himself. But if he dies, he will WIN. So don't kill the Jester!]])
	    
	    -- optional for toggling whether player can avoid the role
		LANG.AddToLanguage("English", "set_avoid_" .. ROLES.JESTER.abbr, "Avoid being selected as Jester!")
		LANG.AddToLanguage("English", "set_avoid_" .. ROLES.JESTER.abbr .. "_tip", 
	        [[Enable this to ask the server not to select you as Jester if possible. Does not mean you are Traitor more often.]])
	    
	    ---------------------------------

		-- maybe this language as well...
		LANG.AddToLanguage("Deutsch", ROLES.JESTER.name, "Narr")
		LANG.AddToLanguage("Deutsch", "hilite_win_" .. ROLES.JESTER.name, "THE JES WON")
		LANG.AddToLanguage("Deutsch", "win_" .. ROLES.JESTER.team, "Der Narr hat gewonnen!")
		LANG.AddToLanguage("Deutsch", "info_popup_" .. ROLES.JESTER.name, [[Du bist DER NARR! Stifte Unruhe und geh drauf!]])
		LANG.AddToLanguage("Deutsch", "body_found_" .. ROLES.JESTER.abbr, "Er war ein Narr...")
		LANG.AddToLanguage("Deutsch", "search_role_" .. ROLES.JESTER.abbr, "Diese Person war ein Narr!")
        LANG.AddToLanguage("Deutsch", "ev_win_" .. ROLES.JESTER.abbr, "Der trottelige Narr hat die Runde gewonnen!")
		LANG.AddToLanguage("Deutsch", "target_" .. ROLES.JESTER.name, "Narr")
        LANG.AddToLanguage("Deutsch", "ttt2_desc_" .. ROLES.JESTER.name, [[Der Narr ist für alle Verräter (und Serienkiller) sichtbar, aber nicht für Unschuldige oder andere "normale" Rollen (außer spezielle Varräter-Rollen oder den Hellseher).
Der Narr kann keinen Schaden anrichten und sich auch nicht selbst umbringen. Doch wenn er stirbt, GEWINNT er allein. Also töte NICHT den Narr!]])
	    
		LANG.AddToLanguage("Deutsch", "set_avoid_" .. ROLES.JESTER.abbr, "Vermeide als Narr ausgewählt zu werden!")
		LANG.AddToLanguage("Deutsch", "set_avoid_" .. ROLES.JESTER.abbr .. "_tip", 
	        [[Aktivieren, um beim Server anzufragen, nicht als Narr ausgewählt zu werden. Das bedeuted nicht, dass du öfter Traitor wirst!]])
	end
end)

if SERVER then
	util.AddNetworkString("NewConfetti")

	--------

	hook.Add("PlayerDeath", "JesterDeath", function(victim, infl, attacker)
	    if victim:GetRole() == ROLES.JESTER.index and attacker:IsPlayer() and infl:GetClass() ~= env_fire and attacker:GetRole() ~= ROLES.JESTER.index then
            if victim:GetRole() == ROLES.JESTER.index and not attacker:HasTeamRole(TEAM_TRAITOR) then
                for _,v in pairs(player.GetAll()) do
                    v:PrintMessage(HUD_PRINTCENTER, "'" .. attacker:Nick() .. "' killed the Jester...")
                end
            end
        else
            -- revive
        end
	end)

	hook.Add("TTTPrepareRound", "JesterInit", function()
		for _, v in pairs(player.GetAll()) do
			v:ChatPrint("Don't kill the Jester!")
		end
	end)

	hook.Add("TTT2_TellTraitors", "JesterTraitorMsg", function()
		local jesters = {}

		for _, v in pairs(player.GetAll()) do
			if v:GetRole() == ROLES.JESTER.index then
		        table.insert(jesters, v:Nick())
		    end
		end

	    for _, v in pairs(player.GetAll()) do
	  		if #jesters < 1 then
	  			v:PrintMessage(HUD_PRINTTALK, "There are no Jesters!")
	  		else
	  			for _, ply in pairs(jesters) do
                    if v:HasTeamRole(TEAM_TRAITOR) then
                        v:PrintMessage(HUD_PRINTTALK, "'" .. ply .. "' is the Jester!")
                    end
	  			end
	        end
	    end
	end)

	hook.Add("TTTCheckForWin", "JesterCheckWin", function()
		for _, v in pairs(player.GetAll()) do
			if v:GetRole() == ROLES.JESTER.index and not v:Alive() then
				return WIN_ROLE, GetWinningRole(ROLES.JESTER.team).index
			end
		end
	end)

	hook.Add("DoPlayerDeath", "JesterDoDeath", function(ply, attacker, dmginfo)
		if ply:GetRole() == ROLES.JESTER.index then
			local HeadIndex = ply:LookupBone("ValveBiped.bip01_pelvis")
			local HeadPos, HeadAng = ply:GetBonePosition(HeadIndex)

			net.Start("NewConfetti")
			net.WriteEntity(ply)
			net.Broadcast()

			ply:EmitSound("BirthdayParty.wav")
		end
	end)

	hook.Add("ScalePlayerDamage", "JesterDmgScale", function(ply, hitgroup, dmginfo)
		if ply:GetRole() == ROLES.JESTER.index then
			if not (dmginfo:IsBulletDamage() 
			  or dmginfo:IsFallDamage() 
			  or dmginfo:IsDamageType(DMG_CRUSH) and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() and dmginfo:GetAttacker() ~= ply
			  or dmginfo:IsDamageType(DMG_CLUB)) 
			or dmginfo:IsExplosionDamage()
            or dmginfo:IsDamageType(DMG_BURN) then
				dmginfo:ScaleDamage(0)
			end
		end

		if ply:IsPlayer() 
        and dmginfo:GetAttacker()
        and IsValid(dmginfo:GetAttacker())
        and dmginfo:GetAttacker():IsPlayer() 
        and dmginfo:GetAttacker():GetRole() == ROLES.JESTER.index then
			dmginfo:ScaleDamage(0)
		end
	end)

	hook.Add("EntityTakeDamage", "JesterGivesDmg", function(ent, dmginfo)
		if ent:IsPlayer() and ent:GetRole() == ROLES.JESTER.index then
			if dmginfo:IsExplosionDamage() or dmginfo:IsDamageType(DMG_BURN) then -- check its burn or explosion.
				dmginfo:ScaleDamage(0) -- no damages
			end
		end
        
        if ent:IsPlayer() 
        and dmginfo:GetAttacker() 
        and IsValid(dmginfo:GetAttacker()) 
        and dmginfo:GetAttacker():IsPlayer() 
        and dmginfo:GetAttacker():GetRole() == ROLES.JESTER.index then
			dmginfo:ScaleDamage(0)
		end
	end)

	hook.Add("OnPlayerHitGround", "JesterHitGround", function(ply, in_water, on_floater, speed)
		if ply:GetRole() == ROLES.JESTER.index then
            return false
        end
	end)

	hook.Add("PlayerCanPickupWeapon", "JesterPickupWeapon", function(ply, wep)
		if IsValid(ply) and IsValid(wep) and ply:GetRole() == ROLES.JESTER.index then
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

		ent:EmitSound("BirthdayParty.mp3") --Play the sound

		local pos = ent:GetPos() + Vector(0, 0, ent:OBBMaxs().z)

		if ent.GetShootPos then
			pos = ent:GetShootPos()
		end

		local velMax = 200
		local gravMax = 50

		local gravity = Vector(math.random(-gravMax, gravMax), math.random(-gravMax, gravMax), math.random(-gravMax, 0))

		--Handles particles
		local emitter = ParticleEmitter(pos, true)
        
		for I = 1, 150 do
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
            
            --[[ fix
            timer.Simple(20, function()
               p:Finish()
            end)
            ]]--
		end
	end)
end
