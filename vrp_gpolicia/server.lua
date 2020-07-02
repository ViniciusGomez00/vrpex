local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--//////////// TEMPO E VALOR DA VERBA /////////////////////////////////////////////////////////////////////////////
local tempo = 120 -- TEMPO QUE DEMORA PARA ENTRAR A NOVA VERBA, DADO PELO SERVIDOR
local dverba = 120000  -- VALOR DA VERBA DEPOSITADA A CADA 2H
local perm = "policia.permissao" -- PERMISSAO PRA COMPRAR ARMAMENTO, COLOQUE A PERMISSAO QUE QUISER AQUI!

--/////////////////////////////////////////////////////////////////////////////////////////////////////////
local dbbanco = 0 -- NÃO MEXA!!

--//////////// PREÇO DAS ARMAS /////////////////////////////////////////////////////////////////////////////
local vglock = 4000 -- VALOR DA GLOCK
local vdoze = 6000 -- VALOR DA REMINGTON
local vsub = 10000 -- VALOR DA MP5
local vsub2 = 12000 --VALOR DA SIGSAUER
local vfuzil = 20000 -- VALOR DO M4A1
local vfuzil2 = 20000  -- VALOR DA PARAFALL
--/////////////////////////////////////////////////////////////////////////////////////////////////////////

-- NOME/PREÇO/QUANTIDADE/MUNIÇAO
local munin = {
    {"glock",250,50,"wammo|WEAPON_COMBATPISTOL"}, 
    {"remington",300,50,"wammo|WEAPON_PUMPSHOTGUN"},
    {"mp5",350,250,"wammo|WEAPON_SMG"},
    {"sig",350,250,"wammo|WEAPON_COMBATPDW"},
    {"m4a1",500,250,"wammo|WEAPON_CARBINERIFLE"}
}

--//////////////////////////////////// NÃO MEXA ///////////////////////////////////////////////////////////
vRP._prepare('vRP/sel_arsenal',"SELECT * FROM vrp_organizacoes WHERE organizacao = @organizacao")
vRP._prepare('vRP/att_geral',"SELECT * FROM vrp_organizacoes WHERE organizacao = @organizacao")
vRP._prepare('vRP/ver_armas',"SELECT * FROM vrp_organizacoes WHERE organizacao = @organizacao")
vRP._prepare('vRP/att_banco',"UPDATE vrp_organizacoes SET banco = @banco WHERE user_id = @user_id")
vRP._prepare('vRP/att_banco2',"UPDATE vrp_organizacoes SET banco = @banco WHERE organizacao = @organizacao")

vRP._prepare('vRP/att_pistola','UPDATE vrp_organizacoes SET glock = @glock WHERE organizacao = @organizacao')
vRP._prepare('vRP/att_doze','UPDATE vrp_organizacoes SET remington = @remington WHERE organizacao = @organizacao')
vRP._prepare('vRP/att_sub','UPDATE vrp_organizacoes SET mp5 = @mp5 WHERE organizacao = @organizacao')
vRP._prepare('vRP/att_sub2','UPDATE vrp_organizacoes SET sigsauer = @sigsauer WHERE organizacao = @organizacao')
vRP._prepare('vRP/att_fuzil','UPDATE vrp_organizacoes SET m4a1 = @m4a1 WHERE organizacao = @organizacao')
vRP._prepare('vRP/att_fuzil2','UPDATE vrp_organizacoes SET fall = @fall WHERE organizacao = @organizacao')
--/////////////////////////////////////////////////////////////////////////////////////////////////////////

