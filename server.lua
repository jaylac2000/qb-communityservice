QBCore = exports['qb-core']:GetCoreObject()
-- Commands

QBCore.Commands.Add('comserv', 'Send To Community Service', {{name='id', help='Target ID'}, {name='amount', help='Action Amount'}}, true, function(source, args)
    local src = source
    local target = tonumber(args[1])
    local targetPlayer = GetPlayerPed(target)
    local amount = tonumber(args[2])
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" then
        if targetPlayer ~= 0 then
            if amount > 0 then
                TriggerEvent('qb-communityservice:server:sendToCommunityService', target, amount)
                TriggerClientEvent('QBCore:Notify', source, 'This citizen has been sentenced to community service!', 'success')
                TriggerClientEvent('QBCore:Notify', target, 'You Have Been Sentenced To '..amount.. ' Month(s) of Community Service')
            else
                TriggerClientEvent('QBCore:Notify', source, 'Invalid amount of months', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'Invalid citizen ID', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You are not a police officer', 'error')
    end
end, 'admin')

QBCore.Commands.Add('endcomserv', 'End Community Service', {{name='id', help='Target ID'}}, true, function(source, args)
    local src = source
    local target = tonumber(args[1])
    local targetPlayer = GetPlayerPed(target)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" then
        if targetPlayer ~= 0 then
            Release(target)
        else
            TriggerClientEvent('QBCore:Notify', source, 'Invalid citizen ID', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You are not a police officer', 'error')
    end
end, 'admin')

RegisterServerEvent('qb-communityservice:server:finishCommunityService')
AddEventHandler('qb-communityservice:server:finishCommunityService', function(source)
    local src = source
	Release(src)
end)

-- Events

RegisterServerEvent('qb-communityservice:server:checkIfSentenced')
AddEventHandler('qb-communityservice:server:checkIfSentenced', function()
    local src = source
    local citizenid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    local result = exports.oxmysql:fetchSync('SELECT * FROM communityservice WHERE citizenid = ?', {citizenid})
    if result[1] ~= nil and result[1].actions_remaining > 0 then
        TriggerClientEvent('qb-communityservice:client:inCommunityService', src, tonumber(result[1].actions_remaining))
    end
end)

RegisterServerEvent('qb-communityservice:server:completeService')
AddEventHandler('qb-communityservice:server:completeService', function()
    local src = source
    local citizenid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    MySQL.Async.execute('UPDATE communityservice SET actions_remaining = actions_remaining - 1 WHERE citizenid = ?', {citizenid})
end)

RegisterServerEvent('qb-communityservice:server:extendService')
AddEventHandler('qb-communityservice:server:extendService', function()
    local src = source
    local citizenid = QBCore.Functions.GetPlayer(src).PlayerData.citizenid
    MySQL.Async.execute('UPDATE communityservice SET actions_remaining = actions_remaining + @extension_value WHERE citizenid = ?', {citizenid, Config.ServiceExtensionOnEscape})
end)

RegisterServerEvent('qb-communityservice:server:sendToCommunityService')
AddEventHandler('qb-communityservice:server:sendToCommunityService', function(target, actions_count)
    local Ply = QBCore.Functions.GetPlayer(target)
    local citizenid = Ply.PlayerData.citizenid
    
    exports.oxmysql:insert('INSERT INTO communityservice (citizenid, actions_remaining) VALUES (?, ?) ON DUPLICATE KEY UPDATE actions_remaining = ?', {citizenid, actions_count})
    TriggerClientEvent('qb-communityservice:client:inCommunityService', target, actions_count)
end)

-- Functions

function Release(target)
    local Ply = QBCore.Functions.GetPlayer(target)
    local citizenid = Ply.PlayerData.citizenid

    MySQL.Async.execute('DELETE FROM communityservice WHERE citizenid = ?', {citizenid})
    TriggerClientEvent('QBCore:Notify', target, 'Community service completed', 'success')
    TriggerClientEvent('qb-communityservice:client:finishCommunityService', target)
end