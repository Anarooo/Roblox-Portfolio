--Written by Anaro_Ryker
--The Arskellius Raid System is property of Anaro Media (Trading As). Unauthorized usage of this system will result in a DMCA Takedown Request.

script.Parent.RaidConfigurePanel.Visible = false
script.Parent.RaidStatusPanel.Visible = false
script.Parent.RaidConfigurePanel.errorTextLabel.Visible = false
script.Parent.joinHostilesButton.Visible = false
script.Parent.joinFriendliesButton.Visible = false

script.Parent.RaidConfigurePanel:GetPropertyChangedSignal("Visible"):Connect(function()
	if script.Parent.isConfigOpen.Value == true and script.Parent.isStatsOpen.Value == false then
		--do nothing
	elseif script.Parent.isConfigOpen.Value == false and script.Parent.isStatsOpen.Value == true then
		--do nothing
	elseif script.Parent.isConfigOpen.Value == false and script.Parent.isStatsOpen.Value == false then
		--do nothing
	else
		print("An Error was encountered...")
	end
end)
