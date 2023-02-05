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

local function updateTimer()
	wait(1)
	while ReplicatedStorage.arskelliusR.varSet1.activeRaid do
		script.Parent.Parent.onScreenTimer.TextLabel.Text = ReplicatedStorage.arskelliusR.varSet1.timeRemaining.Value
		wait(0.05)
	end
end

replicatedFldr.updateAllClient.OnClientEvent:Connect(function(activeObj, currentObjScore, currentObjMax)
	if not script.Parent.Parent.timerStarted.Value then
		task.spawn(function()
			updateTimer()
		end)
		script.Parent.Parent.timerStarted.Value = true
	end
	--print("caught!")
	script.Parent.Parent.onScreenTimer.Visible = true
	pointTracker.Visible = true
	pointTracker.objectiveTitle.Visible = true
	pointTracker.objectiveCap.Visible = true
	pointTracker.objectiveStatus.Visible = true
	script.Parent.Parent.joinHostilesButton.Visible = true
	script.Parent.Parent.joinFriendliesButton.Visible = true
	if activeObj == 1 then
		pointTracker.objectiveTitle.Text = "Objective 1"
		pointTracker.objectiveStatus.Text = currentObjScore
		pointTracker.objectiveCap.Text = "/ "..currentObjMax
	elseif activeObj == 2 then
		pointTracker.objectiveTitle.Text = "Objective 2"
		pointTracker.objectiveStatus.Text = currentObjScore
		pointTracker.objectiveCap.Text = "/ "..currentObjMax
	elseif activeObj == 3 then
		pointTracker.objectiveTitle.Text = "Objective 3"
		pointTracker.objectiveStatus.Text = currentObjScore
		pointTracker.objectiveCap.Text = "/ "..currentObjMax
	elseif activeObj == 4 then
		pointTracker.objectiveTitle.Text = "HOSTILE WIN"
		pointTracker.objectiveStatus.Text = ""
		pointTracker.objectiveStatus.Visible = false
		pointTracker.objectiveCap.Text = ""
		pointTracker.objectiveCap.Visible = false
		script.Parent.Parent.onScreenTimer.Visible = false
		script.Parent.Parent.timerStarted.Value = false
		script.Parent.Parent.joinHostilesButton.Visible = false
		script.Parent.Parent.joinFriendliesButton.Visible = false
		wait(5)
		pointTracker.objectiveTitle.Visible = false
		pointTracker.Visible = false
	elseif activeObj == 5 then
		pointTracker.objectiveTitle.Text = "FRIENDLIES WIN"
		pointTracker.objectiveStatus.Text = ""
		pointTracker.objectiveStatus.Visible = false
		pointTracker.objectiveCap.Text = ""
		pointTracker.objectiveCap.Visible = false
		script.Parent.Parent.onScreenTimer.Visible = false
		script.Parent.Parent.timerStarted.Value = false
		script.Parent.Parent.joinHostilesButton.Visible = false
		script.Parent.Parent.joinFriendliesButton.Visible = false
		wait(5)
		pointTracker.objectiveTitle.Visible = false
		pointTracker.Visible = false
	elseif activeObj == 6 then
		pointTracker.objectiveTitle.Text = "STALEMATE"
		pointTracker.objectiveStatus.Text = ""
		pointTracker.objectiveStatus.Visible = false
		pointTracker.objectiveCap.Text = ""
		pointTracker.objectiveCap.Visible = false
		script.Parent.Parent.onScreenTimer.Visible = false
		script.Parent.Parent.timerStarted.Value = false
		script.Parent.Parent.joinHostilesButton.Visible = false
		script.Parent.Parent.joinFriendliesButton.Visible = false
		wait(5)
		pointTracker.objectiveTitle.Visible = false
		pointTracker.Visible = false
	end
end)
