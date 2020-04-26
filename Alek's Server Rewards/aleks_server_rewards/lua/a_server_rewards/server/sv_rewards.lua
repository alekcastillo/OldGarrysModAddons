//Network Strings

util.AddNetworkString("AsrConfetti")

//Functions

local function AsrSpecificRewards(ply, act)
  if act == 1 and ASR.CustomRewardPerRefer then
    ASR.CustomRewardPerRefer(ply)
  elseif act == 2 and ASR.CustomRewardOnGroupJoin then
    ASR.CustomRewardOnGroupJoin(ply)
  elseif act == 2 and ASR.CustomRewardOnNameTagCheck then
    ASR.CustomRewardOnNameTagCheck(ply)
  end

  AsrGivePointshopItems(ply, act)
  AsrGivePointshop2Items(ply, act)
  AsrGiveULXGroup(ply, act)
end

function AsrPrepareRewards()
  ASR.Rewards.DarkRPMoney = {ASR.DarkRPMoneyPerRefer, ASR.DarkRPMoneyOnGroupJoin, ASR.DarkRPMoneyOnNameTagCheck}

  ASR.Rewards.UnderdoneRPGMoney = {ASR.UnderdoneRPGMoneyPerRefer, ASR.UnderdoneRPGMoneyOnGroupJoin, ASR.UnderdoneRPGMoneyOnNameTagCheck}

  ASR.Rewards.TTTKarma = {ASR.TTTKarmaPerRefer, ASR.TTTKarmaOnGroupJoin, ASR.TTTKarmaOnNameTagCheck}

  ASR.Rewards.PointshopPoints = {ASR.PointshopPointsPerRefer, ASR.PointshopPointsOnGroupJoin, ASR.PointshopPointsOnNameTagCheck}

  ASR.Rewards.Pointshop2Points = {ASR.Pointshop2PointsPerRefer, ASR.Pointshop2PointsOnGroupJoin, ASR.Pointshop2PointsOnNameTagCheck}

  ASR.Rewards.Pointshop2PremiumPoints = {ASR.Pointshop2PremiumPointsPerRefer, ASR.Pointshop2PremiumPointsOnGroupJoin, ASR.Pointshop2PremiumPointsOnNameTagCheck}

  ASR.Rewards.VrondakisXP = {ASR.VrondakisXPPerRefer, ASR.VrondakisXPOnGroupJoin, ASR.VrondakisXPOnNameTagCheck}

  ASR.Rewards.LevelUpXp = {ASR.LevelUpXPPerRefer, ASR.LevelUpXPOnGroupJoin, ASR.LevelUPXPOnNameTagCheck}

  ASR.Rewards.GLevelXP = {ASR.GLevelXPPerRefer, ASR.GLevelXPOnGroupJoin, ASR.GLevelXPOnNameTagCheck}

  ASR.Rewards.ELevelXP = {ASR.ELevelXPPerRefer, ASR.ELevelXPOnGroupJoin, ASR.ELevelXPOnNameTagCheck}

  ASR.Rewards.BlueUnboxingCrates = {ASR.BlueUnboxingCratesPerRefer, ASR.BlueUnboxingCratesOnGroupJoin, ASR.BlueUnboxingCratesOnNameTagCheck}

  ASR.Rewards.BlueUnboxingKeys = {ASR.BlueUnboxingKeysPerRefer, ASR.BlueUnboxingKeysOnGroupJoin, ASR.BlueUnboxingKeysOnNameTagCheck}
end

function AsrRewardPlayer(ply, act)
	if ASR.Rewards.DarkRPMoney[act] > 0 then
		ply:addMoney(ASR.Rewards.DarkRPMoney[act])
	end

  if ASR.Rewards.UnderdoneRPGMoney[act] > 0 then
    ply:AddItem("money", ASR.Rewards.UnderdoneRPGMoney[act])
  end

	if ASR.Rewards.TTTKarma[act] > 0 then
    local maxRew = GetConVar("ttt_karma_max")
    maxRew = maxRew:GetFloat()

		ply:SetLiveKarma(math.min(ply:GetLiveKarma() + ASR.Rewards.TTTKarma[act], maxRew))
	end

	if ASR.Rewards.PointshopPoints[act] > 0 then
		ply:PS_GivePoints(ASR.Rewards.PointshopPoints[act])
	end

	if ASR.Rewards.Pointshop2Points[act] > 0 then
		ply:PS2_AddStandardPoints(ASR.Rewards.Pointshop2Points[act])
	end

	if ASR.Rewards.Pointshop2PremiumPoints[act] > 0 then
		ply:PS2_AddPremiumPoints(ASR.Rewards.Pointshop2PremiumPoints[act])
	end

	if ASR.Rewards.VrondakisXP[act] > 0 then
		ply:addXP(ASR.Rewards.VrondakisXP[act], true)
	end

  if ASR.Rewards.LevelUpXp[act] > 0 then
    levelup.increaseExperience(ply, ASR.Rewards.LevelUpXp[act])
  end

  if ASR.Rewards.GLevelXP[act] > 0 then
    gLevel.giveExp(ply, ASR.Rewards.GLevelXP[act])
  end

  if ASR.Rewards.ELevelXP[act] > 0 then
    ply:addEXP(ASR.Rewards.ELevelXP[act])
  end

  if ASR.Rewards.BlueUnboxingCrates[act] > 0 then
    ply:AddCrates(ASR.Rewards.BlueUnboxingCrates[act])
  end

  if ASR.Rewards.BlueUnboxingKeys[act] > 0 then
    ply:AddKeys(ASR.Rewards.BlueUnboxingKeys[act])
  end

  AsrGiveWeapons(ply)
  AsrSpecificRewards(ply, act)
end
