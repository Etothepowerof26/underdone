BaseBook = DeriveTable(BaseItem)
function BaseBook:Use(usr, itemtable)
	if not IsValid(usr) or usr:Health() <= 0 then return end
	if usr:HasReadBook(itemtable.Name) then
		usr:CreateNotification("You have already read this book")
		return
	end
	if itemtable.GainExp then usr:GiveExp(itemtable.GainExp, true) end
	if itemtable.SaveInLibrary then usr:AddBookToLibrary(itemtable.Name) end
	usr:AddItem(itemtable.Name, -1)
end
function BaseBook:LibraryLoad(usr, itemtable)
	if not IsValid(usr) then return end
	usr:ApplyBuffTable(itemtable.GainStats)
end


local Item = QuickCreateItemTable(BaseBook, "book_of_beginning", "Book of Beginning", "Beginners book, by reading this book you will gain Exp", "icons/item_book1")
Item.Model = "models/props_lab/bindergreenlabel.mdl"
if SERVER then Item.Story = "You gained exp from reading this books :D" end
Item.SaveInLibrary = true
Item.GainExp = 25
Item.GainStats = {}
Item.GainStats["stat_maxhealth"] = 5
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_homemadeboom", "Homemade Boom", "Filled with ideas for various dangerous devices", "icons/item_book2")
Item.Model = "models/props_lab/binderblue.mdl"
if SERVER then Item.Story = "Homemade Boom, First edition /n /n Fragmentation grenade /n 1 tin can /n 2 kg of black powder /n 1 explosives pin /n /n Aim divice away from face." end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_homemadegrenade"
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_canofmeat", "Cook Can of Meat", "Basic culinary", "icons/item_book1")
Item.Model = "models/props_lab/binderblue.mdl"
if SERVER then Item.Story = "Learn how to cook some meat" end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_canofmeat"
Item.SellPrice = 200
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_chineesebox", "Craft Chineese Box", "Basic Crafting", "icons/item_book1")
Item.Model = "models/props_lab/binderblue.mdl"
if SERVER then Item.Story = "Learn to craft a chineese box!" end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_package_chineesebox"
Item.SellPrice = 200
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_cooknoodles", "Cook Chineese Noodles", "Learn how to cook Chineese Noodles", "icons/item_book2")
Item.Model = "models/props_lab/binderblue.mdl"
if SERVER then Item.Story = "Learn to cook chineese noodles!" end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_cook_noodles"
Item.SellPrice = 400
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_wooddistilation", "Wood Distillation", "Basic chemistry", "icons/item_book1")
Item.Model = "models/props_lab/binderred.mdl"
if SERVER then
	Item.Story = "You carefully burn wood chips making sure not to let the open flame touch the wood, the condesing liquid is your methonol, and the chared wood is your charcoal. Warning " ..
	"this proses doesn't always produce methonol, take your time you will get better at this."
end
Item.SaveInLibrary = true
Item.GainRecipes = {}
Item.GainRecipes[1] = "recipe_wooddistillation"
Item.SellPrice = 500
Item.Weight = 1
Register.Item(Item)

local Item = QuickCreateItemTable(BaseBook, "book_polkmstail_ep1", "Polkm's Tail Ep1", "Were it all began!", "icons/item_book3")
Item.Model = "models/props_lab/binderblue.mdl"
if SERVER then
	Item.Story = "Once opon a time in the shit hole city of Manhatin a child was borned into this wourld his name was Polkm. Polkm's child hood was ruined by living in Manhatin, He vowed " ..
	"that he would someday get out of Manhatin and into a real city like Boston were he would do real city things like rob banks and sell drugs. 17 years later his wish finally came true " ..
	"he was going to Boston to work for a upcoming commic book company called Garrage Commics. Polkm was now rooting for a real baseball team not the shity yankeys. Work at Garrage Commics " ..
	"was good and stable, he met many cool people and drawed lots of commics. But he would sooon find out that it was not all good back home in shit Manhatin ..."
end
Item.SaveInLibrary = true
Item.Weight = 1
Register.Item(Item)
