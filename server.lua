ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

--[[ ##### BUY #####]]--
RegisterServerEvent('esx_pawnshop:buyFixkit')
AddEventHandler('esx_pawnshop:buyFixkit', function()
	local _source = source
	local dscale = 0
	local dscale2 = 0
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if Config.PawnTradeItem then
		for i=1, #xPlayer.inventory, 1 do
			local item = xPlayer.inventory[i]

			if item.name == "dragon_scales" then --If you add more items to give you need to declare more veriables "dscale" and create more if statements
					dscale = item.count
			end
			if item.name == "nuts_and_bolts" then --2. item to give
					dscale2 = item.count
			end
			if item.name == "metalscrap" then --3. item to give
					dscale3 = item.count
			end
		end
	
	
		if dscale >= 4 then --Again create more if statements if you add more items to give
			if dscale2 >= 6 then --2. item to give
				if dscale3 >= 10 then --3. item to give
					xPlayer.removeInventoryItem('dragon_scales', 4) --Item you give | 1 = amount of items
					xPlayer.removeInventoryItem('nuts_and_bolts', 6) --2. item
					xPlayer.removeInventoryItem('metalscrap', 10) --3. item
					--xPlayer.removeInventoryItem('dragon_scales', 1)	you can give more items or	xPlayer.addInventoryItem('fixkit', 1)	you can get more items
					xPlayer.addInventoryItem('fixkit', 1) --Item you get | 1 = amount of items
				else
					TriggerClientEvent('esx:showNotification', xPlayer.source, 'Potrbujete:') --Not enought of 3. item
					TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~4x ~s~Zmajeva luskev!')
					if dscale2 >= 6 then --2. item to give
						TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~6x ~s~Matice in vijaki!')
					else 
						TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~6x ~r~Matice in vijaki!')
					end
					if dscale3 >= 10 then
						TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~10x ~s~Odpadno zelezo!')
					else
						TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~10x ~r~Odpadno zelezo!')
					end
				end
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Potrbujete:') --Not enought of 2. item
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~4x ~s~Zmajeva luskev!')
				if dscale2 >= 6 then --2. item to give
					TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~6x ~s~Matice in vijaki!')
				else 
					TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~6x ~r~Matice in vijaki!')
				end
				if dscale3 >= 10 then
					TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~10x ~s~Odpadno zelezo!')
				else
					TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~10x ~r~Odpadno zelezo!')
				end
			end
		else 
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Potrbujete:') --Not enought of 1. item
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~4x ~r~Zmajeva luskev!')
			if dscale2 >= 6 then --2. item to give
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~6x ~s~Matice in vijaki!')
			else 
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~6x ~r~Matice in vijaki!')
			end
			if dscale3 >= 10 then
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~10x ~s~Odpadno zelezo!')
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~10x ~r~Odpadno zelezo!')
			end
		end
	else
		if(xPlayer.getMoney() >= 8006) then --Cost of item
			xPlayer.removeMoney(8006)
			
			xPlayer.addInventoryItem('fixkit', 1) -- 1 = amount of items
			
			notification("Kupili ste ~g~Orodje za popravilo")
		else
			notification("Nimate dovolj ~r~denarja")
		end
	end
		
end)

RegisterServerEvent('esx_pawnshop:buySmallArmour')
AddEventHandler('esx_pawnshop:buySmallArmour', function()
	local _source = source
	local dscale = 0
	local dscale2 = 0
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if Config.PawnTradeItem then
		for i=1, #xPlayer.inventory, 1 do
			local item = xPlayer.inventory[i]

			if item.name == "dragon_scales" then
					dscale = item.count
			end
			if item.name == "metalscrap" then
					dscale2 = item.count
			end
		end
	
	
		if dscale >= 10 then
			if dscale2 >= 10 then
				xPlayer.removeInventoryItem('dragon_scales', 10)
				xPlayer.removeInventoryItem('metalscrap', 10)
				xPlayer.addInventoryItem('smallarmour', 1)
			else 
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Potrbujete:')
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~10x ~s~Zmajeva luskev!')
				if dscale2 >= 10 then
					TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~10x ~s~Odpadno zelezo!')
				else 
						TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~10x ~r~Odpadno zelezo!')
				end
			end
		else 
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Potrbujete:')
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~10x ~r~Zmajeva luskev!')
			if dscale2 >= 10 then
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~10x ~s~Odpadno zelezo!')
			else 
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~10x ~r~Odpadno zelezo!')
			end
		end
	else
		if(xPlayer.getMoney() >= 8006) then
			xPlayer.removeMoney(8006)
			
			xPlayer.addInventoryItem('smallarmour', 1)
			
			notification("Kupili ste ~g~Neprebojec I")
		else
			notification("Nimate dovolj ~r~denarja")
		end
	end
		
end)

RegisterServerEvent('esx_pawnshop:buyMedArmour')
AddEventHandler('esx_pawnshop:buyMedArmour', function()
	local _source = source
	local dscale = 0
	local dscale2 = 0
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if Config.PawnTradeItem then
		for i=1, #xPlayer.inventory, 1 do
			local item = xPlayer.inventory[i]

			if item.name == "dragon_scales" then
					dscale = item.count
			end
			if item.name == "metalscrap" then
					dscale2 = item.count
			end
		end
	
	
		if dscale >= 18 then
			if dscale2 >= 18 then
				xPlayer.removeInventoryItem('dragon_scales', 18)
				xPlayer.removeInventoryItem('metalscrap', 18)
				xPlayer.addInventoryItem('medarmour', 1)
			else 
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Potrbujete:')
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~18x ~s~Zmajeva luskev!')
				if dscale2 >= 18 then
					TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~18x ~s~Odpadno zelezo!')
				else 
					TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~18x ~r~Odpadno zelezo!')
				end
			end
		else 
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Potrbujete:')
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~18x ~r~Zmajeva luskev!')
			if dscale2 >= 18 then
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~18x ~s~Odpadno zelezo!')
			else 
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~18x ~r~Odpadno zelezo!')
			end
		end
	else
		if(xPlayer.getMoney() >= 8006) then
			xPlayer.removeMoney(8006)
			
			xPlayer.addInventoryItem('medarmour', 1)
			
			notification("Kupili ste ~g~Neprebojec I")
		else
			notification("Nimate dovolj ~r~denarja")
		end
	end
		
end)

RegisterServerEvent('esx_pawnshop:buyHeavyArmour')
AddEventHandler('esx_pawnshop:buyHeavyArmour', function()
	local _source = source
	local dscale = 0
	local dscale2 = 0
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if Config.PawnTradeItem then
		for i=1, #xPlayer.inventory, 1 do
			local item = xPlayer.inventory[i]

			if item.name == "dragon_scales" then
					dscale = item.count
			end
			if item.name == "metalscrap" then
					dscale2 = item.count
			end
		end
	
	
		if dscale >= 33 then
			if dscale2 >= 33 then
				xPlayer.removeInventoryItem('dragon_scales', 33)
				xPlayer.removeInventoryItem('metalscrap', 33)
				xPlayer.addInventoryItem('heavyarmour', 1)
			else 
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Potrbujete:')
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~18x ~s~Zmajeva luskev!')
				if dscale2 >= 33 then
					TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~18x ~s~Odpadno zelezo!')
				else 
					TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~18x ~r~Odpadno zelezo!')
				end
			end
		else 
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Potrbujete:')
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~18x ~r~Zmajeva luskev!')
			if dscale2 >= 33 then
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~18x ~s~Odpadno zelezo!')
			else 
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~b~18x ~r~Odpadno zelezo!')
			end
		end
	else
		if(xPlayer.getMoney() >= 8006) then
			xPlayer.removeMoney(8006)
			
			xPlayer.addInventoryItem('heavyarmour', 1)
			
			notification("Kupili ste ~g~Neprebojec I")
		else
			notification("Nimate dovolj ~r~denarja")
		end
	end
		
end)


--[[ ##### SELL #####]]--
RegisterServerEvent('esx_pawnshop:selldragon_scales')
AddEventHandler('esx_pawnshop:selldragon_scales', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local dscale = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "dragon_scales" then
				dscale = item.count
		end
	end
    
    if dscale > 0 then
        xPlayer.removeInventoryItem('dragon_scales', 1)
        xPlayer.addMoney(300)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nimate nobene zmajeve luske za prodat!')
    end
end)

RegisterServerEvent('esx_pawnshop:sellbones')
AddEventHandler('esx_pawnshop:sellbones', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local bones = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "bones" then
			bones = item.count
		end
	end
    
    if bones > 0 then
        xPlayer.removeInventoryItem('bones', 1)
        xPlayer.addMoney(32)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nimate nobenih kosti za prodat!')
    end
end)

RegisterServerEvent('esx_pawnshop:sellnuts_and_bolts')
AddEventHandler('esx_pawnshop:sellnuts_and_bolts', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local nandb = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "nuts_and_bolts" then
			nandb = item.count
		end
	end
    
    if nandb > 0 then
        xPlayer.removeInventoryItem('nuts_and_bolts', 1)
        xPlayer.addMoney(32)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nimate nobenih matic in vijakov za prodat!')
    end
end)


RegisterServerEvent('esx_pawnshop:sellgold_ring')
AddEventHandler('esx_pawnshop:sellgold_ring', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local prstan = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "gold_ring" then
			prstan = item.count
		end
	end
    
    if prstan > 0 then
        xPlayer.removeInventoryItem('gold_ring', 1)
        xPlayer.addMoney(32)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nimate nobenega zlatega prstana za prodat!')
    end
end)

RegisterServerEvent('esx_pawnshop:sellmetalscrap')
AddEventHandler('esx_pawnshop:sellmetalscrap', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local metalscrap = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "metalscrap" then
			metalscrap = item.count
		end
	end
    
    if metalscrap > 0 then
        xPlayer.removeInventoryItem('metalscrap', 1)
        xPlayer.addMoney(32)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nimate nobenega odpadnega zeleza za prodat!')
    end
end)

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end