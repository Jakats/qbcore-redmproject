fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'QB-Core'
version '1.0.0'

shared_scripts { 
	'import.lua',
	'config.lua',
	'shared.lua'
}

client_scripts {
	'client/main.lua',
	'client/functions.lua',
	'client/loops.lua',
	'client/events.lua',
	'client/debug.lua'
}

server_scripts {
	'server/main.lua',
	'server/functions.lua',
	'server/loops.lua',
	'server/player.lua',
	'server/events.lua',
	'server/commands.lua',
	'server/debug.lua'
}

ui_page {
	'html/ui.html'
}

lua54 'yes'

files {
	'html/ui.html',
	'html/css/main.css',
	'html/js/app.js'
}

dependencies {
	'progressbar',
	'connectqueue',
	'ghmattimysql'
}
