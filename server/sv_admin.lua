local ConnectedPlayers = {}

RegisterCommand("sfi", function(source, args, rawCommand)
	TriggerClientEvent("redem_roleplay:SFI", source)
end, false)

TP = function(source, args, rawCommand)
	local user = RedEM.GetPlayer(source)
    if user.getGroup() == "mod" or user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        if args[1] ~= nil and args[2] == nil and args[3] == nil then
            if DoesEntityExist(GetPlayerPed(args[1])) then
                local toCoords = GetEntityCoords(GetPlayerPed(args[1]))
                SetEntityCoords(GetPlayerPed(source), toCoords)
                RedEM.Functions.NotifyRight(source, "Teleported to "..GetPlayerName(args[1]).." ["..args[1].."]", 3000)
            else
                RedEM.Functions.NotifyRight(source, "Player offline?", 3000)
            end
        elseif args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
            SetEntityCoords(GetPlayerPed(source), tonumber(args[1]), tonumber(args[2]), tonumber(args[3]))
            RedEM.Functions.NotifyRight(source, "/tp [Player ID / X] [Y (optional)] [Z (optional)]", 3000)
        end
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end
RegisterCommand("tp", TP, false)
RegisterCommand("goto", TP, false)

RegisterCommand("spec", function(source, args, rawCommand)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "mod" or user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        if args[1] ~= nil then
            if args[1] == "off" then
                TriggerClientEvent("redemrp_admin:client:StopSpectating", source)
            else
                local tuser = RedEM.GetPlayer(args[1])
                if tuser then
                    local PlayerPos = GetEntityCoords(GetPlayerPed(tonumber(args[1])))
                    local Entity = NetworkGetNetworkIdFromEntity(GetPlayerPed(tonumber(args[1])))
                    if PlayerPos then
                        TriggerClientEvent("redemrp_admin:client:Spectate", source, PlayerPos, tonumber(args[1]))
                    end
                end
            end
        else
            RedEM.Functions.NotifyRight(source, "/spec [Player ID / off]", 3000)
        end
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end, false)

RegisterNetEvent("redemrp_admin:server:RequestAdminSpec", function(source, targetplayer)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "mod" or user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        if targetplayer ~= nil then
            if targetplayer == "off" then
                TriggerClientEvent("redemrp_admin:client:StopSpectating", source)
            else
                local tuser = RedEM.GetPlayer(targetplayer)
                if tuser then
                    local PlayerPos = GetEntityCoords(GetPlayerPed(tonumber(targetplayer)))
                    local Entity = NetworkGetNetworkIdFromEntity(GetPlayerPed(tonumber(targetplayer)))
                    if PlayerPos then
                        TriggerClientEvent("redemrp_admin:client:Spectate", source, PlayerPos, tonumber(targetplayer))
                    end
                end
            end
        end
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end)

RegisterCommand("feedme", function(source, args, rawCommand)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        TriggerEvent("redemrp_status:server:FeedMe", source)
        RedEM.Functions.NotifyRight(source, "Fed and watered.", 3000)
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end, false)

RegisterCommand("trash", function(source, args, rawCommand)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        TriggerClientEvent("redemrp_inventory:OpenStash", source, "trash_"..math.random(100000, 999999).."_"..math.random(100000, 999999).."_"..math.random(100000, 999999).."_"..math.random(100000, 999999))
        RedEM.Functions.NotifyRight(source, "Opened a trash.", 3000)
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end, false)

RegisterCommand("openstash", function(source, args, rawCommand)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        if args[1] then
            TriggerClientEvent("redemrp_inventory:OpenStash", source, args[1])
            RedEM.Functions.NotifyRight(source, "Opened a stash.", 3000)
        else
            RedEM.Functions.NotifyRight(source, "/openstash [Stash Code]", 3000)
        end
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end, false)

RegisterCommand("bring", function(source, args, rawCommand)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "mod" or user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        if args[1] ~= nil and args[2] == nil and args[3] == nil then
            if DoesEntityExist(GetPlayerPed(args[1])) then
                local toCoords = GetEntityCoords(GetPlayerPed(source))
                SetEntityCoords(GetPlayerPed(args[1]), toCoords)
                RedEM.Functions.NotifyRight(source, "Teleported "..GetPlayerName(args[1]).." ["..args[1].."] to you", 3000)
            else
                RedEM.Functions.NotifyRight(source, "Player offline?", 3000)
            end
        elseif args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
            SetEntityCoords(GetPlayerPed(source), args[1], args[2], args[3])
        else
            RedEM.Functions.NotifyRight(source, "/tp [Player ID / X] [Y (optional)] [Z (optional)]", 3000)
        end
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end, false)

