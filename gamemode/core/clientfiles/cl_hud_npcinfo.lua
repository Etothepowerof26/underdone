local strIcon = Material("icon16/emoticon_smile.png")

local function DrawNPCIcon(entNPC, posNPCPos)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(strIcon)
	surface.DrawTexturedRect(posNPCPos.x, posNPCPos.y - 25, 16, 16)
end

local function DrawNameText(entNPC, posNPCPos, boolFriendly)
	local tblNPCTable = NPCTable(entNPC:GetNWInt("npc"))
	local intLevel = entNPC:GetNWInt("level")
	local plylevel = math.Clamp(LocalPlayer():GetLevel(),0,9999)
	local clrDrawColor = clrWhite
	if intLevel < plylevel then clrDrawColor = clrGreen end
	if intLevel > plylevel then clrDrawColor = clrRed end
	if boolFriendly then clrDrawColor = clrWhite end
	local strTitle = tblNPCTable.Title or ""
	if tblNPCTable.Shop then
		local tbl = ShopTable(tblNPCTable.Shop)
		if tbl then
			strTitle = tbl.PrintName
		end
	end
	draw.SimpleTextOutlined(strTitle, "Default", posNPCPos.x, posNPCPos.y - 20, clrDrawColor, 1, 1, 1, clrDrakGray)
	local strDrawText = tblNPCTable.PrintName
	if not boolFriendly and not entNPC:IsBuilding() then strDrawText = strDrawText .. " lv. " .. intLevel end
	draw.SimpleTextOutlined(strDrawText, "Default", posNPCPos.x, posNPCPos.y - 10, clrDrawColor, 1, 1, 1, clrDrakGray)
	if boolFriendly then
		surface.SetFont("Default")
		local wide1, high1 = surface.GetTextSize(strTitle)
		local wide2, high2 = surface.GetTextSize(strDrawText)
		posNPCPos.x = posNPCPos.x + (math.Max(wide1, wide2) / 2) + 5
		DrawNPCIcon(entNPC, posNPCPos)
	end
end

local function DrawNPCHealthBar(entNPC, posNPCPos)
	local clrBarColor = clrGreen
	local intHealth = math.Clamp(entNPC:Health(),0,9999)
	local intMaxHealth = entNPC:GetNWInt("MaxHealth")
	if intHealth <= (intMaxHealth * 0.2) then clrBarColor = clrRed end
	local NpcHealthBar = jdraw.NewProgressBar()
	NpcHealthBar:SetDemensions(posNPCPos.x  - (80 / 2), posNPCPos.y, 80, 11)
	NpcHealthBar:SetStyle(4, clrBarColor)
	NpcHealthBar:SetBoarder(1, clrDrakGray)
	NpcHealthBar:SetText("Default", intHealth, clrDrakGray)
	NpcHealthBar:SetValue(intHealth, intMaxHealth)
	jdraw.DrawProgressBar(NpcHealthBar)
end

local function DrawNPCInfo()
	for _, ent in pairs(ents.GetAll()) do
		if IsValid(ent) and (ent:IsNPC() or ent:IsBuilding()) and ent:GetNWInt("level") > 0 then
			if ent:GetPos():Distance(LocalPlayer():GetPos()) < 500 then
				local tblNPCTable = NPCTable(ent:GetNWInt("npc"))
				if not tblNPCTable then return end
				local boolFriendly = tblNPCTable.Race == "human"
				local posNPCPos = (ent:GetPos() + Vector(0, 0, 80)):ToScreen()
				DrawNameText(ent, posNPCPos, boolFriendly)
				if not boolFriendly then DrawNPCHealthBar(ent, posNPCPos) end
			end
		end
	end
end
hook.Add("HUDPaint", "DrawNPCInfo", DrawNPCInfo)
