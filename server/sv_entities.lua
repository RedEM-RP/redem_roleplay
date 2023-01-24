Entities = {}

function entity(type, location, name, metadata, update)
    local self = {}

    self.type = type or "no-persist"
    self.uid = math.random()
    self.location = location or {x = 0.0, y = 0.0, z = 0.0, heading = 0.0}
    self.metadata = metadata or {}
    self.name = name or "Default"

    self.functions = {}

    self.functions.setLocation = function(x, y, z, heading)
        self.location = {x = x, y = y, z = z, heading = (heading or 0.0)}
    end

    self.functions.getLocation = function()
        return self.location
    end

    self.functions.get = function(key)
        return self[key]
    end

    self.functions.set = function(key, value)
        self[key] = value
        return self[key]
    end

    Entities[self.uid] = self.functions

    print("[RedEM] Entity created(" .. tostring(self.uid) .. "): " .. tostring(self.type) .. " " .. tostring(self.name))
end

Citizen.CreateThread(function()
    for k,v in pairs(Entities)do
        if v.update ~= nil then
            if v.type == "no-persist" then 
                Entities[v.uid] = nil 
            else
                update(v)
            end
        end
    end
end)

function distance (x1, y1, x2, y2)
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt ( dx * dx + dy * dy )
end

entity("npc", {x = -1782.99, y = -383.39, z = 159.05}, "NPC-01", { hash = "A_C_Horse_Arabian_White" })

RegisterCommand("requestentities", function(source, args, rawCommand)
	TriggerClientEvent("redemrp:manual_entity_update", source)
end)

RegisterServerEvent("redemrp:request_entities")
AddEventHandler("redemrp:request_entities", function(x, y)
    print("[RedEM] Entity update requested by: " .. GetPlayerName(source) .. " at x" .. tostring(x) .. ", y" .. tostring(y))

    local _source = source

    local entities = {}

    for k,v in pairs(Entities) do
        if (distance(v.getLocation().x, v.getLocation().y, x, y) < 50.0) then
            entities[k] = {type = v.get('type'), location = v.getLocation(), hash = v.get('metadata')}

            print("[RedEM] Entity sent to client(" .. tostring(v.get('uid')) .. "): " .. v.get('name'))
        end
    end

    TriggerClientEvent("redemrp:full_entity_list", _source, entities)
end)