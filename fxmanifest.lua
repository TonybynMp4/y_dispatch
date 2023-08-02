fx_version 'cerulean'
game 'gta5'

version '1.0.3'

shared_scripts {
    '@qbx-core/import.lua',
    '@ox_lib/init.lua',
    '@qbx-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua',
}

modules {
    'qbx-core:core'
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

dependencies {
    'ox_lib',
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
