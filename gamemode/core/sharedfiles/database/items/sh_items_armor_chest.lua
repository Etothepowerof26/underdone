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

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_junkarmor", "Junky Armor", "Protects your heart and lungs from gettin pwnd", "icons/amor_junkyarmor")
Item = AddModel(Item, "models/Gibs/Shield_Scanner_Gib2.mdl", Vector(-0.2, 0.2, -3.3), Angle(-95.9, -10.5, 0))
Item = AddModel(Item, "models/Gibs/Scanner_gib02.mdl", Vector(-4.4, 3.1, 3.9), Angle(46, 9.2, -116.9))
Item = AddModel(Item, "models/Gibs/Scanner_gib02.mdl", Vector(7, 5, 4.6), Angle(-23.4, -4.7, 56.9))
Item = AddStats(Item, "slot_chest", 15)
Item = AddBuff(Item, "stat_maxhealth", 5)
Item.Weight = 2
Item.SellPrice = 420
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_refinedjunkarmor", "Refined Junky Armor", "Protects your Body while still being cool", "icons/junk_box1")
Item = AddModel(Item, "models/Gibs/Shield_Scanner_Gib2.mdl", Vector(-0.2, 0.2, -3.3), Angle(-95.9, -10.5, 0))
Item = AddModel(Item, "models/Gibs/Shield_Scanner_Gib4.mdl", Vector(-2.3, -0.3, -5), Angle(-79.6, -4.7, 12.7))
Item = AddModel(Item, "models/Gibs/Scanner_gib02.mdl", Vector(-4.4, 3.1, 3.9), Angle(46, 9.2, -116.9))
Item = AddModel(Item, "models/Gibs/Scanner_gib02.mdl", Vector(7, 5, 4.6), Angle(-23.4, -4.7, 56.9))
Item = AddModel(Item, "models/Gibs/Scanner_gib04.mdl", Vector(-3.7, 8.4, 0.6), Angle(-11.4, 110.4, 117.1))
Item = AddStats(Item, "slot_chest", 25)
Item = AddBuff(Item, "stat_maxhealth", 10)
Item.Level = 14
Item.Weight = 2
Item.SellPrice = 1020
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_antlionspiked", "Antlion Chest Armor", "Protects your Body while still being cool", "icons/junk_box1")
Item = AddModel(Item, "models/Gibs/Antlion_gib_Large_2.mdl", Vector(-1.9, 0.1, 4.6), Angle(-95.9, -10.5, 180))
Item = AddModel(Item, "models/Gibs/Antlion_gib_medium_3a.mdl", Vector(2.6, 1.9, 11.7), Angle(-180, -81, -36.8))
Item = AddModel(Item, "models/Gibs/Antlion_gib_medium_3a.mdl", Vector(-3.7, 3, 11.5), Angle(-159.9, -106.4, -32.8))
Item = AddModel(Item, "models/Gibs/Antlion_gib_Large_2.mdl", Vector(2.8, 0.6, 8.8), Angle(19.4, 3.3, -172))
Item = AddStats(Item, "slot_chest", 27)
Item = AddBuff(Item, "stat_maxhealth", 14)
Item.Level = 18
Item.Weight = 3
Item.SellPrice = 2020
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_cyborg", "Biomechanical Chest", "You will be assimilated!", "icons/junk_box1")
Item = AddModel(Item, "models/Gibs/manhack_gib03.mdl", Vector(-3.9, -1.7, 0.8), Angle(-114.4, -10.5, 119.8))
Item = AddModel(Item, "models/Gibs/manhack_gib03.mdl", Vector(0.1, 1, 4.6), Angle(-157.2, 158.6, 0))
Item = AddModel(Item, "models/Gibs/manhack_gib02.mdl", Vector(10.4, -0.1, -0.8), Angle(162.6, -14.1, 12.7))
Item = AddModel(Item, "models/Gibs/manhack_gib02.mdl", Vector(1.7, 9.9, -2.1), Angle(-18.1, -27.4, 0))
Item = AddStats(Item, "slot_chest", 40)
Item = AddBuff(Item, "stat_dexterity", 10)
Item.Level = 20
Item.Weight = 4
Item.SellPrice = 8020
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_antlion", "Antlion Shell Armor", "Crunchy!", "icons/junk_box1")
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(0.1, -4.1, 0.1), Angle(85, 67.6, 52.9))--front
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(0.8, -3, 2.1), Angle(-153.2, -0.7, 176))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(1, -7.7, 2.1), Angle(-153.2, -0.7, 176))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(-4.3, -3.2, 4.3), Angle(-153.2, -0.7, 174.6))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(-3.7, -6.6, 5.9), Angle(-153.2, -0.7, -173.3))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(-4.1, 0.3, 2.8), Angle(-153.2, -0.7, 149.2))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(-7.7, -3.2, 6.6), Angle(-153.2, -0.7, 176))
Item = AddModel(Item, "models/Gibs/Antlion_gib_Large_1.mdl", Vector(5.2, -7, 8.1), Angle(162.6, -74.3, -67.6))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(5, -5.9, 1.2), Angle(-170.6, -0.7, 180))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(4.1, -1.4, -0.1), Angle(-172, 0.7, 157.2))
Item = AddStats(Item, "slot_chest", 48)
Item = AddBuff(Item, "stat_maxhealth", 17)
Item.Level = 25
Item.Weight = 5
Item.SellPrice = 9020
Item.Set = "armor_antlion"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_chest_skele", "Bone Chest", "How many people died to make this...", "icons/junk_box1")
Item = AddModel(Item, "models/Gibs/HGIBS.mdl", Vector(1.9, -3.5, 2.8), Angle(6, -0.7, -0.7))
Item = AddModel(Item, "models/Gibs/HGIBS.mdl", Vector(1, 7.5, 0.3), Angle(3.3, 11.4, -3.3))
Item = AddModel(Item, "models/Gibs/HGIBS.mdl", Vector(2.8, 5.7, -5.2), Angle(3.3, 22.1, 2))
Item = AddModel(Item, "models/Gibs/HGIBS.mdl", Vector(1, 1, -5.2), Angle(3.3, -14.1, 3.3))
Item = AddModel(Item, "models/Gibs/manhack_gib05.mdl", Vector(12.2, -6.6, -3.5), Angle(139.9, -15.4, 87.7))
Item = AddModel(Item, "models/Gibs/manhack_gib05.mdl", Vector(11.5, -4.1, -2.8), Angle(149.2, 12.7, 87.7))
Item = AddModel(Item, "models/Gibs/manhack_gib05.mdl", Vector(14.2, -1.7, -4.3), Angle(134.5, 3.3, 87.7))
Item = AddStats(Item, "slot_chest", 62)
Item = AddBuff(Item, "stat_strength", 23)
Item.Level = 32
Item.Weight = 7
Item.SellPrice = 24156
Register.Item(Item)

 local Item = QuickCreateItemTable(BaseArmor, "armor_chest_bio", "Chest Enhancers of the Overseer", "Created from light and durable metal, increases ranged combat", "icons/junk_box1")
