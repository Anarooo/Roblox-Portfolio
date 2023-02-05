--Written by Anaro_Ryker
--The Arskellius Raid System is property of Anaro Media (Trading As). Unauthorized usage of this system will result in a DMCA Takedown Request.

--[[COMMON VARIABLES]]--
local Workspace = game:GetService("Workspace")
local GroupService = game:GetService("GroupService")
local Teams = game:GetService("Teams")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Zone = require(ReplicatedStorage.arskelliusR.Zone) --Free Module dedicated to better detection of part touch events which is more reliable than the standard API.
local sModule = require(ServerScriptService.scrimmageModules)
--
local workspaceFldr = Workspace.arskelliusR
local replicatedFldr = ReplicatedStorage.arskelliusR
local varSet1 = replicatedFldr.varSet1
local varSet2 = replicatedFldr.varSet2
--
local raidTime = 3600 --Full raid timer in seconds
local activeRaid = varSet1.activeRaid --Used to signify if a raid is active
local raidInitiating = varSet1.raidInitiating --Used to signify if a raid is being initialized
local timeRemainingS = varSet1.timeRemainingS --Used to store how long is left in the raid in seconds
local timeRemaining = varSet1.timeRemaining --Used to store how long is left in the raid in MM:SS format
local raidTarget = varSet1.raidTarget -- Used to store the groupID for the target group or name for the raid target
local hostileCounter = varSet1.hostileCounter --Used to store how many hostiles are on the Hostiles Team
local friendlyCounter = varSet1.friendlyCounter --Used to store how many friendlies are on the Friendlies Team
local hostileCap = varSet1.hostileCap --Used to store the cap for the Hostiles team
local friendlyCap = varSet1.friendlyCap --Used to store the cap for the Friendlies team
local friendlyName = varSet1.friendlyName
local hostileName = varSet1.hostileName
local defaultTeam = varSet1.defaultTeam
local activeObj = varSet2.activeObj
local currentObjScore = varSet2.currentObjScore
local firstObjMax = varSet2.firstObjMax
local secondObjMax = varSet2.secondObjMax
local thirdObjMax = varSet2.thirdObjMax
local currentObjMax = varSet2.currentObjMax
--
local zone1 = Zone.new(workspaceFldr.zone1.firstPoint)
local zone2a = Zone.new(workspaceFldr.zone2a.secondPoint)
local zone2b = Zone.new(workspaceFldr.zone2b.secondPoint)
local zone3 = Zone.new(workspaceFldr.zone3.thirdPoint)
--
local numOfElements
local playerCount
local time
local inObjective = {}
local inObjectiveB = {}
local fInObjective = {}
local fInObjectiveB = {}
--[[END OF COMMON VARIABLES]]--

--[[First Objective]]--
replicatedFldr.initiateRaid.OnServerEvent:Connect(function(player, hostileTeama, friendlyTeama, hostileCapa, friendlyCapa)
	if player.Name == "Anaro_Ryker" then -- will change later
		sModule.initializeRaid(hostileTeama, friendlyTeama, hostileCapa, friendlyCapa)
	end
end)

replicatedFldr.changeTeam.OnServerEvent:Connect(function(player, check)
	sModule.joinTeam(player, check)
end)

replicatedFldr.addTime.OnServerEvent:Connect(function(player, timeadd)
	sModule.addTime(timeadd)
end)

replicatedFldr.forceRaidEnd.OnServerEvent:Connect(function(player, condition)
	sModule.terminateRaid(condition)
end)

zone1.playerEntered:Connect(function(player)
	if activeRaid.Value then
		if player.Team == Teams:FindFirstChild(hostileName.Value) then
			if not sModule.findPlayer(player, inObjective) and sModule.playerTotal(inObjective) < 3 then
				inObjective = sModule.tableAdd(player, inObjective)
				while currentObjScore.Value < currentObjMax.Value do
					if activeObj.Value ~= 1  then
						break
					end
						if not sModule.findPlayer(player, inObjective) then
							break
						end
						currentObjScore.Value += 1
						sModule.updateAllPlayers()
						wait(1)
					end
				if currentObjScore.Value >= currentObjMax.Value then
					inObjective = {}
					sModule.updateToNextPoint()
				end
			end
		end
	end
end)

zone1.playerExited:Connect(function(player)
	if sModule.findPlayer(player, inObjective) then
		inObjective = sModule.tableRemove(player, inObjective)
	end
end)

--[[First Objective End]]--
--[[Second Objective]]--

