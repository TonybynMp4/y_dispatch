fx_version 'cerulean'
game 'gta5'

author 'Tonybyn_Mp4'
description 'Dispatch resource for the Qbox framework'
repository 'https://github.com/TonybynMp4/qbx_dispatch'
version '1.4.0'1

ox_lib 'locale'
shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua'
}

ui_page 'html/index.html'
files {
    'config/client.lua',
    'config/shared.lua',
    'locales/*.json',
    'html/index.html',
    'html/*.css',
    'html/*.js',
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

dependencies {
    'ox_lib',
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
