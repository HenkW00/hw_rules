ESX = exports["es_extended"]:getSharedObject()

local mythic = false
local rulesAccepted = false
local kickedForRules = false

Citizen.CreateThread(function()
    while not mythic do
        TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Checking if Mythic Notify is installed' })
        Citizen.Wait(0)

        if exports['mythic_notify'] then
            mythic = true
        end
    end

    while true do
        Citizen.Wait(0)

        if not rulesAccepted and not kickedForRules then
            local playerPed = GetPlayerPed(-1)
            local playerCoords = GetEntityCoords(playerPed)
            local _, _, _, _, vehicle = GetRaycastResult(playerCoords.x, playerCoords.y, playerCoords.z, playerCoords.x, playerCoords.y, playerCoords.z + 10.0)

            if IsControlJustReleased(0, 38) and not IsPedInAnyVehicle(playerPed) and not IsEntityDead(playerPed) then
                TriggerServerEvent('getWelcomeMessage')
            end
        end
    end
end)

RegisterNetEvent('displayWelcomeMessage')
AddEventHandler('displayWelcomeMessage', function(rules)
    if not rulesAccepted then
        mythicNotify('inform', 'Welcome to {server_name}!', 15000)
        mythicNotify('inform', 'Rules summary:<br>' .. table.concat(rules, '<br>'), 15000)
        mythicNotify('inform', 'Use /accept to agree to our rules!', 15000)

        Citizen.Wait(20000)
        mythicNotify('inform', 'Have you read the rules?', 10000)
        mythicNotify('inform', 'U can use /accept to agree to the rules!', 10000)

        Citizen.Wait(20000)
        if not rulesAccepted then
            kickedForRules = true
            mythicNotify('error', 'You have been kicked for not accepting our server rules!', 5000)
            Citizen.Wait(5000)  -- Wait for the notification to display
            TriggerServerEvent('kickPlayerForRules')
        end
    end
end)

AddEventHandler('playerSpawned', function()
    if not rulesAccepted and not kickedForRules then
        TriggerServerEvent('getWelcomeMessage')
    end
end)

RegisterCommand('accept', function()
    rulesAccepted = true
    mythicNotify('success', 'You have accepted the rules. Have fun!', 5000)
end, false)

function mythicNotify(type, text, length)
    TriggerEvent('mythic_notify:client:SendAlert', { type = type, text = text, length = length })
end
