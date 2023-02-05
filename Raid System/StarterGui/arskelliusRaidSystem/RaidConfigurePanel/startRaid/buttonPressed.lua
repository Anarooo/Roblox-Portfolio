--Written by Anaro_Ryker
--The Arskellius Raid System is property of Anaro Media (Trading As). Unauthorized usage of this system will result in a DMCA Takedown Request.

--[[Libraries]]--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GroupService = game:GetService("GroupService")

--[[Variables]]--
local configGUI = script.Parent.Parent
local hostileIdBox = configGUI.hostileIdBox
local friendlyIdBox = configGUI.friendlyIdBox
local hostileCap = configGUI.hostileCap
local friendlyCap = configGUI.friendlyCap
local buttonEnabled = false
local hostileRaiderCap
local friendlyRaiderCap
local raidGroup
local friendlyGroup

--[[Main Code]]--
configGUI.startRaid.MouseButton1Click:Connect(function()
	local activeRaid = ReplicatedStorage.arskelliusR.varSet1.activeRaid.Value
	if tonumber(hostileIdBox.Text) ~= nil then
		local groupInfoR = GroupService:GetGroupInfoAsync(hostileIdBox.Text)
		raidGroup = groupInfoR["Name"]
	else 
		raidGroup = hostileIdBox.Text
	end
	if tonumber(friendlyIdBox.Text) then
		local groupInfoF = GroupService:GetGroupInfoAsync(friendlyIdBox.Text)
		friendlyGroup = groupInfoF["Name"]
	else
		friendlyGroup = friendlyIdBox.Text
	end
	hostileRaiderCap = tonumber(hostileCap.Text)
	friendlyRaiderCap = tonumber(friendlyCap.Text)
	buttonEnabled = configGUI.startRaid.buttonEnabled.Value
	print(activeRaid)
	if buttonEnabled and not activeRaid then
		ReplicatedStorage.arskelliusR.initiateRaid:FireServer(raidGroup, friendlyGroup, hostileRaiderCap, friendlyRaiderCap)
	elseif buttonEnabled and activeRaid then
		configGUI.errorTextLabel.Visible = true
		wait(2)
		configGUI.errorTextLabel.Visible = false
	end
end)
