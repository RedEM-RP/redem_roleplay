--                                     Licensed under                                     --
-- Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License --

_serverPrefix = "XRP: "
_VERSION = 'PRE-LAUNCH 0.1'
_firstCheckPerformed = false
_UUID = LoadResourceFile(GetCurrentResourceName(), "uuid") or "unknown"

Users = {}

RegisterServerEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setKickReason)
	local id
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			id = v
			break
		end
	end

	if not id then
		setKickReason("Unable to find steam identifier', please relaunch Steam and RedM")
		CancelEvent()
	end
end)

RegisterServerEvent("xrp:firstSpawn")
AddEventHandler("xrp:firstSpawn", function(charid)
	local _source = source
	local _charid = tonumber(charid)
    print("XRP: Player activated: " .. GetPlayerName(_source))

    local id
    for k,v in ipairs(GetPlayerIdentifiers(_source))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            id = v
            break
        end
    end
    local subid = "char" .. _charid .. ":" .. string.sub(id, 7)
    registerUser(subid, _source)
end)
 
function registerUser(identifier, source)
	local Source = source
	local once = true
	TriggerEvent("xrp_db:doesUserExist", identifier, function(exists)
		if once then
			once = false
		if exists then
			loadUser(identifier, Source, false)
		else
			local license = "license:rockstardevlicense" -- DISABLED UNTIL LICENSE WILL WORK
			for k,v in ipairs(GetPlayerIdentifiers(Source))do
				if string.sub(v, 1, string.len("license:")) == "license:" then
					license = v
					break
				end
			end
			local name = GetPlayerName(Source)

			TriggerEvent("xrp_db:createUser", identifier, license, name, 25, 1, function()
				loadUser(identifier, Source, true)
			end)
		end
	end
	end)
end

function loadUser(identifier, source, new)
local _source = source
	TriggerEvent("xrp_db:retrieveUser", identifier, function(_user)
		if _user ~= nil then
			local func = CreatePlayer(_source, _user.identifier, _user.name, _user.money, _user.gold, _user.license, _user.group, _user.firstname, _user.lastname, _user.xp, _user.level, _user.job, _user.jobgrade)
			Users[_source] = func
			Users[_source].setSessionVar('idType', 'identifier')
			TriggerEvent('xrp:playerLoaded', _source, Users[_source]) -- TO OTHER RESOURCES
			TriggerClientEvent('xrp:moneyLoaded', _source, Users[_source].getMoney())
			TriggerClientEvent('xrp:goldLoaded', _source, Users[_source].getGold())
			TriggerClientEvent('xrp:xpLoaded', _source, Users[_source].getXP())
			TriggerClientEvent('xrp:levelLoaded', _source, Users[_source].getLevel())
			TriggerClientEvent('xrp:showID', _source, _source)
			
			
			if new then
			TriggerEvent('xrp:firstTimeJoined', _source, Users[_source]) -- TO OTHER RESOURCES
   --print("Player is new")
else 
    --print("Player arleady exist in databse")
end
			
			
	else
	print("Can't Load User")
	end


end)
end

AddEventHandler("xrp:setPlayerData", function(user, k, v, cb)
	if(Users[user])then
		if(Users[user].get(k))then
			if(k ~= "money" and k ~= "gold") then
				Users[user].set(k, v)

				TriggerEvent("xrp_db:updateUser", Users[user].getIdentifier() , {[k] = v}, function(d)
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

AddEventHandler("xrp:getPlayerFromId", function(user, cb)
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
		TriggerEvent("xrp:playerDropped", Users[Source])
		TriggerEvent("xrp_db:updateUser", Users[Source].getIdentifier() ,{name = Users[Source].getName(), money = Users[Source].getMoney(), gold = Users[Source].getGold(), xp = tonumber(Users[Source].getXP()), level = tonumber(Users[Source].getLevel())}, function()
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
					TriggerEvent("xrp_db:updateUser", v.getIdentifier() ,{name = v.getName(), money = v.getMoney(), gold = v.getGold(), xp = tonumber(v.getXP()), level = tonumber(v.getLevel())}, function()
					print("SAVING USER " .. v.getName() .. " - $: " .. v.getMoney() .. " - G: " .. v.getGold() .. " - XP: " .. tonumber(v.getXP()) .. " - LVL: " .. tonumber(v.getLevel()))
					end)
				end
			end

			savePlayerMoney()
		end)
	end)
end

savePlayerMoney()

AddEventHandler('xrp_db:doesUserExist', function(identifier, cb)
    MySQL.Async.fetchAll('SELECT 1 FROM users WHERE `identifier`=@identifier;', {identifier = identifier}, function(users)
        if users[1] then
            cb(true)
        else
            cb(false)
        end
    end)
end)

AddEventHandler('xrp_db:createUser', function(identifier, license, name, cash, gold, callback)
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

AddEventHandler('xrp_db:doesUserExist', function(identifier, callback)
	MySQL.Async.fetchAll('SELECT 1 FROM users WHERE `identifier`=@identifier;', {identifier = identifier}, function(users)
		if users[1] then
			callback(true)
		else
			callback(false)
		end
	end)
end)

AddEventHandler('xrp_db:retrieveUser', function(identifier, callback)
	local Callback = callback
	MySQL.Async.fetchAll('SELECT * FROM users WHERE `identifier`=@identifier;', {identifier = identifier}, function(users)
		if users[1] then
			Callback(users[1])
		else
			Callback(false)
		end
	end)
end)

RegisterServerEvent("xrp:getPlayerData")
AddEventHandler("xrp:getPlayerData", function()
-- TO DO
end)

AddEventHandler('xrp_db:updateUser', function(identifier, new, callback)
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