local function AddModel(tblAddTable, strModel, vecPostion, angAngle, clrColor, strMaterial, vecScale)
	tblAddTable.Model = tblAddTable.Model or {}
	if type(tblAddTable.Model) ~= "table" then tblAddTable.Model = {} end
	table.insert(tblAddTable.Model, {Model = strModel, Position = vecPostion, Angle = angAngle, Color = clrColor, Material = strMaterial, Scale = vecScale})
	return tblAddTable
end
local function AddStats(tblAddTable, strSlot, intArmor)
	tblAddTable.Slot = strSlot
	tblAddTable.Armor = intArmor
	return tblAddTable
end
local function AddBuff(tblAddTable, strBuff, intAmount)
	tblAddTable.Buffs[strBuff] = intAmount
	return tblAddTable
end

local Item = QuickCreateItemTable(BaseArmor, "armor_shoulder_combine", "Combine Shoulder pads", "Shoulder pads made from Combine faces!", "icons/hat_cheifshat")
Item = AddModel(Item, "models/BarneyHelmet_faceplate.mdl", Vector(5, 0.6, -6.1), Angle(-117.1, -145, 2), nil, "Models/Gibs/metalgibs/metal_gibs.vtf")
Item = AddModel(Item, "models/BarneyHelmet_faceplate.mdl", Vector(13.6, 0, -6.2), Angle(-50.2, 180, 0), nil, "Models/Gibs/metalgibs/metal_gibs.vtf")
Item = AddStats(Item, "slot_shoulder", 5)
Item = AddBuff(Item, "stat_agility", 1)
Item.Level = 7
Item.Weight = 2
Item.SellPrice = 760
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_shoulder_cyborg", "Biomechanical Shoulders", "Alittle creeky... needs oil.", "icons/hat_cheifshat")
Item = AddModel(Item, "models/Gibs/manhack_gib03.mdl", Vector(5.5, -1.2, -0.6), Angle(-82.3, -42.2, -11.4)) --left
Item = AddModel(Item, "models/Gibs/manhack_gib02.mdl", Vector(4.1, -0.3, 2.1), Angle(99.7, 180, 173.3))
Item = AddStats(Item, "slot_shoulder", 23)
Item = AddBuff(Item, "stat_dexterity", 6)
Item.Level = 20
Item.Weight = 2
Item.SellPrice = 5800
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_shoulder_antlion", "Antlion Shell Pauldrons", "They're Sticky... Why are they Sticky?!", "icons/hat_cheifshat")
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(5.2, 0.6, -3.9), Angle(-117.1, -145, 2)) --left
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(2.1, -0.1, -1.4), Angle(153.2, 180, -180))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(0.1, 0.1, 1.9), Angle(-23.4, 11.4, 2))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(-9.9, 1, 1), Angle(23.4, 2, 7.4)) --right
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(-11.3, 0.8, 2.3), Angle(10, 2, 6))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(-9.7, 1.7, 8.8), Angle(-28.8, 2, 7.4))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_1.mdl", Vector(12.6, 2.1, 9), Angle(-118.4, 0.7, 6))
Item = AddStats(Item, "slot_shoulder", 25)
Item = AddBuff(Item, "stat_maxhealth", 5)
Item.Level = 27
Item.Weight = 2
Item.SellPrice = 6100
Item.Set = "armor_antlion"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_shoulder_skele", "Bone Sholders", "Extremely Sharp attire.", "icons/hat_cheifshat")
Item = AddModel(Item, "models/Gibs/HGIBS.mdl", Vector(7.7, 1.2, -2.1), Angle(-83.6, 158.6, 55.5))
Item = AddModel(Item, "models/Gibs/HGIBS.mdl", Vector(15.3, 1.2, 0.3), Angle(3.3, 180, -3.3))
Item = AddModel(Item, "models/Gibs/manhack_gib05.mdl", Vector(5, -4.6, -0.3), Angle(-147.9, -169.3, 87.7))
Item = AddModel(Item, "models/Gibs/manhack_gib05.mdl", Vector(1.7, -0.6, -0.6), Angle(-147.9, -169.3, 87.7))
Item = AddModel(Item, "models/Gibs/manhack_gib05.mdl", Vector(14.8, 6.4, -1.4), Angle(-147.9, 7.4, 87.7))
Item = AddStats(Item, "slot_shoulder", 38)
Item = AddBuff(Item, "stat_strength", 10)
Item.Level = 33
Item.Weight = 4
Item.SellPrice = 9786
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_shoulder_bio", "Pauldrons of the Overseer", "Created from light and durable metal, increases ranged combat", "icons/hat_cheifshat")
Item = AddModel(Item, "models/Gibs/manhack_gib03.mdl", Vector(2.1, 0.3, -4.5), Angle(-15.4, -51.5, -169.3)) --left
Item = AddModel(Item, "models/Gibs/manhack_gib02.mdl", Vector(3.3, -0.3, 2.1), Angle(99.7, 180, 173.3))
Item = AddModel(Item, "models/Gibs/manhack_gib01.mdl", Vector(-11, 2.1, -1.5), Angle(125.1, 149.2, -50.2))
Item = AddModel(Item, "models/Gibs/manhack_gib01.mdl", Vector(11.6, -0.3, 2.1), Angle(-123.8, -47.5, -170.6))
Item = AddStats(Item, "slot_shoulder", 42)
Item = AddBuff(Item, "stat_dexterity", 20)
Item.Level = 42
Item.Weight = 2
Item.SellPrice = 9960
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_shoulder_tyrant", "Pauldrons of the Tyrant", "Made from the finest materials, for protection.", "icons/hat_cheifshat")
Item = AddModel(Item, "models/props_combine/stalkerpod_lid.mdl", Vector(-0.1, 1.4, -3.7), Angle(-90.3, -6, -139.9))
Item = AddModel(Item, "models/props_combine/stalkerpod_lid.mdl", Vector(1.2, 0.8, -0.3), Angle(-180, -0.7, 180))
Item = AddStats(Item, "slot_shoulder", 43)
Item = AddBuff(Item, "stat_maxhealth", 35)
Item.Level = 45
Item.Weight = 2
Item.SellPrice = 10960
Register.Item(Item)