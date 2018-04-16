local strIcon = Material("gui/player")

local function DrawPlayerInfo()
	for _, ply in pairs(player.GetAll()) do
		if IsValid(ply) and LocalPlayer() ~= ply then
			if ply:GetPos():Distance(LocalPlayer():GetPos()) < 200 then
				if not ply:IsPlayer() then return end
				local posPlayerPos = (ply:GetPos() + Vector(0, 0, 80)):ToScreen()
				local strDisplayText = ply:Nick() .. " lv." ..  ply:GetLevel()
				surface.SetFont("Default")
				local wide, high = surface.GetTextSize(strDisplayText)
				draw.SimpleTextOutlined(strDisplayText, "Default", posPlayerPos.x, posPlayerPos.y, clrWhite, 1, 1, 1, clrDrakGray)
				if ply:IsAdmin() then strIcon = "gui/admin" end
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetMaterial(strIcon)
				surface.DrawTexturedRect(posPlayerPos.x + (wide / 2) + 5, posPlayerPos.y - 8, 16, 16)
			end
		end
	end

end
hook.Add("HUDPaint", "DrawPlayerInfo", DrawPlayerInfo)
