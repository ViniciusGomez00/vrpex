local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("nav_armas",emP)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "wbody|WEAPON_COMBATPISTOL",quantidade = 1, aco = 5, ferro = 5, plastico = 5, forma = 1,nome = "Glock", tempo = 3}, 
	{ item = "wbody|WEAPON_PUMPSHOTGUN",quantidade = 1, aco = 10, ferro = 10, plastico = 10, forma = 2,nome = "Remington", tempo = 5}, 
	{ item = "wbody|WEAPON_COMBATPDW",quantidade = 1, aco = 20, ferro = 20, plastico = 20, forma = 4, nome = "MTAR-21", tempo = 7}, 
	{ item = "wbody|WEAPON_SPECIALCARBINE",quantidade = 1, aco = 30, ferro = 30, plastico = 30, forma = 10, nome = "AK-47",tempo = 10}, 
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("armas-comprar")
AddEventHandler("armas-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				--if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,"aco",v.aco) and vRP.tryGetInventoryItem(user_id,"ferro",v.ferro) and vRP.tryGetInventoryItem(user_id,"plastico",v.plastico) and vRP.tryGetInventoryItem(user_id,"moldearmas",v.forma) then
						if item == "wbody|WEAPON_COMBATPISTOL" then
							TriggerClientEvent('progress',source,180000,v.nome)
							TriggerClientEvent('Notify',source,'aviso','Você começou a montar '..v.nome.." espere "..v.tempo.." minutos para concluir.")
							TriggerClientEvent('travar',source)
							SetTimeout(180000,function()
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
								TriggerClientEvent('unfreze',source)
								TriggerClientEvent("Notify",source,"sucesso","Fabricou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."")							
							end)

						elseif item == "wbody|WEAPON_PUMPSHOTGUN" then
							TriggerClientEvent('progress',source,300000,v.nome)
							TriggerClientEvent('Notify',source,'aviso','Você começou a montar '..v.nome.." espere "..v.tempo.." minutos para concluir.")
							TriggerClientEvent('travar',source)
							SetTimeout(180000,function()
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
								TriggerClientEvent('unfreze',source)
								TriggerClientEvent("Notify",source,"sucesso","Fabricou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."")
							end)

						elseif item == "wbody|WEAPON_COMBATPDW" then
							TriggerClientEvent('progress',source,420000,v.nome)
							TriggerClientEvent('Notify',source,'aviso','Você começou a montar '..v.nome.." espere "..v.tempo.." minutos para concluir.")
							TriggerClientEvent('travar',source)
							SetTimeout(420000,function()
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
								TriggerClientEvent('unfreze',source)
								TriggerClientEvent("Notify",source,"sucesso","Fabricou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."")
							end)

						elseif item == "wbody|weapon_assaultrifle" then
							TriggerClientEvent('progress',source,600000,v.nome)
							TriggerClientEvent('Notify',source,'aviso','Você começou a montar '..v.nome.." espere "..v.tempo.." minutos para concluir.")
							TriggerClientEvent('travar',source)
							SetTimeout(600000,function()
								vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
								TriggerClientEvent('unfreze',source)
								TriggerClientEvent("Notify",source,"sucesso","Fabricou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."")
							end)							
						end 
					else
						TriggerClientEvent("Notify",source,"negado","Voce nao tem todas as peças")
					end
				--else
				--	TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				--end
			end
		end
	end
end)

function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"armas.permissao")
end