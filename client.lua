local function openFishingMenu()
    local elements = {}
    for _, item in ipairs(Config.FishingItems) do
        table.insert(elements, {label = item.label .. " - $" .. item.price, value = item.label})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fishing_menu', {
        title = 'Magasin de Pêche',
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        local selectedItem = data.current.value
        for _, item in ipairs(Config.FishingItems) do
            if item.label == selectedItem then
                TriggerServerEvent('fishing:buyItem', item.label, item.price)
                break
            end
        end
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        if Vdist(playerCoords, Config.FishingShopCoords) < 1.5 then
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au magasin de pêche.")
            if IsControlJustReleased(0, 38) then -- E key
                openFishingMenu()
            end
        end
    end
end)
