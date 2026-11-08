local IntegrationGameData = RegisterMod("IntegrationGameData", 1)
local json = require("json")
local websocket = require("http.websocket")
local ws = websocket.new_from_uri("ws://127.0.0.1:9002")

-- SOCKET PROTOCOL TESTS
Console.RegisterCommand("Connect", "Connects to websocket", "HelpText", true, AutocompleteType.NONE)
Console.RegisterCommand("EchoTest", "Send test for sending and recieving a TCP echo", "HelpText", true, AutocompleteType.NONE)


function IntegrationGameData:SocketTest(cmd)
    if cmd == "SockTest" then 
        Isaac.ConsoleOutput("Connecting to the Integration websocket...")

        local success, err = assert(ws:connect()) -- A TCP echo server

        if not success then
            assert(ws:close())
            Console.PrintError("Connection failed: " .. err) 
            return 
        end

        Isaac.ConsoleOutput("\nEstablished a client and connected to websocket!")
    else return end
end

function IntegrationGameData:EchoTest(cmd)
    if cmd == "EchoTest" then
        CheckConnection()
        
        local sent, err = assert(ws:send("Testing the websocket!"))
        if not sent then Console.PrintError(err) return end

        Isaac.ConsoleOutput("\nSent data, waiting for response...")

        local data = assert(ws:receive())
        
        Isaac.ConsoleOutput("\nRecieved data: " .. data)
   
        Isaac.ConsoleOutput("\ntests finished.")
    end
end

function CheckConnection() -- empty for now

end

IntegrationGameData:AddCallback(ModCallbacks.MC_EXECUTE_CMD, IntegrationGameData.SocketTest)
IntegrationGameData:AddCallback(ModCallbacks.MC_EXECUTE_CMD, IntegrationGameData.EchoTest)

-- Comments outside of relevant functions explain what all functions below it do until the next comment

function CheckNil(data) -- May be redundant with the json that isaac uses, needs testing
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

-- adds callbacks for picking up items to dump their respective data [[ BUG WITH COLLIDING BUT NOT COLLECTING, NEEDS CUSTOM CALLBACK OR WAY TO VERIFY PICKUPVARIANT IN FUNCTION ]]
local PV = PickupVariant
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData, PV.PICKUP_HEART) -- MAKE THIS FUNCTION ONLY PASS WHEN PICKING UP VALID PICKUPS
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData, PV.PICKUP_COIN) -- simplify this somehow
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData, PV.PICKUP_KEY)
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData, PV.PICKUP_BOMB)












