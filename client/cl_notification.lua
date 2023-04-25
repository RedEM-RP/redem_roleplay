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


function bigInt(text)
    local string1 =  DataView.ArrayBuffer(16)
    string1:SetInt64(0,text)
	return string1:GetInt64(0)
end

exports("ShowTooltip",function(text, duration)
    local string = CreateVarString(10, "LITERAL_STRING", text)
    local Var0 = DataView.ArrayBuffer(8*7)
    local Var13 = DataView.ArrayBuffer(8*3)
    Var0:SetUint32(8*0,duration)
    Var0:SetInt32(8*1,0)
    Var0:SetInt32(8*2,0)
    Var0:SetInt32(8*3,0)	
    -- struct1.setBigInt64(8, BigInt(sound_dict), true); -- Notification sound optional
    -- struct1.setBigInt64(16, BigInt(sound), true);	
    Var13:SetUint64(8*1,bigInt(string))
    Citizen.InvokeNative(0x049D5C615BD38BAD,Var0:Buffer(),Var13:Buffer(),1)
end)

exports("ShowAdvancedNotification",function(title, subTitle, dict, icon, duration, color)	
    local struct1 = DataView.ArrayBuffer(8*7)
    local struct2 = DataView.ArrayBuffer(8*8)
	struct1:SetInt32(8*0,duration)
	--struct1:SetInt64(8*1,bigInt(sound_dict))
	--struct1:SetInt64(8*2,bigInt(sound))
    local string1 = CreateVarString(10, "LITERAL_STRING", title)
    local string2 = CreateVarString(10, "LITERAL_STRING", subTitle)
	struct2:SetInt64(8*1,bigInt(string1))
	struct2:SetInt64(8*2,bigInt(string2))
	struct2:SetInt32(8*3,0)
	struct2:SetInt64(8*4,bigInt(GetHashKey(dict)))
	struct2:SetInt64(8*5,bigInt(GetHashKey(icon)))
	struct2:SetInt64(8*6,bigInt(GetHashKey(color or "COLOR_WHITE")))	
    Citizen.InvokeNative(0x26E87218390E6729,struct1:Buffer(),struct2:Buffer(),1,1)
end)

exports("ShowLocationNotification",function(text, location, duration)
    local string1 = CreateVarString(10, "LITERAL_STRING", location)
    local string2 = CreateVarString(10, "LITERAL_STRING", text)
    local struct1 = DataView.ArrayBuffer(8*7)
    local struct2 = DataView.ArrayBuffer(8*5)
	struct1:SetInt32(8*0,duration)
	--struct1:SetInt64(8*1,bigInt(sound_dict))
	--struct1:SetInt64(8*2,bigInt(sound))
	struct2:SetInt64(8*1,bigInt(string1))
	struct2:SetInt64(8*2,bigInt(string2))	
	
    Citizen.InvokeNative(0xD05590C1AB38F068,struct1:Buffer(),struct2:Buffer(),0,1)
end)

exports("ShowSimpleRightText",function(text, duration)
    local string1 = CreateVarString(10, "LITERAL_STRING", text)
	
    local struct1 = DataView.ArrayBuffer(8*7)
    local struct2 = DataView.ArrayBuffer(8*3)
	struct1:SetInt32(8*0,duration)
	--struct1:SetInt64(8*1,bigInt(sound_dict))
	--struct1:SetInt64(8*2,bigInt(sound))
	struct2:SetInt64(8*1,bigInt(string1))
	
    Citizen.InvokeNative(0xB2920B9760F0F36B,struct1:Buffer(),struct2:Buffer(),1)
end)

exports("ShowObjective",function(text, duration)
	Citizen.InvokeNative("0xDD1232B332CBB9E7", 3, 1, 0)
    local string1 = CreateVarString(10, "LITERAL_STRING", text)	
    local struct1 = DataView.ArrayBuffer(8*7)
    local struct2 = DataView.ArrayBuffer(8*3)
	struct1:SetInt32(8*0,duration)
	--struct1:SetInt64(8*1,bigInt(sound_dict))
	--struct1:SetInt64(8*2,bigInt(sound))
	struct2:SetInt64(8*1,bigInt(string1))
	
    Citizen.InvokeNative(0xCEDBF17EFCC0E4A4,struct1:Buffer(),struct2:Buffer(),1)
end)

