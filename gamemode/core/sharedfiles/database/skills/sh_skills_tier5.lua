local Skill = {}
Skill.Name = "skill_squadhealthregen"
Skill.PrintName = "Squad HealthRegen"
Skill.SkillNeeded = "skill_healthgen"
Skill.Icon = "icons/item_healthkit"
Skill.Desc = {}
Skill.Desc["story"] = "Your blood is purposly infected with a bacteria that allows you to heal anyone around you in your team"
Skill.Desc["SkillNeeded"] = "Blood Mutation"
Skill.Desc[1] = "Every 12 seconds you and your squadmate's who are within a 500 radius of you, will get 1% of there max health."
Skill.Tier = 5
Skill.Levels = 1
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel)
	local intPercent = intSkillLevel
	if intPercent <= 0 then return end
	if #(plyPlayer.Squad or {}) < 1 then return end
	local function fncDoSquadHealth(plyPlayer)
		if intPercent > 0 and IsValid(plyPlayer) and plyPlayer:Alive() then
			for _, plySquad in pairs(plyPlayer.Squad) do
				if IsValid(plySquad) and plyPlayer:GetPos():Distance(plySquad:GetPos()) <= 500 then
					local intCurrentHealth = plySquad:Health()
					plySquad:SetHealth(math.Clamp(intCurrentHealth + (plySquad:GetMaximumHealth() * (intPercent / 100)), 0, plySquad:GetMaximumHealth()))
				end
			end
		end
	end
	timer.Create(plyPlayer:EntIndex(), 12, 0, function() fncDoSquadHealth(plyPlayer) end)
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_nanoweavemusles"
Skill.PrintName = "Nano Weave Musles"
Skill.SkillNeeded = "skill_hydraulicbiceps"
Skill.Icon = "icons/junk_box1"
Skill.Desc = {}
Skill.Desc["story"] = "The musles in you body are reenforced with a nano weave of carbon."
Skill.Desc["SkillNeeded"] = "Hydraulic Biceps"
Skill.Desc[1] = "Increase Strength by 9"
Skill.Desc[2] = "Increase Strength by 10"
Skill.Desc[3] = "Increase Strength by 12"
Skill.Tier = 5
Skill.Levels = 3
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel)
	local tblStatTable = {}
	tblStatTable[0] = 0
	tblStatTable[1] = 9
	tblStatTable[2] = 10
	tblStatTable[3] = 12
	plyPlayer:AddStat("stat_strength", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
Register.Skill(Skill)

local Skill = {}
Skill.Name = "skill_luckyace"
Skill.PrintName = "Lucky Ace"
Skill.Icon = "icons/item_beer"
Skill.Desc = {}
Skill.Desc["story"] = "You found a ace of spades in some dead guys pocket, I think it is lucky!"
Skill.Desc[1] = "Increase Luck by 5"
Skill.Tier = 5
Skill.Levels = 1
function Skill:OnSet(plyPlayer, intSkillLevel, intOldSkillLevel)
	local tblStatTable = {}
	tblStatTable[0] = 0
	tblStatTable[1] = 5
	plyPlayer:AddStat("stat_luck", tblStatTable[intSkillLevel] - tblStatTable[intOldSkillLevel])
end
Register.Skill(Skill)
