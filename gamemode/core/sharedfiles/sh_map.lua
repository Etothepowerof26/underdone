GM.MapEntities = {}
GM.MapEntities.NPCSpawnPoints = {}
GM.MapEntities.WorldProps = {}

function GM:CreateSpawnPoint(vecPosition, angAngle, strNPC, intLevel, intSpawnTime)
	table.insert(GAMEMODE.MapEntities.NPCSpawnPoints, {})
	local intNumSpawns = #GAMEMODE.MapEntities.NPCSpawnPoints
	GAMEMODE:UpdateSpawnPoint(intNumSpawns, vecPosition, angAngle, strNPC, intLevel, intSpawnTime)
end
function GM:RemoveSpawnPoint(intKey)
	local tblSpawnPoint = GAMEMODE.MapEntities.NPCSpawnPoints[intKey]
	if tblSpawnPoint then
		if tblSpawnPoint.Monster then tblSpawnPoint.Monster:Remove() end
		table.remove(GAMEMODE.MapEntities.NPCSpawnPoints, intKey)
	end
	if SERVER and game.SinglePlayer() and player.GetByID(1) and player.GetByID(1):IsValid() then
		SendNetworkMessage("UD_RemoveSpawnPoint", player.GetByID(1), {intKey})
	end
end
function GM:UpdateSpawnPoint(intKey, vecPosition, angAngle, strNPC, intLevel, intSpawnTime)
	local tblToUpdateSpawn = GAMEMODE.MapEntities.NPCSpawnPoints[intKey]
	if tblToUpdateSpawn then
		tblToUpdateSpawn.Position = vecPosition or tblToUpdateSpawn.Position
		tblToUpdateSpawn.Angle = angAngle or tblToUpdateSpawn.Angle or Angle(0, 0, 0)
		tblToUpdateSpawn.NPC = strNPC or tblToUpdateSpawn.NPC or "zombie"
		tblToUpdateSpawn.Level = intLevel or tblToUpdateSpawn.Level or 5
		tblToUpdateSpawn.SpawnTime = intSpawnTime or tblToUpdateSpawn.SpawnTime or 0
		if IsValid(tblToUpdateSpawn.Monster) then
			tblToUpdateSpawn.Monster:SetAngles(tblToUpdateSpawn.Angle)
		end
		if SERVER and game.SinglePlayer() and IsValid(player.GetByID(1)) then
			SendNetworkMessage("UD_UpdateSpawnPoint", player.GetByID(1), {intKey, tblToUpdateSpawn.Position, tblToUpdateSpawn.Angle, tblToUpdateSpawn.NPC, tblToUpdateSpawn.Level, tblToUpdateSpawn.SpawnTime})
		end
	else
		GAMEMODE:CreateSpawnPoint(vecPosition, angAngle, strNPC, intLevel, intSpawnTime)
	end
end