RegisterNetEvent('blip:comprar')
AddEventHandler('blip:comprar',function(org)
    local source = source
    local user_id = vRP.getUserId(source)
    local rows = vRP.query('vRP/sel_arsenal',{organizacao = org})
    for k,v in pairs(rows) do
        dbbanco = rows[1].banco
    end
    if user_id and vRP.hasPermission(user_id,perm) then
        local menu = {name = "Policia"}
        local submenu = {name = "Gerenciamento"}
        local arse = {name = "Comprar"}
        local verb = {name = "Verbas"}
            menu["GERENCIAR"] = {function(source,choice)

                submenu["Verba"] = {function(source,choice)
                    verb["Adicionar"]= {function(source,choice)
                        TriggerEvent('depositar:verba',source,org)
                        vRP.closeMenu(source,verb)
                    end}vRP.openMenu(source,verb)

                    verb["Banco:R$"..vRP.format(dbbanco)] = {function(source,choice)
                    end}vRP.openMenu(source,verb)
                        

                end,}vRP.openMenu(source,submenu)

                submenu["Armamento"] ={function(source,choice)

                    arse["Glock"] = {function(source,choice)
                        TriggerEvent('comprar:arma',source,"glock",org)
                        vRP.closeMenu(source,submenu)
                    end}vRP.openMenu(source,arse)

                    arse["Remington"] = {function(source,choice)
                        TriggerEvent('comprar:arma',source,"remington",org)
                        vRP.closeMenu(source,submenu)
                    end}vRP.openMenu(source,arse)
                    
                    arse["MP5"] = {function(source,choice)
                        TriggerEvent('comprar:arma',source,"mp5",org)
                        vRP.closeMenu(source,submenu)
                    end}vRP.openMenu(source,arse)

                    arse["Sig Sauer"] = {function(source,choice)
                        TriggerEvent('comprar:arma',source,"sigsauer",org)
                        vRP.closeMenu(source,submenu)
                    end}vRP.openMenu(source,arse)

                    arse["M4A1"] = {function(source,choice)
                        TriggerEvent('comprar:arma',source,"m4a1",org)
                        vRP.closeMenu(source,submenu)
                    end}vRP.openMenu(source,arse)

                    arse["ParaFall"] = {function(source,choice)
                        TriggerEvent('comprar:arma',source,"fall",org)
                        vRP.closeMenu(source,submenu)
                    end}vRP.openMenu(source,arse)

                end}vRP.openMenu(source,submenu)

            end}vRP.openMenu(source,menu) 
    end 
end)

