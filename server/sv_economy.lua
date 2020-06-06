if Config.AdminCommands == 1 then
	RegisterCommand("setgold", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("argument #1 or #2 is bad")
		else
			TriggerEvent("redemrp:setGold", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("setmoney", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("argument #1 or #2 is bad")
		else
			TriggerEvent("redemrp:setMoney", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("setlevel", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("argument #1 or #2 is bad")
		else
			TriggerEvent("redemrp:setLevel", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("setxp", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("argument #1 or #2 is bad")
		else
			TriggerEvent("redemrp:setXP", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("setjob", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil or args[3] == nil then
			print("argument #1, #2 or #3 is bad")
		else
			TriggerEvent("redemrp:setJob", source, args[1], args[2], args[3], function(cb)end)
		end
	end, false)

	RegisterCommand("addmoney", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("argument #1 or #2 is bad")
		else
			TriggerEvent("redemrp:addMoney", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("addgold", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("argument #1 or #2 is bad")
		else
			TriggerEvent("redemrp:addGold", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("addxp", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("argument #1 or #2 is bad")
		else
			TriggerEvent("redemrp:addXP", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("removemoney", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("argument #1 or #2 is bad")
		else
			TriggerEvent("redemrp:removeMoney", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("removegold", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("argument #1 or #2 is bad")
		else
			TriggerEvent("redemrp:removeGold", source, args[1], args[2], function(cb)end)
		end
	end, false)

	RegisterCommand("setgroup", function(source, args, rawCommand)
		if args[1] == nil or args[2] == nil then
			print("argument #1 or #2 is bad")
		else
			TriggerEvent("redemrp:setGroup", source, args[1], args[2], function(cb)end)
		end
	end, false)
end

AddEventHandler("redemrp:SetSomeGold", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `redemrp:SetSomeGold` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("redemrp:setGold", source, id, count, cb)
end)

AddEventHandler("redemrp:setGold", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")	
		else
			local _source = tonumber(id)
			TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.setGold(tonumber(count))
					print("Done set gold to user: "..user.getName())
				end
			end)
		end
	end)
end)

AddEventHandler("redemrp:SetSomeJob", function(source, id, count, grade, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `redemrp:SetSomeJob` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("redemrp:setJob", source, id, count, grade, cb)
end)

AddEventHandler("redemrp:setJob", function(source, id, count, grade, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.setJob(count)
					user.setJobgrade(tonumber(grade))
					print("Done set job to user: "..user.getName())
				end
			end)
		end
	end)
end)

AddEventHandler("redemrp:SetSomeMoney", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `redemrp:SetSomeMoney` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("redemrp:setMoney", source, id, count, cb)
end)

AddEventHandler("redemrp:setMoney", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.setMoney(tonumber(count))
					print("Done set money to user: "..user.getName())
				end
			end)
		end
	end)
end)

AddEventHandler("redemrp:AddSomeGold", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `redemrp:AddSomeGold` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("redemrp:addGold", source, id, count, cb)
end)

AddEventHandler("redemrp:addGold", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.addGold(tonumber(count))
					print("Done add gold to user: "..user.getName())
				end
			end)
		end
	end)
end)
	
AddEventHandler("redemrp:AddSomeMoney", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `redemrp:AddSomeMoney` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("redemrp:addMoney", source, id, count, cb)
end)

AddEventHandler("redemrp:addMoney", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then	
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback
					print("Admin command Feedback: this user doesnt exist")
				else
					user.addMoney(tonumber(count))
					print("Done add money to user: "..user.getName())
				end
			end)
		end
	end)
end)
	
AddEventHandler("redemrp:RemoveSomeGold", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `redemrp:RemoveSomeGold` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("redemrp:removeGold", source, id, count, cb)
end)

AddEventHandler("redemrp:removeGold", function(source, id, count, cb)
	local _perm = tonumber(source)
		TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.removeGold(tonumber(count))
					print("Done remove gold to user: "..user.getName())
				end
			end)
		end
	end)
end)
	
AddEventHandler("redemrp:RemoveSomeMoney", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `redemrp:RemoveSomeMoney` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("redemrp:removeMoney", source, id, count, cb)
end)

AddEventHandler("redemrp:removeMoney", function(source, id, count, cb)
	local _perm = tonumber(source)
		TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.removeMoney(tonumber(count))
					print("Done remove money to user: "..user.getName())
				end
			end)
		end
	end)
end)
	
AddEventHandler("redemrp:AddSomeXP", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `redemrp:AddSomeXP` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("redemrp:addXP", source, id, count, cb)
end)

AddEventHandler("redemrp:addXP", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.addXP(tonumber(count))
					print("Done add XP to user: "..user.getName())
				end
			end)
		end
	end)
end)
	
AddEventHandler("redemrp:SetSomeLevel", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `redemrp:SetSomeLevel` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("redemrp:setLevel", source, id, count, cb)
end)

AddEventHandler("redemrp:setLevel", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.setLevel(tonumber(count))
					print("Done set leveling to user: "..user.getName())
				end
			end)
		end
	end)
end)
	
AddEventHandler("redemrp:SetSomeXP", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `redemrp:SetSomeXP` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("redemrp:setXP", source, id, count, cb)
end)

AddEventHandler("redemrp:setXP", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.setXP(tonumber(count))
					print("Done set XP to user: "..user.getName())
				end
			end)
		end
	end)
end)	
	
AddEventHandler("redemrp:SetSomeGroup", function(source, id, count, cb)
	print("[" .. GetInvokingResource() .. "] ^1" .. " called deprecated event `redemrp:SetSomeGroup` please be sure to update to the standarized API introduced in v1.0.0")
	TriggerEvent("redemrp:setGroup", source, id, count, cb)
end)

AddEventHandler("redemrp:setGroup", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
		if _perm ~= 0 and pg.getGroup() ~= 'superadmin' then
			print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN SUPER ADMIN COMMAND WITHOUT PERMISSION")
		else
			local _source = tonumber(id)
			TriggerEvent('redem:getPlayerFromId', _source, function(user)
				if user == nil then
					--TODO Temporary command Feeback	
					print("Admin command Feedback: this user doesnt exist")
				else
					user.setGroup(count)
					print("Done set group to user: "..user.getName() .." Group: "..user.getGroup())
				end
			end)
		end
	end)
end)
