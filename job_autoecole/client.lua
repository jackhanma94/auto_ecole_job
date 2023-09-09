RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer) ESX.PlayerData = xPlayer end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job) ESX.PlayerData.job = job end)

---menu f6
lib.registerContext({
    id = 'menu_autoecole',
    title = 'MENU AUTO ECOLE',
    options = {
      {
        title = '📤menu annonce',
        description = 'acceder au annonce',
        menu = 'annonce',
        icon = 'bars'
      },
      {
        title = '💸menu facture',
        description = 'mettre une facture',
        event = 'sendbill',
        icon = 'bars'
      }
    }
})

lib.registerContext({
  id = 'annonce',
  title = 'menu annonce',
  menu = 'menu_drift',
  onBack = function()
    print('Went back!')
  end,
  options = {
    {
      title = '🌔annonce ouverture',
      description = 'appuyer pour ouvrir',
      event = 'drift:ouvert',
      icon = 'bars'
    },
    {
      title = '🌚annonce fermeture',
      description = 'appuyer pour fermer',
      event = 'drift:fermer',
      icon = 'bars'
    },
    {
      title = '📑annonce personalise',
      description = 'appuyer pour faire une annonce',
      event = 'drift:perso',
      icon = 'bars'
    }
  }
})

--- annonce
RegisterNetEvent('autoecole:perso')
AddEventHandler('autoecole:perso', function(message)
    local input = lib.inputDialog(('message personalise'), {'Message'})
 
    if not input then return end

    local message = input[1]

    TriggerServerEvent('autoecole:Perso', message)
end)
RegisterNetEvent('autoecole:ouvert')
AddEventHandler('autoecole:ouvert', function()
    TriggerServerEvent('autoecole:Ouvert')
end)

RegisterNetEvent('autoecole:fermer')
AddEventHandler('autoecole:fermer', function()
    TriggerServerEvent('autoecole:Fermer')
end)



RegisterCommand("menu_autoecole", function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.JobUtiliser and not ESX.PlayerData.dead then
        lib.showContext("menu_autoecole")
    end
end)

RegisterKeyMapping("menu_autoecole", "menu_autoecole", "keyboard", "F6")



---autopoint

lib.registerContext({
  id = 'action',
  title = 'MENU AUTO ECOLE',
  options = {
    {
      title = '🏫attribuer code de la route',
      description = 'appuyer pour attribuer',
      onSelect = function()
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'dmv')
            ESX.ShowNotification('~g~Vous avez attribué le code de la route avec succès.')
            lib.showContext('action')
        else
            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
            lib.showContext('action')
        end
      end,
      icon = 'bars'
    },
    {
      title = '🚗attribuer permis voiture',
      description = 'appuyer pour attribuer',
      onSelect = function()
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'drive')
            ESX.ShowNotification('~g~Vous avez attribué le code de la route avec succès.')
            lib.showContext('action')
        else
            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
            lib.showContext('action')
        end
      end,
      icon = 'bars'
    },
    {
      title = '🏍️attribuer permis moto',
      description = 'appuyer pour attribuer',
      onSelect = function()
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'drive_bike')
            ESX.ShowNotification('~g~Vous avez attribué le code de la route avec succès.')
            lib.showContext('action')
        else
            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
            lib.showContext('action')
        end
      end,
      icon = 'bars'
    },
    {
      title = '🚚attribuer permis poid lourd',
      description = 'appuyer pour attribuer',
      onSelect = function()
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'drive_truck')
            ESX.ShowNotification('~g~Vous avez attribué le code de la route avec succès.')
            lib.showContext('action')
        else
            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
            lib.showContext('action')
        end
      end,
      icon = 'bars'
    }
  }
})

Citizen.CreateThread(function()
  while true do
      local Timer = 500
      local plyPos = GetEntityCoords(PlayerPedId())
      local dist = #(plyPos-Config.pose.action)
      if ESX.PlayerData.job.name == Config.JobUtiliser then
      if dist <= 10.0 then
       Timer = 0
       DrawMarker(2, Config.pose.action, nil, nil, nil, -90, nil, nil,0.3, 0.2, 0.15, 30, 150, 30, 222, false, true, 0, false, false, false, false)
      end
       if dist <= 3.0 then
          Timer = 0
          if IsControlJustPressed(1,51) then
            lib.showContext('action')
          end
       end
      end
  Citizen.Wait(Timer)
end
end)

--- annonce
RegisterNetEvent('drift:perso')
AddEventHandler('drift:perso', function(message)
    local input = lib.inputDialog(('message personalise'), {'Message'})
 
    if not input then return end

    local message = input[1]

    TriggerServerEvent('drift:Perso', message)
end)
RegisterNetEvent('drift:ouvert')
AddEventHandler('drift:ouvert', function()
    TriggerServerEvent('drift:Ouvert')
end)

