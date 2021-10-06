resource.AddFile("sound/ttt2/birthdayparty.mp3")
resource.AddFile("materials/confetti.png")

util.AddNetworkString("NewConfetti")

util.PrecacheSound("ttt2/birthdayparty.mp3")

local function ShouldJesterTakeNoDamage(ply, attacker)
	if not IsValid(ply) or ply:GetSubRole() ~= ROLE_JESTER then return end

	if IsValid(attacker) and attacker ~= ply then return end

	return true -- true to block damage event
end

local function ShouldJesterDealNoDamage(ply, attacker)
	if not IsValid(ply) or not IsValid(attacker) or not attacker:IsPlayer() or attacker:GetSubRole() ~= ROLE_JESTER then return end
	if SpecDM and (ply.IsGhost and ply:IsGhost() or (attacker.IsGhost and attacker:IsGhost())) then return end

	return true -- true to block damage event
end

function roles.JESTER.SpawnJesterConfetti(ply)
	net.Start("NewConfetti")
	net.WriteEntity(ply)
	net.Broadcast()

	ply:EmitSound("ttt2/birthdayparty.mp3")
end

-- Jester deals no damage to other players
hook.Add("PlayerTakeDamage", "JesterNoDamage", function(ply, inflictor, killer, amount, dmginfo)
	if not ShouldJesterTakeNoDamage(ply, killer) and not ShouldJesterDealNoDamage(ply, killer) then return end

	dmginfo:ScaleDamage(0)
	dmginfo:SetDamage(0)
end)

hook.Add("TTT2PostPlayerDeath", "JesterPostDeath", function(ply, inflictor, killer)
	if not IsValid(ply)
		or ply:GetSubRole() ~= ROLE_JESTER
		or not IsValid(killer)
		or not killer:IsPlayer()
		or killer == ply
		or GetRoundState() ~= ROUND_ACTIVE
		or hook.Run("TTT2PreventJesterWinstate", killer) and JESTER.winstate ~= 1
		or SpecDM and (ply.IsGhost and ply:IsGhost() or (killer.IsGhost and killer:IsGhost()))
	then return end

	roles.JESTER.shouldWin = true
	roles.JESTER.SpawnJesterConfetti(ply)
end)

-- reset hooks at round end
hook.Add("TTTEndRound", "JesterEndRound", function()
	roles.JESTER.shouldWin = false
end)
