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
    Console.PrintError("\nneuro-integration: cannot find UDP Client") return "failure" end
end

function PingServer()
    if CheckConnection() == "failure" then return end

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

-- Data needs to be sent over UDP 
function DumpData(data) -- [[ NEEDS TO BE IMMUNE TO SPAMMING AND RACE CONDITIONS ]] we'll get there eventually.
    Isaac.ConsoleOutput("\n" ..data)
end

-- Dumps pickups data (includes hearts, coins, bombs, keys, pills, cards/runes, trinkets)
function VerifyPickups(pickup)
    local PV = pickup.Variant
    if PV ~= 10 and PV ~= 20 and PV ~= 30 and PV ~= 40 then return "failure" end

    if pickup:GetSprite():IsPlaying("Collect") then
        return
    else
        return "failure"
    end
end

function IntegrationGameData:DumpPickupsData(pickup)
    if VerifyPickups(pickup) == "failure" then return end
    Isaac.ConsoleOutput("neuro-integration: getting pickups data...")
    local player = Isaac.GetPlayer(0)

    local HitPoints = player:GetHearts() + player:GetSoulHearts() + player:GetEternalHearts() + player:GetBoneHearts() + player:GetRottenHearts()
    local C = player:GetNumCoins()
    local B = player:GetNumBombs()
    local K = player:GetNumKeys()
    local HGB = player:HasGoldenBomb()
    local HGK = player:HasGoldenKey()

    local Pickups = json.encode{HP = HitPoints, Coins = C, Bombs = B, Keys = K, GoldenBomb = HGB, GoldenKey = HGK}
    DumpData(Pickups)
end

function IntegrationGameData:DumpCardData(_IntegrationGameData)
    Isaac.ConsoleOutput("neuro-integration: getting card data...")
    local player = Isaac.GetPlayer(0)

    local PrimaryPocket = player:GetPocketItem(PillCardSlot.PRIMARY):GetSlot()

    local AssignedPrimaryPocket = Isaac.GetItemConfig():GetCard(PrimaryPocket)

    local Consumables = json.encode{PrimaryPocket = AssignedPrimaryPocket.Name}
    DumpData(Consumables)
end

function IntegrationGameData:DumpPillData(_IntegrationGameData)
    local Identifier = "Pills"
end

function IntegrationGameData:DumpTrinketsData(_IntegrationGameData)
    local Identifier = "Trinkets"
end

-- adds callbacks for picking up items to dump their respective data

IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PICKUP_COLLISION, IntegrationGameData.DumpPickupsData)
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PLAYER_COLLECT_CARD, IntegrationGameData.DumpCardData)
IntegrationGameData:AddCallback(ModCallbacks.MC_POST_PLAYER_COLLECT_PILL, IntegrationGameData.DumpPillData)












