local showDistance = false
local taxiActive = false
local npcSpawned = false
local npcTaxi = nil
local brokenDown = false

Citizen.CreateThread(function()
    Wait(5000)
    TriggerEvent("spawnTaxiNPC")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if showDistance then
            local playerCoords = GetEntityCoords(GetVehiclePedIsIn(PlayerPedId(), false))
            local distance = #(playerCoords - Config.TargetLocation) / 1000
            DrawTxt("Distanz zum Ziel: " .. string.format("%.2f", distance) .. " km", 0.5, 0.95)
        end

        if taxiActive then
            DisableControlAction(0, 75, true)
            DisableControlAction(0, 23, true)
        end

        if npcSpawned then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local npcCoords = GetEntityCoords(npcTaxi)

            if #(playerCoords - npcCoords) < 2.0 then
                DrawTxt("Drücke [E] um ein Taxi zu rufen", 0.5, 0.9)
                if IsControlJustPressed(0, 38) then
                    TriggerEvent("spawnTaxi")
                end
            end
        end
    end
end)

RegisterNetEvent('spawnTaxiNPC')
AddEventHandler('spawnTaxiNPC', function()
    RequestModel(GetHashKey(Config.NPCModel))
    while not HasModelLoaded(GetHashKey(Config.NPCModel)) do
        Wait(500)
    end

    npcTaxi = CreatePed(4, GetHashKey(Config.NPCModel), Config.NPCSpawn.x, Config.NPCSpawn.y, Config.NPCSpawn.z, Config.NPCHeading, false, true)
    FreezeEntityPosition(npcTaxi, true)
    npcSpawned = true
end)

RegisterNetEvent('spawnTaxi')
AddEventHandler('spawnTaxi', function()
    Wait(1000)
    local playerPed = PlayerPedId()

    RequestModel(GetHashKey(Config.TaxiModel))
    while not HasModelLoaded(GetHashKey(Config.TaxiModel)) do
        Wait(500)
    end

    RequestModel(GetHashKey(Config.DriverModel))
    while not HasModelLoaded(GetHashKey(Config.DriverModel)) do
        Wait(500)
    end

    local taxi = CreateVehicle(GetHashKey(Config.TaxiModel), Config.TaxiSpawn.x, Config.TaxiSpawn.y, Config.TaxiSpawn.z, Config.TaxiHeading, true, false)
    local driver = CreatePedInsideVehicle(taxi, 4, GetHashKey(Config.DriverModel), -1, true, false)

    TaskWarpPedIntoVehicle(playerPed, taxi, 2)
    TaskVehicleDriveToCoord(driver, taxi, Config.TargetLocation.x, Config.TargetLocation.y, Config.TargetLocation.z, Config.TaxiSpeed, 0, GetEntityModel(taxi), 786603, 1.0)

    showDistance = true
    taxiActive = true

    Citizen.CreateThread(function()
        Wait(math.random(5000, 15000))
        if not brokenDown then
            brokenDown = true
            TaskVehicleTempAction(driver, taxi, 6, 2000)

            SetVehicleEngineHealth(taxi, 50.0)
            StartParticleFxLoopedOnEntity("exp_grd_flare", taxi, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false)
            Wait(2000)

            TaskLeaveVehicle(driver, taxi, 0)
            Wait(1500)
            TaskGoToCoordAnyMeans(driver, Config.TaxiSpawn.x, Config.TaxiSpawn.y, Config.TaxiSpawn.z + 1.0, 1.0, 0, 0, 1.0)

            SetVehicleDoorOpen(taxi, 4, false, false)
            Wait(1000)

            TaskPlayAnim(driver, "amb@world_human_vehicle_mechanic@male@idle_a", "idle_a", 8.0, -8.0, -1, 1, 0, false, false, false)
            DrawTxt("Panne! Der Fahrer repariert das Taxi...", 0.5, 0.8)

            Wait(math.random(5000, 10000))

            RemoveParticleFxFromEntity(taxi)

            ClearPedTasks(driver)
            TaskEnterVehicle(driver, taxi, -1, -1, 1.0, 0, 0)
            Wait(2000)

            TaskVehicleDriveToCoord(driver, taxi, Config.TargetLocation.x, Config.TargetLocation.y, Config.TargetLocation.z, Config.TaxiSpeed, 0, GetEntityModel(taxi), 786603, 1.0)
            brokenDown = false
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            local distance = #(GetEntityCoords(taxi) - Config.TargetLocation)
            if distance < 5 then
                showDistance = false
                taxiActive = false
                break
            end
        end
    end)
end)

function DrawTxt(text, x, y)
    SetTextFont(4)
    SetTextScale(0.4, 0.4)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextCentre(true)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x, y)
end
