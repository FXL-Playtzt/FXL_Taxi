RegisterServerEvent('playerSpawned')
AddEventHandler('playerSpawned', function()
    local sourcePlayer = source
    TriggerClientEvent('spawnTaxi', sourcePlayer)
end)
