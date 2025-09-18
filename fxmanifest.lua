fx_version 'cerulean'
game 'gta5'

description 'pengu_pausemenu'
Author "PenguScripts"
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/main.lua',
}

ui_page 'html/index.html'

files {
  'html/*',
  'html/images/*'
}

escrow_ignore {
    'config.lua',
    'fxmanifest.lua'

}
