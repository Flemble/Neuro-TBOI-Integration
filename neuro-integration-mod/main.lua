local IntegrationGameData = RegisterMod("IntegrationGameData", 1)
local json = require("json")
local socket = require("socket")

-- SOCKET PROTOCOL TESTS
Console.RegisterCommand("SockTest", "Tests the Isaac luasocket", "HelpText", true, AutocompleteType.NONE)
Console.RegisterCommand("EchoTest", "Send test for sending and recieving a TCP echo", "HelpText", true, AutocompleteType.NONE)


function IntegrationGameData:SocketTest(cmd)
    if cmd == "SockTest" then 
        Isaac.ConsoleOutput("Testing the Isaac 'LuaSocket' protocol... ")
        Isaac.ConsoleOutput("\nLuaSocket is running version > " .. socket._VERSION) 

        TcpClient = assert(socket.tcp())

        local success, err = TcpClient:connect("tcpbin.com", 4242) -- A TCP echo server

        if not success then
            TcpClient:close()
            Console.PrintError("Connection failed: " .. err) 
            return 
        end

        Isaac.ConsoleOutput("\nEstablished a client and connected it to 'tcpbin.com'!")
        Isaac.ConsoleOutput("\n(Client will expire in 30 seconds.)")
        TcpClient:settimeout(30)
    else return end
end

function IntegrationGameData:EchoTest(cmd)
    if cmd == "EchoTest" then
        CheckConnection()
        
        local sent, err = TcpClient:send("This is a test.\n")
        if not sent then Console.PrintError(err) return end

        Isaac.ConsoleOutput("\nSent data, waiting for response...")

        while true do
            local received, status, partial = TcpClient:receive("*l")
            Isaac.ConsoleOutput(received or partial)
            if status == "closed" then break end
        end
   
        Isaac.ConsoleOutput("\ntests finished.")
    end
end

function CheckConnection()
    if not TcpClient then
    Console.PrintError("Couldn't find a valid connection, have you run 'SockTest'?") return end
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












