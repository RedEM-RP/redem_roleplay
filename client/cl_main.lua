RedEM = {}
RedEM.Version = Config.Version
RedEM.PlayerData = {}
RedEM.ClientCallbacks = {}
RedEM.ServerCallbacks = {}
RedEM.FirstSpawn = false
RedEM.PVPEnabled = false

exports("RedEM", function()
    return RedEM
end)

exports('GetPlayerData', function()
    return RedEM.PlayerData
end)

RedEM.GetPlayerData = function()
    return RedEM.PlayerData
end

RegisterNetEvent("redemrp:receivePlayerData", function(data)
    RedEM.PlayerData = data
end)

AddEventHandler("redemrp_respawn:respawn", function()
    enablePvP()
end)

AddEventHandler("playerSpawned", function()
    enablePvP()
end)

function enablePvP()
    Citizen.InvokeNative(0xF808475FA571D823, true) --enable friendly fire
    NetworkSetFriendlyFireOption(true)
    SetRelationshipBetweenGroups(5, `PLAYER`, `PLAYER`)
    RedEM.PVPEnabled = true
end

AddEventHandler("onClientResourceStart", function()
    Citizen.InvokeNative(0x4B8F743A4A6D2FF8, true) -- Reveal whole map
end)

Citizen.CreateThread(function()
    while RedEM.FirstSpawn == false do
        local spawned = Citizen.InvokeNative(0xB8DFD30D6973E135 --[[NetworkIsPlayerActive]], PlayerPedId(), Citizen.ResultAsInteger())
        if spawned then
            TriggerEvent("redem:setDrawUI", false)
            RedEM.FirstSpawn = true
        end
    end
end)

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
        DisableControlAction(0, 0x580C4473, true)
        DisableControlAction(0, 0xCF8A4ECA, true)
    end
end)

Citizen.CreateThread(function()
    local active = false
    local timer = 0
    while true do 
        Wait(0)
        if IsControlJustPressed(0,0x4AF4D473) then -- DEL KEY
            timer = 0
            active = true
            while  timer < 200 do 
                Wait(0)
                timer = timer + 1
                SetRelationshipBetweenGroups(1, `PLAYER`, `PLAYER`)
            end
            
            active = false
        end
        if active == false and not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            SetRelationshipBetweenGroups(5, `PLAYER`, `PLAYER`)
        end	
    end
end)