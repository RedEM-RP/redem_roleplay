function CreateRoleplayPlayer(source, identifier, name, money, gold, license, group, firstname, lastname, xp, level, job, jobgrade)
	local self = {}

	self.source = source
	self.gold = gold
	self.group = group
	self.firstname = firstname
	self.lastname = lastname
	self.xp = xp
	self.level = level
	self.job = job
	self.jobgrade = jobgrade

	local rTable = {}

	-- SETS LEVELwXP
	rTable.setLevelwXP = function(m)
		if type(m) == "number" then
			if m > self.level then
				self.level = m
				TriggerClientEvent('redemrp:addLevel', self.source, m)
				TriggerClientEvent('redemrp:activateLevel', self.source , self.level)
			else
				self.level = m
				TriggerClientEvent('redemrp:removeLevel', self.source, m)
				TriggerClientEvent('redemrp:activateLevel', self.source , self.level)
			end

		else
			print('REDEMRP_ERROR: There seems to be an issue while setting level, something else then a number was entered.')
		end
	end
	-- SETS LEVEL
	rTable.setLevel = function(m)
		if type(m) == "number" then
			
				self.level = m
				rTable.addXP(Levels[m] - self.xp)
				TriggerClientEvent('redemrp:addLevel', self.source, self.level)
				TriggerClientEvent('redemrp:activateLevel', self.source , self.level)

		else
			print('REDEMRP_ERROR: There seems to be an issue while setting level, something else then a number was entered.')
		end
	end
	
	rTable.setXP = function(m)
		if type(m) == "number" then
				self.xp = m
				TriggerClientEvent('redemrp:addXP', self.source, m)
				TriggerClientEvent('redemrp:activateXP', self.source , self.xp)
			local case = 1, lvlNow, lvlNew
            while true do
                if self.xp > Levels[case] then
                    case = case + 1
                else 
                lvlNow = case
                break
                end
            end
            case = 1
            while true do
				cache = case + 1
                if m > Levels[cache] then
                    case = case + 1
                else 
                lvlNew = case
                break
                end
            end

            if lvlNow ~= lvlNew then
               --print("New level from " .. lvlNow .. " to " .. lvlNew)
			   rTable.setLevel(tonumber(lvlNew))
        else
        --print("Old level " .. lvlNow .. " == " .. lvlNew)
            end
		else
			print('REDEMRP_ERROR: There seems to be an issue while setting xp, something else then a number was entered.')
		end
	end
	
	rTable.setFirstname = function(m)
		if type(m) == "string" then
			TriggerEvent("redemrp:setPlayerData", self.source, "firstname", m, function(response, success)
				self.firstname = m
			end)
		else
			print('REDEMRP_ERROR: There seems to be an issue while setting firstname, something else then a text was entered.')
		end
	end
	
	rTable.setLastname = function(m)
		if type(m) == "string" then
			TriggerEvent("redemrp:setPlayerData", self.source, "lastname", m, function(response, success)
				self.lastname = m
			end)
		else
			print('REDEMRP_ERROR: There seems to be an issue while setting lastname, something else then a text was entered.')
		end
	end

	rTable.setJob = function(m)
		if type(m) == "string" then
			--TriggerEvent("redemrp:setPlayerData", self.source, "job", m, function(response, success)
				self.job = m
			--end)
		else
			print('REDEMRP_ERROR: There seems to be an issue while setting job, something else then a text was entered.')
		end
	end

	rTable.setJobgrade = function(m)
		if type(m) == "number" then
			--TriggerEvent("redemrp:setPlayerData", self.source, "jobgrade", m, function(response, success)
				self.jobgrade = m
			--end)
		else
			print('REDEMRP_ERROR: There seems to be an issue while setting jobgrade, something else then a text was entered.')
		end
	end
	
	rTable.addXP = function(m)
        if type(m) == "number" then
            local newXP = self.xp + m

            local case = 1, lvlNow, lvlNew
            while true do
                if self.xp > Levels[case] then
                    case = case + 1
                else 
                lvlNow = case
                break
                end
            end
            case = 1
            while true do
                if newXP > Levels[case] then
                    case = case + 1
                else 
                lvlNew = case
                break
                end
            end

            if lvlNow ~= lvlNew then
               --print("New level from " .. lvlNow .. " to " .. lvlNew)
			   rTable.setLevelwXP(tonumber(lvlNew))
        else
        --print("Old level " .. lvlNow .. " == " .. lvlNew)
            end
			

			--self.xp = newXP
			if newXP > self.xp then
				self.xp = newXP
			TriggerClientEvent('redemrp:addXP', self.source, m)
			TriggerClientEvent('redemrp:activateXP', self.source , self.xp)
			else
				self.xp = newXP
			TriggerClientEvent('redemrp:removeXP', self.source, m)
			TriggerClientEvent('redemrp:activateXP', self.source , self.xp)
			end
            
        else
            print('REDEMRP_ERROR: There seems to be an issue while adding xp, a different type then number was trying to be added.')
        end
    end
	
	-- Sets a players gold balance
	rTable.setGold = function(m)
		if type(m) == "number" then
				self.gold = m

			TriggerClientEvent('redemrp:addGold', self.source, self.gold)
			TriggerClientEvent('redemrp:activateGold', self.source , self.gold)
		else
			print('REDEMRP_ERROR: There seems to be an issue while setting gold, something else then a number was entered.')
		end
	end

	rTable.getGold = function()
		return self.gold
	end

	-- Kicks the player with the specified reason
	rTable.kick = function(r)
		DropPlayer(self.source, r)
	end

	rTable.addMoney = function(m)
		if type(m) == "number" then
			local newMoney = self.money + m

			self.money = newMoney
			
	

			TriggerClientEvent('redemrp:addMoney', self.source, m)
			TriggerClientEvent('redemrp:activateMoney', self.source , self.money)
		else
			print('REDEMRP_ERROR: There seems to be an issue while adding money, a different type then number was trying to be added.')
		end
	end

	-- Removes money from the user
	rTable.removeMoney = function(m)
		if type(m) == "number" then
			local newMoney = self.money - m

			self.money = newMoney

			TriggerClientEvent('redemrp:removeMoney', self.source, m)
			TriggerClientEvent('redemrp:activateMoney', self.source , self.money)
		else
			print('REDEMRP_ERROR: There seems to be an issue while removing money, a different type then number was trying to be removed.')
		end
	end

	-- Adds money to a users gold
	rTable.addGold = function(m)
		if type(m) == "number" then
			local newGold = self.gold + m
			self.gold = newGold

			TriggerClientEvent('redemrp:addGold', self.source, m)
			TriggerClientEvent('redemrp:activateGold', self.source , self.gold)
		else
			print('REDEMRP_ERROR: There seems to be an issue while adding to gold, a different type then number was trying to be added.')
		end
	end

	-- Removes money from a users gold
	rTable.removeGold = function(m)
		if type(m) == "number" then
			local newGold = self.gold - m
			self.gold = newGold
			
			TriggerClientEvent('redemrp:removeGold', self.source, m)
			TriggerClientEvent('redemrp:activateGold', self.source , self.gold)
		else
			print('REDEMRP_ERROR: There seems to be an issue while removing from gold, a different type then number was trying to be removed.')
		end
	end
	
	rTable.getXP = function()
		return self.xp
	end
	
	rTable.getName = function()
		return self.firstname .. " " .. self.lastname
	end
	
	rTable.getLevel = function()
		return self.level
	end
	
	rTable.getFirstname = function()
		return self.firstname
	end
	
	rTable.getLastname = function()
		return self.lastname
	end

	rTable.getJob = function()
		return self.job
	end

	rTable.getJobgrade = function()
		return self.jobgrade
	end


	rTable.setSessionVar = function(key, value)
		self.session[key] = value
	end


	rTable.getSessionVar = function(k)
		return self.session[k]
	end

	-- Returns a users permission level
	rTable.getPermissions = function()
		return self.permission_level
	end


	rTable.getIdentifier = function(i)
		return self.identifier
	end

	rTable.getGroup = function()
		return self.group
	end

	-- Global set
	rTable.set = function(k, v)
		self[k] = v
	end

	-- Global get
	rTable.get = function(k)
		return self[k]
	end


	rTable.setGlobal = function(g, default)
		self[g] = default or ""

		rTable["get" .. g:gsub("^%l", string.upper)] = function()
			return self[g]
		end

		rTable["set" .. g:gsub("^%l", string.upper)] = function(e)
			self[g] = e
		end

		Users[self.source] = rTable
	end

	return rTable
end
