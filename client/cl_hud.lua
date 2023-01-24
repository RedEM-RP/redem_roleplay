local money = 0
local gold = 0
local id
local hidehud = false

function roundMe(n, dec)
    local power = 10^dec
    return math.floor(n * power) / power
end

	
RegisterNetEvent("redem_roleplay:SFI", function()
    DoScreenFadeIn(500)
end)
	
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
	
RegisterNetEvent('redemrp:showID', function(_id)
	SendNUIMessage({
		showid = true,
		id = _id
	})
end)	
	
RegisterNetEvent('redem:activateMoney', function(_money)
	SendNUIMessage({
		setmoney = true,
		money = roundMe(_money, 2)
	})
end)


RegisterNetEvent("redemrp:moneyLoaded", function(_money)
	SendNUIMessage({
		setmoney = true,
		money = roundMe(_money, 2)
	})
end)

-- Updating
RegisterNetEvent("redem:addMoney", function(_money, native, current)
	SendNUIMessage({
		addcash = true,
		money = roundMe(_money, 2)
	})
end)

RegisterNetEvent("redemrp:removeMoney", function(_money, native, current)
	SendNUIMessage({
		removecash = true,
		money = roundMe(_money, 2)
	})
end)

RegisterNetEvent("redem:removeMoney", function(_money, native, current)
	SendNUIMessage({
		removecash = true,
		money = roundMe(_money, 2)
	})
end)