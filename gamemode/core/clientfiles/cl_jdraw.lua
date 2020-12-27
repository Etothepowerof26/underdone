jdraw = {}
local GradiantDown = Material("gui/gradient_down")
local GradiantUp = Material("gui/gradient_up")

local blur = Material('pp/blurscreen')

function draw_Blur(panel, amount) 
	local x, y = panel:LocalToScreen( 0, 0 )
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( blur )
	for i = 1, 6 do
		blur:SetFloat('$blur', (i / 6) * (amount ~= nil and amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

function jdraw.NewPanel(Parent, CopyStyle)
	local NewPanel = {}
	NewPanel.Position = {}
	NewPanel.Position.X = 0
	if Parent then NewPanel.Position.X = Parent.Position.X end
	NewPanel.Position.Y = 0
	if Parent then NewPanel.Position.Y = Parent.Position.Y end
	NewPanel.Size = {}
	NewPanel.Size.Width = 0
	NewPanel.Size.Height = 0
	function NewPanel:SetDimensions(X, Y, Width, Height)
		if Parent then
			NewPanel.Position.X = Parent.Position.X + X
			NewPanel.Position.Y = Parent.Position.Y + Y
		else
			NewPanel.Position.X = X
			NewPanel.Position.Y = Y
		end
		NewPanel.Size.Width = Width
		NewPanel.Size.Height = Height
	end
	NewPanel.Radius = 0
	if Parent and CopyStyle then NewPanel.Radius = Parent.Radius end
	NewPanel.Color = Color(255, 255, 255, 255)
	if Parent and CopyStyle then NewPanel.Color = Parent.Color end
	function NewPanel:SetStyle(Radius, Color)
		NewPanel.Radius = Radius
		NewPanel.Color = Color
	end
	NewPanel.Border = 0
	if Parent and CopyStyle then NewPanel.Border = Parent.Border end
	NewPanel.BorderColor = Color(255, 255, 255, 255)
	if Parent and CopyStyle then NewPanel.BorderColor = Parent.BorderColor end
	function NewPanel:SetBorder(Border, BorderColor)
		NewPanel.Border = Border
		NewPanel.BorderColor = BorderColor
	end
	return NewPanel
end

function jdraw.DrawPanel(PanelTable)
	local Radius = PanelTable.Radius or 0
	local Border = PanelTable.Border or 0
	local X, Y = PanelTable.Position.X, PanelTable.Position.Y
	local Width, Height = PanelTable.Size.Width, PanelTable.Size.Height
	if PanelTable.Border > 0 then
		draw.RoundedBox(Radius, X, Y, Width, Height, PanelTable.BorderColor)
		draw.RoundedBox(Radius, X + Border, Y + Border, Width - (Border * 2), Height - (Border * 2), PanelTable.Color)
	else
		draw.RoundedBox(Radius, X, Y, Width, Height, PanelTable.Color)
	end
end

function jdraw.NewProgressBar(Parent, CopyStyle)
	local NewPanel = jdraw.NewPanel(Parent, CopyStyle)
	NewPanel.Value = 0
	NewPanel.MaxValue = 0
	function NewPanel:SetValue(Value, MaxValue)
		NewPanel.Value = Value
		NewPanel.MaxValue = MaxValue or 0
	end
	NewPanel.Font = "Default"
	NewPanel.Text = ""
	NewPanel.TextColor = Color(255, 255, 255, 255)
	function NewPanel:SetText(Font, Text, TextColor)
		NewPanel.Font = Font
		NewPanel.Text = Text
		NewPanel.TextColor = TextColor
	end
	return NewPanel
end

function jdraw.DrawProgressBar(PanelTable)
	local Radius = PanelTable.Radius or 0
	local Border = PanelTable.Border or 0
	local X, Y = PanelTable.Position.X, PanelTable.Position.Y
	local Width, Height = PanelTable.Size.Width, PanelTable.Size.Height
	local Value = PanelTable.Value
	local MaxValue = PanelTable.MaxValue
	local BarWidth = ((Width - (Border * 2)) / MaxValue) * Value
	local Text = PanelTable.Text
	if Radius > BarWidth then Radius = 1 end
	draw.RoundedBox(Radius, X, Y, Width, Height, PanelTable.BorderColor)
	draw.RoundedBox(Radius, X + Border, Y + Border, Width  - (Border * 2), Height - (Border * 2), Gray)
	surface.SetDrawColor(0, 0, 0, 70)
	surface.SetMaterial(GradiantDown)
	surface.DrawTexturedRect(X, Y, Width, Height)
	if Value > 0 then
		draw.RoundedBox(Radius, X + Border, Y + Border, BarWidth, Height - (Border * 2), PanelTable.Color)
		surface.SetDrawColor(0, 0, 0, 100)
		surface.SetMaterial(GradiantUp)
		surface.DrawTexturedRect(X + Border, Y + Border, BarWidth, Height - (Border * 2))
	end
	if Text and Text ~= "" then
		draw.SimpleText(Text, PanelTable.Font, X + (Width / 2), Y + (Height / 2), PanelTable.TextColor, 1, 1)
	end
end

function jdraw.DrawHealthBar(Health, MaxHealth, X, Y, Width, Height, PreHealth)
	Health = math.Clamp(Health, 0, math.huge)
	MaxHealth = MaxHealth or 100
	local BarColor = Green
	if Health <= (MaxHealth * 0.2) then BarColor = Red end
	local tblNewHealthBar = jdraw.NewProgressBar()
	tblNewHealthBar:SetDimensions(X, Y, Width, Height)
	tblNewHealthBar:SetStyle(4, BarColor)
	tblNewHealthBar:SetBorder(1, DrakGray)
	tblNewHealthBar:SetText("Default", (PreHealth or "") .. Health, DrakGray)
	tblNewHealthBar:SetValue(Health, MaxHealth)
	jdraw.DrawProgressBar(tblNewHealthBar)
end

function jdraw.DrawIcon(strIcon, X, Y, Width, Height)
	strIcon = strIcon or "gui/player"
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(strIcon)
	surface.DrawTexturedRect(X, Y, Width, Height or Width)
end

function jdraw.QuickDrawPanel(Color, X, Y, Width, Height)
	local NewPanel = jdraw.NewPanel()
	NewPanel:SetDimensions(X, Y, Width, Height or Width)
	NewPanel:SetStyle(4, Color)
	NewPanel:SetBorder(1, DrakGray)
	jdraw.DrawPanel(NewPanel)
end

function jdraw.QuickDrawGrad(Color, X, Y, Width, Height, Dir)
	surface.SetDrawColor(Color)
	surface.SetMaterial(GradiantUp)
	if Dir == -1 then surface.SetMaterial(GradiantDown) end
	surface.DrawTexturedRect(X, Y, Width, Height)
end
