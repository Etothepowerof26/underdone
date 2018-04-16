local Item = QuickCreateItemTable(BaseItem, "money", "Money", "It will bring you happy", "icons/item_cash")
Item.Model = "models/props/cs_assault/Money.mdl"
Item.Stackable = true
Register.Item(Item)

local Item = QuickCreateItemTable(BaseItem, "wood", "Wood", "Its wood?", "icons/item_wood")
Item.Model = "models/Gibs/wood_gib01d.mdl"
Item.SellPrice = 7
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseFood, "item_canmeat", "Can of Uncooked Meat", "Needs to be cooked", "icons/junk_metalcan1")
Item.Model = "models/props_junk/garbage_metalcan001a.mdl"
Item.SellPrice = 4
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseFood, "item_cardboard", "Pieace of cardboard", "Its a bit of cardboard used for many things", "icons/junk_metalcan1")
Item.Model = "models/props_junk/garbage_carboard002a.mdl"
Item.SellPrice = 10
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseFood, "item_bagofnoodles", "Bag of Uncooked Noodles", "A bag of uncooked noodles", "icons/junk_metalcan1")
Item.Model = "models/props_junk/garbage_bag001a.mdl"
Item.SellPrice = 20
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseFood, "item_chineese_box", "Chineese Box", "A Chineese Box of Chineese Noodles.", "icons/junk_metalcan1")
Item.Model = "models/Gibs/wood_gib01d.mdl"
Item.SellPrice = 40
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseFood, "item_firestarting_kit", "Fire Starting Kit", "A Kit to make a fire you can cook on.", "icons/junk_box1")
Item.Model = "models/Gibs/wood_gib01d.mdl"
Item.SellPrice = 40
Item.FireTime = 50
Item.Weight = 1
function Item:Use(usr, itemtable)
	if not IsValid(usr) or usr:Health() <= 0 then return end
	local Wood = ents.Create("prop_physics")
	Wood:SetModel(itemtable.Model)
	Wood:SetPos(usr:EyePos() + (usr:GetAimVector() * 50))
	Wood:Spawn()
	Wood:DropToFloor()
	Wood:Ignite(itemtable.FireTime,0)
	Wood:PhysicsInit(SOLID_VPHYSICS)
	Wood:SetMoveType(MOVETYPE_NONE)
	local Fire = ents.Create("env_fire")
	Fire:SetParent(Wood)
	Fire:SetKeyValue("health", itemtable.FireTime)
	Fire:SetKeyValue("firesize", "0.1")
	Fire:SetPos(Wood:GetPos())
	Fire:Spawn()
	timer.Simple(itemtable.FireTime, function() Wood:Remove() Fire:Remove() end)
	usr:AddItem(itemtable.Name, -1)
end
Register.Item(Item)

local Item = QuickCreateItemTable(BaseFood, "item_spoilednoodles", "Spoiled Chineese Noodles", "A Chineese Box of Spoiled Chineese Noodles.", "icons/junk_metalcan1")
Item.Model = "models/props_junk/garbage_takeoutcarton001a.mdl"
Item.SellPrice = 60
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseFood, "item_package", "Package", "A package you can put food in.", "icons/junk_metalcan1")
Item.Model = "models/props_junk/garbage_takeoutcarton001a.mdl"
Item.SellPrice = 40
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseItem, "item_trade_tincan", "Tin Can", "Rusty and old, black stuff in the bottom", "icons/junk_metalcan2")
Item.Model = "models/props_junk/garbage_metalcan002a.mdl"
Item.SellPrice = 10
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseItem, "item_trade_methanol", "Methanol", "This is a cool fuel source", "icons/Quest_ZombieBlood")
Item.Model = "models/props_junk/garbage_metalcan001a.mdl"
Item.SellPrice = 25
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseItem, "item_trade_fuel", "Fuel", "Used in many aplications for a flamable combustant.", "icons/Quest_ZombieBlood")
Item.Model = "models/props_junk/metalgascan.mdl"
Item.SellPrice = 80
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseItem, "item_trade_charcoal", "Charcoal", "Not to be confused with coal", "icons/Quest_ZombieBlood")
Item.Model = "models/props_lab/box01a.mdl"
Item.SellPrice = 12
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseItem, "item_trade_blackpowder", "Black Powder", "It's dry and finely ground, what to use it for ...", "icons/Quest_ZombieBlood")
Item.Model = "models/props_lab/box01a.mdl"
Item.SellPrice = 120
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseItem, "item_trade_explosivespin", "Explosives Pin", "Small explosive charge in a pin.", "icons/Quest_ZombieBlood")
Item.Model = "models/props_junk/glassjug01.mdl"
Item.SellPrice = 210
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseItem, "weapon_melee_wrench", "Wrench", "Tool used for making things", "icons/tool_wrench")
Item.Model = "models/props_c17/tools_wrench01a.mdl"
Item.SellPrice = 250
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseItem, "item_trade_antlionblood", "Antlion Blood", "Its yellow, and kida smells like raspberries", "icons/Quest_ZombieBlood")
Item.Model = "models/props_junk/glassjug01.mdl"
Item.SellPrice = 460
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseItem, "item_trade_pliers", "Pliers", "Would be useful for making things", "icons/tool_wrench")
Item.Model = "models/props_c17/tools_pliers01a.mdl"
Item.SellPrice = 500
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseItem, "item_grenade", "Grenade", "Use to throw.", "icons/Quest_ZombieBlood")
Item.Model = "models/props_junk/glassjug01.mdl"
Item.Stackable = true
Item.SellPrice = 40
Item.Weight = 1
function Item:Use(usr, itemtable)
	if not IsValid(usr) or usr:Health() <= 0 then return end
	if (usr.NextNade or CurTime()) > CurTime() then return end
	usr:RestartGesture(ACT_ITEM_THROW)
	local entNade = ents.Create("npc_grenade_frag")
	timer.Simple(1, function()
		if IsValid(entNade) and IsValid(usr) then
			local vecNadePos = usr:EyePos() + (usr:GetAimVector() * 50)
			local intNadeDur = 3
			entNade:SetOwner(usr)
			entNade:Fire("SetTimer", intNadeDur)
			entNade.OverrideDamge = 50
			entNade:SetPos(vecNadePos)
			entNade:SetAngles(usr:EyeAngles())
			entNade:Spawn()
			entNade:GetPhysicsObject():ApplyForceCenter(usr:GetAimVector():GetNormalized() * 600)
		end
	end)
	usr.NextNade = CurTime() + 2
	usr:AddItem(itemtable.Name, -1)
end
Register.Item(Item)
