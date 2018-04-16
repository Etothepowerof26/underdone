GM.ConVarShowHUD = CreateClientConVar("ud_showhud", 1, true, false)
GM.ConVarShowCrossHair = CreateClientConVar("ud_showcrosshair", 1, true, false)
GM.ConVarCrossHairProngs = CreateClientConVar("ud_crosshairprongs", 4, true, false)
GM.PlayerHUDBarWidth = 300
local intCrossHairAngle = 45
local function fncGetAnglesCos(intAngle, intSize)
	return math.cos(math.rad(intAngle)) * intSize
end
local function fncGetAnglesSin(intAngle, intSize)
	return math.sin(math.rad(intAngle)) * intSize
end
local function fncDrawAngleLine(intPosX, intPosY, intAngle, intSize)
	surface.DrawLine(intPosX, intPosY, intPosX + fncGetAnglesCos(intAngle, intSize), intPosY + fncGetAnglesSin(intAngle, intSize))
end

local squad_leader = Material("icon16/star.png")


function GM:HUDPaint()
	if not GAMEMODE.ConVarShowHUD:GetBool() then return end
	self.PlayerBox = jdraw.NewPanel()
	if LocalPlayer():IsMelee() or not IsValid(LocalPlayer():GetActiveWeapon()) then
		self.PlayerBox:SetDemensions(10, ScrH() - 55, GAMEMODE.PlayerHUDBarWidth, 45)
	else
		self.PlayerBox:SetDemensions(10, ScrH() - 73, GAMEMODE.PlayerHUDBarWidth, 63)
	end
	self.PlayerBox:SetStyle(4, clrTan)
	self.PlayerBox:SetBoarder(1, clrDrakGray)
	self:DrawSkillPoints()
	jdraw.DrawPanel(self.PlayerBox)

	self:DrawHealthBar()
	self:DrawLevelBar()
	if not LocalPlayer():IsMelee() and IsValid(LocalPlayer():GetActiveWeapon()) then self:DrawAmmoBar() end

	self:DrawQuestToDoList()
	local intYOffset = self.PlayerBox.Position.Y
	if LocalPlayer():GetNWInt("SkillPoints") > 0 then intYOffset = intYOffset - 25 end
	self:DrawSquadMembers(10, -1)

	if GAMEMODE.ConVarShowCrossHair:GetBool() then
		local intSize = 4
		local intLines = GAMEMODE.ConVarCrossHairProngs:GetInt()
		local intRate = 0
		local intX = ScrW() / 2.0
		local intY = LocalPlayer():GetEyeTraceNoCursor().HitPos:ToScreen().y
		surface.SetDrawColor(clrGreen)
		intCrossHairAngle = intCrossHairAngle + intRate
		for i = 0, (intLines - 1) do
			fncDrawAngleLine(intX, intY, intCrossHairAngle + ((i / intLines) * 360), intSize)
		end
	end
	if not LocalPlayer():Alive() then
		surface.SetDrawColor(50, 50, 50, 200)
		local intDrawBoxY = ScrH() * 0.1
		surface.DrawRect(0, intDrawBoxY, ScrW(), 100)
		surface.SetDrawColor(10, 10, 10, 150)
		surface.DrawRect(0, intDrawBoxY, ScrW(), 20)
		surface.DrawRect(0, intDrawBoxY + 100 - 20, ScrW(), 20)
		if not LocalPlayer().Respawning then
			LocalPlayer().Respawning = true
			for i = 1, 10 do
				timer.Simple(i, function() RespawnTime = 10 - i end)
			end
			timer.Simple(10, function() LocalPlayer().Respawning = false end)
		end
		draw.DrawText("Respawn in: " .. (RespawnTime or 10) .. " Seconds", "ScoreboardDefaultTitle", ScrW() * 0.5, intDrawBoxY + 35, clrWhite, 1, 1)
	end
end

