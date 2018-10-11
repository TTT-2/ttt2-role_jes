--a variable has to be set for every winstate
CreateConVar("ttt2_jes_winstate_1", true, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_jes_winstate_2", true, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
CreateConVar("ttt2_jes_winstate_3", true, {FCVAR_NOTIFY, FCVAR_ARCHIVE})
--CreateConVar("ttt2_jes_winstate_x", true, {FCVAR_NOTIFY, FCVAR_ARCHIVE})


function JesterWinstate(ply, killer)
	winstatepick = math.random(1, 20)

	-- Every Winstate has to be put in here after the template
	while winstatepick >= 0 do
		if winstatepick == 0 and ttt2_jes_winstate_1 then
			JesterWinstateOne(ply, killer)
		elseif ttt2_jes_winstate_1 then
			winstatepick = winstatepick - 1
		end

		if winstatepick == 0 and ttt2_jes_winstate_2 then
			JesterWinstateTwo(ply, killer)
		elseif ttt2_jes_winstate_2 then
			winstatepick = winstatepick - 1
		end

		if winstatepick == 0 and ttt2_jes_winstate_3 then
			JesterWinstateThree(ply, killer)
		elseif ttt2_jes_winstate_3 then
			winstatepick = winstatepick - 1
		end
		--[[
    if winstatepick == 0 and ttt2_jes_winstate_x then
      JesterWinstateX(ply, killer)
    elseif ttt2_jes_winstate_x then
      winstatepick = winstatepick - 1
    end
    --]]
	end

	JesterWinstateOne(ply, killer)

end

--Player spawns within three seconds as an random opposite role of the killer
function JesterWinstateOne(ply, killer)
	if IsValid(killer) then
		local rd = killer:GetSubRoleData()
		local tbl = {}
		local choices_i = 0

		-- prevent endless loop
		if killer:HasTeam(TEAM_TRAITOR) then
			table.insert(tbl, INNOCENT)
		else
			table.insert(tbl, TRAITOR)
		end

		for _, v in ipairs(player.GetAll()) do
			if v:IsActive() and not v:GetForceSpec() then
				choices_i = choices_i + 1
			end
		end

		local selectableRoles = GetSelectableRoles()

		for roleData, amount in pairs(selectableRoles) do
			if not table.HasValue(tbl, roleData) and roleData.defaultTeam ~= rd.defaultTeam then
				table.insert(tbl, roleData)
			end
		end

		-- set random available role
		while true do
			local vpick = math.random(1, #tbl)
			local v = tbl[vpick]
			local type_count = selectableRoles[v] or 0

			-- if player was last round innocent, he will be another role (if he has enough karma)
			if IsValid(ply) and ply:CanSelectRole(v, choices_i, type_count) then

				-- if a player has specified he does not want to be detective, we skip
				-- him here (he might still get it if we don't have enough
				-- alternatives
				ply:UpdateRole(v.index)
				ply:Revive(3) -- revive after 3s

				break
			end
		end
	end
end

--Player spawns after killer death as an opposite role
function JesterWinstateTwo(ply, killer)
	if isValid(killer) then
		local rd = killer:GetSubRoleData()
		local tbl = {}
		local choices_i = 0

		-- prevent endless loop
		if killer:HasTeam(TEAM_TRAITOR) then
			table.insert(tbl, INNOCENT)
		else
			table.insert(tbl, TRAITOR)
		end

		for _, v in ipairs(player.GetAll()) do
			if v:IsActive() and not v:GetForceSpec() then
				choices_i = choices_i + 1
			end
		end

		local selectableRoles = GetSelectableRoles()

		for roleData, amount in pairs(selectableRoles) do
			if not table.HasValue(tbl, roleData) and roleData.defaultTeam ~= rd.defaultTeam then
				table.insert(tbl, roleData)
			end
		end


		hook.Add("PostPlayerDeath", "JesterWaitForKillerDeath_" .. ply.Nick(), function(deadply)
			if deadply ~= killer or deadply.NOWINASC then return end

			hook.Remove("PostPlayerDeath", "JesterWaitForKillerDeath_" .. ply.Nick())
			-- set random available role
			while true do
				local vpick = math.random(1, #tbl)
				local v = tbl[vpick]
				local type_count = selectableRoles[v] or 0

				-- if player was last round innocent, he will be another role (if he has enough karma)
				if IsValid(ply) and ply:CanSelectRole(v, choices_i, type_count) then

					-- if a player has specified he does not want to be detective, we skip
					-- him here (he might still get it if we don't have enough
					-- alternatives
					ply:UpdateRole(v.index)
					ply:Revive(3) -- revive after 3s

					break
				end
			end
		end)
	end
end

-- Player spawns after his killer was killed with the role of his killer
function JesterWinstateThree(ply, killer)
	if isValid(killer) then
		local rd = killer:GetSubRoleData()
		local role = rd.index



		hook.Add("PostPlayerDeath", "JesterWaitForKillerDeath_" .. ply.Nick(), function(deadply)
			if deadply ~= killer or deadply.NOWINASC then return end

			hook.Remove("PostPlayerDeath", "JesterWaitForKillerDeath_" .. ply.Nick())

			ply:UpdateRole(role)
			ply:Revive(3) -- revive after 3s

		end)
	end
end
--[[
function JesterWinstateX(ply, killer)

end
--]]
