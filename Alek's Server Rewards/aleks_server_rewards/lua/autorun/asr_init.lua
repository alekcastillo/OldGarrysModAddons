ASR = {}
ASR.Rewards = {}
ASR.Version = "2.0.8"

ASR.DebugMode= true

asr_data = {{steamid = "steamid", nick = "nick", refercode = "referc", referrer = "referrer", groupmember = 0, advertiser = 0, refers = 0}}
asr_groupinfo = {name = "", members = 0, imglink = ""}

include("asr_config.lua")
include("a_server_rewards/shared/sh_metafunctions.lua")

if SERVER then
	asr_pending = {{referrer = "referrer", referred = "referred"}}

	include("asr_mysql_config.lua")
	include("a_server_rewards/server/sv_rewards.lua")
	include("a_server_rewards/data_providers/sv_xml.lua")
	include("a_server_rewards/server/sv_web_functions.lua")
	include("a_server_rewards/server/sv_public_functions.lua")
	include("a_server_rewards/server/sv_main.lua")
	include("a_server_rewards/server/sv_console_commands.lua")
	include("a_server_rewards/server/sv_editing_functions.lua")
	include("a_server_rewards/server/sv_permanent_weapons.lua")
	include("a_server_rewards/server/sv_ps_items.lua")
	include("a_server_rewards/server/sv_ulx_groups.lua")

	AddCSLuaFile("asr_config.lua")
	AddCSLuaFile("a_server_rewards/client/cl_main.lua")
	AddCSLuaFile("a_server_rewards/client/cl_public_functions.lua")
	AddCSLuaFile("a_server_rewards/client/cl_players_tab.lua")
	AddCSLuaFile("a_server_rewards/client/cl_leaderboard_tab.lua")
	AddCSLuaFile("a_server_rewards/client/cl_steamgroup_tab.lua")
	AddCSLuaFile("a_server_rewards/client/cl_profile_tab.lua")
	AddCSLuaFile("a_server_rewards/client/cl_other_windows.lua")
	AddCSLuaFile("a_server_rewards/shared/sh_metafunctions.lua")
end

if CLIENT then
	asrLeadersTbl = {}
	asrTblChunks = {}
	asrDataStr = ""

	include("a_server_rewards/client/cl_main.lua")
	include("a_server_rewards/client/cl_public_functions.lua")
	include("a_server_rewards/client/cl_players_tab.lua")
	include("a_server_rewards/client/cl_leaderboard_tab.lua")
	include("a_server_rewards/client/cl_steamgroup_tab.lua")
	include("a_server_rewards/client/cl_profile_tab.lua")
	include("a_server_rewards/client/cl_other_windows.lua")
end
