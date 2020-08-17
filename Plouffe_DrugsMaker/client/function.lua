local recipe = {}

function OpenCutMenu()
	recipe = {}
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'selecterecipe_menu',
	{
		title    = "Choix des ingrédients",
		align    = 'center',
		elements = {
			{label = "Acetic anhydride", item = 'aceticanhydride',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Acide chlorhydrique", item = 'acidechlorhydrique',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Acide hydroclorhydrique", item = 'hydrochloricacid',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Acide lysergique", item = 'acidelysergique',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Acide bêta-hydroxybutyrique", item = 'hydroxybutyrate',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Acide benzoïque", item = 'acidebenzoique',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Bicarbonate de soude", item = 'bicarbonatesoude',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Carbonate de sodium", item = 'carbonatesodium',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Carbonate de lithium", item = 'lithiumcarbonate',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Chlorure d'ammonium", item = 'chloruredammonium',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Chlorure de mercure", item = 'chloruremercure',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Chloroforme", item = 'chloroforme',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Ephedrine", item = 'ephedrine',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Ergotamine", item = 'ergotamine',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Éther", item = 'ether',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Formaldehyde", item = 'formaldehyde',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Hydroxyde de sodium", item = 'hydroxydesodium',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Hyoscyamine", item = 'hyoscyamine',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Isopropanol", item = 'isopropylalcohol',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Lévamisole", item = 'levamisole',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Paracétamol", item = 'paracetamol',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Sucre", item = 'sucre',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Trichlorure de phosphoryle", item = 'phosphorylchloride',value = 1, type = 'slider', min = 1, max = 100,},
			{label = "Commencer le mix", item = 'go'},
			{label = "Fermer", item = 'close'},

		},
	},
	function(data, menu)
		local val = data.current.item

		if val == "close" then
			ESX.UI.Menu.CloseAll()
			recipe = {}
		end

		if val ~= "close" and val ~= "go" and val ~= nil then
			table.insert(recipe, {name = val, count = data.current.value})
			exports['mythic_notify']:SendAlert('inform', "Vous avez ajouter "..tostring(data.current.value).."x "..data.current.label.." a votre mix.", 3000, { ['background-color'] = '#22ed07', ['color'] = '#fffcfc' })
		end
		
		if val == "go" then
			ESX.UI.Menu.CloseAll()

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'cut_menu',
			{
				title    = "Choix de la drogue",
				align    = 'center',
				elements = {
					{label = "Méthamphétamine", value = 'meth'},
					{label = "Héroine", value = 'heroine'},
					{label = "Cocaine", value = 'coke'},
					{label = "Opium", value = 'opium'},
					{label = "Mdma", value = 'mdma'},
					{label = "Lsd", value = 'lsd'},
					{label = "Ghb", value = 'ghb'}
		
				},
			},
			function(data2, menu2)
				local drug = data2.current.value
				
				if drug ~= nil then
					ESX.UI.Menu.CloseAll()
					ESX.TriggerServerCallback('Plouffe_DrugsMaker:ItemsCheck', function(check)
						local nextStep = check
						SetEntityHeading(GetPlayerPed(-1),289.19)
						TriggerEvent("mythic_progbar:client:progress", {
							name = "making_drugs",
							duration = 6000,
							label = "Fabrication de drogues",
							useWhileDead = false,
							canCancel = false,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
							animation = {
								animDict = "mini@drinking",
								anim = "shots_barman_a",
							}
						}, function(status)
							if not status then
								local input = SelectRandomInputDouble()

								if input == false then
									exports['mythic_notify']:SendAlert('inform', 'Vous avez echouer le mélange...', 4000, { ['background-color'] = '#fa0000', ['color'] = '#fffcfc' })
									FailedMix()
								elseif nextStep == false then
									exports['mythic_notify']:SendAlert('inform', 'Mixologie incorrecte...', 4000, { ['background-color'] = '#fa0000', ['color'] = '#fffcfc' })
									FailedMix()
								elseif input == true and nextStep == true then
									exports['mythic_notify']:SendAlert('inform', "Vous avez réussi votre mix a 100%!", 3000, { ['background-color'] = '#22ed07', ['color'] = '#fffcfc' })
									local rng = math.random(1,15)
									TriggerServerEvent("Bckekw_items:AddItem",drug,rng)
								end
							end
						end)
					end, drug,recipe)
				end
			end,
			function(data2, menu2)
				menu2.close()
			end)
		end
	end,
	function(data, menu)
		menu.close()
	end)
end

