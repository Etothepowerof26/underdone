PANEL = {}
PANEL.inventorylist = nil
PANEL.Paperdoll = nil
PANEL.ItemIconPadding = 1
PANEL.ItemIconSize = 39
PANEL.ItemRow = 7

PANEL.AmmoDisplayTable = {}
PANEL.AmmoDisplayTable[1] = {Type = "smg1", PrintName = "Small"}
PANEL.AmmoDisplayTable[2] = {Type = "ar2", PrintName = "Rifle"}
PANEL.AmmoDisplayTable[3] = {Type = "buckshot", PrintName = "Buckshot"}
PANEL.AmmoDisplayTable[4] = {Type = "SniperRound", PrintName = "Sniper"}

function PANEL:Init()
	self.inventorylist = CreateGenericList(self, self.ItemIconPadding, true, true)
	self.inventorylist.DoDropedOn = function()
		if not LocalPlayer().Data.Paperdoll or not GAMEMODE.DraggingPanel or not GAMEMODE.DraggingPanel.IsPapperDollSlot then return end
		if GAMEMODE.DraggingPanel.Item and GAMEMODE.DraggingPanel.Slot then
			if LocalPlayer().Data.Paperdoll[GAMEMODE.DraggingPanel.Slot] == GAMEMODE.DraggingPanel.Item then
				GAMEMODE.DraggingPanel.DoDoubleClick()
			end
		end
	end
	GAMEMODE:AddHoverObject(self.inventorylist)
	GAMEMODE:AddHoverObject(self.inventorylist.pnlCanvas, self.inventorylist)

	self.WeightBar = CreateGenericWeightBar(self, LocalPlayer().Weight or 0, LocalPlayer():GetMaxWeight())
	self.LibraryButton = CreateGenericImageButton(self, "gui/book", "Library", function()
		GAMEMODE.ActiveMenu = nil
		GAMEMODE.ActiveMenu = DermaMenu()
		local ReadSubMenu = GAMEMODE.ActiveMenu:AddSubMenu("Read ...")
		for strBook, _ in pairs(LocalPlayer().Data.Library or {}) do
			ReadSubMenu:AddOption(ItemTable(strBook).PrintName, function() RunConsoleCommand("UD_ReadBook", strBook) end)
			ReadSubMenu.Panels[#ReadSubMenu.Panels]:SetToolTip(ItemTable(strBook).Desc)
		end
		local CraftSubMenu = GAMEMODE.ActiveMenu:AddSubMenu("Craft ...")
		for strRecipe, _ in pairs(LocalPlayer().Recipes or {}) do
			CraftSubMenu:AddOption(RecipeTable(strRecipe).PrintName, function()
				RunConsoleCommand("UD_CraftRecipe", strRecipe)
			end)
			local strToolTip = "Ingredients:"
			for strItem, intAmount in pairs(RecipeTable(strRecipe).Ingredients) do
				strToolTip = strToolTip .. "\n" .. intAmount .. " " .. ItemTable(strItem).PrintName
			end
			strToolTip = strToolTip .. "\n\nProducts:"
			for strItem, intAmount in pairs(RecipeTable(strRecipe).Products) do
				strToolTip = strToolTip .. "\n" .. intAmount .. " " .. ItemTable(strItem).PrintName
			end
			strToolTip = strToolTip .. "\n\nRequirements:"
			if RecipeTable(strRecipe).NearFire then
				strToolTip = strToolTip .. "\nMust be done near fire"
			end
			for strMaster, intLevel in pairs(RecipeTable(strRecipe).RequiredMasters) do
				strToolTip = strToolTip .. "\n" .. intLevel .. " " .. MasterTable(strMaster).PrintName
			end
			CraftSubMenu.Panels[#CraftSubMenu.Panels]:SetToolTip(strToolTip)
			if not LocalPlayer():CanMake(strRecipe) then
				CraftSubMenu.Panels[#CraftSubMenu.Panels]:SetDisabled(true)
				CraftSubMenu.Panels[#CraftSubMenu.Panels]:SetAlpha(100)
			end
		end
		GAMEMODE.ActiveMenu:Open()
	end)

	self.Paperdoll = vgui.Create("FPaperDoll", self)
	self.Paperdoll.Paint = function()
		local tblPaintPanle = jdraw.NewPanel()
		tblPaintPanle:SetDemensions(0, 0, self.Paperdoll:GetWide(), self.Paperdoll:GetTall())
		tblPaintPanle:SetStyle(4, clrGray)
		tblPaintPanle:SetBoarder(1, clrDrakGray)
		jdraw.DrawPanel(tblPaintPanle)
	end

	self.StatsDisplay = CreateGenericList(self, 3, false, false)
	self.StatsDisplay:SetSpacing(0)

	self.AmmoDisplay = CreateGenericList(self, 3, false, false)
	self.AmmoDisplay:SetSpacing(0)

	self:LoadInventory()
end

function PANEL:PerformLayout()
	self.inventorylist:SetPos(0, 20)
	self.inventorylist:SetSize(((self.ItemIconSize + self.ItemIconPadding) * self.ItemRow) + self.ItemIconPadding, self:GetTall() - 20)

	self.WeightBar:SetPos(0, 0)
	self.WeightBar:SetSize(self.inventorylist:GetWide() - self.LibraryButton:GetWide() - 5, 15)
	self.WeightBar:Update(LocalPlayer().Weight or 0)
	self.LibraryButton:SetPos(self.WeightBar:GetWide() + 5, 0)

	self.Paperdoll:SetPos(self.inventorylist:GetWide() + 5, 0)
	self.Paperdoll:SetSize(self:GetWide() - (self.inventorylist:GetWide() + 5), self:GetTall() - 85)

	self.StatsDisplay:SetPos(self.inventorylist:GetWide() + 5, self.Paperdoll:GetTall() + 5)
	self.StatsDisplay:SetSize((self.Paperdoll:GetWide() * 0.60) - 5, self:GetTall() - self.Paperdoll:GetTall() - 5)

	self.AmmoDisplay:SetPos((self.inventorylist:GetWide() + 5) + self.StatsDisplay:GetWide() + 5, self.Paperdoll:GetTall() + 5)
	self.AmmoDisplay:SetSize((self.Paperdoll:GetWide() - self.StatsDisplay:GetWide()) - 5, self:GetTall() - self.Paperdoll:GetTall() - 5)
end

function PANEL:LoadInventory(boolTemp)
	local TempInv = boolTemp or false
	local WorkInv = LocalPlayer().Data.Inventory or {}
	self.inventorylist:Clear()
	if WorkInv["money"] and WorkInv["money"] > 0 then self:AddItem("money", WorkInv["money"]) end
	for item, amount in pairs(WorkInv) do
		if amount > 0 and item ~= "money" then
			self:AddItem(item, amount)
		end
	end

	for name, slotTable in pairs(GAMEMODE.DataBase.Slots) do
		if self.Paperdoll.Slots[slotTable.Name] then
			if LocalPlayer().Data.Paperdoll[slotTable.Name] then
				self.Paperdoll.Slots[slotTable.Name]:SetItem(GAMEMODE.DataBase.Items[LocalPlayer().Data.Paperdoll[slotTable.Name]])
			else
				self.Paperdoll.Slots[slotTable.Name]:SetSlot(slotTable)
			end
		end
	end

	self.StatsDisplay:Clear()
	local tblAddTable = table.Copy(GAMEMODE.DataBase.Stats)
	tblAddTable = table.ClearKeys(tblAddTable)
	table.sort(tblAddTable, function(statA, statB) return statA.Index < statB.Index end)
	for key, stat in pairs(tblAddTable) do
		if LocalPlayer().Stats and not stat.Hide then
			if not LocalPlayer().Stats[stat.Name] then ErrorNoHalt("stat with that name doesn't exist: " .. stat.Name) return end

			local lblNewStat = vgui.Create("DLabel")
			lblNewStat:SetFont("Default")
			lblNewStat:SetColor(clrDrakGray)
			lblNewStat:SetText(stat.PrintName .. " " .. LocalPlayer().Stats[stat.Name])
			lblNewStat:SizeToContents()
			self.StatsDisplay:AddItem(lblNewStat)
		end
	end

	self:ReloadAmmoDisplay()
	self:PerformLayout()
end

function PANEL:ReloadAmmoDisplay()
	self.AmmoDisplay:Clear()
	for _, tblInfo in pairs(self.AmmoDisplayTable) do
		local lblNewAmmoType = vgui.Create("DLabel")
		lblNewAmmoType:SetFont("Default")
		lblNewAmmoType:SetColor(clrDrakGray)
		lblNewAmmoType:SetText(tblInfo.PrintName .. " " .. LocalPlayer():GetAmmoCount(tblInfo.Type))
		lblNewAmmoType:SizeToContents()
		self.AmmoDisplay:AddItem(lblNewAmmoType)
	end
end

function PANEL:AddItem(item, amount)
	local lstAddList = self.inventorylist
	local tblItemTable = GAMEMODE.DataBase.Items[item]
	local intListItems = 1
	if not tblItemTable.Stackable then intListItems = amount or 1 end
	if table.HasValue(LocalPlayer().Data.Paperdoll or {}, item) then intListItems = intListItems - 1 end
	for i = 1, intListItems do
		local icnItem = vgui.Create("FIconItem")
		icnItem:SetSize(self.ItemIconSize, self.ItemIconSize)
		icnItem:SetItem(tblItemTable, amount)
		icnItem.FromInventory = true
		lstAddList:AddItem(icnItem)
	end
end

vgui.Register("inventorytab", PANEL, "Panel")
