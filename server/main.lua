ESX = nil
local copblip
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			name = identity['name'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height'],
			job = identity['job'],
			group = identity['group']
		}
	else
		return nil
	end
end

RegisterServerEvent('chekjob')
AddEventHandler('chekjob', function(n, m, l, i)
	local id = source
	local emprego = getIdentity(id)
	if emprego.job == 'police' or emprego.job == 'ambulance' then
    TriggerClientEvent("Help999ToCops", -1, source, n, m, l, i)
    end
end)

AddEventHandler('chat:addMessage', function(source, color, msg)
	cm = stringsplit(msg, " ")
    if cm[1] == "/999" then
		CancelEvent()
		if tablelength(cm) == 3 then
			local location = tostring(cm[2])
			local incident = tostring(cm[3])
			local names3 = GetPlayerName(source)
			local textmsg = "No description"
		    TriggerClientEvent("Request999", -1, source, names1, textmsg, location, incident)
		elseif tablelength(cm) > 3 then
		    local location = tostring(cm[2])
			local incident = tostring(cm[3])
			local names3 = GetPlayerName(source)
			local textmsg = ""
			for i=1, #cm do
				if i ~= 1 and i ~= 2 and i ~= 3 then
					textmsg = (textmsg .. " " .. tostring(cm[i]))
				end
			end
            TriggerClientEvent("Request999", -1, source, names1, textmsg, location, incident)
		elseif tablelength(cm) < 2 then
		    TriggerClientEvent('chatMessage', source, "[EMS Service] Couldn't Contact, Please use:", {255, 0, 0}, "/999 [Region] [Incident] [Addition]")
		end
	end	
	
end)

  
  
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end



function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

RegisterServerEvent('esx_help:alertcops')
AddEventHandler('esx_help:alertcops', function(cx,cy,cz)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
			TriggerClientEvent('esx_help:setcopblip', xPlayers[i], cx,cy,cz)
		end
	end
end)

RegisterServerEvent('esx_help:stopalertcops')
AddEventHandler('esx_help:stopalertcops', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
			TriggerClientEvent('esx_help:removecopblip', xPlayers[i])
		end
	end
end)

