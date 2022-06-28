--class for users that contains their characters
function User(source, identifier, group, playerwarnings, license)
    local self = {}

    self._identifier = identifier
    self._license = license
    self._group = group
    self._playerwarnings = playerwarnings
    self._usercharacters = {}
    self._numofcharacters = 0
    self.usedCharacterId = -1
    self.source = source

    self.UsedCharacterId = function(value)
        if value ~= nil then
            self.usedCharacterId = value
            self._usercharacters[value].source = self.source
            TriggerClientEvent("vorp:SelectedCharacter", self.source, self.usedCharacterId)

            self._usercharacters[value].updateCharUi()
            TriggerEvent("vorp:SelectedCharacter", self.source, self._usercharacters[self.usedCharacterId].getCharacter())
        end

        return self.usedCharacterId
    end

    self.Source = function(value) if value ~= nil then self.source = value end return self.source end
    self.Numofcharacters = function(value) if value ~= nil then self._numofcharacters = value end return self._numofcharacters end
    self.Identifier = function(value) if value ~= nil then self._identifier = value end return self._identifier end
    self.License = function(value) if value ~= nil then self._license = value end return self._license end

    self.Group = function(value)
        if value ~= nil then
            self._group = value
            exports.ghmattimysql:execute("UPDATE users SET `group` = ? WHERE `identifier` = ?", { self._group, self.Identifier() })
        end

        return self._group
    end

    self.Playerwarnings = function(value)
        if value ~= nil then
            self._playerwarnings = value
            exports.ghmattimysql:execute("UPDATE users SET `warnings` = ? WHERE `identifier` = ?", { self._playerwarnings, self.Identifier() })
        end

        return self._playerwarnings
    end

    self.GetUser = function()
        local character, userCharacters, userData = {}, {}, {}


        userData.getIdentifier = function()
            return self.Identifier()
        end

        userData.getGroup = self.Group()

        userData.getPlayerwarnings = function()
            return self.Playerwarnings()
        end

        userData.setPlayerWarnings = function(warnings)
            self.Playerwarnings(warnings)
        end

        userData.source = self.source

        userData.setGroup = function(group)
            self.Group(group)
        end

        userData.getUsedCharacter = self.UsedCharacter()
        userData.getUserCharacters = self.UserCharacters()

        userData.getNumOfCharacters = function()
            return self._numofcharacters
        end

        userData.addCharacter = function(firstname, lastname, skin, comps)
            self._numofcharacters = self._numofcharacters + 1 --Should not be done like this
            self.addCharacter(firstname, lastname, skin, comps)
        end

        userData.removeCharacter = function(charid)
            if self._usercharacters[charid] then
                self._numofcharacters = self._numofcharacters - 1 --Should not be done like this
                self.delCharacter(charid)
            end
        end

        userData.setUsedCharacter = function(charid)
            self.SetUsedCharacter(charid)
        end

        return userData
    end

    self.UsedCharacter = function()
        if self._usercharacters[self.usedCharacterId] then
            return self._usercharacters[self.usedCharacterId].getCharacter()
        end

        return {}
    end

    self.UserCharacters = function()
        local userCharacters = {}
        for k, v in pairs(self._usercharacters) do
            table.insert(userCharacters, v.getCharacter())
        end
        return userCharacters
    end

    self.LoadCharacters = function()
        exports.ghmattimysql:execute("SELECT * FROM characters WHERE identifier =?", { self._identifier }, function(usercharacters)
            self.Numofcharacters(#usercharacters)

            if #usercharacters > 0 then
                for k, character in ipairs(usercharacters) do
                    if character['identifier'] ~= nil then
                        local newCharacter = Character(self.source, self._identifier, character["charidentifier"], character["group"], character["job"], character["jobgrade"], character["firstname"], character["lastname"], character["inventory"], character["status"], character["coords"], character["money"], character["gold"], character["rol"], character["xp"], character["isdead"], character["skinPlayer"], character["compPlayer"])

                        self._usercharacters[newCharacter.CharIdentifier()] = newCharacter
                        self.usedCharacterId = newCharacter.CharIdentifier()
                    end
                end
                --print("User characters loaded -> "..usercharacters.Count) --Disable this after
            end
        end)
    end

    self.addCharacter = function(firstname, lastname, skin, comps)
        local newChar = Character(self.source, self._identifier, -1, Config.initGroup, Config.initJob, Config.initJobGrade, firstname, lastname, "{}", "{}", "{}", Config.initMoney, Config.initGold, Config.initRol, Config.initXp, false, skin, comps)

        newChar.SaveNewCharacterInDb(function(id)
            newChar.CharIdentifier(id)
            self._usercharacters[id] = newChar
            self.UsedCharacterId(id)
        end)
    end

    self.delCharacter = function(charIdentifier)
        if self._usercharacters[charIdentifier] then
            self._usercharacters[charIdentifier].DeleteCharacter()
            self._usercharacters[charIdentifier] = nil
            --Debug.WriteLine($"Character with charid {charIdentifier} deleted from user {Identifier} successfully");
        end
    end

    self.GetUsedCharacter = function()
        if self._usercharacters[self.UsedCharacterId()] then
            return self._usercharacters[self.UsedCharacterId()]
        else
            return nil
        end
    end

    self.SetUsedCharacter = function(charid)
        if self._usercharacters[charid] then
            self.UsedCharacterId(charid)
        end
    end

    self.SaveUser = function()
        for k, character in pairs(self._usercharacters) do
            character.SaveCharacterInDb()
        end
    end

    return self
end
