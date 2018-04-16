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

--Chef Hat Madness--
local Item = QuickCreateItemTable(BaseArmor, "armor_helm_chefshat", "Chefs Hat", "It means you cool like that", "icons/hat_cheifshat")
Item = AddModel(Item, "models/chefHat.mdl", Vector(4.6, 0.1, 3.7), Angle(-0.7, -180, -0.7), nil, nil, Vector(1, 1, 1))
Item = AddStats(Item, "slot_helm", 1)
Item.Weight = 1
Item.SellPrice = 25
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "red_chefs_hat", "Red Chefs Hat", "A rare item of coolness!", "icons/hat_cheifshat")
Item = AddModel(Item, "models/chefHat.mdl", Vector(4.6, 0.1, 3.7), Angle(-0.7, -180, -0.7),  clrRed)
Item = AddStats(Item, "slot_helm", 1)
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "blue_chefs_hat", "Blue Chefs Hat", "A rare item of coolness!", "icons/hat_cheifshat")
Item = AddModel(Item, "models/chefHat.mdl", Vector(4.6, 0.1, 3.7), Angle(-0.7, -180, -0.7),  clrBlue)
Item = AddStats(Item, "slot_helm", 1)
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "purple_chefs_hat", "Purple Chefs Hat", "A rare item of coolness!", "icons/hat_cheifshat")
Item = AddModel(Item, "models/chefHat.mdl", Vector(4.6, 0.1, 3.7), Angle(-0.7, -180, -0.7),  clrPurple)
Item = AddStats(Item, "slot_helm", 1)
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "orange_chefs_hat", "Orange Chefs Hat", "A rare item of coolness!", "icons/hat_cheifshat")
Item = AddModel(Item, "models/chefHat.mdl", Vector(4.6, 0.1, 3.7), Angle(-0.7, -180, -0.7),  clrOrange)
Item = AddStats(Item, "slot_helm", 1)
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "green_chefs_hat", "Green Chefs Hat", "A rare item of coolness!", "icons/hat_cheifshat")
Item = AddModel(Item, "models/chefHat.mdl", Vector(4.6, 0.1, 3.7), Angle(-0.7, -180, -0.7),  clrGreen)
Item = AddStats(Item, "slot_helm", 1)
Item.Weight = 1
Register.Item(Item)
---------------------

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_junkhelmet", "Junk Helmet", "Theres still soup in it", "icons/junk_pan1")
Item = AddModel(Item, "models/props_interiors/pot02a.mdl", Vector(-0.7, -8.1, -3.5), Angle(180, -100, -20))
Item = AddStats(Item, "slot_helm", 5)
Item.Weight = 1
Item.SellPrice = 130
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_scannergoggles", "Scanner Goggles", "Scan like a scanner", "icons/armor_scannergogles")
Item = AddModel(Item, "models/Gibs/Shield_Scanner_Gib1.mdl", Vector(-0.3, -0.3, 0.1), Angle(121.1, -83.6, -95.7))
Item = AddStats(Item, "slot_helm", 2)
Item = AddBuff(Item, "stat_strength", 2)
Item.Level = 5
Item.Weight = 1
Item.SellPrice = 295
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_gasmask", "Gas-Mask", "Protects your respiratory system from toxic substances.", "icons/hat_cheifshat")
Item = AddModel(Item, "models/BarneyHelmet_faceplate.mdl", Vector(-1.7, 0.1, -0.1), Angle(-0.7, 2, -0.7))
Item = AddStats(Item, "slot_helm", 1)
Item = AddBuff(Item, "stat_agility", 3)
Item.Level = 5
Item.Weight = 1
Item.SellPrice = 293
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_bones", "Skull Mask", "How Ghastly!", "icons/hat_cheifshat")
Item = AddModel(Item, "models/Gibs/HGIBS.mdl", Vector(-1.2, 0.1, -0.3), Angle(14.1, 2, -0.7))
Item = AddStats(Item, "slot_helm", 5)
Item = AddBuff(Item, "stat_strength", 3)
Item.Level = 10
Item.Weight = 1
Item.SellPrice = 455
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_headcrab", "Headcrab", "Headcrab, Apply directly to the forhead.", "icons/hat_cheifshat")
Item = AddModel(Item, "models/headcrabclassic.mdl", Vector(1.7, 0.1, -6.1), Angle(-10, 0, 0))
Item = AddStats(Item, "slot_helm", 12)
Item.Level = 15
Item.Weight = 2
Item.SellPrice = 1200
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_cyborg", "Biomechanical Eye", "I see london, I see ...", "icons/hat_cheifshat")
Item = AddModel(Item, "models/Gibs/manhack_gib03.mdl", Vector(-1.2, 1.9, -0.6), Angle(0.7, 2, -0.7))
Item = AddModel(Item, "models/Gibs/manhack_gib02.mdl", Vector(2.1, -0.6, 2.8), Angle(-0.7, -180, -0.7))
Item = AddStats(Item, "slot_helm", 22)
Item = AddBuff(Item, "stat_dexterity", 8)
Item.Level = 21
Item.Weight = 1
Item.SellPrice = 6245
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_antlionhelm", "Antlion Shell Helm", "Smells a little funky, but it gets the job done!", "icons/hat_cheifshat")
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(3.2, -0.1, -0.3), Angle(85, 0.7, 4.7))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(-5, 0.1, 3.7), Angle(-44.8, 0.7, -3.3))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(-1.2, 0.3, 3.5), Angle(-4.7, 3.3, 178.7))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_1.mdl", Vector(8.4, -1.4, 1.4), Angle(48.8, 173.3, 12.7))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_1.mdl", Vector(1.7, 2.3, -0.3), Angle(-93, 180, 7.4))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_1.mdl", Vector(8.1, 0.8, 2.6), Angle(55.5, -139.9, 22.1))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_1.mdl", Vector(2.6, -2.1, -0.1), Angle(-91.7, 180, 7.4))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_1.mdl", Vector(2.6, -3.2, 1.4), Angle(-42.2, 109.1, 143.9))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_1.mdl", Vector(3.7, 3.9, 2.1), Angle(-40.8, -107.7, -142.5))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(-1.9, 0.3, 7.5), Angle(-106.4, -0.7, 7.4))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(4.8, -0.6, 5.5), Angle(-180, 0.7, -3.3))
Item = AddStats(Item, "slot_helm", 30)
Item = AddBuff(Item, "stat_maxhealth", 8)
Item.Level = 23
Item.Weight = 1
Item.SellPrice = 7350
Item.Set = "armor_antlion"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_skele", "Bone Helm", "Smells rotten...", "icons/hat_cheifshat")
Item = AddModel(Item, "models/Gibs/HGIBS.mdl", Vector(-1.2, 0.1, -0.3), Angle(14.1, 2, -0.7))
Item = AddModel(Item, "models/Items/battery.mdl", Vector(1.7, 1, -9), Angle(30.1, 170.6, -3.3))
Item = AddModel(Item, "models/Items/battery.mdl", Vector(1.7, -0.8, -9), Angle(31.4, -163.9, -0.7))
Item = AddModel(Item, "models/Gibs/Shield_Scanner_Gib4.mdl", Vector(-0.3, -0.6, -2.6), Angle(180, -16.7, -0.7))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(3.9, 0.1, 1.4), Angle(74.3, 4.7, 10))--front
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(-1.2, 0.1, 1.9), Angle(23.4, -2, 4.7))
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(2.3, 0.1, 3.5), Angle(90.3, -173.3, 10))--back
Item = AddModel(Item, "models/Gibs/Antlion_gib_small_2.mdl", Vector(1.4, 0.6, 3.9), Angle(52.9, 170.6, 0.7))
Item = AddStats(Item, "slot_helm", 33)
Item = AddBuff(Item, "stat_strength", 16)
Item.Level = 33
Item.Weight = 1
Item.SellPrice = 12030
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_bio", "Cyber Optics of the Overseer", "Created from light and durable metal, increases ranged combat", "icons/hat_cheifshat")
Item = AddModel(Item, "models/manhack.mdl", Vector(3.3, -0.3, -2.7), Angle(-62.2, -180, -4.7))
Item = AddModel(Item, "models/manhack.mdl", Vector(2.7, 2.1, 0.9), Angle(161.3, -91.7, 161.3))
Item = AddModel(Item, "models/manhack.mdl", Vector(1.5, -2.1, 0.3), Angle(30.1, -83.6, 19.4))
Item = AddModel(Item, "models/Gibs/manhack_gib01.mdl",Vector(2.7, 0.3, 3.9), Angle(38.1, -180, 2))
Item = AddModel(Item, "models/Gibs/manhack_gib01.mdl", Vector(6.8, 0.3, 4.5), Angle(32.8, -180, -0.7))
Item = AddModel(Item, "models/Gibs/manhack_gib01.mdl", Vector(7.4, 2.1, 2.1), Angle(16.7, -180, 90.3))
Item = AddStats(Item, "slot_helm", 50)
Item = AddBuff(Item, "stat_dexterity", 31)
Item.Level = 39
Item.Weight = 1
Item.SellPrice = 17120
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_tyrant", "Platehelm of the Tyrant", "Ribcage of the Wraith", "Made from those who are dead, forged for reaping.", "icons/hat_cheifshat")
Item = AddModel(Item, "models/props_combine/stalkerpod_lid.mdl", Vector(-1.4, 0.3, -2.8), Angle(78.3, -0.7, 0.7))
Item = AddModel(Item, "models/props_combine/stalkerpod_lid.mdl", Vector(-7.2, 0.1, 2.3), Angle(177.3, -0.7, 0))
Item = AddModel(Item, "models/BarneyHelmet_faceplate.mdl",Vector(0.1, 0.1, 0.1), Angle(-32.8, 2, -0.7), nil, "debug/env_cubemap_model.vtf")
Item = AddStats(Item, "slot_helm", 52)
Item = AddBuff(Item, "stat_maxhealth", 35)
Item.Level = 40
Item.Weight = 2
Item.SellPrice = 17050
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_pot", "Pothead", "Get a life", "icons/hat_cheifshat")
Item = AddModel(Item, "models/props_c17/pottery02a.mdl", Vector(-1.71, 0.24, -11.46), Angle(180, 180, -1.1), nil, "", Vector(1.43, 1.4, 1.4))
Item = AddStats(Item, "slot_helm", 20)
Item = AddBuff(Item, "stat_maxhealth", 35)
Item = AddBuff(Item, "stat_strength", 10)
Item.Level = 1
Item.Weight = 1
Item.SellPrice = 200
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_helm_snowman", "Snowman hat", "Just in time for christmas!", "icons/hat_cheifshat")
Item = AddModel(Item, "models/props_c17/pottery02a.mdl", Vector(-3.41, 0.24, -6.1), Angle(180, 180, -1.1), nil, "Models/props_junk/rock_junk001a.vtf", Vector(0.87, 1.4, 1.4))
Item = AddModel(Item, "models/props_interiors/pot02a.mdl", Vector(2.44, -3.66, -3.5), Angle(180, 70.24, 19.76), nil, "Models/props_silo/de_train_handrails_01.vtf", Vector(0.82, 0.37, 0.75))
Item = AddModel(Item, "models/props_interiors/pot02a.mdl", Vector(-1.71, -3.41, -6.83), Angle(180, 100.98, -17.56), nil, "Models/props_silo/de_train_handrails_01.vtf", Vector(0.82, 0.09, 0.5))
Item = AddModel(Item, "models/props_interiors/pot02a.mdl", Vector(-2.2, -3.41, -10.24), Angle(180, 90, 2.2), nil, "Models/props_silo/de_train_handrails_01.vtf", Vector(0.7, 0.32, 1))
Item = AddModel(Item, "models/props_interiors/pot02a.mdl", Vector(1.22, -1.46, 8.78), Angle(180, -92.2, -169.02), nil, "Models/props_silo/de_train_handrails_01.vtf", Vector(1, 0.3, 1))
Item = AddModel(Item, "models/props_interiors/pot02a.mdl", Vector(0, -3.66, -11.71), Angle(2.2, -94.39, -180), nil, "Models/props_silo/de_train_handrails_01.vtf", Vector(1.17, 0.29, 1))
Item = AddModel(Item, "models/props_interiors/pot02a.mdl", Vector(-2.2, -2.44, 8.78), Angle(2.2, 83.41, 12.07), nil, "Models/props_silo/de_train_handrails_01.vtf", Vector(1, 0.17, 1))
Item = AddModel(Item, "models/props_interiors/pot02a.mdl", Vector(2.93, -4.63, -10.49), Angle(2.2, -95.49, -180), nil, "Models/props_silo/de_train_handrails_01.vtf", Vector(0.73, 0.23, 1))
Item = AddStats(Item, "slot_helm", 20)
Item = AddBuff(Item, "stat_maxhealth", 35)
Item = AddBuff(Item, "stat_strength", 10)
Item.Level = 3
Item.Weight = 1
Item.SellPrice = 200
Register.Item(Item)
