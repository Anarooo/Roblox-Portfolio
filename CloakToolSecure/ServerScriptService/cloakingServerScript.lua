--Written by Anaro_Ryker
--This script is property of Anaro_Ryker. Use of this script without prior permission is strictly prohibited.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local a = {"Department of Intelligence", "SENTINEL", "Internal Security Branch"}
local cloakedPlayers = {}

ReplicatedStorage.cloakActivated.OnServerEvent:Connect(function(Player, t) --Runs Function once RemoteEvent "cloakActiated" is fired by a client.
	if table.find(a, t) and Player.Team.Name == t then --Compares LocalPlayer's team to whitelisted teams and Player's team IS true. (This is the ServerSide Verification)
		table.insert(cloakedPlayers, Player)
		print(cloakedPlayers)
		ReplicatedStorage.cloakActivated:FireAllClients(Player, t)
	else
		print(Player, " attempted to fire Cloaking Script without Valid Team. Logging.") --Fires RemoteEvent to create webhook log through ServerScript.
		--Webhook Fire goes here
	end
end)

ReplicatedStorage.cloakDeactivated.OnServerEvent:Connect(function(Player, t) --Runs Function once RemoteEvent "cloakActiated" is fired by a client.
	if table.find(a, t) and Player.Team.Name == t then --Compares LocalPlayer's team to whitelisted teams and Player's team IS true. (This is the ServerSide Verification)
		if table.find(cloakedPlayers, Player) then
			for i = #cloakedPlayers, 1, -1 do
				if cloakedPlayers[i] == Player then
					table.remove(cloakedPlayers, i)
				end
			end
		end
		print(cloakedPlayers)
		ReplicatedStorage.cloakDeactivated:FireAllClients(Player)
s	else
		print(Player, " attempted to fire Cloaking Script without Valid Team. Logging.") --Fires RemoteEvent to create webhook log through ServerScript.
		--Webhook Fire goes here
	end
end)

ReplicatedStorage.cloakPlayerLoaded.OnServerEvent:Connect(function(Player_) --Forces all players to cloak all the players inside table once they connect.
	if Player_:GetRankInGroup(9426888) < 230 then
		print("firing to player (1)")
		for i = #cloakedPlayers, 1, -1 do
			local forceCloakPlayer = cloakedPlayers[i]
			local t_1 = "BLANK"

			ReplicatedStorage.cloakActivated:FireClient(Player_, forceCloakPlayer, t_1)
			wait(0.001)
		end
	elseif Player_:GetRankInGroup(9426888) == 230 or Player_:GetRankInGroup(9426888) == 240 or Player_:GetRankInGroup(9426888) == 250 then
		print("firing to player (230)")
		for i = #cloakedPlayers, 1, -1 do
			local forceCloakPlayer = cloakedPlayers[i]
			local t_1 = "BLANK"
			ReplicatedStorage.cloakActivated:FireClient(Player_, forceCloakPlayer, t_1)
			wait(0.001)
		end	
	elseif Player_:GetRankInGroup(9426888) >= 251 then
		print("firing to player (251)")
		for i = #cloakedPlayers, 1, -1 do
			local forceCloakPlayer = cloakedPlayers[i]
			local t_1 = "BLANK"
			ReplicatedStorage.cloakActivated:FireClient(Player_, forceCloakPlayer, t_1)
			wait(0.001)
		end	
	end
end)

Players.PlayerRemoving:Connect(function(Player) --Once a Player Leaves, function checks if they are cloaked, and removes them from the table if they are.
	if table.find(cloakedPlayers, Player) then
		for i = #cloakedPlayers, 1, -1 do
			if cloakedPlayers[i] == Player then
				table.remove(cloakedPlayers, i)
			end
		end
	end
end)
