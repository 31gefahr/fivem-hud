fx_version 'cerulean'
game 'gta5'

description 'Vural HUD - Optimized'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/img/*.png'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}
lua_singleton 'yes'