function GM:CreateWorldProp(strModel, vecPosition, angAngle, entEntity, boolLoad)
	if SERVER then
		local tblNewObject = {}

		table.insert(self.MapEntities.WorldProps, tblNewObject)
		local index = #self.MapEntities.WorldProps

		tblNewObject.SpawnProp = function()
			local entNewProp = ents.Create(GetPropClass(strModel))
			tblNewObject.Entity = entNewProp
			self:UpdateWorldProp(index, strModel, vecPosition, angAngle, entNewProp)
			entNewProp:SetSkin(math.random(0, entNewProp:SkinCount()))
			entNewProp:Spawn()
		end
		tblNewObject.SpawnProp()

		return tblNewObject.Entity
	elseif CLIENT then
		table.insert(self.MapEntities.WorldProps, {Entity = entEntity})
		self:UpdateWorldProp(#self.MapEntities.WorldProps, strModel, vecPosition, angAngle, entEntity)
	end
end
function GM:RemoveWorldProp(intKey)
	local tblWorldProp = GAMEMODE.MapEntities.WorldProps[intKey]
	if tblWorldProp then
		if tblWorldProp.Entity and tblWorldProp.Entity:IsValid() then tblWorldProp.Entity:Remove() end
		table.remove(GAMEMODE.MapEntities.WorldProps, intKey)
	end
	if SERVER and game.SinglePlayer() and player.GetByID(1) and player.GetByID(1):IsValid() then
		SendNetworkMessage("UD_RemoveWorldProp", player.GetByID(1), {intKey})
	end
end
function GM:UpdateWorldProp(intKey, strModel, vecPosition, angAngle, entEntity, boolLoad)
	local tblToUpdateProp = GAMEMODE.MapEntities.WorldProps[intKey]
	if tblToUpdateProp and IsValid(tblToUpdateProp.Entity) then
		local entProp = tblToUpdateProp.Entity
		if SERVER then
			local strPreModel = entProp:GetModel()
			entProp:SetModel(strModel or entProp:GetModel() or "models/props_junk/garbage_metalcan001a.mdl")
			entProp:SetPos(vecPosition or entProp:GetPos())
			if strPreModel ~= entProp:GetModel() and not boolLoad then entProp:SetPos(GetFlushToGround(entProp)) end
			entProp:SetAngles(angAngle or entProp:GetAngles())
			entProp:PhysicsInit(SOLID_VPHYSICS)
			entProp:SetMoveType(MOVETYPE_NONE)
			entProp:DrawShadow(false)
			entProp:SetKeyValue("spawnflags", 8)
			entProp.ObjectKey = intKey
			if game.SinglePlayer() and player.GetByID(1) and player.GetByID(1):IsValid() then
				SendNetworkMessage("UD_UpdateWorldProp", player.GetByID(1), {intKey, entProp:GetModel(), entProp:GetPos(), entProp:GetAngles(), entProp})
			end
		end
		tblToUpdateProp.Model = entProp:GetModel()
		tblToUpdateProp.Position = entProp:GetPos()
		tblToUpdateProp.Angle = entProp:GetAngles()
	else
		GAMEMODE:CreateWorldProp(strModel, vecPosition, angAngle, entEntity)
	end
end

if SERVER then
	function GM:LoadMapObjects()
		local strFileName = "underdone/maps/" .. game.GetMap() .. ".txt"
		if not file.Exists(strFileName, "DATA") then return end
		--local tblDecodedTable = glon.decode(file.Read(strFileName, "DATA"))
		local tblDecodedTable = util.JSONToTable(file.Read(strFileName))
		for _, SpawnPoint in pairs(tblDecodedTable.NPCSpawnPoints or {}) do
			GAMEMODE:CreateSpawnPoint(SpawnPoint.Position, SpawnPoint.Angle or Angle(0, 90, 0), SpawnPoint.NPC, SpawnPoint.Level, SpawnPoint.SpawnTime)
		end
		for k, WorldProp in pairs(tblDecodedTable.WorldProps or {}) do
			timer.Simple(0.05 * k, function() GAMEMODE:CreateWorldProp(WorldProp.Model, WorldProp.Position, WorldProp.Angle, nil, true) end)
		end
	end
	hook.Add("Initialize", "LoadMapObjects", function() GAMEMODE:LoadMapObjects() end)
	function GM:SaveMapObjects()
		local strFileName = "underdone/maps/" .. game.GetMap() .. ".txt"
		local tblSaveTable = table.Copy(GAMEMODE.MapEntities)
		for _, SpawnPoint in pairs(tblSaveTable.NPCSpawnPoints or {}) do
			SpawnPoint.Monster = nil
			SpawnPoint.NextSpawn = nil
		end
		for _, WorldProp in pairs(tblSaveTable.WorldProps or {}) do
			WorldProp.Entity = nil
			WorldProp.SpawnProp = nil
		end
		--file.Write(strFileName, glon.encode(tblSaveTable))
		file.Write(strFileName, util.TableToJSON(tblSaveTable))
	end

	function GM:SpawnMapEntities()
		for _, Spawn in pairs(GAMEMODE.MapEntities.NPCSpawnPoints) do
			if not Spawn.Monster or not Spawn.Monster:IsValid() and #ents.FindByClass("npc_*") < 500 and not GAMEMODE.EventHasStarted then
				if not Spawn.NextSpawn then Spawn.NextSpawn = CurTime() + Spawn.SpawnTime end
				if Spawn.SpawnTime > 0 and CurTime() >= Spawn.NextSpawn then
					Spawn.Monster = GAMEMODE:CreateNPC(Spawn.NPC, Spawn)
					Spawn.NextSpawn = nil
				end
			end
		end
	end
	hook.Add("Tick", "SpawnMapEntities", function() GAMEMODE:SpawnMapEntities() end)

	function GM:CreateNPC(strNPC, tblSpawnPoint)
		local tblNPCTable = NPCTable(strNPC)
		if not tblNPCTable then return end
		if tblNPCTable.SpawnName == "npc_turret_floor" then return end
		local entNewMonster = ents.Create(tblNPCTable.SpawnName)
		if tblNPCTable.AdjustSpawn then
			entNewMonster:SetPos( tblSpawnPoint.Position + tblNPCTable.AdjustSpawn )
		else
			entNewMonster:SetPos( tblSpawnPoint.Position )
		end
		entNewMonster:SetAngles(tblSpawnPoint.Angle or Angle(0, 90, 0))
		entNewMonster:SetKeyValue("spawnflags","512")
		entNewMonster:DrawShadow(false)
		if tblNPCTable.Weapon then
			entNewMonster:Give(tblNPCTable.Weapon)
			entNewMonster:SetKeyValue("additionalequipment", tblNPCTable.Weapon)
			entNewMonster:SetKeyValue("spawnflags","8192")
		end
		if tblNPCTable.Accuracy then
			entNewMonster:SetCurrentWeaponProficiency( tblNPCTable.Accuracy )
		end
		if tblNPCTable.Model then
			entNewMonster:SetModel(tblNPCTable.Model)
		end
		if tblNPCTable.Color then
			local r = tblNPCTable.Color[1]
			local g = tblNPCTable.Color[2]
			local b = tblNPCTable.Color[3]
			local a = tblNPCTable.Color[4]
			entNewMonster:SetColor(Color(r,g,b,a))
		end
		entNewMonster:Spawn()
		if tblNPCTable.DeathDistance then
			for _, ent in pairs(ents.FindInSphere( tblSpawnPoint.Position, tblNPCTable.DeathDistance )) do
				if IsValid(ent) and ent:IsPlayer() then
					ent:Kill()
				end
			end
		end
		if tblNPCTable.Frozen then
			entNewMonster:DropToFloor()
			local phys = entNewMonster:GetPhysicsObject()
			if IsValid( phys ) then
				phys:EnableMotion( false )
			end
		end
		if  tblNPCTable.Resistance then
			entNewMonster.Resistance = tblNPCTable.Resistance
		end
		entNewMonster.Name = tblNPCTable.Name
		entNewMonster.Position = tblSpawnPoint.Position
		entNewMonster.Race = tblNPCTable.Race
		entNewMonster.Invincible = tblNPCTable.Invincible
		entNewMonster.Shop = tblNPCTable.Shop
		entNewMonster.Bank = tblNPCTable.Bank
		entNewMonster.Quest = tblNPCTable.Quest
		entNewMonster.Auction = tblNPCTable.Auction
		entNewMonster.Appearance = tblNPCTable.Appearance
		local intTotalFlags = 1 + 8192
		if tblNPCTable.Idle then
			entNewMonster:SetNPCState(NPC_STATE_IDLE)
			intTotalFlags = intTotalFlags + 16 + 128
		end
		entNewMonster:SetKeyValue("spawnflags", intTotalFlags)
		entNewMonster:SetNWString("npc", tblNPCTable.Name)
		local intLevel = math.Clamp(tblSpawnPoint.Level + math.random(-2, 2), 1, tblSpawnPoint.Level + 2)
		entNewMonster:SetNWInt("level", intLevel)
		local intHealth = intLevel * (tblNPCTable.HealthPerLevel or 10)
		entNewMonster:SetMaxHealth(intHealth)
		entNewMonster:SetNWInt("MaxHealth", intHealth)
		entNewMonster:SetHealth(intHealth)
		entNewMonster:SetNWInt("Health", intHealth)
		for _, ent in pairs(ents.GetAll()) do
			if ent and ent:IsValid() and (ent:IsNPC() or ent:IsPlayer()) and ent.Race and tblNPCTable.Race then
				if ent.Race == tblNPCTable.Race then
					entNewMonster:AddEntityRelationship(ent, GAMEMODE.RelationLike, 99)
					if ent:IsNPC() then ent:AddEntityRelationship(entNewMonster, GAMEMODE.RelationLike, 99) end
				else
					if not ent.Invincible then entNewMonster:AddEntityRelationship(ent, GAMEMODE.RelationHate, 99) end
					if not entNewMonster.Invincible and ent:IsNPC() then ent:AddEntityRelationship(entNewMonster, GAMEMODE.RelationHate, 99)  end
					if ent:IsPlayer() and not GAMEMODE.EventHasStarted and intLevel < ent:GetLevel() then
						entNewMonster:AddEntityRelationship(ent, GAMEMODE.RelationNeutral, 99)
					end
				end
			end
		end
		entNewMonster:Activate()
		return entNewMonster
	end

	if game.SinglePlayer() then
		local function OnPlayerSpawnMapEditor(ply)
			for key, spawnPoint in pairs(GAMEMODE.MapEntities.NPCSpawnPoints) do
				GAMEMODE:UpdateSpawnPoint(key)
			end
			for key, worldprop in pairs(GAMEMODE.MapEntities.WorldProps) do
				timer.Simple(1 * key, function()
					GAMEMODE:UpdateWorldProp(key)
				end)
			end
		end
		hook.Add("PlayerSpawn", "UD_OnPlayerSpawnMapEditor", OnPlayerSpawnMapEditor)

		concommand.Add("UD_Dev_EditMap_CreateSpawnPoint", function(ply, command, args)
			if not ply:IsAdmin() or not ply:IsPlayer() then return end
			GAMEMODE:CreateSpawnPoint(ply:GetEyeTraceNoCursor().HitPos + Vector(0, 0, 10))
		end)
		concommand.Add("UD_Dev_EditMap_RemoveSpawnPoint", function(ply, command, args)
			if not ply:IsAdmin() or not ply:IsPlayer() then return end
			GAMEMODE:RemoveSpawnPoint(tonumber(args[1]))
		end)
		concommand.Add("UD_Dev_EditMap_UpdateSpawnPoint", function(ply, command, args)
			if not ply:IsAdmin() or not ply:IsPlayer() then return end
			if args[1] and GAMEMODE.MapEntities.NPCSpawnPoints[tonumber(args[1])] then
				GAMEMODE:UpdateSpawnPoint(tonumber(args[1]), nil, Angle(0, tonumber(args[5]), 0), args[2], tonumber(args[3]), tonumber(args[4]))
			end
		end)

		concommand.Add("UD_Dev_EditMap_CreateWorldProp", function(ply, command, args)
			if not ply:IsAdmin() or not ply:IsPlayer() then return end
			local trcEyeTrace = ply:GetEyeTraceNoCursor()
			GAMEMODE:CreateWorldProp(nil, trcEyeTrace.HitPos)
		end)
		concommand.Add("UD_Dev_EditMap_RemoveWorldProp", function(ply, command, args)
			if not ply:IsAdmin() or not ply:IsPlayer() then return end
			GAMEMODE:RemoveWorldProp(tonumber(args[1]))
		end)
		concommand.Add("UD_Dev_EditMap_UpdateWorldProp", function(ply, command, args)
			if not ply:IsAdmin() or not ply:IsPlayer() then return end
			local tblPropTable = GAMEMODE.MapEntities.WorldProps[tonumber(args[1])]
			if args[1] and tblPropTable then
				local vecNewPosition = tblPropTable.Position + VectortizeString(args[3])
				local vecNewAngle = tblPropTable.Angle + Angle(0, tonumber(args[4]), 0)
				GAMEMODE:UpdateWorldProp(tonumber(args[1]), args[2], vecNewPosition, vecNewAngle)
			end
		end)

		concommand.Add("UD_Dev_EditMap_SaveMap", function(ply, command, args)
			if not ply:IsAdmin() or not ply:IsPlayer() then return end
			GAMEMODE:SaveMapObjects()
		end)
	end
elseif CLIENT and game.SinglePlayer() then
	
	net.Receive("UD_UpdateSpawnPoint", function()
		GAMEMODE:UpdateSpawnPoint(net.ReadInt(16), net.ReadVector(), net.ReadAngle(), net.ReadString(), net.ReadInt(16), net.ReadInt(16))
		GAMEMODE.MapEditor.UpatePanel()
	end)
	net.Receive("UD_RemoveSpawnPoint", function()
		GAMEMODE:RemoveSpawnPoint(net.ReadInt(16))
		GAMEMODE.MapEditor.UpatePanel()
	end)
	net.Receive("UD_UpdateWorldProp", function()
		GAMEMODE:UpdateWorldProp(net.ReadInt(16), net.ReadString(), net.ReadVector(), net.ReadAngle(), net.ReadEntity())
		GAMEMODE.MapEditor.UpatePanel()
	end)
	net.Receive("UD_RemoveWorldProp", function()
		GAMEMODE:RemoveWorldProp(net.ReadInt(16))
		GAMEMODE.MapEditor.UpatePanel()
	end)
end
