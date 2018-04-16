local function TickDistanceRetreat()
	for _, npc in pairs(ents.FindByClass("npc_*")) do
		if IsValid(npc) and not npc.DontReturn  then
			local tblNPCTable = NPCTable(npc:GetNWString("npc"))
			if tblNPCTable and tblNPCTable.DistanceRetreat then
				if npc:GetPos():Distance(npc.Position) > tblNPCTable.DistanceRetreat then
					if not npc.HasTask then
						npc:ReturnSpawn()
						npc.HasTask = true
						timer.Simple(20, function()
							if IsValid(npc) and npc.HasTask then
								npc:Idle()
								npc.HasTask = false
							end
						end)
					end
				end
				if npc:GetPos():Distance(npc.Position) > (tblNPCTable.DistanceRetreat * 2) then
					npc:SetPos(npc.Position)
				end
				if npc.HasTask then
					if npc:GetPos():Distance(npc.Position) < (tblNPCTable.DistanceRetreat * 0.1) then
						npc:Idle()
						npc.HasTask = false
					end
					if npc:IsBlocked() then
						npc:SetPos(npc.Position)
						npc.HasTask = false
					end
				end
				if npc:IsNPC() and not npc:GetEnemy() then
					for _,ply in pairs(player.GetAll()) do
						if ply:GetPos():Distance(npc:GetPos()) < 200 then
							npc:AttackEnemy(ply)
						end
					end
				end
			end
		end
	end
end
hook.Add("Tick", "TickDistanceRetreat", TickDistanceRetreat)

