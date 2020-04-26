print(".")

--[[

THIS IS A WIP

//Set refers
--User

function ulx.setRefers(calling_ply, target_ply, amount)
	if !amount then ULib.tsayError("Amount not specified!") return end
	if !target_ply:AsrIsRecorded() then ULib.tsayError("This player has not been recorded on the ASR system yet!") return end

	target_ply:AsrSetRefers(false, 1)

	DarkRP.notify(target_ply, 0, 4, calling_ply:Nick().." set your ASR refers to "..amount)
	ulx.fancyLogAdmin(calling_ply:Nick() .. " set "..target_ply:Nick().."'s ASR refers to "..amount)
end

local setRefers = ulx.command("Alek's Server Rewards", "ulx setrefers", ulx.setRefers, "!setrefers")
setRefers:addParam{type=ULib.cmds.PlayerArg}
setRefers:addParam{type=ULib.cmds.NumArg, hint="refers"}
setRefers:defaultAccess(ULib.ACCESS_ADMIN)
setRefers:help("Set a player's ASR refers.")

--SteamID

//Add refers
--User

--SteamID

function ulx.setReferrer(calling_ply, target_ply, level)
	if not level then ULib.tsayError("Level not specified!") return end
	if target_ply.DarkRPUnInitialized then return end
	DarkRP.storeXPData(target_ply,level,0)
        target_ply:setDarkRPVar('level',level)
        target_ply:setDarkRPVar('xp',0)
	DarkRP.notify(target_ply, 0,4,calling_ply:Nick() .. " set your level to "..level)
	ulx.fancyLogAdmin(calling_ply:Nick() .. ' set '..target_ply:Nick()..' level to '..level)
end

local setGroupMember = ulx.command("Server Rewards", "ulx setgroupmembership", ulx.setGroupMember, "!setgroupmembership")
setGroupMember:addParam{type=ULib.cmds.PlayerArg}
setGroupMember:addParam{type=ULib.cmds.NumArg, hint= "1 for true, 0 for false"}
setGroupMember:defaultAccess(ULib.ACCESS_ADMIN)
setGroupMember:help("Set if a player received the steam group reward.")

local set = ulx.command("Server Rewards", "ulx set", ulx.setLevel, "!set")
set:addParam{type=ULib.cmds.PlayerArg}
set:addParam{type=ULib.cmds.NumArg, hint= ""}
set:defaultAccess(ULib.ACCESS_ADMIN)
set:help("Set a player's .")

local set = ulx.command("Server Rewards", "ulx set", ulx.setLevel, "!set")
set:addParam{type=ULib.cmds.PlayerArg}
set:addParam{type=ULib.cmds.NumArg, hint= ""}
set:defaultAccess(ULib.ACCESS_ADMIN)
set:help("Set a player's .")

]]
