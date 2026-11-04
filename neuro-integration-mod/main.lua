local IntegrationGameData = RegisterMod("IntegrationGameData", 1)
local json = require("dkjson")


-- Comments outside of relevant functions explain what all functions below it do until the next comment

function CheckNil(data)
    if not data then
        return json.null
    else
        return data
    end
end


-- Data needs to be sent over a websocket
function DumpData(data) -- [[ NEEDS TO BE IMMUNE TO SPAMMING AND RACE CONDITIONS ]] we'll get there eventually.

end

-- Dumps pickups data (includes hearts, coins, bombs, keys, pills, cards/runes, trinkets)
function IntegrationGameData:DumpPickupsData() -- Figure out how to deny this function if you are just COLLIDING with a pickup
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
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData, PV.PICKUP_HEART) -- MAKE THIS FUNCTION ONLY PASS WHEN PICKING UP VALID PICKUPS
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData, PV.PICKUP_COIN) -- simplify this somehow
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData, PV.PICKUP_KEY)
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData, PV.PICKUP_BOMB)












