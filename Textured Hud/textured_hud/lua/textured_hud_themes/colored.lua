--[[

████████╗██╗  ██╗███████╗███╗   ███╗███████╗    ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
   ██║   ███████║█████╗  ██╔████╔██║█████╗      ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
   ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝      ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
   ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗    ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝    ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
                                                                                                               
]]

-----General Colors-----

local globalTextColor = Color(255, 255, 255, 255)

local healthAndarmorTextColor = Color(200, 200, 200, 100)

local globalTextBoxColor = Color(50, 50, 50, 150)

-----Main Hud-----
--Base
THUDTheme.MainHudBaseUseTexture = false

THUDTheme.MainHudBaseTexture = "materials/textured_hud/textures/"..THUD.DefaultTexture

THUDTheme.MainHudBaseColor = THUD.DefaultBasesColor

THUDTheme.MainHudBaseTextBoxColor = globalTextBoxColor

THUDTheme.WantedTextBoxColor = globalTextBoxColor

THUDTheme.GunLicensedTextBoxColor = globalTextBoxColor

--Icons
THUDTheme.HPIconTexture = "materials/textured_hud/icons/hp_icon.png"

THUDTheme.ArmorIconTexture = "materials/textured_hud/icons/armor_icon.png"

--Bars
THUDTheme.HPBarBackgroundColor = Color(75, 0, 0, 200)

THUDTheme.HPBarColor = Color(255, 60, 60, 255)

THUDTheme.ArmorBarBackgroundColor = Color(0, 0, 75, 200)

THUDTheme.ArmorBarColor = Color(60, 99, 255, 255)

THUDTheme.HungerBarBackgroundColor = Color(100, 100, 40, 200)

THUDTheme.HungerBarColor = Color(250, 275, 75, 255)

--Text
THUD.HPTextColor = healthAndarmorTextColor

THUDTheme.ArmorTextColor = healthAndarmorTextColor

THUDTheme.NameTextColor = globalTextColor

THUDTheme.JobTextColor = globalTextColor

THUDTheme.MoneyTextColor = globalTextColor

THUDTheme.GunLicensedTextColor = globalTextColor

-----Agenda-----
--Base
THUDTheme.AgendaBaseUseTexture = false

THUDTheme.AgendaBaseTexture = "materials/textured_hud/textures/"..THUD.DefaultTexture

THUDTheme.AgendaBaseColor = THUD.DefaultBasesColor

THUDTheme.AgendaTextBoxColor = globalTextBoxColor

--Text
THUDTheme.AgendaTitleTextColor = globalTextColor

THUDTheme.AgendaContentTextColor = globalTextColor

-----Ammo Viewer-----
--Base
THUDTheme.AmmoViewerBaseUseTexture = false

THUDTheme.AmmoViewerBaseTexture = "materials/textured_hud/textures/"..THUD.DefaultTexture

THUDTheme.AmmoViewerBaseColor = THUD.DefaultBasesColor

THUDTheme.AmmoViewerTextBoxColor = globalTextBoxColor

--Text
THUDTheme.AmmoOnMagTextColor = globalTextColor

THUDTheme.AmmoOnInvTextColor = globalTextColor

THUDTheme.WeaponNameTextColor = globalTextColor

-----Lockdown Text-----
--Base
THUDTheme.LockdownTextBaseUseTexture = false

THUDTheme.LockdownTextBaseTexture = "materials/textured_hud/textures/"..THUD.DefaultTexture

THUDTheme.LockdownTextBaseColor = THUD.DefaultBasesColor

--Text
THUDTheme.LockdownSubtitleTextColor = globalTextColor

-----Arrested Text-----
--Base
THUDTheme.ArrestedTextBaseUseTexture = false

THUDTheme.ArrestedTextBaseTexture = "materials/textured_hud/textures/"..THUD.DefaultTexture

THUDTheme.ArrestedTextBaseColor = THUD.DefaultBasesColor

--Text
THUDTheme.ArrestedTextColor = globalTextColor

-----Players Info On Top Of Head-----
--Base
THUDTheme.PlayersInfoBaseUseTexture = false

THUDTheme.PlayersInfoBaseTexture = "materials/textured_hud/textures/"..THUD.DefaultTexture

THUDTheme.PlayersInfoBaseColor = THUD.DefaultBasesColor

--Icons
THUDTheme.GunLicenseIconTexture = "icon16/page_white.png"

--Text
THUDTheme.PlayersInfoHealthTextColor = globalTextColor

THUDTheme.PlayersInfoJobTextColor = globalTextColor

-----Voice Chat-----
--Base
THUDTheme.VoiceChatTalkingBaseUseTexture = false

THUDTheme.VoiceChatTalkingBaseTexture = "materials/textured_hud/textures/"..THUD.DefaultTexture

THUDTheme.VoiceChatTalkingBaseColor = THUD.DefaultBasesColor

THUDTheme.VoiceChatTextBoxColor = globalTextBoxColor

--Text
THUDTheme.VoiceChatTalkingTextColor = globalTextColor