RegisterNetEvent('blip:retirar')
AddEventHandler('blip:retirar',function(org)
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id,'policia.permissao') then
        local rows = vRP.query('vRP/ver_armas',{organizacao = org})
        for k,v in pairs(rows) do
            local rglock = rows[1].glock
            local rremington = rows[1].remington
            local rmp5 = rows[1].mp5
            local rsig = rows[1].sigsauer
            local rfall = rows[1].fall
            local rm4a1 = rows[1].m4a1

                        --// BUILD MENU \\ -- 
            local menu = {name = "Arsenal"}
            local submenu = {name = "Armas"}
            local municao = {name = "Munições"}

            menu["Ação"] = {function(source,choice)

                submenu["Glock "..rglock.."x"] = {function(source,choice)
                    TriggerEvent('retirar:arma',source,"glock",org)
                    
                    vRP.closeMenu(source,submenu)
                end}vRP.openMenu(source,submenu)

                submenu["Remington "..rremington.."x"] = {function(source,choice)
                    TriggerEvent('retirar:arma',source,"doze",org)
                    TriggerClientEvent('Notify',source,'sucesso','Você pegou 1x Remington')
                    vRP.closeMenu(source,submenu)
                end}vRP.openMenu(source,submenu)

                submenu["MP5 "..rmp5.."x"] = {function(source,choice)
                    TriggerEvent('retirar:arma',source,"mp5",org)
                    TriggerClientEvent('Notify',source,'sucesso','Você pegou 1x MP5')
                    vRP.closeMenu(source,submenu)
                end}vRP.openMenu(source,submenu)

                submenu["Sig Sauer "..rsig.."x"] = {function(source,choice)
                    TriggerEvent('retirar:arma',source,"sig",org)
                    TriggerClientEvent('Notify',source,'sucesso','Você pegou 1x Sig Sauer')
                    vRP.closeMenu(source,submenu)
                end}vRP.openMenu(source,submenu)

                submenu["ParaFall "..rfall.."x"] = {function(source,choice)
                    TriggerEvent('retirar:arma',source,"fall",org)
                    TriggerClientEvent('Notify',source,'sucesso','Você pegou 1x ParaFall')
                    vRP.closeMenu(source,submenu)
                end}vRP.openMenu(source,submenu)

                submenu["M4A1 "..rm4a1.."x"] = {function(source,choice)
                    TriggerEvent('retirar:arma',source,"m4",org)
                    TriggerClientEvent('Notify',source,'sucesso','Você pegou 1x M4A1')
                    vRP.closeMenu(source,submenu)
                end}vRP.openMenu(source,submenu)

            end}vRP.openMenu(source,menu)

            menu["Patrulha"] = {function(source,choice)

                submenu["Tazer"] = {function(source,choice)
                    TriggerClientEvent('dar:tazer',source)
                    TriggerClientEvent('Notify',source,'sucesso','Você pegou 1x Tazer')
                end}vRP.openMenu(source,submenu)

                submenu["Gas"] = {function(source,choice)
                    TriggerClientEvent('dar:gas',source)
                    TriggerClientEvent('Notify',source,'sucesso','Você pegou 1x Gas')
                end}vRP.openMenu(source,submenu)

                submenu["Lanterna"] = {function(source,choice)
                    TriggerClientEvent('dar:lanterna',source)
                    TriggerClientEvent('Notify',source,'sucesso','Você pegou 1x Lanterna')
                end}vRP.openMenu(source,submenu)

                submenu["Cassetete"] = {function(source,choice)
                    TriggerClientEvent('dar:cassetete',source)
                    TriggerClientEvent('Notify',source,'sucesso','Você pegou 1x Cassetete')
                end}vRP.openMenu(source,submenu)

                submenu["Colete"] = {function(source,choice)
                    TriggerClientEvent('dar:colete',source)
                    TriggerClientEvent('Notify',source,'sucesso','Você pegou 1x Colete')
                end}vRP.openMenu(source,submenu)

                submenu["Extintor"] = {function(source,choice)
                    TriggerClientEvent('dar:extintor',source)
                    TriggerClientEvent('Notify',source,'sucesso','Você pegou 1x Extintor')
                end}vRP.openMenu(source,submenu)    

            end}vRP.openMenu(source,menu)

            menu["Munição"] = {function(source,choice)

                municao["Glock"] = {function(source,choice)
                    TriggerEvent('comprar:muni',source,"glock",org)
                    vRP.closeMenu(source,municao)
                end}vRP.openMenu(source,municao)

                municao["Remington"] = {function(source,choice)
                    TriggerEvent('comprar:muni',source,"remington",org)
                    vRP.closeMenu(source,municao)
                end}vRP.openMenu(source,municao)

                municao["MP5"] = {function(source,choice)
                    TriggerEvent('comprar:muni',source,"mp5",org)
                    vRP.closeMenu(source,municao)
                end}vRP.openMenu(source,municao)

                municao["Sig Sauer"] = {function(source,choice)
                    TriggerEvent('comprar:muni',source,"sig",org)
                    vRP.closeMenu(source,municao)
                end}vRP.openMenu(source,municao)

                municao["M4A1"] = {function(source,choice)
                    TriggerEvent('comprar:muni',source,"m4a1",org)
                    vRP.closeMenu(source,municao)
                end}vRP.openMenu(source,municao)


            end}vRP.openMenu(source,menu)
        end
    end
end)

