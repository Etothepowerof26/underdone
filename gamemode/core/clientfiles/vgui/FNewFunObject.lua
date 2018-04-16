--[[
	+oooooo+-`    `:oyyys+-`    +oo.       /oo-   .oo+-  ooo+`   `ooo+
	NMMhyhmMMm-  omMNyosdMMd:   NMM:       hMM+ `oNMd:  `MMMMy`  yMMMN
	NMM:  .NMMo /MMN:    sMMN`  NMM:       hMMo/dMm/`   `MMMmMs`oMmMMN
	NMMhyhmMNh. yMMm     -MMM:  NMM:       hMMmNMMo     `MMM:mMhMd/MMN
	NMMyoo+/.   /MMN:    sMMN`  NMM:       hMMy:dMMh-   `MMM`:NMN.:MMN
	NMM:         +NMNyosdMMd:   NMMdyyyyy. hMM+ `+NMNo` `MMM` ... :MMN
	+oo.          `:oyyys+-`    +oooooooo` /oo-   .ooo/  ooo`     .oo+  2010
]]

local PANEL = {}

function PANEL:Init()
	self.Color = Color(200, 200, 200, 255)
end

function PANEL:SetColor(clrColor)
	self.Color = clrColor
end

function PANEL:Paint()
	--Prepare to shit out your eyes
	--Meh Curclu Code
	--[[
	local intWidth, intHieght = self:GetWide() - 1, self:GetTall() - 1
	local intOriginX, intOriginY = intWidth / 2, intHieght / 2
	local intA, intB = math.max(intWidth, intHieght), math.min(intWidth, intHieght)
	local intNodes = math.Round((3.14159265 * math.sqrt((math.pow(intA, 2) + math.pow(intB, 2)) / 2)) / (((intA + intB) / 2) / 10)) --I know right :D
	local intDegPerNode = 360 / intNodes
	local intCursorX, intCursorY = self:CursorPos()
	local intLastX, intLastY
	for i = 0, intNodes do
		local intConvertedRad = math.rad(i * intDegPerNode)
		local intAdditive = 0
		local intNewX, intNewY = (math.cos(intConvertedRad) * (intWidth / 2 + intAdditive)) + intOriginX, (math.sin(intConvertedRad) * (intHieght / 2 + intAdditive)) + intOriginY
		if math.sqrt(math.pow(intCursorX - intNewX, 2) + math.pow(intCursorY - intNewY, 2)) < 50 then
			intNewX = intNewX + (intCursorX - intNewX)
			intNewY = intNewY + (intCursorY - intNewY)
		end

		if intLastX and intLastY then
			surface.SetDrawColor(self.Color.r, self.Color.g, self.Color.b, self.Color.a)
			surface.DrawLine(intLastX, intLastY, intNewX, intNewY)
		end
		intLastX, intLastY = intNewX, intNewY
	end]]
	--Otehr thing

	local intWidth, intHieght = self:GetWide(), self:GetTall()
	surface.SetDrawColor(self.Color.r, self.Color.g, self.Color.b, self.Color.a)
	--Draw the ground
	surface.DrawLine(0, intHieght - 1, intWidth, intHieght - 1)
	--Draw Branches
	local function LoadBranch(tblBranch)
		for _, tblLine in pairs(tblBranch or {}) do
			surface.DrawLine(tblLine.StartX, tblLine.StartY, tblLine.StartX + tblLine.EndX, tblLine.StartY - tblLine.EndY)
			LoadBranch(tblLine.Branches or {})
		end
	end
	LoadBranch(self.Branches)
end
vgui.Register("FNewFunObject", PANEL, "Panel")

local function FunExample()
	local frmTestFrame = vgui.Create("DFrame")
	frmTestFrame:SetSize(400, 400)
	frmTestFrame:Center()
	frmTestFrame:SetTitle("Example")
	frmTestFrame:SetDraggable(true)
	frmTestFrame:ShowCloseButton(true)
	frmTestFrame:MakePopup()
		local gphTestGraph = vgui.Create("FNewFunObject", frmTestFrame)
		gphTestGraph:SetPos(5, 25)
		gphTestGraph:SetSize(frmTestFrame:GetWide(), frmTestFrame:GetTall() - 30)
		gphTestGraph:SetColor(Color(50, 255, 50, 255))
		gphTestGraph.Branches = gphTestGraph.Branches or {}
		table.insert(gphTestGraph.Branches, {StartX = gphTestGraph:GetWide() / 2, StartY = gphTestGraph:GetTall(), EndX = math.random(-5, 5), EndY = math.random(10, 50), Branches = {}})
		local function CreateBranches(tblParentBranch)
			local tblBranches = tblParentBranch.Branches
			local intBranches = #tblBranches
			local tblReturnTable = {}
			for _, tblBranchTable in pairs(tblBranches) do
				for i = 1, 3 do
					local intParentX, intParentY = tblBranchTable.StartX + tblBranchTable.EndX, tblBranchTable.StartY - tblBranchTable.EndY
					table.insert(tblBranchTable.Branches, {StartX = intParentX, StartY = intParentY, EndX = math.random(-15, 15), EndY = math.random(10, 50), Branches = {}})
					table.insert(tblReturnTable, tblBranchTable)
				end
			end
			return tblReturnTable
		end
		CreateBranches(gphTestGraph)
		for _, tblBranchTable in pairs(gphTestGraph.Branches) do
			for _, tblBranchTable in pairs(CreateBranches(tblBranchTable)) do
				CreateBranches(tblBranchTable)
			end
		end

end
concommand.Add("FunExample", FunExample)
