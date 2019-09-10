--a variable has to be set for every winstate
CreateConVar("ttt2_jes_winstate_1", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_jes_winstate_2", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_jes_winstate_3", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_jes_winstate_4", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_jes_winstate_5", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_jes_winstate_6", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
--CreateConVar("ttt2_jes_winstate_x", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})

function JesterWinstate(ply, killer)
	local winstatepick = math.random(1, 20)
	local ws1 = GetConVar("ttt2_jes_winstate_1"):GetString()
	local ws2 = GetConVar("ttt2_jes_winstate_2"):GetString()
	local ws3 = GetConVar("ttt2_jes_winstate_3"):GetString()
	local ws4 = GetConVar("ttt2_jes_winstate_4"):GetString()
	local ws5 = GetConVar("ttt2_jes_winstate_5"):GetString()
	local ws6 = GetConVar("ttt2_jes_winstate_6"):GetString()

	-- Every Winstate has to be put in here after the template
	while winstatepick >= 0 do
		if winstatepick == 0 and ws1 == "1" then
			JesterWinstateOne(ply, killer)

			break
		elseif ws1 == "1" then
			winstatepick = winstatepick - 1
		end

		if winstatepick == 0 and ws2 == "1" then
			JesterWinstateTwo(ply, killer)

			break
		elseif ws2 == "1" then
			winstatepick = winstatepick - 1
		end

		if winstatepick == 0 and ws3 == "1" then
			JesterWinstateThree(ply, killer)

			break
		elseif ws3 == "1" then
			winstatepick = winstatepick - 1
		end

		if winstatepick == 0 and ws4 == "1" then
			JesterWinstateFour(ply, killer)

			break
		elseif ws4 == "1" then
			winstatepick = winstatepick - 1
		end

		if winstatepick == 0 and ws5 == "1" then
			JesterWinstateFive(ply, killer)

			break
		elseif ws5 == "1" then
			winstatepick = winstatepick - 1
		end

		if winstatepick == 0 and ws6 == "1" then
			JesterWinstateSix(ply, killer)

			break
		elseif ws6 == "1" then
			winstatepick = winstatepick - 1
		end
		--[[
    if winstatepick == 0 and GetConVar("ttt2_jes_winstate_x"):GetInt() == 1 then
      JesterWinstateX(ply, killer)
	  winstatepick = winstatepick - 1
    elseif GetConVar("ttt2_jes_winstate_x"):GetInt() == 1 then
      winstatepick = winstatepick - 1
    end
    --]]

		if ws1 == "0" and ws2 == "0" and ws3 == "0" and ws4 == "0" and ws5 == "0" and ws6 == "0" then
			RunConsoleCommand("ttt2_jes_winstate", "0")

			break
		end
	end
end

function JesterRevive(ply, fn)
	ply:Revive(3, function(p)
		fn(p)
	end,
	function(p)
		return IsValid(p)
	end) -- revive after 3s
end

--Player respawns within three seconds with a role in an opposing team of the killer
function JesterWinstateOne(ply, killer)
	local rd = killer:GetSubRoleData()
	local reviveRoles = GetSelectableRoles()

	for _, v in pairs(roles.GetList()) do
		if v.defaultTeam == rd.defaultTeam or v.defaultTeam == TEAM_JESTER then
			reviveRoles.remove(v)
		end
	end

	JesterRevive(ply, function(p)
		p:SetRole(reviveRoles[math.random(1, #reviveRoles)])
		p:SetDefaultCredits()

		SendFullStateUpdate()
	end)
end

--Player respawns after killer death with a role in an opposing team of the killer
function JesterWinstateTwo(ply, killer)
	local defaultTeam = killer:GetSubRoleData().defaultTeam

	hook.Add("PostPlayerDeath", "JesterWaitForKillerDeath_" .. ply:Nick(), function(deadply)
		if deadply ~= killer or deadply.NOWINASC then return end

		local reviveRoles = GetSelectableRoles()

		for _, v in pairs(roles.GetList()) do
			if v.defaultTeam == defaultTeam or v.defaultTeam == TEAM_JESTER then
				reviveRoles.remove(v)
			end
		end

		hook.Remove("PostPlayerDeath", "JesterWaitForKillerDeath_" .. ply:Nick())

		-- set random available role
		JesterRevive(ply, function(p)
			p:SetRole(reviveRoles[math.random(1, #reviveRoles)])
			p:SetDefaultCredits()

			SendFullStateUpdate()
		end)
	end)
end

-- Player respawns after killer death with the role of his killer
function JesterWinstateThree(ply, killer)
	local rd = killer:GetSubRoleData()
	local role = rd.index

	hook.Add("PostPlayerDeath", "JesterWaitForKillerDeath_" .. ply:Nick(), function(deadply)
		if deadply ~= killer or deadply.NOWINASC then return end

		hook.Remove("PostPlayerDeath", "JesterWaitForKillerDeath_" .. ply:Nick())

		JesterRevive(ply, function(p)
			p:SetRole(role)
			p:SetDefaultCredits()

			SendFullStateUpdate()
		end)
	end)
end

--Player respawns within three seconds with the role of the killer and the killer dies
function JesterWinstateFour(ply, killer)
	local rd = killer:GetSubRoleData()
	local role = rd.index

	killer:Kill()
	killer:ChatPrint("You were killed, because you killed the Jester!")

	JesterRevive(ply, function(p)
		p:SetRole(role)
		p:SetDefaultCredits()

		SendFullStateUpdate()
	end)
end

--Player respawns within three seconds with a role in an opposing team of the killer and the killer dies
function JesterWinstateFive(ply, killer)
	local rd = killer:GetSubRoleData()
	local reviveRoles = GetSelectableRoles()

	for _, v in pairs(roles.GetList()) do
		if v.defaultTeam == rd.defaultTeam or v.defaultTeam == TEAM_JESTER then
			reviveRoles.remove(v)
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
end

--Same as winstate four, unless the killer is a traitor or serialkiller, then jester is killed normally
function JesterWinstateSix(ply, killer)
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
end

--[[
function JesterWinstateX(ply, killer)

end
--]]