zone2a.playerEntered:Connect(function(player)
	if activeRaid.Value then
		if player.Team == Teams:FindFirstChild(hostileName.Value) then
			if not sModule.findPlayer(player, inObjective) and sModule.playerTotal(inObjective) < 3 then
				inObjective = sModule.tableAdd(player, inObjective)
				while currentObjScore.Value < currentObjMax.Value do
					if activeObj.Value ~= 2  then
						break
					end
					if not sModule.findPlayer(player, inObjective) then
						if sModule.playerTotal(fInObjective) > 0 then
							break
						end
					end
					currentObjScore.Value += 1
					sModule.updateAllPlayers()
					wait(1)
				end
				if currentObjScore.Value >= currentObjMax.Value then
					inObjective = {}
					inObjectiveB = {}
					fInObjective = {}
					fInObjectiveB = {}
					sModule.updateToNextPoint()
				end
			end
		elseif player.Team == Teams:FindFirstChild(friendlyName.Value) then
			if not sModule.findPlayer(player, fInObjective) and sModule.playerTotal(fInObjective) < 3 then
				fInObjective = sModule.tableAdd(player, fInObjective)
				while currentObjScore.Value < currentObjMax.Value and currentObjScore.Value > 0 do
					if activeObj.Value ~= 2  then
						break
					end
					if not sModule.findPlayer(player, fInObjective) then
						if sModule.playerTotal(inObjective) > 0 then
							break
						end
					end
					currentObjScore.Value -= 1
					sModule.updateAllPlayers()
					wait(3)
				end
				if currentObjScore.Value >= currentObjMax.Value then
					inObjective = {}
					inObjectiveB = {}
					fInObjective = {}
					fInObjectiveB = {}
					sModule.updateToNextPoint()
				end
			end
		end
	end
end)

zone2a.playerExited:Connect(function(player)
	if player.Team == Teams:FindFirstChild(hostileName.Value) then
		if sModule.findPlayer(player, inObjective) then
			inObjective = sModule.tableRemove(player, inObjective)
		end
	elseif player.Team == Teams:FindFirstChild(friendlyName.Value) then
		if sModule.findPlayer(player, fInObjective) then
			fInObjective = sModule.tableRemove(player, fInObjective)
		end
	end
end)

zone2b.playerEntered:Connect(function(player)
	if activeRaid.Value then
		if player.Team == Teams:FindFirstChild(hostileName.Value) then
			if not sModule.findPlayer(player, inObjectiveB) and sModule.playerTotal(inObjectiveB) < 3 then
				inObjectiveB = sModule.tableAdd(player, inObjectiveB)
				while currentObjScore.Value < currentObjMax.Value do
					if activeObj.Value ~= 2  then
						break
					end
					if not sModule.findPlayer(player, inObjectiveB) then
						if sModule.playerTotal(fInObjectiveB) > 0 then
							break
						end
					end
					currentObjScore.Value += 1
					sModule.updateAllPlayers()
					wait(1)
				end
				if currentObjScore.Value >= currentObjMax.Value then
					inObjective = {}
					inObjective = {}
					fInObjectiveB = {}
					fInObjectiveB = {}
					sModule.updateToNextPoint()
				end
			end
		elseif player.Team == Teams:FindFirstChild(friendlyName.Value) then
			if not sModule.findPlayer(player, fInObjectiveB) and sModule.playerTotal(fInObjectiveB) < 3 then
				fInObjectiveB = sModule.tableAdd(player, fInObjectiveB)
				while currentObjScore.Value < currentObjMax.Value and currentObjScore.Value > 0 do
					if activeObj.Value ~= 2  then
						break
					end
					if not sModule.findPlayer(player, fInObjectiveB) then
						if sModule.playerTotal(inObjectiveB) > 0 then
							break
						end
					end
					currentObjScore.Value -= 1
					sModule.updateAllPlayers()
					wait(3)
				end
				if currentObjScore.Value >= currentObjMax.Value then
					inObjective = {}
					inObjective = {}
					fInObjectiveB = {}
					fInObjectiveB = {}
					sModule.updateToNextPoint()
				end
			end
		end
	end
end)

zone2b.playerExited:Connect(function(player)
	if player.Team == Teams:FindFirstChild(hostileName.Value) then
		if sModule.findPlayer(player, inObjectiveB) then
			inObjectiveB = sModule.tableRemove(player, inObjectiveB)
		end
	elseif player.Team == Teams:FindFirstChild(friendlyName.Value) then
		if sModule.findPlayer(player, fInObjectiveB) then
			fInObjectiveB = sModule.tableRemove(player, fInObjectiveB)
		end
	end
end)

--[[Second Objective End]]--
--[[Third Objective]]--

zone3.playerEntered:Connect(function(player)
	if activeRaid.Value then
		if player.Team == Teams:FindFirstChild(hostileName.Value) then
			if not sModule.findPlayer(player, inObjective) and sModule.playerTotal(inObjective) < 3 then
				inObjective = sModule.tableAdd(player, inObjective)
				while currentObjScore.Value < currentObjMax.Value do
					if activeObj.Value ~= 3  then
						break
					end
					if not sModule.findPlayer(player, inObjective) then
						break
					end
					currentObjScore.Value += 1
					sModule.updateAllPlayers()
					wait(1)
				end
				if currentObjScore.Value >= currentObjMax.Value then
					inObjective = {}
					sModule.updateToNextPoint()
				end
			end
		end
	end
end)

zone3.playerExited:Connect(function(player)
	if sModule.findPlayer(player, inObjective) then
		inObjective = sModule.tableRemove(player, inObjective)
	end
	if sModule.playerTotal(inObjective) <= 0 then
		currentObjScore.Value = 0
	end
end)
