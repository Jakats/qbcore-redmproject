local charPed = nil
local choosingCharacter = false
local cams = {
    {
        type = "customization",
        x = -561.8157,
        y = -3780.966,
        z = 239.0805,
        rx = -4.2146,
        ry = -0.0007,
        rz = -87.8802,
        fov = 30.0
    },
    {
        type = "selection",
        x = -562.8157,
        y = -3776.266,
        z = 239.0805,
        rx = -4.2146,
        ry = -0.0007,
        rz = -87.8802,
        fov = 30.0
    }
}

Config = {
    PedCoords = vector4(-558.9098, -3775.616, 238.59, 137.98), 
    HiddenCoords = vector4(-558.9098, -3775.616, 238.59, 137.98), 
    -- CamCoords = vector4(-814.02, 179.56, 76.74, 198.5), 
}

Citizen.CreateThread(function()
    RequestImap(-1699673416)
    RequestImap(1679934574)
    RequestImap(183712523)
    
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerEvent('qb-multicharacter:client:chooseChar')
			return
		end
	end
end)

RegisterNUICallback('cDataPed', function(data) -- Visually seeing the char
    local cData = data.cData  
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)

    if cData ~= nil then
        QBCore.Functions.TriggerCallback('qb-multicharacter:server:getSkin', function(model, data)
            model = model ~= nil and tonumber(model) or false
            if model ~= nil then
                Citizen.CreateThread(function()
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                    end
                    charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z, Config.PedCoords.w, false, true)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    PlaceObjectOnGroundProperly(charPed)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                    data = json.decode(data)
                    TriggerEvent('qb-clothing:client:loadPlayerClothing', data, charPed)
                end)
            else
                Citizen.CreateThread(function()
                    local randommodels = {
                        "mp_male",
                        "mp_female",
                    }
                    local model = GetHashKey(randommodels[math.random(1, #randommodels)])
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                    end
                    charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z, Config.PedCoords.w, false, true)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    PlaceObjectOnGroundProperly(charPed)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                end)
            end
        end, cData.citizenid)
    else
        Citizen.CreateThread(function()
            local randommodels = {
                "mp_male",
                "mp_female",
            }
            local model = GetHashKey(randommodels[math.random(1, #randommodels)])
            RequestModel(model)
            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end
            charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.w, false, true)
            FreezeEntityPosition(charPed, false)
            SetEntityInvincible(charPed, true)
            PlaceObjectOnGroundProperly(charPed)
            SetBlockingOfNonTemporaryEvents(charPed, true)
        end)
    end
end)

RegisterNUICallback('selectCharacter', function(data) -- When a char is selected and confirmed to use
    local cData = data.cData
    DoScreenFadeOut(10)
    TriggerServerEvent('qb-multicharacter:server:loadUserData', cData)
    giveUI(false)
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
end)

RegisterNUICallback('setupCharacters', function() -- Present char info
    QBCore.Functions.TriggerCallback("qb-multicharacter:server:loadUserInfo", function(result)
        SendNUIMessage({
            action = "setupCharacters",
            characters = result
        })
    end)
end)

RegisterNUICallback('removeBlur', function()
    SetTimecycleModifier('default')
end)

RegisterNUICallback('createNewCharacter', function(data) -- Creating a char
    DoScreenFadeOut(150)
    if data.gender == "Male" then
        data.gender = 0
    elseif data.gender == "Female" then
        data.gender = 1
    end

    TriggerServerEvent('qb-multicharacter:server:createCharacter', data)
    Citizen.Wait(500)
end)

RegisterNUICallback('removeCharacter', function(data) -- Removing a char
    TriggerServerEvent('qb-multicharacter:server:deleteCharacter', data.citizenid)
    TriggerEvent('qb-multicharacter:client:chooseChar')
end)

RegisterNUICallback('disconnectButton', function() -- Disconnect
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
    TriggerServerEvent('qb-multicharacter:server:disconnect')
end)

RegisterNetEvent('qb-multicharacter:client:chooseChar')
AddEventHandler('qb-multicharacter:client:chooseChar', function()
    SetNuiFocus(false, false)
    DoScreenFadeOut(10)
    Citizen.Wait(1000)
    GetInteriorAtCoords(-558.9098, -3775.616, 238.59, 137.98)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), Config.HiddenCoords.x, Config.HiddenCoords.y, Config.HiddenCoords.z)
    Citizen.Wait(1500)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    Citizen.Wait(10)
    giveUI(true)
end)

RegisterNetEvent('qb-multicharacter:client:closeNUI')
AddEventHandler('qb-multicharacter:client:closeNUI', function()
    SetNuiFocus(false, false)
end)

function giveUI(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    choosingCharacter = bool
    Citizen.Wait(100)
    skyCam(bool)
end

function skyCam(bool)
    if bool then
        DoScreenFadeIn(1000)
        SetTimecycleModifier('hud_def_blur')
        SetTimecycleModifierStrength(1.0)
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA")    
        SetCamCoord(cam, -555.925,-3778.709,238.597)
        SetCamRot(cam, -20.0, 0.0, 83)
        SetCamActive(cam, true)    
        RenderScriptCams(true, false, 1, true, true)
        fixedCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
        SetCamCoord(fixedCam, -561.206,-3776.224,239.597)
        SetCamRot(fixedCam, -20.0, 0, 270.0)
        SetCamActive(fixedCam, true)
        SetCamActiveWithInterp(fixedCam, cam, 3900, true, true)
        Wait(3900)
        DestroyCam(groundCam)
        InterP = true
    else
        SetTimecycleModifier('default')
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(PlayerPedId(), false)
    end
end
