local function AddModel(tblAddTable, strModel, vecPostion, angAngle, clrColor, strMaterial, vecScale)
	tblAddTable.Model = tblAddTable.Model or {}
	if type(tblAddTable.Model) ~= "table" then tblAddTable.Model = {} end
	table.insert(tblAddTable.Model, {Model = strModel, Position = vecPostion, Angle = angAngle, Color = clrColor, Material = strMaterial, Scale = vecScale})
	return tblAddTable
end
local function AddStats(tblAddTable, intPower, intAccuracy, intFireRate, intClipSize, intNumOfBullets)
	tblAddTable.Power = intPower
	tblAddTable.Accuracy = intAccuracy
	tblAddTable.FireRate = intFireRate
	tblAddTable.ClipSize = intClipSize
	tblAddTable.NumOfBullets = intNumOfBullets or 1
	return tblAddTable
end
local function AddSound(tblAddTable, strShootSound, strReloadSound)
	tblAddTable.Sound = strShootSound
	tblAddTable.ReloadSound = strReloadSound
	return tblAddTable
end

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_plasma", "Plasma Rifle", "Stolen from another game!!", "icons/weapon_pistol")
Item = AddModel(Item, "models/props_c17/substation_stripebox01a.mdl", Vector(1.95, -1.46, 22.44), Angle(-87.8, 180, -7.68), nil, nil, Vector(0.06, 0.08, 0.31))
Item = AddModel(Item, "models/props_c17/playground_teetertoter_stan.mdl", Vector(11.71, -0.24, -1.95), Angle(90, 0, 0), nil, nil, Vector(0.96, 1.01, 0.5))
Item = AddModel(Item, "models/props_c17/lamp_bell_on.mdl", Vector(-0.24, -0.24, -3.9), Angle(180, -90, 0), nil, nil, Vector(0.43, 0.31, 0.5))
Item = AddModel(Item, "models/Combine_turrets/combine_cannon_stand.mdl", Vector(-0.49, 1.71, 2.93), Angle(0, 0, -90), nil, nil, Vector(0.47, 0.17, 0.18))
Item = AddStats(Item, 9, 0.09, 23, 50) --(7.5)
Item = AddSound(Item, "weapons/physcannon/energy_sing_flyby1.wav", "weapons/crossbow/bolt_load1.wav")
Item.Weight = 1
Item.SellPrice = 15
Item.HoldType = "crossbow"
Item.AmmoType = "ar2"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_tesla", "Tesla Cannon", "Nikola Teslas' Monster", "icons/weapon_pistol")
Item = AddModel(Item, "models/props_c17/substation_stripebox01a.mdl", Vector(4.15, 0.73, 0), Angle(-96.59, 92.2, 91.1), nil, nil, Vector(0.11, 0.11, 0.38))
Item = AddModel(Item, "models/props_c17/substation_circuitbreaker01a.mdl", Vector(-18.54, 0, 9.51), Angle(-83.41, -88.9, 180), nil, "", Vector(0.06, 0.06, 0.06))
Item = AddModel(Item, "models/magnusson_teleporteroff.mdl", Vector(-0.49, 9.27, -14.63), Angle(0, 88.9, 0), nil, "Models/props_pipes/GutterMetal01a.vtf", Vector(0.29, 0.43, 0.26))
Item = AddModel(Item, "models/Items/combine_rifle_ammo01.mdl", Vector(-0.19, 0.62, 2.79), Angle(-180, -84.51, -178.9), nil, nil, Vector(1, 1, 2.38))
Item = AddModel(Item, "models/props_c17/utilityconnecter002.mdl", Vector(-0.49, 4.15, 9.02), Angle(-180, 90, 90), nil, nil, Vector(0.76, 0.85, 1.02))
Item = AddModel(Item, "models/props_c17/utilityconnecter003.mdl", Vector(-2.68, -17.32, 2.93), Angle(0, 180, 90), nil, "Models/props_lab/cornerunit_cloud.vtf", Vector(1, 1.17, 1))
Item = AddModel(Item, "models/props_c17/utilityconnecter006.mdl", Vector(10.65, -1.19, 0.06), Angle(0, 180, 90), nil, "Models/Magnusson_Teleporter/magnusson_teleporter_fxglow1.vtf", Vector(0.9, 0.69, 0.7))
Item = AddStats(Item, 12, 0.03, 4, 50) --(7.5)
Item = AddSound(Item, "ambient/levels/labs/electric_explosion4.wav", "weapons/cguard/charging.wav")
Item.Weight = 15
Item.SellPrice = 26378
Item.HoldType = "rpg"
Item.AmmoType = "ar2"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_chaingun", "Chaingun", "Cry some more!", "icons/weapon_pistol")  --Change icon
Item = AddModel(Item, "models/props_c17/TrapPropeller_Lever.mdl", Vector(0.98, -2.2, -1.22), Angle(-180, 90, -90), nil, "", Vector(1, 1, 1)) --Handle one
Item = AddModel(Item, "models/props_c17/signpole001.mdl", Vector(0, 0, 0), Angle(180, 0, 0), nil, nil, Vector(0.63, 0.63, 0.4))
Item = AddModel(Item, "models/props_c17/signpole001.mdl", Vector(-1.95, -1.95, 0), Angle(180, 0, 0), nil, nil, Vector(0.63, 0.63, 0.4))
Item = AddModel(Item, "models/props_c17/signpole001.mdl", Vector(-1.95, -4.63, 0), Angle(180, 0, 0), nil, nil, Vector(0.63, 0.63, 0.4))
Item = AddModel(Item, "models/props_c17/signpole001.mdl", Vector(0, -6.34, 0), Angle(180, 0, 0), nil, nil, Vector(0.63, 0.63, 0.4))
Item = AddModel(Item, "models/props_c17/signpole001.mdl", Vector(1.95, -1.95, 0), Angle(180, 0, 0), nil, nil, Vector(0.63, 0.63, 0.4))
Item = AddModel(Item, "models/props_c17/signpole001.mdl", Vector(1.95, -4.63, 0), Angle(180, 0, 0), nil, nil, Vector(0.63, 0.63, 0.4))
Item = AddModel(Item, "models/props_c17/streetsign004e.mdl", Vector(0, 40, -3.66), Angle(0, 0, -90), nil, "Models/props_c17/Metalladder001.vtf", Vector(0.41, 2.79, 0.41))
Item = AddModel(Item, "models/props_c17/streetsign004e.mdl", Vector(0, 33.9, -3.66), Angle(0, 0, -90), nil, "Models/props_c17/Metalladder001.vtf", Vector(0.41, 2.79, 0.41))
Item = AddModel(Item, "models/props_c17/streetsign004e.mdl", Vector(0, 26.83, -3.66), Angle(0, 0, -90), nil, "Models/props_c17/Metalladder001.vtf", Vector(0.41, 2.79, 0.41))
Item = AddModel(Item, "models/props_c17/streetsign004e.mdl", Vector(0, 19.76, -3.66), Angle(0, 0, -90), nil, "Models/props_c17/Metalladder001.vtf", Vector(0.41, 5, 0.41))
Item = AddModel(Item, "models/props_c17/playground_teetertoter_stan.mdl", Vector(9.51, 0, -2.2), Angle(90, 90, 0), nil, "Models/Combine_Turrets/combine_cannon.vtf", Vector(0.43, 1, 0.43)) --Handle two
Item = AddModel(Item, "models/Gibs/metal_gib4.mdl", Vector(-1.95, 1.95, 0), Angle(-90, 0, 0), nil, nil, Vector(1, 1, 1))
Item = AddModel(Item, "models/Gibs/metal_gib2.mdl", Vector(0, -10.73, 0), Angle(0, 0, 90), nil, nil, Vector(1, 1, 1))
Item = AddModel(Item, "models/Gibs/metal_gib2.mdl", Vector(-15.85, 0, 0), Angle(-90, 0, 90), nil, nil, Vector(1, 0.58, 1))
Item = AddModel(Item, "models/props_lab/miniteleportarc.mdl", Vector(-2.2, 0, -3.9), Angle(-180, -90, 0), nil, nil, Vector(0.43, 0.43, 1.36))
Item = AddModel(Item, "models/weapons/w_eq_flashbang.mdl", Vector(12.44, 3.17, 1.22), Angle(90, -38.41, -180), nil, "", Vector(1, 1, 1))
Item = AddModel(Item, "models/props_junk/metal_paintcan001a.mdl", Vector(0, -3.66, -6.59), Angle(0, 0, 0), nil, "Models/props_lab/door_klab01.vtf", Vector(1, 1, 1.37))
Item = AddModel(Item, "models/props_lab/box01b.mdl", Vector(6.59, 6.83, 6.59), Angle(0, -90, -90), nil, "Models/props_lab/door_klab01.vtf", Vector(1, 1, 1))
Item = AddModel(Item, "models/props_junk/PopCan01a.mdl", Vector(4.15, -2.2, -10.24), Angle(0, 0, 0), nil, "Models/props_lab/door_klab01.vtf", Vector(1.16, 1.45, 1.4))
Item = AddStats(Item, 11, 0.13, 24.3, 200) --Edit Stats
Item = AddSound(Item, "weapons/smg1/smg1_fire1.wav", "weapons/smg1/smg1_reload.wav")
Item.Weight = 1 --Edit Weight
Item.SellPrice = 15
Item.HoldType = "shotgun"
Item.AmmoType = "smg1"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_junkpistol", "Junky Pistol", "Looks like its all rusted.", "icons/weapon_pistol")
Item = AddModel(Item, "models/Weapons/W_pistol.mdl", Vector(-3, 0, 3.5), Angle(0, 180, 0))
Item = AddModel(Item, "models/props_junk/garbage_metalcan001a.mdl", Vector(0, 0, -7.2), Angle(90, 0, 0))
Item = AddStats(Item, 5.5, 0.01, 1.5, 9) --(7.5)
Item = AddSound(Item, "weapons/pistol/pistol_fire2.wav", "weapons/pistol/pistol_reload1.wav")
Item.Weight = 1
Item.SellPrice = 15
Item.HoldType = "pistol"
Item.AmmoType = "smg1"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_junksmg", "Junky SMG", "Made from old parts and crap like that.", "icons/weapon_pistol")
Item = AddModel(Item, "models/Weapons/w_smg1.mdl", Vector(7.5, -1.7, 3.2), Angle(-12.7, -0.7, -0.7))
Item = AddModel(Item, "models/props_junk/garbage_plasticbottle002a.mdl", Vector(1.2, 0.3, 0.3), Angle(0.7, 91.7, -87.7), nil, "Models/props_c17/FurnitureMetal002a.vtf")
Item = AddModel(Item, "models/props_junk/garbage_metalcan001a.mdl", Vector(1.4, -1, -7), Angle(180, -90.3, 90.3))
Item = AddModel(Item, "models/props_junk/GlassBottle01a.mdl", Vector(1, 2.1, -4.1), Angle(180, -90.3, -90.3))
Item = AddStats(Item, 3.7, 0.04, 7, 35) --(25.9)
Item = AddSound(Item, "weapons/smg1/smg1_fire1.wav", "weapons/smg1/smg1_reload.wav")
Item.Weight = 2
Item.Level = 3
Item.SellPrice = 200
Item.HoldType = "smg"
Item.AmmoType = "smg1"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_junkrifle", "Junky Rifle", "Crafted with the junkiest materials around.", "icons/weapon_sniper1")
Item = AddModel(Item, "models/Weapons/w_annabelle.mdl", Vector(-12.4, 1.9, 1.4), Angle(10, -176, -7.4))
Item = AddModel(Item, "models/healthvial.mdl", Vector(-1.4, 1, -7.9), Angle(83.6, -2, 180))
Item = AddModel(Item, "models/Items/battery.mdl", Vector(-0.1, -0.8, -2.8), Angle(95.7, 178.7, -178.7))
Item = AddModel(Item, "models/props_c17/utilityconnecter006.mdl", Vector(1.2, -11.3, 1), Angle(-0.7, -93, 6))
Item = AddStats(Item, 22, 0.02, 2, 25) --(35)
Item = AddSound(Item, "weapons/ar1/ar1_dist2.wav", "weapons/crossbow/reload1.wav")
Item.Weight = 2
Item.Level = 5
Item.SellPrice = 450
Item.HoldType = "smg"
Item.AmmoType = "ar2"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_heavymacgun", "Heavy Mac Gun", "Someone order a heeping pile of bullet?", "icons/weapon_heavymacgun")
Item = AddModel(Item, "models/Airboatgun.mdl", Vector(4.3, 0.6, 4.3), Angle(-2, -2, 0))
Item = AddStats(Item, 8, 0.06, 8, 50) --(42.4)
Item = AddSound(Item, "weapons/ar2/fire1.wav", "weapons/ar2/npc_ar2_reload.wav")
Item.Weight = 3
Item.Level = 10
Item.SellPrice = 480
Item.HoldType = "shotgun"
Item.AmmoType = "smg1"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_drumshotgun", "Junky Shoty", "Has a drumclip for extra ammo.", "icons/weapon_shotgun")
Item = AddModel(Item, "models/Weapons/w_shotgun.mdl", Vector(-14.6, 1.4, -0.6), Angle(15.4, -174.6, -6))
Item = AddModel(Item, "models/props_lab/jar01a.mdl", Vector(-1.4, -0.3, -0.1), Angle(-97, -11.4, 10), nil, "Models/props_c17/FurnitureMetal002a.vtf")
Item = AddModel(Item, "models/props_junk/garbage_metalcan002a.mdl", Vector(-0.6, -0.1, -7.5), Angle(0.7, 87.7, 86.3), nil, "Models/props_c17/FurnitureMetal002a.vtf")
Item = AddStats(Item, 5.8, 0.1, 1.5, 12, 8) --(55.2)
Item = AddSound(Item, "weapons/shotgun/shotgun_fire7.wav", "weapons/shotgun/shotgun_cock.wav")
Item.QuestNeeded = "quest_arsenalupgrade"
Item.Weight = 3
Item.Level = 13
Item.SellPrice = 560
Item.HoldType = "shotgun"
Item.AmmoType = "buckshot"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_revolver", "Junky Revolver", "Teh big pistol!", "icons/weapon_pistol")
Item = AddModel(Item, "models/weapons/W_357.mdl", Vector(-2.3, -0.8, 1.9), Angle(-2, -2, 0))
Item = AddModel(Item, "models/items/grenadeAmmo.mdl", Vector(-0.3, 1.2, -6.4), Angle(0, -90, 90))
Item = AddStats(Item, 88.5, 0.03, 0.7, 6) --(56.35)
Item = AddSound(Item, "weapons/357_fire2.wav", "weapons/357/357_spin1.wav")
Item.Weight = 3
Item.Level = 15
Item.SellPrice = 920
Item.HoldType = "pistol"
Item.AmmoType = "smg1"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_wornasr", "Worn Assaultrifle", "This weapon has seen quite a few battles", "icons/weapon_sniper1")
Item = AddModel(Item, "models/props_canal/mattpipe.mdl", Vector(-3, 0.8, 11.9), Angle(72.9, 0, 0.7))
Item = AddModel(Item, "models/props_c17/TrapPropeller_Lever.mdl", Vector(0, -7.5, -2.1), Angle(0, 90, -102.4), nil, "Models/props_c17/FurnitureMetal002a.vtf")
Item = AddModel(Item, "models/Items/combine_rifle_cartridge01.mdl", Vector(8.8, 0.3, 8.6), Angle(27.4, 0, 180), nil, "Models/props_c17/FurnitureMetal002a.vtf")
Item = AddModel(Item, "models/Items/combine_rifle_cartridge01.mdl", Vector(1.7, -0.3, -2.1), Angle(-47.5, 0, 0), nil, "Models/props_c17/FurnitureMetal002a.vtf")
Item = AddStats(Item, 11, 0.05, 7, 35)
Item = AddSound(Item, "weapons/ar1/ar1_dist2.wav", "weapons/crossbow/reload1.wav")
Item.Weight = 4
Item.Level = 15
Item.SellPrice = 1400
Item.HoldType = "ar2"
Item.AmmoType = "ar2"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_combine_cannon", "Combine Cannon", "Stolen cannon from the combine with extremely high fire rate.", "icons/weapon_heavymacgun")
Item = AddModel(Item, "models/Combine_turrets/combine_cannon_gun.mdl", Vector(12.2, -0.9, -10.4), Angle(-14.1, -2, 0))
Item = AddStats(Item, 8, 0.06, 12, 50)
Item = AddSound(Item, "weapons/ar2/fire1.wav", "weapons/ar2/npc_ar2_reload.wav")
Item.Weight = 5
Item.Level = 15
Item.SellPrice = 4600
Item.HoldType = "shotgun"
Item.AmmoType = "smg1"
Register.Item(Item)


