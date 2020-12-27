GM.Name        = "Legacy Underdone"
GM.Author      = "Polkm, Zeni, TwentySix, Q2F2 and Nexeonen"
GM.Email       = "n/a"
GM.Website     = "https://github.com/Nexeonenn/underdone"

GM.MonsterViewDistance = 200
GM.RelationHate        = D_HT
GM.RelationFear        = D_FR
GM.RelationLike        = D_LI
GM.RelationNeutral     = D_NU
GM.AuctionsPerPage     = 20

Register    = {}
GM.DataBase = {}

Gray     = Color(097, 095, 090, 255)
DrakGray = Color(043, 042, 039, 255)
Green    = Color(194, 255, 072, 255)
Orange   = Color(255, 137, 044, 255)
Purple   = Color(135, 081, 201, 255)
Blue     = Color(059, 142, 209, 255)
Red      = Color(191, 075, 037, 255)
Tan      = Color(178, 161, 126, 255)
Cream    = Color(245, 255, 154, 255)
Mooca    = Color(107, 097, 078, 255)
White    = Color(242, 242, 242, 255)

clrBlack = Color(0, 0, 0, 255)
clrLightBlack = Color(28, 32, 36, 255)
clrBrown = Color(127, 51, 0, 255)
clrGray = Color(97, 95, 90, 255)
clrDarkGray = Color(43, 42, 39, 255)
clrGreen = Color(194, 255, 72, 255)
clrGreen2 = Color(120, 230, 110, 255)
clrDarkGreen = Color(0, 160, 0, 255)
clrOrange = Color(255, 137, 44, 255)
clrPurple = Color(135, 81, 201, 255)
clrBlue = Color(59, 142, 209, 255)
clrBlue2 = Color(9, 92, 159, 255)
clrBlue3 = Color(100, 100, 255, 255)
clrTan = Color(178, 161, 126, 255)
clrCream = Color(245, 255, 154, 255)
clrMooca = Color(107, 97, 78, 255)
clrWhite = Color(255, 255, 255, 255)
clrOffWhite = Color(205, 205, 205, 255)
clrYellow = Color(255, 216, 0, 255)
clrRed = Color(191, 75, 37, 255)
clrRed2 = Color(255, 50, 50, 255)
clrBrightYellow = Color(255, 255, 0, 255)
clrBrightRed = Color(255, 0, 0, 255)
clrBrightGreen = Color(0, 255, 0, 255)
clrBrightBlue = Color(0, 0, 255, 255)

GM.DataBase.Items = {}
GM.DataBase.Slots = {}
GM.DataBase.EquipmentSets = {}
GM.DataBase.Stats = {}
GM.DataBase.NPCs = {}
GM.DataBase.Shops = {}
GM.DataBase.Quests = {}
GM.DataBase.Skills = {}
GM.DataBase.Recipes = {}
GM.DataBase.Masters = {}
GM.DataBase.Events = {}
GM.PlayerModels = {}

local StatIndex = 1

function Register.Item(Item) GM.DataBase.Items[Item.Name] = Item end
function Register.Slot(Item) GM.DataBase.Slots[Item.Name] = Item end
function Register.EquipmentSet(EquipmentSet) GM.DataBase.EquipmentSets[EquipmentSet.Name] = EquipmentSet end
function Register.Stat(Item)
	GM.DataBase.Stats[Item.Name] = Item
	GM.DataBase.Stats[Item.Name].Index = StatIndex
	StatIndex = StatIndex + 1
end
function Register.NPC(Item) GM.DataBase.NPCs[Item.Name] = Item end
function Register.Shop(Shop) GM.DataBase.Shops[Shop.Name] = Shop end
function Register.Quest(Quest) GM.DataBase.Quests[Quest.Name] = Quest end
function Register.Skill(Skill) GM.DataBase.Skills[Skill.Name] = Skill end
function Register.Recipe(Recipe) GM.DataBase.Recipes[Recipe.Name] = Recipe end
function Register.Master(Master) GM.DataBase.Masters[Master.Name] = Master end
function Register.Event(Event) GM.DataBase.Events[Event.Name] = Event end

function ItemTable(Item) return GAMEMODE.DataBase.Items[Item] end
function SlotTable(Slot) return GAMEMODE.DataBase.Slots[Slot] end
function EquipmentSetTable(EquipmentSet) return GAMEMODE.DataBase.EquipmentSets[EquipmentSet] end
function StatTable(Stat) return GAMEMODE.DataBase.Stats[Stat] end
function NPCTable(NPC) return GAMEMODE.DataBase.NPCs[NPC] end
function ShopTable(Shop) return GAMEMODE.DataBase.Shops[Shop] end
function QuestTable(Quest) return GAMEMODE.DataBase.Quests[Quest] end
function SkillTable(Skill) return GAMEMODE.DataBase.Skills[Skill] end
function RecipeTable(Recipe) return GAMEMODE.DataBase.Recipes[Recipe] end
function MasterTable(Master) return GAMEMODE.DataBase.Masters[Master] end
function EventTable(Event) return GAMEMODE.DataBase.Events[Event] end

function AddPlayerModel(Model)
	GM.PlayerModels[Model] = true
end

-- Citizen
AddPlayerModel("models/player/group01/male_01.mdl")
AddPlayerModel("models/player/group01/male_02.mdl")
AddPlayerModel("models/player/group01/male_03.mdl")
AddPlayerModel("models/player/group01/male_04.mdl")
AddPlayerModel("models/player/group01/male_05.mdl")
AddPlayerModel("models/player/group01/male_06.mdl")
AddPlayerModel("models/player/group01/male_07.mdl")
AddPlayerModel("models/player/group01/male_08.mdl")
AddPlayerModel("models/player/group01/male_09.mdl")
AddPlayerModel("models/player/group01/female_01.mdl")
AddPlayerModel("models/player/group01/female_02.mdl")
AddPlayerModel("models/player/group01/female_03.mdl")
AddPlayerModel("models/player/group01/female_04.mdl")
AddPlayerModel("models/player/group01/female_06.mdl")

-- Rebel
AddPlayerModel("models/player/group03/male_01.mdl")
AddPlayerModel("models/player/group03/male_02.mdl")
AddPlayerModel("models/player/group03/male_03.mdl")
AddPlayerModel("models/player/group03/male_04.mdl")
AddPlayerModel("models/player/group03/male_05.mdl")
AddPlayerModel("models/player/group03/male_06.mdl")
AddPlayerModel("models/player/group03/male_07.mdl")
AddPlayerModel("models/player/group03/male_08.mdl")
AddPlayerModel("models/player/group03/male_09.mdl")
AddPlayerModel("models/player/group03/female_01.mdl")
AddPlayerModel("models/player/group03/female_02.mdl")
AddPlayerModel("models/player/group03/female_03.mdl")
AddPlayerModel("models/player/group03/female_04.mdl")
AddPlayerModel("models/player/group03/female_06.mdl")
