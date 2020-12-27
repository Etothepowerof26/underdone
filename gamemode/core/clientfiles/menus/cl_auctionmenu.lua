GM.AuctionMenu = nil
PANEL = {}

function PANEL:Init()
	self.Frame = CreateGenericFrame("", false, true)
	self.Frame.Paint = function() end

	self.TabSheet = CreateGenericTabPanel(self.Frame)
	self.BuyAuctions = self.TabSheet:NewTab("Buy and Sell", "buyauctionstab", "gui/money", "Buy out auctions and create auctions here.")
	self.PlayerAuctions = self.TabSheet:NewTab("Your Auctions", "selfauctions", "gui/arrow_up", "See your own auctions")
	self.PickUpAuction = self.TabSheet:NewTab("Pick up Auctions", "pickupauctionstab", "gui/arrow_up", "Pick up auctions here.")

	btnClose = vgui.Create( "DButton", self.Frame )
	btnClose:SetText("X")
	btnClose:SetTextColor(color_white)
	btnClose.Paint = function(self, w, h)
	if self.hover then
        kcol = Color(math.abs(math.sin(CurTime()*5)*255), 0, 0, 255)
    else
        kcol = Color( 200, 79, 79 )
    end
		draw.RoundedBox( 0, 0, 0, w, h, kcol )
	end
	
	btnClose.OnCursorEntered = function( self )
        self.hover = true
    end
    btnClose.OnCursorExited = function( self )
        self.hover = false
    end
	
	btnClose.DoClick = function(pnlPanel)
		self:SetPos( -self.Frame:GetWide(), self.Frame:GetTall() )
		GAMEMODE.AuctionMenu.Frame:Close()
		GAMEMODE.AuctionMenu = nil
	end
	self.Frame:ShowCloseButton(false)
	self.Frame:MakePopup()
	self:PerformLayout()
end

function PANEL:PerformLayout()
	self.Frame:SetPos(self:GetPos())
	self.Frame:SetSize(self:GetSize())
	btnClose:SetPos(self.Frame:GetWide() - 50, 0)
	btnClose:SetSize(40, 20)

	self.TabSheet:SetPos(5, 5)
	self.TabSheet:SetSize(self.Frame:GetWide() - 10, self.Frame:GetTall() - 10)
end
vgui.Register("auctionmenu", PANEL, "Panel")

concommand.Add("UD_OpenAuctionMenu", function(ply, command, args)
	local npc = ply:GetEyeTrace().Entity
	local NPCTable = NPCTable(npc:GetNWString("npc"))
	if not IsValid(npc) or not NPCTable or not NPCTable.Auction then return end
	RunConsoleCommand("UD_RequestAuctionInfo")
	GAMEMODE.AuctionMenu = GAMEMODE.AuctionMenu or vgui.Create("auctionmenu")
	GAMEMODE.AuctionMenu:SetSize(520, 459)
	GAMEMODE.AuctionMenu:Center()
end)
