//Variables

local meta = FindMetaTable( "Player" )
if not meta then return end

//Functions

function AsrIsRecordedSID(steamid)
	for _, v in pairs(asr_data) do
		if v["steamid"] == steamid then
			return true
		end
	end

	return false
end

function meta:AsrIsRecorded()
	return AsrIsRecordedSID(self:SteamID())
end

function AsrIsGroupMemberSID(steamid)
	for _, v in pairs(asr_data) do
		if v["steamid"] == steamid then
			if v["groupmember"] == 1 then
				return true
			end

			break
		end
	end

	return false
end

function meta:AsrIsGroupMember()
	return AsrIsGroupMemberSID(self:SteamID())
end

function AsrIsAdvertiserSID(steamid)
	for _, v in pairs(asr_data) do
		if v["steamid"] == steamid then
			if v["advertiser"] == 1 then
				return true
			end

			break
		end
	end

	return false
end

function meta:AsrIsAdvertiser()
	return AsrIsAdvertiserSID(self:SteamID())
end

function AsrRefersSID(steamid)
	local plyrefers = 0

	for _, v in pairs(asr_data) do
		if v["steamid"] == steamid then
			plyrefers = v["refers"]

			break
		end
	end

	return plyrefers
end

function meta:AsrRefers()
	return AsrRefersSID(self:SteamID())
end

function AsrReferrerSID(steamid)
	for _, v in pairs(asr_data) do
		if v["steamid"] == steamid then
			if v["referrer"] != "" then
				return v["referrer"]
			end

			break
		end
	end

	return false
end

function meta:AsrReferrer()
	return AsrReferrerSID(self:SteamID())
end

function AsrReferCodeSID(steamid)
	for _, v in pairs(asr_data) do
		if v["steamid"] == steamid then
			return v["refercode"]
		end
	end

	return false
end

function meta:AsrReferCode()
	return AsrReferCodeSID(self:SteamID())
end

function AsrSIDFromCode(refercode)
	for _, v in pairs(asr_data) do
		if v["refercode"] == refercode then
			return v["steamid"]
		end
	end

	return false
end

function AsrNickSID(steamid)
	for _, v in pairs(asr_data) do
		if v["steamid"] == steamid then
			return v["nick"]
		end
	end

	return false
end

function meta:AsrNick()
	return AsrNickSID(self:SteamID())
end

function AsrReferredPlayersSID(steamid, name)
	local referredTbl = {}

	for _, v in pairs(asr_data) do
		if v["referrer"] == steamid then
			if name then
				table.insert(referredTbl, v["nick"])
			else
				table.insert(referredTbl, v["steamid"])
			end
		end
	end

	if #referredTbl > 0 then
		return referredTbl
	else
		return false
	end
end

function meta:AsrReferredPlayers(name)
	return AsrReferredPlayersSID(self:SteamID(), name)
end
