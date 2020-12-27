-- This code is a mess but its basicly a dump for useful functions we cant live with out. (yeH)
local Entity = FindMetaTable("Entity")
local Player = FindMetaTable("Player")

function toExp(level)
	local exp = tonumber(level) or 0
	if exp <= 1 then exp = 0 end
	return math.floor(math.pow(exp * 6, 2))
end

function toLevel(exp)
	if not exp then return end
	local level = math.sqrt(tonumber(exp) or 0)
	return math.floor(math.Clamp(level / 6, 1, level))
end

function Entity:GetLevel()
	if self:IsPlayer() then
		return toLevel(self:GetNWInt("exp"))
	elseif self:IsNPC() then
		return self:GetNWInt("level")
	end
end

function Entity:CreateGrip()
	local Grip = ents.Create("prop_physics")
		Grip:SetModel("models/props_junk/cardboard_box004a.mdl")
		Grip:SetPos(self:GetPos())
		Grip:SetAngles(self:GetAngles())
		Grip:SetCollisionGroup(COLLISION_GROUP_WORLD)
		Grip:SetRenderMode(RENDERMODE_TRANSALPHA)
		Grip:SetColor(Color(0, 0, 0, 0))
	Grip:Spawn()
	self:SetParent(Grip)
	self.Grip = Grip
end

function GetPropClass(strModel)
	local EntClass = "prop_physics"
	if SERVER and strModel and not util.IsValidProp(strModel) then
		EntClass = "prop_dynamic"
	end
	return EntClass
end

function StringatizeVector(vec)
	local Vector_Table = {}
	Vector_Table[1] = math.Round(vec.x * 100) / 100
	Vector_Table[2] = math.Round(vec.y * 100) / 100
	Vector_Table[3] = math.Round(vec.z * 100) / 100
	return table.concat(Vector_Table, "!")
end

function VectortizeString(VectorString)
	local DecodeTable = string.Explode("!", VectorString)
	return Vector(DecodeTable[1] or 0, DecodeTable[2] or 0, DecodeTable[3] or 0)
end

function GetFlushToGround(entEntity)
	local Trace	= {}
	Trace.start	= entEntity:GetPos()
	Trace.endpos = entEntity:GetPos() + (entEntity:GetAngles():Up() * -500)
	Trace.filter = entEntity
	local NewTrace = util.TraceLine(Trace)

	local NewPosition = NewTrace.HitPos - (NewTrace.HitNormal * 512)
	NewPosition = entEntity:NearestPoint(NewPosition)
	NewPosition = entEntity:GetPos() - NewPosition
	NewPosition = NewTrace.HitPos + NewPosition
	return NewPosition
end

function Player:ApplyBuffTable(BuffTable, Multiplier)
	if not SERVER or not BuffTable then return end

	for Skill, Amount in pairs(BuffTable) do
		self:AddStat(Skill, Amount * (Multiplier or 1))
	end
end

function ColorCopy(ToCopy, Alpha)
	return Color(ToCopy.r, ToCopy.g, ToCopy.b, Alpha or ToCopy.a)
end

function GM:NotifyAll(Text)
	for _, ply in ipairs(player.GetAll()) do
		if not ply.CreateNotification then continue end
		
		ply:CreateNotification(Text)
	end
end

