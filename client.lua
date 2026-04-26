local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pData = QBCore.Functions.GetPlayerData()
        
        if pData and pData.money then
            -- Can hesaplama (Ölünce 0 olması için düzenlendi)
            local rawHealth = GetEntityHealth(ped)
            local displayHealth = 0
            if rawHealth > 100 then
                displayHealth = rawHealth - 100
            else
                displayHealth = 0
            end

            SendNUIMessage({
                type = "updateBasics",
                id = GetPlayerServerId(PlayerId()),
                job = pData.job.label,
                cash = pData.money['cash'],
                bank = pData.money['bank']
            })

            SendNUIMessage({
                type = "updateStatus",
                show = not IsPauseMenuActive(),
                health = displayHealth,
                armor = GetPedArmour(ped),
                hunger = pData.metadata["hunger"] or 0,
                thirst = pData.metadata["thirst"] or 0,
                stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
            })
        end
        Citizen.Wait(1000)
    end
end)

-- Araç Göstergesi
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped, false)
            SendNUIMessage({
                type = "updateCarHud",
                show = true,
                speed = math.floor(GetEntitySpeed(veh) * 2.236936), -- MPH
                fuel = GetVehicleFuelLevel(veh),
                gear = GetVehicleCurrentGear(veh),
                rpm = GetVehicleCurrentRpm(veh)
            })
            Citizen.Wait(100)
        else
            SendNUIMessage({ type = "updateCarHud", show = false })
            Citizen.Wait(1000)
        end
    end
end)