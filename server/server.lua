-- Server event to call open identification card on valid players
RegisterServerEvent('sho_identification:server:showID')
AddEventHandler('sho_identification:server:showID', function(item, players)
	if #players > 0 then 
		for _,player in pairs(players) do 
			TriggerClientEvent('sho_identification:openID', player, item)
		end 
	end 
end)

-- Creating the card using item metadata.
RegisterServerEvent('sho_identification:createCard')
AddEventHandler('sho_identification:createCard', function(source,url,type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local card_metadata = {}
	card_metadata.type = xPlayer.name
	if type == 'police_license' then
		card_metadata.citizenid = xPlayer[Config.CitizenID]:sub(-4)..' | LEO'
	elseif type == 'ems_license' then
		card_metadata.citizenid = xPlayer[Config.CitizenID]:sub(-4)..' | MED'
	elseif type == 'mechanic_license' then
		card_metadata.citizenid = xPlayer[Config.CitizenID]:sub(-4)..' | MECH'
	elseif type == 'drivers_license' then
		card_metadata.citizenid = xPlayer[Config.CitizenID]:sub(-4)..' | DRIVE'
	else
		card_metadata.citizenid = xPlayer[Config.CitizenID]:sub(-7)..' | ID'
	end
	
	card_metadata.firstName = xPlayer.variables.firstName
	card_metadata.lastName = xPlayer.variables.lastName
	card_metadata.dateofbirth = xPlayer.variables.dateofbirth
	card_metadata.sex = xPlayer.variables.sex
	card_metadata.height = xPlayer.variables.height
	card_metadata.mugshoturl = url
	card_metadata.cardtype = type
	local curtime = os.time(os.date("!*t"))
	local diftime = curtime + 2629746
	card_metadata.issuedon = os.date('%m / %d / %Y',curtime)
	card_metadata.expireson = os.date('%m / %d / %Y', diftime)
	if type == "identification" then 
		--print("Type is identification")
		local sex, identifier = xPlayer.variables.sex
		if sex == 'm' then sex = 'male' elseif sex == 'f' then sex = 'female' end
		card_metadata.description = ('Sex: %s | DOB: %s'):format( sex, xPlayer.variables.dateofbirth )
	elseif type == "drivers_license" then 
		MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = xPlayer.identifier},
		function (licenses)
			for i=1, #licenses, 1 do
				if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' then
					card_metadata.licenses = licenses
				end
			end
		end)
		TriggerEvent('esx_license:addLicense', source, 'drive', function()
		end)
	elseif type == "firearms_license" then 
		MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = xPlayer.identifier},
		function (licenses)
			for i=1, #licenses, 1 do
				if licenses[i].type == 'weapon' then
					card_metadata.licenses = licenses
				end
			end
		end)
			TriggerEvent('esx_license:addLicense', source, 'weapon', function()
			end)
		elseif type == "police_license" then 
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = xPlayer.identifier},
			function (licenses)
				for i=1, #licenses, 1 do
					if licenses[i].type == 'police' then
						card_metadata.licenses = licenses
					end
				end
			end)
				TriggerEvent('esx_license:addLicense', source, 'police', function()
				end)
	elseif type == "ems_license" then 
		MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = xPlayer.identifier},
		function (licenses)
			for i=1, #licenses, 1 do
				if licenses[i].type == 'ems' then
					card_metadata.licenses = licenses
				end
			end
		end)
			TriggerEvent('esx_license:addLicense', source, 'ems', function()
			end)
	elseif type == "police_license" then 
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = xPlayer.identifier},
			function (licenses)
				for i=1, #licenses, 1 do
					if licenses[i].type == 'ems' then
						card_metadata.licenses = licenses
					end
				end
			end)
				TriggerEvent('esx_license:addLicense', source, 'ems', function()
				end)
	end
	xPlayer.addInventoryItem(type, 1, card_metadata)
end)

-- Server event to call open identification card on valid players
RegisterServerEvent('sho_identification:server:payForLicense')
AddEventHandler('sho_identification:server:payForLicense', function(identificationData,mugshotURL)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() < identificationData.cost then
		return xPlayer.showNotification("You can't afford this license.")
	end
	xPlayer.removeMoney(identificationData.cost)
	TriggerEvent('sho_identification:createCard',_source,mugshotURL,identificationData.item)
end)
