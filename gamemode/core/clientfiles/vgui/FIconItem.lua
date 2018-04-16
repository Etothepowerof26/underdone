-- Polkm 2015
local PANEL = {}
local matGlossIcon = Material("icons/icon_gloss")
local matBoarderIcon = Material("icons/icon_boarder2")
local matGradiantDown = Material("gui/gradient_down")
PANEL.Icon = nil
PANEL.Text = nil
PANEL.LastClick = 0
PANEL.Draggable = false
PANEL.Item = nil
PANEL.Slot = nil
PANEL.UseCommand = nil
PANEL.LeftMouseDown = false
PANEL.DoClick = function() end
PANEL.DoRightClick = function() end
PANEL.DoDoubleClick = function() end
PANEL.DoDropedOn = function() end
PANEL.OnHover = function() end

function PANEL:Init()
	GAMEMODE:AddHoverObject(self)
	self.OnHover = function()
		surface.PlaySound("UI/buttonrollover.wav")
	end
end

function PANEL:OnMousePressed(mousecode)
	if mousecode == MOUSE_LEFT and self.Draggable then
		timer.Simple(0.1, function()
			if IsValid(self) and self.Draggable and input.IsMouseDown(MOUSE_LEFT) then
				GAMEMODE.DraggingPanel = self
			end
		end)
	end
end

function PANEL:OnMouseReleased(mousecode)
	if mousecode == MOUSE_RIGHT then
		self.DoRightClick()
		if GAMEMODE.DraggingPanel then
			GAMEMODE.DraggingPanel = nil
		end
	end
	if mousecode == MOUSE_LEFT then
		if GAMEMODE.DraggingPanel then
			if GAMEMODE.HoveredIcon then
				GAMEMODE.HoveredIcon.DoDropedOn()
			end
			GAMEMODE.DraggingPanel = nil
		else
			if (SysTime() - self.LastClick) < 0.3 then
				self.DoDoubleClick()
			else
				self.DoClick()
			end
		end
		self.LastClick = SysTime()
	end
end

function PANEL:Paint(w, h)
	local texDrawTexture = self.Icon or matGradiantDown
	surface.SetDrawColor(0, 0, 0, 50)
	if texDrawTexture == self.Icon then
		surface.SetDrawColor(table.Split(self.Color or Color(255, 255, 255, 255)))
	end
	surface.SetMaterial(texDrawTexture)
	surface.DrawTexturedRect(0, 0, w, h)
	if texDrawTexture == self.Icon then
		surface.SetDrawColor(255, 255, 255, 70)
		surface.SetMaterial(matGlossIcon)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(matBoarderIcon)
	surface.DrawTexturedRect(0, 0, w, h)

	if self.Text then
		if tonumber(self.Text) and tonumber(self.Text) >= 1000  then
			local IntAmount = math.Round(tonumber(self.Text) / 1000)
			local strPrefix = "K"
			if IntAmount > 1000 then
				IntAmount = math.Round(tonumber(self.Text) / 1000000)
				strPrefix = "M"
			end
			self.Text = IntAmount .. "" .. strPrefix
		end
		surface.SetFont("DebugFixedSmall")
		local width, tall = surface.GetTextSize(tostring(self.Text))
		surface.SetTextColor(255, 255, 255, 255)
		surface.SetTextPos(w - width - 2, h - tall - 1)
		surface.DrawText(tostring(self.Text))
	end

	-- spawnicon hover effect
	self.OverlayFade = math.Clamp((self.OverlayFade or 0) - RealFrameTime() * 640 * 2, 0, 255)
	if dragndrop.IsDragging() or not self:IsHovered() then return end
	self.OverlayFade = math.Clamp(self.OverlayFade + RealFrameTime() * 640 * 8, 0, 255)

	return true
end

do -- spawnicon hover effect
	local border = 4
	local border_w = 5
	local matHover = Material("gui/sm_hover.png", "nocull")
	local boxHover = GWEN.CreateTextureBorder(border, border, 64 - border * 2, 64 - border * 2, border_w, border_w, border_w, border_w, matHover)

	function PANEL:PaintOver(w, h)
		if self.OverlayFade > 0 then
			boxHover(0, 0, w, h, Color(255, 255, 255, self.OverlayFade))
		end
	end
