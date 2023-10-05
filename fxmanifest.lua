fx_version 'cerulean'
game 'gta5'

author 'Tonybyn_Mp4'
description 'Dispatch resource for the Qbox framework'
version '1.1.0'

shared_scripts {
    "@qbx_core/import.lua",
    '@ox_lib/init.lua',
    '@qbx_core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua',
}

modules {
    "qbx_core:client:playerdata"
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