RegisterServerEvent('retirar:arma')
AddEventHandler('retirar:arma',function(source,arma,org)
    local user_id = vRP.getUserId(source)
    local rows = vRP.query('vRP/ver_armas',{organizacao = org})
    for k,v in pairs(rows) do
        local rglock = rows[1].glock
        local rremington = rows[1].remington
        local rmp5 = rows[1].mp5
        local rsig = rows[1].sigsauer
        local rfall = rows[1].fall
        local rm4a1 = rows[1].m4a1
        if arma == "glock" then
            if rglock <= 0 then
                TriggerClientEvent('Notify',source,'negado','Arma indisponivel')
            else
                local ok = vRP.request(source,"Desenha retirar 1x Glock?",60)
                if ok then
                    local rtglock = rglock - 1
                    vRP.execute('vRP/att_pistola',{glock = rtglock, organizacao = org})
                    TriggerClientEvent('Notify',source,'sucesso','Você pegou 1x Glock')
                    TriggerClientEvent('dar:glock',source)
                end
            end
        elseif arma == "doze"  then
            if rremington <= 0 then
                TriggerClientEvent('Notify',source,'negado','Arma indisponivel')
            else
                local ok = vRP.request(source,"Desenha retirar 1x Remington?",60)
                if ok then
                    local rtremington = rremington - 1
                    vRP.execute('vRP/att_doze',{remington = rtremington, organizacao = org})
                    TriggerClientEvent('dar:doze',source)
                end
            end
        elseif arma == "mp5"  then
            if rmp5 <= 0 then
                TriggerClientEvent('Notify',source,'negado','Arma indisponivel')
            else
                local ok = vRP.request(source,"Desenha retirar 1x MP5?",60)
                if ok then
                    local rtmp5 = rmp5 - 1
                    vRP.execute('vRP/att_sub',{mp5 = rtmp5, organizacao = org})
                    TriggerClientEvent('dar:mp5',source)
                end
            end
        elseif arma == "sig"  then
            if rsig <= 0 then
                TriggerClientEvent('Notify',source,'negado','Arma indisponivel')
            else
                local ok = vRP.request(source,"Desenha retirar 1x Sig Sauer?",60)
                if ok then
                    local rtsig = rsig - 1
                    vRP.execute('vRP/att_sub2',{sigsauer = rtsig, organizacao = org})
                    TriggerClientEvent('dar:sig',source)
                end
            end
        elseif arma == "fall"  then
            if rfall <= 0 then
                TriggerClientEvent('Notify',source,'negado','Arma indisponivel')
            else
                local ok = vRP.request(source,"Desenha retirar 1x ParaFall?",60)
                if ok then
                    local rtfall = rfall - 1
                    vRP.execute('vRP/att_fuzil2',{fall = rtfall, organizacao = org})
                    TriggerClientEvent('dar:fall',source)
                end
            end
        elseif arma == "m4"  then
            if rm4a1 <= 0 then
                TriggerClientEvent('Notify',source,'negado','Arma indisponivel')
            else
                local ok = vRP.request(source,"Desenha retirar 1x M4A1?",60)
                if ok then
                    local rtm4a1 = rm4a1 - 1
                    vRP.execute('vRP/att_fuzil',{m4a1 = rtm4a1, organizacao = org})
                    TriggerClientEvent('dar:m4',source)
                end
            end
        end
    end
end)

RegisterServerEvent('comprar:muni')
AddEventHandler('comprar:muni',function(source,arma,org)
    local user_id = vRP.getUserId(source)
    local rows = vRP.query('vRP/att_geral',{organizacao = org})
    for a,b in pairs(munin) do
        if arma == b[1] then
            local ok = vRP.request(source,'Deseja retirar 250 balas de '..b[1].."por $"..b[2].."?",60)
            if ok then
                for k,v in pairs(rows) do
                    local banco = rows[1].banco
                    local pmunicao = banco - b[2]
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(b[4])*b[3] <= vRP.getInventoryMaxWeight(user_id) then
                        if pmunicao <= 0 then
                            TriggerClientEvent('Notify',source,'aviso','Sua organizaçao está sem verba!')
                        else
                            vRP.execute('vRP/att_banco2', {banco = pmunicao, organizacao = org})
                            vRP.giveInventoryItem(user_id,b[4],b[3])
                            TriggerClientEvent('Notify',source,'sucesso','Munições entregues!')
                        end
                    else
                        TriggerClientEvent('Notify',source,'aviso','Inventario cheio!')
                    end
                end
            end
        end
    end
end)

