if CLIENT then
	EVENT.icon = Material("vgui/ttt/vskin/events/jester_kill")
	EVENT.title = "title_event_jester_kill"

	function EVENT:GetText()
		-- each returned subtable is rendered as one paragraph
		return {
			{
				string = "desc_event_jester_kill",
				params = {
					jester = self.event.jester.nick,
					killer = self.event.killer.nick,
					role = roles.GetByIndex(self.event.killer.role).name,
					team = self.event.killer.team,
				},
				translateParams = true
			}
		}
	end
end

if SERVER then
	-- this function is triggered when the event is triggered
	function EVENT:Trigger(jester, killer)
		self:AddAffectedPlayers(
			{jester:SteamID64(), killer:SteamID64()},
			{jester:Nick(), killer:Nick()}
		)

		return self:Add({
			-- string indexed data can be added here
			jester = {
				nick = jester:Nick(),
				sid64 = jester:SteamID64()
			},
			killer = {
				nick = killer:Nick(),
				sid64 = killer:SteamID64(),
				role = killer:GetSubRole(),
				team = killer:GetTeam(),
				score = killer:GetSubRoleData().score.teamKillsMultiplier
			}
		})
	end

	-- this function is triggered to calculate the score
	function EVENT:CalculateScore()
		local jester = self.event.jester
		local killer = self.event.killer

		self:SetPlayerScore(jester.sid64, {
			score_jester = 8
		})
		self:SetPlayerScore(killer.sid64, {
			score_killer = killer.score
		})
	end
end

-- simple text to store in the log file
function EVENT:Serialize()
	return self.event.jester.nick .. " was killed by " .. self.event.killer.nick .. "."
end
