
local PlayerList = {}
local JoinedList = false
local Group = "user"
local invisible = false
local Spectating = false
local SavedPos = nil
local TargetPed = nil

--------------------------------------------------------------------------------------
--                                       SPECTATE                                   -- 
--------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if Spectating then
            if DoesEntityExist(TargetPed) then
                local coords = GetEntityCoords(TargetPed)
                SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z -3.0)
            end
        end
    end
end)

RegisterNetEvent("redemrp_admin:client:Spectate", function(position, player)
    if not Spectating then
        DoScreenFadeOut(500)
        Wait(500)
        Spectating = true
        SavedPos = GetEntityCoords(PlayerPedId())
        RequestCollisionAtCoord(position.x,position.y,position.z)
        Wait(50)
        SetEntityCollision(PlayerPedId(), false, false)
        SetEntityVisible(PlayerPedId(), false)
        invisible = true
        SetEntityCoords(PlayerPedId(), position.x, position.y, position.z + 4.0)
        SetEntityInvincible(PlayerPedId(), true)
        FreezeEntityPosition(PlayerPedId(), true)
        while not DoesEntityExist(GetPlayerPed(GetPlayerFromServerId(player))) do
            Wait(500)
            print("Waiting for ped to load")
        end
        TargetPed = GetPlayerPed(GetPlayerFromServerId(player))
        Citizen.InvokeNative(0x423DE3854BB50894, true, TargetPed) -- NetworkSetInSpectatorMode
        DoScreenFadeIn(500)
    else
        TriggerEvent("redemrp_admin:client:StopSpectating")
    end
end)

RegisterNetEvent("redemrp_admin:client:StopSpectating", function()
    Spectating = false
    Citizen.InvokeNative(0x423DE3854BB50894, false, TargetPed) -- NetworkSetInSpectatorMode
    DetachEntity(PlayerPedId(), false, true)
    if SavedPos then
        SetEntityCoords(PlayerPedId(), SavedPos)
    end
    SetEntityVisible(PlayerPedId(), false)
    SetEntityInvincible(PlayerPedId(), false)
    invisible = true
    SetEntityCollision(PlayerPedId(), true, true)
    FreezeEntityPosition(PlayerPedId(), false)
end)

--------------------------------------------------------------------------------------
--                                    PED SCALE                                     -- 
--------------------------------------------------------------------------------------

RegisterNetEvent("redemrp_admin:client:SetScale", function(scale)
    SetPedScale(PlayerPedId(), scale)
end)

--------------------------------------------------------------------------------------
--                                    PED MODEL                                     -- 
--------------------------------------------------------------------------------------

RegisterNetEvent("redemrp_skin:client:SetModel", function(model)
    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(100) end
    SetPlayerModel(PlayerId(), model)
    Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
    SetModelAsNoLongerNeeded(model)
end)

--------------------------------------------------------------------------------------
--                                    INVISIBILITY                                  -- 
--------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if invisible then
            SetEntityVisible(PlayerPedId(), false)
        end
    end
end)

RegisterNetEvent("redemrp_admin:client:SetInvis", function()
    if not invisible then
        invisible = true
        SetEntityVisible(PlayerPedId(), false)
    else
        invisible = false
        SetEntityVisible(PlayerPedId(), true)
    end
end)

--------------------------------------------------------------------------------------
--                                 TELEPORT TO MARKER                               -- 
--------------------------------------------------------------------------------------

RegisterNetEvent("redemrp_admin:client:TeleportToMarker", function()
    if IsWaypointActive() then
        local Waypoint = GetWaypointCoords()
        local groundZ = GetHeightmapBottomZForPosition(Waypoint.x, Waypoint.y)
        SetEntityCoords(PlayerPedId(), Waypoint.x, Waypoint.y, groundZ + 3.0)
    end
end)


--------------------------------------------------------------------------------------
--                                DELETE VEHICLE/HORSE                              -- 
--------------------------------------------------------------------------------------
RegisterNetEvent("redemrp_admin:client:DeleteVehicle", function()
    if IsPedSittingInAnyVehicle(PlayerPedId()) then 
        local currentvehicle = GetVehiclePedIsIn(PlayerPedId(),false)
        SetEntityAsMissionEntity(currentvehicle,true,true)
        DeleteVehicle(currentvehicle)
    elseif IsPedOnMount(PlayerPedId()) then
        local currentvehicle = GetMount(PlayerPedId())
        SetEntityAsMissionEntity(currentvehicle, true, true)
        DeleteEntity(currentvehicle)
    end
end)

RegisterNetEvent("redemrp_admin:client:DeleteVehicleAdmin", function()
    if IsPedSittingInAnyVehicle(PlayerPedId()) then 
        local currentvehicle = GetVehiclePedIsIn(PlayerPedId(),false)
        SetEntityAsMissionEntity(currentvehicle,true,true)
        DeleteVehicle(currentvehicle)
    elseif IsPedOnMount(PlayerPedId()) then
        local currentvehicle = GetMount(PlayerPedId())
        SetEntityAsMissionEntity(currentvehicle, true, true)
        DeleteEntity(currentvehicle)
    else
        local playerPos = GetEntityCoords(PlayerPedId())
        local closestvehicle, distance = GetClosestVehicleEx(playerPos)
        if distance < 3.0 then
            NetworkRequestControlOfEntity(closestvehicle)
            SetEntityAsMissionEntity(closestvehicle, true, true)
            DeleteEntity(closestvehicle)
            DeleteVehicle(closestvehicle)
            RedEM.Functions.NotifyRight("Deleted vehicle.", 3000)
        end
    end
end)

GetClosestVehicleEx = function(coords)
	local ped = PlayerPedId()
	local vehicles = GetGamePool('CVehicle')
	local closestDistance = -1
	local closestVehicle  = -1
	local coords = coords or GetEntityCoords(ped)
	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = #(vehicleCoords - coords)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle, closestDistance
end