
-- READ THIS: Don't edit any of this settings while your server is running, it will cause major lua issues; always restart your server after editing this file!

THUD = {}
THUDTheme = {}

--[[

 ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗         ██╗  ██╗██╗   ██╗██████╗     ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║         ██║  ██║██║   ██║██╔══██╗    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║         ███████║██║   ██║██║  ██║    ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║         ██╔══██║██║   ██║██║  ██║    ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗    ██║  ██║╚██████╔╝██████╔╝    ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
 ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝     ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

]]

THUD.WorkshopDownload = false
THUD.ServerDownload = true
--[[ These 2 settings do the same thing, they both make every player who joins the server
automatically download the 2 icons and 11 textured (about 1mb of download) needed for the HUD
to look correctly, however, I recommend having the WorkshopDownload to true and the ServerDownload
to false since not all Garry's Mod hosts support server downloads. ]]

THUD.ShowAvatar = true
--[[ Set this to false if you don't want the Steam Avatar to be shown in the hud. ]]

THUD.ShowHungerBar = false
--[[ Set this to true if you are using Hunger Mod and want a Energy bar to be shown in the hud. ]]

THUD.EnableCustomAgenda = true
--[[ Set this to false if you want to use your own custom agenda viewer. ]]

THUD.EnableCustomAmmoBox = true
--[[ Set this to false if you want to use your own custom ammo box viewer. ]]

THUD.EnableCustomVoiceIcon = true
--[[ Set this to false if you want to use your own custom voice chat overlay. ]]

THUD.DrawTexturedBaseOnPlayersInfo = true
--[[ Set this to false if you want to hide the textured base on top of players' head, and show only the text. ]]

--[[

████████╗███████╗██╗  ██╗████████╗    ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
╚══██╔══╝██╔════╝╚██╗██╔╝╚══██╔══╝    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
   ██║   █████╗   ╚███╔╝    ██║       ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
   ██║   ██╔══╝   ██╔██╗    ██║       ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
   ██║   ███████╗██╔╝ ██╗   ██║       ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝       ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

]]

THUD.VoiceChatTalkingText = "Talking"
--[[ This is the text that will be shown when you activate your voicechat. ]]

THUD.NoAgendaText = "There's no agenda set!"
--[[ This is the text that will be shown when there's no agenda set. ]]

THUD.PlayerWantedText = "Wanted!"
--[[ This is the text that will be shown when you are wanted by the police. ]]

THUD.LockdownTitleText = "Lockdown!"
--[[ This is the title of the box that will be shown when there's an active lockdown on the city. ]]

THUD.LockdownSubtitleText = "Everyone outside will be arrested on sight."
--[[ This is the subtitle of the box that will be shown when there's an active lockdown on the city. ]]

--[[

████████╗██╗  ██╗███████╗███╗   ███╗███████╗    ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
   ██║   ███████║█████╗  ██╔████╔██║█████╗      ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
   ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝      ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
   ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗    ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝    ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

]]

THUD.Theme = "blurred"
--[[ Here you can specify the desired colors and icons theme you want to use.

---Default Themes---
"colored"
"blurred"
"textured"

--- How to add your own themes ---
1. Theme files are located on textured_hud/lua/textured_hud_themes.
2. The themes must have a lua format.
3. To create a custom theme, copy and paste the default one, change the file's name, and edit it with your likings.
4. After you create and save your team, simply write its file name in the THUD.Theme setting (without the .lua).
5. Enjoy your unique HUD C:
]]

-----SETTINGS FOR THE "colored" THEME--------------------------------------------------------------------------------

THUD.DefaultBasesColor = Color(34, 37, 40, 255)
--[[ Write here the color you want all the hud bases/backgrounds to have. ]]

-----SETTINGS FOR THE "blurred" THEME--------------------------------------------------------------------------------

THUD.BlurIntensity = 5
--[[ Set here the intensity you want for the blur with a number from 1 to 10. ]]

-----SETTINGS FOR THE "textured" THEME-------------------------------------------------------------------------------

THUD.DefaultTexture = "woodplanks2.png"
--[[ Write here the name of the texture you want to use as background for everything on the hud.

--- Default Textures ---
"woodplanks.png"
"woodplanks2.png"
"bricks.png"
"crackles.png"
"grass.png"
"metal.png"
"paper.png"
"plastic.png"
"rock.png"
"rust.png"
"tiles.png"

--- How to add your own textures ---
1. Texture files are located on textured_hud/materials/textured_hud/textures.
2. They can be any format you want, but the recommended one is png.
3. The recommended dimensions for the textures are 350 x 130.
4. After you place your 350 x 130 png texture in the textured_hud/materials/textured_hud/textures,
simply write its file name in the THUD.DefaultTexture setting (with the .png, or .jpg, or whatever format it is).
5. Enjoy your unique HUD C:
]]