if SERVER then
	--SendUsrMsg -> SendNetworkMessage
	function SendNetworkMessage(Name, Target, Args) -- TODO: Replace with net ✓ 
		net.Start(Name)
		for _, value in pairs(Args or {}) do
			if (next(Args) == nil) then return end
		
			if type(value) == "string" then
				net.WriteString(value)
			elseif type(value) == "number" then
				net.WriteInt(value, 16)
			elseif type(value) == "boolean" then
				net.WriteBool(value)
			elseif IsEntity(value) then
				net.WriteEntity(value)
			elseif type(value) == "Vector" then
				net.WriteVector(value)
			elseif type(value) == "Angle" then
				net.WriteAngle(value)
			elseif type(value) == "table" then
				net.WriteString(util.TableToJSON(value))
			end
		end
		net.Send(Target)
	end

	local origin = Vector(0, 0, 0)
	function CreateWorldItem(Item, Amount, Position)
		local ItemTable = ItemTable(Item)
		if not ItemTable then return NULL end -- type correct

		local WorldProp = GAMEMODE:BuildModel(ItemTable.Model)
		if not IsValid(WorldProp) then return NULL end
			WorldProp.Item = Item
			WorldProp.Amount = Amount or 1
			WorldProp:SetPos(Position or origin)
		WorldProp:Spawn()

		WorldProp:SetNWString("PrintName", ItemTable.PrintName)
		WorldProp:SetNWInt("Amount", WorldProp.Amount)

		if not util.IsValidProp(WorldProp:GetModel()) then
			WorldProp:CreateGrip()
		end

		if not ItemTable.QuestItem then
			-- After 15 seconds the item can be picked up by anyone
			-- TODO: config?
			timer.Simple(15 ,function()
				if IsValid(WorldProp) then
					WorldProp:SetOwner(nil)
				end
			end)
		end

		-- Clean up if nobody wants it after a minute
		SafeRemoveEntityDelayed(WorldProp, 60) -- TODO: config?

		return WorldProp
	end

	function Entity:Stun(Time, Severity)
		if self.Resistance and self.Resistance == "Ice" then return end
		if self.UD_BeingSlowed then return end
		
		Time = Time or 3
		Severity = Severity or 0.1

		local TotalTime = 0
		local SlowRate = 0.1
		self.UD_originalColor = self.UD_originalColor or self:GetColor()

		timer.Create("UD_Stun" .. self:EntIndex(), SlowRate, 0, function()
			if not IsValid(self) then return end
			
			if TotalTime < Time then
				self:SetPlaybackRate(Severity)
				TotalTime = TotalTime + SlowRate
			else
				self:SetPlaybackRate(1)
				self.UD_BeingSlowed = false
				if self.UD_originalColor then
					self:SetColor(self.UD_originalColor)
					self.UD_originalColor = nil
				end
				timer.Remove("UD_Stun" .. self:EntIndex())
			end
		end)
		
		self:SetColor(Color(200, 200, 255, 255))
		self.UD_BeingSlowed = true
	end

	function Entity:IgniteFor(Time, Damage, Player)
		if self.Resistance and self.Resistance == "Fire" then return end
		if self.UD_BeingBurned then return end

		Time = Time or 3
		Damage = Damage or 1

		local TotalTime = 0
		local IgnitedRate = 0.35
		local startingHealth = self:Health()
		
		self.UD_originalColor = self.UD_originalColor or self:GetColor()
		
		timer.Create("UD_Burn", IgnitedRate, 0, function()
			if TotalTime < Time then
				if IsValid(Player) then
					Player:CreateIndicator(Damage, self:GetPos(), "red", true)
				end
				
				self:SetNWInt("Health", self:Health())
				self:Ignite(Time, 0) -- Used for the effect
				self:SetHealth(startingHealth - Damage) -- Starts taking damage
				TotalTime = TotalTime + IgnitedRate
			else
				self:Extinguish()
				self.UD_BeingBurned = false
				if self.UD_originalColor then
					self:SetColor(self.UD_originalColor)
					self.UD_originalColor = nil
				end
				timer.Remove("UD_Burn" .. self:EntIndex())
			end
		end)
		self:SetColor(Color(200, 0, 0, 255))
		self.UD_BeingBurned = true
	end

	function GM:RemoveAll(strClass, Time)
		table.foreach(ents.FindByClass(strClass .. "*"), function(_, ent) SafeRemoveEntityDelayed(ent, Time or 0) end)
	end
end

