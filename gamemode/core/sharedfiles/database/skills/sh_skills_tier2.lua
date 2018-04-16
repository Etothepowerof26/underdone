local Skill = {}
Skill.Name = "skill_paralyzepoison"
Skill.PrintName = "Paralyze poison"
Skill.Icon = "icons/weapon_axe"
Skill.Desc = {}
Skill.Desc["story"] = "Augments your blade with a deadly paralyzing poison"
Skill.Desc[1] = "Every melee attack has a 5% chance to paralyze for 2 seconds"
Skill.Desc[2] = "Every melee attack has a 8% chance to paralyze for 4 seconds"
Skill.Tier = 2
Skill.Levels = 2
function Skill:BulletCallBack(plyPlayer, intSkill, trcTrace, tblDamageInfo)
	if not SERVER then return end
	local entEntity = trcTrace.Entity
	if plyPlayer:IsMelee() and intSkill > 0 and entEntity:IsNPC() and entEntity.Race ~= "human" then
		local intChance = 0
		local intTime = 0
		if intSkill == 1 then intChance = 5 intTime = 2 end
		if intSkill == 2 then intChance = 8 intTime = 4 end
		if  math.random(1, 100 / intChance) == 1 then
			entEntity:Stun(intTime, 0.1 / intSkill)
		end
	end
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_marksman"
Skill.PrintName = "Marks Man"
Skill.Icon = "icons/weapon_sniper1"
Skill.SkillNeeded = "skill_basictraining"
Skill.Desc = {}
Skill.Desc["story"] = "Learn to master ranged weapons."
Skill.Desc["SkillNeeded"] = "Basic Training"
Skill.Desc[1] = "Increase Dexterity by 4"
Skill.Desc[2] = "Increase Dexterity by 5"
Skill.Desc[3] = "Increase Dexterity by 7"
Skill.Desc[4] = "Increase Dexterity by 10"
Skill.Tier = 2
Skill.Levels = 4
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel)
	local tblStatTable = {}
	tblStatTable[0] = 0
	tblStatTable[1] = 4
	tblStatTable[2] = 5
	tblStatTable[3] = 7
	tblStatTable[4] = 10
	plyPlayer:AddStat("stat_dexterity", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_brutal"
Skill.PrintName = "Brutal"
Skill.SkillNeeded = "skill_closecombat"
Skill.Icon = "icons/weapon_pipe"
Skill.Desc = {}
Skill.Desc["story"] = "Your anger and brutality give you power."
Skill.Desc["SkillNeeded"] = "Close Quarters Combat"
Skill.Desc[1] = "Increase Strength by 3"
Skill.Desc[2] = "Increase Strength by 4"
Skill.Desc[3] = "Increase Strength by 8"
Skill.Tier = 2
Skill.Levels = 3
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel)
	local tblStatTable = {}
	tblStatTable[0] = 0
	tblStatTable[1] = 3
	tblStatTable[2] = 4
	tblStatTable[3] = 8
	plyPlayer:AddStat("stat_strength", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_mechheart"
Skill.PrintName = "Mech Heart"
Skill.Icon = "icons/item_healthkit"
Skill.SkillNeeded = "skill_consumeless"
Skill.Desc = {}
Skill.Desc["story"] = "Your old heart is enhanced by hydraulics, increasing blood flow and overall health."
Skill.Desc["SkillNeeded"] = "Consume Less!"
Skill.Desc[1] = "Increase Max Health by 10"
Skill.Desc[2] = "Increase Max Health by 20"
Skill.Desc[3] = "Increase Max Health by 35"
Skill.Tier = 2
Skill.Levels = 3
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel)
	local tblStatTable = {}
	tblStatTable[0] = 0
	tblStatTable[1] = 10
	tblStatTable[2] = 20
	tblStatTable[3] = 35
	plyPlayer:AddStat("stat_maxhealth", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_momentum"
Skill.PrintName = "Momentum"
Skill.Icon = "icons/junk_gnome"
Skill.Desc = {}
Skill.Desc["story"] = "Learn to use your momentum as a weapon."
Skill.Desc[1] = "Every melee attack has a 0.2% more damage for every Kg in your inventory"
Skill.Tier = 2
Skill.Levels = 1
Skill.Hooks = {}
Skill.Hooks["damage_mod"] = function(plyPlayer, intSkillLevel, intDamage)
	if plyPlayer:IsMelee() and intSkillLevel > 0 then
		intDamage = intDamage + (intDamage * ((0.2 * (plyPlayer.Weight or 0)) / 100))
	end
	return intDamage
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_leadcurrency"
Skill.PrintName = "Lead Currency"
Skill.Icon = "icons/item_pistolammobox"
Skill.Desc = {}
Skill.Desc["story"] = "You can recover your old bullets from the bodies of the fallen, but it can be expensive."
Skill.Desc[1] = "10% more ammo drops but 5% less money drops"
Skill.Tier = 2
Skill.Levels = 1
Skill.Hooks = {}
Skill.Hooks["drop_mod"] = function(plyPlayer, intSkillLevel, strItem, tblInfo)
	if intSkillLevel > 0 then
		local tblItemTable = ItemTable(strItem)
		if tblItemTable.AmmoAmount then
			plyPlayer.Chance = math.Clamp(tblInfo.Chance + 10, 0, 100)
		end
		if tblItemTable.Name == "money" then
			plyPlayer.Chance = math.Clamp(tblInfo.Chance - 5, 0, 100)
		end
	end
	return strItem, tblInfo
end
Register.Skill(Skill)
