//Network Strings

util.AddNetworkString("AsrSteamGroupCheck")

//Functions

local function AsrCanBeGroupRewarded(ply)
  if !ASR.EnableSteamGroupRewards then return end

  if ply == nil or !ply:IsValid() or !ply:IsPlayer() or ply:IsBot() then

    return
  end

  if ply.IsCheckingMembership then
    AsrNotify("We are already checking your steam group membership, please wait!", ply)

    ply.CanUseGroup = false

    return
  end

  if ply:AsrIsGroupMember() then
    AsrNotify("You were already rewarded for joining our steam group!", ply)

    ply.CanUseGroup = false

    return
  end

  if ASR.RequiredMinutesOnServerForGroupReward > 0 then
    if math.floor(ply:GetUTimeTotalTime() / 60) < ASR.RequiredMinutesOnServerForGroupReward then
      AsrNotify("You have less than "..ASR.RequiredMinutesOnServerForGroupReward.." minutes played on this server, therefore, you can't get rewarded for joining our steam group yet.", ply)

      ply.CanUseGroup = false

      return
    end
  end

  if ASR.MinPlayTimeForGroupReward > 0 and (ASR.SteamAPIKey != "The key goes here" and ASR.SteamAPIKey != "") then
    ply:CheckTime()

    timer.Simple(0.5, function()
      if ply == nil or !ply:IsValid() then return end

      if ply.Playtime < ASR.MinPlayTimeForGroupReward then
        AsrNotify("You either have less than "..ASR.MinPlayTimeForGroupReward.." hours played on Garry's Mod, or a private Steam profile, therefore, you can't get rewarded for joining our steam group yet.", ply)

        ply.CanUseGroup = false

        return
      end
    end)
  end

  if ASR.CheckFamilyShareForGroupReward and (ASR.SteamAPIKey != "The key goes here" and ASR.SteamAPIKey != "") then
    ply:CheckShared()

    timer.Simple(0.5, function()
      if ply == nil or !ply:IsValid() then return end

      if ply.IsGameshared then
        AsrNotify("You are either playing on a family shared copy of Garry's Mod, or have a private Steam profile, therefore, you can't get rewarded for joining our steam group yet.", ply)

        ply.CanUseGroup = false

        return
      end
    end)
  end

  ply.CanUseGroup = true
end

local function AsrSteamGroupChecked(ply)
  if !ASR.EnableSteamGroupRewards then return end

  local nick = ply:AsrNick()

  ply:AsrSetGroupMember(1)

  AsrRewardPlayer(ply, 2)

  if ASR.GlobalNotificationOnMembershipConfirmed then
    AsrNotify(nick.." has joined our steam group and received a reward by confirming it with '!"..ASR.SteamGroupMenuCommand.."' (or '/"..ASR.SteamGroupMenuCommand.."')...!")

    AsrPlaySound("player_rewarded")
  else
    AsrNotify("Thanks for joining our steam group, you have been rewarded!", ply)
  end

  AsrPlaySound("applause", ply)

  if ASR.ThrowConfettiOnMembershipConfirmed then
    AsrThrowConfetti(ply)
  end

  AsrUpdateTable(ply:SteamID())
end

function AsrSendGroupInfo(ply)
  AsrGetGroupInfo()

  timer.Simple(0.5, function()

    net.Start("AsrUpdateGroup")
    net.WriteTable(asr_groupinfo)

    if ply == nil then
      net.Broadcast()
    elseif ply:IsPlayer() then
      net.Send(ply)
    end
  end)
end

//Network Messages

net.Receive("AsrSteamGroupCheck", function(_, ply)
  if !ASR.EnableSteamGroupRewards then return end

  if !ply:IsValid() or !ply:IsPlayer() then return end

  AsrCanBeGroupRewarded(ply)

  ply:CheckGroupMember()

  AsrNotify("Checking if you are part of our steam group...", ply)

  ply.IsCheckingMembership = true

  timer.Create(ply:SteamID64().."_AsrGroupCheck", 1.5, 20, function()
    if !ply:IsValid() then return end

    if !ply.CanUseGroup then
      ply.IsCheckingMembership = false

      timer.Remove(ply:SteamID64().."_AsrGroupCheck")

      return
    end

    if ply.IsGroupMember then
      ply.IsCheckingMembership = false

      AsrSteamGroupChecked(ply)

      timer.Remove(ply:SteamID64().."_AsrGroupCheck")
    elseif timer.RepsLeft(ply:SteamID64().."_AsrGroupCheck") == 0 then
      ply.IsCheckingMembership = false

      AsrNotify("Sorry, but we couldn't verify your group membership. If you just joined, please try again in some minutes!", ply)
    else
      ply:CheckGroupMember()
    end
  end)
end)
