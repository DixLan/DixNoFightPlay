
-- fonction pour faire spawn les peds avec leur armes
function spawnped(V3Co, Ped, WeaponName)
    local player = PlayerPedId(-1)
    local pos = V3Co
    
    local pedName = Ped
    local pedHash = GetHashKey(pedName)

    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Citizen.Wait(10)
        print("loading")
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

    local weaponName = WeaponName
    local weaponHash = GetHashKey(weaponName)
    GiveWeaponToPed(FighterPed, weaponHash, 1000, false, true)
    TaskCombatPed(FighterPed, "PLAYER", 0, 16)
end


-- Commandes pour tester si tout fonctionne
RegisterCommand("ped", function (source, args, rawcommand)
    print("In progress...")
    for k, v in pairs(Config.Pos.zone1) do
        print(k.." - "..v)
        spawnped(v, "csb_mweather", "weapon_assaultrifle")
    end
end)


-- blips
Citizen.CreateThread(function()
    local pos = vector3(-1119.452, 4925.132, 218.3747)
    local FightZone = AddBlipForCoord(pos, 100)
    local NumZoneHostile = 1
    SetBlipSprite(FightZone, 303)
    SetBlipScale(FightZone, 0.8)
    SetBlipColour(FightZone, 47)
    SetBlipAsShortRange(FightZone, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Zone Hostile ~r~["..NumZoneHostile.."]~s~")
    EndTextCommandSetBlipName(FightZone)
end)

Citizen.CreateThread(function()
    SetRelationshipBetweenGroups(0, "test", GetHashKey("csb_mweather"))
end)