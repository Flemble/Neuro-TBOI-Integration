local IntegrationGameData = RegisterMod("IntegrationGameData", 1)

-- Comments outside of functions explain what all functions below it do until the next comment

-- Request pickups data (includes hearts, coins, bombs, keys, pills, cards/runes, sacks, trinkets, active items)
function IntegrationGameData:GetPlayerPickupsData(_IntegrationGameData) 
    local Identifier = "Player Pickups"
    local player = Isaac.GetPlayer(0)
    
    local HP = player:GetHearts() + player:GetSoulHearts() + player:GetEternalHearts() + player:GetBoneHearts() + player:GetRottenHearts()
    local CoinAmount = player:GetNumCoins()
    local BombAmount = player:GetNumBombs()
    local KeyAmount = player:GetNumKeys()

    local AreBombsGolden = player:HasGoldenBomb()
    local AreKeysGolden = player:HasGoldenKey()

    DumpPickups = {Identifier, HP, CoinAmount, BombAmount, KeyAmount, AreBombsGolden, AreKeysGolden}
end

function IntegrationGameData:GetPlayerConsumables(_IntegrationGameData)
    local Identifier = "Consumables"
end

function IntegrationGameData:GetPlayerTrinkets(_IntegrationGameData)
    local Identifier = "Trinkets"
end

function IntegrationGameData:GetPlayerActiveItems(_IntegrationGameData)
    local Identifier = "Active Items"
end

-- This dumps data into the websocket
-- When communicating with integration, make sure data has been confirmed read by the integration
function IntegrationGameData:DumpData(_IntegrationGameData)

end
