local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emP = Tunnel.getInterface("nav_armas")

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end

function HideActionMenu()
	menuactive = true
	if menuactive == true then
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	local glock = 1
	if data == "check-glock" then
		TriggerServerEvent("armas-comprar","wbody|WEAPON_COMBATPISTOL")
		HideActionMenu()
	elseif data == "armamentos-comprar-doze" then
		TriggerServerEvent("armas-comprar","wbody|WEAPON_PUMPSHOTGUN")
		HideActionMenu()
	elseif data == "armamentos-comprar-zig" then
		TriggerServerEvent("armas-comprar","wbody|WEAPON_COMBATPDW")
		HideActionMenu()
	elseif data == "armamentos-comprar-fall" then
		TriggerServerEvent("armas-comprar","wbody|weapon_assaultrifle")
		HideActionMenu()

	elseif data == "fechar" then
		HideActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local montar1 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),896.78399658203,-3217.3698730469,-98.226203918457,true)
		local montar2 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),905.72534179688,-3230.7697753906,-98.294357299805,true)
		local montar3 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),909.81829833984,-3210.2272949219,-98.222274780273,true)

		if montar1 <= 10 then
			DrawMarker(21,896.78399658203,-3217.3698730469,-98.226203918457-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,0,0,0,100,0,0,0,1)
			if montar1 <= 1.1 then
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end 
		end
		if montar2 <= 10 then
			DrawMarker(21,905.72534179688,-3230.7697753906,-98.294357299805-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,0,0,0,100,0,0,0,1)
			if montar2 <= 1.1 then
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end 
		end
		if montar3 <= 10 then
			DrawMarker(21,909.81829833984,-3210.2272949219,-98.222274780273-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,0,0,0,100,0,0,0,1)
			if montar3 <= 1.1 then
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end 
		end
	end
end)

RegisterNetEvent('travar')
AddEventHandler('travar',function()
	while (not HasAnimDictLoaded("anim@amb@business@cfm@cfm_machine_oversee@")) do 
		RequestAnimDict("anim@amb@business@cfm@cfm_machine_oversee@")
		DisableControlAction(2, 167, true) --Desliga o F6
		Citizen.Wait(0)
	end
	--SetEntityCoords(PlayerPedId(),1109.5281982422,-1996.8391113281,29.947607040405,false,false,false,false)
	SetEntityHeading(PlayerPedId(),149.78)
	TaskPlayAnim(PlayerPedId(-1), "anim@amb@business@cfm@cfm_machine_oversee@", "cough_spit_operator", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
	FreezeEntityPosition(PlayerPedId(-1),true)
end)

RegisterNetEvent('unfreze')
AddEventHandler('unfreze',function()
	local player = PlayerPedId()
	FreezeEntityPosition(player, false)
	ClearPedTasksImmediately(PlayerPedId(-1))
end)