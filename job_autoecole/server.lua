
ESX = exports["es_extended"]:getSharedObject()


local ox_inventory = exports.ox_inventory

RegisterNetEvent('osc:removeitem')
AddEventHandler('osc:removeitem', function(item, amount)
local source = source

ox_inventory:RemoveItem(source, item, amount)
end)

---annonce
RegisterServerEvent('drift:Ouvert')
AddEventHandler('drift:Ouvert', function()
    local _source  = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if Config.NotificationType == "esx" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], Config.JobUtiliser, '~b~Annonce auto ecole', 'auto ecole Ouvert', 'CHAR_CARSITE2', 7)
        elseif Config.NotificationType == "ox" then
            sendNotification(xPlayers[i], "info", 'Annonce auto ecole', 'auto ecole Ouvert')
        elseif Config.NotificationType == "okok" then
            sendNotification(xPlayers[i], "info", 'Annonce auto ecole', 'auto ecole Ouvert')
        end
    end
end)

RegisterServerEvent('drift:Fermer')
AddEventHandler('drift:Fermer', function()
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if Config.NotificationType == "esx" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], Config.JobUtiliser, '~b~Annonce auto ecole', 'auto ecole Fermer', 'CHAR_CARSITE2', 7)
        elseif Config.NotificationType == "ox" then
            sendNotification(xPlayers[i], "info", 'Annonce auto ecole', 'auto ecole Fermer')
        elseif Config.NotificationType == "okok" then
            sendNotification(xPlayers[i], "info", 'Annonce auto ecole', 'auto ecole Fermer')
        end
    end
end)

RegisterServerEvent('drift:Perso')
AddEventHandler('drift:Perso', function(message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if Config.NotificationType == "esx" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], Config.JobUtiliser, '~b~Annonce auto ecole', message, 'CHAR_CARSITE2', 7)
        elseif Config.NotificationType == "ox" then
            sendNotification(xPlayers[i], "info", 'Annonce auto ecole', message)
        elseif Config.NotificationType == "okok" then
            sendNotification(xPlayers[i], "info", 'Annonce auto ecole', message)
        end
    end
end)


ESX.RegisterServerCallback('rPermisPoint:getAllLicenses', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)
        local allLicenses = {}
        MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @owner', {['owner'] = xPlayer.identifier}, function(result)
            for k,v in pairs(result) do
                table.insert(allLicenses, {
                    Name = xPlayer.getName(),
                    Type = v.type,
                    Point = v.point,
                    Owner = v.owner
                })
            end
            cb(allLicenses)
        end)
end)

---boss action 
RegisterServerEvent('Recruter')
AddEventHandler('Recruter', function(target, job, grade)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    targetXPlayer.setJob(job, grade)
    TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~recruté " .. targetXPlayer.name .. "~w~.")
    TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~embauché par " .. sourceXPlayer.name .. "~w~.")
end)


RegisterServerEvent('Virer')
AddEventHandler('Virer', function(target)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    local job = "unemployed"
    local grade = "0"
    if (sourceXPlayer.job.name == targetXPlayer.job.name) then
        targetXPlayer.setJob(job, grade)
        TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~viré " .. targetXPlayer.name .. "~w~.")
        TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~viré par " .. sourceXPlayer.name .. "~w~.")
    else
        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
    end
end)

RegisterServerEvent('Promotion')
AddEventHandler('Promotion', function(target)
	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == 3) then
		TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~b~promouvoir~w~ d'avantage.")
	else
		if (sourceXPlayer.job.name == targetXPlayer.job.name) then
			local grade = tonumber(targetXPlayer.job.grade) + 1
			local job = targetXPlayer.job.name

			targetXPlayer.setJob(job, grade)

			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~b~promu " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent('esx:showNotification', target, "Vous avez été ~b~promu~s~ par " .. sourceXPlayer.name .. "~w~.")
		end
	end
end)

RegisterServerEvent('Retrograder')
AddEventHandler('Retrograder', function(target)
	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == 0) then
		TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~r~rétrograder~w~ d'avantage.")
	else
		if (sourceXPlayer.job.name == targetXPlayer.job.name) then
			local grade = tonumber(targetXPlayer.job.grade) - 1
			local job = targetXPlayer.job.name

			targetXPlayer.setJob(job, grade)

			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~rétrogradé " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent('esx:showNotification', target, "Vous avez été ~r~rétrogradé par " .. sourceXPlayer.name .. "~w~.")
		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
		end
	end
end)

---gestion argent

ESX.RegisterServerCallback('getSocietyMoney', function(source, cb)
	  local society = Config.society
	  TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
        print(account.money)
		cb(account.money)
	  end)
end)



RegisterServerEvent("autodepotentreprise")
AddEventHandler("autodepotentreprise", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getAccount("bank").money
    
    TriggerEvent('esx_addonaccount:getSharedAccount', Config.society, function (account)
        if xMoney >= total then
            account.addMoney(total)
            xPlayer.removeAccountMoney('bank', total)
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque Société', "~b~auto ecole", "Vous avez déposé ~g~"..total.." $~s~ dans votre ~b~entreprise", 'CHAR_BANK_FLEECA', 9)
        else
            TriggerClientEvent('esx:showNotification', source, "<C>~r~Vous n'avez pas assez d'argent !")
        end
    end)   
end)

RegisterServerEvent("autoRetraitEntreprise")
AddEventHandler("autoRetraitEntreprise", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	local xMoney = xPlayer.getAccount("bank").money
	
	TriggerEvent('esx_addonaccount:getSharedAccount', Config.society, function (account)
		if account.money >= total then
			account.removeMoney(total)
			xPlayer.addAccountMoney('bank', total)
			TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque Société', "~b~auto ecole", "Vous avez retiré ~g~"..total.." $~s~ de votre ~b~entreprise", 'CHAR_BANK_FLEECA', 9)
		else
			TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque Société', "~b~auto ecole", "Vous avez pas assez d'argent dans votre ~b~entreprise", 'CHAR_BANK_FLEECA', 9)
		end
	end)
end) 

---garage

RegisterNetEvent("testserversideauto", function(data) 
    local source = source 
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= data.prix then 
        xPlayer.removeMoney(data.prix)
        xPlayer.showNotification("Vous avez sortie : ~b~"..data.name.."")
        TriggerClientEvent("clientsideauto", source, data)
    else xPlayer.showNotification("Vous avez pas assez d'argent") end 
end)

---coffre
local borderstash = {
    id = 'coffre_autoecole',
    label = 'Coffre auto',
    slots = 90,
    weight = 2000000,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
		exports.ox_inventory:RegisterStash(borderstash.id, borderstash.label, borderstash.slots, borderstash.weight, borderstash.owner)
    end
end)

RegisterServerEvent('ledjo_tabac:add')
AddEventHandler('ledjo_tabac:add', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if type == 'money' then
		xPlayer.addMoney(amount)
		TriggerClientEvent('esx:showNotification', source, 'Tu a recu $'..amount 'success')
	elseif type == 'item' then
		xPlayer.addInventoryItem(name, amount)
	end
end)

RegisterServerEvent('ledjo_tabac:remove')
AddEventHandler('ledjo_tabac:remove', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if type == 'money' then
		xPlayer.removeMoney(amount)
	elseif type == 'item' then
		xPlayer.removeInventoryItem(name, amount)
	end
end)

ESX.RegisterServerCallback('ledjo_tabac:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