function GM:DrawQuestToDoList()
	local intYOffset = 20
	local intPadding = 13
	local intQuestNumber = 0
	if not LocalPlayer().Data then return end
	for strQuest, tblInfo in pairs(LocalPlayer().Data.Quests or {}) do
		if LocalPlayer():GetQuest(strQuest) and not LocalPlayer():HasCompletedQuest(strQuest) then
			local tblQuestTable = QuestTable(strQuest)
			local intXOffset = ScrW() - 200
			if intQuestNumber == 0 then
				draw.SimpleTextOutlined("Quest Todo list", "Trebuchet24", intXOffset - 20, intYOffset, clrWhite, 0, 1, 1, clrDrakGray)
				intYOffset = intYOffset + intPadding + 7
			end
			draw.SimpleTextOutlined(tblQuestTable.PrintName, "Trebuchet22", intXOffset, intYOffset, clrWhite, 0, 1, 1, clrDrakGray)
			intYOffset = intYOffset + intPadding + 5
			intXOffset = intXOffset + 20
			for strNPC, intAmount in pairs(tblInfo.Kills or {}) do
				if not NPCTable(strNPC) then return end
				if intAmount < tblQuestTable.Kill[strNPC] then
					draw.SimpleTextOutlined("Kill " .. NPCTable(strNPC).PrintName .. ": " .. intAmount .. "/" .. tblQuestTable.Kill[strNPC], "Trebuchet18", intXOffset, intYOffset, clrWhite, 0, 1, 1, clrDrakGray)
					intYOffset = intYOffset + intPadding
				end
				for _, NPC in pairs(ents.FindByClass("npc_"..strNPC)) do
					if not NPC.HasWayPoint and not LocalPlayer():CanTurnInQuest(strQuest) then
						NPC.HasWayPoint = true
						local vPoint = NPC:GetPos()
						WayPoint = EffectData()
						WayPoint:SetStart( vPoint )
						WayPoint:SetOrigin( vPoint )
						WayPoint:SetEntity(NPC)
						WayPoint:SetScale( 1 )
						util.Effect( "selection_ring", WayPoint )
					end
				end
			end
			for strItem, intAmountNeeded in pairs(tblQuestTable.ObtainItems or {}) do
				local intItemsGot = LocalPlayer():GetItem(strItem) or 0
				local tblItemTable = ItemTable(strItem)
				if intItemsGot < intAmountNeeded then
					draw.SimpleTextOutlined(tblItemTable.PrintName .. ": " .. intItemsGot .. "/" .. intAmountNeeded, "Trebuchet18", intXOffset, intYOffset, clrWhite, 0, 1, 1, clrDrakGray)
					intYOffset = intYOffset + intPadding
					for _,prop in pairs(ents.FindByClass("prop_physics")) do
						if IsValid(prop) and tblItemTable.Model == prop:GetModel() then
							if not prop.HasWayPoint and not LocalPlayer():CanTurnInQuest(strQuest) then
								prop.HasWayPoint = true
								local vPoint = prop:GetPos()
								WayPoint = EffectData()
								WayPoint:SetStart( vPoint )
								WayPoint:SetOrigin( vPoint )
								WayPoint:SetEntity(prop)
								WayPoint:SetScale( 1 )
								util.Effect( "selection_ring", WayPoint )
							end
						end
					end
				end
			end
			if LocalPlayer():CanTurnInQuest(strQuest) then
				draw.SimpleTextOutlined("Done return to npc", "Trebuchet18", intXOffset, intYOffset, clrWhite, 0, 1, 1, clrDrakGray)
				intYOffset = intYOffset + intPadding
			end
			intYOffset = intYOffset + 10
			intQuestNumber = intQuestNumber + 1
		end
	end
end

function GM:DrawSquadMembers(intYOffset, intDirection)
	intDirection = intDirection or 1
	local intPadding = 40
	local intKey = 0
	if #(LocalPlayer().Squad or {}) <= 1 then return end
	for key, plySquadMate in pairs(LocalPlayer().Squad or {}) do
		if not IsValid(plySquadMate) then LocalPlayer().Squad[key] = nil end
		if IsValid(plySquadMate) and plySquadMate ~= LocalPlayer() then
			if plySquadMate ~= LocalPlayer() then
				self:DrawSquadHealthBar(plySquadMate)
			end
			jdraw.QuickDrawPanel(clrTan, 10, intYOffset - (intKey * intPadding * intDirection), 250, intPadding - 5)
			draw.SimpleTextOutlined(plySquadMate:Nick() .. " lv." .. plySquadMate:GetLevel(), "Trebuchet18", 15, intYOffset - (intKey * intPadding * intDirection), clrDrakGray, 0, 0, 0, clrDrakGray)
			jdraw.DrawHealthBar(plySquadMate:Health(), plySquadMate:GetNWInt("MaxHealth"), 15, intYOffset - ((intKey) * intPadding * intDirection) + 17, 250 - 10, 13)
			if plySquadMate == LocalPlayer():GetNWEntity("SquadLeader") then
				jdraw.DrawIcon(squad_leader, 3, intYOffset - 5 - (intKey * intPadding * intDirection), 16)
			end
			intKey = intKey + 1
		end
	end