function OpenShopMenu()
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'cut_menu',
	{
		title    = "Fabrication",
		align    = 'left',
		elements = {
			{label = "Acetic anhydride [4$]", item = 'aceticanhydride',value = 1, type = 'slider', min = 1, max = 100, price = 4},
			{label = "Acide chlorhydrique [6$]", item = 'acidechlorhydrique',value = 1, type = 'slider', min = 1, max = 100, price = 6},
			{label = "Acide hydroclorhydrique [3$]", item = 'hydrochloricacid',value = 1, type = 'slider', min = 1, max = 100, price = 3},
			{label = "Acide lysergique [7$]", item = 'acidelysergique',value = 1, type = 'slider', min = 1, max = 100, price = 7},
			{label = "Acide bêta-hydroxybutyrique [5$]", item = 'hydroxybutyrate',value = 1, type = 'slider', min = 1, max = 100, price = 5},
			{label = "Acide benzoïque [2$]", item = 'acidebenzoique',value = 1, type = 'slider', min = 1, max = 100, price = 2},
			{label = "Bicarbonate de soude [8$]", item = 'bicarbonatesoude',value = 1, type = 'slider', min = 1, max = 100, price = 8},
			{label = "Carbonate de sodium [1$]", item = 'carbonatesodium',value = 1, type = 'slider', min = 1, max = 100, price = 1},
			{label = "Carbonate de lithium [9$]", item = 'lithiumcarbonate',value = 1, type = 'slider', min = 1, max = 100, price = 9},
			{label = "Chlorure d'ammonium [7$]", item = 'chloruredammonium',value = 1, type = 'slider', min = 1, max = 100, price = 7},
			{label = "Chlorure de mercure [6$]", item = 'chloruremercure',value = 1, type = 'slider', min = 1, max = 100, price = 6},
			{label = "Chloroforme [9$]", item = 'chloroforme',value = 1, type = 'slider', min = 1, max = 100, price = 9},
			{label = "Ephedrine [4$]", item = 'ephedrine',value = 1, type = 'slider', min = 1, max = 100, price = 4},
			{label = "Ergotamine [7$]", item = 'ergotamine',value = 1, type = 'slider', min = 1, max = 100, price = 7},
			{label = "Éther [3$]", item = 'ether',value = 1, type = 'slider', min = 1, max = 100, price = 3},
			{label = "Formaldehyde [8$]", item = 'formaldehyde',value = 1, type = 'slider', min = 1, max = 100, price = 8},
			{label = "Hydroxyde de sodium [6$]", item = 'hydroxydesodium',value = 1, type = 'slider', min = 1, max = 100, price = 6},
			{label = "Hyoscyamine [11$]", item = 'hyoscyamine',value = 1, type = 'slider', min = 1, max = 100, price = 11},
			{label = "Isopropanol [5$]", item = 'isopropylalcohol',value = 1, type = 'slider', min = 1, max = 100, price = 5},
			{label = "Lévamisole [7$]", item = 'levamisole',value = 1, type = 'slider', min = 1, max = 100, price = 7},
			{label = "Paracétamol [10$]", item = 'paracetamol',value = 1, type = 'slider', min = 1, max = 100, price = 10},
			{label = "Sucre [1$]", item = 'sucre',value = 1, type = 'slider', min = 1, max = 100, price = 1},
			{label = "Trichlorure de phosphoryle [9$]", item = 'phosphorylchloride',value = 1, type = 'slider', min = 1, max = 100, price = 9}
		},
	},
	function(data, menu)
		ESX.UI.Menu.CloseAll()
		TriggerServerEvent("Plouffe_DrugsMaker:BuyItems",data.current.item,data.current.value,data.current.price)
	end,
	function(data2, menu2)
		menu2.close()
	end)
end

function OpenNewShopMenu()
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'cut_menu',
	{
		title    = "Fabrication",
		align    = 'left',
		elements = {
			{label = "Alluminium [2500$]", item = 'allum',value = 1, type = 'slider', min = 1, max = 100, price = 2500},
			{label = "Pate thermique [1500$]", item = 'thermalpaste',value = 1, type = 'slider', min = 1, max = 100, price = 1500}
		},
	},
	function(data, menu)
		ESX.UI.Menu.CloseAll()
		TriggerServerEvent("Plouffe_DrugsMaker:BuyItems",data.current.item,data.current.value,data.current.price)
	end,
	function(data2, menu2)
		menu2.close()
	end)
end

