local function QuickNPC(strName, strPrintName, strSpawnName, strRace, intDistance, strModel)
	local NPC = {}
	NPC.Name = strName
	NPC.PrintName = strPrintName
	NPC.SpawnName = strSpawnName
	NPC.Race = strRace
	NPC.DistanceRetreat = intDistance
	NPC.Model = strModel
	return NPC
end
local function AddBool(Table, strFrozen, strInvincible, strIdle)
		Table.Frozen = strFrozen
		Table.Invincible = strInvincible
		Table.Idle = strIdle
	return Table
end
local function AddMultiplier(Table, strHealth, strDamage)
	Table.HealthPerLevel = strHealth
	Table.DamagePerLevel = strDamage
	return Table
end
local function AddDrop(Table, strName, intChance, intMin, intMax, intMinLevel)
	Table.Drops = Table.Drops or {}
	Table.Drops[strName] = {Chance = intChance, Min = intMin, Max = intMax, MinLevel = intMinLevel}
	return Table
end

local NPC = QuickNPC("zombie", "Zombie", "npc_zombie", "zombie", 1000)
AddDrop(NPC, "money", 50, 15, 18)
AddDrop(NPC, "item_bananna", 15)
AddDrop(NPC, "item_canmeat", 20)
AddDrop(NPC, "item_smallammo_small", 17)
AddDrop(NPC, "item_rifleammo_small", 17)
AddDrop(NPC, "item_buckshotammo_small", 15)
AddDrop(NPC, "armor_helm_headcrab", 0.05, nil, nil, 5)
AddDrop(NPC, "quest_zombieblood", 75)
AddMultiplier(NPC, 10, 2)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("headcrab", "Headcrab", "npc_headcrab", "headcrab", 1000)
AddDrop(NPC, "money", 50, 15, 18)
AddDrop(NPC, "item_bananna", 15)
AddDrop(NPC, "item_canmeat", 20)
AddDrop(NPC, "item_smallammo_small", 17)
AddDrop(NPC, "item_rifleammo_small", 17)
AddDrop(NPC, "item_buckshotammo_small", 15)
AddDrop(NPC, "armor_helm_headcrab", 0.2, nil, nil, 5)
AddMultiplier(NPC, 10, 2)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("fire_zombie", "Fire Zombie", "npc_zombie", "zombie", 1000)
AddDrop(NPC, "money", 50, 15, 18)
AddDrop(NPC, "item_bananna", 15)
AddDrop(NPC, "item_canmeat", 40)
AddDrop(NPC, "item_smallammo_small", 17)
AddDrop(NPC, "item_rifleammo_small", 17)
AddDrop(NPC, "item_buckshotammo_small", 15)
AddDrop(NPC, "armor_helm_headcrab", 0.2, nil, nil, 5)
AddDrop(NPC, "quest_zombieblood", 75)
AddMultiplier(NPC, 11, 3)
NPC.DeathDistance = 14
NPC.Resistance = "Fire"
NPC.Color = {200,0,0,255}
function NPC:DamageCallBack(npc, victim)
	local intChance = 8
	local intTime = 7
	if  math.random(1, 100 / intChance) == 1 then
		victim:IgniteFor(intTime, 1, victim)
	end
end
Register.NPC(NPC)

local NPC = QuickNPC("ice_zombie", "Ice Zombie", "npc_zombie", "zombie", 1000)
AddDrop(NPC, "money", 50, 15, 18)
AddDrop(NPC, "item_bananna", 15)
AddDrop(NPC, "item_canmeat", 40)
AddDrop(NPC, "item_smallammo_small", 17)
AddDrop(NPC, "item_rifleammo_small", 17)
AddDrop(NPC, "item_buckshotammo_small", 15)
AddDrop(NPC, "armor_helm_headcrab", 0.2, nil, nil, 5)
AddDrop(NPC, "quest_zombieblood", 75)
AddDrop(NPC, "armor_helm_snowman", 2)
AddDrop(NPC, "quest_moneystack", 10)
AddMultiplier(NPC, 11, 3)
NPC.DeathDistance = 14
NPC.Resistance = "Ice"
NPC.Color = {0,0,200,255}
function NPC:DamageCallBack(npc, victim)
	intChance = 8
	if  math.random(1, 100 / intChance) == 1 then
		victim:SlowDown(7)
	end
end
Register.NPC(NPC)


