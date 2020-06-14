fx_version 'adamant'

game 'gta5'

ui_page 'html/index.html'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_script 'client.lua'

files {
	'html/assets/images/plate.png',
	'html/index.html',
	'html/assets/fonts/roboto/Roboto-Bold.woff',
	'html/assets/css/style.css',
	'html/assets/js/jquery.js',
	'html/assets/js/init.js'
}