RegisterCommand("tpm", function(source, args, rawCommand)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "mod" or user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        TriggerClientEvent("redemrp_admin:client:TeleportToMarker", source)
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end, false)

RegisterCommand("announce", function(source, args)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        local msg = table.concat(args, " ")
        --TriggerClientEvent('chatMessage', -1, "SYSTEM", "error", "^3"..msg)
        RedEM.Functions.NotifyLeft(-1, "SERVER ANNOUNCEMENT", msg, "menu_textures", "menu_icon_alert", 10000)
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end)

RegisterCommand("balances", function(source, args)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        if args[1] then
            local tuser = RedEM.GetPlayer(args[1])
            if tuser then
                RedEM.Functions.NotifyRight(source, GetPlayerName(tonumber(args[1]).." ("..tuser.GetFirstName().." "..tuser.GetLastName().." cash: $"..tuser.getMoney()..", bank: $"..tuser.getBankMoney()), 3000)
            else
                RedEM.Functions.NotifyRight(source, "Player not logged in.", 3000)
            end
        end
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end)

RegisterCommand("say", function(source, args)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "mod" or user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        if args[1] and args[2] then
            local id = args[1]
            table.remove(args, 1)
            local msg = table.concat(args, " ")
            --TriggerClientEvent('chatMessage', -1, "SYSTEM", "error", "^3"..msg)
            RedEM.Functions.NotifyLeft(tonumber(id), "STAFF MESSAGE", msg, "menu_textures", "menu_icon_alert", 10000)
            RedEM.Functions.NotifyRight(source, "Sent message to "..id..".")
        end
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end)

RegisterCommand("dv", function(source, args)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        TriggerClientEvent("redemrp_admin:client:DeleteVehicleAdmin", source)
    else
        TriggerClientEvent("redemrp_admin:client:DeleteVehicle", source)
    end
end)

RegisterCommand("dh", function(source, args)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        TriggerClientEvent("redemrp_admin:client:DeleteVehicleAdmin", source)
    else
        TriggerClientEvent("redemrp_admin:client:DeleteVehicle", source)
    end
end)

RegisterCommand("setrb", function(source, args)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        if args[1] ~= nil and args[2] ~= nil then
            if DoesEntityExist(GetPlayerPed(tonumber(args[1]))) then
                SetPlayerRoutingBucket(tonumber(args[1]), tonumber(args[2]))
            else
                RedEM.Functions.NotifyRight(source, "Player offline?", 3000)
            end
            RedEM.Functions.NotifyRight(source, "/setrb [Player ID] [Routing Bucket #]", 3000)
        end
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end)

RegisterCommand("kick", function(source, args)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        if args[1] ~= nil and args[2] ~= nil then
            local targetId = args[1]
            table.remove(args, 1)
            local reason = table.concat(args, " ")
            DropPlayer(targetId, reason)
        else
            RedEM.Functions.NotifyRight(source, "/kick [Player ID] [Reason]", 3000)
        end
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end)

RegisterCommand("openinv", function(source, args)
    if args[1] then
        local user = RedEM.GetPlayer(source)
        if user.getGroup() == "admin" or user.getGroup() == "superadmin" then
            if GetPlayerPing(tonumber(args[1])) ~= nil then
                TriggerEvent("redemrp_inventory:OpenPlayerInventory", source, tonumber(args[1]))
            else
                RedEM.Functions.NotifyRight(source, "Player not connected.", 3000)
            end
        else
            RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
        end
    else
        RedEM.Functions.NotifyRight(source, "/openinv [Player ID]", 3000)
    end
end)

RegisterCommand("pedscale", function(source, args)
    if args[1] then
        local user = RedEM.GetPlayer(source)
        if user.getGroup() == "admin" or user.getGroup() == "superadmin" then
            if tonumber(args[1]) > 0.2 and tonumber(args[1]) < 2.0 then
                TriggerClientEvent("redemrp_admin:client:SetScale", source, tonumber(args[1]))
            else
                RedEM.Functions.NotifyRight(source, "Scale out of bounds. 0.2 - 2.0", 3000)
            end
        else
            RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
        end
    else
        RedEM.Functions.NotifyRight(source, "/pedscale [Scale 0.2-2.0]", 3000)
    end
end)

