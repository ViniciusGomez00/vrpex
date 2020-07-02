local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

local org 
--local departamento

RegisterNetEvent('dar:glock')
AddEventHandler('dar:glock',function()
    local ped = PlayerPedId()
    SetPedAmmo(ped,GetHashKey("WEAPON_COMBATPISTOL"),0)
    RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPISTOL"))
    GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),100,0,1)
    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_COMBATPISTOL_CLIP_02"))
end)

RegisterNetEvent('dar:doze')
AddEventHandler('dar:doze',function()
    local ped = PlayerPedId()
    SetPedAmmo(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),0)
    RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"))
    GiveWeaponToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),30,0,1)
end)

RegisterNetEvent('dar:mp5')
AddEventHandler('dar:mp5',function()
    local ped = PlayerPedId()
    SetPedAmmo(ped,GetHashKey("WEAPON_SMG"),0)
    RemoveWeaponFromPed(ped,GetHashKey("WEAPON_SMG"))
    GiveWeaponToPed(ped,GetHashKey("WEAPON_SMG"),200,0,1)
    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_SMG_CLIP_02"))
    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
    GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
end)

RegisterNetEvent('dar:sig')
AddEventHandler('dar:sig',function()
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_COMBATPDW"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPDW"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPDW"),200,0,1)
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_COMBATPDW_CLIP_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
end)

RegisterNetEvent('dar:fall')
AddEventHandler('dar:fall',function()
    local ped = PlayerPedId()
	GiveWeaponToPed(ped,GetHashKey("WEAPON_SPECIALCARBINE"),200,0,1)
end)

RegisterNetEvent('dar:m4')
AddEventHandler('dar:m4',function()
	local ped = PlayerPedId()
		SetPedAmmo(ped,GetHashKey("WEAPON_CARBINERIFLE"),0)
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE"))
		GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),200,0,1)
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_CARBINERIFLE_CLIP_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
end)

RegisterNetEvent('dar:tazer')
AddEventHandler('dar:tazer',function()
    local ped = PlayerPedId()
	GiveWeaponToPed(ped,GetHashKey("WEAPON_STUNGUN"),0,0,0)
end)

RegisterNetEvent('dar:gas')
AddEventHandler('dar:gas',function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,GetHashKey("WEAPON_BZGAS"),1,0,0)
end)

RegisterNetEvent('dar:cassetete')
AddEventHandler('dar:cassetete',function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,GetHashKey("WEAPON_NIGHTSTICK"),0,0,0)
end)

RegisterNetEvent('dar:colete')
AddEventHandler('dar:colete',function()
	TriggerServerEvent('dar:colete')
end)

RegisterNetEvent('dar:extintor')
AddEventHandler('dar:extintor',function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,GetHashKey("WEAPON_FIREEXTINGUISHER"),25000,0,1)
end)

RegisterNetEvent('dar:lanterna')
AddEventHandler('dar:lanterna',function()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,GetHashKey("WEAPON_FLASHLIGHT"),0,0,0)
end)

local marcacoes = {
    {447.980,-973.3823,30.689,"lspd"},
	{-435.87417602539,6000.431640625,31.71618270874,"lssd"}

}

local rarmas = {
    {450.70236206055,-979.87475585938,30.689310073853,"lspd"},
    {-437.40026855469,5988.5625,31.716180801392,"lssd"}
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		for _,mark in pairs(marcacoes) do
			local x,y,z,nome = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 5.0 then
				DrawMarker(21,x,y,z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,0,0,0,100,0,0,0,1)
					if distance <= 1.2 then
						if IsControlJustPressed(0,38) then
							org = nome
							TriggerServerEvent('blip:comprar',org)
						end
					end
			end 
		end
	end
end)


Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		for _,mark in pairs(rarmas) do
			local x,y,z,nome = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 5.0 then
				DrawMarker(21,x,y,z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,0,0,0,100,0,0,0,1)
					if distance <= 1.2 then
						if IsControlJustPressed(0,38) then
							org = nome
							TriggerServerEvent('blip:retirar',org)
						end
					end
			end 
		end
	end
end)