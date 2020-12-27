GM.HelpMenu = nil
PANEL = {}

function PANEL:Init()
	local helpmenu = vgui.Create( "DFrame" )
	helpmenu:SetSize( ScrW() / 2, ScrH() / 2 )
	helpmenu:SetTitle( "Underdone RPG" )
	helpmenu:MakePopup()
	helpmenu:Center()

	local tabs = vgui.Create( "DPropertySheet", helpmenu )
	tabs:Dock( FILL )

	local tab1panel = vgui.Create( "helptab" )
	local tab2panel = vgui.Create( "optionstab" )
	//if LocalPlayer():IsAdmin() then 
	//local tab3panel = vgui.Create( "admintab" )
	//end
	
	tabs:AddSheet( "Underdone RPG FAQ", tab1panel, "icon16/information.png", false, false, "A Quick Underdone RPG FAQ, More Information Can Be Found On The Wiki By Typing In Chat '/wiki'" )
	tabs:AddSheet( "Underdone RPG Options", tab2panel, "icon16/cog.png", false, false, "Options For Underdone RPG" )
	//if LocalPlayer():IsAdmin() then
	//tabs:AddSheet( "Underdone RPG Admin Options", tab3panel, "icon16/user_suit.png", false, false, "Description of third tab" )
	//end
end
vgui.Register("helpmenu", PANEL, "Panel")

concommand.Add("UD_OpenHelp", function(ply, command, args)
	vgui.Create("helpmenu")
end)
