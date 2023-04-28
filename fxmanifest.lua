fx_version 'cerulean'
game 'gta5'

version '0.0.2'


shared_scripts {
    '@ox_lib/init.lua',
    '@qbx-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua',
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

ui_page 'html/index.html'

files {
    'locales/*.json',
    'html/index.html',
    'html/*.css',
    'html/*.js',
}

lua54 'yes'