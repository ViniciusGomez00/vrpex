local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent('receber:Droga')
AddEventHandler('receber:Droga',function(droga)
    local user_id = vRP.getUserId(source)
    
    -- Final
    if droga == "metanfetamina" then
        vRP.tryGetInventoryItem(user_id,"anfetamina",2)
        vRP.giveInventoryItem(user_id,'metanfetamina',1)
        
    -- Meio
    elseif droga == "anfetamina" then
        vRP.tryGetInventoryItem(user_id,'acidobateria',4)
        vRP.giveInventoryItem(user_id,"anfetamina",2)
        
    -- Inicio
    elseif droga == "acidobateria" then
        vRP.giveInventoryItem(user_id,'acidobateria',4)
        
    end
end)
