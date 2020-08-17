local HasAlreadyEnteredZone = false
local LastZone = nil
local canOpenMenu = false
local zoneMenu = nil

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed(-1)
		local pedCoords = GetEntityCoords(ped)
		local letSleep = true
		local isInZone  = false
		local currentZone = nil
		local menu = nil

		for k,v in ipairs(DrugsMaker.Coords) do 
			local dstCheck = #(pedCoords -v.coords)
			if dstCheck <= 15 then
				letSleep = false
				if dstCheck <= 1.5 then
					ESX.Game.Utils.DrawText3D(pedCoords,v.txt,v.txtSize)
					isInZone  = true
					currentZone = k
					menu = v.type
				end
			end
		end

		if (isInZone and not HasAlreadyEnteredZone) or (isInZone and LastZone ~= currentZone) then
			HasAlreadyEnteredZone = true
			LastZone                = currentZone
			TriggerEvent('Plouffe_DrugsMaker:InZone', currentZone,menu)
		end

		if not isInZone and HasAlreadyEnteredZone then
			HasAlreadyEnteredZone = false
			TriggerEvent('Plouffe_DrugsMaker:OuOfZone', LastZone)
		end

		if letSleep == true then
			Wait(5000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Wait(0)
		if zoneMenu ~= nil and canOpenMenu == true then
			if IsControlJustReleased(0, 38) then
				OpenMenu(zoneMenu)
			end
		else
			Wait(1000)
		end
	end
end)

RegisterNetEvent("Plouffe_DrugsMaker:InZone")
AddEventHandler("Plouffe_DrugsMaker:InZone",function(zone,menu)
	zoneMenu = menu
	canOpenMenu = true
    ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent("Plouffe_DrugsMaker:OuOfZone")
AddEventHandler("Plouffe_DrugsMaker:OuOfZone",function(zone)
	zoneMenu = nil
	canOpenMenu = false
    ESX.UI.Menu.CloseAll()
end)