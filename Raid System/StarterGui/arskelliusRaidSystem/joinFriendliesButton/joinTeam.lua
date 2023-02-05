local ReplicatedStorage = game:GetService("ReplicatedStorage")
local arskeliusR = ReplicatedStorage.arskelliusR
local joinHostiles = script.Parent.Parent.joinHostilesButton
local joinFriendlies = script.Parent

---

joinFriendlies.MouseButton1Click:Connect(function()
	if arskeliusR.varSet1.activeRaid.Value then
		arskeliusR.changeTeam:FireServer(true)
	end
end)

joinHostiles.MouseButton1Click:Connect(function()
	if arskeliusR.varSet1.activeRaid.Value then
		arskeliusR.changeTeam:FireServer(false)
	end
end)
