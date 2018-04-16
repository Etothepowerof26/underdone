local tblBreakables = {}
local function AddItem(strModel, strItem, intChance, intMin, intMax)
	tblBreakables[strModel] = tblBreakables[strModel] or {}
	table.insert(tblBreakables[strModel], {Item = strItem, Chance = intChance or 100, Min = intMin or 1, Max = intMax or intMin or 1})
end
AddItem("models/props_junk/wood_crate001a.mdl", "wood", 80, 1, 3)
AddItem("models/props_junk/wood_crate002a.mdl", "wood", 80, 1, 3)
AddItem("models/props_junk/wood_crate002a.mdl", "item_smallammo_small", 10)
AddItem("models/props_junk/wood_crate002a.mdl", "item_rifleammo_small", 10)
AddItem("models/props_junk/wood_crate002a.mdl", "item_buckshotammo_small", 10)
AddItem("models/props_junk/wood_crate002a.mdl", "item_canmeat", 30)

local function PropAdjustDamage(entVictim, entInflictor, entAttacker, intAmount, tblDamageInfo)
	if IsValid(entVictim) and entVictim:GetClass() == "prop_physics" then
		local tblBreakTable = tblBreakables[entVictim:GetModel()]
		if tblBreakTable and entAttacker:IsPlayer() then
			tblDamageInfo:ScaleDamage(2)
			return
		end
		tblDamageInfo:SetDamage(0)
	end
end
hook.Add("EntityTakeDamage", "PropAdjustDamage", PropAdjustDamage)

local function OnPropBreak(entBreaker, entProp)
	if entBreaker:IsValid() and entBreaker:IsPlayer() and entProp:IsValid() then
		local tblBreakTable = tblBreakables[entProp:GetModel()]
		if tblBreakTable then
			for _, tblBreakItem in pairs(tblBreakTable) do
				if math.random(1, 100 / tblBreakItem.Chance) == 1 then
					local strItem = tblBreakItem.Item
					local intMaxAmount = tblBreakItem.Max
					strItem, intMaxAmount = entBreaker:CallSkillHook("resouce_mod", strItem, intMaxAmount)
					for i = 1, math.random(tblBreakItem.Min, intMaxAmount) do
						local entLoot = CreateWorldItem(strItem)
						entLoot:SetPos(entProp:GetPos())
						entLoot:SetOwner(entBreaker)
						entLoot:GetPhysicsObject():ApplyForceCenter(Vector(math.random(-100, 100), math.random(-100, 100), math.random(350, 400)))
					end
				end
			end
		end
		if entProp.ObjectKey and GAMEMODE.MapEntities.WorldProps[entProp.ObjectKey] then
			local tblWorldObject = GAMEMODE.MapEntities.WorldProps[entProp.ObjectKey]
			timer.Simple(math.random(45, 75), function() tblWorldObject.SpawnProp() end)
		end
	end
end
hook.Add("PropBreak", "OnPropBreak", OnPropBreak)
