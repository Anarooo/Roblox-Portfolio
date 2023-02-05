--Written by Anaro_Ryker
--The Arskellius Raid System is property of Anaro Media (Trading As). Unauthorized usage of this system will result in a DMCA Takedown Request.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local replicatedFldr = ReplicatedStorage.arskelliusR
local varSet1 = replicatedFldr.varSet1
local varSet2 = replicatedFldr.varSet2
local activeRaid = varSet1.activeRaid --Used to signify if a raid is active
local timeRemaining = varSet1.timeRemaining --Used to store how long is left in the raid in MM:SS format
local raidTarget = varSet1.raidTarget -- Used to store the groupID for the target group or name for the raid target
local pointTracker = script.Parent.Parent.objectivePointTracker
local gui = script.Parent

---

gui.addOneMinute.MouseButton1Click:Connect(function() --Runs the below code every time the button is pressed.
	replicatedFldr.addTime:FireServer(60)
end)

gui.addFiveMinutes.MouseButton1Click:Connect(function() --Runs the below code every time the button is pressed.
	replicatedFldr.addTime:FireServer(300)
end)

gui.addTenMinutes.MouseButton1Click:Connect(function() --Runs the below code every time the button is pressed.
	replicatedFldr.addTime:FireServer(600)
end)

gui.friendlyWin.MouseButton1Click:Connect(function() --Runs the below code every time the button is pressed.
	replicatedFldr.forceRaidEnd:FireServer(2)
end)

gui.hostileWin.MouseButton1Click:Connect(function() --Runs the below code every time the button is pressed.
	replicatedFldr.forceRaidEnd:FireServer(1)
end)

gui.stalemateEnd.MouseButton1Click:Connect(function() --Runs the below code every time the button is pressed.
	replicatedFldr.forceRaidEnd:FireServer(3)
end)
