Config = {}
-- Distance at which you want to check for a player to show the ID card to
Config.DistanceShowID = 2.5
-- xPlayer variable that stores your player's "identification number" - for us it's identifier, you might store it as 'citizenid' or even 'slot'.
Config.CitizenID = 'identifier' -- if you use 'identifier' you can check this link https://forum.cfx.re/t/sho_identification-a-free-id-card-resource/4024670/20?u=katoteki
-- time in SECONDS to enforce a cooldown between attempts to show your ID card to people around you
Config.ShowIDCooldown = 5 
-- The item you use for your physical currency
Config.MoneyItem = 'money' -- or 'cash' or whatever you use
Config.CustomMugshots = false -- for custom url, you can put your link for img

Config.MugshotScriptName = "MugShotBase64" -- mugshot or MugShotBase64

Config.MugshotsBase64 = true -- Set this to true for MugShotBase64 or false for normal mugshot


Config.IdentificationData = {	
	police = {    		
		identification = {  
				[1]  = {
					label = "ID Card",
					item = 'identification',
					cost = 1000,
				},    			
				[2]  = {
						label = "Drivers License",
						item = 'drivers_license',
						cost = 2500,  
				},
				[3]  = {
						label = "Level 1 Firearms License",
						item = 'firearms_license',
						cost = 10000,
				},
				[4]  = {
					label = "Police License",
					item = 'police_license',
					cost = 5000,
				},
				[5]  = {
					label = "EMS License",
					item = 'ems_license',
					cost = 5000,
				},
				[6]  = {
					label = "Mechanic License",
					item = 'mechanic_license',
					cost = 5000,
				},

			},
	},   
	
}
--- NPC STUFF
Config.Invincible = false
Config.Frozen = true
Config.Stoic = true
Config.FadeIn = true
Config.DistanceSpawn = 5.0
Config.MinusOne = true

Config.GenderNumbers = {
	['male'] = 4,
	['female'] = 5
}

Config.NPCList = {

	{
		model = `cs_movpremmale`,
		coords = vector4(243.31, -1092.31, 29.29, 355.01), 
		gender = 'male',
	}
}

Config.EnableLicenseBlip = false
Config.LicenseBlipName = "License Issuer"

--Coordinates for License Issuer
Config.LicenseLocation = {
    Loc = {
        LicenseLocation = {
            vector3(243.31, -1092.31, 29.293)
        }
    }
}
