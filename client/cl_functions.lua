RedEM.Functions = {}

RedEM.Functions.CommaValue = function(amount)
    local formatted = amount
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end

RedEM.Functions.DrawTxt = function(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end

RedEM.Functions.LoadModel = function(model)
    local load_model = model
    if type(model) == "string" then 
        load_model = GetHashKey(model)
    end
    if IsModelValid(load_model) then
        if not HasModelLoaded(load_model) then
            RequestModel(load_model)
            while not HasModelLoaded(load_model) do
                Citizen.Wait(1)
            end
        end
    end
end

RedEM.Functions.LoadAnim = function(dict)
    if DoesAnimDictExist(dict) then
        if not HasAnimDictLoaded(dict) then 
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do 
                Citizen.Wait(1)
            end
        end
	end
end

RedEM.Functions.LoadTexture = function(dict)
    if DoesStreamedTxdExist(dict) then 
        if not HasStreamedTextureDictLoaded(dict) then 
            RequestStreamedTextureDict(dict)
            while not HasStreamedTextureDictLoaded(dict) do 
                Citizen.Wait(1)
            end 
        end
    end
end

RedEM.Functions.RemoveLoaded = function(id, var)
    if id == "model" then 
        SetModelAsNoLongerNeeded(var)
    elseif id == "anim" then 
        RemoveAnimDict(var)
    elseif id == "texture" then 
        SetStreamedTextureDictAsNoLongerNeeded(var)
    end
end

-- Entity Getters
RedEM.Functions.GetVehicles = function()
    return GetGamePool('CVehicle')
end

RedEM.Functions.RedEMs = function()
    return GetGamePool('CObject')
end

RedEM.Functions.GetPeds = function()
    return GetGamePool('CPed')
end

RedEM.Functions.GetPlayers = function()
    return GetActivePlayers()
end

RedEM.Functions.NotifyLeft = function(title, text, texture_dict, texture_name, duration)
    TriggerEvent("redem_roleplay:NotifyLeft", title, text, texture_dict, texture_name, duration)
end

RedEM.Functions.NotifyRight = function(text, duration)
    TriggerEvent("redem_roleplay:NotifyRight", text, duration)
end

RedEM.Functions.GetTownNameAtCoords = function(coords)
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, coords, 1)
    if town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Armadillo") then
        return "Armadillo"
    elseif town_hash == GetHashKey("Blackwater") then
        return "Blackwater"
    elseif town_hash == GetHashKey("BeechersHope") then
        return "BeechersHope"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "Braithwaite"
    elseif town_hash == GetHashKey("Butcher") then
        return "Butcher"
    elseif town_hash == GetHashKey("Caliga") then
        return "Caliga"
    elseif town_hash == GetHashKey("cornwall") then
        return "Cornwall"
    elseif town_hash == GetHashKey("Emerald") then
        return "Emerald"
    elseif town_hash == GetHashKey("lagras") then
        return "lagras"
    elseif town_hash == GetHashKey("Manzanita") then
        return "Manzanita"
    elseif town_hash == GetHashKey("Rhodes") then
        return "Rhodes"
    elseif town_hash == GetHashKey("Siska") then
        return "Siska"
    elseif town_hash == GetHashKey("StDenis") then
        return "Saint Denis"
    elseif town_hash == GetHashKey("Strawberry") then
        return "Strawberry"
    elseif town_hash == GetHashKey("Tumbleweed") then
        return "Tumbleweed"
    elseif town_hash == GetHashKey("valentine") then
        return "Valentine"
    elseif town_hash == GetHashKey("VANHORN") then
        return "Vanhorn"
    elseif town_hash == GetHashKey("Wallace") then
        return "Wallace"
    elseif town_hash == GetHashKey("wapiti") then
        return "Wapiti"
    elseif town_hash == GetHashKey("AguasdulcesFarm") then
        return "Aguasdulces Farm"
    elseif town_hash == GetHashKey("AguasdulcesRuins") then
        return "Aguasdulces Ruins"
    elseif town_hash == GetHashKey("AguasdulcesVilla") then
        return "Aguasdulces Villa"
    elseif town_hash == GetHashKey("Manicato") then
        return "Manicato"
    else
        return "Other place"
    end
end

RedEM.Functions.SetGuarmaWorldhorizonActive = function(toggle)
	Citizen.InvokeNative(0x74E2261D2A66849A, toggle)
end

RedEM.Functions.SetWorldWaterType = function(waterType)
	Citizen.InvokeNative(0xE8770EE02AEE45C2, waterType)
end

RedEM.Functions.SetWorldMapType = function(mapType)
	Citizen.InvokeNative(0xA657EC9DBC6CC900, mapType)
end

RedEM.Functions.IsInGuarma = function()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
	return x >= 0 and y <= -4096
end