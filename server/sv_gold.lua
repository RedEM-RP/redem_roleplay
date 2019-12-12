
RegisterServerEvent("xrp:SetSomeGold")
AddEventHandler("xrp:SetSomeGold", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	--print(pg.getGroup())
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('xrp:getPlayerFromId', _source, function(user)
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

RegisterServerEvent("xrp:SetSomeJob")
AddEventHandler("xrp:SetSomeJob", function(id, count, grade, cb)
	local _perm = tonumber(source)
	TriggerEvent('xrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	--print(pg.getGroup())
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('xrp:getPlayerFromId', _source, function(user)
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
	
RegisterServerEvent("xrp:SetSomeMoney")
AddEventHandler("xrp:SetSomeMoney", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('xrp:getPlayerFromId', _source, function(user)
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
	
RegisterServerEvent("xrp:AddSomeGold")
AddEventHandler("xrp:AddSomeGold", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('xrp:getPlayerFromId', _source, function(user)
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
	
RegisterServerEvent("xrp:AddSomeMoney")
AddEventHandler("xrp:AddSomeMoney", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('xrp:getPlayerFromId', _source, function(user)
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
	
RegisterServerEvent("xrp:RemoveSomeGold")
AddEventHandler("xrp:RemoveSomeGold", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('xrp:getPlayerFromId', _source, function(user)
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
	
RegisterServerEvent("xrp:RemoveSomeMoney")
AddEventHandler("xrp:RemoveSomeMoney", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('xrp:getPlayerFromId', _source, function(user)
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
	
RegisterServerEvent("xrp:AddSomeXP")
AddEventHandler("xrp:AddSomeXP", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('xrp:getPlayerFromId', _source, function(user)
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
	
RegisterServerEvent("xrp:SetSomeLevel")
AddEventHandler("xrp:SetSomeLevel", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('xrp:getPlayerFromId', _source, function(user)
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
	
RegisterServerEvent("xrp:SetSomeXP")
AddEventHandler("xrp:SetSomeXP", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('xrp:getPlayerFromId', _source, function(user)
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
	
RegisterServerEvent("xrp:SetSomeGroup")
AddEventHandler("xrp:SetSomeGroup", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('xrp:getPlayerFromId', _perm, function(pg)
	if pg.getGroup() ~= 'superadmin' then
	
	print(pg.getName() .. " - With ID: " .. _perm .. " - TRIED TO RUN SUPER ADMIN COMMAND WITHOUT PERMISSION")
	
	else
	
	local _source = tonumber(id)
		TriggerEvent('xrp:getPlayerFromId', _source, function(user)
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