local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_battlerifle", "Battle Rifle", "Used by the Americans in the 2021 WWIII.", "icons/weapon_sniper1")
--Item = AddModel(Item, "models/Items/HealthKit.mdl", Vector(-9, 1.9, -0.3), Angle(10, -176, -7.4))
Item = AddModel(Item, "models/Weapons/W_crossbow.mdl", Vector(-9, 1.7, -4.3), Angle(8.7, 176, 90.3))
Item = AddModel(Item, "models/Items/battery.mdl", Vector(-0.1, -0.8, -2.8), Angle(95.7, 178.7, -178.7))
Item = AddModel(Item, "models/Items/battery.mdl", Vector(-5.7, -0.3, -15.5), Angle(95.7, 178.7, -178.7))
--Item = AddModel(Item, "models/props_c17/utilityconnecter006.mdl", Vector(0.8, -19.7, 1), Angle(-0.7, -93, 6))
Item = AddStats(Item, 22, 0.032, 40, 3) --(66)
Item = AddSound(Item, "weapons/ar1/ar1_dist2.wav")
Item.Weight = 5
Item.Level = 17
Item.SellPrice = 1530
Item.HoldType = "smg"
Item.AmmoType = "ar2"
Register.Item(Item)

local Item = QuickCreateItemTable(BaseWeapon, "weapon_ranged_combinesniper", "Combine Sniper", "Sniper Rifle from the combine.", "icons/weapon_heavymacgun")
Item = AddModel(Item, "models/weapons/w_combine_sniper.mdl", Vector(-17.3, 0.6, 2.6), Angle(-2, 173.3, 2))
Item = AddStats(Item, 150, 0.001, 1, 8) --(75)
Item = AddSound(Item, "weapons/ar2/fire1.wav", "weapons/ar2/npc_ar2_reload.wav")
Item.Weight = 3
Item.Level = 20
Item.SellPrice = 4200
Item.HoldType = "crossbow"
Item.AmmoType = "SniperRound"
function Item:SecondaryCallBack(ply)
	if (not Zoomed) then
		Zoomed = true
		if SERVER then
			ply:SetFOV( 45, 0.3 )
		end
	else
		Zoomed = false
		if SERVER then
			ply:SetFOV( 0, 0.3 )
		end
	end
end
Register.Item(Item)
