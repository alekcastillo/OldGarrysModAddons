//Network Strings

util.AddNetworkString("AsrReferConfirmationRequest")
util.AddNetworkString("AsrOpenConfirmationMenu")
util.AddNetworkString("AsrReferConfirmed")

//Functions

local function AsrCheckIfReferredCanUse(referrerply, referredply, confirmstate)
	if !referredply:IsValid() or !referredply:IsPlayer() or referredply:IsBot() then

		return
  end

	local nick = referredply:AsrNick()

	if referredply:AsrReferrer() then
		if confirmstate == 1 and referrerply != nil then
			AsrNotify(referredply:Nick().." has already rewarded the player who referred him/her, and this can only be done once.", referrerply)
		elseif confirmstate == 2 and referredply != nil then
			AsrNotify("You have already rewarded your referrer, and this can only be done once.", referredply)
		end

		referredply.CanUseRefers = false

		return
	end

	if ASR.RequiredMinutesOnServerForReferReward > 0 then
		if math.floor(referredply:GetUTimeTotalTime() / 60) < ASR.RequiredMinutesOnServerForReferReward then
			if confirmstate == 1 and referrerply != nil then
				AsrNotify(nick.." has less than "..ASR.RequiredMinutesOnServerForReferReward.." minutes played on this server, therefore, he/she can't reward anyone for referring him/her to the server yet.", referrerply)
			elseif confirmstate == 2 and referredply != nil then
				AsrNotify("You have less than "..ASR.RequiredMinutesOnServerForReferReward.." minutes played on this server, therefore, you can't reward anyone for referring you to the server yet.", referredply)
			end

			referredply.CanUseRefers = false

			return
		end
	end

	if ASR.MinPlayTimeForReferReward > 0 and (ASR.SteamAPIKey != "The key goes here" and ASR.SteamAPIKey != "") then --REEMPLAZAR LOS CONFIGS GLOBALES POR LOS DE "FOR REFER"
		referredply:CheckTime()

		timer.Simple(0.5, function()
      if referredply == nil or !referredply:IsValid() then return end

			if referredply.Playtime < ASR.MinPlayTimeForReferReward then
				if confirmstate == 1 and referrerply != nil then
					AsrNotify(nick.." either has less than "..ASR.MinPlayTimeForReferReward.." hours played on Garry's Mod, or a private Steam profile, therefore, he/she can't reward anyone for referring him/her to the server yet.", referrerply)
				elseif confirmstate == 2 and referredply != nil then
					AsrNotify("You either have less than "..ASR.MinPlayTimeForReferReward.." hours played on Garry's Mod, or a private Steam profile, therefore, you can't reward anyone for referring you to the server yet.", referredply)
				end

				referredply.CanUseRefers = false

				return
			end
		end)
	end

	if ASR.CheckFamilyShareForReferReward and (ASR.SteamAPIKey != "The key goes here" and ASR.SteamAPIKey != "") then
		referredply:CheckShared()

		timer.Simple(0.5, function()
      if referredply == nil or !referredply:IsValid() then return end

			if referredply.IsGameshared then
				if confirmstate == 1 and referrerply != nil then
					AsrNotify(nick.." is either playing on a family shared copy of Garry's Mod, or has a private Steam profile, therefore, he/she can't reward anyone for referring him/her to the server yet.", referrerply)
				elseif confirmstate == 2 and referredply != nil then
					AsrNotify("You are either playing on a family shared copy of Garry's Mod, or have a private Steam profile, therefore, you can't reward anyone for referring you to the server yet.", referredply)
				end

				referredply.CanUseRefers = false

				return
			end
		end)
	end

	referredply.CanUseRefers = true
end

