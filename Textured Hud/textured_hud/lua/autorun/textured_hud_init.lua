if SERVER then
	AddCSLuaFile("textured_hud_config.lua")
	include("textured_hud_config.lua")
	AddCSLuaFile("textured_hud_themes/"..THUD.Theme..".lua")
	include("textured_hud_themes/"..THUD.Theme..".lua")
	if THUD.WorkshopDownload or THUD.ServerDownload then
		include("textured_hud_downloads.lua")
	end
end

if CLIENT then
	include("textured_hud_config.lua")
	include("textured_hud_themes/"..THUD.Theme..".lua")
end