RegisterCommand("invis", function(source, args)
    local user = RedEM.GetPlayer(source)
    if user.getGroup() == "mod" or user.getGroup() == "admin" or user.getGroup() == "superadmin" then
        TriggerClientEvent("redemrp_admin:client:SetInvis", source)
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end)

RegisterCommand("setmoney", function(source, args, rawCommand)
	if args[1] == nil or args[2] == nil then
		RedEM.Functions.NotifyRight(source, "/setmoney [Player ID] [Amount]", 3000)
	else
		TriggerEvent("redemrp:setMoney", source, args[1], args[2], function(cb)end)
	end
end, false)

RegisterCommand("setjob", function(source, args, rawCommand)
	if args[1] == nil or args[2] == nil or args[3] == nil then
		RedEM.Functions.NotifyRight(source, "/setjob [Player ID] [Job] [Rank]", 3000)
	else
		TriggerEvent("redemrp:setJob", source, args[1], args[2], args[3], function(cb)end)
	end
end, false)

RegisterCommand("setgang", function(source, args, rawCommand)
	if args[1] == nil or args[2] == nil or args[3] == nil then
		RedEM.Functions.NotifyRight(source, "/setgang [Player ID] [Gang] [Rank]", 3000)
	else
		TriggerEvent("redemrp:setGang", source, args[1], args[2], args[3], function(cb)end)
	end
end, false)

RegisterCommand("addmoney", function(source, args, rawCommand)
	if args[1] == nil or args[2] == nil then
		RedEM.Functions.NotifyRight(source, "/addmoney [Player ID] [Amount]", 3000)
	else
		TriggerEvent("redemrp:addMoney", source, args[1], args[2], function(cb)end)
	end
end, false)

RegisterCommand("addbankmoney", function(source, args, rawCommand)
	if args[1] == nil or args[2] == nil then
		--print("argument #1 or #2 is bad")
	else
		TriggerEvent("redemrp:addBankMoney", source, args[1], args[2], function(cb)end)
	end
end, false)

RegisterCommand("removemoney", function(source, args, rawCommand)
	if args[1] == nil or args[2] == nil then
		RedEM.Functions.NotifyRight(source, "/removemoney [Player ID] [Amount]", 3000)
	else
		TriggerEvent("redemrp:removeMoney", source, args[1], args[2], function(cb)end)
	end
end, false)

RegisterCommand("removebankmoney", function(source, args, rawCommand)
	if args[1] == nil or args[2] == nil then
		--print("argument #1 or #2 is bad")
	else
		TriggerEvent("redemrp:removeBankMoney", source, args[1], args[2], function(cb)end)
	end
end, false)

AddEventHandler("redemrp:setJob", function(source, id, job, grade, cb)
	local _perm = tonumber(source)
	local pg = RedEM.GetPlayer(_perm)
	if _perm ~= 0 and (pg.GetGroup() ~= "admin" and pg.GetGroup() ~= "superadmin") then
		print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	else
		local _source = tonumber(id)
		local user = RedEM.GetPlayer(_source)
		if not user then
			RedEM.Functions.NotifyRight(_perm, "Invalid player!", 3000)
		else
			user.SetJob(job)
			user.SetJobGrade(tonumber(grade))
			TriggerClientEvent("redem_roleplay:JobChange", _source, job)
			RedEM.Functions.NotifyRight(_perm, "Set "..user.GetName().."'s job to "..job.." (Rank "..grade..")", 3000)
		end
	end
end)

AddEventHandler("redemrp:setGang", function(source, id, count, grade, cb)
	local _perm = tonumber(source)
	local pg = RedEM.GetPlayer(_perm)
	if _perm ~= 0 and (pg.GetGroup() ~= "admin" and pg.GetGroup() ~= "superadmin") then
		print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	else
		local _source = tonumber(id)
		local user = RedEM.GetPlayer(_source)
		if not user then
			RedEM.Functions.NotifyRight(_perm, "Invalid player!", 3000)
		else
			user.setGang(count)
			user.setGanggrade(tonumber(grade))
			TriggerClientEvent("redem_roleplay:GangChange", _source, count)
			RedEM.Functions.NotifyRight(_perm, "Set "..user.getName().."'s gang to "..count.." (Rank "..grade..")", 3000)
		end
	end
end)

