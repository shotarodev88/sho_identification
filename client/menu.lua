-- This file manages the main menu parts of the code. 
-- I separated it here becuase it relies on nh-context and nh-keyboard and you may wish to replace it with your own method, maybe using ESX Menu Default? 



-- The event called by the qtarget to open the menu
RegisterNetEvent('sho_identification:requestLicense')
AddEventHandler('sho_identification:requestLicense',function()
	local options = {}		
	for k,v in pairs(Config.IdentificationData) do	
	
		for kk,v in pairs(v.identification) do
			--if ESX.PlayerData.job.name == k then
			  options[kk] = {
					title = v.label,
					description = v.label .. ' $ '  ..v.cost,
					event = 'sho_identification:applyForLicense',
					arrow = true,
					args = {item = v.item}
				}
			--end
		end
	end
	
	    lib.registerContext({
        id = 'open_identification',
        title = 'Open Identification',
        options = options
    })
    lib.showContext('open_identification')

	
end)


-- the event that handles applying for license
RegisterNetEvent('sho_identification:applyForLicense')
AddEventHandler('sho_identification:applyForLicense',function(data)
	local identificationData = nil
	local mugshotURL = nil

	-- Loop through identificationdata and match item and set a variable for future use
	for k,v in pairs(Config.IdentificationData) do 
		for kk,v in pairs(v.identification) do
			if v.item == data.item then 
				identificationData = v
				break
			end
		end
	end

	if Config.CustomMugshots then 
		local data = exports.ox_inventory:Keyboard('Custom Mugshot URL (Leave blank for default)', {'Direct Image URL (link foto)'})
	
		if data then
			mugshotURL = data[1]
		else
			--print('No value was entered into the field!')
		end
	else
		if Config.MugshotsBase64 then
			mugshotURL = exports[Config.MugshotScriptName]:GetMugShotBase64(PlayerPedId(), false)
		else
			local p = promise.new() -- Make sure we wait for the mugshot is created
			exports[Config.MugshotScriptName]:getMugshotUrl(PlayerPedId(), function(url)
				mugshotURL = url
				p:resolve()
			end)
			Citizen.Await(p)		
		end
	end 
	TriggerServerEvent('sho_identification:server:payForLicense',identificationData,mugshotURL)
end)