end

function PANEL:SetIcon(strIconText)
	self.Icon = strIconText and Material(strIconText)
end

function PANEL:SetText(strText)
	self.Text = strText
end

function PANEL:SetDragable(boolDraggable)
	self.Draggable = boolDraggable
end

function PANEL:SetRightClick(fncRightClick)
	self.DoRightClick = fncRightClick
end

function PANEL:SetDoubleClick(fncDoubleClick)
	self.DoDoubleClick = fncDoubleClick
end

function PANEL:SetDropedOn(fncDropedOn)
	self.DoDropedOn = fncDropedOn
end

function PANEL:SetColor(clrColor)
	self.Color = clrColor
end

function PANEL:SetItem(tblItemTable, intAmount, strUseCommand, intCost)
	if not tblItemTable then
		self:SetIcon(nil)
		self:SetText(intAmount or nil)
		self:SetDragable(false)
		self:SetRightClick(function() end)
		self:SetDoubleClick(function() end)
		self:SetTooltip(nil)
		return
	end
	intCost = intCost or 0
	strUseCommand = strUseCommand or "use"
	self.UseCommand = strUseCommand
	intAmount = intAmount or 1
	self:SetDragable(true)
	if tblItemTable.Icon then self:SetIcon(tblItemTable.Icon) end
	if tblItemTable.Stackable and intAmount > 1 then self:SetText(intAmount) end
	if tblItemTable.Name then self.Item = tblItemTable.Name end
	if tblItemTable.Slot then self.Slot = tblItemTable.Slot end
	if strUseCommand == "use" and tblItemTable.Dropable then
		self.DoDropItem = function()
			self:RunPromtAmount(tblItemTable, intAmount, "How many to drop", "UD_DropItem")
		end
	end
	if strUseCommand == "use" and tblItemTable.Giveable then
		self.DoGiveItem = function(plyGivePlayer)
			if tblItemTable.Stackable or intAmount >= 5 then
				GAMEMODE:DisplayPromt("number", "How many to give", function(itemamount)
					RunConsoleCommand("UD_GiveItem", tblItemTable.Name, itemamount, plyGivePlayer:EntIndex())
				end, tblItemTable.Name)
			else
				RunConsoleCommand("UD_GiveItem", tblItemTable.Name, 1, plyGivePlayer:EntIndex())
			end
		end
	end
	if strUseCommand == "use" and tblItemTable.Use then
		self.DoUseItem = function() RunConsoleCommand("UD_UseItem", tblItemTable.Name) end
	end
	if strUseCommand == "buy" then
		self.DoUseItem = function() RunConsoleCommand("UD_BuyItem", tblItemTable.Name) end
	end
	if strUseCommand == "sell" then
		self.DoUseItem = function(intAmountToSell)
			self:RunPromtAmount(tblItemTable, intAmount, "How many to sell", "UD_SellItem", intAmountToSell)
		end
	end
	if strUseCommand == "deposit" then
		self.DoUseItem = function(intAmountToDipostite)
			self:RunPromtAmount(tblItemTable, intAmount, "How many to deposit", "UD_DipostiteItem", intAmountToDipostite)
		end
	end
	if strUseCommand == "withdraw" then
		self.DoUseItem = function(intAmountToWithdraw)
			self:RunPromtAmount(tblItemTable, intAmount, "How many to withdraw", "UD_WithdrawItem", intAmountToWithdraw)
		end
	end
	---------ToolTip---------
	local strTooltip = Format("%s", tblItemTable.PrintName)
	if intAmount and intAmount >= 1000 then strTooltip = Format("%s (x%s)", strTooltip, intAmount) end
	if tblItemTable.Level and tblItemTable.Level > 1 then strTooltip = Format("%s (lv. %s)", strTooltip, tblItemTable.Level) end
	if tblItemTable.Level and tblItemTable.Level > LocalPlayer():GetLevel() then self:SetColor(clrRed) end
	if tblItemTable.Weight and tblItemTable.Weight > 0 then strTooltip = Format("%s (%s Kgs)", strTooltip, tblItemTable.Weight) end
	if tblItemTable.Desc then strTooltip = Format("%s\n%s", strTooltip, tblItemTable.Desc) end
	if tblItemTable.Power then strTooltip = Format("%s\nDamage: %s", strTooltip, tblItemTable.Power) end
	if tblItemTable.NumOfBullets and tblItemTable.NumOfBullets > 1 then strTooltip = Format("%sx%s", strTooltip, tblItemTable.NumOfBullets) end
	if tblItemTable.FireRate then strTooltip = Format("%s (%s)", strTooltip, tblItemTable.Power * tblItemTable.NumOfBullets * tblItemTable.FireRate) end
	if tblItemTable.FireRate then strTooltip = Format("%s\nSpeed: %s", strTooltip, tblItemTable.FireRate) end
	if tblItemTable.ClipSize and tblItemTable.ClipSize >= 0 then strTooltip = Format("%s\nClipsize: %s", strTooltip, tblItemTable.ClipSize) end
	if tblItemTable.Slot and tblItemTable.Slot ~= "slot_primaryweapon" then strTooltip = Format("%s\nSlot: %s", strTooltip, SlotTable(tblItemTable.Slot).PrintName) end
	if tblItemTable.Armor then strTooltip = Format("%s\nArmor: %s", strTooltip, tblItemTable.Armor) end
	for strStat, intAmount in pairs(tblItemTable.Buffs or {}) do
		local tblStatTable = StatTable(strStat)
		strTooltip = Format("%s\n+%s %s", strTooltip, intAmount, tblStatTable.PrintName)
	end
	local tblSetTable = EquipmentSetTable(tblItemTable.Set) or {}
	if tblSetTable.Items then
		strTooltip = Format("%s\n\nSet: %s", strTooltip, tblSetTable.PrintName)
	end
	for _, strItem in pairs(tblSetTable.Items or {}) do
		local tblItemTable = ItemTable(strItem)
		local boolWearing = LocalPlayer():GetSlot(tblItemTable.Slot) == tblItemTable.Name
		if boolWearing then boolWearing = 1 end
		if not boolWearing then boolWearing = 0 end
		strTooltip = Format("%s\n%s/%s %s", strTooltip, tonumber(boolWearing), 1, tblItemTable.PrintName)
	end
	for strStat, intAmount in pairs(tblSetTable.Buffs or {}) do
		local tblStatTable = StatTable(strStat)
		strTooltip = Format("%s\n+%s %s", strTooltip, intAmount, tblStatTable.PrintName)
	end

	if strUseCommand == "buy" and intCost > 0 then strTooltip = Format("%s\n\nBuy For $%s", strTooltip, intCost) end
	if strUseCommand == "sell" and intCost > 0 then strTooltip = Format("%s\n\nSell For $%s", strTooltip, intCost) end
	self:SetTooltip(strTooltip)
	------Double Click------
	if self.DoUseItem then self:SetDoubleClick(self.DoUseItem) end
	-------Right Click-------
	local menuFunc = function()
		GAMEMODE.ActiveMenu = nil
		GAMEMODE.ActiveMenu = DermaMenu()
		if strUseCommand == "use" and tblItemTable.Use and self.DoUseItem then GAMEMODE.ActiveMenu:AddOption("Use", function() self.DoUseItem() end) end
		if strUseCommand == "buy" and self.DoUseItem then GAMEMODE.ActiveMenu:AddOption("Buy", function() self.DoUseItem() end) end
		if strUseCommand == "sell" and intCost > 0 and self.DoUseItem then GAMEMODE.ActiveMenu:AddOption("Sell", function() self.DoUseItem() end) end
		if strUseCommand == "sell" and intCost > 0 and intAmount > 1 then GAMEMODE.ActiveMenu:AddOption("Sell All", function() self.DoUseItem(intAmount) end) end
		if strUseCommand == "deposit" and self.DoUseItem then GAMEMODE.ActiveMenu:AddOption("deposit", function() self.DoUseItem() end) end
		if strUseCommand == "withdraw" and self.DoUseItem then GAMEMODE.ActiveMenu:AddOption("Withdraw", function() self.DoUseItem() end) end
		if strUseCommand == "use" and tblItemTable.Dropable then GAMEMODE.ActiveMenu:AddOption("Drop", function() self.DoDropItem() end) end
		if strUseCommand == "use" and tblItemTable.Giveable and #player.GetAll() > 1 then
			local GiveSubMenu = nil
			for _, player in pairs(player.GetAll()) do
				if player:GetPos():Distance(LocalPlayer():GetPos()) < 250 and player ~= LocalPlayer() then
					GiveSubMenu = GiveSubMenu or GAMEMODE.ActiveMenu:AddSubMenu("Give ...")
					GiveSubMenu:AddOption(player:Nick(), function() self.DoGiveItem(player) end)
				end
			end
		end
		GAMEMODE.ActiveMenu:Open()
	end
	self:SetRightClick(menuFunc)
