--[[---------------------------------------------------------------------------
HUD Fonts
-----------------------------------------------------------------------------]]

surface.CreateFont("THUD_Font1",{
	font = "Trebuchet24",
	size = 20,
	weight = 1000,
	antialias = true,
	outline = true,
})

surface.CreateFont("THUD_Font2",{
	font = "Trebuchet24",
	size = 25,
	weight = 1000,
	antialias = true,
	outline = true,
})

surface.CreateFont("THUD_Font3",{
	font = "Trebuchet24",
	size = 35,
	weight = 1000,
	antialias = true,
	outline = true,
})

surface.CreateFont("THUD_Font4",{
	font = "Trebuchet24",
	size = 60,
	weight = 1000,
	antialias = true,
	outline = true,
})

surface.CreateFont("THUD_Font5",{
	font = "Trebuchet24",
	size = 23,
	weight = 1000,
	antialias = true,
	outline = true,
})

surface.CreateFont("THUD_Font6",{
	font = "Trebuchet24",
	size = 15,
	weight = 1000,
	antialias = true,
	outline = true,
})

--[[---------------------------------------------------------------------------
Required HUD Functions
-----------------------------------------------------------------------------]]

local function thMonetizeNumber(amount)
	if amount == nil then return "Loading..." end
	local formatted = tostring(amount)

	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')

		if (k==0) then
			break
		end
	end

	return GAMEMODE.Config.currency..formatted
end

local function thDrawBorders(x, y, w, h, up, down, left, right)
	surface.SetDrawColor(25, 25, 25, 255)
	if (up) then surface.DrawRect(x, y, w, 1) end
	if (down) then surface.DrawRect(x, y + h - 2, w, 2) end
	if (left) then surface.DrawRect(x, y, 1, h) end
	if (right) then surface.DrawRect(x + w - 1, y, 1, h) end
end

local function thGetAmmo(weapon)
	local weapon_name = weapon:GetPrintName()
	local mag_ammo = weapon:Clip1()
	local saved_ammo = weapon:Ammo1()
	local max_ammo = weapon.Primary.ClipSize
	return weapon_name, mag_ammo, saved_ammo, max_ammo
end

local function thDrawBlurRect(x, y, w, h, mat)
	local X, Y = 0,0
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(mat)
	for i = 1, THUD.BlurIntensity do
		mat:SetFloat("$blur", (i / 3) * (THUD.BlurIntensity))
		mat:Recompute()
		render.UpdateScreenEffectTexture()
		render.SetScissorRect(x, y, x + w, y + h, true)
			surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
		render.SetScissorRect(0, 0, 0, 0, false)
	end
	draw.RoundedBox(0, x, y, w, h, Color(0, 0, 0, 205))
	surface.SetDrawColor(0, 0, 0)
	surface.DrawOutlinedRect(x, y, w, h)
end

--[[---------------------------------------------------------------------------
HUD Draw Functions
-----------------------------------------------------------------------------]]

local function DrawBase()
	if THUDTheme.MainHudBaseUseTexture then
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(base_texture)
		if THUD.Theme == "blurred" then
			thDrawBlurRect(10, ScrH() - 140, 230 + extrahudwidth, 130, base_texture)
		else
			surface.DrawTexturedRect(10, ScrH() - 140, 230 + extrahudwidth, 130)
		end
	else
		draw.RoundedBox(0, 10, ScrH() - 140, 230 + extrahudwidth, 130, THUDTheme.MainHudBaseColor)
	end
	thDrawBorders(10, ScrH() - 140, 230 + extrahudwidth, 130, true, true, true, true)
end

