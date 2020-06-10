fx_version "adamant"
games {"rdr3"}
version '1.1.0'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
	'config.lua',
	'client/cl_functions.lua',
	'client/cl_main.lua',
	'client/cl_entities.lua',
	'client/cl_hud.lua',
	'client/cl_callback.lua',
	'client/cl_notification.js',
	'client/cl_notification.lua',
	'html/ui.html',
	'html/style.css',
	'html/crock.ttf',
}

server_scripts {
	'config.lua',
	'server/metrics.lua',
	'server/sv_main.lua',
	'server/sv_player.lua',
	'server/sv_entities.lua',
	'server/sv_gold.lua',
	'server/sv_groups.lua',
	'server/sv_callback.lua',
	'server/levels.lua',
	'server/sv_economy.lua',
	'@mysql-async/lib/MySQL.lua',
	'server/sv_db.lua',
}

files{
	'html/ui.html',
	'html/style.css',
	'html/crock.ttf',
}

ui_page 'html/ui.html'

server_exports {
	'getPlayerFromId',
	'playerLoaded',
}