AddEventHandler("redemrp:setMoney", function(source, id, count, cb)
	local _perm = tonumber(source)
	local pg = RedEM.GetPlayer(_perm)
	if _perm ~= 0 and (pg.GetGroup() ~= "admin" and pg.GetGroup() ~= "superadmin") then
		print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	else
		local _source = tonumber(id)
		local user = RedEM.GetPlayer(_source)
		if not user then
			RedEM.Functions.NotifyRight(_perm, "Invalid player!", 3000)
		else
			user.SetMoney(tonumber(count))
			RedEM.Functions.NotifyRight(_perm, "Set ".. user.getName() .."'s money to $".. count.."!", 3000)
		end
	end
end)

AddEventHandler("redemrp:addMoney", function(source, id, count, cb)
	local _perm = tonumber(source)
	local pg = RedEM.GetPlayer(_perm)
	if _perm ~= 0 and (pg.GetGroup() ~= "admin" and pg.GetGroup() ~= "superadmin") then	
		print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	else
		local _source = tonumber(id)
		local user = RedEM.GetPlayer(_source)
		if not user then
			RedEM.Functions.NotifyRight(_perm, "Invalid player!", 3000)
		else
			user.AddMoney(tonumber(count))
			RedEM.Functions.NotifyRight(_perm, "Added <strong style=\"color:lime\">$".. RedEM.Functions.CommaValue(string.format("%.2f", count)).."</strong> to ".. user.GetName() .."!", 3000)
			RedEM.Functions.NotifyRight(_source, "Staff gave you <strong style=\"color:lime\">$"..RedEM.Functions.CommaValue(string.format("%.2f", count)).."</strong>!", 3000)
		end
	end
end)

AddEventHandler("redemrp:addBankMoney", function(source, id, count, cb)
	local _perm = tonumber(source)
	local pg = RedEM.GetPlayer(_perm)
	if _perm ~= 0 and (pg.GetGroup() ~= "admin" and pg.GetGroup() ~= "superadmin") then	
		print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	else
		local _source = tonumber(id)
		local user = RedEM.GetPlayer(_source)
		if not user then
			RedEM.Functions.NotifyRight(_perm, "Invalid player!", 3000)
		else
			user.AddBankMoney(tonumber(count))
			RedEM.Functions.NotifyRight(_perm, "Added <strong style=\"color:lime\">$".. RedEM.Functions.CommaValue(string.format("%.2f", count)).."</strong> bank to ".. user.getName() .."!", 3000)
			RedEM.Functions.NotifyRight(_source, "Staff gave you <strong style=\"color:lime\">$".. RedEM.Functions.CommaValue(string.format("%.2f", count)).."</strong> bank money!", 3000)
		end
	end
end)

AddEventHandler("redemrp:removeMoney", function(source, id, count, cb)
	local _perm = tonumber(source)
	local pg = RedEM.GetPlayer(_perm)
	if _perm ~= 0 and (pg.GetGroup() ~= "admin" and pg.GetGroup() ~= "superadmin") then
		print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	else
		local _source = tonumber(id)
		local user = RedEM.GetPlayer(_source)
		if not user then
			RedEM.Functions.NotifyRight(_perm, "Invalid player!", 3000)
		else
			user.RemoveMoney(tonumber(count))
			RedEM.Functions.NotifyRight(_source, "Removed <strong style=\"color:lime\">$".. RedEM.Functions.CommaValue(string.format("%.2f", count)).."</strong> from ".. user.getName() .."!", 3000)
		end
	end
end)

AddEventHandler("redemrp:removeBankMoney", function(source, id, count, cb)
	local _perm = tonumber(source)
	local pg = RedEM.GetPlayer(_perm)
	if _perm ~= 0 and (pg.GetGroup() ~= "admin" and pg.GetGroup() ~= "superadmin") then
		print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	else
		local _source = tonumber(id)
		local user = RedEM.GetPlayer(_source)
		if not user then
			RedEM.Functions.NotifyRight(_perm, "Invalid player!", 3000)
		else
			user.RemoveBankMoney(tonumber(count))
			RedEM.Functions.NotifyRight(_perm, "Removed <strong style=\"color:lime\">$".. RedEM.Functions.CommaValue(string.format("%.2f", count)).."</strong> from ".. user.getName() .."!", 3000)
			RedEM.Functions.NotifyRight(_source, "Staff removed <strong style=\"color:lime\">$".. RedEM.Functions.CommaValue(string.format("%.2f", count)).."</strong> from your bank!", 3000)
		end
	end
end)

function HexIdToSteamId(hexId)
    local cid = math.floor(tonumber(string.sub(hexId, 7), 16))
	local steam64 = math.floor(tonumber(string.sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
	local sid = "STEAM_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end