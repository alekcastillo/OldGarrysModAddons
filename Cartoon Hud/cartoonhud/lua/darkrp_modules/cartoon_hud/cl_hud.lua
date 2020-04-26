/*---------------------------------------------------------------------------
HUD Fonts
---------------------------------------------------------------------------*/

surface.CreateFont("CH_HP_Armor_Font",{
	font = "Trebuchet24",
	size = 25,
	weight = 1000,
	antialias = true
})

surface.CreateFont("CH_Player_HP_Font",{
	font = "Trebuchet24",
	size = 35,
	weight = 1000,
	antialias = true
})

surface.CreateFont("CH_Ammo_Font",{
	font = "Trebuchet24",
	size = 55,
	weight = 1000,
	antialias = true
})

surface.CreateFont("CH_Ammo_Font2",{
	font = "Trebuchet24",
	size = 35,
	weight = 1000,
	antialias = true
})

surface.CreateFont("CH_Agenda_Title_Font",{
	font = "Trebuchet24",
	size = 25,
	weight = 1000,
	antialias = true
})

surface.CreateFont("CH_Lockdown_Font",{
	font = "Trebuchet24",
	size = 25,
	weight = 1000,
	antialias = true
})

surface.CreateFont("CH_Lockdown_Font2",{
	font = "Trebuchet24",
	size = 23,
	weight = 1000,
	antialias = true
})

/*---------------------------------------------------------------------------
HUD Draw Functions
---------------------------------------------------------------------------*/
local function DrawBase()
	draw.RoundedBox(3, -5, ScrH () - 150, 305, 155, CartoonHudConfig.HudBaseBorderColor) --Base Border
	draw.RoundedBox(3, -5, ScrH () - 145, 300, 150, CartoonHudConfig.HudBaseDarkColor) --Base
	draw.RoundedBox(1, -5, ScrH () - 35, 300, 35, CartoonHudConfig.HudBaseLightColor) --Inner Base
	draw.RoundedBox(1, 0, ScrH () - 135, 285, 40, CartoonHudConfig.HPBarBorderColor) --HP Border
	draw.RoundedBox(1, 0, ScrH () - 85, 285, 40, CartoonHudConfig.ArmorBarBorderColor) --Armor Border
end

local function DrawHP()
	local hp_icon = Material(CartoonHudConfig.HPIcon)
	local playerhp = localply:Health() or 0
	draw.RoundedBox(1, 0, ScrH () - 130, 280, 30, CartoonHudConfig.HPBarBackColor) --HP Background
	if playerhp > 100 then playerhp = 100 end
	if playerhp < 0 then playerhp = 0 end
 
	if playerhp != 0 then
		draw.RoundedBox(1, 0, ScrH() - 130, 280 * playerhp / 100, 30, CartoonHudConfig.HPBarColor)
	end
	draw.RoundedBox(1, 0, ScrH () - 115, 280, 15, Color(0, 0, 10, 100)) --HP Shadow
	draw.SimpleTextOutlined(localply:Health().."%", "CH_HP_Armor_Font", 40, ScrH() - 115, CartoonHudConfig.HPTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.HPTextBorderColor)
	surface.SetMaterial(hp_icon)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(10, ScrH () - 128, 26, 26)
end

local function DrawArmor()
	local armor_icon = Material(CartoonHudConfig.ArmorIcon)
	local playerarmor = localply:Armor() or 0
	draw.RoundedBox(1, 0, ScrH() - 80, 280, 30, CartoonHudConfig.ArmorBarBackColor) --Armor Background
	if playerarmor > 100 then playerarmor = 100 end
	if playerarmor < 0 then playerarmor = 0 end
	if playerarmor != 0 then
		draw.RoundedBox(1, 0, ScrH () - 80, 280 * playerarmor / 100, 30, CartoonHudConfig.ArmorBarColor)
	end
	draw.RoundedBox(1, 0, ScrH () - 65, 280, 15, Color(0, 0, 10, 100)) --Armor Shadow
	draw.SimpleTextOutlined(localply:Armor().."%", "CH_HP_Armor_Font", 40, ScrH() - 65, CartoonHudConfig.ArmorTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.ArmorTextBorderColor)
	surface.SetMaterial(armor_icon)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(10, ScrH () - 78, 26, 26)
