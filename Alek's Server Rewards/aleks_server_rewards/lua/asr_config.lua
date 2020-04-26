--[[

██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗
██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║
██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║
██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║
╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗
╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

]]

ASR.WorkshopDownload = true
ASR.ServerDownload = false
--[[ These 2 settings do the same thing, they both make every player who joins the server
automatically download the 3 icons needed for the menu to look correctly, however, I recommend
having the WorkshopDownload to true and the ServerDownload to false since not all Garry's Mod
hosts support serverdl. ]]

ASR.EnableUIAnimations = true
--[[ Animations can be laggy on low end computers and / or very consuming servers, so, you can
set this to false to disable them completely. ]]

ASR.MenuCommand = "rewards"
--[[ The command you want players to use in order to open the server rewards menu.
(Without the ! or /). ]]

ASR.ChatTag = "[ASR]"
--[[ The chat tag shown before all the reward related messages on the chat box. ]]

ASR.ChatTagColor = Color(90, 210, 255)
--[[ The color of the chat tag shown before all the reward related messages on the chat box. ]]

ASR.LeaderboardExtraSpots = 9
--[[ Set this to the number of extra spots you want to be shown in the refers leaderboard.
By default, this is set to 9, which means it will show the 3 first spots, and the other 9, showing
a total of 12 leaderboard members. If you are gonna enable this, set it to a number higher than 1,
or it will look kind of weird.
Set to 0 to disable. ]]

ASR.AlwaysShowExtraLeaderboardSpots = false
--[[ If this is true, the LeaderboardExtraSpots will always be shown, even when there's not
enough players to fill them. If this is set to false, if will only show the used leaderboard
spots. ]]

--[[

████████╗██╗  ██╗███████╗███╗   ███╗███████╗
╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
   ██║   ███████║█████╗  ██╔████╔██║█████╗
   ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
   ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝

]]

ASR.Theme_AccentColor = Color(90, 210, 255)
--[[ The nice color that special things, like titles or selected buttons will have.
(bright blue by default) ]]

ASR.Theme_RainbowAccentColor = false
--[[ Pretty self explanatory tbh... ]]

--[[

██╗    ██╗███████╗██████╗
██║    ██║██╔════╝██╔══██╗
██║ █╗ ██║█████╗  ██████╔╝
██║███╗██║██╔══╝  ██╔══██╗
╚███╔███╔╝███████╗██████╔╝
 ╚══╝╚══╝ ╚══════╝╚═════╝

]]

ASR.SteamAPIKey = "The key goes here"
--[[ Write here your Steam Web Api Key. You can get it from here:
http://steamcommunity.com/dev/apikey

Remember, you only have to do this if you have the playtime or family share check activated
on any reward! ]]

--[[

██████╗ ███████╗███████╗███████╗██████╗ ██████╗  █████╗ ██╗     ███████╗
██╔══██╗██╔════╝██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██║     ██╔════╝
██████╔╝█████╗  █████╗  █████╗  ██████╔╝██████╔╝███████║██║     ███████╗
██╔══██╗██╔══╝  ██╔══╝  ██╔══╝  ██╔══██╗██╔══██╗██╔══██║██║     ╚════██║
██║  ██║███████╗██║     ███████╗██║  ██║██║  ██║██║  ██║███████╗███████║
╚═╝  ╚═╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝

]]

--[[ General ]]

ASR.ReferralCodeCommand = "referralcode"
--[[ The command you want players to use in order to open the referral code entering menu to confirm
their referrer.
(Without the ! or /). ]]

ASR.CooldownTimer = 60
--[[ The cooldown a player must wait after sending a referral confirmation before sending another one.
I recomnmend setting this to 60 or more to avoid confirmations spamming. ]]

ASR.AutocloseConfirmationTimer = 25
--[[ The time before a referral confirmation box closes automatically. ]]

ASR.MaxReferrablePlayers = 0
--[[ Use this if you want to limit how many players a player can get rewarded for referring.
After he reaches this number, he will still get leaderboard points, but won't get rewarded.
Set to 0 to disable. ]]

