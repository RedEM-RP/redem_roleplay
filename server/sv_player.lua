RedEM.Internal.NewPlayer = function(source, charid, dbdata)
    local self = {}
    self.name = GetPlayerName(source)
    self.license = RedEM.Functions.GetIdentifier(source, 'license')
    self.source = source
    self.identifier = dbdata.identifier
    self.charid = charid
    self.citizenid = dbdata.citizenid
    self.group = nil
    self.money = dbdata.money
    self.bankmoney = dbdata.bank
    self.firstname = dbdata.firstname
    self.lastname = dbdata.lastname
    self.job = dbdata.job
    self.jobgrade = dbdata.jobgrade
    self.gang = dbdata.gang
    self.ganggrade = dbdata.ganggrade
    self.pobox = dbdata.pobox
    self.jailed = dbdata.jailed

    self.metadata = json.decode(dbdata.metadata)
    if self.metadata == nil then self.metadata = {} end
    if not self.metadata.thirst then self.metadata.thirst = 100 end
    if not self.metadata.hunger then self.metadata.hunger = 100 end

    if not self.citizenid then
        self.citizenid = RedEM.Functions.CreateCitizenId()
    end

    if #self.citizenid < 2 then
        self.citizenid = RedEM.Functions.CreateCitizenId()
    end

    if not self.pobox then
        self.pobox = RedEM.Functions.CreatePOBox()
    end

    -- Roll your own discord role permissions sytem here.
    --[[
    local roles = exports["redemrp_discordwl"]:GetDiscordRoles(self.source)
    if roles then
        for i=1,#roles do
            if roles[i] == "ROLEID" then -- Owner
                self.group = "superadmin"
                break
            elseif roles[i] == "ROLEID" then -- Head Admin
                self.group = "superadmin"
                break
            elseif roles[i] == "ROLEID" then -- Admin
                self.group = "admin"
                break
            elseif roles[i] == "ROLEID" then -- Moderator
                self.group = "mod"
                break
            end
        end
    end
    ]]

    if not self.group then self.group = "user" end

    self.SetFirstName = function(m)
        self.firstname = m
        self.SendPlayerDataToClient()
    end

    self.SetLastName = function(m)
        self.lastname = m
        self.SendPlayerDataToClient()
    end

    self.SetJob = function(m)
        self.job = m
        self.SendPlayerDataToClient()
    end

    self.SetJobGrade = function(m)
        self.jobgrade = m
        self.SendPlayerDataToClient()
    end

    self.SetGang = function(m)
        self.gang = m
        self.SendPlayerDataToClient()
    end

    self.SetGangGrade = function(m)
        self.ganggrade = m
        self.SendPlayerDataToClient()
    end

    self.SetJailTime = function(m)
        self.jailed = m
        self.SendPlayerDataToClient()
    end

    -- Kicks the player with the specified reason
    self.kick = function(r)
        DropPlayer(self.source, r)
    end

    self.SetMoney = function(m)
        self.money = m
        TriggerClientEvent("redem:activateMoney", self.source, self.money)
        self.SendPlayerDataToClient()
    end

    self.AddMoney = function(m)
        local newMoney = self.money + m

        self.money = newMoney

        TriggerClientEvent("redem:addMoney", self.source, m)
        TriggerClientEvent("redem:activateMoney", self.source, self.money)
        self.SendPlayerDataToClient()
    end

    -- Removes money from the user
    self.RemoveMoney = function(m)
        local newMoney = self.money - m

        self.money = newMoney

        TriggerClientEvent("redem:removeMoney", self.source, m)
        TriggerClientEvent("redem:activateMoney", self.source, self.money)
        self.SendPlayerDataToClient()
    end

    self.SetBankMoney = function(m)
		self.bankmoney = m
        self.SendPlayerDataToClient()
	end

    self.AddBankMoney = function(m)
        local newMoney = self.bankmoney + m
        self.bankmoney = newMoney
        self.SendPlayerDataToClient()
	end

    -- Removes money from the user
	self.RemoveBankMoney = function(m)
        local newMoney = self.bankmoney - m
        self.bankmoney = newMoney
        self.SendPlayerDataToClient()
	end
    

    self.SetMetaData = function(key, value)
        self.metadata[key] = value
        self.SendPlayerDataToClient()
    end

    self.CitizenId = function() return self.citizenid end
    self.GetMetaData = function() return self.metadata end
    self.GetMoney = function() return self.money end
    self.GetBankMoney = function() return self.bankmoney end
    self.GetName = function() return self.firstname .. " " .. self.lastname end
    self.GetFirstName = function() return self.firstname end
    self.GetLastName = function() return self.lastname end
    self.GetJob = function() return self.job end
    self.GetJobGrade = function() return self.jobgrade end
    self.GetGang = function() return self.gang end
    self.GetGangGrade = function() return self.ganggrade end
    self.GetPOBox = function() return self.pobox end
    self.GetJailTime = function() return self.jailed end
    self.SetSessionVar = function(key, value) self[key] = value end
    self.GetSessionVar = function(k) return self[k] end
    self.GetActiveCharacter = function() return self.charid end
    self.SetActiveCharacter = function(charid) self.charid = charid end
    self.GetPermissions = function() return 0 end -- Deprecated function
    self.GetIdentifier = function(i) return self.identifier end
    self.GetGroup = function() return self.group end
    
    self.set = function(k, v)
        self[k] = v
		self.SendPlayerDataToClient()
    end

    self.get = function(k)
        return self[k]
    end

	self.SendPlayerDataToClient = function()
		local PlayerData = {}
        PlayerData.isLoggedIn = true
        PlayerData.money = self.money
        PlayerData.bankmoney = self.bankmoney
		PlayerData.group = self.group
		PlayerData.firstname = self.firstname
		PlayerData.lastname = self.lastname
		PlayerData.job = self.job
		PlayerData.jobgrade = self.jobgrade
        PlayerData.gang = self.job
        PlayerData.ganggrade = self.ganggrade
        PlayerData.pobox = self.pobox
        PlayerData.jailed = self.jailed
        PlayerData.metadata = self.metadata

        Player(self.source).state.isLoggedIn = true
        Player(self.source).state.money = self.money
        Player(self.source).state.bankmoney = self.bankmoney
		Player(self.source).state.group = self.group
		Player(self.source).state.firstname = self.firstname
		Player(self.source).state.lastname = self.lastname
		Player(self.source).state.job = self.job
		Player(self.source).state.jobgrade = self.jobgrade
        Player(self.source).state.gang = self.gang
        Player(self.source).state.ganggrade = self.ganggrade
        Player(self.source).state.pobox = self.pobox
        Player(self.source).state.jailed = self.jailed
        Player(self.source).state.metadata = self.metadata
	
		TriggerClientEvent("redemrp:receivePlayerData", self.source, PlayerData)
	end

	self.SendPlayerDataToClient()

    self.setJob = self.SetJob -- Deprecated function name
    self.setFirstname = self.SetFirstName -- Deprecated function name
    self.setLastname = self.SetLastName -- Deprecated function name
    self.setJobgrade = self.SetJobGrade -- Deprecated function name
    self.setGang = self.SetGang -- Deprecated function name
    self.setGanggrade = self.SetGangGrade -- Deprecated function name
    self.setJailTime = self.SetJailTime -- Deprecated function name
    self.setMoney = self.SetMoney -- Deprecated function name
    self.getMoney = self.GetMoney -- Deprecated function name
    self.addMoney = self.AddMoney -- Deprecated function name
    self.removeMoney = self.RemoveMoney -- Deprecated function name
    self.getBankMoney = self.GetBankMoney -- Deprecated function name
    self.setBankMoney = self.SetBankMoney -- Deprecated function name
    self.addBankMoney = self.AddBankMoney -- Deprecated function name
    self.removeBankMoney = self.RemoveBankMoney -- Deprecated function name
    self.getName = self.GetName -- Deprecated function name
    self.getFirstname = self.GetFirstName -- Deprecated function name
    self.getLastname = self.GetLastName -- Deprecated function name
    self.getJob = self.GetJob -- Deprecated function name
    self.getJobgrade = self.GetJobGrade -- Deprecated function name
    self.getGang = self.GetGang -- Deprecated function name
    self.getGanggrade = self.GetGangGrade -- Deprecated function name
    self.getPOBox = self.GetPOBox -- Deprecated function name
    self.getJailTime = self.GetJailTime -- Deprecated function name
    self.setSessionVar = self.SetSessionVar -- Deprecated function name
    self.getSessionVar = self.GetSessionVar -- Deprecated function name
    self.getPermissions = self.GetPermissions -- Deprecated function name
    self.getIdentifier = self.GetIdentifier -- Deprecated function name
    self.getGroup = self.GetGroup -- Deprecated function name
    self.setGlobal = self.SetGlobal -- Deprecated function name

    self.getGold = function() return 0 end -- Deprecated function
    self.getXp = function() return 0 end -- Deprecated function
    self.getLevel = function() return 0 end -- Deprecated function

    return self
end