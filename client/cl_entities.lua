Entities = {}

LoadModel = function(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        
        Citizen.Wait(1)
    end
end

function SpawnNPC(hash, x, y, z)
    local hash = GetHashKey(hash)
    LoadModel(hash)
    local result = Citizen.InvokeNative(0xD49F9B0955C367DE, hash, x, y, z, 0, 0, 0, 0, Citizen.ResultAsInteger())
    Citizen.InvokeNative(0x1794B4FCC84D812F, result, 1) -- SetEntityVisible
    Citizen.InvokeNative(0x0DF7692B1D9E7BA7, result, 255, false) -- SetEntityAlpha
    Citizen.InvokeNative(0x283978A15512B2FE, result, true) -- Invisible without
    Citizen.InvokeNative(0x4AD96EF928BD4F9A, hash) -- SetModelAsNoLongerNeeded

    return result
end

RegisterNetEvent("redemrp:full_entity_list", function(entities)
    Entities = entities

    for k,v in pairs(entities)do
        if(v.type == "npc")then
            local newNPC = SpawnNPC(v.metadata.hash, v.location.x, v.location.y, v.location.z)

            FreezeEntityPosition(newNPC, true)

            Citizen.CreateThread(function()
                Citizen.Wait(2000)
                SetEntityAsMissionEntity(newNPC, 1, 1)
                DeletePed(newNPC)
                DeleteEntity(newNPC)
            end)
        end
    end
end)

RegisterNetEvent("redemrp:manual_entity_update", function()
    local p_coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("redemrp:request_entities", p_coords.x, p_coords.y)    
end)