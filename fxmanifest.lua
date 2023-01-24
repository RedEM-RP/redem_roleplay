fx_version "adamant"
games {"rdr3"}
version '1.0.0'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_script 'config.lua'

client_scripts {
	'client/cl_main.lua',
	'client/cl_natives.lua',
	'client/cl_functions.lua',
	'client/cl_entities.lua',
	'client/cl_hud.lua',
	'client/cl_callbacks.lua',
	'client/cl_notification.js',
	'client/cl_notification.lua',
	'client/cl_game.lua',
	'client/cl_events.lua',
	'client/cl_cmdsuggestions.lua',
	'client/cl_admin.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/sv_main.lua',
	'server/sv_player.lua',
	'server/sv_entities.lua',
	'server/sv_functions.lua',
	'server/sv_callbacks.lua',
	'server/sv_admin.lua',
}

files{
	'html/ui.html',
	'html/style.css',
	'html/crock.ttf',
}

ui_page 'html/ui.html'

client_exports {
	'RedEM',
	'GetPlayerData',
}

server_exports {
	'RedEM',
}