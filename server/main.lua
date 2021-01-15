ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 



RegisterServerEvent('guille_ammurob:tusmuertos')
AddEventHandler('guille_ammurob:tusmuertos', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

    print("requisito 1 cumplido")
    local numero = math.random(1,15)
    if numero == 1 then
        xPlayer.addWeapon('weapon_switchblade', 200)
    elseif numero == 2 then
        xPlayer.addWeapon('weapon_snspistol', 200)
    elseif numero == 3 then
        xPlayer.addWeapon('weapon_flashlight', 200)
    elseif numero == 4 then
        xPlayer.addWeapon('weapon_sawnoffshotgun', 200)
    elseif numero == 5 then
        xPlayer.addWeapon('weapon_pistol50', 200)
    elseif numero == 6 then
        xPlayer.addWeapon('weapon_sawnoffshotgun', 200)
    elseif numero == 7 then
        xPlayer.addWeapon('weapon_microsmg', 200)
    elseif numero == 8 then
        xPlayer.addWeapon('weapon_smg', 200)
    elseif numero == 9 then
        xPlayer.addWeapon('weapon_heavypistol', 200)
    elseif numero == 10 then
        xPlayer.addWeapon('weapon_vintagepistol', 200)
    elseif numero == 11 then
        xPlayer.addWeapon('weapon_smg', 200)
    elseif numero == 12 then
        xPlayer.addWeapon('weapon_assaultrifle', 200)
    elseif numero == 13 then
        xPlayer.addWeapon('weapon_heavypistol', 200)
    elseif numero == 14 then
        xPlayer.addWeapon('weapon_microsmg', 200)
    elseif numero == 15 then
        xPlayer.addWeapon('weapon_sawnoffshotgun', 200)
    end

    TriggerClientEvent('esx:showNotification', source, 'Has recibido un arma')

    for i = 1, #xPlayers do
        Citizen.Wait(5000)
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('guille_ammurob:borrarblip', xPlayers[i])
            TriggerClientEvent('esx:showNotification', xPlayers[i], 'Robo al ammunation terminado, el botín ha sido recogido')
        end
    end
end)

RegisterServerEvent('guille_ammurob:fuerablip')
AddEventHandler('guille_ammurob:fuerablip', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

    for i = 1, #xPlayers do
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('guille_ammurob:borrarblip', xPlayers[i])
            TriggerClientEvent('esx:showNotification', xPlayers[i], 'Robo al ammunation terminado, el botín no ha sido recogido porque ha muerto el vendedor')
        end
    end
end)

RegisterNetEvent('guille_ammurob:reloj')
AddEventHandler('guille_ammurob:reloj', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    local reloj = 60

	Citizen.CreateThread(function()
		while reloj > 0 do
			Citizen.Wait(1000)

			if reloj > 0 then
                reloj = reloj - 1
                print(reloj)
                for i = 1, #xPlayers do
                    TriggerClientEvent('guille_ammurob:nodisponible', xPlayers[i])
                end
            end
            if reloj == 0 then
                print("Robodispo")
                for i = 1, #xPlayers do
                    TriggerClientEvent('guille_ammurob:disponible', xPlayers[i])
                end
            end
		end
    end)
end)


RegisterServerEvent('guille_ammurob:avisopasma')
AddEventHandler('guille_ammurob:avisopasma', function()

	local xPlayer  = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('esx:showNotification', xPlayers[i], 'Robo al ammunation en progreso')
            TriggerClientEvent('guille_ammurob:bliprobo', xPlayers[i])
        end
    end
end)