local NPC = QuickNPC("fastzombie", "Fast Zombie", "npc_fastzombie", "zombie", 1000)
AddDrop(NPC, "money", 100, 20, 25)
AddDrop(NPC, "item_bananna", 5)
AddDrop(NPC, "item_canspoilingmeat", 10)
AddDrop(NPC, "item_smallammo_small", 17)
AddDrop(NPC, "item_rifleammo_small", 17)
AddDrop(NPC, "item_buckshotammo_small", 15)
AddDrop(NPC, "armor_helm_bones", 2, nil, nil, 5)
AddDrop(NPC, "armor_shield_imprvsaw", 2, nil, nil, 12)
AddDrop(NPC, "quest_zombieblood", 75)
AddDrop(NPC, "item_cardboard", 40)
AddDrop(NPC, "item_bagofnoodles", 15)
AddDrop(NPC, "book_cooknoodles", 5)
AddDrop(NPC, "armor_helm_pot", 2)
AddMultiplier(NPC, 8, 4)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("zombine", "Zombie Boss", "npc_zombine", "zombie", 500)
AddDrop(NPC, "money", 200, 20, 25)
AddDrop(NPC, "armor_helm_bones", 5, nil, nil, 5)
AddDrop(NPC, "weapon_melee_exhaust", 1, nil, nil, 20)
AddDrop(NPC, "armor_shoulder_skele", 0.4, nil, nil, 30)
AddDrop(NPC, "armor_helm_skele", 0.4, nil, nil, 33)
AddDrop(NPC, "armor_shield_skele", 0.4, nil, nil, 31)
AddDrop(NPC, "armor_belt_skele", 0.4, nil, nil, 32)
AddDrop(NPC, "weapon_melee_skele", 0.01, nil, nil, 50)
AddDrop(NPC, "item_cardboard", 50)
AddDrop(NPC, "item_bagofnoodles", 25)
AddDrop(NPC, "book_cooknoodles", 10)
AddDrop(NPC, "armor_helm_pot", 5)
AddMultiplier(NPC, 25, 4)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("vortigaunt", "Vortigaunt", "npc_vortigaunt", "vortigaunt", 500)
NPC = AddDrop(NPC, "money", 30, 1, 500)
NPC = AddDrop(NPC, "weapon_melee_skele", 2, nil, nil, 50)
NPC = AddDrop(NPC, "armor_shoulder_bio", 1, nil, nil, 42)
NPC = AddDrop(NPC, "armor_shield_tyrant", 1.5, nil, nil, 40)
NPC = AddMultiplier(NPC, 50, 20)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("antlion", "Antlion", "npc_antlion", "antlion", 1500)
NPC = AddDrop(NPC, "money", 50, 10, 20)
NPC = AddDrop(NPC, "item_orange", 10)
NPC = AddDrop(NPC, "weapon_ranged_junksmg", 1)
NPC = AddDrop(NPC, "weapon_melee_fryingpan", 1)
NPC = AddDrop(NPC, "armor_shield_antlionshell", 1, nil, nil, 7)
NPC = AddDrop(NPC, "armor_shield_antlionshell2", 0.5, nil, nil, 25)
NPC = AddDrop(NPC, "weapon_melee_antlionclaw", 1)
NPC = AddDrop(NPC, "quest_detergent", 20)
NPC = AddMultiplier(NPC, 10, 2)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("antlionworker", "Antlion Worker", "npc_antlion_worker", "antlion", 1500)
NPC = AddDrop(NPC, "money", 50, 10, 20)
NPC = AddDrop(NPC, "item_orange", 10)
NPC = AddDrop(NPC, "armor_shield_antlionshell", 1, nil, nil, 7)
NPC = AddDrop(NPC, "weapon_melee_mtree", 3)
NPC = AddDrop(NPC, "quest_detergent", 20)
NPC = AddMultiplier(NPC, 9, .4)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("antlionguard", "Antlion Boss", "npc_antlionguard", "antlion", 700)
NPC = AddDrop(NPC, "money", 100, 50, 100)
NPC = AddDrop(NPC, "weapon_melee_leadpipe", 2)
NPC = AddDrop(NPC, "armor_shield_metacarbon", 5, nil, nil, 10)
NPC = AddDrop(NPC, "armor_shoulder_antlion", 1, nil, nil, 20)
NPC = AddDrop(NPC, "armor_helm_antlionhelm", 1, nil, nil, 20)
NPC = AddDrop(NPC, "armor_belt_antlion", 1, nil, nil, 25)
NPC = AddDrop(NPC, "armor_chest_antlion", 1, nil, nil, 20)
NPC = AddDrop(NPC, "armor_chest_skele", 0.5, nil, nil, 30)
NPC = AddDrop(NPC, "armor_helm_skele", 0.5, nil, nil, 30)
NPC = AddMultiplier(NPC, 25, 4)
NPC.DeathDistance = 40
Register.NPC(NPC)