end

function PANEL:RunPromtAmount(tblItemTable, intAmount, strQuestion, strCommand, intCallAmount)
	if (intAmount >= 5) and not intCallAmount then
		GAMEMODE:DisplayPromt("number", strQuestion, function(intItemAmount)
			RunConsoleCommand(strCommand, tblItemTable.Name, intItemAmount)
		end, intAmount)
	else
		RunConsoleCommand(strCommand, tblItemTable.Name, intCallAmount or 1)
	end
end

function PANEL:SetSlot(tblSlotTable)
	local strToolTip = ""
	if tblSlotTable then
		if tblSlotTable.PrintName then strToolTip = Format("%s", tblSlotTable.PrintName) end
		if tblSlotTable.Desc then strToolTip = Format("%s\n%s", strToolTip, tblSlotTable.Desc) end
	end
	self.IsPapperDollSlot = true
	self:SetDragable(false)
	self:SetIcon(nil)
	self:SetTooltip(strToolTip)
	self:SetDropedOn(function()
		if GAMEMODE.DraggingPanel and GAMEMODE.DraggingPanel.Slot and GAMEMODE.DraggingPanel.Slot == tblSlotTable.Name then
			if GAMEMODE.DraggingPanel.Item and LocalPlayer().Data.Paperdoll[tblSlotTable.Name] ~= GAMEMODE.DraggingPanel.Item then
				GAMEMODE.DraggingPanel.DoDoubleClick()
			end
		end
	end)
	self:SetDoubleClick(function() end)
	self:SetRightClick(function() end)