function OpenBagMenu()
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'bag_menu',
	{
		title    = "Emballage",
		align    = 'left',
		elements = {
			{label = "Méthamphétamine", value = 'meth', newitem = "pooch_meth"},
			{label = "Héroine", value = 'heroine', newitem = "pooch_heroine"},
			{label = "Cocaine", value = 'coke', newitem = "pooch_coke"},
			{label = "Opium", value = 'opium', newitem = "pooch_opium"},
			{label = "Mdma", value = 'mdma', newitem = "pooch_mdma"},
			{label = "Lsd", value = 'lsd', newitem = "pooch_lsd"},
			{label = "Ghb", value = 'ghb', newitem = "pooch_ghb"}

		},
	},
	function(data, menu)
		ESX.UI.Menu.CloseAll()
		Bagging(data.current.value,data.current.newitem)
	end,
	function(data2, menu2)
		menu2.close()
	end)
end

function OpenCraftMenu()
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'bag_menu',
	{
		title    = "Emballage",
		align    = 'left',
		elements = {
			{label = "Charge Thermique", value = 'thermal_charge'}
		},
	},
	function(data, menu)
		ESX.UI.Menu.CloseAll()
		TriggerServerEvent("Plouffe_DrugsMaker:Craft", data.current.value)
	end,
	function(data2, menu2)
		menu2.close()
	end)
end

function Bagging(itemtoremove,itemtoadd)
	local ped = GetPlayerPed(-1)
	SetEntityHeading(ped,356.11)

	TriggerEvent("mythic_progbar:client:progress", {
		name = "packing_drugs",
		duration = 20000,
		label = "Emballage des drogues",
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
			anim = "weed_stand_checkingleaves_idle_02_inspector",
		}
	}, function(status)
		if not status then
			local ez = SelectRandomInputDouble()
			if ez == true then
				TriggerServerEvent("Plouffe_DrugsMaker:Pooching",itemtoremove,itemtoadd)
			else
				TriggerServerEvent("Plouffe_DrugsMaker:FailedPooching",itemtoremove)	
			end
		end
	end)
end

function FailedMix()
	local fireCoords = vector3(1390.56,3605.29,37.94)
	local fire = StartScriptFire(fireCoords,25,true)
	Wait(7000)
	AddExplosion(fireCoords,"EXPLOSION_SMOKEGRENADE",9.0,true,false,100.0,true)
	ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
	Wait(5000)
	AddExplosion(fireCoords,"EXPLOSION_SMOKEGRENADE",9.0,true,false,100.0,true)
	ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
	Wait(30000)
	RemoveScriptFire(fire)
end

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
	    Wait(0)
	end
end

function OpenMenu(key)
	if key == "shop" then
		OpenShopMenu()
	elseif key == "cut" then
		OpenCutMenu()
	elseif key == "bag" then
		OpenBagMenu()
	elseif key == "newShop" then
		OpenNewShopMenu()
	elseif key == "craft" then
		OpenCraftMenu()
	end
end

function SelectRandomInput()
    local keyToPress = nil
    local inputToPress = nil
    local secondInputToPress = nil
    local secondKeyToPress = nil
    local readyToPress = false
    local milliSecChecks = 0
    local succes = false
    local firstInput = false
    
    local keyInputs = {
      {["id"] = 1, ["value"] = 'M', ["input"] = 244, },
      {["id"] = 2, ["value"] = '=', ["input"] = 83, },
      {["id"] = 3, ["value"] = 'H', ["input"] = 304, },
      {["id"] = 4, ["value"] = 'K', ["input"] = 311, },
      {["id"] = 5, ["value"] = 'Z', ["input"] = 20, },
    --   {["id"] = 6, ["value"] = 'TAB', ["input"] = 37, },
    --   {["id"] = 7, ["value"] = 'R', ["input"] = 45, },
      {["id"] = 6, ["value"] = 'F9', ["input"] = 56, }
    }
      
    local randi = math.random(1,8)
      
    for i = 1, #keyInputs, 1 do 
        if randi == keyInputs[i].id then
            inputToPress = keyInputs[i].input
            keyToPress = keyInputs[i].value
        end
    end
      
    local msg = ("Appuyer sur: "..keyToPress)
    exports['mythic_notify']:SendAlert('inform', msg, 13000, { ['background-color'] = ' #ff0000 ', ['color'] = '#fffcfc' })
    
    Wait(500)
  
    Citizen.CreateThread(function()
        while readyToPress == true do
            Wait(1)

            milliSecChecks = milliSecChecks + 1

            if milliSecChecks >= 225 then
                
                if firstInput == false then
                    exports['mythic_notify']:SendAlert('inform', "Vous avez raté la mixologie..", 13000, { ['background-color'] = ' #ff0000 ', ['color'] = '#fffcfc' })
                end
                
                readyToPress = false
                break
            end
        
            if succes then
            	break
            end
        
            if IsControlJustReleased(0,inputToPress) then
              exports['mythic_notify']:SendAlert('inform', "Premiere input réussi", 10000, { ['background-color'] = '#22ed07', ['color'] = '#fffcfc' })
              Wait(10)
              firstInput = true
            end

            if firstInput then
                succes = true
                readyToPress = false
            end
        end
    end)

    while readyToPress do 
        Wait(100)
    end

    return succes
  