if CLIENT then
	function CreateGenericFrame(strTitle, boolDrag, boolClose)
		local frmNewFrame = vgui.Create("DFrame")
		frmNewFrame:SetTitle(strTitle)
		frmNewFrame:SetDraggable(boolDrag)
		frmNewFrame:ShowCloseButton(boolClose)
		frmNewFrame:SetAlpha(255)
		frmNewFrame.Paint = function( self, w, h )
			draw_Blur( self, 3 )
			draw.RoundedBox( 0, 0, 0, frmNewFrame:GetWide(), frmNewFrame:GetTall(), Color( 0, 0, 0, 100 ) )
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawOutlinedRect( 0, 0, frmNewFrame:GetWide(), frmNewFrame:GetTall() )
		end
		return frmNewFrame
	end

	function CreateGenericList(pnlParent, intSpacing, boolHorz, boolScrollz)
		local pnlNewList = vgui.Create("DPanelList", pnlParent)
		pnlNewList:SetSpacing(intSpacing)
		pnlNewList:SetPadding(intSpacing)
		pnlNewList:EnableHorizontal(boolHorz)
		pnlNewList:EnableVerticalScrollbar(boolScrollz)
		pnlNewList.Paint = function( self, w, h )
			draw_Blur( self, 5 )
			draw.RoundedBox( 0, 0, 0, pnlNewList:GetWide(), pnlNewList:GetTall(), Color( 0, 0, 0, 100 ) )
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawOutlinedRect( 0, 0, pnlNewList:GetWide(), pnlNewList:GetTall() )
		end
		return pnlNewList
	end

	function CreateGenericLabel(pnlParent, strFont, strText, clrColor)	
		local lblNewLabel = vgui.Create("FMultiLabel", pnlParent)
		lblNewLabel:SetFont(strFont or "Default")
		lblNewLabel:SetText(strText or "Default")
		lblNewLabel:SetColor(clrColor or clrWhite)
		return lblNewLabel
	end

	local weight_format = "Weight %d/%d"
	function CreateGenericWeightBar(Parent, Weight, MaxWeight)
		local WeightBar = vgui.Create("FPercentBar", Parent)
		WeightBar:SetMax(MaxWeight)
		WeightBar:SetValue(Weight)
		WeightBar:SetText(string.format(weight_format, Weight, MaxWeight))

		function WeightBar:Update(NewValue)
			NewValue = tonumber(NewValue) or 0

			WeightBar:SetValue(NewValue)
			WeightBar:SetText(string.format(weight_format, NewValue, self:GetMax()))
		end

		return WeightBar
	end

	function CreateGenericTabPanel(Parent)
		local TabSheet = vgui.Create("DPropertySheet", Parent)

		function TabSheet:Paint(w, h)
			jdraw.QuickDrawPanel(Tan, 0, 20, w, h - 20)
		end

		function TabSheet:NewTab(Name, PanelObject, Icon, Desc)
			local NewPanel = vgui.Create(PanelObject)
			local tab = self:AddSheet(Name, NewPanel, Icon, false, false, Desc).Tab

			function tab:Paint(w, h)
				local active = TabSheet:GetActiveTab() == self
				local BackColor = active and Tan or Gray

				if active then
					jdraw.QuickDrawPanel(BackColor, 0, 0, w, h - 6)
					draw.RoundedBox(0, 0, h - 8, w, 2, BackColor)
				else
					jdraw.QuickDrawPanel(BackColor, 0, 0, w, h + 2)
					draw.RoundedBox(0, 0, h - 4, w, 2, BackColor)
				end
			end

			return NewPanel
		end

		return TabSheet
	end

	function CreateGenericListItem(intHeaderSize, strNameText, strDesc, strIcon, clrColor, boolExpandable, boolExpanded)
		local lstNewListItem = vgui.Create("FListItem")
		lstNewListItem:SetHeaderSize(intHeaderSize)
		lstNewListItem:SetNameText(strNameText)
		lstNewListItem:SetDescText(strDesc)
		lstNewListItem:SetIcon(strIcon)
		lstNewListItem:SetColor(clrColor)
		lstNewListItem:SetExpandable(boolExpandable)
		lstNewListItem:SetExpanded(boolExpanded)
		return lstNewListItem
	end
	
	function CreateGenericSlider(pnlParent, strText, intMin, intMax, intDecimals, strConVar)
		local nmsNewNumSlider = vgui.Create("DNumSlider", pnlParent)
		nmsNewNumSlider:SetText(strText)
		nmsNewNumSlider:SetMin(intMin)
		nmsNewNumSlider:SetMax(intMax or intMin)
		nmsNewNumSlider:SetDecimals(intDecimals or 0)
		nmsNewNumSlider:SetConVar(strConVar)
		nmsNewNumSlider.TextArea:SetTextColor( Color( 255, 255, 255, 255 ) )
		return nmsNewNumSlider
	end

	function CreateGenericCheckBox(pnlParent, strText, strConVar)
		local ckbNewCheckBox = vgui.Create( "DCheckBoxLabel", pnlParent)
		ckbNewCheckBox:SetText(strText)
		ckbNewCheckBox:SetConVar(strConVar)
		ckbNewCheckBox:SizeToContents()
		return ckbNewCheckBox
	end

	function CreateGenericImageButton(Parent, Image, ToolTip, Callback)
		local NewButton = vgui.Create("DImageButton", Parent)
		NewButton:SetImage(Image)
		NewButton:SetTooltip(ToolTip)
		NewButton:SizeToContents()
		NewButton.DoClick = Callback

		return NewButton
	end

	local shade = Color(0, 0, 0, 100)
	function CreateGenericButton(pnlParent, strText)
		local btnNewButton = vgui.Create("DButton", pnlParent)
		btnNewButton:SetText(strText)
		btnNewButton:SetColor(clrWhite) -- test
		btnNewButton.Paint = function(btnNewButton)
			local clrDrawColor = ColorCopy(clrGray)
			local intGradDir = 1
			if btnNewButton:GetDisabled() then
				clrDrawColor = ColorCopy(clrDarkGray, 100)
			elseif btnNewButton.Depressed/* || btnNewButton:GetSelected()*/ then
				intGradDir = -1
			elseif btnNewButton.Hovered then
			end
			jdraw.QuickDrawPanel(clrDrawColor, 0, 0, btnNewButton:GetWide(), btnNewButton:GetTall())
			jdraw.QuickDrawGrad(Color(0, 0, 0, 100), 0, 0, btnNewButton:GetWide(), btnNewButton:GetTall(), intGradDir)
		end
		return btnNewButton
	end

	function CreateGenericPanel(pnlParent, intX, intY, intWidth, intHieght)
		local pnlNewPanel = vgui.Create("DPanel", pnlParent)
		pnlNewPanel:SetPos(intX, intY)
		pnlNewPanel:SetSize(intWidth, intHieght)
		pnlNewPanel.Paint = function()
			jdraw.QuickDrawPanel(clrTan, 0, 0, pnlNewPanel:GetWide(), pnlNewPanel:GetTall())
		end
		return pnlNewPanel
	end

	function CreateGenericMultiChoice(pnlParent, strText, boolEditable)
		local mlcNewMultiChoice = vgui.Create("DMultiChoice", pnlParent)
		mlcNewMultiChoice:SetText(strText or "")
		mlcNewMultiChoice:SetEditable(boolEditable or false)		
		return mlcNewMultiChoice
	end

	function CreateGenericCollapse(Parent, Name, Spacing, HorizontalScrollEnabled)
		local NewCollapseCat = vgui.Create("DCollapsibleCategory", Parent)
		NewCollapseCat:SetLabel(Name)

		NewCollapseCat.List = vgui.Create("DPanelList")
		NewCollapseCat.List:SetAutoSize(true)
		NewCollapseCat.List:SetSpacing(Spacing)
		NewCollapseCat.List:SetPadding(Spacing)
		NewCollapseCat.List:EnableHorizontal(HorizontalScrollEnabled)
		NewCollapseCat:SetContents(NewCollapseCat.List)

		return NewCollapseCat
	end
end