RegisterServerEvent('comprar:arma')
AddEventHandler('comprar:arma',function(source,arma,org)
    local user_id = vRP.getUserId(source)
    local rows = vRP.query('vRP/att_geral',{organizacao = org})
    
    for k,v in pairs(rows) do
        local banco = rows[1].banco
        if banco <= 0 then
            TriggerClientEvent('Notify',source,'aviso','Sua organizaçao está sem verba!')
        else
            local ok = vRP.prompt(source,"Quantas unidades deseja comprar?","")
            local tok = parseInt(ok)
            if tok then
                if arma == "glock" then
                    local dbglock = rows[1].glock
                    local entregaglock = dbglock + tok
                    local bancodb = rows[1].banco
                    local pagar = bancodb - tok * vglock
                    if pagar <= 0 then
                        TriggerClientEvent('Notify',source,'aviso','Sua organizaçao está sem verba!')
                    else 
                        local ok = vRP.request(source,"Deseja comprar "..tok.."x Glock por R$"..tok * vglock.."?",60)
                        if ok then
                            vRP.execute('vRP/att_banco2', {banco = pagar, organizacao = org})
                            vRP.execute('vRP/att_pistola',{glock = entregaglock, organizacao = org})
                            TriggerClientEvent('Notify',source,'sucesso','Você comprou '..tok..'x Glock')
                        end
                    end
                elseif arma  == "remington" then
                    local dbdoze = rows[1].remington
                    local entregaglock = dbdoze + tok
                    local bancodb = rows[1].banco
                    local pagar = bancodb - tok * vdoze
                    if pagar <= 0 then
                        TriggerClientEvent('Notify',source,'aviso','Sua organizaçao está sem verba!')
                    else 
                        local ok = vRP.request(source,"Deseja comprar "..tok.."x Remington por R$"..tok * vdoze.."?",60)
                        if ok then
                            vRP.execute('vRP/att_banco2', {banco = pagar, organizacao = org})
                            vRP.execute('vRP/att_doze',{remington = entregaglock, organizacao = org})
                            TriggerClientEvent('Notify',source,'sucesso','Você comprou '..tok..'x Remington')
                        end
                    end
                elseif arma  == "mp5" then
                    local dbsub = rows[1].mp5
                    local entregasub = dbsub + tok
                    local bancodb = rows[1].banco
                    local pagar = bancodb - tok * vsub
                    if pagar <= 0 then
                        TriggerClientEvent('Notify',source,'aviso','Sua organizaçao está sem verba!')
                    else 
                        local ok = vRP.request(source,"Deseja comprar "..tok.."x MP5 por R$"..tok * vsub.."?",60)
                        if ok then
                            vRP.execute('vRP/att_banco2', {banco = pagar, organizacao = org})
                            vRP.execute('vRP/att_sub',{mp5 = entregasub, organizacao = org})
                            TriggerClientEvent('Notify',source,'sucesso','Você comprou '..tok..'x MP5')
                        end
                    end
                elseif arma  == "sigsauer" then
                    local dbsub = rows[1].sigsauer
                    local entregasub = dbsub + tok
                    local bancodb = rows[1].banco
                    local pagar = bancodb - tok * vsub2
                    if pagar <= 0 then
                        TriggerClientEvent('Notify',source,'aviso','Sua organizaçao está sem verba!')
                    else 
                        local ok = vRP.request(source,"Deseja comprar "..tok.."x Sig Sauer por R$"..tok*vsub2.."?",60)
                        if ok then
                            vRP.execute('vRP/att_banco2', {banco = pagar, organizacao = org})
                            vRP.execute('vRP/att_sub2',{sigsauer = entregasub, organizacao = org})
                            TriggerClientEvent('Notify',source,'sucesso','Você comprou '..tok..'x Sig Sauer')
                        end
                    end
                elseif arma  == "m4a1" then
                    local dbsub = rows[1].m4a1
                    local entregasub = dbsub + tok
                    local bancodb = rows[1].banco
                    local pagar = bancodb - tok * vfuzil
                    if pagar <= 0 then
                        TriggerClientEvent('Notify',source,'aviso','Sua organizaçao está sem verba!')
                    else 
                        local ok = vRP.request(source,"Deseja comprar "..tok.."x M4A1 por R$"..tok*vfuzil.."?",60)
                        if ok then
                            vRP.execute('vRP/att_banco2', {banco = pagar, organizacao = org})
                            vRP.execute('vRP/att_fuzil',{m4a1 = entregasub, organizacao = org})
                            TriggerClientEvent('Notify',source,'sucesso','Você comprou '..tok..'x M4A1')
                        end
                    end
                elseif arma  == "fall" then
                    local dbsub = rows[1].fall
                    local entregasub = dbsub + tok
                    local bancodb = rows[1].banco
                    local pagar = bancodb - tok * vfuzil2
                    if pagar <= 0 then
                        TriggerClientEvent('Notify',source,'aviso','Sua organizaçao está sem verba!')
                    else 
                        local ok = vRP.request(source,"Deseja comprar "..tok.."x ParaFall por R$"..tok*vfuzil2.."?",60)
                        if ok then
                            vRP.execute('vRP/att_banco2', {banco = pagar, organizacao = org})
                            vRP.execute('vRP/att_fuzil2',{fall = entregasub, organizacao = org})
                            TriggerClientEvent('Notify',source,'sucesso','Você comprou '..tok..'x ParaFall')
                        end
                    end       
                end
            end
        end
    end
end)

