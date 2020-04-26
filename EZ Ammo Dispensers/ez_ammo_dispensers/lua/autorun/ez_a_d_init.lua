EZAD_Version = "1.0.3"

if SERVER then
	EZAD_AmmoTypes = {}
	EZAD_Lang = {}
	EZAD = {}

	include("ezad_language_config.lua")
	include("ez_a_d/language/ezad_lang_"..EZAD_Lang.uage..".lua")
	include("ez_a_d/server/sv_ezad_public_functions.lua")
	include("ezad_config.lua")
	include("ez_a_d/server/sv_ezad_main.lua")
	AddCSLuaFile("ezad_language_config.lua")
	AddCSLuaFile("ez_a_d/language/ezad_lang_"..EZAD_Lang.uage..".lua")
	AddCSLuaFile("ezad_config.lua")
	AddCSLuaFile("ez_a_d/client/cl_ezad_public_functions.lua")
	AddCSLuaFile("ez_a_d/client/cl_ezad_main.lua")

	if EZAD.WorkshopDownload or EZAD.ServerDownload then
		include("ez_a_d/server/sv_ezad_downloads.lua")
	end
end

if CLIENT then
	ammotable = {}
	EZAD_Lang = {}
	EZAD = {}

	include("ezad_language_config.lua")
	include("ez_a_d/language/ezad_lang_"..EZAD_Lang.uage..".lua")
	include("ez_a_d/client/cl_ezad_public_functions.lua")
	include("ezad_config.lua")
	include("ez_a_d/client/cl_ezad_main.lua")
end
