ESX = nil
local notif = '::{Dash#5403}::esx:showNotification'
local notif2 = '::{Dash#5403}::esx:showAdvancedNotification'

RegisterServerEvent("{[DIXLAN]}:notifSpawn")
AddEventHandler("{[DIXLAN]}:notifSpawn", function()
    TriggerClientEvent(notif, -1,"De nouveau ~r~~b~mercenaires~b~~s~ son présent en zone hostile")
end)

--RegisterCommand("war", function(source, args)
--    local argument = args[1]
--    if IsPlayerAceAllowed(source, "dixnofightplay.spawnped") then
--        TriggerClientEvent("{[DIXLAN]}:SpawnCommand", source, argument)
--        print("Event - trigered")
--
--        TriggerClientEvent("chatMessage", source, "{[DIXLAN]}:WAR : Spawn effectué avec succès")
--        print("Server Side - "..argument)
--    else
--        TriggerClientEvent("chatMessage", source, "{[DIXLAN]}:WAR : Permission insufisante")
--    end
--end)