local function AsrCheckIfReferrerCanUse(referrerply, referredply, confirmstate)
	if !referrerply:IsValid() or !referrerply:IsPlayer() or referrerply:IsBot() then

		return
  end

	local nick = referrerply:AsrNick()

	if ASR.RequiredMinutesOnServerForReferReward > 0 then
		if math.floor(referrerply:GetUTimeTotalTime() / 60) < ASR.RequiredMinutesOnServerForReferReward then
			if confirmstate == 1 and referrerply != nil then
				AsrNotify("You have less than "..ASR.RequiredMinutesOnServerForReferReward.." minutes played on this server, therefore, you can't get rewarded for referring anyone to the server yet.", referrerply)
			elseif confirmstate == 2 and referredply != nil then
				AsrNotify(nick.." has less than "..ASR.RequiredMinutesOnServerForReferReward.." minutes played on this server, therefore, he/she can't get rewarded for referring anyone to the server yet.", referredply)
			end

			referrerply.CanUseRefers = false

			return
		end
	end

	if ASR.MinPlayTimeForReferReward > 0 and (ASR.SteamAPIKey != "The key goes here" and ASR.SteamAPIKey != "") then
		referrerply:CheckTime()

		timer.Simple(0.5, function()
      if referrerply == nil or !referrerply:IsValid() then return end

			if referrerply.Playtime < ASR.MinPlayTimeForReferReward then
				if confirmstate == 1 and referrerply != nil then
					AsrNotify("You either have less than "..ASR.MinPlayTimeForReferReward.." hours played on Garry's Mod, or a private Steam profile, therefore, you can't get rewarded for referring anyone to the server yet.", referrerply)
				elseif confirmstate == 2 and referredply != nil then
					AsrNotify(nick.." either has less than "..ASR.MinPlayTimeForReferReward.." hours played on Garry's Mod, or a private Steam profile, therefore, he/she can't get rewarded for referring anyone to the server yet.", referredply)
				end

				referrerply.CanUseRefers = false

				return
			end
		end)
	end

	if ASR.CheckFamilyShareForReferReward and (ASR.SteamAPIKey != "The key goes here" and ASR.SteamAPIKey != "") then
		referrerply:CheckShared()

		timer.Simple(0.5, function()
      if referrerply == nil or !referrerply:IsValid() then return end

			if referrerply.IsGameshared then
				if confirmstate == 1 and referrerply != nil then
					AsrNotify("You are either playing on a family shared copy of Garry's Mod, or have a private Steam profile, therefore, you can't get rewarded for referring anyone to the server yet.", referrerply)
				elseif confirmstate == 2 and referredply != nil then
					AsrNotify(nick.." is either playing on a family shared copy of Garry's Mod, or has a private Steam profile, therefore, he/she can't get rewarded for referring anyone to the server yet.", referredply)
				end

				referrerply.CanUseRefers = false

				return
			end
		end)
	end

	referrerply.CanUseRefers = true
end

local function AsrCheckIfReferralIsValid(referrer, referred, ply, act)
	if referrer == referred then
		AsrNotify("You can't reward yourself!", ply)

		return false
	end

	if act == 1 and referred == AsrReferrerSID(referrer) then
		AsrNotify("You can't get rewarded by referring your referrer!", ply)

		return false
	elseif act == 2 and referred == AsrReferrerSID(referrer) then
		AsrNotify("You can't reward a player that you referred to the server!", ply)

		return false
	end

	return true
end

local function AsrRecordPending(referrer, referred)
	if ASR.UseMySQL and sqlSuccess then
		AsrQuery("insert into asr_pending (referrer, referred) values ('"..referrer.."', '"..referred.."');", _)
	else
		local pendingDataTbl = {referrer = referrer, referred = referred}

		if asr_pending[1]["referrer"] == "referrer" then
			table.remove(asr_pending, 1)
		end

		table.insert(asr_pending, pendingDataTbl)

		file.Write("server_rewards/asr_pending.txt", util.TableToJSON(asr_pending))
	end
end

local function AsrRemovePending(referred)
  for k, v in pairs(asr_pending) do
    if v["referred"] == referred then
      table.remove(asr_pending, k)

      break
    end
  end

  if ASR.UseMySQL and sqlSuccess then
    AsrQuery("delete from asr_pending where referred = '"..referred.."';");
  else
    file.Write("server_rewards/asr_pending.txt", util.TableToJSON(asr_pending))
  end
end