local function DrawHP()
	local playerhp = localply:Health() or 0
	if playerhp > 100 then playerhp = 100 end
	if playerhp < 0 then playerhp = 0 end
	if oldhp < playerhp then
		oldhp = oldhp + 1
	elseif oldhp > playerhp then
		oldhp = oldhp - 1
	end
 	draw.RoundedBox(0, 20 + extrahudwidth, ScrH() - 130 - 1, 210, 35, THUDTheme.HPBarBackgroundColor)
 	thDrawBorders(20 + extrahudwidth, ScrH() - 130 - 1, 210, 35, true, true, true, true)
	draw.RoundedBox(0, 20 + extrahudwidth, ScrH () - 130 - 1 + 18, 210, 17, Color(0, 0, 10, 100))
	if oldhp != 0 then
		draw.RoundedBox(0, 20 + extrahudwidth, ScrH() - 130 - 1, (210 * (oldhp / 100)) - 1, 35, THUDTheme.HPBarColor)
		thDrawBorders(20 + extrahudwidth, ScrH() - 130 - 1, 210 * (oldhp / 100), 35, true, true, true, true)
	end
	draw.SimpleText(localply:Health(), "THUD_Font2", 20 + extrahudwidth + 30 - 2, ScrH() - 114, THUD.HPTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	surface.SetMaterial(hp_icon)
	surface.SetDrawColor(255, 255, 255, 100)
	surface.DrawTexturedRect(20 + extrahudwidth + 5, ScrH () - 123 - 1, 22, 22)
end

local function DrawArmor()
	local playerarmor = localply:Armor() or 0
	if playerarmor > 100 then playerarmor = 100 end
	if playerarmor < 0 then playerarmor = 0 end
	if oldarmor < playerarmor then
		oldarmor = oldarmor + 1
	elseif oldarmor > playerarmor then
		oldarmor = oldarmor - 1
	end
	draw.RoundedBox(0, 20 + extrahudwidth, ScrH() - 85 - 1, 210, 35, THUDTheme.ArmorBarBackgroundColor)
	thDrawBorders(20 + extrahudwidth, ScrH() - 85 - 1, 210, 35, true, true, true, true)
	draw.RoundedBox(0, 20 + extrahudwidth, ScrH() - 85 - 1 + 18, 210, 17, Color(0, 0, 10, 100))
	if oldarmor != 0 then
		draw.RoundedBox(0, 20 + extrahudwidth, ScrH() - 85 - 1, (210 * (oldarmor / 100)) - 1, 35, THUDTheme.ArmorBarColor)
		thDrawBorders(20 + extrahudwidth, ScrH() - 85 - 1, 210 * (oldarmor / 100), 35, true, true, true, true)
	end
	draw.SimpleText(localply:Armor(), "THUD_Font2", 20 + extrahudwidth + 30 - 2, ScrH() - 68, THUDTheme.ArmorTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	surface.SetMaterial(armor_icon)
	surface.SetDrawColor(255, 255, 255, 100)
	surface.DrawTexturedRect(20 + extrahudwidth + 5, ScrH () - 78 - 1, 22, 22)
end

local function DrawInfo()
	surface.SetFont("THUD_Font3")
	local txtw1, txth1 = surface.GetTextSize(localply:Nick())
	if txtw1 <= 250 then
		draw.SimpleText(localply:Nick(), "THUD_Font1", 20 + extrahudwidth + 200, ScrH() - 114, THUDTheme.NameTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	else
		draw.SimpleText(string.sub(localply:Nick(), 1, 17).."...", "THUD_Font6", 20 + extrahudwidth + 200, ScrH() - 114, THUDTheme.NameTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	end
	if localply:getDarkRPVar("job") != nil then
		surface.SetFont("THUD_Font3")
		local txtw2, txth2 = surface.GetTextSize(localply:getDarkRPVar("job"))
		if txtw2 <= 200 then
			draw.SimpleText(localply:getDarkRPVar("job"), "THUD_Font1", 20 + extrahudwidth + 200, ScrH() - 68, THUDTheme.JobTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		elseif txtw2 <= 300 then
			draw.SimpleText(localply:getDarkRPVar("job"), "THUD_Font6", 20 + extrahudwidth + 200, ScrH() - 68, THUDTheme.JobTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(string.sub(localply:getDarkRPVar("job"), 1, 17).."...", "THUD_Font6", 20 + extrahudwidth + 200, ScrH() - 68, THUDTheme.JobTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end
	end
	surface.SetFont("THUD_Font1")
	local txtw,txth = surface.GetTextSize(thMonetizeNumber(localply:getDarkRPVar("money")).." | Salary: "..thMonetizeNumber(localply:getDarkRPVar("salary")))
	draw.RoundedBox(1, 20 + extrahudwidth, ScrH() - 40 - 1, txtw + 10, 20, THUDTheme.MainHudBaseTextBoxColor)
	draw.SimpleText(thMonetizeNumber(localply:getDarkRPVar("money")).." | Salary: "..thMonetizeNumber(localply:getDarkRPVar("salary")), "THUD_Font1", 20 + extrahudwidth + 5, ScrH() - 30 - 1, THUDTheme.MoneyTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

local function DrawHunger()
	local playerenergy = localply:getDarkRPVar("Energy") or 0
	if playerenergy > 100 then playerenergy = 100 end
	if playerenergy < 0 then playerenergy = 0 end
	if oldhunger < playerenergy then
		oldhunger = oldhunger + 1
	elseif oldhunger > playerenergy then
		oldhunger = oldhunger - 1
	end
	draw.RoundedBox(0, 20 + (extrahudwidth - 30), ScrH() - 130 - 1, 20, 110 + 1, THUDTheme.HungerBarBackgroundColor)
	thDrawBorders(20 + (extrahudwidth - 30), ScrH() - 130 - 1, 20, 110 + 1, true, true, true, true)
	draw.RoundedBox(0, 20 + (extrahudwidth - 30), ScrH() - 20 - ((110 + 1) * (oldhunger / 100)), 20, (110 + 1) * (oldhunger / 100), THUDTheme.HungerBarColor)
	thDrawBorders(20 + (extrahudwidth - 30), ScrH() - 20 - ((110 + 1) * (oldhunger / 100)), 20, (110 + 1) * (oldhunger / 100), true, true, true, true)
end

local function DrawAvatar()
	if !avatarDrawn then
		local Avatar = vgui.Create( "AvatarImage")
		Avatar:SetSize(110, 110)
		Avatar:SetPos(20, ScrH() - 130)
		Avatar:SetPlayer(localply, 128)
		avatarDrawn = true
	end
	thDrawBorders(20 - 1, ScrH() - 131, 112, 112, true, true, true, true)
end

local function DrawAgenda()
	local plyAgenda = localply:getAgendaTable()
	if not plyAgenda then return end
	if THUDTheme.AgendaBaseUseTexture then
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(agenda_texture)
		if THUD.Theme == "blurred" then
			thDrawBlurRect(10, 10, 355, 160, agenda_texture)
		else
			surface.DrawTexturedRect(10, 10, 355, 160)
		end
	else
		draw.RoundedBox(0, 10, 10, 355, 160, THUDTheme.AgendaBaseColor)
	end
	thDrawBorders(10, 10, 355, 160, true, true, true, true)
	draw.SimpleText(plyAgenda.Title, "THUD_Font2", 20, 30, THUDTheme.AgendaTitleTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.RoundedBox(1, 15, 48, 345, 115, THUDTheme.AgendaTextBoxColor)
	local text = localply:getDarkRPVar("agenda") or THUD.NoAgendaText
	text = text:gsub("//", "\n"):gsub("\\n", "\n")
	text = DarkRP.textWrap("  "..text, "THUD_Font1", 330)
	draw.DrawNonParsedText(text, "THUD_Font1", 20, 50, THUDTheme.AgendaContentTextColor, 0)
end

local function DrawGunLicense()
	if THUDTheme.MainHudBaseUseTexture then
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(base_texture)
		if THUD.Theme == "blurred" then
			thDrawBlurRect(25 + tagsspace, ScrH () - 140 - 25, 100, 25, base_texture)
		else
			surface.DrawTexturedRect(25 + tagsspace, ScrH () - 140 - 25, 100, 25)
		end
	else
		draw.RoundedBox(0, 25 + tagsspace, ScrH () - 140 - 25, 100, 25, THUDTheme.AgendaBaseColor)
	end
	draw.RoundedBox(1, 25 + tagsspace, ScrH() - 140 - 25, 100, 25, THUDTheme.GunLicensedTextBoxColor)
	thDrawBorders(25 + tagsspace, ScrH() - 140 - 25, 100, 25, true, false, true, true)
	draw.SimpleText("Licensed", "THUD_Font1", 25 + 50 + tagsspace, ScrH () - 140 - 12, THUDTheme.GunLicensedTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	tagsspace = tagsspace + 110
end

local function DrawWanted()
	if THUDTheme.MainHudBaseUseTexture then
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(base_texture)
		if THUD.Theme == "blurred" then
			thDrawBlurRect(25 + tagsspace, ScrH () - 140 - 25, 100, 25, base_texture)
		else
			surface.DrawTexturedRect(25 + tagsspace, ScrH () - 140 - 25, 100, 25)
		end
	else
		draw.RoundedBox(0, 25 + tagsspace, ScrH () - 140 - 25, 100, 25, THUDTheme.AgendaBaseColor)
	end
	draw.RoundedBox(1, 25 + tagsspace, ScrH () - 140 - 25, 100, 25, THUDTheme.WantedTextBoxColor)
	thDrawBorders(25 + tagsspace, ScrH() - 140 - 25, 100, 25, true, false, true, true)
	draw.SimpleText("Wanted", "THUD_Font1", 25 + 50 + tagsspace, ScrH () - 140 - 12, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	tagsspace = tagsspace + 110
end

local function DrawLockDown()
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(lockdown_texture)
	if THUD.Theme == "blurred" then
		thDrawBlurRect(ScrW() / 2 - 200, 10, 400, 50, lockdown_texture)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 200, 10, 400, 50)
	end
	surface.DrawTexturedRect(ScrW() / 2 - 200, 10, 400, 50)
	thDrawBorders(ScrW() / 2 - 200, 10, 400, 50, true, true, true, true)
	draw.SimpleText(THUD.LockdownTitleText, "THUD_Font2", ScrW() / 2, 24, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(THUD.LockdownSubtitleText, "THUD_Font1", ScrW() / 2, 45, THUDTheme.LockdownSubtitleTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function DrawVoiceChat()
	local chbxX, chboxY = chat.GetChatBoxPos()
	if THUDTheme.VoiceChatTalkingBaseUseTexture then
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(voicechat_texture)
		if THUD.Theme == "blurred" then
			thDrawBlurRect(ScrW() - 110, chboxY, 100, 50, voicechat_texture)
		else
			surface.DrawTexturedRect(ScrW() - 110, chboxY, 100, 50)
		end
	else
		draw.RoundedBox(0, ScrW() - 110, chboxY, 100, 50, THUDTheme.VoiceChatTalkingBaseColor)
	end
	thDrawBorders(ScrW() - 110, chboxY, 100, 50, true, true, true, true)
	draw.SimpleText(THUD.VoiceChatTalkingText, "THUD_Font2", ScrW() - 60, chboxY + 25, THUDTheme.VoiceChatTalkingTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function DrawAmmo()
	local weapon = localply:GetActiveWeapon()
	if weapon == "Camera" or !IsValid(weapon) or !weapon.Primary then return end
	local weapon_name, mag_ammo, saved_ammo, max_ammo = thGetAmmo(weapon)
	if (mag_ammo == -1) then return end
	if THUDTheme.AmmoViewerBaseUseTexture then
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(ammoviewer_texture)
		if THUD.Theme == "blurred" then
			thDrawBlurRect(ScrW() - 210, ScrH () - 110, 200, 100, ammoviewer_texture)
		else
			surface.DrawTexturedRect(ScrW() - 210, ScrH () - 110, 200, 100)
		end
	else
		draw.RoundedBox(0, ScrW() - 210, ScrH () - 110, 200, 100, THUDTheme.AmmoViewerBaseColor)
	end
	thDrawBorders(ScrW() - 210, ScrH () - 110, 200, 100, true, true, true, true)
	draw.RoundedBox(1,  ScrW() - 210, ScrH () - 40, 200, 30, THUDTheme.AmmoViewerTextBoxColor)
	draw.SimpleText("/"..saved_ammo, "THUD_Font3", ScrW() - 20,  ScrH() - 62, THUDTheme.AmmoOnInvTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	surface.SetFont("THUD_Font3")
	local txtw, txth = surface.GetTextSize("/ "..saved_ammo)
	draw.SimpleText(mag_ammo, "THUD_Font4", ScrW() - 20 - txtw,  ScrH() - 70, THUDTheme.AmmoOnMagTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	draw.SimpleText(weapon_name, "THUD_Font1", ScrW() - 15,  ScrH() - 25, THUDTheme.WeaponNameTextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
end

local function DrawPlayerInfo(ply)
	local pos = ply:EyePos()
	pos.z = pos.z + 10
	pos = pos:ToScreen()
	pos.y = pos.y - 50
	if THUD.DrawTexturedBaseOnPlayersInfo then
		if THUDTheme.PlayersInfoBaseUseTexture then
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(playersinfo_texture)
			if THUD.Theme == "blurred" then
				thDrawBlurRect(pos.x - 100, pos.y - 15, 200, 75, playersinfo_texture)
			else
				surface.DrawTexturedRect(pos.x - 100, pos.y - 15, 200, 75)
			end
		else
			draw.RoundedBox(0, pos.x - 100, pos.y - 15, 200, 75, THUDTheme.PlayersInfoBaseColor)
		end
		thDrawBorders(pos.x - 100 - 1, pos.y - 15 - 1, 200 + 2, 75 + 2, true, true, true, true)
	end
	draw.SimpleText(ply:Nick(), "THUD_Font5", pos.x, pos.y, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText("Health: "..ply:Health(), "THUD_Font5", pos.x, pos.y + 20, THUDTheme.PlayersInfoHealthTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(ply:getDarkRPVar("job"), "THUD_Font5", pos.x, pos.y + 40, THUDTheme.PlayersInfoJobTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	if ply:getDarkRPVar("HasGunlicense") then
		surface.SetMaterial(gunlicense_icon)
		surface.SetDrawColor(255,255,255,255)
		surface.DrawTexturedRect(pos.x-16, pos.y + 52, 32, 32)
	end
	if ply:getDarkRPVar("wanted") then
		local wantedreason = tostring(ply:getDarkRPVar("wantedReason"))
		draw.SimpleText(THUD.PlayerWantedText, "THUD_Font1", pos.x, pos.y - 45, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("Reason: "..wantedreason, "THUD_Font1", pos.x, pos.y - 25, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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
		elseif not GAMEMODE.Config.globalshow and hisPos:DistToSqr(shootPos) < 75000 then
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

function GAMEMODE:DrawDeathNotice(x, y)
	if not GAMEMODE.Config.showdeaths then return end
	self.BaseClass:DrawDeathNotice(x, y)
end

--[[---------------------------------------------------------------------------
Separate HUD Functions
-----------------------------------------------------------------------------]]

local DrawArrested = function() end
usermessage.Hook("GotArrested", function(msg)
	local StartArrested = CurTime()
	local ArrestedUntil = msg:ReadFloat()
	DrawArrested = function()
		if CurTime() - StartArrested <= ArrestedUntil and localplayer:getDarkRPVar("Arrested") then
			if THUDTheme.ArrestedTextBaseUseTexture then
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetMaterial(arrestedtext_texture)
				if THUD.Theme == "blurred" then
					thDrawBlurRect(ScrW() / 2 - 150, 70, 300, 30, arrestedtext_texture)
				else
					surface.DrawTexturedRect(ScrW() / 2 - 150, 70, 300, 30)
				end
			else
				draw.RoundedBox(0, ScrW() / 2 - 150, 70, 300, 30, THUDTheme.PlayersInfoBaseColor)
			end
			thDrawBorders(ScrW() / 2 - 150, 70, 300, 30, true, true, true, true)
			draw.SimpleText("You are arrested for "..math.ceil(ArrestedUntil - (CurTime() - StartArrested)), "THUD_Font2",  ScrW() / 2, 85, THUDTheme.ArrestedTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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

--[[---------------------------------------------------------------------------
Materials
-----------------------------------------------------------------------------]]

hp_icon = Material(THUDTheme.HPIconTexture)
armor_icon = Material(THUDTheme.ArmorIconTexture)
gunlicense_icon = Material(THUDTheme.GunLicenseIconTexture)
base_texture = Material(THUDTheme.MainHudBaseTexture)
agenda_texture = Material(THUDTheme.AgendaBaseTexture)
ammoviewer_texture = Material(THUDTheme.AmmoViewerBaseTexture)
lockdown_texture = Material(THUDTheme.LockdownTextBaseTexture)
playersinfo_texture = Material(THUDTheme.PlayersInfoBaseTexture)
voicechat_texture = Material(THUDTheme.VoiceChatTalkingBaseTexture)
arrestedtext_texture = Material(THUDTheme.ArrestedTextBaseTexture)

--[[---------------------------------------------------------------------------
Remove the default hud shit
-----------------------------------------------------------------------------]]

local HavokDies = {
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
	if HavokDies[name] then return false end
end)

function GAMEMODE:HUDDrawTargetID()
	return false
end

--[[---------------------------------------------------------------------------
HUD Paint Hook
-----------------------------------------------------------------------------]]

local avatarDrawn = false
tagspace = 0
extrahudwidth = 0
oldhp = 0
oldarmor = 0
oldhunger = 0
function DrawHUD()
	tagsspace = 0
	extrahudwidth = 0
	cin = (math.sin(CurTime()) + 1) / 2
	localplayer = localplayer and IsValid(localplayer) and localplayer or LocalPlayer()
	if not IsValid(localplayer) then return end
	if THUD.ShowAvatar then extrahudwidth = extrahudwidth + 120 end
	if THUD.ShowHungerBar then extrahudwidth = extrahudwidth + 30 end
	localply = LocalPlayer()
	DrawBase()
	DrawHP()
	DrawArmor()
	if THUD.ShowHungerBar then DrawHunger() end
	DrawInfo()
	if THUD.ShowAvatar then DrawAvatar() end
	if localply:getDarkRPVar("HasGunlicense") then DrawGunLicense() end
	if localply:getDarkRPVar("wanted") then DrawWanted() end
	if GetGlobalBool("DarkRP_LockDown") then DrawLockDown() end
	if THUD.EnableCustomAgenda then DrawAgenda() end
	if THUD.EnableCustomAmmoBox then DrawAmmo() end
	DrawEntityDisplay()
	DrawArrested()
	DrawAdminTell()
	if localply.DRPIsTalking and THUD.EnableCustomVoiceIcon then DrawVoiceChat() end
end

hook.Add("HUDPaint", "DrawHUD", DrawHUD)