end

local function DrawInfo()
	local wallet_icon = Material(CartoonHudConfig.WalletIcon)
	local paycheck_icon = Material(CartoonHudConfig.SalaryIcon)
	draw.SimpleTextOutlined(localply:Nick(), "Trebuchet24", 270, ScrH() - 115, CartoonHudConfig.PlayerNameTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayerNameTextBorderColor) --Player Name
	draw.SimpleTextOutlined(team.GetName(localply:Team()), "Trebuchet24", 270, ScrH() - 65, CartoonHudConfig.PlayerJobTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayerJobTextBorderColor) --Player Job
	draw.SimpleTextOutlined(MonetizeNumber(localply:getDarkRPVar("money")), "Trebuchet24", 42, ScrH() - 18, CartoonHudConfig.WalletTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.WalletTextBorderColor) --Player Wallet
	surface.SetMaterial(wallet_icon)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(5, ScrH() - 32, 32, 32)
	draw.SimpleTextOutlined(MonetizeNumber(localply:getDarkRPVar("salary")), "Trebuchet24", 238, ScrH() - 18, CartoonHudConfig.SalaryTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.SalaryTextBorderColor) --Player Salary
	surface.SetMaterial(paycheck_icon)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(245, ScrH() - 37, 32, 32)
end

local function DrawHunger()
	draw.RoundedBox(3, 295, ScrH () - 150, 40, 155, CartoonHudConfig.HudBaseBorderColor) --Base Border
	draw.RoundedBox(3, 300, ScrH () - 145, 30, 150, CartoonHudConfig.HudBaseDarkColor) --Base
	draw.RoundedBox(1, 305, ScrH () - 140, 20, 140, CartoonHudConfig.HungerBarBorderColor) --Hunger Bar Border
	draw.RoundedBox(1, 310, ScrH () - 135, 10, 135, CartoonHudConfig.HungerBarBackColor) --Hunger Bar Back
	draw.RoundedBox(1, 310, ScrH () - 135 * localply:getDarkRPVar("Energy") / 100, 10, 135, CartoonHudConfig.HungerBarColor) --Hunger Bar
end

local function DrawAvatar()
	local avatarposition = 0
	if CartoonHudConfig.ShowHunger then avatarposition = 35 end
	if !avatarDrawn then
		local Avatar = vgui.Create( "AvatarImage")
		Avatar:SetSize(128, 128)
		Avatar:SetPos(305 + avatarposition, ScrH () - 130)
		Avatar:SetPlayer(localply, 184)
		avatarDrawn = true
	end
	draw.RoundedBox(3, 295 + avatarposition, ScrH () - 140, 148, 140, CartoonHudConfig.HudBaseBorderColor) --Base Border
	draw.RoundedBox(3, 300 + avatarposition, ScrH () - 135, 138, 135, CartoonHudConfig.HudBaseDarkColor) --Base
end

local function DrawAgenda()
	local agenda = localply:getAgendaTable()
	if not agenda then return end
	draw.RoundedBox(3, -5, -5, 470, 125, CartoonHudConfig.AgendaBaseBorderColor)
	draw.RoundedBox(3, -5, -5, 465, 120, CartoonHudConfig.AgendaContentBaseColor)
	draw.RoundedBox(1, 0, 0, 460, 30, CartoonHudConfig.AgendaTitleBaseColor)
	draw.SimpleTextOutlined(agenda.Title, "CH_Agenda_Title_Font", 20, 15, CartoonHudConfig.AgendaTitleTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.AgendaTitleTextBorderColor)
	local text = localply:getDarkRPVar("agenda") or CartoonHudConfig.NoAgendaText
	text = text:gsub("//", "\n"):gsub("\\n", "\n")
	text = DarkRP.textWrap(text, "Trebuchet24", 440)
	draw.DrawNonParsedText(text, "Trebuchet24", 10, 35, CartoonHudConfig.AgendaContentTextColor, 0)
end

local function DrawGunLicense()
	local gunlicense_icon = Material(CartoonHudConfig.GunLicenseIcon)
	surface.SetMaterial(gunlicense_icon)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(1, ScrH() - 175, 24, 24)
	draw.SimpleTextOutlined(CartoonHudConfig.GunLicenseText, "Trebuchet24", 26,  ScrH() - 162, CartoonHudConfig.GunLicenseTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.GunLicenseTextBorderColor)
