concommand.Add("UD_InvitePlayer", function(ply, command, args)
	local plyPlayer = player.GetByID(tonumber(args[1]))
	if not IsValid(ply) or not IsValid(plyPlayer) then return false end
	if #(ply.Squad or {}) >= 5 then return false end
	plyPlayer:UpdateInvites(ply, 1)
end)
concommand.Add("UD_KickSquadPlayer", function(ply, command, args)
	local plyPlayer = player.GetByID(tonumber(args[1]))
	if not IsValid(ply) or not IsValid(plyPlayer) then return false end
	if ply:GetNWEntity("SquadLeader") ~= ply or not ply:IsInSquad(plyPlayer) then return end
	plyPlayer:SetNWEntity("SquadLeader", plyPlayer)
	timer.Simple(0.5, function()
		for _, plyPlayer in pairs(player.GetAll()) do
			plyPlayer:UpdateSquadTable()
		end
	end)
end)
concommand.Add("UD_LeaveSquad", function(ply, command, args)
	if not IsValid(ply) then return false end
	ply:SetNWEntity("SquadLeader", ply)
	timer.Simple(0.5, function()
		for _, plyPlayer in pairs(player.GetAll()) do
			plyPlayer:UpdateSquadTable()
		end
	end)
end)
concommand.Add("UD_AcceptInvite", function(ply, command, args)
	local plyInviter = player.GetByID(tonumber(args[1]))
	if not IsValid(ply) or not IsValid(plyInviter) then return false end
	if not ply.Invites[plyInviter] == 1 then return end
	plyInviter:SetNWEntity("SquadLeader", plyInviter)
	ply:SetNWEntity("SquadLeader", plyInviter)
	ply:UpdateInvites(plyInviter, 0)
	timer.Simple(0.5, function()
		for _, plyPlayer in pairs(player.GetAll()) do
			plyPlayer:UpdateSquadTable()
		end
	end)
end)
