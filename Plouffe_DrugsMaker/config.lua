DrugsMaker = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while not ESX do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

DrugsMaker.Keys = {
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

DrugsMaker.CraftList = {
    {["itemname"] = "heroine", ["requireditems"] = {{["name"] = "aceticanhydride", ["count"] = 3}, {["name"] = "chloroforme", ["count"] = 2}, {["name"] = "carbonatesodium", ["count"] = 5}, {["name"] = "isopropylalcohol", ["count"] = 1}}},
    {["itemname"] = "coke"   , ["requireditems"] = {{["name"] = "bicarbonatesoude", ["count"] = 2}, {["name"] = "sucre", ["count"] = 5}, {["name"] = "paracetamol", ["count"] = 3}, {["name"] = "levamisole", ["count"] = 2}}},
    {["itemname"] = "lsd"    , ["requireditems"] = {{["name"] = "phosphorylchloride", ["count"] = 2}, {["name"] = "ergotamine", ["count"] = 1}, {["name"] = "acidelysergique", ["count"] = 3}}},
    {["itemname"] = "ghb"    , ["requireditems"] = {{["name"] = "hydroxybutyrate", ["count"] = 267}, {["name"] = "ephedrine", ["count"] = 4}}},
    {["itemname"] = "meth"   , ["requireditems"] = {{["name"] = "ephedrine", ["count"] = 4}, {["name"] = "hydrochloricacid", ["count"] = 2}, {["name"] = "lithiumcarbonate", ["count"] = 1},{["name"] = "hydroxydesodium", ["count"] = 2}}},
    {["itemname"] = "mdma"   , ["requireditems"] = {{["name"] = "formaldehyde", ["count"] = 3}, {["name"] = "chloruredammonium", ["count"] = 3}, {["name"] = "chloruremercure", ["count"] = 1}, {["name"] = "isopropylalcohol", ["count"] = 5}, {["name"] = "hydrochloricacid", ["count"] = 1}}},
    {["itemname"] = "opium"  , ["requireditems"] = {{["name"] = "acidebenzoique", ["count"] = 2}, {["name"] = "hyoscyamine", ["count"] = 16}}}
}

DrugsMaker.BlackCraftList = {
    {["itemname"] = "thermal_charge", ["requireditems"] = {{["name"] = "poudre", ["count"] = 2}, {["name"] = "allum", ["count"] = 2}, {["name"] = "thermalpaste", ["count"] = 1},}}
}

DrugsMaker.BagingList = {
    {["itemname"] = "meth"   , ["newitem"] = "pooch_meth"},
    {["itemname"] = "coke"   , ["newitem"] = "pooch_coke"},
    {["itemname"] = "heroine", ["newitem"] = "pooch_heroine"},
    {["itemname"] = "opium"  , ["newitem"] = "pooch_opium"},
    {["itemname"] = "mdma"   , ["newitem"] = "pooch_mdma"},
    {["itemname"] = "lsd"    , ["newitem"] = "pooch_lsd"},
    {["itemname"] = "ghb"    , ["newitem"] = "pooch_ghb"}
}

DrugsMaker.Coords = {
    {["type"] = "shop", ["coords"] = vector3(-330.81,-2448.21,7.36), ["txt"] = "Appuyer sur [E] pour ouvrir le magasin",  ["txtSize"] = 0.4},
    {["type"] = "cut", ["coords"] = vector3(1389.15,3605.16,38.94) , ["txt"] = "Appuyer sur [E] pour transformer", ["txtSize"] = 0.4},
    {["type"] = "bag", ["coords"] = vector3(890.34,-960.69,39.28)  , ["txt"] = "Appuyer sur [E] pour emballer", ["txtSize"] = 0.4},
    {["type"] = "newShop", ["coords"] = vector3(2391.56,3062.8,51.44), ["txt"] = "Appuyer sur [E] pour ouvrir le magasin",  ["txtSize"] = 0.4},
    {["type"] = "craft", ["coords"] = vector3(722.75,4190.25,41.09), ["txt"] = "Appuyer sur [E] pour crafter",  ["txtSize"] = 0.4},
    {["type"] = "cut", ["coords"] = vector3(2433.49,4968.81,42.35), ["txt"] = "Appuyer sur [E] pour transformer",  ["txtSize"] = 0.4},
    {["type"] = "cut", ["coords"] = vector3(-1372.91,-311.22,39.63), ["txt"] = "Appuyer sur [E] pour transformer",  ["txtSize"] = 0.4},
}