local function AsrRewardRefer(referrer, referred)
	local referrerply = player.GetBySteamID(referrer)
	local referredply = player.GetBySteamID(referred)

	if (!referrerply or !referrerply:IsPlayer()) and (!referredply or !referredply:IsPlayer()) then return end

	if referredply != false then
		if !AsrCheckIfReferralIsValid(referrer, referred, referredply, 2) then return end
	elseif referrerply != false then
		if !AsrCheckIfReferralIsValid(referrer, referred, referrerply, 1) then return end
	end

	local rewardable = true

	if ASR.MaxReferrablePlayers > 0 then
		if referrerply:AsrRefers() >= ASR.MaxReferrablePlayers then
			rewardable = false
		end
	end

	local referrernick = AsrNickSID(referrer)
	local referrednick = AsrNickSID(referred)

	local referrerrecorded = false
	local referredrecorded = false

	if referrerply then
		referrerply:AsrSetRefers(true, 1)
		AsrSetReferrerSID(referred, referrer)
		AsrRemovePending(referred)

		if rewardable then
			AsrRewardPlayer(referrerply, 1)

			if referredply != false then
				AsrNotify("Thanks for confirming that you were referred by "..referrernick.."!", referredply)
			end

			AsrNotify("Thanks for referring "..referrednick.." to the server, you have been rewarded!", referrerply)
		else
			if referredply != false then
				AsrNotify("Thanks for confirming "..referrernick.."'s' refer!", referredply)
			end

			AsrNotify("Thanks for referring "..referrednick.." to the server, you would normally receive a reward, however, you already reached the refer rewards limit ("..ASR.MaxReferrablePlayers..").", referrerply)
		end

		if ASR.GlobalNotificationOnReferralConfirmed then
			AsrNotify(referrernick.." referred "..referrednick.." to the server and received a reward by confirming it with '!"..ASR.MenuCommand.."' (or '/"..ASR.MenuCommand.."')...!")
		end

		AsrPlaySound("applause", referrerply)

		if ASR.ThrowConfettiOnReferralConfirmed then
			AsrThrowConfetti(referrerply)
		end

		AsrUpdateTable(referrer)
		AsrUpdateTable(referred)
	else
		if rewardable then
			AsrNotify("Thanks for confirming "..referrernick.."'s' refer! He will be rewarded as soon as he joins!", referredply)
		else
			AsrNotify("Thanks for confirming "..referrernick.."'s' refer!", referredply)
		end

		AsrRecordPending(referrer, referred)
	end
end

function AsrCheckPendingRewards(ply)
  local edited = false
  local rewardable = true

  AsrCheckIfReferrerCanUse(ply, _, 2)

	timer.Simple(1, function()
		if !ply.CanUseRefers then
			rewardable = false
		end

	  for k, v in pairs(asr_pending) do
	    if v["referrer"] == ply:SteamID() then
	      edited = true

	      if rewardable then
	        AsrRewardRefer(v["referrer"], v["referred"])
	      end

				AsrRemovePending(v["referred"])
	    end
	  end
	end)
end

//Network Messages

net.Receive("AsrReferConfirmationRequest", function(_, referrerply)
	if !referrerply:IsValid() or !referrerply:IsPlayer() then return end

	local referredply = net.ReadEntity(ply2)

	if !referredply:IsValid() or !referredply:IsPlayer() then return end

	if !AsrCheckIfReferralIsValid(referrerply:SteamID(), referredply:SteamID(), referrerply, 1) then return end

	if CurTime() - referrerply.CoolDownTimer < ASR.CooldownTimer then
		AsrNotify("You have to wait another "..-1 * math.floor((CurTime() - referrerply.CoolDownTimer) - ASR.CooldownTimer).." seconds before asking someone to confirm your referral again!", referrerply)

		return false
	end

	AsrCheckIfReferrerCanUse(referrerply, referredply, 1)
	AsrCheckIfReferredCanUse(referrerply, referredply, 1)

	timer.Simple(1, function()
		if referrerply:IsValid() and referrerply.CanUseRefers and referredply:IsValid() and referredply.CanUseRefers then
			AsrNotify("The referral confirmation request has been succesfully sent to "..referredply:AsrNick()..". Waiting for his/her answer...", referrerply)

			referrerply.CoolDownTimer = CurTime()

			net.Start("AsrOpenConfirmationMenu")
			net.WriteEntity(referrerply)
			net.Send(referredply)
		end
	end)
end)

net.Receive("AsrReferConfirmed", function(_, referredply)
	if !referredply:IsValid() or !referredply:IsPlayer() then return end

	local referrer = net.ReadString()
	local referred = referredply:SteamID()

	if !AsrCheckIfReferralIsValid(referrer, referred, referredply, 2) then return end

	local referrerply = player.GetBySteamID(referrer)

	if referrerply then
		AsrCheckIfReferrerCanUse(referrerply, referredply, 2)
		AsrCheckIfReferredCanUse(referrerply, referredply, 2)
	else
		AsrCheckIfReferredCanUse(_, referredply, 2)
	end

	timer.Simple(1, function()
		if referrerply and referrerply.CanUseRefers and referredply:IsValid() and referredply.CanUseRefers then
			AsrRewardRefer(referrer, referred)
		elseif !referrerply and referredply:IsValid() and referredply.CanUseRefers then
			AsrRewardRefer(referrer, referred)
		end
	end)
end)
