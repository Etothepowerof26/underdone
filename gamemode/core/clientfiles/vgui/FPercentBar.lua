PANEL = {}
PANEL.Min = 0
PANEL.Max = 1
PANEL.Value = 1
PANEL.Text = ""

function PANEL:Init()
end

function PANEL:Paint()
	self.PercentBar = jdraw.NewProgressBar()
	self.PercentBar:SetDemensions(0, 0, self:GetWide(), self:GetTall())
	self.PercentBar:SetStyle(4, clrBlue)
	self.PercentBar:SetBoarder(1, clrDrakGray)
	self.PercentBar:SetValue(self.Value, self.Max)
	self.PercentBar:SetText("Default", self.Text, clrDrakGray)
	jdraw.DrawProgressBar(self.PercentBar)
end

function PANEL:SetMax(intMax)
	self.Max = intMax
end

function PANEL:SetValue(intValue)
	self.Value = intValue
end
function PANEL:GetValue()
	return self.Value
end

function PANEL:SetText(strText)
	self.Text = strText
end

vgui.Register("FPercentBar", PANEL, "Panel")
