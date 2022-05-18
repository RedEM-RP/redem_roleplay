--                                     Licensed under                                     --
-- Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License --

_serverPrefix = "redemrp: "
_VERSION = '1.0.0'
_firstCheckPerformed = false

Users = {}

RegisterServerEvent("redemrp:selectCharacter")
AddEventHandler("redemrp:selectCharacter", function(character)
	local src = source
	TriggerEvent("redem:getPlayerFromId", src, function(user)
		loadCharacter(src, user, character)
	end)
end)

RegisterServerEvent("redemrp:createCharacter")
AddEventHandler("redemrp:createCharacter", function(firstname, lastname)
	local src = source
	TriggerEvent("redem:getPlayerFromId", src, function(user)
		addCharacter(src, user, firstname, lastname)
	end)
end)

RegisterCommand("sc", function(source, args, rawCommand)
	local src = source
	TriggerEvent("redem:getPlayerFromId", src, function(user)
		loadCharacter(src, user, args[1])
	end)
end)

RegisterCommand("ac", function(source, args, rawCommand)
	local src = source
	TriggerEvent("redem:getPlayerFromId", src, function(user)
		addCharacter(src, user, args[1], args[2])
	end)
end)

function loadCharacter(src, user, charid)
	TriggerEvent("redemrp_db:retrieveUser", user.getIdentifier(), charid, function(_user)
		if _user then
			local rpPlayer = CreateRoleplayPlayer(src, _user.identifier, _user.name, _user.money, _user.gold, _user.license, _user.group, _user.firstname, _user.lastname, _user.xp, _user.level, _user.job, _user.jobgrade)
			Users[src] = rpPlayer

			for k, v in pairs(user) do Users[src][k] = v end

			-- Set character related stuff
			Users[src].setMoney(_user.money)
			Users[src].setSessionVar("charid", charid)

			TriggerEvent('redemrp:playerLoaded', src, Users[src]) -- TO OTHER RESOURCES
			TriggerClientEvent('redemrp:moneyLoaded', src, Users[src].getMoney())
			TriggerClientEvent('redemrp:goldLoaded', src, Users[src].getGold())
			TriggerClientEvent('redemrp:xpLoaded', src, Users[src].getXP())
			TriggerClientEvent('redemrp:levelLoaded', src, Users[src].getLevel())
			TriggerClientEvent('redemrp:showID', src, src)
		else
			print("That character does not exist!")
		end
	end)
end

function addCharacter(src, user, firstname, lastname)
	if (firstname and lastname) then
		TriggerEvent("redemrp_db:createUser", user.getIdentifier(), firstname, lastname, function(charID)
			print("Character made!")
			loadCharacter(src, user, charID)
		end)
	end
end

AddEventHandler("redemrp:getPlayerFromId", function(user, cb)
	if (Users) then
		if (Users[user]) then
			cb(Users[user])
		else
			cb(nil)
		end
	else
		cb(nil)
	end
end)

AddEventHandler('playerDropped', function()
	local src = source

	if (Users[src]) then
		TriggerEvent("redemrp:playerDropped", Users[src])
		TriggerEvent("redemrp_db:updateUser", Users[src].getIdentifier(), tonumber(Users[src].getSessionVar("charid")), { money = Users[Source].getMoney(), gold = Users[Source].getGold(), xp = tonumber(Users[Source].getXP()), level = tonumber(Users[Source].getLevel()), job = Users[Source].getJob(), jobgrade = tonumber(Users[Source].getJobgrade()) }, function()
			Users[Source] = false
		end)
	end
end)

AddEventHandler("redemrp:getAllPlayers", function(cb)
	cb(Users)
end)

function getPlayerFromId(charId)
	return Users[charId]
end

local function savePlayerMoney()
	SetTimeout(60000, function()
		Citizen.CreateThread(function()
			for k, v in pairs(Users) do
				if Users[k] then
					TriggerEvent("redemrp_db:updateUser", v.getIdentifier(), tonumber(v.getSessionVar("charid")), { money = v.getMoney(), gold = v.getGold(), xp = tonumber(v.getXP()), level = tonumber(v.getLevel()), job = v.getJob(), jobgrade = tonumber(v.getJobgrade()) }, function()
					end)
				end
			end

			savePlayerMoney()
		end)
	end)
end

savePlayerMoney()

AddEventHandler('redemrp_db:doesUserExist', function(identifier, cb)
	MySQL.Async.fetchAll('SELECT 1 FROM users WHERE `identifier`=@identifier;', { identifier = identifier }, function(users)
		if users[1] then
			cb(true)
		else
			cb(false)
		end
	end)
end)

function CharacterExist(charId, userData)
	local isExist = false
	for k, v in pairs(userData) do
		if v.characterid == charId then
			isExist = true
		end
	end
	return (isExist)
end

AddEventHandler('redemrp_db:createUser', function(identifier, firstname, lastname, callback)
	MySQL.Async.fetchAll('SELECT * FROM characters WHERE `identifier`=@identifier', { identifier = identifier }, function(userData)
		local charId = 1
		while CharacterExist(charId, userData) do
			charId = charId + 1
		end
		print("Found charId " .. charId)
		MySQL.Async.execute('INSERT INTO characters (`identifier`, `firstname`, `lastname`, `characterid`) VALUES (@identifier, @firstname, @lastname, @characterid);',
			{
				identifier = identifier,
				firstname = firstname,
				lastname = lastname,
				characterid = charId

			}, function(rowsChanged)
			callback(charId)
		end)
	end)
end)

AddEventHandler('redemrp_db:retrieveUser', function(identifier, cb)
	MySQL.Async.fetchAll('SELECT * FROM characters WHERE `identifier`=@identifier AND `characterid`=@characterid;', { identifier = identifier, characterid = charid }, function(users)
		if users[1] then
			cb(users[1])
		else
			cb(false)
		end
	end)
end)

AddEventHandler('redemrp_db:updateUser', function(identifier, charid, new, callback)
	Citizen.CreateThread(function()
		local updateString = ""
		local cLength = 1

		for k, v in pairs(new) do
			if cLength < #new then
				if (type(v) == "number") then
					updateString = updateString .. "`" .. k .. "`=" .. v .. ","
				else
					updateString = updateString .. "`" .. k .. "`='" .. v .. "',"
				end
			else
				if (type(v) == "number") then
					updateString = updateString .. "`" .. k .. "`=" .. v .. ""
				else
					updateString = updateString .. "`" .. k .. "`='" .. v .. "'"
				end
			end
			cLength = cLength + 1
		end
		MySQL.Async.execute('UPDATE characters SET ' .. updateString .. ' WHERE `identifier`=@identifier AND `characterid`=@characterid', { identifier = identifier, characterid = charid }, function(done)
			if callback then
				callback(true)
			end
		end)
	end)
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
	if eventData.secondsRemaining == 60 then
		CreateThread(function()
			Wait(45000)
			print("15 seconds before restart... saving all players!")
			for k, v in pairs(Users) do
				DropPlayer(tonumber(k), "A scheduled server restart is in progress")
			end
		end)
	end
end)
