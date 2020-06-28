local cords = {
    -- Alqeada
    {1387.0250244141,3622.0773925781,35.011856079102,"mferro",'alqeada.permissao'},
    {1395.1182861328,3613.9523925781,34.980930328369,"carbono",'alqeada.permissao'},
    {1390.595703125,3607.021484375,38.94189453125,"aco",'alqeada.permissao'},
    --Milicia
    {64.860885620117,3684.9497070313,39.834339141846,"mferro",'milicia.permissao'},
    {55.952117919922,3725.9455566406,39.664588928223,"carbono",'milicia.permissao'},
    {16.191181182861,3730.1462402344,39.684505462646,"aco",'milicia.permissao'},
    --Mafia
    {2560.6975097656,4666.7377929688,34.076797485352,"mferro",'mafia.permissao'},
    {2564.4284667969,4644.9375,34.076797485352,"carbono",'mafia.permissao'},
    {2582.6975097656,4660.31640625,34.076808929443,"aco",'mafia.permissao'},
}

local minerio
local fac
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for _,mark in pairs(cords) do
			local x,y,z,nome,perm = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
            if distance <= 30 then
                DrawMarker(21,x,y,z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
                if distance <= 2 then
                    if IsControlJustPressed(0,38) then
                        TriggerEvent('progress',3000,'Coletando')
                        TriggerEvent('cancelando',true)
                        SetTimeout(3000,function()
                            minerio = nome
                            fac = perm
                            TriggerEvent('cancelando',false)
                            TriggerServerEvent('coletar:item',minerio,fac)
                        end)
                    end
                end
			end
		end
	end
end)