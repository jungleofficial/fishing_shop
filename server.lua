ESX.RegisterServerCallback('fishing:buyItem', function(source, cb, itemName, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(itemName, 1)
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('fishing:buyItem')
AddEventHandler('fishing:buyItem', function(itemName, price)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(itemName, 1)
        TriggerClientEvent('esx:showNotification', source, "Vous avez acheté une " .. itemName .. ".")
    else
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent.")
    end
end)
