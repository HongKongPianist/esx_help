ESX              = nil
local PlayerData = {}
local blip


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('Request999')
AddEventHandler('Request999', function(id, name, message, loc, inc)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  TriggerServerEvent("chekjob", name, message, loc, inc)
  if pid == myId then
    local coords = GetEntityCoords(GetPlayerPed(-1))
    TriggerEvent('chat:addMessage', "", {20, 255, 239}, " YourCase: [999] | Region:" .. loc .." || Incident: ".. inc .." || Addition: " .. message)
    TriggerServerEvent('esx_help:alertcops', coords.x, coords.y, coords.z)
  end
end)

RegisterNetEvent('Help999ToCops')
AddEventHandler('Help999ToCops', function(id, name, message, loc, inc)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    local coords = GetEntityCoords(GetPlayerPed(-1))
    TriggerEvent('chat:addMessage', "", {20, 255, 239}, " [999] | Region:" .. loc .." || Incident: ".. inc .." || Addition: " .. message)
    TriggerServerEvent('esx_help:alertcops', coords.x, coords.y, coords.z)
  end
end)

RegisterCommand("done", function(source, args, rawCommand)
    local playerPed = PlayerPedId()

	if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
            TriggerEvent('esx_help:removecopblip')
            ESX.ShowAdvancedNotification('EMS Service', '~y~999', 'The Case has been solved', 'CHAR_CHAT_CALL', 3)  
            Citizen.Wait(2500)
        else 
            ESX.ShowAdvancedNotification('EMS', '~y~999', 'You are not EMS', 'CHAR_CHAT_CALL', 3) 
            Citizen.Wait(2500)
        end
end)

RegisterNetEvent('esx_help:removecopblip')
AddEventHandler('esx_help:removecopblip', function()
     RemoveBlip(blip)
end)
  
RegisterNetEvent('esx_help:setcopblip')
AddEventHandler('esx_help:setcopblip', function(cx,cy,cz)
  ESX.ShowAdvancedNotification('EMS Service', '~y~999', 'the location has set for you', 'CHAR_CHAT_CALL', 3)  
    Citizen.Wait(2500)
    RemoveBlip(blip)
      blip = AddBlipForCoord(cx,cy,cz)
      SetBlipSprite(blip , 161)
      SetBlipScale(blipy , 2.0)
      SetBlipColour(blip, 75)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString('help me')
      EndTextCommandSetBlipName(blip)
      table.insert(blip, blip)
      PulseBlip(blip)
end)