end

function PANEL:SetSkill(tblSkillTable, intSkillLevel)
	if not tblSkillTable then return false end
	local strToolTip = ""
	if tblSkillTable.PrintName then strToolTip = Format("%s", tblSkillTable.PrintName) end
	if tblSkillTable.Desc["SkillNeeded"] then strToolTip = Format("%s\n%s", strToolTip, "Skill Needed: " .. tblSkillTable.Desc["SkillNeeded"]) end
	if tblSkillTable.Desc["story"] then strToolTip = Format("%s\n%s", strToolTip, tblSkillTable.Desc["story"]) end
	if tblSkillTable.Desc[intSkillLevel] then strToolTip = Format("%s\n%s", strToolTip, tblSkillTable.Desc[intSkillLevel]) end
	if tblSkillTable.Desc[intSkillLevel + 1] and tblSkillTable.Desc[intSkillLevel] then strToolTip = Format("%s\n\n%s", strToolTip, "Next Level") end
	if tblSkillTable.Desc[intSkillLevel + 1] then strToolTip = Format("%s\n%s", strToolTip, tblSkillTable.Desc[intSkillLevel + 1]) end
	self:SetTooltip(strToolTip)
	self:SetIcon(tblSkillTable.Icon or nil)
	self:SetText((intSkillLevel or 0) .. "/" .. tblSkillTable.Levels)
	self:SetDragable(false)

	self:SetDoubleClick(function() RunConsoleCommand("UD_BuySkill", tblSkillTable.Name) end)
end
vgui.Register("FIconItem", PANEL, "Panel")
