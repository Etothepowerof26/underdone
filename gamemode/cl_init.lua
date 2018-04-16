--------Includes---------
include('shared.lua')
include('core/sharedfiles/database/items/sh_items_base.lua')
include('core/sh_resource.lua')
local Player = FindMetaTable("Player")
-------------------------
-------------------------
GM.TranslateColor = {}
GM.TranslateColor["green"] = clrGreen
GM.TranslateColor["orange"] = clrOrange
GM.TranslateColor["purple"] = clrPurple
GM.TranslateColor["blue"] = clrBlue
GM.TranslateColor["red"] = clrRed
GM.TranslateColor["tan"] = clrTan
GM.TranslateColor["white"] = clrWhite
function GM:GetColor(strColorName)
	local clrTranslated = GAMEMODE.TranslateColor[strColorName]
	if clrTranslated then return clrTranslated end
	return clrWhite
end

function GM:HUDDrawScoreboard()
	return false
end

function GM:Tick()
	if LocalPlayer() and not LocalPlayer().Data then LocalPlayer().Data = {} end
end

function Player:PlaySound(args)
	if not IsValid(self) then return end
	if args[1] then
		surface.PlaySound( args[1] )
	end
	if args[2] then
		surface.PlaySound( args[2] )
	end
end
concommand.Add("UD_PlaySound", function(ply, command, args)
	ply:PlaySound(args)
end)

RunConsoleCommand("cl_phys_props_max", "99999")

--[[
local intMaxHieght = 75
local intMinHieght = 5
local intDirection = 0.08
local intLastHieght = intMinHieght
hook.Add("PrePlayerDraw", "DrawTest", function(ply)
	render.SetMaterial(Material("Effects/bluelaser1"))
	local intNodes = 30
	render.StartBeam(intNodes)
	local intDegPerNode = 360 / (intNodes - 1)
	local vecFirstPos
	for i = 1, intNodes - 1 do
		local intConvertedRad = math.rad(i * intDegPerNode)
		local vecPos = Vector(ply:GetPos().x + (math.cos(intConvertedRad) * 25), ply:GetPos().y + (math.sin(intConvertedRad) * 25), ply:GetPos().z + intLastHieght)
		vecFirstPos = vecFirstPos or vecPos
		render.AddBeam(vecPos, 16, CurTime(), Color(64, 255, 64, 255))
		if i >= intNodes - 1 then
			render.AddBeam(vecFirstPos, 16, CurTime(), Color(64, 255, 64, 255))
		end
	end
	intLastHieght = intLastHieght + intDirection
	if intLastHieght >= intMaxHieght or intLastHieght <= intMinHieght then intDirection = -intDirection end
	render.EndBeam()
end)]]
