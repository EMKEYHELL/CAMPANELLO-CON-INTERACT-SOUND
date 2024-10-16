ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_campanello:suonaCampanello')
AddEventHandler('esx_campanello:suonaCampanello', function(campanello)
    local _source = source  
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == campanello.lavoro then
            local playerPed = GetPlayerPed(xPlayers[i]) 
            local playerCoords = GetEntityCoords(playerPed) 
            local distanza = #(playerCoords - campanello.coords) 
            if distanza <= 50.0 then 
                TriggerClientEvent('InteractSound_SV:PlayOnSource', xPlayers[i], campanello.suono, 0.5)
                TriggerClientEvent('vms_notify:Notification', xPlayers[i], 'Campanello', '~g~Qualcuno ha suonato il campanello!', 2000, '#ff9900', 'fa-exclamation-triangle')
            else
                TriggerClientEvent('vms_notify:Notification', xPlayers[i], 'Campanello', '~o~Hanno suonato un campanello!', 2000, '#ff9900', 'fa-exclamation-triangle')
            end
        end

        if xPlayers[i] == _source then
            TriggerClientEvent('vms_notify:Notification', _source, 'Campanello', '~g~Hai suonato il campanello!', 2000, '#00ff00', 'fa-check')
        end
    end
end)
