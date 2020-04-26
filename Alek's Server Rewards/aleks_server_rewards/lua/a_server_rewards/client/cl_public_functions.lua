//Functions

function AsrPrepareMaterials()
	ply_texture = Material("asr_icons/users_icon.png")
	profile_texture = Material("asr_icons/profile_icon.png")
	steam_texture = Material("asr_icons/steam_icon.png")
	leader_texture = Material("asr_icons/leaderboard_icon.png")
  name_texture = Material("asr_icons/name_tag_icon.png")
	check_texture = Material("asr_icons/check_icon.png")
end

function AsrDrawTitle(title, font, color, x, y, alignx, aligny, ly)
	draw.SimpleText(title, font, x, y, color, alignx, aligny)

	surface.SetFont(font)

	local tw, th = surface.GetTextSize(title)
	local linex
	local liney

	surface.SetDrawColor(color.r, color.g, color.b)

	if alignx == TEXT_ALIGN_CENTER then
		linex = x - tw / 2
	elseif alignx == TEXT_ALIGN_RIGHT then
		linex = x - tw
	elseif alignx == TEXT_ALIGN_LEFT then
		linex = x
	end

	if aligny == TEXT_ALIGN_CENTER then
		liney = y + th / 2 + 2
	elseif aligny == TEXT_ALIGN_TOP then
		liney = y + th + 2
	elseif aligny == TEXT_ALIGN_BOTTOM then
		liney = y + 2
	end

	surface.DrawRect(linex, liney, tw, ly)
end

function AsrTextWrap(text, font, pxWidth)
	surface.SetFont(font)

	local total = 0
	local spaceSize = surface.GetTextSize(" ")

	text = text:gsub("(%s?[%S]+)", function(word)
		local char = string.sub(word, 1, 1)

		if char == "\n" or char == "\t" then
			total = 0
		end

		local wordlen = surface.GetTextSize(word)

		total = total + wordlen

		if wordlen >= pxWidth then
			local splitWord, splitPoint = charWrap(word, pxWidth - (total - wordlen))

			total = splitPoint

			return splitWord
		elseif total < pxWidth then
			return word
		end

		if char == ' ' then
			total = wordlen - spaceSize

			return '\n' .. string.sub(word, 2)
		end

		total = wordlen

		return '\n' .. word
	end)

	return text
end

local function AsrSafeText(text)
	return string.match(text, "^#([a-zA-Z_]+)$") and text.." " or text
end

function AsrDrawFormatedText(text, font, x, y, color, xAlign, yAlign)
	return draw.DrawText(AsrSafeText(text), font, x, y, color)
end

function AsrOrdinalNumber(n)
	local ordinal = {"st", "nd", "rd"}
	local lastdigit = tonumber(string.sub(n, -1))
	local lasttwo = tonumber(string.sub(n, -2))

  if lastdigit > 0 and lastdigit <= 3 and lasttwo != 11 and lasttwo != 12 and lasttwo != 13 then
    return n..ordinal[lastdigit]
  else
    return n.."th"
  end
end

function AsrCutText(txt, font, maxw)
	surface.SetFont(font)

	local txtw, txth = surface.GetTextSize(txt)
	local txtl = string.len(txt)

	while txtw > maxw do
		txt = string.sub(txt, 1, txtl - 1).."..."
		txtl = txtl - 1

		txtw, txth = surface.GetTextSize(txt)
	end

	return txt
end

function AsrQuad(fraction, beginning, change)
	return change * (fraction ^ 2) + beginning
end

function AsrSaveGroupImage()
	local groupName = asr_groupinfo["name"]
	local groupIconLink = asr_groupinfo["imglink"]

	if !file.Exists("asr_"..groupName.."_group_icon.txt", "DATA") then
		http.Fetch(groupIconLink, function(body)
			if body then
				file.Write("asr_"..groupName.."_group_icon.txt", body)
			end
		end)
	end
end

function AsrAproach(startn, endn, byn)
	if ASR.EnableUIAnimations then
		return math.Approach(startn, endn, byn)
	else
		return endn
	end
end

function AsrAnimateHover(num, startn, endn, byntoend, bytostart, var, inv)
	if var and num < endn and !inv then
		return AsrAproach(num, endn, byntoend)
	elseif !var and num > startn and !inv then
		return AsrAproach(num, startn, bytostart)
	elseif var and num > startn and inv then
		return AsrAproach(num, startn, bytostart)
	elseif !var and num < endn and inv then
		return AsrAproach(num, endn, byntoend)
	end

	return num