local NPC = QuickNPC("combine_smg", "Combine Guard", "npc_combine_s", "combine", 300, "models/Combine_Soldier.mdl")
NPC = AddDrop(NPC, "money", 50, 30, 43)
NPC = AddDrop(NPC, "item_smallammo_small", 20)
NPC = AddDrop(NPC, "item_rifleammo_small", 10)
NPC = AddDrop(NPC, "item_sniperammo_small", 5)
NPC = AddDrop(NPC, "weapon_ranged_junksmg", 1)
NPC = AddDrop(NPC, "weapon_ranged_junkrifle", 1)
NPC = AddDrop(NPC, "weapon_melee_wrench", 3)
NPC = AddDrop(NPC, "armor_helm_gasmask", 2, nil, nil, 5)
NPC = AddDrop(NPC, "armor_shoulder_combine", 1.5, nil, nil, 10)
NPC = AddDrop(NPC, "weapon_melee_emptool", 1, nil, nil, 10)
NPC = AddDrop(NPC, "weapon_ranged_combinesniper", 0.4, nil, nil, 10)
NPC = AddDrop(NPC, "armor_belt_cyborg", 1, nil, nil, 20)
NPC = AddMultiplier(NPC, 20, 2)
NPC.Weapon = "weapon_smg1"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("combine_Elite", "Combine Elite", "npc_combine_s", "combine", 300, "models/combine_super_soldier.mdl")
NPC = AddDrop(NPC, "money", 100, 30, 43)
NPC = AddDrop(NPC, "item_smallammo_small", 30)
NPC = AddDrop(NPC, "item_rifleammo_small", 40)
NPC = AddDrop(NPC, "weapon_ranged_junksmg", 4)
NPC = AddDrop(NPC, "weapon_ranged_junkrifle", 4)
NPC = AddDrop(NPC, "weapon_melee_wrench", 1)
NPC = AddDrop(NPC, "armor_helm_cyborg", 0.3, nil, nil, 15)
NPC = AddDrop(NPC, "armor_chest_cyborg", 0.3, nil, nil, 15)
NPC = AddDrop(NPC, "armor_shield_skele", 0.3, nil, nil, 31)
NPC = AddDrop(NPC, "armor_shield_tyrant", 0.2, nil, nil, 40)
NPC = AddDrop(NPC, "armor_belt_cyborg", 0.4, nil, nil, 20)
NPC = AddDrop(NPC, "armor_belt_skele", 0.4, nil, nil, 32)
NPC = AddDrop(NPC, "armor_belt_tyrant", 0.1, nil, nil, 43)
NPC = AddDrop(NPC, "armor_belt_bio", 0.05, nil, nil, 42)
NPC = AddMultiplier(NPC, 25, 4)
NPC.Weapon = "weapon_ar2"
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("Breen", "Breen", "npc_breen", "combine", 300)
NPC = AddDrop(NPC, "armor_shoulder_cyborg", 0.1, nil, nil, 10)
NPC = AddMultiplier(NPC, 3, 2)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("combine_turret(f)", "Combine Turret(Floor)", "npc_turret_floor", "combine")
NPC = AddMultiplier(NPC, 20, 3)
NPC = AddBool(NPC, true, false, false)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("combine_turret(c)", "Combine Turret(Ceiling)", "npc_turret_ceiling", "combine")
NPC = AddMultiplier(NPC, 20, 3)
NPC = AddBool(NPC, true, false, false)
NPC.DeathDistance = 14
Register.NPC(NPC)

local NPC = QuickNPC("combine_manhack", "Combine ManHack", "npc_manhack", "combine", 1000)
NPC = AddMultiplier(NPC, 0.5, 0.5)
NPC.DeathDistance = 5
Register.NPC(NPC)

local NPC = QuickNPC("combine_rollermine", "Combine RollerMine", "npc_rollermine", "combine", 500)
NPC = AddMultiplier(NPC, 1, 3)
NPC.DeathDistance = 10
Register.NPC(NPC)

local NPC = QuickNPC("vortigaunt", "Metro police", "npc_metropolice", "combine", 1000)
NPC = AddDrop(NPC, "money", 300, 350, 400)
NPC = AddDrop(NPC, "weapon_melee_skele", 0.5, nil, nil, 50)
NPC = AddDrop(NPC, "armor_shield_tyrant", 1, nil, nil, 40)
NPC = AddDrop(NPC, "armor_chest_tyrant", 1, nil, nil, 40)
NPC = AddDrop(NPC, "armor_helm_tyrant", 1, nil, nil, 40)
NPC = AddDrop(NPC, "armor_belt_tyrant", 1, nil, nil, 40)
NPC = AddDrop(NPC, "armor_shoulder_tyrant", 1, nil, nil, 40)
NPC = AddDrop(NPC, "weapon_melee_tyrant", 1, nil, nil, 40)
AddMultiplier(NPC, 50, 6) --health and damage is multiplied by integers inputed into those slots.
NPC.Weapon = "weapon_pistol"
NPC.DeathDistance = 14 --Do not edit.
NPC.Resistance = "Ice"
function NPC:DamageCallBack(npc, victim)
	intChance = 50
	if  math.random(1, 100 / intChance) == 1 then
		victim:SlowDown(3)
	end
end
Register.NPC(NPC)

local NPC = QuickNPC("poisonzombie", "Poison Zombie", "npc_poisonzombie", "zombie", 300)
NPC = AddDrop(NPC, "money", 100, 500, 800)
NPC = AddMultiplier(NPC, 50, 8)
NPC.DeathDistance = 14
Register.NPC(NPC)
