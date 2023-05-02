RedEM = {}
RedEM.Version = Config.Version
RedEM.Config = Config
RedEM.Players = {}
RedEM.DB = {}
RedEM.ClientCallbacks = {}
RedEM.ServerCallbacks = {}
RedEM.PlayerCoords = {}
local DBData

exports("RedEM", function()
    return RedEM
end)

RedEM.GetInventory = function()
    local inv = nil
    local timeout = 0
    TriggerEvent("redemrp_inventory:getData", function(ret)
        inv = ret
    end)
    while inv == nil do Wait(100) ; timeout = timeout + 1 ; if timeout > 100 then print("[redemrp] Getting Inventory timed out...") ; break end end
    return inv
end

RedEM.GetPlayer = function(playerId)
    playerId = tonumber(playerId)
    if RedEM.Players then
        if RedEM.Players[playerId] then
            return RedEM.Players[playerId]
        else
            return nil
        end
    else
        return nil
    end
end

RedEM.GetPlayerByCitizenId = function(cid)
    if RedEM.Players then
        for k,v in pairs(RedEM.Players) do
            if v.citizenid == cid then
                return v
            end
        end
    end
    return nil
end

RedEM.GetAllPlayers = function(cb)
    if RedEM.Players then
        cb(RedEM.Players)
    end
end

RedEM.GetPlayerCB = function(playerId, cb)
    playerId = tonumber(playerId)
    if RedEM.Players then
        if RedEM.Players[playerId] then
            Citizen.Trace("^2[redemrp] ^0Deprecated event used (redemrp:getPlayerFromId)\n^2[redemrp] ^0Please update your scripts to the new standard available at\n^2[redemrp] ^0https://sinatra.gitbook.io/redemrp/developer-documentation/server-scripting-api/player-class")
            cb(RedEM.Players[playerId])
        else
            cb(nil)
        end
    else
        cb(nil)
    end
end
AddEventHandler("redemrp:getPlayerFromId", RedEM.GetPlayerCB)

RegisterServerEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setKickReason)
    local _source = source
    if not RedEM.Functions.GetIdentifier(_source, "steam") then
        setKickReason("Unable to find requested identifier: 'steam', please relaunch RedM")
        CancelEvent()
    end
end)

RedEM.SelectCharacter = function(character)
    local _source = source
    RedEM.DB.LoadCharacter(_source, RedEM.Functions.GetIdentifier(_source, "steam"), character, false)
end
RegisterServerEvent("redemrp:selectCharacter", RedEM.SelectCharacter)

RedEM.DB.CreateCharacter = function(firstname, lastname)
    local _source = source
    local id = RedEM.Functions.GetIdentifier(_source, "steam")
    if firstname and lastname and id then
        local identifier = id
        MySQL.query('SELECT * FROM characters WHERE `identifier`= @identifier', {identifier = identifier}, function(users)
            DBData = users
            local charID = 1
            while CharacterExist(charID) do 
                charID = charID + 1
            end

            local randomPOBoxNum = RedEM.Functions.CreatePOBox()		
            local citizenId = RedEM.Functions.CreateCitizenId()

            MySQL.update('INSERT INTO characters (`identifier`, `firstname`, `lastname`, `money`, `bank`, `characterid`, `citizenid`, `pobox`) VALUES (@identifier, @firstname, @lastname, @money, @bank, @characterid, @citizenid, @pobox);',
            {
                identifier = identifier,
                firstname = firstname,
                lastname = lastname,
                money = RedEM.Config.StartingCash,
                bank = RedEM.Config.StartingBank,
                characterid = charID,
                citizenid = citizenId,
                pobox = randomPOBoxNum,
            }, function(rowsChanged)
                RedEM.DB.LoadCharacter(_source, identifier, charID, true)
            end)
        end)
    end
end
RegisterServerEvent("redemrp:createCharacter", RedEM.DB.CreateCharacter)

RegisterServerEvent("redemrp:TempLoadCharacter")
AddEventHandler("redemrp:TempLoadCharacter", function(charid)
    local _source = source
    RedEM.DB.TempLoadCharacter(_source,charid)
end)

RedEM.DB.TempLoadCharacter = function(_source,charid)
    local identifier = RedEM.Functions.GetIdentifier(_source, "steam")
    MySQL.query('SELECT * FROM characters WHERE `identifier`=@identifier AND `characterid`=@characterid;', {identifier = identifier, characterid = charid}, function(users)
        if users[1] then
            local _user = users[1]
            RedEM.Players[_source] = NewPlayer(_source, charid, _user)
            Citizen.CreateThread(function()
                Wait(3000)
                RedEM.DB.UpdatePlayer(RedEM.Players[_source])
                RedEM.Players[_source] = nil
            end)            
        end
    end)
end

RedEM.DB.LoadCharacter = function(_source, identifier, charid, new)
    MySQL.query('SELECT * FROM characters WHERE `identifier`=@identifier AND `characterid`=@characterid;', {identifier = identifier, characterid = charid}, function(users)
        if users[1] then
            local _user = users[1]
            RedEM.Players[_source] = NewPlayer(_source, charid, _user)

            Player(_source).state['isLoggedIn'] = true

            TriggerEvent('redemrp:playerLoaded', _source, RedEM.Players[_source])
            TriggerClientEvent('redemrp:moneyLoaded', _source, RedEM.Players[_source].money)
            TriggerClientEvent('redemrp:showID', _source, _source)

            TriggerClientEvent("redemrp_charselect:client:FinishSelection", _source, new)
        end
    end)
