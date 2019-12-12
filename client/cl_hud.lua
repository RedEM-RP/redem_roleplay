local money = 0
local gold = 0
local id
local hidehud = false

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    end
    end)
	
RegisterCommand("hud", function(source, args, rawCommand) -- Its showing/hiding hud - just a dev command
if (hidehud ~= false) then
	hidehud = false
	TriggerEvent("xrp:showHUD")
	DisplayHud(true)
	else
	hidehud = true
	DisplayHud(false)
	TriggerEvent("xrp:hideHUD")
	end
end, false)	
	
RegisterNetEvent('xrp:showHUD')
AddEventHandler('xrp:showHUD', function()
	SendNUIMessage({
		showhud = true
	})
end)	

RegisterNetEvent('xrp:hideHUD')
AddEventHandler('xrp:hideHUD', function()
	SendNUIMessage({
		hidehud = true
	})
end)	
	
RegisterNetEvent('xrp:showID')
AddEventHandler('xrp:showID', function(_id)
if Config.ShowID then
	SendNUIMessage({
		showid = true,
		id = _id
	})
	else end
end)	
	
RegisterNetEvent('xrp:activateMoney')
AddEventHandler('xrp:activateMoney', function(_money)
	SendNUIMessage({
		setmoney = true,
		money = _money
	})
end)

RegisterNetEvent('xrp:activateGold')
AddEventHandler('xrp:activateGold', function(_gold)
	SendNUIMessage({
		setgold = true,
		gold = _gold
	})
end)	
	
RegisterNetEvent("xrp:moneyLoaded")
AddEventHandler("xrp:moneyLoaded", function(_money)
		SendNUIMessage({
		setmoney = true,
		money = _money
	})
end)

RegisterNetEvent("xrp:xpLoaded")
AddEventHandler("xrp:xpLoaded", function(_xp)
if Config.ShowXPandLevel then
		SendNUIMessage({
		setxp = true,
		xp = _xp
	})
else end
end)

RegisterNetEvent("xrp:levelLoaded")
AddEventHandler("xrp:levelLoaded", function(_level)
	if Config.ShowXPandLevel then
		SendNUIMessage({
		setlevel = true,
		level = _level
	})
else end
end)

RegisterNetEvent('xrp:activateXP')
AddEventHandler('xrp:activateXP', function(_xp)
	if Config.ShowXPandLevel then
	SendNUIMessage({
		setxp = true,
		xp = _xp
	})
else end
end)	

RegisterNetEvent('xrp:activateLevel')
AddEventHandler('xrp:activateLevel', function(_level)
	if Config.ShowXPandLevel then
	SendNUIMessage({
		setlevel = true,
		level = _level
	})
else end
end)

RegisterNetEvent("xrp:goldLoaded")
AddEventHandler("xrp:goldLoaded", function(_gold)
	SendNUIMessage({
		setgold = true,
		gold = _gold
	})
end)


-- Updating
RegisterNetEvent("xrp:addMoney")
AddEventHandler("xrp:addMoney", function(_money, native, current)
	SendNUIMessage({
			addcash = true,
			money = _money
		})
end)

RegisterNetEvent("xrp:addXP")
AddEventHandler("xrp:addXP", function(_xp, native, current)
	if Config.ShowXPandLevel then
	SendNUIMessage({
			addxp = true,
			xp = _xp
		})
	else end
end)

RegisterNetEvent("xrp:removeXP")
AddEventHandler("xrp:removeXP", function(_xp, native, current)
	if Config.ShowXPandLevel then
	SendNUIMessage({
			removexp = true,
			xp = _xp
		})
	else end
end)

RegisterNetEvent("xrp:removeLevel")
AddEventHandler("xrp:removeLevel", function(_level, native, current)
	if Config.ShowXPandLevel then
	SendNUIMessage({
			removelevel = true,
			level = _level
		})
	else end
end)

RegisterNetEvent("xrp:addLevel")
AddEventHandler("xrp:addLevel", function(_level, native, current)
	if Config.ShowXPandLevel then
	SendNUIMessage({
			addlevel = true,
			level = _level
		})
	else end
end)

RegisterNetEvent("xrp:addGold")
AddEventHandler("xrp:addGold", function(_gold, native, current)
	SendNUIMessage({
			addgold = true,
			gold = _gold
		})
end)

RegisterNetEvent("xrp:removeMoney")
AddEventHandler("xrp:removeMoney", function(_money, native, current)
	SendNUIMessage({
			removecash = true,
			money = _money
		})
end)

RegisterNetEvent("xrp:removeGold")
AddEventHandler("xrp:removeGold", function(_gold, native, current)
	SendNUIMessage({
			removegold = true,
			gold = _gold
		})
end)