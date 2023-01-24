-- Client Callback
RedEM.TriggerClientCallback = function(name, source, cb, ...)
    RedEM.ClientCallbacks[name] = cb
    TriggerClientEvent('RedEM:Client:TriggerClientCallback', source, name, ...)
end

-- Server Callback
RedEM.RegisterCallback = function(name, cb)
    RedEM.ServerCallbacks[name] = cb
end

RedEM.TriggerCallback = function(name, source, cb, ...)
    if not RedEM.ServerCallbacks[name] then return end
    RedEM.ServerCallbacks[name](source, cb, ...)
end

-- Client Callback
RegisterNetEvent('RedEM:Server:TriggerClientCallback', function(name, ...)
    if RedEM.ClientCallbacks[name] then
        RedEM.ClientCallbacks[name](...)
        RedEM.ClientCallbacks[name] = nil
    end
end)

-- Server Callback
RegisterNetEvent('RedEM:Server:TriggerCallback', function(name, ...)
    local src = source
    RedEM.TriggerCallback(name, src, function(...)
        TriggerClientEvent('RedEM:Client:TriggerCallback', src, name, ...)
    end, ...)
end)