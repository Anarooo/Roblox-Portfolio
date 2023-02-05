local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local activatorName = nil

ReplicatedStorage.playerCloak.OnClientEvent:Connect(function(Activator)
	print(Activator)
	print("Fired Successfully")
	print(Activator.Team)
	activatorName = Activator.Name
	if LocalPlayer.Team == Activator.Team or LocalPlayer.Team.Name == "other" then
		local function makeXrayPart(part)
			part.LocalTransparencyModifier = 0.5
		end
		local function recurseForParts(object)
			if object:IsA("BasePart") or object:IsA("Decal") then
				makeXrayPart(object)
				print(object)
			end
			for _, child in pairs (object:GetChildren()) do
				recurseForParts(child)
			end
		end
		recurseForParts(Workspace[activatorName])
		--break
	else
		local function makeXrayPart(part)
			part.LocalTransparencyModifier = 1
		end
		local function recurseForParts(object)
			if object:IsA("BasePart") or object:IsA("Decal") then
				makeXrayPart(object)
			end
			for _, child in pairs (object:GetChildren()) do
				recurseForParts(child)
			end
		end
		recurseForParts(Workspace[activatorName])
	end 
end)
ReplicatedStorage.playerUncloak.OnClientEvent:Connect(function(Activator)
	print(Activator)
	print("Uncloak Fired Successfully")
	print(Activator.Team)
	local function makeXrayPart(part)
		part.LocalTransparencyModifier = 0
	end
	local function recurseForParts(object)
		if object:IsA("BasePart") or object:IsA("Decal") then
			makeXrayPart(object)
		end
		for _, child in pairs (object:GetChildren()) do
			recurseForParts(child)
		end
	end
	recurseForParts(Workspace[activatorName])
end)
