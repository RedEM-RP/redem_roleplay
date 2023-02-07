local ConnectedPlayers = {}

RegisterCommand("sfi", function(source, args, rawCommand)
	TriggerClientEvent("redem_roleplay:SFI", source)
end, false)

TP = function(source, args, rawCommand)
	local Player = RedEM.GetPlayer(source)
    if Player.group == "mod" or Player.group == "admin" or Player.group == "superadmin" then
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
    local Player = RedEM.GetPlayer(source)
    if Player.group == "mod" or Player.group == "admin" or Player.group == "superadmin" then
        if args[1] ~= nil then
            if args[1] == "off" then
                TriggerClientEvent("redemrp_admin:client:StopSpectating", source)
            else
                local Target = RedEM.GetPlayer(args[1])
                if Target then
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
    local Player = RedEM.GetPlayer(source)
    if Player.group == "mod" or Player.group == "admin" or Player.group == "superadmin" then
        if targetplayer ~= nil then
            if targetplayer == "off" then
                TriggerClientEvent("redemrp_admin:client:StopSpectating", source)
            else
                local Target = RedEM.GetPlayer(targetplayer)
                if Target then
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
    local Player = RedEM.GetPlayer(source)
    if Player.group == "admin" or Player.group == "superadmin" then
        TriggerEvent("redemrp_status:server:FeedMe", source)
        RedEM.Functions.NotifyRight(source, "Fed and watered.", 3000)
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end, false)

RegisterCommand("trash", function(source, args, rawCommand)
    local Player = RedEM.GetPlayer(source)
    if Player.group == "admin" or Player.group == "superadmin" then
        TriggerClientEvent("redemrp_inventory:OpenStash", source, "trash_"..math.random(100000, 999999).."_"..math.random(100000, 999999).."_"..math.random(100000, 999999).."_"..math.random(100000, 999999))
        RedEM.Functions.NotifyRight(source, "Opened a trash.", 3000)
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end, false)

RegisterCommand("openstash", function(source, args, rawCommand)
    local Player = RedEM.GetPlayer(source)
    if Player.group == "admin" or Player.group == "superadmin" then
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
    local Player = RedEM.GetPlayer(source)
    if Player.group == "mod" or Player.group == "admin" or Player.group == "superadmin" then
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
    local Player = RedEM.GetPlayer(source)
    if Player.group == "mod" or Player.group == "admin" or Player.group == "superadmin" then
        TriggerClientEvent("redemrp_admin:client:TeleportToMarker", source)
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end, false)

RegisterCommand("announce", function(source, args)
    local Player = RedEM.GetPlayer(source)
    if Player.group == "admin" or Player.group == "superadmin" then
        local msg = table.concat(args, " ")
        --TriggerClientEvent('chatMessage', -1, "SYSTEM", "error", "^3"..msg)
        RedEM.Functions.NotifyLeft(-1, "SERVER ANNOUNCEMENT", msg, "menu_textures", "menu_icon_alert", 10000)
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end)

RegisterCommand("balances", function(source, args)
    local Player = RedEM.GetPlayer(source)
    if Player.group == "admin" or Player.group == "superadmin" then
        if args[1] then
            local Target = RedEM.GetPlayer(args[1])
            if Target then
                RedEM.Functions.NotifyRight(source, GetPlayerName(tonumber(args[1]).." ("..Target.GetFirstName().." "..Target.GetLastName().." cash: $"..Target.getMoney()..", bank: $"..Target.getBankMoney()), 3000)
            else
                RedEM.Functions.NotifyRight(source, "Player not logged in.", 3000)
            end
        end
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end)