end

local function DrawLockDown()
	draw.SimpleTextOutlined(CartoonHudConfig.LockdownTitle, "CH_Lockdown_Font", ScrW() / 2, 25, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.LockdownTitleTextBorderColor)
	draw.SimpleTextOutlined(CartoonHudConfig.LockdownSubtitle, "CH_Lockdown_Font2", ScrW() / 2, 50, CartoonHudConfig.LockdownSubtitleTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.LockdownSubtitleTextBorderColor)
end

local function DrawWanted()
	local wanted_icon = Material(CartoonHudConfig.WantedIcon)
	local wantedposition = 0
	if localply:getDarkRPVar("HasGunlicense") then wantedposition = 25 end
	surface.SetMaterial(wanted_icon)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(1, ScrH() - 175 - wantedposition, 24, 24)
	draw.SimpleTextOutlined(CartoonHudConfig.WantedText, "Trebuchet24", 26,  ScrH() - 163 - wantedposition, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.GunLicenseTextBorderColor)
end

local function DrawVoiceChat()
	local VoiceChatTexture = surface.GetTextureID("voice/icntlk_pl")
	local chbxX, chboxY = chat.GetChatBoxPos()
	local Rotating = math.sin(CurTime()*3)
	local backwards = 0
	if Rotating < 0 then
		Rotating = 1-(1+Rotating)
		backwards = 180
	end
	surface.SetTexture(VoiceChatTexture)
	surface.SetDrawColor(Color(255, 0, 0, 255))
	surface.DrawTexturedRectRotated(ScrW() - 100, chboxY, Rotating*96, 96, backwards)
end

local function DrawAmmo()
	local weapon = localply:GetActiveWeapon()
	if weapon == "Camera" or !IsValid(weapon) or !weapon.Primary then return end
	local weapon_name, mag_ammo, saved_ammo, max_ammo = GetAmmo(weapon)
	if (mag_ammo == -1) then return end
	surface.SetFont("Trebuchet24")
	local w, h = surface.GetTextSize("/ "..saved_ammo)
	draw.RoundedBox(3, ScrW() -205, ScrH () - 105, 210, 110, CartoonHudConfig.HudBaseBorderColor) --Base Border
	draw.RoundedBox(3,  ScrW() -200, ScrH () - 100, 205, 105, CartoonHudConfig.HudBaseDarkColor) --Base
	draw.RoundedBox(1,  ScrW() -200, ScrH () - 30, 200, 30, CartoonHudConfig.HudBaseLightColor) --Inner Base
	draw.SimpleTextOutlined(mag_ammo, "CH_Ammo_Font", ScrW() - 10 - w * 2,  ScrH() - 65, CartoonHudConfig.AmmoTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.AmmoTextBorderColor)
	draw.SimpleTextOutlined("/ "..saved_ammo, "CH_Ammo_Font2", ScrW() - 10,  ScrH() - 60, CartoonHudConfig.AmmoTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.AmmoTextBorderColor)
	draw.SimpleTextOutlined(weapon_name, "Trebuchet24", ScrW() - 10,  ScrH() - 15, CartoonHudConfig.AmmoTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.AmmoTextBorderColor)
end

