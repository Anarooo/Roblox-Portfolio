local activated = false
local Players = game:GetService("Players")
local Activator = Players.LocalPlayer.Name
print(Activator)
local Workspace = game:GetService("Workspace")
local cloakButton = script.Parent
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local team = Activator.TeamColor

cloakButton.Activated:Connect(function()
	wait(0.2)
	if activated == false then
		--remote event fires to cloak
		ReplicatedStorage.cloakingActivate:FireServer(Activator)
		activated = true
	elseif activated == true then
		--remote event fires to uncloak
		ReplicatedStorage.cloakingUnactivate:FireServer(Activator)
		activated = false
	end
end)
