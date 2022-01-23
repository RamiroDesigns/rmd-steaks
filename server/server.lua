local QBCore = exports['qb-core']:GetCoreObject()

-- give raw meat event 
RegisterNetEvent('steaks:server:rawMeat', function() -- Event used to give Raw Meat
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("rawbeef", Config.RawAmount)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['rawbeef'], "add")
end)

RegisterNetEvent('steaks:server:cookedMeat', function() -- Event used to give Cooked Meat
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("cookedsteak", 1)
    Player.Functions.RemoveItem("rawbeef", 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['cookedsteak'], "add")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['rawbeef'], "removed")
end)