end

RedEM.SavePlayerData = function()
    SetTimeout(60000, function()
        Citizen.CreateThread(function()
            for k,v in pairs(RedEM.Players) do
                RedEM.DB.UpdatePlayer(v)
            end
            RedEM.SavePlayerData()
        end)
    end)
end
RedEM.SavePlayerData()

RedEM.DB.UpdatePlayer = function(Player)
    Citizen.CreateThread(function()
        local data = {}

        local SaveCoords = true -- We save the player's coords by default.
        if not RedEM.PlayerCoords[Player.source] then -- Check if the player's coords have been reported to the server
            SaveCoords = false -- If they haven't, lets not try to save the player's coords.
        end

        -- Here we set all of the player's information into our data table for the query. We can't simply use the Player table, as it includes lua functions.
        data.citizenid = Player.citizenid
        data.firstname = Player.firstname
        data.lastname = Player.lastname
        data.money = Player.money
        data.bank = Player.bankmoney
        data.job = Player.job
        data.jobgrade = Player.jobgrade
        data.gang = Player.gang
        data.ganggrade = Player.ganggrade
        data.pobox = Player.pobox
        data.jailed = Player.jailed
        data.metadata = json.encode(Player.metadata)
        data.identifier = Player.identifier
        data.characterid = Player.charid

        local query = "UPDATE characters SET `citizenid`=@citizenid,`money`=@money,`bank`=@bank,`job`=@job,`jobgrade`=@jobgrade,`firstname`=@firstname,`lastname`=@lastname,`gang`=@gang,`ganggrade`=@ganggrade,`coords`=@coords,`pobox`=@pobox,`jailed`=@jailed,`metadata`=@metadata WHERE `identifier`=@identifier AND `characterid`=@characterid"
        if SaveCoords then -- If we're saving the player coords, let's add it to the data table.
            data.coords = json.encode(RedEM.PlayerCoords[Player.source])
        else -- We're not saving the player coords, so let's modify the query to exclude it.
            query = "UPDATE characters SET `citizenid`=@citizenid,`money`=@money,`bank`=@bank,`job`=@job,`jobgrade`=@jobgrade,`firstname`=@firstname,`lastname`=@lastname,`gang`=@gang,`ganggrade`=@ganggrade,`pobox`=@pobox,`jailed`=@jailed,`metadata`=@metadata WHERE `identifier`=@identifier AND `characterid`=@characterid"
        end
        MySQL.update(query, data) -- Execute the player data saving query.
    end)
end

RedEM.DB.GetPlayerPermissionGroup = function(identifier)
    local users = MySQL.query.await('SELECT * FROM permissions WHERE `identifier` = ?', { identifier })
    if users[1] then
        return users[1].permissiongroup
    else
        return "user"
    end
end

RedEM.DB.SetPlayerPermissionGroup = function(identifier, group)
    if group ~= "user" then
        MySQL.update('INSERT INTO permissions (identifier, permissiongroup) VALUES (?, ?) ON DUPLICATE KEY UPDATE permissiongroup = ?', { identifier, group, group })
        print("^4[DB]^0 Added identifier ^2" .. identifier .. "^0 to permissions table (^2" .. group .. "^0)")
    else
        MySQL.query('SELECT * FROM permissions WHERE `identifier` = ?', { identifier }, function(result)
            if result[1] then
                MySQL.update('DELETE FROM permissions WHERE `identifier` = ?', { identifier })
                print("^4[DB]^0 Removed identifier ^2" .. identifier .. "^0 from permissions table")
            end
        end)
    end
end

RegisterServerEvent("RedEM:server:RegisterCoords", function(coords)
    local _source = source
    local Player = RedEM.GetPlayer(_source)
    if Player then
        RedEM.PlayerCoords[_source] = coords -- Register the player's coords.
    end
end)

AddEventHandler('playerDropped', function(reason)
    local _source = source
    if RedEM.Players[_source] then
        TriggerEvent("redemrp:playerDropped", RedEM.Players[_source])
        RedEM.DB.UpdatePlayer(RedEM.Players[_source])
        Wait(500)
        RedEM.Players[_source] = nil
    end
end)

RegisterNetEvent("redemrp:PlayerLogout", function()
    local _source = source
    if RedEM.Players[_source] then
        TriggerEvent("redemrp:playerDropped", RedEM.Players[_source])
        RedEM.DB.UpdatePlayer(RedEM.Players[_source])
        Wait(500)
        RedEM.Players[_source] = nil
    end
end)


AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 60 then
        CreateThread(function()
            Wait(45000)
            print("^4[DB]^0 15 seconds before restart... kicking & saving all players!")
            for _, playerId in pairs(GetPlayers()) do
                DropPlayer(tonumber(playerId), "A scheduled server restart is in progress...")
            end
        end)
    end
end)

function CharacterExist (id)
    local test = false
    for k,v in pairs(DBData) do
        if v.characterid == id then
            test = true
        end
    end
    return (test)
end