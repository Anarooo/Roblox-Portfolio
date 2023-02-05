local ReplicatedStorage = game:GetService("ReplicatedStorage")

local cloakingActivate = ReplicatedStorage.cloakingActivate
local cloakingUnactivate = ReplicatedStorage.cloakingUnactivate


cloakingActivate.OnServerEvent:Connect(function(Activator)
	--wait(0.2)
	ReplicatedStorage.playerCloak:FireAllClients(Activator)
end)
cloakingUnactivate.OnServerEvent:Connect(function(Activator)
	--wait(0.2)
	ReplicatedStorage.playerUncloak:FireAllClients(Activator)
end)
