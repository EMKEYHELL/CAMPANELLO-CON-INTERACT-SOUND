ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local nearCampanello = false

        for _, campanello in pairs(Config.Campanelli) do
            local distanza = #(playerCoords - campanello.coords)

            if distanza <= 2.0 then
                nearCampanello = true
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per suonare il campanello') -- Notifica ESX HelpText

                -- Disegna il marker personalizzato (usando i valori dal config.lua)
                DrawMarker(
                    2, -- Tipo di marker
                    campanello.coords.x, campanello.coords.y, campanello.coords.z + 2, -- Coordinate del marker
                    0.0, 0.0, 0.0, 0.0, 180.0, 0.0, -- Direzione e rotazione
                    campanello.markerScale or 0.5, campanello.markerScale or 0.5, campanello.markerScale or 0.5, -- Dimensioni (usando il valore dal config.lua)
                    campanello.markerColor.r or 255, campanello.markerColor.g or 128, campanello.markerColor.b or 0, campanello.markerColor.a or 50, -- Colore e opacità (usando i valori dal config.lua)
                    false, true, 2, nil, nil, false -- Opzioni aggiuntive
                )

                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent('InteractSound_SV:PlayOnSource', campanello.suono, 0.5)
                    exports['vms_notify']:Notification("Campanello", "~g~Hai suonato il campanello!", 2000, '#00ff00', 'fa-check')
                    TriggerServerEvent('esx_campanello:suonaCampanello', campanello)
                end
            end
        end

        if not nearCampanello then
            Citizen.Wait(500)
        end
    end
end)

RegisterNetEvent('notificaCampanello')
AddEventHandler('notificaCampanello', function(lavoro)
    if ESX.GetPlayerData().job.name == lavoro then
        exports['vms_notify']:Notification("Campanello", "~g~Qualcuno ha suonato il campanello!", 2000, '#ff9900', 'fa-exclamation-triangle')
    end
end)
