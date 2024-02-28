ESX = exports["es_extended"]:getSharedObject()

local enableWelcomeNotification = true 

local customRules = {
    "Rule 1 - No VDM allowed.",
    "Rule 2 - No RDM allowed.",
    "Rule 3 - No swearing allowed.",
    -- U can add more lines if needed
}

local rulesAccepted = {}

RegisterServerEvent('getWelcomeMessage')
AddEventHandler('getWelcomeMessage', function()
    local source = source

    if enableWelcomeNotification then
        TriggerClientEvent('displayWelcomeMessage', source, customRules)
    end
end)

RegisterCommand('accepteer', function(source, args, rawCommand)
    rulesAccepted[source] = true
    TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, 'You have accepted the rules.') -- Message for accepting rules
end, false)

RegisterServerEvent('kickPlayerForRules')
AddEventHandler('kickPlayerForRules', function()
    DropPlayer(source, 'You have been kicked for not accepting our server rules!')
end)