exports("ShowTopNotification",function(title, subtext, duration)
    local struct1 = DataView.ArrayBuffer(8*7)
	struct1:SetInt32(8*0,duration)
	--struct1:SetInt64(8*1,bigInt(sound_dict))
	--struct1:SetInt64(8*2,bigInt(sound))	
    local string1 = CreateVarString(10, "LITERAL_STRING", title)	
    local string2 = CreateVarString(10, "LITERAL_STRING", subtext)	
    local struct2 = DataView.ArrayBuffer(8*7)	
	struct2:SetInt64(8*1,bigInt(string1))
	struct2:SetInt64(8*2,bigInt(string2))	
    Citizen.InvokeNative(0xA6F4216AB10EB08E,struct1:Buffer(),struct2:Buffer(),1,1)
end)

exports("ShowAdvancedRightNotification",function(_text, _dict, icon, text_color, duration, quality)
    local text = CreateVarString(10, "LITERAL_STRING", _text)
    local dict = CreateVarString(10, "LITERAL_STRING", _dict)
    local sdict = CreateVarString(10, "LITERAL_STRING", "Transaction_Feed_Sounds")
    local sound = CreateVarString(10, "LITERAL_STRING", "Transaction_Positive")	
	
    local struct1 = DataView.ArrayBuffer(8*7)
	struct1:SetInt32(8*0,duration)
	struct1:SetInt64(8*1,bigInt(sdict))
	struct1:SetInt64(8*2,bigInt(sound))	
	
    local struct2 = DataView.ArrayBuffer(8*10)	
	struct2:SetInt64(8*1,bigInt(text))	
	struct2:SetInt64(8*2,bigInt(dict))
	struct2:SetInt64(8*3,bigInt(GetHashKey(icon)))	
	struct2:SetInt64(8*5,bigInt(GetHashKey(text_color or "COLOR_WHITE")))	
	struct2:SetInt32(8*6,quality or 1)	
	
    Citizen.InvokeNative(0xB249EBCB30DD88E0,struct1:Buffer(),struct2:Buffer(),1)
end)

exports("ShowBasicTopNotification",function(text, duration)
    local struct1 = DataView.ArrayBuffer(8*7)
	struct1:SetInt32(8*0,duration)
	--struct1:SetInt64(8*1,bigInt(sound_dict))
	--struct1:SetInt64(8*2,bigInt(sound))	
    local string1 = CreateVarString(10, "LITERAL_STRING", text)	
    local struct2 = DataView.ArrayBuffer(8*7)	
	struct2:SetInt64(8*1,bigInt(string1))	
    Citizen.InvokeNative(0x860DDFE97CC94DF0,struct1:Buffer(),struct2:Buffer(),1)
end)

exports("ShowSimpleCenterText",function(text, duration, text_color)
    local struct1 = DataView.ArrayBuffer(8*7)
	struct1:SetInt32(8*0,duration)
	--struct1:SetInt64(8*1,bigInt(sound_dict))
	--struct1:SetInt64(8*2,bigInt(sound))	
    local string1 = CreateVarString(10, "LITERAL_STRING", text)	
    local struct2 = DataView.ArrayBuffer(8*4)	
	struct2:SetInt64(8*1,bigInt(string1))	
	struct2:SetInt64(8*2,bigInt(GetHashKey(text_color or "COLOR_PURE_WHITE")))	
    Citizen.InvokeNative(0x893128CDB4B81FBB,struct1:Buffer(),struct2:Buffer(),1)
end)

exports("showNotification",function(text, duration)
    local struct1 = DataView.ArrayBuffer(8*3)
	struct1:SetInt32(8*0,duration)
	--struct1:SetInt64(8*1,bigInt(sound_dict))
	--struct1:SetInt64(8*2,bigInt(sound))	
    local string1 = CreateVarString(10, "LITERAL_STRING", text)
	local struct2 = DataView.ArrayBuffer(8*6)	
	struct2:SetInt64(8*1,bigInt(string1))	
	struct2:SetInt64(8*2,bigInt(string1))
    Citizen.InvokeNative(0xC927890AA64E9661,struct1:Buffer(),struct2:Buffer(),1,1)
end)