ASR.ReferralRemindersInterval = 0 * 60
--[[ The amount of seconds between the message that players will receive reminding them that they
can get rewarded for inviting players to the server.
(60 SECONDS = 1 MINUTE)
Set to 0 to disable. ]]

ASR.ReferralReminderText = "Remember that you can get rewarded for inviting players to the server and confirming it with '!rewards' (or '/rewards')...!"

ASR.ThrowConfettiOnReferralConfirmed = true
--[[ Set this to false if you want to disable the confetti when someone confirms a referral
(Lame if you set it to false :,C) ]]

ASR.GlobalNotificationOnReferralConfirmed = true
--[[ Set this to false if you want to disable the global message when someone confirms a
referral. ]]

--[[ Restrictions ]]

ASR.RequiredMinutesOnServerForReferReward = 0 * 60
--[[ Use this if you use UTime and want players with less played minutes on your server than the ones specified
not able to refer or reward other players. This can be used to prevent reward duplication.
(60 MINUTES = 1 HOUR)
Set to 0 to disable. ]]

ASR.MinPlayTimeForReferReward = 0
--[[ The minimum hours played on Garry's Mod required to be able to reward or be rewarded for a referral.
Set to 0 to disable. ]]

ASR.CheckFamilyShareForReferReward = false
--[[ If you don't want gameshared account to be able to reward or be rewarded for a referral, set this to true. ]]

--[[ Rewards ]]

--[[ These settings are very self explanatory. A player will get these rewards each time someone confirms
he/she was referred by him to the server. ]]

ASR.DarkRPMoneyPerRefer = 2500

ASR.UnderdoneRPGMoneyPerRefer = 0

ASR.TTTKarmaPerRefer = 0

ASR.PointshopPointsPerRefer = 0

ASR.PointshopItemsPerRefer = {
  --{requiredReferrals = 5, item = "pistol"},
  --{requiredReferrals = 10, item = "smg"}
  --set the requiredReferrals to 0 if you want players to get the item on every referral
}

ASR.Pointshop2PointsPerRefer = 0

ASR.Pointshop2PremiumPointsPerRefer = 0

ASR.Pointshop2ItemsPerRefer = {
  --{requiredReferrals = 5, item = "more_expensive_pistol"},
  --{requiredReferrals = 10, item = "more_expensive_smg"}
  --set the requiredReferrals to 0 if you want players to get the item on every referral
}

ASR.VrondakisXPPerRefer = 0

ASR.LevelUpXPPerRefer = 0

ASR.GLevelXPPerRefer = 0

ASR.ELevelXPPerRefer = 0

ASR.BlueUnboxingCratesPerRefer = 0

ASR.BlueUnboxingKeysPerRefer = 0

ASR.PermanentWeaponsPerRefer = {
  --{requiredReferrals = 10, weaponClass = "m9k_1911"},
  --{requiredReferrals = 20, weaponClass = "m9k_ak47"}
}

ASR.GiveAllPermanentWeaponsPerRefer = false
--[[ Set this to true if you want players to receive all the weapons they apply for, if not, they will
just receive the higher one in requiredReferrals that they are able to get. ]]

ASR.UlxGroupPerRefer = {
  --{requiredReferrals = 5, group = "member"},
  --{requiredReferrals = 10, group = "vipmember"}
}

--ASR.CustomRewardPerRefer = function(ply) end
--[[ FOR DEVELOPERS | This is the function ran everytime someone confirms he/she was referred by someone
to the server. The ply parameter is the referrer player. Use this in case you want to add any custom reward. ]]

--[[

███████╗████████╗███████╗ █████╗ ███╗   ███╗     ██████╗ ██████╗  ██████╗ ██╗   ██╗██████╗
██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║    ██╔════╝ ██╔══██╗██╔═══██╗██║   ██║██╔══██╗
███████╗   ██║   █████╗  ███████║██╔████╔██║    ██║  ███╗██████╔╝██║   ██║██║   ██║██████╔╝
╚════██║   ██║   ██╔══╝  ██╔══██║██║╚██╔╝██║    ██║   ██║██╔══██╗██║   ██║██║   ██║██╔═══╝
███████║   ██║   ███████╗██║  ██║██║ ╚═╝ ██║    ╚██████╔╝██║  ██║╚██████╔╝╚██████╔╝██║
╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝     ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝

]]

--[[ General ]]

ASR.EnableSteamGroupRewards = true
--[[ Set this to false if you want to disable the Steam group rewards part of this system, and
everything related to it entirely. You can re-enable this if you need to at any time. ]]

ASR.SteamGroupMenuCommand = "steam"
--[[ The command you want players to use in order to open the menu to confirm that they joined the
steam group and get rewarded.
(Without the ! or /). ]]

ASR.OpenSteamGroupWindowOnJoin = true
--[[ If this is set to true, players will get the "Join our steam group and get rewarded" window
each time they join the server. ]]

ASR.GroupInfoRefreshTime = 120
--[[ This is the interval before the "group members" text shown on the Steam group menu updates. ]]

ASR.SteamGroupLink = "http://steamcommunity.com/groups/abstract_gaming_group"
--[[ The Steam group link of the Steam group you want players rewarded for joining. ]]

ASR.SteamGroupRemindersInterval = 0 * 60
--[[ The amount of seconds between the message that players will receive reminding them that they
can get rewarded for joining the server's Steam group.
(60 SECONDS = 1 MINUTE)
Set to 0 to disable. ]]

ASR.SteamGroupReminderText = "Remember that you can get rewarded for joining the server's Steam group with '!steam' (or '/steam')...!"

ASR.ThrowConfettiOnMembershipConfirmed = true
--[[ Set this to false if you want to disable the confetti when someone joins the Steam group.
(Lame if you set it to false :,C) ]]

ASR.GlobalNotificationOnMembershipConfirmed = true
--[[ Set this to false if you want to disable the global message when someone joins the Steam group. ]]

--[[ Restrictions ]]

ASR.RequiredMinutesOnServerForGroupReward = 0 * 60
--[[ Use this if you use UTime and want players with less played minutes on your server than the ones specified
not able to get rewarded for joining the Steam group. This can be used to prevent reward duplication.
(60 MINUTES = 1 HOUR)
Set to 0 to disable. ]]

ASR.MinPlayTimeForGroupReward = 0
--[[ The minimum hours played on Garry's Mod required to be able to be rewarded for joining the Steam group.
Set to 0 to disable. ]]

ASR.CheckFamilyShareForGroupReward = false
--[[ Another way of preventing rewards duplication is by setting this to true. Once this is activated,
family shared accounts (accounts who are playing Garry's Mod but didn't buy it) won't be able to
get rewarded for joining the Steam group. ]]

--[[ Rewards ]]

--[[ These settings are very self explanatory. A player will get these rewards each time someone confirms
he/she joined the Steam group. ]]

ASR.DarkRPMoneyOnGroupJoin = 5000

ASR.UnderdoneRPGMoneyOnGroupJoin = 0

ASR.TTTKarmaOnGroupJoin = 0

ASR.PointshopPointsOnGroupJoin = 0

ASR.PointshopItemsOnGroupJoin = {
  --"pistol",
  --"smg"
}

ASR.Pointshop2PointsOnGroupJoin = 0

ASR.Pointshop2PremiumPointsOnGroupJoin = 0

ASR.Pointshop2ItemsOnGroupJoin = {
  --"more_expensive_pistol",
  --"more_expensive_smg"
}

ASR.VrondakisXPOnGroupJoin = 0

ASR.LevelUpXPOnGroupJoin = 0

ASR.GLevelXPOnGroupJoin = 0

ASR.ELevelXPOnGroupJoin = 0

ASR.BlueUnboxingCratesOnGroupJoin = 0

ASR.BlueUnboxingKeysOnGroupJoin = 0

ASR.PermanentWeaponsOnGroupJoin = {
  --"m9k_1911",
  --"m9k_ak47"
}

ASR.UlxGroupOnGroupJoin = ""

--ASR.CustomRewardOnGroupJoin = function(ply) end
--[[ FOR DEVELOPERS | This is the function ran when someone confirms he/she has joined the Steam group.
The ply parameter is the player. Use this in case you want to add any custom reward. ]]

--[[

███╗   ██╗ █████╗ ███╗   ███╗███████╗    ████████╗ █████╗  ██████╗
████╗  ██║██╔══██╗████╗ ████║██╔════╝    ╚══██╔══╝██╔══██╗██╔════╝
██╔██╗ ██║███████║██╔████╔██║█████╗         ██║   ███████║██║  ███╗
██║╚██╗██║██╔══██║██║╚██╔╝██║██╔══╝         ██║   ██╔══██║██║   ██║
██║ ╚████║██║  ██║██║ ╚═╝ ██║███████╗       ██║   ██║  ██║╚██████╔╝
╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝       ╚═╝   ╚═╝  ╚═╝ ╚═════╝

]]

--[[ General ]]

ASR.EnableNameTagRewards = true
--[[ Set this to false if you want to disable the Steam name tag rewards part of this system, and
everything related to it entirely. You can re-enable this if you need to at any time. ]]

ASR.NameTagMenuCommand = "nametag"
--[[ The command you want players to use in order to open the name tag confirmation menu to
confirm that they are using the server's nametag and get rewarded.
(Without the ! or /). ]]

ASR.ServerNameTag = "[AG]"
--[[ The nametag players will be rewarded for using. Try not making it too big (you can if you want,
but it looks silly). ]]

ASR.NameTagRemindersInterval = 0 * 60
--[[ The amount of seconds between the message that players will receive reminding them that they
can get rewarded for using the server's name tag.
(60 SECONDS = 1 MINUTE)
Set to 0 to disable. ]]

ASR.NameTagReminderText = "Remember that you can get rewarded for using the server's name tag with '!steam' (or '/steam')...!"

ASR.ThrowConfettiOnNameTagConfirmed = true
--[[ Set this to false if you want to disable the confetti when someone confirms he's using the server tag.
(Lame if you set it to false :,C) ]]

ASR.GlobalNotificationOnNameTagConfirmed = true
--[[ Set this to false if you want to disable the global message when someone confirms that he's
using the server's nametag. ]]

--[[ Restrictions ]]

ASR.RequiredMinutesOnServerForNameTagReward = 0
--[[ Use this if you use UTime and want players with less played minutes on your server than the ones specified
not able to get rewarded for using the server's nametag. This can be used to prevent reward duplication.
(60 MINUTES = 1 HOUR)
Set to 0 to disable. ]]

ASR.MinPlayTimeForNameTagReward = 0
--[[ The minimum hours played on Garry's Mod required to be rewarded for using the server's name tag.
Set to 0 to disable. ]]

ASR.CheckFamilyShareForNameTagReward = false
--[[ If you don't want gameshared account to be rewarded for having the server's
nametag, set this to true. ]]

--[[ Rewards ]]

ASR.DarkRPMoneyOnNameTagCheck = 5000

ASR.UnderdoneRPGMoneyOnNameTagCheck = 0

ASR.TTTKarmaOnNameTagCheck = 0

ASR.PointshopPointsOnNameTagCheck = 0

ASR.PointshopItemsOnNameTagCheck = {
  --"pistol",
  --"smg"
}

ASR.Pointshop2PointsOnNameTagCheck = 0

ASR.Pointshop2PremiumPointsOnNameTagCheck = 0

ASR.Pointshop2ItemsOnNameTagCheck = {
  --"more_expensive_pistol",
  --"more_expensive_smg"
}

ASR.VrondakisXPOnNameTagCheck = 0

ASR.LevelUPXPOnNameTagCheck = 0

ASR.GLevelXPOnNameTagCheck = 0

ASR.ELevelXPOnNameTagCheck = 0

ASR.BlueUnboxingCratesOnNameTagCheck = 0

ASR.BlueUnboxingKeysOnNameTagCheck = 0

ASR.PermanentWeaponsOnNameTagCheck = {
  --"m9k_1911",
  --"m9k_ak47"
}

ASR.UlxGroupOnNameTagCheck = ""

--ASR.CustomRewardOnNameTagCheck = function(ply) end
--[[ FOR DEVELOPERS | This is the function ran when someone confirms he/she has is using the server's
name tag. The ply parameter is the player. Use this in case you want to add any custom reward. ]]
