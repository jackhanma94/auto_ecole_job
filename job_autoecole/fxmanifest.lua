fx_version('cerulean')
games({ 'gta5' })
lua54 'yes'
shared_script {"@es_extended/imports.lua","@ox_lib/init.lua", "config.lua"}
server_scripts({
    "server.lua"
});

client_scripts({
    "client.lua"
});