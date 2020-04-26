if SERVER then
	AddCSLuaFile("cartoon_hud_config.lua")
	AddCSLuaFile("cartoon_hud_theme_config.lua")
	include("cartoon_hud_config.lua")
	if CartoonHudConfig.ActivatePredifinedLaws then
		AddCSLuaFile("cartoon_hud_client.lua")
		include("cartoon_hud_main.lua")
	end
	if CartoonHudConfig.AutoDownloadMaterials then
		resource.AddSingleFile( 'materials/cartoonhud/hp_icon.png' )
		resource.AddSingleFile( 'materials/cartoonhud/armor_icon.png' )
		resource.AddSingleFile( 'materials/cartoonhud/paycheck_icon.png' )
		resource.AddSingleFile( 'materials/cartoonhud/wallet_icon.png' )
	end
end

if CLIENT then
	include("cartoon_hud_config.lua")
	include("cartoon_hud_theme_config.lua")
	if CartoonHudConfig.ActivatePredifinedLaws then
		include("cartoon_hud_client.lua")
	end
end