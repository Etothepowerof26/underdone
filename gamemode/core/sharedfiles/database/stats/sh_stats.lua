local Stat = {}
Stat.Name = "stat_maxhealth"
Stat.PrintName = "Max Health"
Stat.Desc = "The Maximum amount of Health you can have"
Stat.Default = 100
function Stat:OnSet(ply, intMaxHealth, intOldMaxHealth)
	ply:SetMaxHealth(intMaxHealth)
	ply:SetNWInt("MaxHealth", intMaxHealth)
	if ply:Health() > ply:GetMaxHealth() then
		ply:SetHealth(ply:GetMaxHealth())
	end
end
function Stat:OnSpawn(ply, intMaxHealth)
	ply:SetHealth(intMaxHealth)
end
hook.Add("UD_Hook_PlayerLoad", "PlayerLoadHealth", function(ply)
	ply:SetHealth(ply:GetStat("stat_maxhealth"))
end)
Register.Stat(Stat)

local Stat = {}
Stat.Name = "stat_maxweight"
Stat.Hide = true
Stat.Default = 30
Register.Stat(Stat)

local Stat = {}
Stat.Name = "stat_strength"
Stat.PrintName = "Strength"
Stat.Desc = "The more you have more damage melee attack will do"
Stat.Default = 1
function Stat:OnSet(ply, intStrength, intOldStrength)
	--ply:AddStat("stat_maxhealth", (intStrength - intOldStrength) * 1.5)
end
function Stat:DamageMod(ply, intStrength, intDamage)
	if ply:IsMelee() then
		intDamage = intDamage * math.Clamp(intStrength / 3, 1, intStrength)
	end
	return intDamage
end
Register.Stat(Stat)

local Stat = {}
Stat.Name = "stat_dexterity"
Stat.PrintName = "Dexterity"
Stat.Desc = "The more you have more damage ranged attack will do"
Stat.Default = 1
function Stat:DamageMod(ply, intDexterity, intDamage)
	if not ply:IsMelee() then
		intDamage = intDamage * math.Clamp(intDexterity / 3, 1, intDexterity)
	end
	return intDamage
end
Register.Stat(Stat)

local Stat = {}
Stat.Name = "stat_intellect"
Stat.PrintName = "Intellect"
Stat.Desc = ""
Stat.Default = 1
Register.Stat(Stat)

local Stat = {}
Stat.Name = "stat_agility"
Stat.PrintName = "Agility"
Stat.Desc = "The higher this is teh faster you run and reload and attack"
Stat.Default = 1
function Stat:OnSet(ply, intAgility, intOldAgility)
	ply:AddMoveSpeed((intAgility - intOldAgility) * 10)
end
function Stat:FireRateMod(ply, intAgility, intFireRate)
	intFireRate = intFireRate * math.Clamp(intAgility / 5, 1, intAgility)
	return intFireRate
end
Register.Stat(Stat)

local Stat = {}
Stat.Name = "stat_luck"
Stat.PrintName = "Luck"
Stat.Desc = "You find your self to be more lucky, crit hits"
Stat.Default = 1
Register.Stat(Stat)
