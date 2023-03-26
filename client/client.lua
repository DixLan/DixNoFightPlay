function spawnped(V3Co, Ped, WeaponName)
    local player = PlayerPedId()
    local pos = V3Co
    
    local pedName = Ped
    local pedHash = GetHashKey(pedName)

    RequestModel(pedHash)
    while not HasModelLoaded(pedHash) do
        Citizen.Wait(10)
        print("loading")
    end

    local FighterPed = CreatePed(9, pedHash, pos.x, pos.y, pos.z, 0, true, false)

    local weaponName = WeaponName
    local weaponHash = GetHashKey(weaponName)

    SetBlockingOfNonTemporaryEvents(FighterPed, true)

    GiveWeaponToPed(FighterPed, weaponHash, 1000, false, true)

    --TaskCombatHatedTargetsInArea(FighterPed, x, y, z, radius, p5)

    TaskCombatPed(FighterPed, player, 0, 16)
end

RegisterCommand("ped", function (source, args, rawcommand)
    print("In progress...")
    for k, v in pairs(Config.Pos.zone1) do
        print(k.." - "..v)
        spawnped(v, "csb_mweather", "weapon_assaultrifle")
    end
end)

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