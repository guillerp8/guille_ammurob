ESX = nil



Citizen.CreateThread(function() 
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        TriggerEvent('guille_ammurob:blip')
        Citizen.Wait(0) 
    end 
end)

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local jugador = PlayerPedId()
local iniciado = false
local cajaentregada = false
local anim = true
local pedviva = true
local robable = true


RegisterNetEvent('guille_ammurob:blip')
AddEventHandler('guille_ammurob:blip', function()

    local blip = AddBlipForCoord(vector3(-332.04, 6085.28, 31.44))
    SetBlipSprite(blip, 156)
    SetBlipColour(blip, 40)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('AmmuNation')
    EndTextCommandSetBlipName(blip)


end)


RegisterNetEvent('guille_ammurob:bliprobo')
AddEventHandler('guille_ammurob:bliprobo', function()
	bliprobo = AddBlipForCoord(-332.04, 6085.28, 30.5)

	SetBlipSprite(bliprobo, 161)
	SetBlipScale(bliprobo, 3.2)
	SetBlipColour(bliprobo, 1)
    PulseBlip(bliprobo)
    
end)

RegisterNetEvent('guille_ammurob:borrarblip')
AddEventHandler('guille_ammurob:borrarblip', function()
    RemoveBlip(bliprobo)
end)

RegisterNetEvent('guille_ammurob:disponible')
AddEventHandler('guille_ammurob:disponible', function()
    print('dispo')
    robable = true
    anim = true
    pedviva = true
end)

RegisterNetEvent('guille_ammurob:nodisponible')
AddEventHandler('guille_ammurob:nodisponible', function()
    print('nodispo')
    robable = false

end)




Citizen.CreateThread(function()    
    while true do
        Citizen.Wait(0)
        if anim and IsPedArmed(jugador, 5) and GetDistanceBetweenCoords(vector3(-332.04, 6085.28, 30.5), GetEntityCoords(jugador, true)) < 4 and robable then
            print('check')
            TriggerServerEvent('guille_ammurob:reloj')
            iniciado = true
            TriggerServerEvent('guille_ammurob:avisopasma')
            Citizen.Wait(10)
            ped = crearped2("csb_g", vector3(-330.76, 6084.92, 30.44), 221.96)
            Citizen.Wait(0)
            local pos = GetEntityCoords(ped, false)
            loadDict('missheist_agency2ahands_up')
            TaskPlayAnim(ped, "missheist_agency2ahands_up", "handsup_anxious", 8.0, -8.0, -1, 1, 0, false, false, false)
            Citizen.Wait(20000)
            loadDict("mp_am_hold_up")
            Citizen.Wait(5)
            if not IsPedDeadOrDying(ped) then
                TaskPlayAnim(ped,"mp_am_hold_up","purchase_beerbox_shopkeeper",1.0,-1.0, 5000, 0, 1, true, true, true)
                Citizen.Wait(800)
                objeto = CreateObject(GetHashKey("imp_prop_impexp_cargo_01"), pos.x, pos.y, pos.z, true, true, true)
                NetworkRegisterEntityAsNetworked(objeto)
                SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(objeto, true))
                SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(objeto, true))
                SetEntityAsMissionEntity(objeto)
                AttachEntityToEntity(objeto, ped, GetPedBoneIndex(ped,  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
                Citizen.Wait(3000)
                DetachEntity(objeto, true, false)
                ClearPedTasks(ped)
                anim = false
                cajaentregada = true
                iniciado = false
                DeletePed(ped)
            else
                TriggerServerEvent("guille_ammurob:fuerablip")
                TriggerServerEvent('guille_ammurob:reloj')
                iniciado = false
            end
        end

        while cajaentregada do
            Citizen.Wait(0)
            ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para revisar el contenido de la caja")
            DrawMarker(2, -331.08, 6082.88, 31.44, 0,0,0,0,0,0,0.5,0.5,0.5,255,255,0,165,true,true,0,0)
            if IsControlJustPressed(0, Keys["E"]) and GetDistanceBetweenCoords(vector3(-331.08, 6082.88, 31.44), GetEntityCoords(jugador, true)) < 2 then
                TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                Citizen.Wait(5000)
                ClearPedTasks(PlayerPedId())
                PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                TriggerServerEvent("guille_ammurob:tusmuertos")
                DeleteObject(objeto)
                cajaentregada = false
                robable = false
            end   
        end
    end
end)  

-- Pendiente rehacer este loop asqueroso / I must remake this shitty loop omfg i'm retard

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if iniciado then
            DrawMissionText("Espera a que el empleado del Ammu Nation te entregue ~r~las armas")
        end
    end
end)


function crearped2(hash, coords, heading)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(5)
    end

    local ped = CreatePed(4, hash, coords, false, false)
    SetEntityHeading(ped, heading)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetPedFleeAttributes(ped, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    return ped
end

loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end


function DrawMissionText(msg, time)
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end
    