end

function SelectRandomInputDouble()
    local keyToPress = "M"
    local inputToPress = 244
    local secondInputToPress = 56
    local secondKeyToPress = "F9"
    local readyToPress = false
    local milliSecChecks = 0
    local succes = false
    local firstInput = false
	local secondInput = false
	local count = 0
	
	local randi = math.random(1,8)
	local rando = math.random(1,8)

	-- if randi == rando then
	-- 	repeat 
	-- 		randi = math.random(1,8)
	-- 	until randi ~= rando and randi ~= nil
	-- end
	
    local keyInputs = {
      {["id"] = 1, ["value"] = 'M', ["input"] = 244, },
      {["id"] = 2, ["value"] = '=', ["input"] = 83, },
      {["id"] = 3, ["value"] = 'H', ["input"] = 304, },
      {["id"] = 4, ["value"] = 'K', ["input"] = 311, },
      {["id"] = 5, ["value"] = 'Z', ["input"] = 20, },
      {["id"] = 6, ["value"] = 'F9', ["input"] = 56, }
    }
      
    for i = 1, #keyInputs, 1 do 
        if randi == keyInputs[i].id then
            inputToPress = keyInputs[i].input
            keyToPress = keyInputs[i].value
        end
    end

    for i = 1, #keyInputs, 1 do 
        if rando == keyInputs[i].id then
            secondInputToPress = keyInputs[i].input
            secondKeyToPress = keyInputs[i].value
            readyToPress = true
        end
	end
	
	-- while readyToPress == false do 
	-- 	count = count + 1
	-- 	if count >= 10 then
	-- 		for i = 1, #keyInputs, 1 do 
	-- 			if randi == keyInputs[i].id then
	-- 				inputToPress = keyInputs[i].input
	-- 				keyToPress = keyInputs[i].value
	-- 			end
	-- 		end
		
	-- 		for i = 1, #keyInputs, 1 do 
	-- 			if rando == keyInputs[i].id then
	-- 				secondInputToPress = keyInputs[i].input
	-- 				secondKeyToPress = keyInputs[i].value
	-- 				readyToPress = true
	-- 			end
	-- 		end
	-- 	end

	-- 	if readyToPress == true then
	-- 		break 
	-- 	end
	-- 	print("waiting")
	-- 	Wait(50)
	-- end

	while readyToPress == false do
		Wait(50)
		count = count + 1 
		if count >= 10 then
			readyToPress = true
			count = 0
			break
		end
	end
	
    local msg = ("Appuyer sur: "..keyToPress)
    exports['mythic_notify']:SendAlert('inform', msg, 13000, { ['background-color'] = ' #ff0000 ', ['color'] = '#fffcfc' })
    local secondMsg = ("Ensuite appuyer sur: "..secondKeyToPress)
    exports['mythic_notify']:SendAlert('inform', secondMsg, 13000, { ['background-color'] = ' #ff0000 ', ['color'] = '#fffcfc' })
  
    Citizen.CreateThread(function()
        while readyToPress == true do
            Wait(1)

            milliSecChecks = milliSecChecks + 1

            if milliSecChecks >= 225 then
                
                if firstInput == false then
                    exports['mythic_notify']:SendAlert('inform', "Vous avez raté le premier input..", 13000, { ['background-color'] = ' #ff0000 ', ['color'] = '#fffcfc' })
                end
                
                if secondInput == false then
                    exports['mythic_notify']:SendAlert('inform', "Vous avez raté le deuxieme input..", 13000, { ['background-color'] = ' #ff0000 ', ['color'] = '#fffcfc' })
                end
                
                readyToPress = false
                break
            end
        
            if succes then
              break
            end
        
            if IsControlJustReleased(0,inputToPress) and firstInput == false then
              exports['mythic_notify']:SendAlert('inform', "Premiere input réussi", 10000, { ['background-color'] = '#22ed07', ['color'] = '#fffcfc' })
              Wait(10)
              firstInput = true
            end

            if IsControlJustReleased(0,secondInputToPress) and secondInput == false then
                exports['mythic_notify']:SendAlert('inform', "Deuxieme input réussi", 10000, { ['background-color'] = '#22ed07', ['color'] = '#fffcfc' })
                secondInput = true
            end

            if firstInput and secondInput then
                succes = true
                readyToPress = false
            end
        end
    end)

    while readyToPress do 
        Wait(100)
    end

    return succes
  
end