RegisterCommand("say", function(source, args)
    local Player = RedEM.GetPlayer(source)
    if Player.group == "mod" or Player.group == "admin" or Player.group == "superadmin" then
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

DeleteHorse = function(source, args)
    local Player = RedEM.GetPlayer(source)
    if Player.group == "admin" or Player.group == "superadmin" then
        TriggerClientEvent("redemrp_admin:client:DeleteVehicleAdmin", source)
    else
        TriggerClientEvent("redemrp_admin:client:DeleteVehicle", source)
    end
end
RegisterCommand("dv", DeleteHorse)
RegisterCommand("dh", DeleteHorse)

RegisterCommand("setrb", function(source, args)
    local Player = RedEM.GetPlayer(source)
    if Player.group == "admin" or Player.group == "superadmin" then
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
    local Player = RedEM.GetPlayer(source)
    if Player.group == "admin" or Player.group == "superadmin" then
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
        local Player = RedEM.GetPlayer(source)
        if Player.group == "admin" or Player.group == "superadmin" then
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
        local Player = RedEM.GetPlayer(source)
        if Player.group == "admin" or Player.group == "superadmin" then
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
    local Player = RedEM.GetPlayer(source)
    if Player.group == "mod" or Player.group == "admin" or Player.group == "superadmin" then
        TriggerClientEvent("redemrp_admin:client:SetInvis", source)
    else
        RedEM.Functions.NotifyRight(source, "Insufficient permissions.", 3000)
    end
end)

RegisterCommand("setgroup", function(source, args, rawCommand)
    local Player = RedEM.GetPlayer(source)
    if Player then
        if Player.group == "superadmin" then
            if args[1] and args[2] then
                local Target = RedEM.GetPlayer(args[1])
                if Target then
                    local group = args[2]
                    if group == "admin" or group == "superadmin" or group == "user" then
                        Target.set("group", group)
                        RedEM.DB.SetPlayerPermissionGroup(Target.identifier, group)
                        RedEM.Functions.NotifyRight(source, "Set ".. GetPlayerName(tonumber(args[1])) .."'s group to <strong style=\"color:gold\">"..group.."</strong>!", 3000)
                    end
                else
                    RedEM.Functions.NotifyRight(source, "Player not found or isn't logged in.", 3000)
                end
            else
                RedEM.Functions.NotifyRight(source, "/setgroup [Player ID] [Group]", 3000)
            end
        end
    end
end)


RegisterCommand("setmoney", function(source, args, rawCommand)
    local Player = RedEM.GetPlayer(source)
    if Player then
        if Player.group == "admin" or Player.group == "superadmin" then
            if args[1] and args[2] then
                local Target = RedEM.GetPlayer(args[1])
                if Target then
                    local amount = tonumber(args[2])
                    if amount > 0 then

                        Target.SetMoney(tonumber(args[2]))

                        RedEM.Functions.NotifyRight(source, "Set ".. Player.GetName() .."'s cash to <strong style=\"color:lime\">$".. RedEM.Functions.CommaValue(string.format("%.2f", count)).."</strong>!", 3000)
                        RedEM.Functions.NotifyRight(tonumber(args[1]), "Staff set your cash to <strong style=\"color:lime\">$"..RedEM.Functions.CommaValue(string.format("%.2f", count)).."</strong>!", 3000)
                    end
                else
                    RedEM.Functions.NotifyRight(source, "Player not found or isn't logged in.", 3000)
                end
            else
                RedEM.Functions.NotifyRight(source, "/setmoney [Player ID] [Amount]", 3000)
            end
        end
    end
end)

RegisterCommand("setjob", function(source, args, rawCommand)
    local Player = RedEM.GetPlayer(source)
    if Player then
        if Player.group == "admin" or Player.group == "superadmin" then
            if args[1] and args[2] and args[3] then
                local Target = RedEM.GetPlayer(args[1])
                if Target then
                    local job, rank = args[2], args[3]

                    Target.SetJob(job)
                    Target.SetJobGrade(rank)

                    TriggerClientEvent("redem_roleplay:JobChange", tonumber(args[1]), job)
                    RedEM.Functions.NotifyRight(source, "Set "..Target.GetName().."'s job to "..job.." (Rank "..rank..")", 3000)
                else
                    RedEM.Functions.NotifyRight(source, "Player not found or isn't logged in.", 3000)
                end
            else
                RedEM.Functions.NotifyRight(source, "/setjob [Player ID] [Job] [Rank]", 3000)
            end
        end
    end
end)

RegisterCommand("setgang", function(source, args, rawCommand)
    local Player = RedEM.GetPlayer(source)
    if Player then
        if Player.group == "admin" or Player.group == "superadmin" then
            if args[1] and args[2] and args[3] then
                local Target = RedEM.GetPlayer(args[1])
                if Target then
                    local gang, rank = args[2], args[3]

                    Target.SetGang(gang)
                    Target.SetGangGrade(rank)

                    TriggerClientEvent("redem_roleplay:GangChange", tonumber(args[1]), gang)
                    RedEM.Functions.NotifyRight(source, "Set "..Target.GetName().."'s gang to "..gang.." (Rank "..rank..")", 3000)
                else
                    RedEM.Functions.NotifyRight(source, "Player not found or isn't logged in.", 3000)
                end
            else
                RedEM.Functions.NotifyRight(source, "/setgang [Player ID] [Gang] [Rank]", 3000)
            end
        end
    end
end)

RegisterCommand("addmoney", function(source, args, rawCommand)
    local Player = RedEM.GetPlayer(source)
    if Player then
        if Player.group == "admin" or Player.group == "superadmin" then
            if args[1] and args[2] then
                local Target = RedEM.GetPlayer(args[1])
                if Target then
                    local amount = tonumber(args[2])
                    if amount > 0 then

                        Target.AddMoney(tonumber(args[2]))

                        RedEM.Functions.NotifyRight(source, "Added <strong style=\"color:lime\">$".. RedEM.Functions.CommaValue(string.format("%.2f", args[2])).."</strong> to ".. Player.GetName() .."!", 3000)
                        RedEM.Functions.NotifyRight(tonumber(args[1]), "Staff gave you <strong style=\"color:lime\">$"..RedEM.Functions.CommaValue(string.format("%.2f", args[2])).."</strong>!", 3000)
                    end
                else
                    RedEM.Functions.NotifyRight(source, "Player not found or isn't logged in.", 3000)
                end
            else
                RedEM.Functions.NotifyRight(source, "/addmoney [Player ID] [Amount]", 3000)
            end
        end
    end
end)

RegisterCommand("addbankmoney", function(source, args, rawCommand)
    local Player = RedEM.GetPlayer(source)
    if Player then
        if Player.group == "admin" or Player.group == "superadmin" then
            if args[1] and args[2] then
                local Target = RedEM.GetPlayer(args[1])
                if Target then
                    local amount = tonumber(args[2])
                    if amount > 0 then

                        Target.AddBankMoney(tonumber(args[2]))

                        RedEM.Functions.NotifyRight(source, "Added <strong style=\"color:lime\">$".. RedEM.Functions.CommaValue(string.format("%.2f", args[2])).."</strong> bank to ".. Target.GetName() .."!", 3000)
                        RedEM.Functions.NotifyRight(tonumber(args[1]), "Staff gave you <strong style=\"color:lime\">$"..RedEM.Functions.CommaValue(string.format("%.2f", args[2])).."</strong> bank money!", 3000)
                    end
                else
                    RedEM.Functions.NotifyRight(source, "Player not found or isn't logged in.", 3000)
                end
            else
                RedEM.Functions.NotifyRight(source, "/addbankmoney [Player ID] [Amount]", 3000)
            end
        end
    end
end)

RegisterCommand("removemoney", function(source, args, rawCommand)
    local Player = RedEM.GetPlayer(source)
    if Player then
        if Player.group == "admin" or Player.group == "superadmin" then
            if args[1] and args[2] then
                local Target = RedEM.GetPlayer(args[1])
                if Target then
                    local amount = tonumber(args[2])
                    if amount > 0 then

                        Target.RemoveMoney(tonumber(args[2]))

                        RedEM.Functions.NotifyRight(source, "Removed <strong style=\"color:red\">$".. RedEM.Functions.CommaValue(string.format("%.2f", args[2])).."</strong> cash from ".. Target.GetName() .."!", 3000)
                        RedEM.Functions.NotifyRight(tonumber(args[1]), "Staff removed <strong style=\"color:red\">$"..RedEM.Functions.CommaValue(string.format("%.2f", args[2])).."</strong> cash from you!", 3000)
                    end
                else
                    RedEM.Functions.NotifyRight(source, "Player not found or isn't logged in.", 3000)
                end
            else
                RedEM.Functions.NotifyRight(source, "/removemoney [Player ID] [Amount]", 3000)
            end
        end
    end
end)

RegisterCommand("removebankmoney", function(source, args, rawCommand)
    local Player = RedEM.GetPlayer(source)
    if Player then
        if Player.group == "admin" or Player.group == "superadmin" then
            if args[1] and args[2] then
                local Target = RedEM.GetPlayer(args[1])
                if Target then
                    local amount = tonumber(args[2])
                    if amount > 0 then

                        Target.RemoveBankMoney(tonumber(args[2]))
                        
                        RedEM.Functions.NotifyRight(source, "Removed <strong style=\"color:red\">$".. RedEM.Functions.CommaValue(string.format("%.2f", args[2])).."</strong> bank money from ".. Target.GetName() .."!", 3000)
                        RedEM.Functions.NotifyRight(tonumber(args[1]), "Staff removed <strong style=\"color:red\">$"..RedEM.Functions.CommaValue(string.format("%.2f", args[2])).."</strong> bank money from you!", 3000)
                    end
                else
                    RedEM.Functions.NotifyRight(source, "Player not found or isn't logged in.", 3000)
                end
            else
                RedEM.Functions.NotifyRight(source, "/removebankmoney [Player ID] [Amount]", 3000)
            end
        end
    end
end)