end

function GM:DrawSquadHealthBar(plySquadMate)
	if plySquadMate:GetPos():Distance(LocalPlayer():GetPos()) < 500 then
		local PosSquadPos = (plySquadMate:GetPos() + Vector(0, 0, 80)):ToScreen()
		jdraw.DrawHealthBar(plySquadMate:Health(), plySquadMate:GetNWInt("MaxHealth"), PosSquadPos.x - (80 / 2), PosSquadPos.y + 8, 80, 11)
	end
end

function GM:DrawSkillPoints()
	if LocalPlayer():GetNWInt("SkillPoints") > 0 then
		self.SkillBar = jdraw.NewProgressBar(self.PlayerBox, true)
		self.SkillBar:SetDemensions(3, -21, 125, 23)
		self.SkillBar:SetStyle(4, clrTan)
		self.SkillBar:SetText("Default", "Unused SkillPoints " .. LocalPlayer():GetNWInt("SkillPoints"), clrDrakGray)
		jdraw.DrawProgressBar(self.SkillBar)
	end
end

function GM:DrawHealthBar()
	local clrBarColor = clrGreen
	if LocalPlayer():GetStat("stat_maxhealth") then
		if LocalPlayer():Health() <= (LocalPlayer():GetStat("stat_maxhealth") * 0.2) then clrBarColor = clrRed end
		self.HealthBar = jdraw.NewProgressBar(self.PlayerBox, true)
		self.HealthBar:SetDemensions(3, 3, self.PlayerBox.Size.Width - 6, 20)
		self.HealthBar:SetStyle(4, clrBarColor)
		self.HealthBar:SetValue(LocalPlayer():Health(), LocalPlayer():GetStat("stat_maxhealth"))
		self.HealthBar:SetText("Default", "Health " .. LocalPlayer():Health(), clrDrakGray)
		jdraw.DrawProgressBar(self.HealthBar)
	end
end

function GM:DrawLevelBar()
	local playerlevel = tonumber(LocalPlayer():GetLevel()) or 0
	local intCurrentLevelExp = toExp(playerlevel)
	local intNextLevelExp = toExp(playerlevel + 1)
	local clrBarColor = clrOrange
	self.LevelBar = jdraw.NewProgressBar(self.PlayerBox, true)
	self.LevelBar:SetDemensions(3, self.HealthBar.Size.Height + 6, self.PlayerBox.Size.Width - 6, 15)
	self.LevelBar:SetStyle(4, clrBarColor)
	self.LevelBar:SetValue(LocalPlayer():GetNWInt("exp") - intCurrentLevelExp, intNextLevelExp - intCurrentLevelExp)
	self.LevelBar:SetText("Default", "Level " .. LocalPlayer():GetLevel(), clrDrakGray)
	jdraw.DrawProgressBar(self.LevelBar)
end

function GM:DrawAmmoBar()
	local entActiveWeapon = LocalPlayer():GetActiveWeapon()
	local intCurrentClip = entActiveWeapon:Clip1()
	local tblWeaponTable = entActiveWeapon.WeaponTable or {}
	local strAmmoType = tblWeaponTable.AmmoType or "none"
	local clrBarColor = clrBlue
	self.AmmoBar = jdraw.NewProgressBar(self.PlayerBox, true)
	self.AmmoBar:SetDemensions(3, self.HealthBar.Size.Height + self.LevelBar.Size.Height + 9, self.PlayerBox.Size.Width - 6, 15)
	self.AmmoBar:SetStyle(4, clrBarColor)
	self.AmmoBar:SetValue(intCurrentClip, tblWeaponTable.ClipSize or 1)
	self.AmmoBar:SetText("Default", "Ammo " .. intCurrentClip .. "  " .. LocalPlayer():GetAmmoCount(strAmmoType), clrDrakGray)
	jdraw.DrawProgressBar(self.AmmoBar)
end

function GM:HUDShouldDraw(name)
	local ply = LocalPlayer()
	if ply and ply:IsValid() then
		local wep = ply:GetActiveWeapon()
		if wep and wep:IsValid() and wep.HUDShouldDraw ~= nil then
			return wep.HUDShouldDraw(wep, name)
		end
	end
	if name == "CHudHealth" or name == "CHudBattery" or name == "CHudAmmo" or name == "CHudSecondaryAmmo" or name == "CHudWeaponSelection" then
		return false
	end
	return true
end
