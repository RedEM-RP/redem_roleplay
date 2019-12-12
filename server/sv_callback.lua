RegisterServerEvent('xrp:callback')
AddEventHandler('xrp:callback', function(id, name, data, cb)
    local _source = source
    TriggerEvent(name, data, function(cb)
        TriggerClientEvent('xrp:callbackReturn', _source, id, cb)
    end)
end)