fx_version 'cerulean'
game 'gta5'

description 'vRP Bank Robbery System'
dependency "vrp"

version '0.0.1'

server_script { 
	"@vrp/lib/utils.lua",
	"vrp_server.lua",
}

client_script {
	"@vrp/lib/utils.lua",
	'vrp_client.lua',
}

files {
    'client.lua',
}
