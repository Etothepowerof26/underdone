local function AddModel(tblAddTable, strModel, vecPostion, angAngle, clrColor, strMaterial, vecScale)
	tblAddTable.Model = tblAddTable.Model or {}
	if type(tblAddTable.Model) ~= "table" then tblAddTable.Model = {} end
	table.insert(tblAddTable.Model, {Model = strModel, Position = vecPostion, Angle = angAngle, Color = clrColor, Material = strMaterial, Scale = vecScale})
	return tblAddTable
end
local function AddStats(tblAddTable, strSlot, intArmor)
	tblAddTable.Slot = strSlot
	tblAddTable.Armor = intPower
	return tblAddTable
end
local function AddBuff(tblAddTable, strBuff, intAmount)
	tblAddTable.Buffs[strBuff] = intAmount
	return tblAddTable
end

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_backpack", "Small Backpacks", "It will add inventory space", "icons/item_cash")
Item = AddModel(Item, "models/weapons/w_defuser.mdl", Vector(-3.9, -0.3, -14.2), Angle(-0.7, -6, 2))
Item = AddStats(Item, "slot_waist", 0)
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_waist_jetpack", "Jetpack", "Just for show!", "icons/hat_cheifshat")
Item = AddModel(Item, "models/props_combine/breenlight.mdl", Vector(7.7, -4.3, -2.1), Angle(-15.4, -177.3, 0.7))
Item = AddModel(Item, "models/props_combine/breenlight.mdl", Vector(-0.3, 7.7, -0.1), Angle(-4.7, -4.7, -0.7))
Item = AddModel(Item, "models/props_combine/combine_emitter01.mdl", Vector(4.3, -4.3, -3.9), Angle(-94.3, 180, -2))
Item = AddStats(Item, "slot_waist", 1)
Item = AddBuff(Item, "stat_strength", 3)
Item = AddBuff(Item, "stat_agility", 5)
Item.Weight = 2
Item.SellPrice = 300
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_leather", "Leather Belt", "4str 4stam leather belt? UGH Level 14? UGHHUGH", "icons/item_cash")
Item = AddModel(Item, "models/props_c17/pulleywheels_large01.mdl", Vector(1.22, 0, -0.98), Angle(0, 90, 0), nil, nil, Vector(0.4, 0.37, 0.32))--Waist
Item = AddModel(Item, "models/props_vehicles/apc_tire001.mdl", Vector(6.34, 0, 0), Angle(-90, 0, 0), nil, nil, Vector(0.1, 0.1, 0.1))--Buckle
Item = AddStats(Item, "slot_waist", 0)
Item = AddBuff(Item, "stat_strength", 4)
Item = AddBuff(Item, "stat_maxhealth", 4)
Item.Level = 14
Item.Weight = 1
Item.SellPrice = 1444
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_cyborg", "Biomechanical Spine", "Resistance is Futile.", "icons/item_cash")
Item = AddModel(Item, "models/Gibs/manhack_gib02.mdl", Vector(-4.39, -4.88, -1.46), Angle(0, -90, 52.68), nil, nil, Vector(1, 1, 1))--left
Item = AddStats(Item, "slot_waist", 5)
Item = AddBuff(Item, "stat_dexterity", 3)
Item.Level = 20
Item.Weight = 1
Item.SellPrice = 5205
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_car", "Steering belt", "Steer me in the right direction", "icons/item_cash")
Item = AddModel(Item, "models/props_borealis/door_wheel001a.mdl", Vector(4.88, 0, 0), Angle(-90, 79.02, 0), nil, nil, Vector(0.7, 0.7, 0.7))--left
Item = AddStats(Item, "slot_waist", 13)
Item = AddBuff(Item, "stat_dexterity", 1)
Item = AddBuff(Item, "stat_strength", 1)
Item = AddBuff(Item, "stat_maxhealth", 5)
Item.Level = 1
Item.Weight = 1
Item.SellPrice = 1
Register.Item(Item)


local Item = QuickCreateItemTable(BaseArmor, "armor_belt_antlion", "Antlion Shell Codpiece", "I don't want Antlion pieces near there!", "icons/item_cash")
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(0, 0, 3.66), Angle(0, -90, 0), nil, nil, Vector(1, 1, 1))--left
Item = AddStats(Item, "slot_waist", 15)
Item = AddBuff(Item, "stat_maxhealth", 10)
Item.Level = 25
Item.Weight = 1
Item.SellPrice = 6302
Item.Set = "armor_antlion"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_skele", "Gutguard of the Wraith", "Made from those who are dead, forged for reaping.", "icons/item_cash")
Item = AddModel(Item, "models/Gibs/HGIBS.mdl", Vector(1.22, 0, 8.05), Angle(-71.34, -90, 0), nil, nil, Vector(1, 1, 1))
Item = AddModel(Item, "models/Gibs/HGIBS.mdl", Vector(1.7, -0.3, -5.2), Angle(3.3, -2, 2))
Item = AddModel(Item, "models/Gibs/manhack_gib05.mdl", Vector(1, -3.9, -2.1), Angle(-110.4, 7.4, -14.1))
Item = AddModel(Item, "models/Gibs/manhack_gib05.mdl", Vector(0.6, -3, 1.7), Angle(-74.3, 168, 19.4))
Item = AddStats(Item, "slot_waist", 13)
Item = AddBuff(Item, "stat_strength", 15)
Item.Level = 32
Item.Weight = 2
Item.SellPrice = 12456
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_bio", "Gutguard of the Overseer", "Created from light and durable metal, increases ranged combat.", "icons/item_cash")
Item = AddModel(Item, "models/Gibs/manhack_gib02.mdl", Vector(-4.39, -4.88, -1.46), Angle(0, -90, 52.68), nil, nil, Vector(1, 1, 1))--left
Item = AddStats(Item, "slot_waist", 15)
Item = AddBuff(Item, "stat_dexterity", 5)
Item = AddBuff(Item, "stat_maxhealth", 10)
Item.Level = 42
Item.Weight = 1
Item.SellPrice = 22467
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_belt_tyrant", "Gutguard of the Tyrant", "Made from the finest materials, for protection.", "icons/item_cash")
Item = AddModel(Item, "models/props_combine/stalkerpod_lid.mdl", Vector(-3.17, 0, 0.73), Angle(-144.88, -90, 180), nil, nil, Vector(1, 1, 1))
Item = AddModel(Item, "models/props_combine/stalkerpod_lid.mdl", Vector(1, 0.1, 0.1), Angle(109.1, -178.7, 0.7))
Item = AddStats(Item, "slot_waist", 20)
Item = AddBuff(Item, "stat_maxhealth", 15)
Item.Level = 43
Item.Weight = 3
Item.SellPrice = 25483
Register.Item(Item)
