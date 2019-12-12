fx_version "adamant"
games {"rdr3"}

client_scripts {
	'config.lua',
	'client/cl_functions.lua',
	'client/cl_main.lua',
	'client/cl_hud.lua',
	'client/cl_gold.lua',
	'client/cl_callback.lua',
	'html/ui.html',
	'html/style.css',
	'html/crock.ttf',
}

server_scripts {
	'server/sv_main.lua',
	'server/sv_player.lua',
	'server/sv_gold.lua',
	'server/sv_groups.lua',
	'server/sv_callback.lua',
	'server/levels.lua',
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
}

files{
'html/ui.html',
'html/style.css',
'html/crock.ttf',
}

ui_page 'html/ui.html'

server_exports {
	'getPlayerFromId',
	'canGroupTarget',
	'playerLoaded',
}