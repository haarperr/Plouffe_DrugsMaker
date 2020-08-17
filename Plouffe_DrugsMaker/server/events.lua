TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Plouffe_DrugsMaker:ItemsCheck', function(source, cb, val, recipe)
    local xPlayer = ESX.GetPlayerFromId(source)
    local asEnough = true

    for k,v in ipairs(DrugsMaker.CraftList) do 
        if val == v.itemname then
            for _,j in ipairs(v.requireditems) do
                local currentItem = xPlayer.getInventoryItem(j.name)

                if currentItem.count >= j.count then
                    for L,item in ipairs(recipe) do
                        if item.name == j.name then
                            xPlayer.removeInventoryItem(item.name,item.count)
                            table.remove(recipe,L)
                        end
                    end
                else
                    asEnough = false
                    -- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Vous avez echouer votre mix.", length = 5000 })
                end
            end
        end
    end

    for k,v in pairs(recipe) do
        asEnough = false
        local currentItem = xPlayer.getInventoryItem(v.name)
        xPlayer.removeInventoryItem(v.name,v.count)
    end

	cb(asEnough)
end)

RegisterServerEvent("Plouffe_DrugsMaker:BuyItems")
AddEventHandler("Plouffe_DrugsMaker:BuyItems", function(item,amount,price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getAccount('black_money').money
    local newPrice = amount * price

    if money >= newPrice and money ~= nil then
        xPlayer.removeAccountMoney('black_money', newPrice)
        xPlayer.addInventoryItem(item,amount)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Vous avez acheter pour: "..tostring(newPrice).." $", length = 5000 })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Vous n'avez pas asser d'argent", length = 5000 })
    end

end)

RegisterServerEvent("Plouffe_DrugsMaker:Craft")
AddEventHandler("Plouffe_DrugsMaker:Craft", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local canCraft = true

    for k,v in ipairs(DrugsMaker.BlackCraftList) do 
        if v.itemname == item then
            for _,i in ipairs(v.requireditems) do
                local count = xPlayer.getInventoryItem(i.name).count
                if count < i.count then
                    canCraft = false
                end
            end
        end
    end

    if canCraft == true then
        local xItem = xPlayer.getInventoryItem(item)
        xPlayer.addInventoryItem(item,1)
        for k,v in ipairs(DrugsMaker.BlackCraftList) do 
            if v.itemname == item then
                for _,i in ipairs(v.requireditems) do
                    xPlayer.removeInventoryItem(i.name,i.count)
                end
            end
        end
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Vous avez fait 1x :"..xItem.label..".", length = 5000 })
    end

end)

RegisterServerEvent("Plouffe_DrugsMaker:Pooching")
AddEventHandler("Plouffe_DrugsMaker:Pooching", function(item,newitem)
    local xPlayer = ESX.GetPlayerFromId(source)
    local currentItem = xPlayer.getInventoryItem(item)

    if currentItem.count >= 10 and currentItem.count ~= nil then
        xPlayer.removeInventoryItem(item,10)
        xPlayer.addInventoryItem(newitem,1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'succes', text = "Vous avez fait 1x :"..currentItem.label..".", length = 5000 })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Vous n'avez pas asser de produits.", length = 5000 })
    end

end)

RegisterServerEvent("Plouffe_DrugsMaker:FailedPooching")
AddEventHandler("Plouffe_DrugsMaker:FailedPooching", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local currentItem = xPlayer.getInventoryItem(item)

    xPlayer.removeInventoryItem(item,10)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "Vous n'avez pas asser de produits.", length = 5000 })
end)
