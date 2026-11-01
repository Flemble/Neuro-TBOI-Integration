local IntegrationGameData = RegisterMod("IntegrationGameData", 1)
local json = require("dkjson")
local ModData = io.open("Mod_data.json", "w+")

if not ModData then
    Console.PrintError("Couldn't find 'Mod_data.json', data cannot be sent!")
    return
end

-- Comments outside of functions explain what all functions below it do until the next comment

function CheckNil(data) -- Checks if data is nil, assigns null if so
    if data == nil then
        data = json.null
    else
        return data
    end
end

-- Request pickups data (includes hearts, coins, bombs, keys, pills, cards/runes, sacks, trinkets)
function IntegrationGameData:GetPlayerPickupsData(_IntegrationGameData) 
    Isaac.ConsoleOutput("Getting pickups data...")
    local Identifier = "Player Pickups"
    local player = Isaac.GetPlayer(0)

    local HP = CheckNil(player:GetHearts() + player:GetSoulHearts() + player:GetEternalHearts() + player:GetBoneHearts() + player:GetRottenHearts())
    local Coins = CheckNil(player:GetNumCoins())
    local Bombs = CheckNil(player:GetNumBombs())
    local Keys = CheckNil(player:GetNumKeys())
    local HasGoldenBomb = CheckNil(player:HasGoldenBomb())
    local HasGoldenKey = CheckNil(player:HasGoldenKey())

    local Pickups = {Identifier, HP, Coins, Bombs, Keys, HasGoldenBomb, HasGoldenKey}

    DumpPickups = json.encode(Pickups)
end

function IntegrationGameData:GetPlayerConsumables(_IntegrationGameData)
    local Identifier = "Consumables"
end

function IntegrationGameData:GetPlayerTrinkets(_IntegrationGameData)
    local Identifier = "Trinkets"
end

-- This dumps data into "Mod_data.json"
-- Since previous dumps are erased by the current dump, make sure multiple and all required dumps are done at the time of request
function IntegrationGameData:DumpData(request)
    ModData:write(request)
    ModData:close()
    Isaac.ConsoleOutput("Data sent to 'Mod_data.json'!")
end

