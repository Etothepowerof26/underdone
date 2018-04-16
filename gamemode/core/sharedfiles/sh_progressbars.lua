if CLIENT then
	local tblProgressBars = {}
	local intBarWidth = 200
	local intBarHieght = 20
	local intStartingX = (ScrW() / 2) - (intBarWidth / 2)
	local intStartingY = ScrH() - intBarHieght - 100
	local intSpacing = 5

	local function DrawProgressBars()
		local intRunningHieght = intStartingY
		for strNocification, tblTimeTable in pairs(tblProgressBars or {}) do
			local tblProgressBar = jdraw.NewProgressBar()
			tblProgressBar:SetDemensions(intStartingX, intRunningHieght, intBarWidth, intBarHieght)
			tblProgressBar:SetStyle(4, clrGreen)
			tblProgressBar:SetBoarder(1, clrDrakGray)
			tblProgressBar:SetValue(tblTimeTable.Running, tblTimeTable.Starting)
			tblProgressBar:SetText("Default", strNocification, clrDrakGray)
			jdraw.DrawProgressBar(tblProgressBar)
			intRunningHieght = intRunningHieght - intBarHieght - intSpacing
		end
	end
	hook.Add("HUDPaint", "DrawProgressBars", DrawProgressBars)

	function AddProgressBar(strNotification, intTime)
		tblProgressBars[strNotification] = {Starting = intTime, Running = intTime}
		for i = 1, intBarWidth do
			timer.Simple(i * (intTime / intBarWidth), function() tblProgressBars[strNotification].Running = tblProgressBars[strNotification].Running - (intTime / intBarWidth) end)
		end
		timer.Simple(intTime, function() tblProgressBars[strNotification] = nil end)
	end
	concommand.Add("UD_AddProgressBar", function(ply, command, args) AddProgressBar(string.gsub(args[1], "_", " "), tonumber(args[2])) end)
end

if SERVER then
	local Player = FindMetaTable("Player")
	function Player:CreateProgressBar(strMessage, intTime)
		if IsValid(self) then
			self:ConCommand("UD_AddProgressBar " .. string.gsub(strMessage, " ", "_") .. " " .. intTime)
		end
	end
end
