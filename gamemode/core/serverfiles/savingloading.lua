local Player = FindMetaTable("Player")

function Player:NewGame()
	self:SetNWInt("exp", 0)
	self:AddItem("money", 100)
	self:AddItem("item_smallammo_small", 3)
	self:AddItem("item_healthkit", 2)
	self:AddItem("weapon_melee_axe", 1)
	self:AddItem("weapon_ranged_junkpistol", 1)
	--[[
	self:AddItem("item_canspoilingmeat", 1)
	self:AddItem("weapon_melee_fryingpan", 1)
	self:AddItem("weapon_melee_cleaver", 1)
	self:AddItem("weapon_melee_leadpipe", 1)
	self:AddItem("weapon_melee_circularsaw", 1)
	self:AddItem("weapon_melee_wrench", 1)
	self:AddItem("weapon_melee_knife", 1)
	self:AddItem("weapon_ranged_heavymacgun", 1)
	self:AddItem("weapon_ranged_junksmg", 1)
	self:AddItem("armor_helm_chefshat", 1)
	self:AddItem("armor_helm_junkhelmet", 1)
	self:AddItem("armor_helm_scannergoggles", 1)
	self:AddItem("armor_chest_junkarmor", 1)
	self:AddItem("armor_sheild_cog", 1)
	self:AddItem("armor_sheild_saw", 1)
	]]
	self:SaveGame()
	print("New Game")
end

function Player:LoadGame()
	self.Data = {}
	self.Race = "human"
	-- local Data = {}

	-- Set the player's stats to the default.
	for name, stat in pairs(GAMEMODE.DataBase.Stats) do
		self:SetStat(name, stat.Default)
	end

	-- Load the player's game
	local steamID = string.Replace(self:SteamID(), ":", "!")
	if game.SinglePlayer() or steamID ~= "STEAM_ID_PENDING" then
		local strFileName = "underdone/" .. steamID .. ".txt"
		if file.Exists(strFileName, "DATA") then
			local savedGameData = util.JSONToTable(util.Decompress(file.Read(strFileName)) or "")
			self:SetNWInt("exp", savedGameData.Exp or 0)
			self:SetNWInt("SkillPoints", self:GetDeservedSkillPoints())
			if savedGameData.Skills then
				local tblAllSkillsTable = table.Copy(GAMEMODE.DataBase.Skills)
				tblAllSkillsTable = table.ClearKeys(tblAllSkillsTable)
				table.sort(tblAllSkillsTable, function(statA, statB) return statA.Tier < statB.Tier end)
				for _, tblSkill in pairs(tblAllSkillsTable or {}) do
					if self:CanHaveSkill(tblSkill.Name) and savedGameData.Skills[tblSkill.Name] then
						self:BuySkill(tblSkill.Name, savedGameData.Skills[tblSkill.Name])
					end
				end
			end
			self:SetModel(savedGameData.Model or "models/player/Group01/male_02.mdl")
			self.Data.Model = savedGameData.Model or "models/player/Group01/male_02.mdl"
			if savedGameData.Usergroup then
				self:SetUserGroup(savedGameData.Usergroup)
			end
			self:GiveItems(savedGameData.Inventory)
			for strItem, intAmount in pairs(savedGameData.Bank or {}) do self:AddItemToBank(strItem, intAmount) end
			for slot, item in pairs(savedGameData.Paperdoll or {}) do self:UseItem(item) end
			for strQuest, tblInfo in pairs(savedGameData.Quests or {}) do self:UpdateQuest(strQuest, tblInfo) end
			for strFriends, tblInfo in pairs(savedGameData.Friends or {}) do self:AddFriend(strFriends, tblInfo.Blocked) end
			for strBook, boolRead in pairs(savedGameData.Library or {}) do self:AddBookToLibrary(strBook) end
			for strMaster, intExp in pairs(savedGameData.Masters or {}) do self:SetMaster(strMaster, intExp) end
		else
			self:NewGame()
		end
	end

	-- Finish loading
	self.Loaded = true
	self:SetNWBool("Loaded", true)
	hook.Call("UD_Hook_PlayerLoad", GAMEMODE, self)
	for _, ply in pairs(player.GetAll()) do
		if ply ~= self and ply.Data and ply.Data.Paperdoll then
			for slot, item in pairs(ply.Data.Paperdoll) do
				SendUsrMsg("UD_UpdatePapperDoll", self, {ply, slot, item})
			end
		end
	end
end

function Player:SaveGame()
	if not self.Loaded then return end
	if GAMEMODE.StopSaving then return end
	if not self.Data then return end
	local tblSaveTable = table.Copy(self.Data)
	tblSaveTable.Inventory = {}
	--Polkm: Space saver loop
	for strItem, intAmount in pairs(self.Data.Inventory or {}) do
		if intAmount > 0 then tblSaveTable.Inventory[strItem] = intAmount end
	end
	tblSaveTable.Bank = {}
	for strItem, intAmount in pairs(self.Data.Bank or {}) do
		if intAmount > 0 then tblSaveTable.Bank[strItem] = intAmount end
	end
	tblSaveTable.Quests = {}
	for strQuest, tblInfo in pairs(self.Data.Quests or {}) do
		if tblInfo.Done then
			tblSaveTable.Quests[strQuest] = {Done = true}
		else
			tblSaveTable.Quests[strQuest] = tblInfo
		end
	end
	tblSaveTable.Friends = {}
	for strFriends, tblInfo in pairs(self.Data.Friends or {}) do
		if tblInfo.Blocked then
			tblSaveTable.Friends[strFriends] = {Blocked = true}
		else
			tblSaveTable.Friends[strFriends] = {}
		end
	end
	local strSteamID = string.Replace(self:SteamID(), ":", "!")
	if strSteamID ~= "STEAM_ID_PENDING" then
		local strFileName = "underdone/" .. strSteamID .. ".txt"
		tblSaveTable.Exp = self:GetNWInt("exp")
		file.Write(strFileName, util.Compress(util.TableToJSON(tblSaveTable)))
	end
end

local function PlayerSave(ply) ply:SaveGame() end
hook.Add("PlayerDisconnected", "PlayerSavePlayerDisconnected", PlayerSave)
hook.Add("UD_Hook_PlayerLevelUp", "PlayerSaveUD_Hook_PlayerLevelUp", PlayerSave)
hook.Add("ShutDown", "PlayerSaveShutDown", function() for _, ply in pairs(player.GetAll()) do PlayerSave(ply) end end)
