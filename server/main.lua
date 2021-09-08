ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
local lastRobbed = 0  -- Do not touch
local cooldown = 3600 -- Seconds (cooldown check between robberies, make sure to have same as local reloj at line 91
local copsConnected = 1;  -- Required cops to being able to start the robbery


RegisterServerEvent('guille_ammurob:tusmuertos')
AddEventHandler('guille_ammurob:tusmuertos', function()

    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
 	if xPlayer ~= nil or xPlayer ~= -1 then
	    local numero = math.random(1,15)
	    local difference = #(GetEntityCoords(GetPlayerPed(xPlayer.source)) - vector3(-332.04, 6085.28, 30.5)) 
	    if difference <= 50 then  -- too far (99% cheater)
		if difference <= 30 then  -- Players can cancel robbery going away
		    local timeDifference = os.time() - lastRobbed
		    if timeDifference < cooldown then return 	print("cooldown, replace print with ban event") end

		    lastRobbed = os.time()

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
		end

	    else
		--ban event
	     print("Distance cheat, Please replace me with a ban event!")
	    end

	    TriggerClientEvent('esx:showNotification', source, 'Has recibido un arma')

	    for i = 1, #xPlayers do
		Citizen.Wait(5000)
		if xPlayer.job.name == 'police' then
		    TriggerClientEvent('guille_ammurob:borrarblip', xPlayers[i])
		    TriggerClientEvent('esx:showNotification', xPlayers[i], 'Robo al ammunation terminado, el botín ha sido recogido')
		end
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
    local reloj = 3600

	Citizen.CreateThread(function()
		while reloj > 0 do
			Citizen.Wait(1000)
            local cops = 0
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'police' then
                    cops = cops + 1
                end
            end
            if cops >= 1 then
                if reloj > 0 then
                    reloj = reloj - 1
                    for i = 1, #xPlayers do
                        TriggerClientEvent('guille_ammurob:nodisponible', xPlayers[i])
                    end
                end
                if reloj == 0 then
                    for i = 1, #xPlayers do
                        TriggerClientEvent('guille_ammurob:disponible', xPlayers[i])
                    end
            
                end
            
            else
                TriggerClientEvent('esx:showNotification', xPlayer, 'No hay policías suficientes para iniciar el robo')
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

