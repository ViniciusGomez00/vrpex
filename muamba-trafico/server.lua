local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

func = {}

function func.checkPermission()
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"farmearmas.permissao") then
        return true
    end
end

local itens = {
    {item = "mferro"},
    {item ="aco"},
    {item ="carbono"}
}

RegisterServerEvent('coletar:item')
AddEventHandler('coletar:item',function(type,perm)
local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,perm) then
        for k,v in pairs(itens)do
            if type == v.item then
                if type == "mferro" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item) <= vRP.getInventoryMaxWeight(user_id) then
                        vRP.giveInventoryItem(user_id,v.item,3)
                        TriggerClientEvent('Notify',source,'sucesso','Você coletou 6x '..v.item..".")
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
                    end
                elseif type == "carbono" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item) <= vRP.getInventoryMaxWeight(user_id) then
                       if  vRP.tryGetInventoryItem(user_id,'mferro',3) then
                            vRP.giveInventoryItem(user_id,v.item,3)
                            TriggerClientEvent('Notify',source,'sucesso','Você coletou 3x '..v.item..".")
                       else
                            TriggerClientEvent('Notify',source,'aviso','Ferro insuficiente')
                       end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
                    end
                elseif type == "aco" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item) <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.tryGetInventoryItem(user_id,'carbono',3) then
                            vRP.giveInventoryItem(user_id,v.item,3)
                            TriggerClientEvent('Notify',source,'sucesso','Você coletou 2x '..v.item..".")
                        else
                            TriggerClientEvent('Notify',source,'aviso','Carbono insuficiente')
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
                    end
                end
            end
        end
    else
        TriggerClientEvent("Notify",source,"negado","Você nao tem permissao")
    end
end)