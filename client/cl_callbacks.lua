-- Client Callback
RedEM.CreateClientCallback = function(name, cb)
    RedEM.ClientCallbacks[name] = cb
end

RedEM.TriggerClientCallback = function(name, cb, ...)
    if not RedEM.ClientCallbacks[name] then return end
    RedEM.ClientCallbacks[name](cb, ...)
end

-- Server Callback
RedEM.TriggerCallback = function(name, cb, ...)
    RedEM.ServerCallbacks[name] = cb
    TriggerServerEvent('RedEM:Server:TriggerCallback', name, ...)
end

-- Client Callback
RegisterNetEvent('RedEM:Client:TriggerClientCallback', function(name, ...)
    RedEM.TriggerClientCallback(name, function(...)
        TriggerServerEvent('RedEM:Server:TriggerClientCallback', name, ...)
    end, ...)
end)

-- Server Callback
RegisterNetEvent('RedEM:Client:TriggerCallback', function(name, ...)
    if RedEM.ServerCallbacks[name] then
        RedEM.ServerCallbacks[name](...)
        RedEM.ServerCallbacks[name] = nil
    end
end)