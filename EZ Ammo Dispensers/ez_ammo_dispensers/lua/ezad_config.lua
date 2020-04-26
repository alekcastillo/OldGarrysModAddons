--[[
                                        _____      _   _   _                 
     /\                                / ____|    | | | | (_)                
    /  \   _ __ ___  _ __ ___   ___   | (___   ___| |_| |_ _ _ __   __ _ ___ 
   / /\ \ | '_ ` _ \| '_ ` _ \ / _ \   \___ \ / _ \ __| __| | '_ \ / _` / __|
  / ____ \| | | | | | | | | | | (_) |  ____) |  __/ |_| |_| | | | | (_| \__ \
 /_/    \_\_| |_| |_|_| |_| |_|\___/  |_____/ \___|\__|\__|_|_| |_|\__, |___/
                                                                    __/ |    
                                                                   |___/    
]]
--[[-------------------------------------------------------------------------
					How to add more ammo types
-----------------------------------------------------------------------------
To add a new ammo type, simply follow this format:

EZAD_AddAmmoType("Name shown in the UI", "Name of the ammo type itself", "Path to the model", Ammount of bullets, Price type, Price)

'What does the "price type" thing means?' Simple, if you want the ammo to be buyable by roleplay money, set it to 1, if you want it to 
be buyable with pointshop 1 points, set it to 2, and if you want it to be buyable with pointshop 2 points, set it to 3.

Example:

Let's say I want to make the default HL2 buckshot ammo type, with "Example AMMO" as its name in the UI, an office chair as a model, 
giving 50 bullets per buy and costing 12 pointshop 1 points. The line would look like this:

EZAD_AddAmmoType("Example AMMO", "buckshot", "models/props_c17/chair02a.mdl", 50, 2, 12)

If I wanted it to cost $12 instead of 12 pointshop 1 points, it would be:

EZAD_AddAmmoType("Example AMMO", "buckshot", "models/props_c17/chair02a.mdl", 50, 1, 12)

]]

EZAD_AddAmmoType("Pistol Ammo", "pistol", "models/items/boxsrounds.mdl", 12, 1, 18)
EZAD_AddAmmoType("Magnum Ammo", "357", "models/Items/357ammobox.mdl", 12, 1, 20)
EZAD_AddAmmoType("SMG Ammo", "smg1", "models/items/boxmrounds.mdl", 30, 1, 60)
EZAD_AddAmmoType("Assault Rifle Ammo", "ar2", "models/Items/ammocrate_ar2.mdl", 30, 1, 90)
EZAD_AddAmmoType("Shotgun Ammo", "buckshot", "models/Items/BoxBuckshot.mdl", 8, 1, 16)
EZAD_AddAmmoType("Sniper Rifle Ammo", "SniperPenetratedRound", "models/props_junk/cardboard_box003a.mdl", 10, 1, 40)

EZAD.WorkshopDownload = true
EZAD.ServerDownload = false
--[[ These 2 settings do the same thing, they both make every player who joins the server
automatically download the 2 icons needed for the UI to look correctly, however, I recommend
having the WorkshopDownload to true and the ServerDownload to false since not all Garry's Mod
hosts support server downloads. ]]

--[[
  _______ _                            _____      _   _   _                 
 |__   __| |                          / ____|    | | | | (_)                
    | |  | |__   ___ _ __ ___   ___  | (___   ___| |_| |_ _ _ __   __ _ ___ 
    | |  | '_ \ / _ \ '_ ` _ \ / _ \  \___ \ / _ \ __| __| | '_ \ / _` / __|
    | |  | | | |  __/ | | | | |  __/  ____) |  __/ |_| |_| | | | | (_| \__ \
    |_|  |_| |_|\___|_| |_| |_|\___| |_____/ \___|\__|\__|_|_| |_|\__, |___/
                                                                   __/ |    
                                                                  |___/    
]]

EZAD.DispenserModel = "models/props_interiors/VendingMachineSoda01a.mdl"

EZAD.Theme_AccentColor = Color(250, 255, 50, 255)

EZAD.Theme_RainbowAccentColor = false

EZAD.Theme_ColoredBorders = true

EZAD.ChatTagColor = Color(250, 255, 50, 255)

EZAD.ChatTag = "[EZAD]"

--[[
   _____                                          _     
  / ____|                                        | |    
 | |     ___  _ __ ___  _ __ ___   __ _ _ __   __| |___ 
 | |    / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
 | |___| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
  \_____\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
                                                        
                                                      
save_ezad - Saves the positions of all the Ammo Dispensers

reset_ezad - Resets the saved positions of all the Ammo Dispensers.

review_ezad - Post a review of EZ Ammo Dispensers on Scriptfodder <3

reload_ezad - Resends the ammo types table to all the players on the server.

version_ezad - Prints your version of EZ Ammo Dispensers (useful on support tickets)

]]

