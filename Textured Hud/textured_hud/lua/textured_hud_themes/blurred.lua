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

local globalTextBoxColor = Color(0, 0, 0, 100)

-----Main Hud-----
--Base
THUDTheme.MainHudBaseUseTexture = true

THUDTheme.MainHudBaseTexture = "pp/blurscreen"

THUDTheme.MainHudBaseColor = Color(34, 37, 40, 255)

THUDTheme.MainHudBaseTextBoxColor = globalTextBoxColor

THUDTheme.WantedTextBoxColor = globalTextBoxColor

THUDTheme.GunLicensedTextBoxColor = globalTextBoxColor

--Icons
THUDTheme.HPIconTexture = "materials/textured_hud/icons/hp_icon.png"

THUDTheme.ArmorIconTexture = "materials/textured_hud/icons/armor_icon.png"

--Bars
THUDTheme.HPBarBackgroundColor = Color(75, 0, 0, 100)

THUDTheme.HPBarColor = Color(255, 60, 60, 255)

THUDTheme.ArmorBarBackgroundColor = Color(0, 0, 75, 100)

THUDTheme.ArmorBarColor = Color(60, 99, 255, 255)

THUDTheme.HungerBarBackgroundColor = Color(100, 100, 40, 100)

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
THUDTheme.AgendaBaseUseTexture = true

THUDTheme.AgendaBaseTexture = "pp/blurscreen"

THUDTheme.AgendaBaseColor = Color(34, 37, 40, 255)

THUDTheme.AgendaTextBoxColor = globalTextBoxColor

--Text
THUDTheme.AgendaTitleTextColor = globalTextColor

THUDTheme.AgendaContentTextColor = globalTextColor

-----Ammo Viewer-----
--Base
THUDTheme.AmmoViewerBaseUseTexture = true

THUDTheme.AmmoViewerBaseTexture = "pp/blurscreen"

THUDTheme.AmmoViewerBaseColor = Color(34, 37, 40, 255)

THUDTheme.AmmoViewerTextBoxColor = globalTextBoxColor

--Text
THUDTheme.AmmoOnMagTextColor = globalTextColor

THUDTheme.AmmoOnInvTextColor = globalTextColor

THUDTheme.WeaponNameTextColor = globalTextColor

-----Lockdown Text-----
--Base
THUDTheme.LockdownTextBaseUseTexture = true

THUDTheme.LockdownTextBaseTexture = "pp/blurscreen"

THUDTheme.LockdownTextBaseColor = Color(34, 37, 40, 255)

--Text
THUDTheme.LockdownSubtitleTextColor = globalTextColor

-----Arrested Text-----
--Base
THUDTheme.ArrestedTextBaseUseTexture = true

THUDTheme.ArrestedTextBaseTexture = "pp/blurscreen"

THUDTheme.ArrestedTextBaseColor = Color(34, 37, 40, 255)

--Text
THUDTheme.ArrestedTextColor = globalTextColor

-----Players Info On Top Of Head-----
--Base
THUDTheme.PlayersInfoBaseUseTexture = true

THUDTheme.PlayersInfoBaseTexture = "pp/blurscreen"

THUDTheme.PlayersInfoBaseColor = Color(34, 37, 40, 255)

--Icons
THUDTheme.GunLicenseIconTexture = "icon16/page_white.png"

--Text
THUDTheme.PlayersInfoHealthTextColor = globalTextColor

THUDTheme.PlayersInfoJobTextColor = globalTextColor

-----Voice Chat-----
--Base
THUDTheme.VoiceChatTalkingBaseUseTexture = true

THUDTheme.VoiceChatTalkingBaseTexture = "pp/blurscreen"

THUDTheme.VoiceChatTalkingBaseColor = Color(34, 37, 40, 255)

THUDTheme.VoiceChatTextBoxColor = globalTextBoxColor

--Text
THUDTheme.VoiceChatTalkingTextColor = globalTextColor