RegisterServerEvent('redemrp:callback')
AddEventHandler('redemrp:callback', function(id, name, data, cb)
    local _source = source
    TriggerEvent(name, data, function(cb)
        TriggerClientEvent('redemrp:callbackReturn', _source, id, cb)
    end)
end)