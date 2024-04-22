fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'HenkW'
description 'ESX Welcome Script'
version '1.2.4'

dependencies {
    'es_extended',
}

server_script 'version.lua'
client_script 'client.lua'
server_script 'welcome.lua'

ui_page 'welcome.html'

files {
    'welcome.html'
}

shared_script '@es_extended/imports.lua'
