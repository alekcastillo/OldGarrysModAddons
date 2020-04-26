//Network Strings

util.AddNetworkString("AsrNameTagCheck")

//Functions

local function AsrCanBeNameTagRewarded(ply)
  if !ASR.EnableNameTagRewards then return end

  if ply == nil or !ply:IsValid() or !ply:IsPlayer() or ply:IsBot() then

    return
  end

  if ply.IsCheckingName then
    ply.CanUseTag = false

    return
  end

  if ply:AsrIsAdvertiser() then
    AsrNotify("You were already rewarded for using our nametag!", ply)

    ply.CanUseTag = false

    return
  end

  if ASR.RequiredMinutesOnServerForNameTagReward > 0 then
    if math.floor(ply:GetUTimeTotalTime() / 60) < ASR.RequiredMinutesOnServerForNameTagReward then
      AsrNotify("You have less than "..ASR.RequiredMinutesOnServerForNameTagReward.." minutes played on this server, therefore, you can't get rewarded for using our nametag yet.", ply)

      ply.CanUseTag = false

      return
    end
  end

  if ASR.MinPlayTimeForNameTagReward > 0 and (ASR.SteamAPIKey != "The key goes here" and ASR.SteamAPIKey != "") then
    ply:CheckTime()

    timer.Simple(0.5, function()
      if ply == nil or !ply:IsValid() then return end

      if ply.Playtime < ASR.MinPlayTimeForNameTagReward then
        AsrNotify("You either have less than "..ASR.MinPlayTimeForNameTagReward.." hours played on Garry's Mod, or a private Steam profile, therefore, you can't get rewarded for using our nametag yet.", ply)

        ply.CanUseTag = false

        return
      end
    end)
  end

  if ASR.CheckFamilyShareForNameTagReward and (ASR.SteamAPIKey != "The key goes here" and ASR.SteamAPIKey != "") then
    ply:CheckShared()

    timer.Simple(0.5, function()
      if ply == nil or !ply:IsValid() then return end

      if ply.IsGameshared then
        AsrNotify("You are either playing on a family shared copy of Garry's Mod, or have a private Steam profile, therefore, you can't get rewarded for using our nametag yet.", ply)

        ply.CanUseTag = false

        return
      end
    end)
  end

  ply.CanUseTag = true
end

local function AsrNameTagChecked(ply)
  if !ASR.EnableNameTagRewards then return end

  local nick = ply:AsrNick()

  ply:AsrSetAdvertiser(1)

  AsrRewardPlayer(ply, 3)

  if ASR.GlobalNotificationOnNameTagConfirmed then
    AsrNotify(nick.." has added our name tag to his steam name and received a reward by confirming it with '!"..ASR.NameTagMenuCommand.."' (or '/"..ASR.NameTagMenuCommand.."')...!")

    AsrPlaySound("player_rewarded")
  else
    AsrNotify("Thanks for using our nametag, you have been rewarded!", ply)
  end

  AsrPlaySound("applause", ply)

  if ASR.ThrowConfettiOnNameTagConfirmed then
    AsrThrowConfetti(ply)
  end

  AsrUpdateTable(ply:SteamID())
end

//Network Messages

net.Receive("AsrNameTagCheck", function(_, ply)
  if !ASR.EnableNameTagRewards then return end

  if !ply:IsValid() or !ply:IsPlayer() then return end

  AsrCanBeNameTagRewarded(ply)

  ply:CheckAdvertiser()

  ply.IsCheckingName = true

  timer.Simple(1, function()
    if !ply:IsValid() then return end
    if !ply.CanUseTag then return end

    if ply.IsAdvertiser then
      AsrNameTagChecked(ply)
    else
      AsrNotify("Sorry, but we couldn't verify if you are currently using our name tag. Please, try again later!", ply)
    end

    ply.IsCheckingName = false
  end)
end)
