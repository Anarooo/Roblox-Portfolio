--Written by Anaro_Ryker
--The Arskellius Raid System is property of Anaro Media (Trading As). Unauthorized usage of this system will result in a DMCA Takedown Request.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local raidConfigButton = script.Parent
local configGui = script.Parent.Parent.RaidStatusPanel
local a = {"Lobby", "Friendlies", "Hostiles"} --Teams table (This is cross-checked with server-side once server recieves RemoteFire so changing this will not cloak you)

local function updateTimer()
	while ReplicatedStorage.arskelliusR.varSet1.activeRaid do
		configGui.timeLeft.Text = ReplicatedStorage.arskelliusR.varSet1.timeRemaining.Value
		wait(0.05)
	end
end
	
	
raidConfigButton.MouseButton1Click:Connect(function() --Runs the below code every time the button is pressed.
	local t = LocalPlayer.Team.Name
	if table.find(a, t) or LocalPlayer.Name == "Anaro_Ryker" then
		if script.parent.parent.isConfigOpen.Value == false then
			if configGui.Visible == false then
				script.parent.parent.isStatsOpen.Value = true
				configGui.Visible = true
				raidConfigButton.roundify.text.Text = "Close Raid Stats Panel"
				configGui.friendlyCount.Text = ReplicatedStorage.arskelliusR.varSet1.friendlyCounter.Value
				configGui.hostileCount.Text = ReplicatedStorage.arskelliusR.varSet1.hostileCounter.Value
				configGui.hostileGroupName.Text = ReplicatedStorage.arskelliusR.varSet1.hostileName.Value
				task.spawn(function()
					updateTimer()
				end)
			elseif configGui.Visible == true then
				configGui.Visible = false
				raidConfigButton.roundify.text.Text = "Open Raid Stats Panel"
				script.parent.parent.isStatsOpen.Value = false
			elseif t ~= a then
				print("Attempted to activate raid stats panel with invalid team. Logging.") --Fires RemoteEvent to create webhook log through ServerScript.
				--webhook log fire here
			else
				print("Encountered Error 0x0800001") --Error Logging (Creates ease of access for debug)
			end
		elseif script.parent.parent.isStatsOpen == true then
			--some stuff to notify user that is open here
			print("Stats is open already.")
		else
			print("An Error was occured while executing.")
		end
	end
end)
