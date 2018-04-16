local Player = FindMetaTable("Player")

function Player:AddStat(strStat, intAmount)
	self.Stats = self.Stats or {}
	if intAmount ~= 0 then
	local intDirection = math.abs(intAmount) / intAmount
	self:SetStat(strStat, self:GetStat(strStat) + (intDirection * math.ceil(math.abs(intAmount))))
	end
end

function Player:SetStat(strStat, intAmount)
	local tblStatTable = GAMEMODE.DataBase.Stats[strStat]
	self.Stats = self.Stats or {}
	local intOldStat = self.Stats[strStat] or 1
	self.Stats[strStat] = intAmount
	if SERVER then
	if tblStatTable.OnSet then
		tblStatTable:OnSet(self, intAmount, intOldStat)
	end
	SendUsrMsg("UD_UpdateStats", self, {strStat, intAmount})
	end
end

function Player:GetStat(strStat)
	self.Stats = self.Stats or {}
	if self.Stats and self.Stats[strStat] then
	return self.Stats[strStat]
	end
	return StatTable(strStat).Default
end

if SERVER then
	hook.Add("PlayerSpawn", "PlayerSpawn_Stats", function(ply)
	for name, stat in pairs(GAMEMODE.DataBase.Stats) do
		if ply.Stats then
		ply:SetStat(name, ply:GetStat(name))
		if stat.OnSpawn then
			stat:OnSpawn(ply, ply:GetStat(name))
		end
		end
	end
	ply:AddStat("stat_agility", ply.ToMakeUpAgility or 0)
	ply.ToMakeUpAgility = 0
	end)
end

if CLIENT then
	usermessage.Hook("UD_UpdateStats", function(usrMsg)
		if not LocalPlayer().SetStat then return end

	LocalPlayer():SetStat(usrMsg:ReadString(), usrMsg:ReadLong())
	end)
end
