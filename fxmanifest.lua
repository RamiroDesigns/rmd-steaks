fx_version 'cerulean'
game 'gta5'

description 'RMD-Steaks'
version '1.0.0'

shared_script 'config.lua'
server_script 'server/*.lua'
client_script 'client/*.lua'

dependencies {
    'qb-core',
    'qb-target'
}