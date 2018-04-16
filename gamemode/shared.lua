GM.Name     = "underdone"
GM.Author     = "Polkm"
GM.Email     = "polkmpolkmpolkm@gmail.com"
GM.Website     = "@Polkm1"
GM.MaxSlots    = 20

GM.MonsterViewDistance = 200
GM.RelationHate = 1
GM.RelationFear = 2
GM.RelationLike = 3
GM.RelationNeutral = 4
GM.AuctionsPerPage = 20

Register = {}
GM.DataBase = {}

clrGray = Color(97, 95, 90, 255)
clrDrakGray = Color(43, 42, 39, 255)
clrGreen = Color(194, 255, 72, 255)
clrOrange = Color(255, 137, 44, 255)
clrPurple = Color(135, 81, 201, 255)
clrBlue = Color(59, 142, 209, 255)
clrRed = Color(191, 75, 37, 255)
clrTan = Color(178, 161, 126, 255)
clrCream = Color(245, 255, 154, 255)
clrMooca = Color(107, 97, 78, 255)
clrWhite = Color(242, 242, 242, 255)

GM.DataBase.Items = {}
function Register.Item(tblItem) GM.DataBase.Items[tblItem.Name] = tblItem end
function ItemTable(strItem) return GAMEMODE.DataBase.Items[strItem] end

GM.DataBase.Slots = {}
function Register.Slot(tblItem) GM.DataBase.Slots[tblItem.Name] = tblItem end
function SlotTable(strSlot) return GAMEMODE.DataBase.Slots[strSlot] end

GM.DataBase.EquipmentSets = {}
function Register.EquipmentSet(tblEquipmentSet) GM.DataBase.EquipmentSets[tblEquipmentSet.Name] = tblEquipmentSet end
function EquipmentSetTable(strEquipmentSet) return GAMEMODE.DataBase.EquipmentSets[strEquipmentSet] end

GM.DataBase.Stats = {}
local intStatIndex = 1
function Register.Stat(tblItem)
	GM.DataBase.Stats[tblItem.Name] = tblItem
	GM.DataBase.Stats[tblItem.Name].Index = intStatIndex
	intStatIndex = intStatIndex + 1
end
function StatTable(strStat) return GAMEMODE.DataBase.Stats[strStat] end

GM.DataBase.NPCs = {}
function Register.NPC(tblItem) GM.DataBase.NPCs[tblItem.Name] = tblItem end
function NPCTable(strNPC) return GAMEMODE.DataBase.NPCs[strNPC] end

GM.DataBase.Shops = {}
function Register.Shop(tblShop) GM.DataBase.Shops[tblShop.Name] = tblShop end
function ShopTable(strShop) return GAMEMODE.DataBase.Shops[strShop] end

GM.DataBase.Quests = {}
function Register.Quest(tblQuest) GM.DataBase.Quests[tblQuest.Name] = tblQuest end
function QuestTable(strQuest) return GAMEMODE.DataBase.Quests[strQuest] end

GM.DataBase.Skills = {}
function Register.Skill(tblSkill) GM.DataBase.Skills[tblSkill.Name] = tblSkill end
function SkillTable(strSkill) return GAMEMODE.DataBase.Skills[strSkill] end

GM.DataBase.Recipes = {}
function Register.Recipe(tblRecipe) GM.DataBase.Recipes[tblRecipe.Name] = tblRecipe end
function RecipeTable(strRecipe) return GAMEMODE.DataBase.Recipes[strRecipe] end

GM.DataBase.Masters = {}
function Register.Master(tblMaster) GM.DataBase.Masters[tblMaster.Name] = tblMaster end
function MasterTable(strMaster) return GAMEMODE.DataBase.Masters[strMaster] end

GM.DataBase.Events = {}
function Register.Event(tblEvent) GM.DataBase.Events[tblEvent.Name] = tblEvent end
function EventTable(strEvent) return GAMEMODE.DataBase.Events[strEvent] end

function AddPlayerModel(strModel)
	table.insert(GM.PlayerModel, {strModel})
end

GM.PlayerModel = {}
---------Models----------
-- Citizen
AddPlayerModel( "models/player/group01/male_01.mdl" )
AddPlayerModel( "models/player/group01/male_02.mdl" )
AddPlayerModel( "models/player/group01/male_03.mdl" )
AddPlayerModel( "models/player/group01/male_04.mdl" )
AddPlayerModel( "models/player/group01/male_05.mdl" )
AddPlayerModel( "models/player/group01/male_06.mdl" )
AddPlayerModel( "models/player/group01/male_07.mdl" )
AddPlayerModel( "models/player/group01/male_08.mdl" )
AddPlayerModel( "models/player/group01/male_09.mdl" )
AddPlayerModel( "models/player/group01/female_01.mdl" )
AddPlayerModel( "models/player/group01/female_02.mdl" )
AddPlayerModel( "models/player/group01/female_03.mdl" )
AddPlayerModel( "models/player/group01/female_04.mdl" )
AddPlayerModel( "models/player/group01/female_06.mdl" )
AddPlayerModel( "models/player/group01/female_07.mdl" )

-- Rebel
AddPlayerModel( "models/player/group03/male_01.mdl" )
AddPlayerModel( "models/player/group03/male_02.mdl" )
AddPlayerModel( "models/player/group03/male_03.mdl" )
AddPlayerModel( "models/player/group03/male_04.mdl" )
AddPlayerModel( "models/player/group03/male_05.mdl" )
AddPlayerModel( "models/player/group03/male_06.mdl" )
AddPlayerModel( "models/player/group03/male_07.mdl" )
AddPlayerModel( "models/player/group03/male_08.mdl" )
AddPlayerModel( "models/player/group03/male_09.mdl" )
AddPlayerModel( "models/player/group03/female_01.mdl" )
AddPlayerModel( "models/player/group03/female_02.mdl" )
AddPlayerModel( "models/player/group03/female_03.mdl" )
AddPlayerModel( "models/player/group03/female_04.mdl" )
AddPlayerModel( "models/player/group03/female_06.mdl" )
AddPlayerModel( "models/player/group03/female_07.mdl" )
