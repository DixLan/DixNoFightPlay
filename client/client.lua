-- Liste des armes pour les peds
local weapons = {
    {name = "weapon_assaultrifle"},
    {name = "weapon_bullpuprifle"},
    {name = "weapon_combatmg"},
    {name = "weapon_gusenberg"}
}

local j = nil
local FighterPed = nil

-- Fonction pour faire spawn les peds avec leur armes
function spawnped(V3Co)

    local player = PlayerPedId(-1)
    local pos = V3Co
    local pedName = nil
    TriggerServerEvent("{[DIXLAN]}:notifSpawn")

    for k, v in pairs(Config.ped) do
        pedName = v
    end
        local pedHash = GetHashKey(pedName)
    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Citizen.Wait(10)
    end
        local FighterPed = CreatePed(9, pedHash, pos.x, pos.y, pos.z, 0, true, false)

        SetPedCombatAttributes(newPed, 0, true) --[[ BF_CanUseCover ]]
        SetPedCombatAttributes(newPed, 5, true) --[[ BF_CanFightArmedPedsWhenNotArmed ]]
        SetPedCombatAttributes(newPed, 46, true) --[[ BF_AlwaysFight ]]
        SetPedFleeAttributes(newPed, 0, true) --[[ allows/disallows the ped to flee from a threat i think]]

        AddRelationshipGroup("ennemies")
        SetPedRelationshipGroupHash(FighterPed, GetHashKey("ennemies"))
        SetRelationshipBetweenGroups(5, GetHashKey("ennemies"), GetHashKey("PLAYER"))
        SetRelationshipBetweenGroups(0, GetHashKey("ennemies"), GetHashKey("ennemies"))

        SetPedArmour(FighterPed, 100)
        SetPedMaxHealth(FighterPed, 100)

        j = math.random(1, #weapons)

        local weaponName = weapons[j].name
        local weaponHash = GetHashKey(weaponName)
        GiveWeaponToPed(FighterPed, weaponHash, 1000, false, true)
        TaskCombatPed(FighterPed, "PLAYER", 0, 16)
end

-- /!\ NOT WORKING FOR THE MOMENT /!\

-- Commandes pour faire spawn dans certaines zone

--RegisterNetEvent("{[DIXLAN]}:SpawnCommand")
--AddEventHandler("{[DIXLAN]}:SpawnCommand", function(source, argument)
--    print("Client Side Event Trigeredd")
--    print("Client Side - "..argument)
--    if argument == "1" then
--        for k, v in pairs(Config.Pos.zone1) do
--            spawnped(v)
--        end
--
--    elseif argument == "2" then
--        for k, v in pairs(Config.Pos.zone2) do
--            spawnped(v)
--        end    
--
--    elseif argument == "3" then
--        for k, v in pairs(Config.Pos.zone3) do
--            spawnped(v)
--        end
--
--    elseif argument == "4" then
--        for k, v in pairs(Config.Pos.zone4) do
--            spawnped(v)
--        end
--
--    elseif argument == "5" then
--        for k, v in pairs(Config.Pos.zone5) do
--            spawnped(v)
--        end
--
--    elseif argument == "6" then
--        for k, v in pairs(Config.Pos.zone6) do
--            spawnped(v)
--        end
--
--    elseif argument == "7" then
--        for k, v in pairs(Config.Pos.zone7) do
--            spawnped(v)
--        end
--    end
--end)

Citizen.CreateThread(function()
local timer = 60000 * 60 -- respawn toutes les 60 minutes 
Citizen.Wait(timer)
    for k, v in pairs(Config.Pos.zone1) do
        spawnped(v)
    end

    for k, v in pairs(Config.Pos.zone2) do
        spawnped(v)
    end

    for k, v in pairs(Config.Pos.zone3) do
        spawnped(v)
    end

    for k, v in pairs(Config.Pos.zone4) do
        spawnped(v)
    end

    for k, v in pairs(Config.Pos.zone5) do
        spawnped(v)
    end

    for k, v in pairs(Config.Pos.zone6) do
        spawnped(v)
    end
end)

-- Blips
Citizen.CreateThread(function()
    for k, v in pairs(Config.blip) do
        local pos = v
        local FightZone = AddBlipForCoord(pos, 100)
        local NumZoneHostile = k
        SetBlipSprite(FightZone, 303)
        SetBlipScale(FightZone, 0.8)
        SetBlipColour(FightZone, 47)
        SetBlipAsShortRange(FightZone, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Zone Hostile ~r~["..NumZoneHostile.."]~s~")
        EndTextCommandSetBlipName(FightZone)
    end
end)