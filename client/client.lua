local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('rmd-steaks:client:butcherMeat', function() -- Event Used to Get raw Meat
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            TriggerEvent('animations:client:EmoteCommandStart', {"inspect"})
            QBCore.Functions.Progressbar("steak_butcher", "Butchering Cow for Meat", Config.ButchTime, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = false,
                disableInventory = true,
            }, {}, {}, {}, function()
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                TriggerServerEvent('steaks:server:rawMeat') -- give raw meat event
                QBCore.Functions.Notify("You recieved some meat!", "success", "20") 
                local player = PlayerPedId()
                local coords = GetEntityCoords(player)
                ClearAreaOfPeds(coords.x, coords.y, coords.z, 5.0, 0)
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                QBCore.Functions.Notify("Canceled..", "error")
            end)
        else
            QBCore.Functions.Notify("Requires a Hunting Knife", "error")
        end
    end, "huntingknife")  
end)

RegisterNetEvent('rmd-steaks:client:cookSteak', function() -- Cook Steaks
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
        if result then
            TriggerEvent('animations:client:EmoteCommandStart', {"bbq"})
            QBCore.Functions.Progressbar("steak_cook", "Cooking Steak", Config.CookTime, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = false,
                disableInventory = true,
            }, {}, {}, {}, function()
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                TriggerServerEvent('steaks:server:cookedMeat') -- give cooked meat event
                QBCore.Functions.Notify("You recieved some meat!", "success", "20") 
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                QBCore.Functions.Notify("Canceled..", "error")
            end)
        else
            QBCore.Functions.Notify("You need some meat!", "error")
        end
    end, "rawbeef")  
end)

-- Target Exports

exports['qb-target']:AddTargetModel(Config.Props, {
    options = {
        {
            type = "client",
            event = "rmd-steaks:client:cookSteak",
            icon = "fas fa-fire",
            label = "Cook Steaks",
        },
    },
    distance = 2.5
})

exports['qb-target']:AddTargetModel('a_c_cow', {
    options = {
        {
            type = "client",
            event = "rmd-steaks:client:butcherMeat",
            icon = "fas fa-cut",
            label = "Butcher Meat",
            canInteract = function(entity)
                if not IsPedAPlayer(entity) then 
                    return IsEntityDead(entity)
                end
            end, 
        },
    },
    distance = 2.5
})

