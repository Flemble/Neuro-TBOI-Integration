local IntegrationGameData = RegisterMod("IntegrationGameData", 1)
local json = require("json")
local socket = require("socket")

-- Comments outside of relevant functions explain what all functions below it do until the next comment

-- UDP SOCKET, INITIALIZATION AND TESTING
function ClientSetup()
    UDPClient = assert(socket.udp())

    UDPClient:settimeout(2)
    assert(UDPClient:setsockname("0.0.0.0",0))
    UDPClient:setpeername("localhost", 1987)
    Isaac.ConsoleOutput("neuro-integration: established a UDP client")

    local PeerListen = UDPClient:getpeername()
    Isaac.ConsoleOutput("\nlistening on peer: " .. PeerListen)

    Console.PrintWarning("\nneuro-integration: pinging server...")
end

function CheckConnection()
    if not UDPClient then
    Console.PrintError("neuro-integration: cannot find UDP Client") return end
end

function PingServer()
    CheckConnection()
    local EstimateDelay = os.clock()
    UDPClient:send("Ping!")

    while true do
        local response, err = UDPClient:receive()

        if not response and err == "timeout" then
            Console.PrintError("neuro-integration: request timeout")
            return
        end

        if response and response:match "Pong!" then
            local EstimateMath = math.floor(((os.clock() - EstimateDelay) * 1000) + 0.5)
            local FinalEstimate = string.format("%s (%dms)", response, EstimateMath)
            Isaac.ConsoleOutput("\n" ..FinalEstimate)

            return
        elseif response then
            Console.PrintError("neuro-integration: " .. err)
            return
        end
    end
end

ClientSetup()
PingServer()

function IntegrationGameData:Connect(cmd)
    if cmd == "Connect" then
        ClientSetup()
    end
end

function IntegrationGameData:ping(cmd)
    if cmd == "ping" then
        PingServer()
    end
end

Console.RegisterCommand("Connect", "Usually the mod connects on init, this attempts another connection", "HelpText", true, AutocompleteType.NONE)
Console.RegisterCommand("ping", "ping the server, times out after 2 seconds", "HelpText", true, AutocompleteType.NONE)
IntegrationGameData:AddCallback(ModCallbacks.MC_EXECUTE_CMD, IntegrationGameData.Connect)
IntegrationGameData:AddCallback(ModCallbacks.MC_EXECUTE_CMD, IntegrationGameData.ping)

-- May be redundant with the json that isaac uses, needs testing
function CheckNil(data) 
    if not data then
        return json.null
    else
        return data
    end
end


-- Data needs to be sent over UDP 
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












