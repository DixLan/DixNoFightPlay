
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
function spawnped(V3Co, Ped)
    
    local player = PlayerPedId(-1)
    local pos = V3Co
    
    local pedName = Ped
    local pedHash = GetHashKey(pedName)

    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Citizen.Wait(10)
        print("loading ped")
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

        print("Weapon give - "..j)

        local weaponName = weapons[j].name
        local weaponHash = GetHashKey(weaponName)
        GiveWeaponToPed(FighterPed, weaponHash, 1000, false, true)
        TaskCombatPed(FighterPed, "PLAYER", 0, 16)

end



-- Commandes pour tester si tout fonctionne
RegisterCommand("ped", function (source, args, rawcommand)
    print("In progress...")
    if args[1] == "1" then
        for k, v in pairs(Config.Pos.zone1) do
            print(k.." - "..v)
            spawnped(v, "csb_mweather")
        end
    end

    if args[1] == "2" then
        for k, v in pairs(Config.Pos.zone2) do
            print(k.." - "..v)
            spawnped(v, "csb_mweather")
        end
    end

    if args[1] == "3" then
        for k, v in pairs(Config.Pos.zone3) do
            print(k.." - "..v)
            spawnped(v, "csb_mweather")
        end
    end
end)


-- Blips
Citizen.CreateThread(function()
    for k, v in pairs(Config.blip) do
        print(k.." - "..v)
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

Citizen.CreateThread(function()
    
end)