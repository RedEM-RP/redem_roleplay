--                                     Licensed under                                     --
-- Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License --

--print("LUA: " .. "Version: " .. _VERSION .. " LOADED!")

local firstSpawn = false

function printClient(message)
    print("RedEM_Roleplay: " .. message)
end

Citizen.CreateThread(function()
    while firstSpawn == false do
        local spawned = Citizen.InvokeNative(0xB8DFD30D6973E135 --[[NetworkIsPlayerActive]], PlayerPedId(), Citizen.ResultAsInteger())
        if spawned then
            TriggerEvent("redem:setDrawUI", false)
            firstSpawn = true
        end
    end
end)

function enablePvP()
    if Config.pvp == 1 then
        Citizen.InvokeNative(0xF808475FA571D823, true) --enable friendly fire
        NetworkSetFriendlyFireOption(true)
        SetRelationshipBetweenGroups(5, `PLAYER`, `PLAYER`)
    end
end

AddEventHandler("redemrp_respawn:respawn", function()
    enablePvP()
end)

AddEventHandler("playerSpawned", function()
    enablePvP()
end)

AddEventHandler("onClientResourceStart", function() -- Reveal whole map on spawn and enable pvp
    if Config.RevealMap == 1 then
        Citizen.InvokeNative(0x4B8F743A4A6D2FF8, true)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DrawCoords()
        DisableControlAction(0, 0x580C4473, true)
        DisableControlAction(0, 0xCF8A4ECA, true)
    end
end)
    
function DrawCoords()
    if Config.Coords == 1 then
        local ent = PlayerPedId()
        local pp = GetEntityCoords(ent)
        local hd = GetEntityHeading(ent)
        DrawTxt("x = " .. tonumber(string.format("%.2f", pp.x)) .. " y = " .. tonumber(string.format("%.2f", pp.y)) .. " z = " .. tonumber(string.format("%.2f", pp.z)) .. " | H: " .. tonumber(string.format("%.2f", hd)), 0.01, 0.0, 0.4, 0.4, true, 255, 255, 255, 150, false)
    end
end


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end
    
function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end


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
--724057703319601175

SetDiscordAppId(724057703319601175)
