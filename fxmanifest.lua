fx_version "adamant"
games {"rdr3"}
version '1.1.0'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
	'config.lua',
	'client/*.lua',
	'html/ui.html',
	'html/*.css',
	'html/*.ttf',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/*.lua'
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