exports("showBottomRight",function(text, duration)
    local struct1 = DataView.ArrayBuffer(8*7)
	struct1:SetInt32(8*0,duration)
	--struct1:SetInt64(8*1,bigInt(sound_dict))
	--struct1:SetInt64(8*2,bigInt(sound))	
    local string1 = CreateVarString(10, "LITERAL_STRING", text)
    local struct2 = DataView.ArrayBuffer(8*5)	
	struct2:SetInt64(8*1,bigInt(string1))
    Citizen.InvokeNative(0x2024F4F333095FB1,struct1:Buffer(),struct2:Buffer(),1)
end)

exports("failmissionnotif",function(title,subTitle, duration)
	local title = CreateVarString(10, "LITERAL_STRING", title)
	local msg = CreateVarString(10, "LITERAL_STRING", subTitle)
	local duration = tonumber(duration)
	local struct1 = DataView.ArrayBuffer(8*5)
	local struct2 = DataView.ArrayBuffer(8*9)
	struct2:SetInt64(8*1,bigInt(title))
	struct2:SetInt64(8*2,bigInt(msg))
	local msgId = Citizen.InvokeNative(0x9F2CC2439A04E7BA,struct1:Buffer(),struct2:Buffer(),1)
	Wait(duration)
	Citizen.InvokeNative(0x00A15B94CBA4F76F,msgId)
end)

exports("deadplayernotif",function(title,_audioRef,_audioName, duration)
    local title = CreateVarString(10, "LITERAL_STRING", title)
    local audioRef = CreateVarString(10, "LITERAL_STRING", _audioRef)
    local audioName = CreateVarString(10, "LITERAL_STRING", _audioName)
	local struct1 = DataView.ArrayBuffer(8*5)
    local struct2 = DataView.ArrayBuffer(8*9)
	struct1:SetInt64(8*0,bigInt(audioRef))
	struct1:SetInt64(8*1,bigInt(audioName))
	struct1:SetInt16(8*2,4)
	struct2:SetInt64(8*1,bigInt(title))
	local zz = Citizen.InvokeNative(0x815C4065AE6E6071,struct1:Buffer(),struct2:Buffer(),1)
    Wait(tonumber(duration))
    Citizen.InvokeNative(0x00A15B94CBA4F76F,zz)
end)

exports("updatemissionotify",function(notifid, utitle, umsg, duration)
	local title = CreateVarString(10, "LITERAL_STRING", utitle)
    local msg = CreateVarString(10, "LITERAL_STRING", umsg)
    local struct3 = DataView.ArrayBuffer(8*9)
	struct3:SetInt64(8*1,bigInt(title))
	struct3:SetInt64(8*2,bigInt(msg))
    Citizen.InvokeNative(0xBC6F454E310124DA,notifid,struct3:Buffer(),1)
    Wait(duration)
    Citizen.InvokeNative(0x00A15B94CBA4F76F,notifid)
end)

exports("warninnotify",function(title, msg, _audioRef,_audioName, duration)
    local title = CreateVarString(10, "LITERAL_STRING", title)
    local msg = CreateVarString(10, "LITERAL_STRING", msg)
    local audioRef = CreateVarString(10, "LITERAL_STRING", _audioRef)
    local audioName = CreateVarString(10, "LITERAL_STRING", _audioName)
	local duration = tonumber(duration) or 3000
	local struct1 = DataView.ArrayBuffer(8*5)
    local struct2 = DataView.ArrayBuffer(8*9)
	struct1:SetInt64(8*0,bigInt(audioRef))
	struct1:SetInt64(8*1,bigInt(audioName))
	struct1:SetInt16(8*2,4)
	struct2:SetInt64(8*2,bigInt(title))
	struct2:SetInt64(8*3,bigInt(msg))
	local zz = Citizen.InvokeNative(0x339E16B41780FC35,struct1:Buffer(),struct2:Buffer(),1)
    Wait(duration)
    Citizen.InvokeNative(0x00A15B94CBA4F76F,zz)
end)