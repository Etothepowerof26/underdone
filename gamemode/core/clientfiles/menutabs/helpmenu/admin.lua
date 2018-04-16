local tblMapList = {}
tblMapList[1] = "ud_rebellland_beta_02b"
PANEL = {}

function PANEL:Init()
	self.Maplist = vgui.Create("DListView", self)
	self.Maplist:SetMultiSelect(false)
	self.Maplist:AddColumn("Map Name")
	for _, strMapName in pairs(tblMapList) do
		self.Maplist:AddLine(strMapName)
	end
	self.Maplist:SelectFirstItem()

	self.MapSwitchButton = CreateGenericButton(self, "Change Map")
	local btnSwitchButton = self.MapSwitchButton
	btnSwitchButton.DoClick = function(btnSelf)
		RunConsoleCommand("UD_Admin_ChangeMap", self.Maplist:GetSelected()[1]:GetValue(1))
	end
end

function PANEL:PerformLayout()
	self.Maplist:SetPos(0, 0)
	self.Maplist:SetSize(150, 120)
	self.MapSwitchButton:SetPos(0, self.Maplist:GetTall() + 5)
	self.MapSwitchButton:SetSize(self.Maplist:GetWide(), 20)
end
vgui.Register("admintab", PANEL, "Panel")