local function DrawPlayerInfo(ply)
	local gunlicense_icon = Material(CartoonHudConfig.GunLicenseIcon)
	local pos = ply:EyePos()
	pos.z = pos.z + 10
	pos = pos:ToScreen()
	pos.y = pos.y - 50
	if CartoonHudConfig.PlayersHPMode == 0 then
		draw.SimpleTextOutlined(ply:Nick(), "Trebuchet24", pos.x, pos.y, CartoonHudConfig.PlayersNameTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayersNameTextBorderColor)
		draw.SimpleTextOutlined(team.GetName(ply:Team()), "Trebuchet24", pos.x, pos.y + 25, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayersNameTextBorderColor)
	elseif CartoonHudConfig.PlayersHPMode == 1 then
		draw.SimpleTextOutlined(ply:Nick(), "Trebuchet24", pos.x, pos.y, CartoonHudConfig.PlayersNameTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayersNameTextBorderColor)
		draw.SimpleTextOutlined("Health: "..ply:Health().."%", "Trebuchet24", pos.x, pos.y + 25, CartoonHudConfig.PlayersHealthTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayersHealthTextBorderColor)
		draw.SimpleTextOutlined(team.GetName(ply:Team()), "Trebuchet24", pos.x, pos.y + 50, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayersNameTextBorderColor)
	elseif CartoonHudConfig.PlayersHPMode == 2 then
		local player_hp_icon = Material("materials/cartoonhud/hp_icon.png")
		draw.SimpleTextOutlined(ply:Health(), "CH_Player_HP_Font", pos.x, pos.y - 30, CartoonHudConfig.PlayersHealthTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, CartoonHudConfig.PlayersHealthTextBorderColor)
		draw.SimpleTextOutlined(ply:Nick(), "Trebuchet24", pos.x, pos.y, CartoonHudConfig.PlayersNameTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayersNameTextBorderColor)
		draw.SimpleTextOutlined(team.GetName(ply:Team()), "Trebuchet24", pos.x, pos.y + 25, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayersNameTextBorderColor)
		surface.SetFont("Trebuchet24")
		local w, h = surface.GetTextSize(ply:Health())
		surface.SetMaterial(player_hp_icon)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(pos.x - 23 - w, pos.y - 40, 26, 26)
	end
	if ply:getDarkRPVar("HasGunlicense") then
		surface.SetMaterial(gunlicense_icon)
		surface.SetDrawColor(255,255,255,255)
		if CartoonHudConfig.PlayersHPMode == 0 or CartoonHudConfig.PlayersHPMode == 2 then
			surface.DrawTexturedRect(pos.x-16, pos.y + 45, 32, 32)
		elseif CartoonHudConfig.PlayersHPMode == 1 then
			surface.DrawTexturedRect(pos.x-16, pos.y + 70, 32, 32)
		end
	end
	if ply:getDarkRPVar("wanted") then
		local wantedreason = tostring(ply:getDarkRPVar("wantedReason"))
		if CartoonHudConfig.PlayersHPMode == 0 or CartoonHudConfig.PlayersHPMode == 1 then
			draw.SimpleTextOutlined(CartoonHudConfig.PlayerWantedText, "Trebuchet24", pos.x, pos.y - 45, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayersWantedTextBorderColor)
			draw.SimpleTextOutlined("Reason: "..wantedreason, "Trebuchet24", pos.x, pos.y - 25, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayersWantedTextBorderColor)
		elseif CartoonHudConfig.PlayersHPMode == 2 then
			draw.SimpleTextOutlined(CartoonHudConfig.PlayerWantedText, "Trebuchet24", pos.x, pos.y - 75, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayersWantedTextBorderColor)
			draw.SimpleTextOutlined("Reason: "..wantedreason, "Trebuchet24", pos.x, pos.y - 55, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.PlayersWantedTextBorderColor)
		end
	end
end

local function DrawEntityDisplay()
	local shootPos = localplayer:GetShootPos()
	local aimVec = localplayer:GetAimVector()
	for k, ply in pairs(players or player.GetAll()) do
		if not ply:Alive() or ply == localplayer then continue end
		local hisPos = ply:GetShootPos()
		if GAMEMODE.Config.globalshow then
			DrawPlayerInfo(ply)
		elseif not GAMEMODE.Config.globalshow and hisPos:DistToSqr(shootPos) < 160000 then
			local pos = hisPos - shootPos
			local unitPos = pos:GetNormalized()
			if unitPos:Dot(aimVec) > 0.95 then
				local trace = util.QuickTrace(shootPos, pos, localplayer)
				if trace.Hit and trace.Entity ~= ply then return end
				DrawPlayerInfo(ply)
			end
		end
	end
	local tr = localplayer:GetEyeTrace()
	if IsValid(tr.Entity) and tr.Entity:isKeysOwnable() and tr.Entity:GetPos():Distance(localplayer:GetPos()) < 200 then
		tr.Entity:drawOwnableInfo()
	end
end

local function DisplayNotify(msg)
	local txt = msg:ReadString()
	GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
	surface.PlaySound("buttons/lightswitch2.wav")
	print(txt)
