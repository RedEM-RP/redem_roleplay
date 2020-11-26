local version = 5

updateResourceDatabase = function(resourceName, lastVersion, new)
    if(new)then
        Citizen.CreateThread(function()
            for curVersion = 1,lastVersion do
                local sql = LoadResourceFile(resourceName, "/server/sql/db_" .. curVersion .. ".sql")

                MySQL.Sync.execute(sql, {})
                
                if(curVersion == 1)then
                    MySQL.Sync.execute("INSERT INTO version(id, resource) VALUES(@id, @resource);", { id = curVersion, resource = resourceName })
                    print("^2[RedEM:RP] Database(" .. resourceName .. "): ^0Successfully created database")
                else
                    MySQL.Sync.execute("INSERT INTO version(id, resource) VALUES(@id, @resource);", { id = curVersion, resource = resourceName })
                    print("^2[RedEM:RP] Database(" .. resourceName .. "): ^0Successfully updated database for version: " .. curVersion)
                end
            end

            updateResourceDatabase(resourceName, lastVersion, false)
        end)
    else
        MySQL.Async.fetchAll("SELECT * FROM version WHERE resource=@resource ORDER BY ID DESC", { resource = resourceName }, function(_resourceVersion)            
            if(_resourceVersion[1] == nil)then
                updateResourceDatabase(resourceName, lastVersion, true)
            else
                if(_resourceVersion[1].id == lastVersion)then
                    print("^2[RedEM:RP] Database(" .. resourceName .. "): ^0Your database is fully up to date!")
                else
                    for curVersion = (_resourceVersion[1].id + 1),version do
                        local sql = LoadResourceFile(resourceName, "/server/sql/db_" .. curVersion .. ".sql")

                        MySQL.Sync.execute(sql, {})

                        MySQL.Sync.execute("INSERT INTO version(id, resource) VALUES(@id, @resource);", { id = curVersion, resource = resourceName })
                        print("^2[RedEM:RP] Database(" .. resourceName .. "): ^0Successfully updated database for version: " .. curVersion)
                        updateResourceDatabase(resourceName, lastVersion, false)
                    end
                end
            end
        end)
    end
end

updateDatabase = function(new)
    if(new)then
        Citizen.CreateThread(function()
            for curVersion = 1,version do
                local sql = LoadResourceFile(GetCurrentResourceName(), "/server/sql/db_" .. curVersion .. ".sql")

                MySQL.Sync.execute(sql, {})
                
                if(curVersion == 1)then
                    MySQL.Sync.execute("INSERT INTO version(id, current) VALUES(@id, 'yes');", { id = curVersion })
                    print("^2[RedEM:RP] Database: ^0Successfully created database")
                else
                    MySQL.Sync.execute("UPDATE version SET current='no' WHERE id=@id", { id = curVersion - 1 })
                    MySQL.Sync.execute("INSERT INTO version(id, current) VALUES(@id, 'yes');", { id = curVersion })
                    print("^2[RedEM:RP] Database: ^0Successfully updated database for version: " .. curVersion)
                end
            end

            updateDatabase(false)
        end)
    else
        MySQL.Async.fetchAll("SELECT * FROM version WHERE current='yes'", {}, function(_version)
            if(_version[1] ~= nil and _version[1].id == version)then
                print("^2[RedEM:RP] Database: ^0Your database is fully up to date!")

                TriggerEvent("redemrp:updateDatabase", function(resourceName, lastVersion)
                    updateResourceDatabase(resourceName, lastVersion)
                end)
            else
                for curVersion = (_version[1].id + 1),version do
                    local sql = LoadResourceFile(GetCurrentResourceName(), "/server/sql/db_" .. curVersion .. ".sql")

                    MySQL.Sync.execute(sql, {})

                    MySQL.Sync.execute("UPDATE version SET current='no' WHERE id=@id", { id = curVersion - 1 })
                    MySQL.Sync.execute("INSERT INTO version(id, current) VALUES(@id, 'yes');", { id = curVersion })
                    print("^2[RedEM:RP] Database: ^0Successfully updated database for version: " .. curVersion)
                    updateDatabase(false)
                end
            end
        end)
    end
end

doDatabaseCheck = function()
    MySQL.Async.fetchAll("select schema_name from information_schema.schemata where schema_name = 'redemrp'", {}, function(database)
        if(database == nil or #database == 0)then
            updateDatabase(true)
        else
            MySQL.Async.fetchAll("SHOW TABLES LIKE 'version';", {}, function(versions)
                if(#versions == 0)then
                    MySQL.Async.fetchAll("SHOW TABLES LIKE 'characters';", {}, function(characters)
                        if(#characters == 0)then
                            updateDatabase(true)
                        else
                            print("^1[RedEM:RP] WARNING: ^0Your database is currently setup manually, if you'd like it to be done automatically please remove your current database and restart your server.")
                        end
                    end)
                else
                    updateDatabase(false)
                end
            end)
        end
    end)
end

MySQL.ready(function()
    doDatabaseCheck()
end)

e = function()
    for k,v in ipairs(GetPlayerIdentifiers(1))do
        print(v)
    end
end

e()
