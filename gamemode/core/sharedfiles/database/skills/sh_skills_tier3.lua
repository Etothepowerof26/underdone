local Skill = {}
Skill.Name = "skill_healthgen"
Skill.PrintName = "Blood Mutation"
Skill.SkillNeeded = "skill_mechheart"
Skill.Icon = "icons/item_healthkit"
Skill.Desc = {}
Skill.Desc["story"] = "Your blood is purposly infected with a bacteria that heals you."
Skill.Desc["SkillNeeded"] = "Mech Heart"
Skill.Desc[1] = "Every 6 seconds your health goes up by 1% of its max amount"
Skill.Desc[2] = "Every 6 seconds your health goes up by 2% of its max amount"
Skill.Tier = 3
Skill.Levels = 2
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel)
	local intPercent = intSkillLevel
	local function fncDoHealth(plyPlayer)
		if intPercent > 0 and IsValid(plyPlayer) and plyPlayer:Alive() then
			local intCurrentHealth = plyPlayer:Health()
			plyPlayer:SetHealth(math.Clamp(intCurrentHealth + (plyPlayer:GetMaximumHealth() * (intPercent / 100)), 0, plyPlayer:GetMaximumHealth()))
		end
	end
	timer.Create(plyPlayer:EntIndex(), 6, 0, function() fncDoHealth(plyPlayer) end)
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_warriorsfire"
Skill.PrintName = "Warriors Fire"
Skill.SkillNeeded = "skill_paralyzepoison"
Skill.Icon = "icons/weapon_axe"
Skill.Desc = {}
Skill.Desc["story"] = "The fire within you burns hot."
Skill.Desc["SkillNeeded"] = "Paralyze poison"
Skill.Desc[1] = "Every melee attack has a 6% chance to burn for 3 seconds"
Skill.Desc[2] = "Every melee attack has a 8% chance to burn for 7 seconds"
Skill.Tier = 3
Skill.Levels = 2
function Skill:BulletCallBack(plyPlayer, intSkill, trcTrace, tblDamageInfo)
	if not SERVER then return end
	local entEntity = trcTrace.Entity
	if plyPlayer:IsMelee() and intSkill > 0 and entEntity:IsNPC() and entEntity.Race ~= "human" and entEntity.Race ~= "antlion" then
		local intChance = 0
		local intTime = 0
		if intSkill == 1 then intChance = 6 intTime = 3 end
		if intSkill == 2 then intChance = 8 intTime = 7 end
		if  math.random(1, 100 / intChance) == 1 then
			trcTrace.Entity:IgniteFor(intTime, 1, plyPlayer)
		end
	end
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_bulletleech"
Skill.PrintName = "Bullet Leech"
Skill.SkillNeeded = "skill_mechheart"
Skill.Icon = "icons/item_pistolammobox"
Skill.Desc = {}
Skill.Desc["story"] = "Nano-bots are installed on your bullets giving you a chance to stealing some health."
Skill.Desc["SkillNeeded"] = "Mech Heart"
Skill.Desc[1] = "Every bullet has a 8% chance at stealing 4% of the target's health"
Skill.Desc[2] = "Every bullet has a 12% chance at stealing 5% of the target's health"
Skill.Desc[3] = "Every bullet has a 14% chance at stealing 7% of the target's health"
Skill.Tier = 3
Skill.Levels = 3
function Skill:BulletCallBack(plyPlayer, intSkill, trcTrace, tblDamageInfo)
	if not SERVER then return end
	local entEntity = trcTrace.Entity
	if not plyPlayer:IsMelee() and intSkill > 0 and entEntity:IsNPC() and entEntity.Race ~= "human" then
		local intChance = 0
		local intPercent = 0
		if intSkill == 1 then intChance = 8 intPercent = 4 end
		if intSkill == 2 then intChance = 12 intPercent = 5 end
		if intSkill == 3 then intChance = 14 intPercent = 7 end
		if math.random(1, 100 / intChance) == 1 then
			local intHealthtoSteal = math.ceil(entEntity:Health() * (intPercent / 100))
			tblDamageInfo:SetDamage(tblDamageInfo:GetDamage() + intHealthtoSteal)
			plyPlayer:SetHealth(math.Clamp(plyPlayer:Health() + intHealthtoSteal, 0, plyPlayer:GetMaximumHealth()))
			plyPlayer:CreateIndacator("+_" .. intHealthtoSteal .. "HP", plyPlayer:GetPos() + Vector(0, 0, 70), "purple")
		end
	end
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_eagleeye"
Skill.PrintName = "Eagle Eye"
Skill.Icon = "icons/weapon_sniper1"
Skill.SkillNeeded = "skill_marksman"
Skill.Desc = {}
Skill.Desc["story"] = "The sprit of teh eagle flows within you, feel the power."
Skill.Desc["SkillNeeded"] = "Marks Man"
Skill.Desc[1] = "Increase Dexterity by 5"
Skill.Desc[2] = "Increase Dexterity by 7"
Skill.Tier = 3
Skill.Levels = 2
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel)
	local tblStatTable = {}
	tblStatTable[0] = 0
	tblStatTable[1] = 5
	tblStatTable[2] = 7
	plyPlayer:AddStat("stat_dexterity", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_hydraulicbiceps"
Skill.PrintName = "Hydraulic Biceps"
Skill.SkillNeeded = "skill_brutal"
Skill.Icon = "icons/junk_box1"
Skill.Desc = {}
Skill.Desc["story"] = "When human arms just doesn't cut it any more."
Skill.Desc["SkillNeeded"] = "Brutal"
Skill.Desc[1] = "Increase Strength by 6"
Skill.Desc[2] = "Increase Strength by 10"
Skill.Tier = 3
Skill.Levels = 2
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel)
	local tblStatTable = {}
	tblStatTable[0] = 0
	tblStatTable[1] = 5
	tblStatTable[2] = 10
	plyPlayer:AddStat("stat_strength", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
Register.Skill(Skill)