end

function AsrAddConfetti(ply)
	if !ply:IsValid() or !ply:IsPlayer() then return end

	emitter = ParticleEmitter(ply:GetPos())

	for i = 0, 75, 1 do
		local spark = emitter:Add("effects/spark", ply:GetPos() + VectorRand() * math.random(-15, 15) + Vector(math.random(1, 5), math.random(1, 5), math.random(50, 100)))
		spark:SetStartSize(math.Rand(2, 6))
		spark:SetEndSize(0)

		spark:SetCollide(true)
		spark:SetBounce(0.2)
		spark:SetGravity(Vector(0, 0, -250))
		spark:SetRoll(math.Rand(0, 360))
		spark:SetVelocity(VectorRand() * 100)
		spark:SetRollDelta(math.Rand(-4, 4))

		spark:SetStartAlpha(math.Rand(80, 250))
		spark:SetEndAlpha(0)

		spark:SetColor(math.random(75, 250), math.random(75, 250), math.random(75, 250), 255)
		spark:SetDieTime(4)
	end

	emitter:Finish()
end

function AsrDrawBorders(x, y, w, h, up, down, left, right)
	surface.SetDrawColor(asrColor.r, asrColor.g, asrColor.b, 255)

	if (up) then surface.DrawRect(x, y, w, 1) end
	if (down) then surface.DrawRect(x, y + h - 1, w, 1) end
	if (left) then surface.DrawRect(x, y, 1, h) end
	if (right) then surface.DrawRect(x + w - 1, y, 1, h) end
end

function AsrNotify(netmsg)
	chat.AddText(ASR.ChatTagColor, ASR.ChatTag.." ", Color(255, 255, 255), netmsg)

	surface.PlaySound("buttons/lightswitch2.wav")
end

function AsrDrawRhombus(px, py, w, h, color)
	local rhombus = {
		{x = px + w / 2, y = py + h},
		{x = px, y = py + h / 2},
		{x = px + w / 2, y = py},
		{x = px + w, y = py + h / 2},
	}

	surface.SetDrawColor(color.r, color.g, color.b, color.alpha)

	draw.NoTexture()

	surface.DrawPoly(rhombus)
end

function AsrCheckTab(tabNum)
	if asrCurrentTab != tabNum then
		invitespanel:Remove()
	end

	if asrCurrentTab == 4 then
		invitespanel:Remove()
	end

	asrCurrentTab = tabNum
end

local function AsrOrderLeaderboard()
	table.Empty(asrLeadersTbl)

	for k, v in pairs(asr_data) do
		if v["refers"] > 0 then
			table.insert(asrLeadersTbl, v)
		end
	end

	table.sort(asrLeadersTbl, function(a, b) return a["refers"] > b["refers"] end)
end

local function AsrDecompress(str)
  return util.JSONToTable(util.Decompress(str))
end

//Net Messages

net.Receive("AsrNotify", function()
	local netmessage = net.ReadString()

	AsrNotify(netmessage)
end)

net.Receive("AsrConfetti", function()
	local ply = net.ReadEntity()

	AsrAddConfetti(ply)
end)

net.Receive("AsrSound", function()
	local name = net.ReadString()

	surface.PlaySound("asr_sounds/"..name..".mp3")
end)

net.Receive("AsrSendTable", function(len)
	local currentChunk = net.ReadData((len - 1) / 8)
	local finishedChunking = net.ReadBool()

	table.insert(asrTblChunks, currentChunk)

	if finishedChunking then
		table.Empty(asr_data)

		asrDataStr = table.concat(asrTblChunks)
		asr_data = table.Copy(AsrDecompress(asrDataStr))

		table.Empty(asrTblChunks)
		asrDataStr = ""

		AsrOrderLeaderboard()

		print("[Server Rewards] The data table has been received.")
	end
end)

net.Receive("AsrUpdateTable", function()
	local netTbl = net.ReadTable()
	local netSID = netTbl["steamid"]

	for k, v in pairs(asr_data) do
		if v["steamid"] == netSID then
			table.remove(asr_data, k)

			break
		end
	end

	table.insert(asr_data, netTbl)

	AsrOrderLeaderboard()

	print("[Server Rewards] The data table has been updated.")
end)

net.Receive("AsrUpdateGroup", function()
	asr_groupinfo = net.ReadTable()

	print("[Server Rewards] The steam group's info has been updated.")
end)