RegisterNetEvent('drift:fermer')
AddEventHandler('drift:fermer', function()
    TriggerServerEvent('drift:Fermer')
end)
  




---BLIPS
local blips = {
    { title = Config.blips.title, colour = Config.blips.color, id = Config.blips.id, x = Config.blips.x, y = Config.blips.y, z = Config.blips.z }
  }
  
  Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.6)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
  end)

-- Facture
RegisterNetEvent('sendbill')
AddEventHandler('sendbill', function()
  local input = lib.inputDialog('FACTURE AUTO ECOLE', {
    {type = "number", label = "Montant de la facture", min = 1, max = 100000}
  })
           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification('Montant Invalide')
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification('Personne proche!')
				else
          TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_VEHICLE_MECHANIC', 0, true)
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_lscustom', 'Facture Mecano', amount)
        
			end
		end
    end
end)


---boss menu
lib.registerContext({
  id = 'boss_menu',
  title = 'BOSS MENU',
  options = {
    {
      title = '🤝action menu',
      icon = 'bars',
      menu = 'personel_menu',
      onSelect = function() mecanoRetraitEntreprise() end
    },
    {
      title = '🏧gestion argent',
      icon = 'bars',
      menu = 'gestion_argent',
      onSelect = function() mecanoRetraitEntreprise() end
    }
}
})

lib.registerContext({
  id = 'personel_menu',
  title = 'action menu',
  menu = 'boss_menu',
  onBack = function()
    print('Went back!')
  end,
  options = {
    {
      title = 'recruter',
      icon = 'bars',
      onSelect = function() 
        local Tikozaal = {}           
        Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
        if Tikozaal.closestPlayer == -1 or Tikozaal.closestDistance > 3.0 then
             ESX.ShowNotification('Aucun joueur à ~b~proximité')
             lib.showContext('boss_menu')
        else
            TriggerServerEvent('Tikoz:Recruter', GetPlayerServerId(Tikozaal.closestPlayer), ESX.PlayerData.job.name, 0)
            lib.showContext('boss_menu')
        end 
      end
    },
    {
      title = 'premouvoir',
      icon = 'bars',
      onSelect = function() 
        local Tikozaal = {}   
        Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
        if Tikozaal.closestPlayer == -1 or Tikozaal.closestDistance > 3.0 then
             ESX.ShowNotification('Aucun joueur à ~b~proximité')
             lib.showContext('boss_menu')
        else
            TriggerServerEvent('Tikoz:Promotion', GetPlayerServerId(Tikozaal.closestPlayer), ESX.PlayerData.job.name, 0)
            lib.showContext('boss_menu')
        end 
      end
    },
    {
      title = 'retrograder',
      icon = 'bars',
      onSelect = function() 
        local Tikozaal = {}   
        Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
        if Tikozaal.closestPlayer == -1 or Tikozaal.closestDistance > 3.0 then
             ESX.ShowNotification('Aucun joueur à ~b~proximité')
             lib.showContext('boss_menu')
        else
            TriggerServerEvent('Tikoz:Retrograder', GetPlayerServerId(Tikozaal.closestPlayer), ESX.PlayerData.job.name, 0)
            lib.showContext('boss_menu')
        end 
      end
    },
    {
      title = 'virer',
      icon = 'bars',
      onSelect = function() 
        local Tikozaal = {}   
        Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
        if Tikozaal.closestPlayer == -1 or Tikozaal.closestDistance > 3.0 then
             ESX.ShowNotification('Aucun joueur à ~b~proximité')
             lib.showContext('boss_menu')
        else
            TriggerServerEvent('Tikoz:Virer', GetPlayerServerId(Tikozaal.closestPlayer), ESX.PlayerData.job.name, 0)
            lib.showContext('boss_menu')
        end 
      end
    }
  }
})

lib.registerContext({
  id = 'gestion_argent',
  title = 'gestion argent',
  menu = 'boss_menu',
  onBack = function()
    print('Went back!')
  end,
  onExit = function() CreateThread(PositionBossCheck) end,
  options = {
    {
      title = '💶retirer argent',
      icon = 'bars',
      onSelect = function() autoRetraitEntreprise() end
    },
    {
      title = '🖥️deposer argent',
      icon = 'bars',
      onSelect = function() depotargentmechanic() end
    },
    {
      title = '🖥️argent du compte ',
      icon = 'bars',
      onSelect = function() getarententreprise() end
    }
}
})

function getarententreprise()
  ESX.TriggerServerCallback('getSocietyMoney', function(money)
  ESX.ShowNotification('compte ~g~'..money..'$')
  lib.showContext('boss_menu')
  end)
end


