--[[
	+oooooo+-`    `:oyyys+-`    +oo.       /oo-   .oo+-  ooo+`   `ooo+
	NMMhyhmMMm-  omMNyosdMMd:   NMM:       hMM+ `oNMd:  `MMMMy`  yMMMN
	NMM:  .NMMo /MMN:    sMMN`  NMM:       hMMo/dMm/`   `MMMmMs`oMmMMN
	NMMhyhmMNh. yMMm     -MMM:  NMM:       hMMmNMMo     `MMM:mMhMd/MMN
	NMMyoo+/.   /MMN:    sMMN`  NMM:       hMMy:dMMh-   `MMM`:NMN.:MMN
	NMM:         +NMNyosdMMd:   NMMdyyyyy. hMM+ `+NMNo` `MMM` ... :MMN
	+oo.          `:oyyys+-`    +oooooooo` /oo-   .ooo/  ooo`     .oo+  2009
]]

local PANEL = {}
PANEL.Slots = {}
PANEL.ItemIconSize = 39

function PANEL:Init()
	for _, slotTable in pairs(GAMEMODE.DataBase.Slots) do
		local icnItem = vgui.Create("FIconItem", self)
		icnItem:SetSize(self.ItemIconSize, self.ItemIconSize)
		icnItem:SetSlot(slotTable)
		icnItem.FromInventory = true
		self.Slots[slotTable.Name] = icnItem
	end
	self.ArmorRatingLabel = CreateGenericLabel(self, "Default", "Total Armor " .. LocalPlayer():GetArmorRating(), clrDrakGray)
end

function PANEL:PerformLayout()
	for name, icnItem in pairs(self.Slots) do
		local tblSlotTable = GAMEMODE.DataBase.Slots[name]
		local intX = (self:GetWide() * (tblSlotTable.Position.x / 100)) - (self.ItemIconSize / 2)
		local intY = (self:GetTall() * (tblSlotTable.Position.y / 100)) - (self.ItemIconSize / 2)
		icnItem:SetPos(intX, intY)
	end
	if IsValid(self.ArmorRatingLabel) then
		self.ArmorRatingLabel:SetPos(3, self:GetTall() - 15)
		self.ArmorRatingLabel:SetSize(self:GetWide() - 10, 15)
	end
end

function PANEL:Think()
	if IsValid(self.ArmorRatingLabel) then
		self.ArmorRatingLabel:SetText("Total Armor " .. LocalPlayer():GetArmorRating())
	end
end
vgui.Register("FPaperDoll", PANEL, "Panel")