function GM:OnNPCKilled(npcTarget, entKiller, weapon)
	if npcTarget:GetClass() == "npc_zombie" then GAMEMODE:RemoveAll("npc_headcrab") end
	if not entKiller:IsPlayer() and npcTarget.LastPlayerAttacker then entKiller = npcTarget.LastPlayerAttacker end
	if entKiller.EntityDamageData then
		if entKiller.EntityDamageData[npcTarget] then
			for _, ply in pairs(player.GetAll()) do
				if ply.EntityDamageData then
					if ply.EntityDamageData[npcTarget] then
						if ply.EntityDamageData[npcTarget] > entKiller.EntityDamageData[npcTarget] then
							entKiller = ply
						end
					end
				end
			end
		end
	end
	for _, ply in pairs(player.GetAll()) do
		if ply.EntityDamageData then
			if ply.EntityDamageData[npcTarget] then
				ply.EntityDamageData[npcTarget] = nil
			end
		end
	end
	if npcTarget:GetNWInt("level") > 0 and entKiller and entKiller:IsValid() and entKiller:IsPlayer() then
		local tblNPCTable = NPCTable(npcTarget:GetNWString("npc"))
		if #(entKiller.Squad or {}) > 1 then
			local intTotalExp = math.Round((npcTarget:GetMaxHealth() * (npcTarget:GetLevel() / entKiller:GetAverageSquadLevel())) / (#(entKiller.Squad or {}) + 7))
			local intPerPlayer = math.Round(intTotalExp / #entKiller.Squad)
			for _, ply in pairs(entKiller.Squad) do
				if IsValid(ply) then
					ply:GiveExp(intPerPlayer, true)
				end
			end
		else
			entKiller:GiveExp(math.Round((npcTarget:GetMaxHealth() * (npcTarget:GetLevel() / entKiller:GetLevel())) / 6), true)
		end
		for strItem, tblInfo in pairs(tblNPCTable.Drops or {}) do
			local tblItemTable = ItemTable(strItem)
			--Check Level of player and of npc
			if npcTarget:GetLevel() >= (tblInfo.MinLevel or 0) then
				if not tblItemTable.QuestItem or (entKiller:GetQuest(tblItemTable.QuestItem) and not entKiller:HasCompletedQuest(tblItemTable.QuestItem)) then
					strItem, tblInfo = entKiller:CallSkillHook("drop_mod", strItem, tblInfo)
					local intChance = (tblInfo.Chance or 0) * (1 + (entKiller:GetStat("stat_luck") / 45))
					local ItemChance = 100 / math.Clamp(intChance, 0, 100)
					if math.random(1, (ItemChance or 100)) == 1 then
						local intAmount = math.random(tblInfo.Min or 1, tblInfo.Max or tblInfo.Min or 1)
						local entLoot = CreateWorldItem(strItem, intAmount, npcTarget:GetPos() + Vector(0, 0, 30))
						entLoot:SetOwner(entKiller)
						local phyLootPhys = entLoot:GetPhysicsObject()
						if not IsValid(phyLootPhys) and IsValid(entLoot.Grip) then phyLootPhys = entLoot.Grip:GetPhysicsObject() end
						phyLootPhys:Wake()
						phyLootPhys:ApplyForceCenter(Vector(math.random(-100, 100), math.random(-100, 100), math.random(350, 400)))
					end
				end
			end
		end
	end
end

local function NPCAdjustDamage(entVictim, entInflictor, entAttacker, intAmount, tblDamageInfo)
	if not IsValid(entVictim) or not IsValid(entAttacker) or not NPCTable(entVictim:GetNWString("npc")) then return end
	if entAttacker.OverrideDamge then tblDamageInfo:SetDamage(entAttacker.OverrideDamge) end
	if not entAttacker:IsPlayer() and entAttacker:GetOwner():IsPlayer() then
		entAttacker = entAttacker:GetOwner()
	end
	local tblNPCTable = NPCTable(entVictim:GetNWString("npc"))
	local boolInvincible = tblNPCTable.Invincible or entAttacker.Race == tblNPCTable.Race
	if entAttacker:IsPlayer() and not boolInvincible then
		local clrDisplayColor = "white"
		tblDamageInfo:SetDamage(math.Round(tblDamageInfo:GetDamage() * (1 / entVictim:GetNWInt("level"))))
		if math.random(1, math.Round(20 / (1 + (entAttacker:GetStat("stat_luck") / 50)))) == 1 then
			tblDamageInfo:SetDamage(math.Round(tblDamageInfo:GetDamage() * 2))
			entAttacker:CreateIndacator("Crit!", tblDamageInfo:GetDamagePosition(), "blue", true)
			clrDisplayColor = "blue"
		end
		if entVictim:IsNPC() then
			if not entVictim:GetEnemy() then
				entVictim:AttackEnemy(entAttacker)
			end
			entVictim:AddEntityRelationship(entAttacker, GAMEMODE.RelationHate, 99)
		end
		if entVictim:Health() < 2 and entVictim:IsBuilding() then
			local tblNPCTable = NPCTable(entVictim:GetNWString("npc"))
			if not tblNPCTable then return end
			entAttacker:AddQuestKill(entVictim:GetNWString("npc"))
		end
		tblDamageInfo:SetDamage(math.Round(tblDamageInfo:GetDamage() + math.random(-1, math.Round(1 * (1 + (entAttacker:GetStat("stat_luck") / 55))))))
		tblDamageInfo:SetDamage(math.Clamp(tblDamageInfo:GetDamage(), 0, tblDamageInfo:GetDamage()))
		if not entAttacker.EntityDamageData then
			entAttacker.EntityDamageData = {}
		end
		entAttacker.EntityDamageData[entVictim] = (entAttacker.EntityDamageData[entVictim] or 0) + math.Clamp(tblDamageInfo:GetDamage(),0,entVictim:Health())
		entAttacker:CreateIndacator(tblDamageInfo:GetDamage(), tblDamageInfo:GetDamagePosition(), clrDisplayColor, true)
		if entVictim:Health() <= tblDamageInfo:GetDamage() then
			entVictim:Remove()
		end
		entVictim.FirstPlayerAttacker = entVictim.FirstPlayerAttacker or entAttacker
		entVictim.LastPlayerAttacker = entAttacker
		entVictim:SetHealth(entVictim:Health() - tblDamageInfo:GetDamage())
		entVictim:SetNWInt("Health", entVictim:Health())
		tblDamageInfo:SetDamage(0)
	end
	if boolInvincible then tblDamageInfo:SetDamage(0) end
end
hook.Add("EntityTakeDamage", "NPCAdjustDamage", NPCAdjustDamage)
function GM:ScaleNPCDamage(entVictim, strHitGroup, tblDamageInfo)
	tblDamageInfo:ScaleDamage(1)
	local tblNPCTable = NPCTable(entVictim:GetNWString("npc"))
	if not tblNPCTable then return end
	if tblNPCTable.Invincible or tblDamageInfo:GetAttacker().Race == tblNPCTable.Race then
		tblDamageInfo:ScaleDamage(0)
	end
end
