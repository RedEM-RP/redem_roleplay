local money = 0
local gold = 0
local id
local hidehud = false

function roundMe(n, dec)
    local power = 10^dec
    return math.floor(n * power) / power
end

	
RegisterCommand("hud", function(source, args, rawCommand) -- Its showing/hiding hud - just a dev command
	if (hidehud ~= false) then
		hidehud = false
		TriggerEvent("redemrp:showHUD")
		DisplayHud(true)
	else
		hidehud = true
		DisplayHud(false)
		TriggerEvent("redemrp:hideHUD")
	end
end, false)	
	
RegisterNetEvent('redemrp:showHUD')
AddEventHandler('redemrp:showHUD', function()
	SendNUIMessage({
		showhud = true
	})
end)	

RegisterNetEvent('redemrp:hideHUD')
AddEventHandler('redemrp:hideHUD', function()
	SendNUIMessage({
		hidehud = true
	})
end)	
	
RegisterNetEvent('redemrp:showID')
AddEventHandler('redemrp:showID', function(_id)
	if Config.ShowID == 1 then
		SendNUIMessage({
			showid = true,
			id = _id
		})
	end
end)	
	
RegisterNetEvent('redem:activateMoney')
AddEventHandler('redem:activateMoney', function(_money)
	SendNUIMessage({
		setmoney = true,
		money = roundMe(_money, 2)
	})
end)

RegisterNetEvent('redemrp:activateGold')
AddEventHandler('redemrp:activateGold', function(_gold)
	SendNUIMessage({
		setgold = true,
		gold = _gold
	})
end)	
	
RegisterNetEvent("redemrp:moneyLoaded")
AddEventHandler("redemrp:moneyLoaded", function(_money)
	SendNUIMessage({
		setmoney = true,
		money = roundMe(_money, 2)
	})
end)

RegisterNetEvent("redemrp:xpLoaded")
AddEventHandler("redemrp:xpLoaded", function(_xp)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			setxp = true,
			xp = _xp
		})
	end
end)

RegisterNetEvent("redemrp:levelLoaded")
AddEventHandler("redemrp:levelLoaded", function(_level)
	if Config.ShowXPandLevel == 1 then
			SendNUIMessage({
			setlevel = true,
			level = _level
		})
	end
end)

RegisterNetEvent('redemrp:activateXP')
AddEventHandler('redemrp:activateXP', function(_xp)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			setxp = true,
			xp = _xp
		})
	end
end)	

RegisterNetEvent('redemrp:activateLevel')
AddEventHandler('redemrp:activateLevel', function(_level)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			setlevel = true,
			level = _level
		})
	end
end)

RegisterNetEvent("redemrp:goldLoaded")
AddEventHandler("redemrp:goldLoaded", function(_gold)
	SendNUIMessage({
		setgold = true,
		gold = _gold
	})
end)


-- Updating
RegisterNetEvent("redem:addMoney")
AddEventHandler("redem:addMoney", function(_money, native, current)
	SendNUIMessage({
		addcash = true,
		money = roundMe(_money, 2)
	})
end)

RegisterNetEvent("redemrp:addXP")
AddEventHandler("redemrp:addXP", function(_xp, native, current)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			addxp = true,
			xp = _xp
		})
	end
end)

RegisterNetEvent("redemrp:removeXP")
AddEventHandler("redemrp:removeXP", function(_xp, native, current)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			removexp = true,
			xp = _xp
		})
	end
end)

RegisterNetEvent("redemrp:removeLevel")
AddEventHandler("redemrp:removeLevel", function(_level, native, current)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			removelevel = true,
			level = _level
		})
	end
end)

RegisterNetEvent("redemrp:addLevel")
AddEventHandler("redemrp:addLevel", function(_level, native, current)
	if Config.ShowXPandLevel == 1 then
		SendNUIMessage({
			addlevel = true,
			level = _level
		})
	end
end)

RegisterNetEvent("redemrp:addGold")
AddEventHandler("redemrp:addGold", function(_gold, native, current)
	SendNUIMessage({
		addgold = true,
		gold = _gold
	})
end)

RegisterNetEvent("redemrp:removeMoney")
AddEventHandler("redemrp:removeMoney", function(_money, native, current)
	SendNUIMessage({
		removecash = true,
		money = roundMe(_money, 2)
	})
end)

RegisterNetEvent("redem:removeMoney")
AddEventHandler("redem:removeMoney", function(_money, native, current)
	SendNUIMessage({
		removecash = true,
		money = roundMe(_money, 2)
	})
end)


RegisterNetEvent("redemrp:removeGold")
AddEventHandler("redemrp:removeGold", function(_gold, native, current)
	SendNUIMessage({
		removegold = true,
		gold = _gold
	})
end)