Item = AddModel(Item, "models/props_combine/tprotato2_chunk05.mdl", Vector(-3.3, 11.6, 16.4), Angle(19.4, -2, 147.9))--front
Item = AddModel(Item, "models/Gibs/manhack_gib01.mdl", Vector(-3.9, 14, -8), Angle(-138.5, 135.8, 114.4))
Item = AddModel(Item, "models/Gibs/manhack_gib01.mdl", Vector(-2.1, 21.1, 14), Angle(-142.5, 138.5, 34.1))
Item = AddModel(Item, "models/props_combine/tprotato2_chunk05.mdl", Vector(-12.8, 27.7, 24.1), Angle(-47.5, -159.9, -81))--back
Item = AddModel(Item, "models/Gibs/manhack_gib01.mdl", Vector(12.2, 19.3, 6.8), Angle(62.2, 131.8, -70.3))
Item = AddModel(Item, "models/Gibs/manhack_gib01.mdl", Vector(6.8, -5.1, -12.8), Angle(40.8, 145.2, 52.9))
Item = AddStats(Item, "slot_chest", 73)
Item = AddBuff(Item, "stat_dexterity", 35)
Item.Level = 42
Item.Weight = 1
Item.SellPrice = 26112
Register.Item(Item)

 local Item = QuickCreateItemTable(BaseArmor, "armor_chest_tyrant", "Chest Armor of the Tyrant", "Made from the finest materials, for protection.", "icons/junk_box1")
Item = AddModel(Item, "models/props_combine/stalkerpod_lid.mdl", Vector(-4.6, -1.9, 1), Angle(50.2, 0.7, 7.4))--front
Item = AddModel(Item, "models/props_combine/stalkerpod_lid.mdl", Vector(0.1, 4.3, 0.6), Angle(180, -178.7, 169.3))
Item = AddModel(Item, "models/props_combine/stalkerpod_lid.mdl", Vector(-5.9, -1.9, 7.2), Angle(-82.3, 75.6, 105.1))
Item = AddModel(Item, "models/props_combine/stalkerpod_lid.mdl", Vector(-1.4, -3.5, 0.1), Angle(93, -161.3, 27.4))
Item = AddModel(Item, "models/props_combine/stalkerpod_lid.mdl", Vector(-1.7, 0.3, -0.6), Angle(77, -125.1, 54.2))--back
Item = AddModel(Item, "models/props_combine/stalkerpod_lid.mdl", Vector(-6.8, 2.1, 4.8), Angle(-163.9, -0.7, 7.4))
Item = AddStats(Item, "slot_chest", 97)
Item = AddBuff(Item, "stat_maxhealth", 70)
Item.Level = 45
Item.Weight = 8
Item.SellPrice = 27144
Register.Item(Item)
