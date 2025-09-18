PauseMenuOpened = false
Camera = nil

local function displayUi(type)
    SendNuiMessage(json.encode({
        type = type,
    }))
end

local function openLink(url)
    SendNuiMessage(json.encode({
        type = "openLink",
        link = url
    }))

end
local function doCameraCinematic()
    local ped = PlayerPedId()
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.5, 0.6)
    local heading = GetEntityHeading(ped)-180
    Camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x,coords.y,coords.z, 0.0, 0.0, heading, 60.0, true, 0)

    RenderScriptCams(true, true, 1000, false, false)
end

local function deleteCamera()
    RenderScriptCams(false, true, 1000, false, false)
    DestroyCam(Camera, false)
end

function CloseUi()
    SetNuiFocus(false, false)
    PauseMenuOpened = false
    displayUi("hide")
    deleteCamera()
end


-- Command --
RegisterCommand('+pengu_pausemenu', function()
    if GetCurrentFrontendMenuVersion() == -1 and not IsNuiFocused() then
        SetNuiFocus(true, true)
        PauseMenuOpened = true
        displayUi("show")
        doCameraCinematic()
    end
end)

RegisterKeyMapping('+pengu_pausemenu', 'Pause Menu', 'keyboard', 'ESCAPE')

RegisterNuiCallback('menuEvent', function(data, cb)
    local type = data.type
    if type == "exit" then
        CloseUi()
    elseif type == "resume" then
        CloseUi()
    elseif type == "quit" then
        CloseUi()
        QuitGame()
    elseif type == "map" then
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), false, -1)
        Wait(100)
        PauseMenuceptionGoDeeper(0)
        CloseUi()
        while true do
            Wait(1)
            if IsControlJustPressed(0, 200) then
                SetFrontendActive(0)
                Wait(1)
                break
            end
        end
    elseif type == "settings" then
        CloseUi()
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), false, -1)
    elseif type == "store" then
        openLink("https://penguscripts.tebex.io/")
    end
end)


-- Loop --
CreateThread(function()
    AddTextEntry('FE_THDR_GTAO', Config.NativePauseMenuText)
    while true do
        if PauseMenuOpened then
            SetPauseMenuActive(false)
        end
        Wait(1)
    end
end)




-- BE-A-DICK-WORKSPACE