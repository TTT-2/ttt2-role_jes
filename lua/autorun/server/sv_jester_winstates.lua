local function JesterTakeNoDamage(ply, attacker)
	if not IsValid(ply) or ply:GetSubRole() ~= ROLE_JESTER then return end

	if IsValid(attacker) and attacker ~= ply then return end

	return true -- true to block damage event
end

local function JesterDealNoDamage(ply, attacker)
	if not IsValid(ply) or not IsValid(attacker) or attacker:GetSubRole() ~= ROLE_JESTER then return end

	return true -- true to block damage event
end

local function SpawnJesterConfetti(ply)
	if not IsValid(ply) or ply:GetSubRole() ~= ROLE_JESTER then return end

	if not IsValid(attacker) or attacker == ply then return end

	net.Start("NewConfetti")
	net.WriteEntity(ply)
	net.Broadcast()

	ply:EmitSound("ttt2/birthdayparty.mp3")
end

local function JesterRevive(ply, fn)
	ply:Revive(3, function(p)
		fn(p)
	end,
	function(p)
		return IsValid(p)
	end) -- revive after 3s
end

jesterShouldWin = false

local winstates_death = {
	-- RANDOM WINSTATE
	[0] = function(ply, killer)
		-- select a random winstate
		return winstates_death[math.random(1, 8)](ply, killer)
	end,

	-- if the jester is killed, he has won
	[1] = function(ply, killer)
		LANG.MsgAll("'" .. killer:Nick() .. "' killed the Jester...", nil, MSG_MSTACK_PLAIN)

		jesterShouldWin = true

		return true
	end,

	-- Jester respawns after three seconds with a random opposite role of his killer
	[2] = function(ply, killer)
		local rd = killer:GetSubRoleData()
		local reviveRoleCandidates = table.Copy(GetSelectableRoles())
		local reviveRoles = {}

		-- make sure innocent and traitor are revive candidate roles
		reviveRoleCandidates[INNOCENT] = reviveRoleCandidates[INNOCENT] or 1
		reviveRoleCandidates[TRAITOR] = reviveRoleCandidates[TRAITOR] or 1

		-- remove jester from the revive candidate roles
		reviveRoleCandidates[JESTER] = nil

		for k in pairs(reviveRoleCandidates) do
			if k.defaultTeam ~= rd.defaultTeam then
				reviveRoles[#reviveRoles + 1] = k.index
			end
		end

		PrintTable(reviveRoleCandidates)

		JesterRevive(ply, function(p)
			p:SetRole(reviveRoles[math.random(1, #reviveRoles)])
			p:SetDefaultCredits()

			SendFullStateUpdate()

			print(tostring(p:GetRole()))
		end)

		return true
	end,

	-- Jester respawns after killer death with a random opposite role
	[3] = function(ply, killer)
		hook.Add("PostPlayerDeath", "JesterWaitForKillerDeath_" .. ply:SteamID64(), function(deadply)
			if deadply ~= killer or deadply.NOWINASC then return end

			local rd = killer:GetSubRoleData()
			local reviveRoleCandidates = table.Copy(GetSelectableRoles())
			local reviveRoles = {}

			-- make sure innocent and traitor are revive candidate roles
			reviveRoleCandidates[INNOCENT] = reviveRoleCandidates[INNOCENT] or 1
			reviveRoleCandidates[TRAITOR] = reviveRoleCandidates[TRAITOR] or 1

			-- remove jester from the revive candidate roles
			reviveRoleCandidates[JESTER] = nil

			for k in pairs(reviveRoleCandidates) do
				if k.defaultTeam ~= rd.defaultTeam then
					reviveRoles[#reviveRoles + 1] = k.index
				end
			end

			hook.Remove("PostPlayerDeath", "JesterWaitForKillerDeath_" .. ply:SteamID64())

			-- set random available role
			JesterRevive(ply, function(p)
				p:SetRole(reviveRoles[math.random(1, #reviveRoles)])
				p:SetDefaultCredits()

				SendFullStateUpdate()
			end)
		end)

		return true
	end,

	-- Jester respawns after killer death with the role of his killer
	[4] = function(ply, killer)
		local role = killer:GetRole()

		hook.Add("PostPlayerDeath", "JesterWaitForKillerDeath_" .. ply:SteamID64(), function(deadply)
			if deadply ~= killer or deadply.NOWINASC then return end

			hook.Remove("PostPlayerDeath", "JesterWaitForKillerDeath_" .. ply:SteamID64())

			JesterRevive(ply, function(p)
				p:SetRole(role)
				p:SetDefaultCredits()

				SendFullStateUpdate()
			end)
		end)

		return true
	end,

	-- Jester respawns after three seconds with the role of the killer and the killer dies
	[5] = function(ply, killer)
		local role = killer:GetRole()

		killer:Kill()
		killer:ChatPrint("You were killed, because you killed the Jester!")

		JesterRevive(ply, function(p)
			p:SetRole(role)
			p:SetDefaultCredits()

			SendFullStateUpdate()
		end)

		return true
	end,

	-- Jester respawns within three seconds with a role in an opposing team of the killer and the killer dies
	[6] = function(ply, killer)
		local rd = killer:GetSubRoleData()
		local reviveRoleCandidates = table.Copy(GetSelectableRoles())
		local reviveRoles = {}

		-- make sure innocent and traitor are revive candidate roles
		reviveRoleCandidates[INNOCENT] = reviveRoleCandidates[INNOCENT] or 1
		reviveRoleCandidates[TRAITOR] = reviveRoleCandidates[TRAITOR] or 1

		--remove jester from the revive candidate roles
		reviveRoleCandidates[JESTER] = nil

		for k in pairs(reviveRoleCandidates) do
			if k.defaultTeam ~= rd.defaultTeam then
				reviveRoles[#reviveRoles + 1] = k.index
			end
		end

		killer:Kill()
		killer:ChatPrint("You were killed, because you killed the Jester!")

		-- set random available role
		JesterRevive(ply, function(p)
			p:SetRole(reviveRoles[math.random(1, #reviveRoles)])
			p:SetDefaultCredits()

			SendFullStateUpdate()
		end)

		return true
	end,

	-- Jester respawns after three seconds with the role of the killer and the killer dies,
	-- unless the killer is a traitor or serialkiller, then jester is killed normally
	[7] = function(ply, killer)
		local rd = killer:GetSubRoleData()
		local role = rd.index

		if role == ROLE_TRAITOR or role == ROLE_SERIALKILLER then
			return
		end

		killer:Kill()
		killer:ChatPrint("You were killed, because you killed the Jester!")

		JesterRevive(ply, function(p)
			p:SetRole(role)
			p:SetDefaultCredits()

			SendFullStateUpdate()
		end)

		return true
	end
}

local winstates_damage = {
	-- RANDOM WINSTATE, does nothing when damaged
	[0] = function(ply, killer)

	end,

	-- if the jester is killed, he has won
	[1] = function(ply, killer)

	end,

	-- Jester respawns after three seconds with a random opposite role of his killer
	[2] = function(ply, killer)

	end,

	-- Jester respawns after killer death with a random opposite role
	[3] = function(ply, killer)

	end,

	-- Jester respawns after killer death with the role of his killer
	[4] = function(ply, killer)

	end,

	-- Jester respawns after three seconds with the role of the killer and the killer dies
	[5] = function(ply, killer)

	end,

	-- Jester respawns within three seconds with a role in an opposing team of the killer and the killer dies
	[6] = function(ply, killer)

	end,

	-- Jester respawns after three seconds with the role of the killer and the killer dies,
	-- unless the killer is a traitor or serialkiller, then jester is killed normally
	[7] = function(ply, killer)

	end
}

-- Jester deals no damage to other players
hook.Add("PlayerTakeDamage", "JesterDealNoDamage", function(ply, dmginfo)
	local killer = dmginfo:GetAttacker()

	if JesterTakeNoDamage(ply, killer) or JesterDealNoDamage(ply, killer) then
		return true
	end

	return winstates_damage[GetConVar("ttt2_jes_winstate"):GetInt()](ply, killer)
end)

hook.Add("TTT2PostPlayerDeath", "JesterPostDeath", function(ply, inflictor, killer)
	if not IsValid(ply) or ply:GetSubRole() ~= ROLE_JESTER or not IsValid(killer) then return end

	if winstates_death[GetConVar("ttt2_jes_winstate"):GetInt()](ply, killer) then
		SpawnJesterConfetti(ply)
	end
end)

-- reset hooks at round end
hook.Add("TTTEndRound", "JesterEndRound", function()
	for _, v in ipairs(player.GetAll()) do
		hook.Remove("PostPlayerDeath", "JesterWaitForKillerDeath_" .. v:SteamID64())
	end

	jesterShouldWin = false
end)
