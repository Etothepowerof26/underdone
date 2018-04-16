local function DrawItemInfo()
	for _, ent in pairs(ents.FindByClass("prop_*")) do
		//if IsValid(ent) then
			//if ent:GetModel() == "models/props_c17/oildrum001.mdl" then
			//end
		//end
		if IsValid(ent) and ent:GetNWString("PrintName") and ent:GetNWInt("Amount") > 0 then
			if ent:GetPos():Distance(LocalPlayer():GetPos()) < 200 then
				local posENTpos = (ent:GetPos() + Vector(0, 0, 10)):ToScreen()
				local strText = ent:GetNWString("PrintName")
				if ent:GetNWInt("Amount") > 1 then strText = strText .. " x" .. ent:GetNWInt("Amount") end
				if ent:GetOwner() == LocalPlayer() or not IsValid(ent:GetOwner()) or LocalPlayer():IsInSquad(ent:GetOwner()) then
					draw.SimpleTextOutlined(strText, "Default", posENTpos.x, posENTpos.y - 10, clrWhite, 1, 1, 1, clrDrakGray)
					ent:SetColor(255, 255, 255, 255)
				else
					ent:SetColor(255, 255, 255, 0)
				end
			end
			if ent:GetModel() == "models/props/de_inferno/clayoven.mdl" then
				if ent:GetPos():Distance(LocalPlayer():GetPos()) < 200 then
					local posENTpos = (ent:GetPos() + Vector(0, 0, 40)):ToScreen()
					draw.SimpleTextOutlined("Work Bench", "Default", posENTpos.x, posENTpos.y, clrWhite, 1, 1, 1, clrDrakGray)
				end
			end
		end
	end
end
hook.Add("HUDPaint", "DrawItemInfo", DrawItemInfo)
