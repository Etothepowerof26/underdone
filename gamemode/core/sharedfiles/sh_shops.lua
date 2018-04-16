local Player = FindMetaTable("Player")

function Player:GetItemBuyPrice(strItem)
	local tblItemTable = ItemTable(strItem)
	if tblItemTable and tblItemTable.SellPrice then
		local intBuyPrice = tblItemTable.SellPrice * 2.7
		intBuyPrice = self:CallSkillHook("price_mod", intBuyPrice)
		return math.floor(intBuyPrice)
	end
end
