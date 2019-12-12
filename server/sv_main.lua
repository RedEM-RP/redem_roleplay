--                                     Licensed under                                     --
-- Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License --

_serverPrefix = "redemrp: "
_VERSION = 'PRE-LAUNCH 0.1'
_firstCheckPerformed = false
_UUID = LoadResourceFile(GetCurrentResourceName(), "uuid") or "unknown"

Users = {}

AddEventHandler("redem:playerLoaded", function(_source, user)
	local _source = source
	TriggerEvent("redemrp_db:retrieveUser", identifier, function(_user)
		if _user ~= nil then
			local rpPlayer = CreateRoleplayPlayer(_source, _user.identifier, _user.name, _user.money, _user.gold, _user.license, _user.group, _user.firstname, _user.lastname, _user.xp, _user.level, _user.job, _user.jobgrade)
			Users[_source] = rpPlayer

			for k,v in pairs(rpPlayer) do Users[k] = v end

			TriggerEvent('redemrp:playerLoaded', _source, Users[_source]) -- TO OTHER RESOURCES
			TriggerClientEvent('redemrp:moneyLoaded', _source, Users[_source].getMoney())
			TriggerClientEvent('redemrp:goldLoaded', _source, Users[_source].getGold())
			TriggerClientEvent('redemrp:xpLoaded', _source, Users[_source].getXP())
			TriggerClientEvent('redemrp:levelLoaded', _source, Users[_source].getLevel())
			TriggerClientEvent('redemrp:showID', _source, _source)
		else
			
		end
	end)
end)

AddEventHandler("redemrp:setPlayerData", function(user, k, v, cb)
	if(Users[user])then
		if(Users[user].get(k))then
			if(k ~= "money" and k ~= "gold") then
				Users[user].set(k, v)

				TriggerEvent("redemrp_db:updateUser", Users[user].getIdentifier() , {[k] = v}, function(d)
					if d == true then
						cb("Player data edited", true)
					else
						cb(d, false)
					end
					
				end)
			end
			
			if(k == "group") then
				Users[user].set(k, v)
			end
		else
			cb("Column does not exist!", false)
		end
	else
		cb("User could not be found!", false)
	end
end)

AddEventHandler("redemrp:getPlayerFromId", function(user, cb)
	if(Users)then
		if(Users[user])then
			cb(Users[user])
		else
			cb(nil)
		end
	else
		cb(nil)
	end
end)

AddEventHandler('playerDropped', function()
	local Source = source

	if(Users[Source])then
		TriggerEvent("redemrp:playerDropped", Users[Source])
		TriggerEvent("redemrp_db:updateUser", Users[Source].getIdentifier() ,{name = Users[Source].getName(), money = Users[Source].getMoney(), gold = Users[Source].getGold(), xp = tonumber(Users[Source].getXP()), level = tonumber(Users[Source].getLevel())}, function()
		Users[Source] = nil
		end)
	end
end)


function getPlayerFromId(id)
	return Users[id]
end

local function savePlayerMoney()
	SetTimeout(60000, function()
		Citizen.CreateThread(function()
			for k,v in pairs(Users)do
				if Users[k] ~= nil then
					TriggerEvent("redemrp_db:updateUser", v.getIdentifier() ,{name = v.getName(), money = v.getMoney(), gold = v.getGold(), xp = tonumber(v.getXP()), level = tonumber(v.getLevel())}, function()
					print("SAVING USER " .. v.getName() .. " - $: " .. v.getMoney() .. " - G: " .. v.getGold() .. " - XP: " .. tonumber(v.getXP()) .. " - LVL: " .. tonumber(v.getLevel()))
					end)
				end
			end

			savePlayerMoney()
		end)
	end)
end

savePlayerMoney()

AddEventHandler('redemrp_db:doesUserExist', function(identifier, cb)
    MySQL.Async.fetchAll('SELECT 1 FROM users WHERE `identifier`=@identifier;', {identifier = identifier}, function(users)
        if users[1] then
            cb(true)
        else
            cb(false)
        end
    end)
end)

AddEventHandler('redemrp_db:createUser', function(identifier, license, name, cash, gold, callback)
	local user = {
		identifier = identifier,
		name = name,
		money = cash or 0,
		gold = gold or 0,
		license = license,
		group = 'user'
	}

	MySQL.Async.execute('INSERT INTO users (`identifier`, `money`, `gold`, `group`, `license`, `name`) VALUES (@identifier, @money, @gold, @group, @license, @name);',
	{
		identifier = user.identifier,
		name = user.name,
		money = user.money,
		gold = user.gold,
		group = user.group,
		license = user.license
	}, function(rowsChanged)
		callback()
	end)
end)

AddEventHandler('redemrp_db:doesUserExist', function(identifier, callback)
	MySQL.Async.fetchAll('SELECT 1 FROM users WHERE `identifier`=@identifier;', {identifier = identifier}, function(users)
		if users[1] then
			callback(true)
		else
			callback(false)
		end
	end)
end)

AddEventHandler('redemrp_db:retrieveUser', function(identifier, callback)
	local Callback = callback
	MySQL.Async.fetchAll('SELECT * FROM users WHERE `identifier`=@identifier;', {identifier = identifier}, function(users)
		if users[1] then
			Callback(users[1])
		else
			Callback(false)
		end
	end)
end)

RegisterServerEvent("redemrp:getPlayerData")
AddEventHandler("redemrp:getPlayerData", function()
-- TO DO
end)

AddEventHandler('redemrp_db:updateUser', function(identifier, new, callback)
	Citizen.CreateThread(function()
		local updateString = ""

		local length = tLength(new)
		local cLength = 1
		for k,v in pairs(new)do
			if cLength < length then
				if(type(v) == "number")then
					updateString = updateString .. "`" .. k .. "`=" .. v .. ","
				else
					updateString = updateString .. "`" .. k .. "`='" .. v .. "',"
				end
			else
				if(type(v) == "number")then
					updateString = updateString .. "`" .. k .. "`=" .. v .. ""
				else
					updateString = updateString .. "`" .. k .. "`='" .. v .. "'"
				end
			end
			cLength = cLength + 1
		end
		MySQL.Async.execute('UPDATE users SET ' .. updateString .. ' WHERE `identifier`=@identifier', {identifier = identifier}, function(done)
			if callback then
				callback(true)
			end
		end)
	end)
end)

function tLength(t)
	local l = 0
	for k,v in pairs(t)do
		l = l + 1
	end

	return l
end