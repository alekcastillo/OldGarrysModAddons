//Variables

local meta = FindMetaTable( "Player" )
if !meta then return end

//Functions

function meta:CheckTime()
	http.Fetch("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key="..ASR.SteamAPIKey.."&steamid="..self:SteamID64().."&format=json", function(body)
		if !self:IsValid() or !self:IsPlayer() then return end

		if body == nil or !body then
			self.Playtime = 0

			return
		end

		local fetchTbl = util.JSONToTable(body)

		if fetchTbl == nil or !fetchTbl then
			self.Playtime = 0

			return
		end

		for _, v in pairs(fetchTbl["response"]["games"]) do
			if v["appid"] == 4000 then
				self.Playtime = v["playtime_forever"] / 60

				break
			end
		end
	end)
end

function meta:CheckShared()
	http.Fetch("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key="..ASR.SteamAPIKey.."&steamid="..self:SteamID64().."&appid_playing=4000&format=json", function(body)
		if !self:IsValid() or !self:IsPlayer() then return end

		if body == nil or !body then
			self.IsGameshared = true

			return
		end

		local fetchTbl = util.JSONToTable(body)

		if fetchTbl == nil or !fetchTbl then
			self.IsGameshared = false

			return
		end

		if fetchTbl["response"]["lender_steamid"] == 1 then
			self.IsGameshared = true
		else
			self.IsGameshared = false
		end
	end)
end

function meta:CheckGroupMember()
	http.Fetch(ASR.SteamGroupLink.."/memberslistxml/?xml=1", function(body)
		if body == nil or !body then
			self.IsGroupMember = false

			return
		end

		local tbl = AsrXMLToTable(body)

		if !tbl then
			self.IsGroupMember = false

			return
		end

		local membersTbl = table.Copy(tbl["memberList"]["members"]["steamID64"])
		local page = 1
		local newPage = true
		local totPages = tonumber(tbl["memberList"]["totalPages"])

		while newPage do
			if page < totPages then
				page = page + 1

				http.Fetch(ASR.SteamGroupLink.."/memberslistxml/?xml=1&p="..page, function(body)
					if body == nil or !body then return end

					local newTbl = AsrXMLToTable(body)
					local newMembersTbl = table.Copy(newTbl["memberList"]["members"]["steamID64"])

					table.Add(membersTbl, newMembersTbl)
				end)
			else
				newPage = false
			end
		end

		timer.Simple(1, function()
			if !self:IsValid() or !self:IsPlayer() then return end

			if table.HasValue(membersTbl, self:SteamID64()) then
				self.IsGroupMember = true
			else
				self.IsGroupMember = false
			end
		end)
	end)
end

function meta:CheckAdvertiser()
	http.Fetch("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key="..ASR.SteamAPIKey.."&steamids="..self:SteamID64(), function(body)
		if !self:IsValid() or !self:IsPlayer() then return end

		if body == nil or !body then
			self.IsAdvertiser = false

			return
		end

		local fetchTbl = util.JSONToTable(body)

		if fetchTbl == nil or !fetchTbl then
			self.IsAdvertiser = false

			return
		end

		local plyName = fetchTbl["response"]["players"][1]["personaname"]

		if string.find(plyName, ASR.ServerNameTag, 1, true) then
			self.IsAdvertiser = true
		else
			self.IsAdvertiser = false
		end
	end)
end

function AsrGetGroupInfo()
	if string.sub(ASR.SteamGroupLink, -1) == "/" then
		ASR.SteamGroupLink = string.sub(ASR.SteamGroupLink, -1)
	end

	http.Fetch(ASR.SteamGroupLink.."/memberslistxml/?xml=1", function(body)
		if body == nil or !body then return end

		local tbl = AsrXMLToTable(body)

		if !tbl then return end

		local name = tbl["memberList"]["groupDetails"]["groupName"]

		asr_groupinfo["name"] = string.gsub(name, "%W", "")
		asr_groupinfo["members"] = tbl["memberList"]["groupDetails"]["memberCount"]
		asr_groupinfo["imglink"] = tbl["memberList"]["groupDetails"]["avatarFull"]
	end)
end