RegisterServerEvent('depositar:verba')
AddEventHandler('depositar:verba',function(source,org)
    local user_id = vRP.getUserId(source)
    local rows = vRP.query('vRP/sel_arsenal', {organizacao = org})
    for k,v in pairs(rows) do
        local banco = rows[1].banco
        if user_id then
            local vdepostio = vRP.prompt(source,"Quanto deseja depositar? (DINHEIRO SUJO)","")
            local intDeposito = parseInt(vdepostio)
            if vdepostio then
                if vRP.tryGetInventoryItem(user_id,'dinheirosujo',vdepostio) then
                    local depositobanco = banco + vdepostio
                    vRP.execute('vRP/att_banco2',{banco = depositobanco,organizacao = org})
                    TriggerClientEvent('Notify',source,'sucesso','Você depositou R$'..vdepostio..", otimo trabalho!")
                else
                    TriggerClientEvent('Notify',source,'negado','Valor insuficiente!!')
                end
            end
        end
    end
end)

RegisterServerEvent('dar:colete')
AddEventHandler('dar:colete', function()
	local src = source
	local user_id = vRP.getUserId(src)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local colete = 100
		vRPclient.setArmour(src,100)
		vRP.setUData(user_id,"vRP:colete", json.encode(colete))
	end
end)

RegisterServerEvent('deposito:verba')
AddEventHandler('deposito:verba',function()
    local org = "policia"
    local org2 = "rota"
    local rows = vRP.query('vRP/att_geral',{organizacao = org})
    local rows2 = vRP.query('vRP/att_geral',{organizacao = org2})
    for k,v in pairs(rows) do
        local verba = rows[1].banco
        local ddverba = verba + dverba
        vRP.execute('vRP/att_banco2',{banco = ddverba,organizacao = org})
    end
    for k,v in pairs(rows2) do
        local verba = rows2[1].banco
        local ddverba = verba + dverba
        vRP.execute('vRP/att_banco2',{banco = ddverba,organizacao = org2})
    end
end)

Citizen.CreateThread(function()
    updateTime()
end)

function updateTime()
    while tempo > 0 do
        Wait(1000*60)
        tempo = tempo -1
    end
    TriggerEvent("deposito:verba")
    tempo = 120
    updateTime()
end



    
