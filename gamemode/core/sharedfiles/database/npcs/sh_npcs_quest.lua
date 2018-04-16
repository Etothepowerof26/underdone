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
local function AddDrop(Table, strName, strChance, strMin, strMax,strDefaultChance)
	Table.Drops = Table.Drops or {}
	Table.Drops[strName] = {Chance = strChance, Min = strMin, Max = strMax}
	return Table
end

local NPC = QuickNPC("combine_thumper", "Combine Thumper", "prop_physics", nil, nil, "models/props_combine/CombineThumper001a.mdl")
NPC = AddMultiplier(NPC, 5)
NPC = AddBool(NPC, true, false, false)
Register.NPC(NPC)
