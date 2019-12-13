if Config.AdminCommands == 1 then
RegisterCommand("setgold", function(source, args, rawCommand)
 if args[1] == nil or args[2] == nil then
 print("argument #1 or #2 is bad")
 else
 
 TriggerEvent("redemrp:SetSomeGold", source, args[1], args[2], function(cb)
 print("Gold Setted")
 end)
 

 end
end, false)

RegisterCommand("setmoney", function(source, args, rawCommand)

 if args[1] == nil or args[2] == nil then
 print("argument #1 or #2 is bad")
 else
    TriggerEvent("redemrp:SetSomeMoney", source, args[1], args[2], function(cb)
 print("Money Setted")
 end)
 

 end
end, false)

RegisterCommand("setlevel", function(source, args, rawCommand)

 if args[1] == nil or args[2] == nil then
 print("argument #1 or #2 is bad")
 else
    TriggerEvent("redemrp:SetSomeLevel", source, args[1], args[2], function(cb)
 print("Level Setted")
 end)
 

 end
end, false)

RegisterCommand("setxp", function(source, args, rawCommand)

 if args[1] == nil or args[2] == nil then
 print("argument #1 or #2 is bad")
 else
    TriggerEvent("redemrp:SetSomeXP", source, args[1], args[2], function(cb)
 print("XP Setted")
 end)
 

 end
end, false)

RegisterCommand("setjob", function(source, args, rawCommand)
    if args[1] == nil or args[2] == nil or args[3] == nil then
    print("argument #1 or #2 or #3 is bad")
    else
    
        TriggerEvent("redemrp:SetSomeJob", source, args[1], args[2], args[3], function(cb)
    print("Job Setted")
    end)
    
   
    end
   end, false)

RegisterCommand("addmoney", function(source, args, rawCommand)

 if args[1] == nil or args[2] == nil then
 print("argument #1 or #2 is bad")
 else
    TriggerEvent("redemrp:AddSomeMoney", source, args[1], args[2], function(cb)
 print("Money Added")
 end)
 

 end
end, false)


RegisterCommand("addgold", function(source, args, rawCommand)

 if args[1] == nil or args[2] == nil then
 print("argument #1 or #2 is bad")
 else
    TriggerEvent("redemrp:AddSomeGold", source, args[1], args[2], function(cb)
 print("Gold Added")
 end)
 

 end
end, false)

RegisterCommand("addxp", function(source, args, rawCommand)

 if args[1] == nil or args[2] == nil then
 print("argument #1 or #2 is bad")
 else
    TriggerEvent("redemrp:AddSomeXP", source, args[1], args[2], function(cb)
 print("XP Added")
 end)
 

 end
end, false)

RegisterCommand("removemoney", function(source, args, rawCommand)

 if args[1] == nil or args[2] == nil then
 print("argument #1 or #2 is bad")
 else
    TriggerEvent("redemrp:RemoveSomeMoney", source, args[1], args[2], function(cb)
 print("Money Removed")
 end)
 

 end
end, false)

RegisterCommand("removegold", function(source, args, rawCommand)

 if args[1] == nil or args[2] == nil then
 print("argument #1 or #2 is bad")
 else
    TriggerEvent("redemrp:RemoveSomeGold", source, args[1], args[2], function(cb)
 print("Gold Removed")
 end)
 

 end
end, false)

RegisterCommand("setgroup", function(source, args, rawCommand)

 if args[1] == nil or args[2] == nil then
 print("argument #1 or #2 is bad")
 else
    TriggerEvent("redemrp:SetSomeGroup", source, args[1], args[2], function(cb)
 print("Group Setted")
 end)
 

 end
end, false)
else end

AddEventHandler("redemrp:SetSomeGold", function(source, id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	--print(pg.getGroup())
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		--print(user.getIdentifier())
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

AddEventHandler("redemrp:SetSomeJob", function(id, count, grade, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	--print(pg.getGroup())
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		--print(user.getIdentifier())
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
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		--print(user.getIdentifier())
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
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		--print(user.getIdentifier())
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
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
			--print(user.getIdentifier())
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
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		--print(user.getIdentifier())
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
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		--print(user.getIdentifier())
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
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		--print(user.getIdentifier())
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
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		--print(user.getIdentifier())
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
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if _perm ~= 0 and (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		--print(user.getIdentifier())
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
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if _perm ~= 0 and pg.getGroup() ~= 'superadmin' then
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN SUPER ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		--print(user.getIdentifier())
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