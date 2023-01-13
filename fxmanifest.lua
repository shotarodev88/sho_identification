fx_version 'cerulean'

name 'sho_identification'
description 'Identification cards script built to work with linden_inventory'
game 'gta5'
lua54 'yes'
author 'Noms'



ui_page 'html/index.html'


dependencies {
	'es_extended',
	'oxmysql'
}

shared_scripts {
    
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
	'config.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/*.lua'
}

client_scripts {
	'client/*.lua'
}

files {
	'html/index.html',
	'html/assets/css/*.css',
	'html/assets/js/*.js',
	'html/assets/fonts/roboto/*.woff',
	'html/assets/fonts/roboto/*.woff2',
	'html/assets/fonts/justsignature/JustSignature.woff',
	'html/assets/images/*.png'
}
