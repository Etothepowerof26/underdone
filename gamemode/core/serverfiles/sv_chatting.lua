function GM:PlayerCanHearPlayersVoice(pListener, pSpeaker)
	if not IsValid(pSpeaker) or not IsValid(pListener) then return false end --InValid
	local intChatDistance = 1000
	if pSpeaker:GetNWBool("SquadChat") or pListener:GetNWBool("SquadChat") then
		if pListener:IsInSquad(pSpeaker) or pSpeaker:IsInSquad(pListener) then
			intChatDistance = 10000
		else
			intChatDistance = 1000
		end
	end
	if pListener:GetPos():Distance(pSpeaker:GetPos()) >= intChatDistance then return false end --Too Far
	return true --All good :)
end

function GM:PlayerCanSeePlayersChat(strText, bTeamOnly, pListener, pSpeaker)
	if not IsValid(pSpeaker) or not IsValid(pListener) then return false end --InValid
	if bTeamOnly and (not pListener:IsInSquad(pSpeaker) or not pSpeaker:IsInSquad(pListener)) then return false end
	if GAMEMODE.ChatDistance and pListener:GetPos():Distance(pSpeaker:GetPos()) >= GAMEMODE.ChatDistance then return false end --Too Far
	return true
end
