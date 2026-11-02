local IntegrationGameData = RegisterMod("IntegrationGameData", 1)
local json = require("dkjson")


-- Comments outside of relevant functions explain what all functions below it do until the next comment

local ModData, errmsg = io.open("Mod_data.json", "w")
if not ModData then
    Console.PrintError("neuro-integration: Couldn't create or find 'Mod_data.json', data cannot be sent!")
    Console.PrintError(tostring(errmsg))
    return
else
    Isaac.ConsoleOutput("neuro-integration: 'Mod_data.json' found, data can be sent!") 
    Isaac.ConsoleOutput(" Confirming that the integration can see Mod_data.json...") -- [[ doesn't do anything until C++ program can actually change and read the file ]]
    ModData:write("Ping!") -- confirm that the C++ program can read this file by writing a test message to it and wait for a change...
    ModData:close()
end

function CheckNil(data)
    if not data then
        return json.null
    else
        return data
    end
end

-- This dumps data into "Mod_data.json"
-- Currently, previous dumps are erased by the current dump to ensure proper formatting.
function DumpData(data) -- [[ NEEDS TO BE IMMUNE TO SPAMMING AND RACE CONDITIONS ]] we'll get there eventually.
    local ModData, errmsg = io.open("Mod_data.json", "w")
    if not ModData then
        Console.PrintError(" Cannot access 'Mod_data.json' anymore!")
        Console.PrintError(tostring(errmsg))
        return
    else
        Isaac.ConsoleOutput(" Sending data...")
        ModData:write(data)
        ModData:close()
        Isaac.ConsoleOutput(" Data sent to file!")
    end
end

-- Dumps pickups data (includes hearts, coins, bombs, keys, pills, cards/runes, trinkets)
function IntegrationGameData:DumpPickupsData(_IntegrationGameData) 
    Isaac.ConsoleOutput("neuro-integration: Getting pickups data...")
    local player = Isaac.GetPlayer(0)

    local HitPoints = CheckNil(player:GetHearts() + player:GetSoulHearts() + player:GetEternalHearts() + player:GetBoneHearts() + player:GetRottenHearts())
    local C = CheckNil(player:GetNumCoins())
    local B = CheckNil(player:GetNumBombs())
    local K = CheckNil(player:GetNumKeys())
    local HGB = CheckNil(player:HasGoldenBomb())
    local HGK = CheckNil(player:HasGoldenKey())

    local Pickups = json.encode{HP = HitPoints, Coins = C, Bombs = B, Keys = K, GoldenBomb = HGB, GoldenKey = HGK}
    DumpData(Pickups)
end

function IntegrationGameData:DumpConsumables(_IntegrationGameData)
    local Identifier = "Consumables"
end

function IntegrationGameData:DumpTrinkets(_IntegrationGameData)
    local Identifier = "Trinkets"
end

-- adds callbacks for picking up items to dump their respective data [[ BUG WITH COLLIDING BUT NOT COLLECTING, SPAMS CALLBACK, MAY NEED CUSTOM CALLBACK ]]
local PV = PickupVariant
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData, PV.PICKUP_HEART) -- need a way to simplify this, "or" statements don't work
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData, PV.PICKUP_COIN)
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData, PV.PICKUP_KEY)
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData, PV.PICKUP_BOMB)












