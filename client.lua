local Keys = {
 ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
 ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
 ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
 ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
 ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
 ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
 ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
 ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
 ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
   
ESX = nil
local PlayerData              = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local blips = {
      {title="Pawnshop", colour=4, id=133, x = 412.31, y = 314.11, z = 103.02}
}
 
      
Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
  
local gym = {
    {x = 412.31, y = 314.11, z = 103.02}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(gym) do
            DrawMarker(21, gym[k].x, gym[k].y, gym[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 153, 255, 255, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(gym) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gym[k].x, gym[k].y, gym[k].z)

            if dist <= 0.5 then
				hintToDisplay('Pritisnite ~INPUT_CONTEXT~ da odprete ~b~zastavljalnico~w~')
				if IsControlJustPressed(0, Keys['E']) then
					OpenPawnMenu()
				end			
            end
        end
    end
end)

function OpenPawnMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'pawn_menu',
        {
            title    = 'Pawnshop',
            elements = {
				{label = 'Zamenjaj', value = 'shop'}, --Trade
				{label = 'Prodaj', value = 'sell'}, --Sell
            }
        },
        function(data, menu)
            if data.current.value == 'shop' then
				OpenPawnShopMenu()
            elseif data.current.value == 'sell' then
				OpenSellMenu()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenPawnShopMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'pawn_shop_menu',
        {
            title    = 'Nakup',
            elements = {
				{label = 'Orodje za popravilo', value = 'fixkit'},
				{label = 'Neprebojec I (35000kr)', value = 'smallarmour'},
				{label = 'Neprebojec II (35000kr)', value = 'medarmour'},
				{label = 'Neprebojec III (35000kr)', value = 'heavyarmour'},
				--{label = 'Vrtalni Stroj (45000kr)', value = 'drill'},
				--{label = 'Ögonbindel (16214kr)', value = 'blindfold'},
                --{label = 'Fiskespö (2591kr)', value = 'fishingrod'},
                --{label = 'Antibiotika (1239kr)', value = 'antibiotika'},
                --{label = 'Samsung S8 (3400kr)', value = 'phone'},
            }
        },
        function(data, menu)
            if data.current.value == 'fixkit' then
				TriggerServerEvent('esx_pawnshop:buyFixkit')
            elseif data.current.value == 'smallarmour' then
				TriggerServerEvent('esx_pawnshop:buySmallArmour')
			elseif data.current.value == 'medarmour' then
				TriggerServerEvent('esx_pawnshop:buyMedArmour')
			elseif data.current.value == 'heavyarmour' then
				TriggerServerEvent('esx_pawnshop:buyHeavyArmour')
            --elseif data.current.value == 'drill' then
				--TriggerServerEvent('esx_pawnshop:buyDrill')
            --elseif data.current.value == 'blindfold' then
				--TriggerServerEvent('esx_pawnshop:buyBlindfold')
            --elseif data.current.value == 'fishingrod' then
                --TriggerServerEvent('esx_pawnshop:buyFishingrod')
            --elseif data.current.value == 'antibiotika' then
                --TriggerServerEvent('esx_pawnshop:buyAntibiotika')  
            --elseif data.current.value == 'phone' then
				--TriggerServerEvent('esx_pawnshop:buyPhone')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end



function OpenSellMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'pawn_sell_menu',
        {
            title    = 'Prodaja',
            elements = {
                {label = 'Dragon Scale (32$)', value = 'dragon_scales'},
                {label = 'Kosti (32$)', value = 'bones'},
                {label = 'Matice in vijaki (32$)', value = 'nuts_and_bolts'},
                {label = 'Zlati prstan (32$)', value = 'gold_ring'},
                {label = 'Odpadno zelezo (32$)', value = 'metalscrap'},
                --{label = 'Tomflaskor (1)', value = 'bottle'},
                --{label = 'Fiskespö (1000)', value = 'fishingrod'},
                --{label = 'Borrmaskin(5000)', value = 'drill'},
                --{label = 'Ögonbindel(2000)', value = 'blindfold'},
            }
        },
        function(data, menu)
            if data.current.value == 'dragon_scales' then
				TriggerServerEvent('esx_pawnshop:selldragon_scales')
            elseif data.current.value == 'bones' then
				TriggerServerEvent('esx_pawnshop:sellbones')
            elseif data.current.value == 'nuts_and_bolts' then
				TriggerServerEvent('esx_pawnshop:sellnuts_and_bolts')
            elseif data.current.value == 'gold_ring' then
				TriggerServerEvent('esx_pawnshop:sellgold_ring')
            elseif data.current.value == 'metalscrap' then
				TriggerServerEvent('esx_pawnshop:sellmetalscrap')
            --elseif data.current.value == 'bottle' then
                --TriggerServerEvent('esx_pawnshop:sellbottle')
            --elseif data.current.value == 'fishingrod' then
                --TriggerServerEvent('esx_pawnshop:sellfishingrod')
            --elseif data.current.value == 'drill' then
                --TriggerServerEvent('esx_pawnshop:selldrill')
            --elseif data.current.value == 'blindfold' then
                --TriggerServerEvent('esx_pawnshop:sellblindfold')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end





