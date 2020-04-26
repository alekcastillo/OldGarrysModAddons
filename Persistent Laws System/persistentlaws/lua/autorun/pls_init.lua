if SERVER then
	AddCSLuaFile("persistentlawssystem/persislaws_client.lua")
	AddCSLuaFile("persistentlawssystem/persislaws_config.lua")
	include("persistentlawssystem/persislaws_config.lua")
	include("persistentlawssystem/persislaws_main.lua")
end

if CLIENT then
	include("persistentlawssystem/persislaws_config.lua")
	include("persistentlawssystem/persislaws_client.lua")
end