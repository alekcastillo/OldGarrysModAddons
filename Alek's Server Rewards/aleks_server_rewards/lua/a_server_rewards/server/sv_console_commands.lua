//Console Commands

concommand.Add("asr_reset", function(ply, cmd, args)
	if !ply:IsPlayer() or !ply:IsSuperAdmin() then return end

	if ASR.UseMySQL and sqlSuccess then
		AsrQuery("drop table asr_data;")
		AsrQuery("drop table asr_pending;")
	else
		if file.Exists("server_rewards/asr_data.txt", "DATA") then
			file.Delete("server_rewards/asr_data.txt")
		end

		if file.Exists("server_rewards/asr_pending.txt", "DATA") then
			file.Delete("server_rewards/asr_pending.txt")
		end
	end

	asr_data = {{steamid = "steamid", nick = "nick", refercode = "referc", referrer = "referrer", groupmember = 0, advertiser = 0, refers = 0}}
	asr_groupinfo = {name = "", members = 0, imglink = ""}

	AsrFilesInit()
	AsrReadTables()

	for _, ply in pairs (player.GetAll()) do
		if ply:IsValid() and ply:IsPlayer() then
			AsrRecordNewPlayer(ply)
		end
	end

	timer.Simple(1, function()
		AsrSendTables()
		AsrSendGroupInfo()

		AsrNotify("The ASR data has been succesfully reseted!", ply)

		print(ASR.ChatTag.." The ASR data has been succesfully reseted!")
	end)
end)

concommand.Add("asr_refresh", function(ply, cmd, args)
	if !ply:IsPlayer() or !ply:IsSuperAdmin() then return end

	AsrPrepareRewards()

	AsrSendTables()
	AsrSendGroupInfo()

	AsrNotify("The ASR data has been succesfully refreshed!", ply)

	print(ASR.ChatTag.." The ASR data has been succesfully refreshed!")
end)

concommand.Add("asr_optimize", function(ply, cmd, args)
	if !ply:IsPlayer() or !ply:IsSuperAdmin() then return end

	if !file.Exists("server_rewards/to_optimize.txt", "DATA") then
		file.Write("server_rewards/to_optimize.txt", "༼ つ ◕_◕ ༽つ NOTHING TO SEE HERE :D")
	end

	AsrNotify("The ASR data will be optimized on the next server restart!", ply)

	print(ASR.ChatTag.." The ASR data has been succesfully reseted!")
end)
