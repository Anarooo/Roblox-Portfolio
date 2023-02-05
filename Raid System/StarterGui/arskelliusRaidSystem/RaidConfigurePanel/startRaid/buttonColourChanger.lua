--Written by Anaro_Ryker
--The Arskellius Raid System is property of Anaro Media (Trading As). Unauthorized usage of this system will result in a DMCA Takedown Request.

--[[Libraries]]--
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--[[Variables]]--
local configGUI = script.Parent.Parent
local onLoadColour = Color3.new(0.658824, 0, 0)
activeRaid = ReplicatedStorage.arskelliusR.varSet1.activeRaid.Value
script.Parent.ButtonColour.ImageColor3 = onLoadColour
local friendlyIdBox = configGUI.friendlyIdBox
local hostileIdBox = configGUI.hostileIdBox
local hostileCap = configGUI.hostileCap
local friendlyCap = configGUI.friendlyCap
local repeatLoop = 1
local textlen = 0

--[[Main Code]]--
if not activeRaid then
	repeat
		wait()
		textlen = friendlyIdBox.Text:len() + hostileCap.Text:len() + friendlyCap.Text:len() + hostileIdBox.Text:len()
		if friendlyIdBox.Text ~= "" and hostileCap.Text ~= "" and friendlyCap.Text ~= "" and hostileIdBox.Text ~= "" then
			script.Parent.ButtonColour.ImageColor3 = Color3.new(0.25098, 0.584314, 0.105882)
			script.Parent.buttonEnabled.Value = true
		elseif textlen < 4 then
			script.Parent.ButtonColour.ImageColor3 = Color3.new(0.658824, 0, 0)
			script.Parent.buttonEnabled.Value = false
		end
	until repeatLoop ~= 1
end
