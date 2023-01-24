RedEM.Functions = {}


RedEM.StringChars = {}
RedEM.NumberChars = {}

for i = 48, 57 do RedEM.NumberChars[#RedEM.NumberChars + 1] = string.char(i) end
for i = 65, 90 do RedEM.StringChars[#RedEM.StringChars + 1] = string.char(i) end
for i = 97, 122 do RedEM.StringChars[#RedEM.StringChars + 1] = string.char(i) end

RedEM.Functions.CommaValue = function(amount)
    local formatted = amount
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end

RedEM.Functions.GetIdentifier = function(source, idtype)
    for _, identifier in pairs(GetPlayerIdentifiers(source)) do
        if string.find(identifier, idtype) then
            return identifier
        end
    end
    return nil
end

RedEM.Functions.CreateCitizenId = function()
    local UniqueFound = false
    local CitizenId = nil
    while not UniqueFound do
        CitizenId = tostring(RedEM.Functions.RandomStr(3) .. RedEM.Functions.RandomInt(5)):upper()
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM characters WHERE citizenid = ?', { CitizenId })
        if result == 0 then
            UniqueFound = true
        end
    end
    return CitizenId
end

RedEM.Functions.CreatePOBox = function()
    local UniqueFound = false
    local POBox = nil
    while not POBox do
        POBox = tostring(tonumber(RedEM.Functions.RandomInt(6)))
        while #POBox ~= 6 do POBox = tostring(tonumber(RedEM.Functions.RandomInt(6))) end
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM characters WHERE pobox = ?', { POBox })
        if result == 0 then
            UniqueFound = true
        end
    end
    return POBox
end

RedEM.Functions.RandomStr = function(length)
    if length <= 0 then return '' end
    return RedEM.Functions.RandomStr(length - 1) .. RedEM.StringChars[math.random(1, #RedEM.StringChars)]
end

RedEM.Functions.RandomInt = function(length)
    if length <= 0 then return '' end
    return RedEM.Functions.RandomInt(length - 1) .. RedEM.NumberChars[math.random(1, #RedEM.NumberChars)]
end

RedEM.Functions.NotifyLeft = function(source, title, text, texture_dict, texture_name, duration)
    TriggerClientEvent("redem_roleplay:NotifyLeft", source, title, text, texture_dict, texture_name, duration)
end

RedEM.Functions.NotifyRight = function(source, text, duration)
    TriggerClientEvent("redem_roleplay:NotifyRight", source, text, duration)
end