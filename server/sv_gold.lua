
RegisterServerEvent("redemrp:SetSomeGold")
AddEventHandler("redemrp:SetSomeGold", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
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

RegisterServerEvent("redemrp:SetSomeJob")
AddEventHandler("redemrp:SetSomeJob", function(id, count, grade, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
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
	
RegisterServerEvent("redemrp:SetSomeMoney")
AddEventHandler("redemrp:SetSomeMoney", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
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
	
RegisterServerEvent("redemrp:AddSomeGold")
AddEventHandler("redemrp:AddSomeGold", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
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
	
RegisterServerEvent("redemrp:AddSomeMoney")
AddEventHandler("redemrp:AddSomeMoney", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
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
	
RegisterServerEvent("redemrp:RemoveSomeGold")
AddEventHandler("redemrp:RemoveSomeGold", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
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
	
RegisterServerEvent("redemrp:RemoveSomeMoney")
AddEventHandler("redemrp:RemoveSomeMoney", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
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
	
RegisterServerEvent("redemrp:AddSomeXP")
AddEventHandler("redemrp:AddSomeXP", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
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
	
RegisterServerEvent("redemrp:SetSomeLevel")
AddEventHandler("redemrp:SetSomeLevel", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
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
	
RegisterServerEvent("redemrp:SetSomeXP")
AddEventHandler("redemrp:SetSomeXP", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if (pg.getGroup() ~= "admin" and pg.getGroup() ~= "superadmin") then
	
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
	
RegisterServerEvent("redemrp:SetSomeGroup")
AddEventHandler("redemrp:SetSomeGroup", function(id, count, cb)
	local _perm = tonumber(source)
	TriggerEvent('redemrp:getPlayerFromId', _perm, function(pg)
	if pg.getGroup() ~= 'superadmin' then
	
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