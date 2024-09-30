fx_version 'cerulean'
game 'gta5'

author 'Tonybyn_Mp4'
description 'Dispatch resource for the Qbox framework'
repository 'https://github.com/TonybynMp4/y_dispatch'
version '1.5.3'

ox_lib 'locale'
shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
    'types.lua',
}

ui_page 'web/build/index.html'

files {
    'web/build/index.html',
    'web/build/assets/*.js',
    'web/build/assets/*.css',
    'config/client.lua',
    'config/shared.lua',
    'locales/*.json',
}

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'client/*.lua',
    'client/nui/*.lua',
}

server_scripts {
    'server/exports/*.lua',
    'server/*.lua'
}

dependencies {
    'ox_lib',
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
