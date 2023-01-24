-- EXMAPLE USAGE:
--
-- TriggerEvent('redem_roleplay:NotifyLeft', "first text", "second text", "generic_textures", "tick", 4000)
-- TriggerEvent('redem_roleplay:Tip', "your text", 4000)
-- TriggerEvent('redem_roleplay:NotifyTop', "your text", "TOWN_ARMADILLO", 4000)
-- TriggerEvent('redem_roleplay:ShowSimpleRightText', "your text",  4000)
-- TriggerEvent('redem_roleplay:ShowObjective', "your text", 4000)
-- TriggerEvent('redem_roleplay:ShowTopNotification', "your text", "your text", 4000)
-- TriggerEvent('redem_roleplay:ShowAdvancedRightNotification', "your text", "generic_textures" , "tick" , "COLOR_PURE_WHITE", 4000)
-- TriggerEvent('redem_roleplay:ShowBasicTopNotification', "your text", 4000)
-- TriggerEvent('redem_roleplay:ShowSimpleCenterText', "your text", 4000)

RegisterNetEvent('redem_roleplay:NotifyLeft')
AddEventHandler('redem_roleplay:NotifyLeft', function(firsttext, secondtext, dict, icon, duration)
    local _dict = dict
    local _icon = icon
    if not LoadTexture(_dict) then
        _dict = "generic_textures"
        LoadTexture(_dict)
        _icon = "tick"
    end
    exports.redem_roleplay:ShowAdvancedNotification(tostring(firsttext), tostring(secondtext), tostring(_dict), tostring(_icon), tonumber(duration))
end)

RegisterNetEvent('redem_roleplay:Tip')
AddEventHandler('redem_roleplay:Tip', function(text, duration)
    exports.redem_roleplay:ShowTooltip(tostring(text), tonumber(duration))
end)

RegisterNetEvent('redem_roleplay:NotifyTop')
AddEventHandler('redem_roleplay:NotifyTop', function(text, location, duration)
    exports.redem_roleplay:ShowLocationNotification(tostring(text), tostring(location), tonumber(duration))
end)

RegisterNetEvent('redem_roleplay:ShowSimpleRightText')
AddEventHandler('redem_roleplay:ShowSimpleRightText', function(text, duration)
    exports.redem_roleplay:ShowSimpleRightText(tostring(text), tonumber(duration))
end)

RegisterNetEvent('redem_roleplay:ShowObjective')
AddEventHandler('redem_roleplay:ShowObjective', function(text, duration)
    exports.redem_roleplay:ShowObjective(tostring(text), tonumber(duration))
end)

RegisterNetEvent('redem_roleplay:ShowTopNotification')
AddEventHandler('redem_roleplay:ShowTopNotification', function(tittle, subtitle, duration)
    exports.redem_roleplay:ShowTopNotification(tostring(tittle), tostring(subtitle), tonumber(duration))
end)

RegisterNetEvent('redem_roleplay:ShowAdvancedRightNotification')
AddEventHandler('redem_roleplay:ShowAdvancedRightNotification', function(text, dict, icon, text_color, duration)
    local _dict = dict
    local _icon = icon
    if not LoadTexture(_dict) then
        _dict = "generic_textures"
        LoadTexture(_dict)
        _icon = "tick"
    end
    exports.redem_roleplay:ShowAdvancedRightNotification(tostring(text), tostring(_dict), tostring(_icon), tostring(text_color), tonumber(duration))
end)

RegisterNetEvent('redem_roleplay:ShowBasicTopNotification')
AddEventHandler('redem_roleplay:ShowBasicTopNotification', function(text, duration)
    exports.redem_roleplay:ShowBasicTopNotification(tostring(text), tonumber(duration))
end)

RegisterNetEvent('redem_roleplay:ShowSimpleCenterText')
AddEventHandler('redem_roleplay:ShowSimpleCenterText', function(text, duration)
    exports.redem_roleplay:ShowSimpleCenterText(tostring(text), tonumber(duration))
end)

function LoadTexture(dict)
    if Citizen.InvokeNative(0x7332461FC59EB7EC, dict) then
        RequestStreamedTextureDict(dict, true)
        while not HasStreamedTextureDictLoaded(dict) do
            Wait(1)
        end
        return true
    else
        return false
    end
end