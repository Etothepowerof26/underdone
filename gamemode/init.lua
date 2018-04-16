AddCSLuaFile("shared.lua")
AddCSLuaFile("core/sh_resource.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
include("core/sharedfiles/database/items/sh_items_base.lua")
include("core/sh_resource.lua")

-- TODO: authed isn't always called on things such as after a restart, delayed initial spawn?
function GM:PlayerAuthed(ply)
	ply:LoadGame()
end

-- TODO: likely not needed, shouldn't be called with playerclass?
-- honestly, most of the data should be moved to a playerclass
function GM:PlayerSpawn(ply)
	hook.Run("PlayerLoadout", ply)
	ply:SetModel(ply.Data and ply.Data.Model or "models/player/Group01/male_02.mdl")
end

function GM:PlayerLoadout(ply)
	if not ply.Data or not ply.Data.Paperdoll then return end

	local strPrimaryWeapon = ply.Data.Paperdoll["slot_primaryweapon"]
	if not strPrimaryWeapon then return end

	local tblItemTable = self.DataBase.Items[strPrimaryWeapon]
	if not tblItemTable then return end

	local primary = ply:Give("weapon_primaryweapon")
	if IsValid(primary) then
		primary:SetWeapon(tblItemTable)
	else
		ErrorNoHalt("Failed to create 'weapon_primaryweapon' for " .. ply:Nick())
	end

	return true
end

local useDistSqr = 85^2
local ignoreClasses = {
	weapon_primaryweapon = true
}

function GM:UseKeyPressed(ply)
	local trace = ply:GetEyeTrace()

	-- TODO: hardcoded, room for improvement here
	local hitEnt = trace.Entity
	ply:SearchWorldProp(hitEnt, "models/props/cs_militia/footlocker01_closed.mdl",
	{"money", "wood", "item_canspoilingmeat", "item_orange"}, 1, "models/props/cs_militia/footlocker01_open.mdl")
	ply:SearchQuestProp(hitEnt, "models/props/cs_militia/caseofbeer01.mdl", "quest_beer", 1)
	ply:SearchQuestProp(hitEnt, "models/props_c17/oildrum001.mdl", "quest_oil", 1)

	local vecHitPos = trace.HitPos
	local entLookEnt
	local dist = math.huge

	-- TODO: would be better using the dot product, but I'm not changing behavior for now, just cleanup
	local plyPos = ply:GetPos()
	for _, ent in ipairs(ents.FindInSphere(vecHitPos, 20)) do
		local pos = ent:GetPos()

		if (ent.Item or ent.Shop or ent.Quest or ent.Bank or ent.Auction or ent.Appearance) and not ignoreClasses[ent:GetClass()] and pos:DistToSqr(plyPos) <= useDistSqr then
			local testDist = pos:DistToSqr(vecHitPos)

			if testDist < dist then
				entLookEnt = ent
				dist = testDist
			end
		end
	end

	if not entLookEnt or not entLookEnt:IsValid() then return end
	ply.UseTarget = entLookEnt

	-- TODO: this is pretty awful, should be done with net messages
	if entLookEnt.Item then
		local owner = entLookEnt:GetOwner()

		if (owner == ply or not IsValid(owner) or ply:IsInSquad(owner)) and
			ply:AddItem(entLookEnt.Item, entLookEnt.Amount or 1) then
			if IsValid(entLookEnt:GetParent()) then
				entLookEnt:GetParent():Remove()
			end

			entLookEnt:Remove()
		end
	elseif entLookEnt.Shop then
		ply:ConCommand("UD_OpenShopMenu " .. entLookEnt.Shop)
	elseif entLookEnt.Quest then
		ply:ConCommand("UD_OpenQuestMenu " .. entLookEnt:GetNWString("npc"))
	elseif entLookEnt.Bank then
		ply:ConCommand("UD_OpenBankMenu " .. entLookEnt:EntIndex())
	elseif entLookEnt.Auction then
		ply:ConCommand("UD_OpenAuctionMenu")
	elseif entLookEnt.Appearance then
		ply:ConCommand("UD_OpenAppearanceMenu")
	end
end

function GM:KeyPress(ply, key)
	if key == IN_USE then
		self:UseKeyPressed(ply, key)
	end
end

function GM:PlayerUse(ply, ent)
	return true
end

function GM:ShowHelp(ply)
	ply:ConCommand("UD_OpenHelp")
end
