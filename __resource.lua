  resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX_HELP'

version '1.0.0'

client_script {

  'client/main.lua'


}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua'


}


