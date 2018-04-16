local Skill = {}
Skill.Name = "skill_basictraining"
Skill.PrintName = "Basic Training"
Skill.Icon = "icons/weapon_pistol"
Skill.Desc = {}
Skill.Desc["story"] = "Its time for basic soldier!"
Skill.Desc[1] = "Increase Dexterity by 2"
Skill.Desc[2] = "Increase Dexterity by 4"
Skill.Desc[3] = "Increase Dexterity by 7"
Skill.Tier = 1
Skill.Levels = 3
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel)
	local tblStatTable = {}
	tblStatTable[0] = 0
	tblStatTable[1] = 2
	tblStatTable[2] = 4
	tblStatTable[3] = 7
	plyPlayer:AddStat("stat_dexterity", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_closecombat"
Skill.PrintName = "Close Quarters Combat"
Skill.Icon = "icons/junk_gnome"
Skill.Desc = {}
Skill.Desc["story"] = "Be trained by the pros."
Skill.Desc[1] = "Increase Strength by 1"
Skill.Desc[2] = "Increase Strength by 3"
Skill.Desc[3] = "Increase Strength by 5"
Skill.Tier = 1
Skill.Levels = 3
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel)
	local tblStatTable = {}
	tblStatTable[0] = 0
	tblStatTable[1] = 1
	tblStatTable[2] = 3
	tblStatTable[3] = 5
	plyPlayer:AddStat("stat_strength", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_hexbones"
Skill.PrintName = "Hexagonal Leg Bones"
Skill.Icon = "icons/junk_shoe"
Skill.Desc = {}
Skill.Desc["story"] = "Your regular leg bone structure is bio-moded to a hexagonal, lighter one."
Skill.Desc[1] = "Increase Agility by 1"
Skill.Desc[2] = "Increase Agility by 2"
Skill.Tier = 1
Skill.Levels = 2
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel)
	local tblStatTable = {}
	tblStatTable[0] = 0
	tblStatTable[1] = 1
	tblStatTable[2] = 2
	plyPlayer:AddStat("stat_agility", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_consumeless"
Skill.PrintName = "Consume Less!"
Skill.Icon = "icons/junk_metalcan2"
Skill.Desc = {}
Skill.Desc["story"] = "More sustenece from less food (health kits too)."
Skill.Desc[1] = "You get 15% more health"
Skill.Tier = 1
Skill.Levels = 1
Skill.Hooks = {}
Skill.Hooks["food_mod"] = function(plyPlayer, intSkillLevel, intHealthToAdd)
	if intSkillLevel > 0 then
		intHealthToAdd = intHealthToAdd + (intHealthToAdd * (15 / 100))
	end
	return intHealthToAdd
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_barter"
Skill.PrintName = "Barter"
Skill.Icon = "icons/item_cash"
Skill.Desc = {}
Skill.Desc["story"] = "You know how to work the shop keeper."
Skill.Desc[1] = "You get a 3% discount on all items"
Skill.Desc[2] = "You get a 5% discount on all items"
Skill.Tier = 1
Skill.Levels = 2
Skill.Hooks = {}
Skill.Hooks["price_mod"] = function(plyPlayer, intSkillLevel, intPrice)
	if intSkillLevel > 0 then
		local intDiscount = 3
		if intSkillLevel == 2 then intDiscount = 5 end
		intPrice = intPrice - (intPrice * (intDiscount / 100))
	end
	return intPrice
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_scavange"
Skill.PrintName = "Scavanger"
Skill.Icon = "icons/item_wood"
Skill.Desc = {}
Skill.Desc["story"] = "You become more experienced at scavenging for resources."
Skill.Desc[1] = "Increase max resources found by 1"
Skill.Desc[2] = "Increase max resources found by 2"
Skill.Tier = 1
Skill.Levels = 2
Skill.Hooks = {}
Skill.Hooks["resouce_mod"] = function(plyPlayer, intSkillLevel, strItem, intMaxAmount)
	if intSkillLevel > 0 then
		local intAddMaxAmount = 1
		if intSkillLevel == 2 then intAddMaxAmount = 2 end
		intMaxAmount = intMaxAmount + intAddMaxAmount
	end
	return strItem, intMaxAmount
end
Register.Skill(Skill)
