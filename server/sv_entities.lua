Entities = {}

function entity(type, location, name, update)
    local self = {}

    self.type = type or "no-persist"
    self.uid = math.random()
    self.location = location or {x = 0.0, y = 0.0, z = 0.0, heading = 0.0}
    self.name = name or "Default"

    self.functions = {}

    self.functions.setLocation = function(x, y, z, heading)
        self.location = {x = x, y = y, z = z, heading = heading}
    end

    self.get = function(key)
        return self[key]
    end

    self.set = function(key, value)
        self[key] = value
        return self[key]
    end

    Entities[self.uid] = self.functions
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