function depotargentmechanic()
  local input = lib.inputDialog('DEPO AUTO ECOLE', {
    {type = "number", label = "Montant du depo", min = 1, max = 100000}
  })
    if not input then
        ESX.ShowAdvancedNotification('Banque societé', "~b~auto ecole", "Vous avez pas assez ~r~d'argent", 'CHAR_BANK_FLEECA', 9)
        lib.showContext('boss_menu')
    else
        TriggerServerEvent("autodepotentreprise", input[1])
        lib.showContext('boss_menu')
    end
end

function autoRetraitEntreprise()
  local input = lib.inputDialog('RETRAIT AUTO ECOLE', {
    {type = "number", label = "Montant du retrait", min = 1, max = 100000}
  })
    if not input then
        ESX.ShowAdvancedNotification('Banque societé', "~b~auto ecole", "Vous avez pas assez ~r~d'argent", 'CHAR_BANK_FLEECA', 9)
        lib.showContext('boss_menu')
    else
        TriggerServerEvent("autoRetraitEntreprise", input[1])
        lib.showContext('boss_menu')
    end
end



Citizen.CreateThread(function()
  while true do
      local Timer = 500
      local plyPos = GetEntityCoords(PlayerPedId())
      local dist = #(plyPos-Config.pose.boss)
      if ESX.PlayerData.job.name == Config.JobUtiliser and ESX.PlayerData.job.grade_name == Config.gradejobboss then
      if dist <= 10.0 then
       Timer = 0
       DrawMarker(2, Config.pose.boss, nil, nil, nil, -90, nil, nil,0.3, 0.2, 0.15, 30, 150, 30, 222, false, true, 0, false, false, false, false)
      end
       if dist <= 3.0 then
          Timer = 0
          if IsControlJustPressed(1,51) then
            lib.showContext('boss_menu')
          end
       end
      end
  Citizen.Wait(Timer)
end
end)
---garage

local function OpenMenu()
  local menu = {}
  for k, v in pairs(Vehicle) do 
      menu[#menu+1] = {
          title = v.label,
          description = "sortir "..v.label.."",
          onSelect = function() TriggerServerEvent("testserversideauto", v)  end,
          image = v.image,
      }
  end
  lib.registerContext({
      id = "garage",
      title = "GARAGE AUTO ECOLE",
      options = menu
  })
  lib.showContext('garage')
end

RegisterNetEvent("clientsideauto", function(data)
  local h = GetHashKey(data.name)
  RequestModel(h)
  while not HasModelLoaded(h) do Wait(0) end 
  local car = CreateVehicle(h, Config.pose.spawn, true, false)
  TriggerServerEvent('oliann-addkeys', plate)
  CreateThread(PositionGarageCheckauto)
  SetPedIntoVehicle(PlayerPedId(), car, -1)
  checkrange(car, data)
end)


Citizen.CreateThread(function()
  while true do
      local Timer = 500
      local plyPos = GetEntityCoords(PlayerPedId())
      local dist = #(plyPos-Config.pose.garage)
      if ESX.PlayerData.job.name == Config.JobUtiliser then
      if dist <= 10.0 then
       Timer = 0
       DrawMarker(2, Config.pose.garage, nil, nil, nil, -90, nil, nil,0.3, 0.2, 0.15, 30, 150, 30, 222, false, true, 0, false, false, false, false)
      end
       if dist <= 3.0 then
          Timer = 0
          if IsControlJustPressed(1,51) then
            OpenMenu()
          end
       end
      end
  Citizen.Wait(Timer)
end
end)

-------rangment
function checkrange(car, int)
  CreateThread(function()
      while true do 
          if #(GetEntityCoords(PlayerPedId()) - Config.pose.delete) <= 5 then
              ms = 0 
              ESX.ShowHelpNotification("Appuie sur E pour ranger : ~b~"..int.name)
              if IsControlJustPressed(1, 51) then
                  TriggerServerEvent('oliann-removekeys', plate)
                  local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
                  ESX.Game.DeleteVehicle(car)
                  cansee = false
                  return 
              end
          else ms = 1000 end 
          Wait(ms)
      end
  end)
end

---coffre

CreateThread(function()


  while true do 

      local ped = PlayerPedId()
      local pos = GetEntityCoords(ped)
      local menu = Config.pose.coffre
      local dist = #(pos - menu)

      if dist <= 2 and ESX.PlayerData.job.name == Config.JobUtiliser then

          DrawMarker(2, menu, nil, nil, nil, -90, nil, nil,0.3, 0.2, 0.15, 30, 150, 30, 222, false, true, 0, false, false, false, false)

          if IsControlJustPressed(1,51) then
            exports.ox_inventory:openInventory('stash', {id='coffre_autoecole', owner= false, job = tabac})
          end
      else
          Wait(1000)
      end
      Wait(0)
  end
end)
