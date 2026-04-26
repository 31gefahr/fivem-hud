local QBCore = exports['qb-core']:GetCoreObject()

local function UpdatePlayerHUD(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerClientEvent('hud:client:UpdateBasics', src, 
            Player.PlayerData.job.label, 
            Player.PlayerData.job.grade.name, 
            Player.PlayerData.money['cash'], 
            Player.PlayerData.money['bank']
        )
    end
end

-- Bu kısımlar doğru görünüyor
RegisterNetEvent('QBCore:Server:OnJobUpdate', function(playerId)
    UpdatePlayerHUD(playerId)
end)

RegisterNetEvent('QBCore:Server:OnMoneyChange', function(playerId)
    UpdatePlayerHUD(playerId)
end)

-- Loaded eventi için source'u direkt geçirmek daha garantidir
AddEventHandler('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    UpdatePlayerHUD(src)
end)