end

/*---------------------------------------------------------------------------
Required Functions
---------------------------------------------------------------------------*/
function MonetizeNumber(amount)
  local formatted = tostring(amount)
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return GAMEMODE.Config.currency..formatted
end

function GetAmmo(weapon)
	local weapon_name = weapon:GetPrintName()
	local mag_ammo = weapon:Clip1()
	local saved_ammo = weapon:Ammo1()
	local max_ammo = weapon.Primary.ClipSize
	return weapon_name, mag_ammo, saved_ammo, max_ammo
end

function GAMEMODE:DrawDeathNotice(x, y)
	if not GAMEMODE.Config.showdeaths then return end
	self.BaseClass:DrawDeathNotice(x, y)
end

/*---------------------------------------------------------------------------
HUD Seperate Functions
---------------------------------------------------------------------------*/
local DrawArrested = function() end
usermessage.Hook("GotArrested", function(msg)
	local StartArrested = CurTime()
	local ArrestedUntil = msg:ReadFloat()

	DrawArrested = function()
		if CurTime() - StartArrested <= ArrestedUntil and localplayer:getDarkRPVar("Arrested") then
			draw.SimpleTextOutlined("You are arrested for "..math.ceil(ArrestedUntil - (CurTime() - StartArrested)), "Trebuchet24",  ScrW() / 2, 85, CartoonHudConfig.ArrestedTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.ArrestedTextBorderColor)
		elseif not localplayer:getDarkRPVar("Arrested") then
			DrawArrested = function() end
		end
	end
end)

local DrawAdminTell = function() end
usermessage.Hook("AdminTell", function(msg)
	timer.Destroy("DarkRP_AdminTell")
	local Message = msg:ReadString()

	DrawAdminTell = function()
		draw.RoundedBox(4, 10, 10, ScrW() - 20, 100, Color(0,0,0,255))
		draw.DrawNonParsedText(DarkRP.getPhrase("listen_up"), "GModToolName", ScrW() / 2 + 10, 10, Color(255, 255, 255, 255), 1)
		draw.DrawNonParsedText(Message, "ChatFont", ScrW() / 2 + 10, 80, Color(255, 0, 0, 255), 1)
	end

	timer.Create("DarkRP_AdminTell", 10, 1, function()
		DrawAdminTell = function() end
	end)
end)

usermessage.Hook("_Notify", DisplayNotify)

/*---------------------------------------------------------------------------
Remove the default hud shit
---------------------------------------------------------------------------*/
local HanSoloDies = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true,
	["DarkRP_HUD"] = true,
	["DarkRP_LocalPlayerHUD"] = true,
	["DarkRP_Agenda"] = true,
	["DarkRP_EntityDisplay"] = true,
	["DarkRP_ZombieInfo"] = false,
	["DarkRP_Hungermod"] = true
}

hook.Add("HUDShouldDraw", "HideDefaultElements", function(name)
	if HanSoloDies[name] then return false end
end)

function GAMEMODE:HUDDrawTargetID()
	return false
end

/*---------------------------------------------------------------------------
Actual HUDPaint hook
---------------------------------------------------------------------------*/
local avatarDrawn = false
function DrawHUD()
	cin = (math.sin(CurTime()) + 1) / 2
	localplayer = localplayer and IsValid(localplayer) and localplayer or LocalPlayer()
	if not IsValid(localplayer) then return end
	localply = LocalPlayer()
	
	-- Custom
	DrawBase()
	DrawHP()
	DrawArmor()
	DrawInfo()
	DrawAgenda()
	DrawAmmo()
	DrawEntityDisplay()
	DrawArrested()
	DrawAdminTell()

	if localply.DRPIsTalking then DrawVoiceChat() end
	if localply:getDarkRPVar("HasGunlicense") then DrawGunLicense() end
	if localply:getDarkRPVar("wanted") then DrawWanted() end
	if GetGlobalBool("DarkRP_LockDown") then DrawLockDown() end
	if CartoonHudConfig.ShowHunger then DrawHunger() end
	if CartoonHudConfig.ShowAvatar then DrawAvatar() end
end

hook.Add("HUDPaint", "DrawHUD", DrawHUD)