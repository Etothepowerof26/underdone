local Player = FindMetaTable("Player")

function Player:UseItem(strItem)
	local tblItemTable = ItemTable(strItem)
	if tblItemTable and tblItemTable.Use and self:HasItem(strItem) then
		tblItemTable:Use(self, tblItemTable)
		return true
	end
	return false
end
concommand.Add("UD_UseItem", function(ply, command, args)
	ply:UseItem(tostring(args[1]))
end)

function Player:DropItem(strItem, intAmount)
	local tblItemTable = ItemTable(strItem)
	if self:HasItem(strItem, intAmount) and tblItemTable.Dropable then
		local vecPostion = self:EyePos() + (self:GetAimVector() * 25)
		local trace = self:GetEyeTrace()
		if trace.HitPos:Distance(self:GetPos()) < 80 then  vecPostion = trace.HitPos end
		local entDropedItem = CreateWorldItem(strItem, intAmount, vecPostion)
		--entDropedItem:SetOwner(self)
		self:AddItem(strItem, -intAmount)
		return true
	end
	return false
end
concommand.Add("UD_DropItem", function(ply, command, args)
	local amount = math.Clamp(tonumber(args[2]), 1, ply.Data.Inventory[args[1]]) or 1
	ply:DropItem(args[1], amount)
end)

function Player:GiveItem(strItem, intAmount, plyTarget)
	local tblItemTable = ItemTable(strItem)
	if not tblItemTable.Giveable then return false end
	plyTarget:TransferItem(self, strItem, intAmount)
	plyTarget:CreateNotification(self:Nick() .. " Gave you " .. tostring(math.Round(intAmount)) .. " " .. tblItemTable.PrintName)
end
concommand.Add("UD_GiveItem", function(ply, command, args) ply:GiveItem(args[1], args[2], player.GetByID(tonumber(args[3]))) end)
