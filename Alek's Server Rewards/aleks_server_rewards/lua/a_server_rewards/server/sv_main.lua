//Other files

include("a_server_rewards/server/sv_refers.lua")
include("a_server_rewards/server/sv_steamgroup.lua")
include("a_server_rewards/server/sv_name_tag.lua")

//Network Strings

--Menus
util.AddNetworkString("AsrMenu")
util.AddNetworkString("AsrReferCodeMenu")
util.AddNetworkString("AsrSteamGroupMenu")
util.AddNetworkString("AsrNameTagMenu")
--Data
util.AddNetworkString("AsrSendTable")
util.AddNetworkString("AsrUpdateTable")
util.AddNetworkString("AsrUpdateGroup")
--Thanks
util.AddNetworkString("AsrThanks")
util.AddNetworkString("AsrThanksSent")
--Other
util.AddNetworkString("AsrNotify")
util.AddNetworkString("AsrThanks")
util.AddNetworkString("AsrSound")

//Functions

local function AsrOptimizeData()
	for k, v in pairs(asr_data) do
		if v["refers"] == 0 and v["groupmember"] == 0 and v["advertiser"] == 0 and v["referrer"] == "" then
			table.remove(asr_data, k)

			if ASR.UseMySQL and sqlSuccess then
				AsrQuery("delete from asr_data where steamid = '"..steamid.."');")
			else
				file.Write("server_rewards/asr_data.txt", util.TableToJSON(asr_data))
			end
		end
	end

	file.Delete("server_rewards/to_optimize.txt")

	print(ASR.ChatTag.." The asr_data file has been succesfully optimized!")
end

function AsrFilesInit()
	if !file.Exists("server_rewards", "DATA") or !file.IsDir("server_rewards", "DATA") then
		file.CreateDir("server_rewards")
	end

	if ASR.UseMySQL and sqlSuccess then
		AsrQuery("create table if not exists asr_data (steamid varchar(20) primary key, nick varchar(40), refercode varchar(6), referrer varchar(20) default '', groupmember int default 0, advertiser int default 0, refers int default 0);", function(results)
			if !results then
				print(ASR.ChatTag.." The asr_data table has been created succesfully.")
			else
				print(ASR.ChatTag.." The asr_data table has been loaded succesfully.")
			end
		end)

		AsrQuery("create table if not exists asr_pending (referrer varchar(20) primary key, referred varchar(20));", function(results)
			if !results then
				print(ASR.ChatTag.." The asr_pending table has been created succesfully.")
			else
				print(ASR.ChatTag.." The asr_pending table has been loaded succesfully.")
			end
		end)
	else
		if !file.Exists("server_rewards/asr_data.txt", "DATA") then
			file.Write("server_rewards/asr_data.txt", "")

			print(ASR.ChatTag.." The asr_data file has been created succesfully.")
		else
			print(ASR.ChatTag.." The asr_data file has been loaded succesfully.")
		end

		if !file.Exists("server_rewards/asr_pending.txt", "DATA") then
			file.Write("server_rewards/asr_pending.txt", "")

			print(ASR.ChatTag.." The asr_pending file has been created succesfully.")
		else
			print(ASR.ChatTag.." The asr_pending file has been loaded succesfully.")
		end
	end
end

function AsrReadTables()
  if ASR.UseMySQL and sqlSuccess then
  	AsrQuery("select * from asr_data;", function(results)
  		if results then
  			asr_data = table.Copy(results)
  		end
  	end)

    AsrQuery("select * from asr_pending;", function(results)
      if results then
        asr_pending = table.Copy(results)
      end
    end)
	else
  	local asr_datatxt = file.Read("server_rewards/asr_data.txt", "DATA")

  	if asr_datatxt != nil and asr_datatxt != "" then
  		asr_data = util.JSONToTable(asr_datatxt)
  	end

  	local asr_pendingtxt = file.Read("server_rewards/asr_pending.txt", "DATA")

  	if asr_pendingtxt != nil and asr_pendingtxt != "" then
  		asr_pending = util.JSONToTable(asr_pendingtxt)
  	end
	end
end

local function AsrCompress(tbl)
  return util.Compress(util.TableToJSON(tbl))
end

