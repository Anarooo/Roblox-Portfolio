--Written by Anaro_Ryker
--This script is property of Anaro_Ryker. Use of this script without prior permission is strictly prohibited.

local GUI = script.Parent
GUI.Enabled = false
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local LocalPlrRank = LocalPlayer:GetRankInGroup(9426888)
local authorizedTeams = {"Department of Intelligence", "SENTINEL", "Internal Security Branch"}
local foundTeam

LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function()
	local team = LocalPlayer.Team.Name
	if table.find(authorizedTeams, team) then
		foundTeam = true
	end
	if foundTeam == true then
		GUI.Enabled = true
		foundTeam = false
	elseif foundTeam == false then
		GUI.Enabled = false
		foundTeam = false
		game.ReplicatedStorage.cloakPlayerLoaded:FireServer() --Changing the teams in this script will not change the outcome of execution as it is server-side verified.
	else
		print("Encountered Error 0x08000004")
	end
end)
