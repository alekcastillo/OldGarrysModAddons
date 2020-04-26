//Functions

function AsrRecordRandom(referrer)
  local steamIDNotUsed = false
  local steamID = ""
  local name = ""
  local refers = math.Round(math.Rand(0, 4))
  local ismember = math.Round(math.Rand(0, 5))
  local isadvertiser = math.Round(math.Rand(0, 8))
  local refRefers = AsrRefersSID(referrer) + 1

  if ismember != 1 then ismember = 0 end
  if isadvertiser != 1 then isadvertiser = 0 end

  while !steamIDNotUsed do
    steamID = AsrGenerateCode(8)

    if !AsrIsRecordedSID(steamid) then
      steamIDNotUsed = true
    end
  end

  http.Fetch("https://randomuser.me/api/", function(body)
    if !body then return end

    local decode = util.JSONToTable(body)

    decode = decode.results[1]

    name = decode.name.title .. ". " .. decode.name.first .. " " .. decode.name.last

    AsrRecordPlayerSID(steamID, name, referrer, ismember, isadvertiser, refers)
  end)
end

function AsrAntiInjection(str)
  str = string.gsub(str, "'", "")
  str = string.gsub(str, '"', '')
  str = string.gsub(str, "-", "")
  str = string.gsub(str, "/", "")
  str = string.gsub(str, ":", "")
  str = string.gsub(str, ";", "")
  str = string.gsub(str, ",", "")

  if str == "" then
    str = " "
  end

  return str
end

function AsrNotify(message, ply)
	net.Start("AsrNotify")
	net.WriteString(message)

	if ply == nil then
		net.Broadcast()
	elseif ply.IsPlayer() then
		net.Send(ply)
	end
end

function AsrPrepareDownloads()
  if ASR.WorkshopDownload then
  	resource.AddWorkshop("830279674")
  elseif ASR.ServerDownload then
  	resource.AddSingleFile("materials/asr_icons/check_icon.png")
    resource.AddSingleFile("materials/asr_icons/group_member_icon.png")
  	resource.AddSingleFile("materials/asr_icons/leaderboard_icon.png")
  	resource.AddSingleFile("materials/asr_icons/steam_icon.png")
  	resource.AddSingleFile("materials/asr_icons/profile_icon.png")
  	resource.AddSingleFile("materials/asr_icons/users_icon.png")
  end

  resource.AddFile("resource/fonts/roboto.ttf")
  resource.AddFile("resource/fonts/oneday.ttf")
end

function AsrGenerateCode(length)
	local code = ""

	for i = 1, length do
		n = math.random(48, 90)
		if n > 57 and n < 65 then
			n = math.random(48, 57)
		end
		code = code..string.char(n)
	end

	return code
end

function AsrThrowConfetti(ply)
  net.Start("AsrConfetti")
  net.WriteEntity(ply)
  net.Broadcast()
end

function AsrPlaySound(name, ply)
  net.Start("AsrSound")
	net.WriteString(name)

	if ply == nil then
		net.Broadcast()
	elseif ply.IsPlayer() then
		net.Send(ply)
	end
end
