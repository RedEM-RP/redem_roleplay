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

    Citizen.CreateThread(function()
        if (update ~= nil) then
            while true do
                Citizen.Wait(1)
                if self.type == "no-persist" then break end
                update(self)
            end
        end
    end)

    Entities[self.uid] = self.functions
end