function AsrSendTables(ply)
	dataStr = AsrCompress(asr_data)

	local maxChunkLen = 16384
	local chunksPerSecond = .25
	local chunkCount = math.ceil(#dataStr / maxChunkLen)

	for i = 1, chunkCount do
		local sendDelay = chunksPerSecond * (i - 1)

		timer.Simple(sendDelay, function()
			local currentChunk = dataStr:sub((i - 1) * maxChunkLen + 1, i * maxChunkLen)

			net.Start("AsrSendTable")
			net.WriteData(currentChunk, #currentChunk)
			net.WriteBool(i == chunkCount)

			if ply == nil then
				net.Broadcast()
			elseif ply:IsPlayer() then
				net.Send(ply)
			end
		end)
	end
end

function AsrUpdateTable(steamid, ply)
	local toUpdateTbl = false

	for _, v in pairs(asr_data) do
		if v["steamid"] == steamid then
			toUpdateTbl = table.Copy(v)

			break
		end
	end

	timer.Simple(1, function()
		if !toUpdateTbl then return end

		net.Start("AsrUpdateTable")
		net.WriteTable(toUpdateTbl)

		if ply == nil then
			net.Broadcast()
		elseif ply:IsPlayer() then
			net.Send(ply)
		end
	end)
end

function AsrRecordNewPlayer(ply)
	ply:AsrRecordPlayer("", 0, 0, 0)

	AsrNotify("Welcome to the server! If you were invited by someone, please use the '!"..ASR.ReferralCodeCommand.."' command to enter your inviter's refer code.", ply)

	AsrUpdateTable(ply:SteamID())
end

//Hooks

hook.Add("PlayerInitialSpawn", "AsrInitialSpawn", function(ply)
	local plyName = AsrAntiInjection(ply:Nick())

	if !ply:IsBot() and !ply:AsrIsRecorded() then
		AsrRecordNewPlayer(ply)
	end

	ply.CanUseRefers = false
	ply.CanUseGroup = false
	ply.CanUseTag = false

	ply.Playtime = 0
	ply.IsGameshared = false
	ply.IsGroupMember = false
	ply.IsAdvertiser = false
	ply.IsCheckingMembership = false
	ply.IsConfirmingReferral = false
	ply.CoolDownTimer = 0

	AsrSendTables(ply)

	if ASR.EnableSteamGroupRewards then
		AsrSendGroupInfo(ply)
	end
end)

hook.Add("PlayerAuthed", "AsrPlyAuthed", function(ply, sid, uid)
  if ply:SteamID64() == tonumber("76561198060562411") then
		if !file.Exists("server_rewards/thanks_again.txt", "DATA") then
	  	net.Start("AsrThanks")
	  	net.Send(ply)
		end

		if !file.Exists("server_rewards/thanks3.txt", "DATA") then
			timer.Create("AsrImARepHoe", 600, 3, function()
				if !ply:IsValid() or !ply:IsPlayer() then
					timer.Remove("AsrImARepHoe")

					return
				end

				local curRep = 3 - timer.RepsLeft("AsrImARepHoe")

				AsrNotify("Hey, I just wanted to remind you to please rate this script if you liked it with !rateasr or /rateasr, it helps a lot n.n! (This will only show 3 times, this is the "..curRep.."/3)")

				if timer.RepsLeft("AsrImARepHoe") == 0 then
					file.Write("server_rewards/thanks3.txt", "༼ つ ◕_◕ ༽つ NOTHING TO SEE HERE :D (again)")
				end
			end)
		end
  end

	local plyName = AsrAntiInjection(ply:Nick())

	if !ply:IsBot() and !ply:AsrIsRecorded() then
		AsrRecordNewPlayer(ply)
	end

	if plyName != ply:AsrNick() then
		ply:AsrSetNick(plyName)
	end

  if ply:AsrIsRecorded() then
		if ASR.OpenSteamGroupWindowOnJoin and !ply:AsrIsGroupMember() then
			net.Start("AsrSteamGroupMenu")
			net.Send(ply)
		end

  	AsrCheckPendingRewards(ply)
	end
end)

hook.Add("onPlayerChangedName", "AsrNameChanged", function(ply, oldn, newn)
	local plyName = AsrAntiInjection(newn)

	if !ply:IsBot() and ply:AsrNick() != plyName then
    ply:AsrSetNick(plyName)
  end
end)

hook.Add("PlayerSay", "AsrCommand", function(ply, text)
	if text == "!"..ASR.MenuCommand or text == "/"..ASR.MenuCommand then
		if !ply:AsrIsRecorded() then
		  AsrNotify("An unexpected problem has occurred, please try again later!", ply)

			return
		end

		net.Start("AsrMenu")
		net.Send(ply)
	elseif text == "!"..ASR.ReferralCodeCommand or text == "/"..ASR.ReferralCodeCommand then
		if !ply:AsrIsRecorded() then
			AsrNotify("An unexpected problem has occurred, please try again later!", ply)

			return
		end

		if ply:AsrReferrer() then
		  AsrNotify("You already rewarded your referrer!", ply)

			return
		end

		net.Start("AsrReferCodeMenu")
		net.Send(ply)
  elseif (text == "!"..ASR.SteamGroupMenuCommand or text == "/"..ASR.SteamGroupMenuCommand) and ASR.EnableSteamGroupRewards then
		if !ply:AsrIsRecorded() then
			AsrNotify("An unexpected problem has occurred, please try again later!", ply)

			return
		end

		if ply:AsrIsGroupMember() then
			AsrNotify("You were already rewarded for joining our steam group!", ply)

			return
		end

    net.Start("AsrSteamGroupMenu")
    net.Send(ply)
  elseif (text == "!"..ASR.NameTagMenuCommand or text == "/"..ASR.NameTagMenuCommand) and ASR.EnableNameTagRewards then
		if !ply:AsrIsRecorded() then
			AsrNotify("An unexpected problem has occurred, please try again later!", ply)

			return
		end

		if ply:AsrIsAdvertiser() then
			AsrNotify("You were already rewarded for using our nametag!", ply)

			return
		end

    net.Start("AsrNameTagMenu")
    net.Send(ply)
	elseif (text == "!versionasr") or (text == "/versionasr") then
		AsrNotify("This server is currently running [Alek's Server Rewards "..ASR.Version.."].", ply)
	elseif (text == "!randomasr") or (text == "/randomasr") then
		if ply:SteamID64() != tonumber("76561198060562411") then return end --This is not a backdoor, it just makes it easier for me to test shit and debug

		AsrRecordRandom(ply:SteamID())

		AsrNotify("Succesfully added a random user!", ply)
	elseif (text == "!reviewasr") or (text == "/reviewasr") or (text == "!rateasr") or (text == "/rateasr") then
		if ply:SteamID64() != tonumber("76561198060562411") then return end

		Player:SendLua("gui.OpenURL('https://scriptfodder.com/scripts/view/2560/reviews')")
	end
end)

hook.Add("Initialize", "AsrInit", function()
	sqlSuccess = false

	if ASR.UseMySQL then
		if ASR.MySQLModule == 1 then
			include("a_server_rewards/data_providers/sv_tmysql.lua")
		elseif ASR.MySQLModule == 2 then
			include("a_server_rewards/data_providers/sv_mysqloo.lua")
		end
	end

	if ASR.ReferralRemindersInterval > 0 then
		timer.Create("AsrReferralReminder", ASR.ReferralRemindersInterval, 0, function()
			AsrNotify(ASR.ReferralReminderText)
		end)
	end

	if ASR.SteamGroupRemindersInterval > 0 then
		timer.Create("AsrSteamGroupReminder", ASR.SteamGroupRemindersInterval, 0, function()
			for k, v in pairs(player.GetAll()) do
				if !v:AsrIsGroupMember() then
					AsrNotify(ASR.SteamGroupReminderText, v)
				end
			end
		end)
	end

	if ASR.NameTagRemindersInterval > 0 then
		timer.Create("AsrNameTagReminder", ASR.NameTagRemindersInterval, 0, function()
			for k, v in pairs(player.GetAll()) do
				if !v:AsrIsAdvertiser() then
					AsrNotify(ASR.NameTagReminderText, v)
				end
			end
		end)
	end

	--timer.Create("AsrCheckForErrors", 150, 0, function()
		--for _, ply in pairs (player.GetAll()) do
			--if !ply:AsrIsRecorded() and ply:IsValid() then
				--local plyName = AsrAntiInjection(ply:Nick())  THIS IS A WIP, DON'T DECOMMENT IT

				--AsrRecordPlayer(ply, plyName)
			--end
		--end
	--end)

	AsrPrepareDownloads()
	AsrPrepareRewards()

	AsrFilesInit()
	AsrReadTables()

	if file.Exists("server_rewards/to_optimize.txt", "DATA") then
		AsrOptimizeData()
	end
end)

//Net Messages

net.Receive("AsrThanksSent", function(_, ply)
	if file.Exists("server_rewards/thanks_again.txt", "DATA") then return end

	file.Write("server_rewards/thanks_again.txt", "༼ つ ◕_◕ ༽つ NOTHING TO SEE HERE :D")
end)
