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

local Item = QuickCreateItemTable(BaseArmor, "armor_sheild_cog", "Cog Sheild", "Protects", "icons/junk_cog")
Item = AddModel(Item, "models/props_mining/elevator_winch_cog.mdl", Vector(0, 5.7, 5), Angle(-83.6, -7.4, 0))
Item = AddStats(Item, "slot_offhand", 20)
Item.Weight = 1
Item.SellPrice = 505
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_sheild_saw", "Saw Sheild", "Protects", "icons/junk_sawblade")
Item = AddModel(Item, "models/props_junk/sawblade001a.mdl", Vector(0.3, 1, -2.1), Angle(-89, 68.9, 4.7))
Item = AddStats(Item, "slot_offhand", 20)
Item.Weight = 1
Item.SellPrice = 505
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_shield_antlionshell", "Antlion-Shell Shield", "Protects", "icons/junk_antlionwing")
Item = AddModel(Item, "models/Gibs/Antlion_gib_Large_1.mdl", Vector(-6.1, -6.8, 12.6), Angle(64.9, 40.8, -135.8))
Item = AddStats(Item, "slot_offhand", 23)
Item.Level = 5
Item.Weight = 1
Item.SellPrice = 631
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_shield_metacarbon", "Heavy Meta-Carbon Shield", "Protects", "icons/armor_carbonsheild")
Item = AddModel(Item, "models/Gibs/gunship_gibs_eye.mdl", Vector(-5.9, 4.8, 7.5), Angle(-40.8, -2, -6))
Item = AddStats(Item, "slot_offhand", 33)
Item.Level = 9
Item.Weight = 3
Item.SellPrice = 883
Register.Item(Item)


local Item = QuickCreateItemTable(BaseArmor, "armor_shield_heavycomposite", "Heavy Composite Shield", "Protects", "icons/junk_metalcan2")
Item = AddModel(Item, "models/Gibs/Strider_Gib6.mdl", Vector(-26.9, -11.7, -15.3), Angle(-143.9, -89, -8.7))
Item = AddStats(Item, "slot_offhand", 40)
Item.Weight = 3
Item.SellPrice = 1010
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_shield_imprvsaw", "The Mutilator", "Offensive Shield", "icons/junk_sawblade")
Item = AddModel(Item, "models/props_junk/sawblade001a.mdl", Vector(1.2, 8.4, 3), Angle(101, -55.5, -135.8))
Item = AddModel(Item, "models/props_junk/sawblade001a.mdl", Vector(-0.6, 0.1, 0.3), Angle(180, -27.4, -178.7))
Item = AddModel(Item, "models/props_borealis/door_wheel001a.mdl", Vector(0.8, 0.6, -0.1), Angle(-87.7, 40.8, -135.8))
Item = AddStats(Item, "slot_offhand", 35)
Item = AddBuff(Item, "stat_strength", 5)
Item.Level = 12
Item.Weight = 1
Item.SellPrice = 2600
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_shield_antlionshell2", "Antlion TriShell Shield", "The fusion of three hard exoskelotens of antlions", "icons/junk_antlionwing")
Item = AddModel(Item, "models/Gibs/Antlion_gib_Large_1.mdl", Vector(-4.1, -4.1, 13), Angle(35.5, 54.2, -127.8))
Item = AddModel(Item, "models/Gibs/Antlion_gib_Large_1.mdl", Vector(-0.8, -5.2, -0.6), Angle(-177.3, -178.7, -168))
Item = AddModel(Item, "models/Gibs/Antlion_gib_Large_1.mdl", Vector(-2.8, -10.4, -0.8), Angle(-176, -178.7, -147.9))
Item = AddStats(Item, "slot_offhand", 56)
Item = AddBuff(Item, "stat_maxhealth", 12)
Item.Level = 25
Item.Weight = 2
Item.SellPrice = 6310
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_shield_skele", "The Soul Drinker", "Ba'jak the Soul Drinker.", "icons/junk_sawblade")
Item = AddModel(Item, "models/Gibs/HGIBS.mdl", Vector(0.1, -0.1, 4.1), Angle(-6, 6, -90.3))--skull
Item = AddModel(Item, "models/Gibs/HGIBS_spine.mdl", Vector(-0.3, 5, -10.1), Angle(-7.4, -83.6, -123.8))--spine
Item = AddModel(Item, "models/Gibs/manhack_gib05.mdl", Vector(5.7, -14.6, 3.5), Angle(-83.6, -0.7, -72.9))--scorp spike
Item = AddModel(Item, "models/Gibs/manhack_gib05.mdl", Vector(3.9, 0.6, 1.7), Angle(4.7, 2, -90.3))--blade
Item = AddModel(Item, "models/Gibs/manhack_gib05.mdl", Vector(3.9, 0.6, -1.9), Angle(4.7, 2, -90.3))
Item = AddStats(Item, "slot_offhand", 5)
Item = AddBuff(Item, "stat_strength", 30)
Item.Level = 31
Item.Weight = 1
Item.SellPrice = 24053
Register.Item(Item)

local Item = QuickCreateItemTable(BaseArmor, "armor_shield_tyrant", "Shield of the Tyrant", "Forged from an unmoveable object.", "icons/junk_cog")
Item = AddModel(Item, "models/combine_apc_destroyed_gib04.mdl", Vector(12.2, -71.1, -65.1), Angle(166.6, 75.6, 34.1))
Item = AddStats(Item, "slot_offhand", 113)
Item = AddBuff(Item, "stat_maxhealth", 45)
Item.Level = 40
Item.Weight = 3
Item.SellPrice = 26020
Register.Item(Item)
