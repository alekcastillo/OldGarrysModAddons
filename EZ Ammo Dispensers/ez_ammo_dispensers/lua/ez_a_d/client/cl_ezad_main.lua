//Fonts
surface.CreateFont("EZAD_Font",{
	font = "Trebuchet24",
	size = 25,
	weight = 1000,
	antialias = true
})

surface.CreateFont("EZAD_Font2",{
	font = "Trebuchet24",
	size = 23,
	weight = 1000,
	antialias = true
})

surface.CreateFont("EZAD_Font3",{
	font = "DermaLarge",
	size = 90,
	weight = 1000,
	antialias = true
})

surface.CreateFont("EZAD_Font4",{
	font = "DermaLarge",
	size = 80,
	weight = 1000,
	antialias = true
})

surface.CreateFont("EZAD_Font5",{
	font = "Trebuchet24",
	size = 21,
	weight = 1000,
	antialias = true
})

surface.CreateFont("EZAD_Font6",{
	font = "Trebuchet24",
	size = 21,
	weight = 1000,
	antialias = true
})

//Textures
bullet_txt = Material("ez_a_d/icons/bullet_ico.png")
price_txt = Material("ez_a_d/icons/price_ico.png")

//Init
ezad_accentColor = EZAD.Theme_AccentColor

if EZAD.Theme_RainbowAccentColor then
	local ezad_r = 100
	local ezad_g = 150
	local ezad_b  = 200

	timer.Create("EZAD_RainbowColorsTimer", 0.1, 0, function()
		ezad_r = math.random(-15, 15)
		ezad_g = math.random(-15, 15)
		ezad_b = math.random(-15, 15)

		ezad_accentColor = Color(math.min(math.max(ezad_accentColor.r + ezad_r, 0), 255), math.min(math.max(ezad_accentColor.g + ezad_g, 0), 255), math.min(math.max(ezad_accentColor.b + ezad_b, 0), 255))
	end)
else
	ezad_accentColor = EZAD.Theme_AccentColor
end

//Net Messages
net.Receive("EZAD_Thanks", function()
	surface.PlaySound("ui/achievement_earned.wav")

	local confirmhovering = false

	local ezad_thanks_panel = vgui.Create("DFrame")
	ezad_thanks_panel:SetSize(300, 450)
	ezad_thanks_panel:SetPos(ScrW() / 2 - 150, ScrH() / 2 - 225)
	ezad_thanks_panel:SetTitle("")
	ezad_thanks_panel:SetVisible(true)
	ezad_thanks_panel:ShowCloseButton(false)
	ezad_thanks_panel:SetBackgroundBlur(true)
	ezad_thanks_panel:MakePopup()

	function ezad_thanks_panel:Paint(w, h)
		draw.RoundedBox(1, 0, 0, w, h, Color(54, 57, 62, 255))

		EZAD_DrawBorders(0, 0, w, h, true, true, true, true)

		draw.DrawText("Hello, and thanks for buying\nmy script, EZ Ammo Dispensers!", "EZAD_Font5", w / 2, 25, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.DrawText("I know this probably won't\nmean a lot to you, but I just\nwanted you to know how cool\nyou are! Seriously, thanks.", "EZAD_Font5", w / 2, 75, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.DrawText("I hope you really enjoy my\nscript, if you have any questions\nor issues, don't hesitate in\ncontacting me, I will be glad\nto help you!", "EZAD_Font5", w / 2, 165, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) --76561198060562411
		draw.DrawText("Also, if you want to help me\neven more, please consider writing\na review, it helps me A LOT\nand it only takes a couple of\nseconds. Click [HERE] to do it.", "EZAD_Font5", w / 2, 275, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local confirmbutton = vgui.Create( "DButton", ezad_thanks_panel)
	confirmbutton:SetText(" ")
	confirmbutton:SetSize(270, 40)
	confirmbutton:SetPos(15, 400)

	function confirmbutton:OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")

		confirmhovering = true
	end

	function confirmbutton:OnCursorExited()
		confirmhovering = false
	end

	function confirmbutton:Paint(w, h)
		if confirmhovering then
			draw.RoundedBox(3, 0, 0, w, h, Color(math.max(ezad_accentColor.r - 10, 0), math.max(ezad_accentColor.g - 10, 0), math.max(ezad_accentColor.b - 10, 0)))
			draw.RoundedBox(3, 0, 0, w, h - 5, ezad_accentColor)
		else
			draw.RoundedBox(3, 0, 0, w, h, Color(40, 42, 46, 255))
			draw.RoundedBox(3, 0, 0, w, h - 5, Color(42, 44, 48, 255))
		end

		draw.DrawText("You're welcome :D!", "EZAD_Font6", w / 2, h / 2 - 18, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	end

	function confirmbutton:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		net.Start("EZAD_ThanksReceived")
		net.SendToServer()

		ezad_thanks_panel:Close()
	end

	local reviewbutton = vgui.Create( "DButton", ezad_thanks_panel)
	reviewbutton:SetText(" ")
	reviewbutton:SetSize(62, 20)
	reviewbutton:SetPos(145, 361)

	function reviewbutton:Paint(w, h)
		EZAD_DrawBorders(0, 0, w, h, true, true, true, true)
	end

	function reviewbutton:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		gui.OpenURL("https://scriptfodder.com/scripts/view/2953/reviews")
	end
end)

net.Receive("EZAD_OpenMenu", function()
	surface.PlaySound("ambient/levels/labs/coinslot1.wav")

	local ezad_frame = vgui.Create("DFrame")
	ezad_frame:SetSize(550, 450)
	ezad_frame:SetPos(ScrW() / 2 - 275, ScrH() / 2 - 225)
	ezad_frame:SetTitle("")
	ezad_frame:ShowCloseButton(false)
	ezad_frame:SetVisible(true)
	ezad_frame:MakePopup()

	function ezad_frame:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(54, 57, 62, 255))

		EZAD_DrawBorders(0, 0, w, h, true, true, true, true)
	end

	local ezad_closebutton = vgui.Create("DButton", ezad_frame)
	ezad_closebutton:SetSize(40, 15)
	ezad_closebutton:SetPos(500, 5)
	ezad_closebutton:SetText("")
	ezad_closebutton:SetTooltip("Close")

	function ezad_closebutton:Paint(w, h)
		draw.RoundedBox(3, 0, 0, w, h, ezad_accentColor)
	end

	function ezad_closebutton:DoClick()
		ezad_frame:Close()
	end

	ezad_ammo_panel = vgui.Create("DPanel", ezad_frame)
	ezad_ammo_panel:SetSize(530, 415)
	ezad_ammo_panel:SetPos(10, 25)

	function ezad_ammo_panel:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(42, 46, 48, 255))
	end

	local ezad_scroll = vgui.Create("DScrollPanel", ezad_ammo_panel)
	ezad_scroll:SetSize(520, 405)
	ezad_scroll:SetPos(5, 5)

	function ezad_scroll:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(42, 46, 48, 255))
	end

	local scrollbar = ezad_scroll:GetVBar()

	function scrollbar:Paint(w, h)
		draw.RoundedBox(3, 5, 0, 10, h, Color(46, 49, 54, 255))
	end

	function scrollbar.btnUp:Paint(w, h)
		draw.RoundedBox(3, 5, 0, 10, h, Color(36, 39, 44, 255))
	end

	function scrollbar.btnDown:Paint(w, h)
		draw.RoundedBox(3, 5, 0, 10, h, Color(36, 39, 44, 255))
	end

	function scrollbar.btnGrip:Paint(w, h)
		draw.RoundedBox(3, 5, 0, 10, h, Color(36, 39, 44, 255))
	end

	local ezad_ammo_list_title = vgui.Create("DPanel", ezad_scroll)
	ezad_ammo_list_title:SetSize(0, 30)
	ezad_ammo_list_title:DockMargin(0, 0, 0, 5)
	ezad_ammo_list_title:Dock(TOP)
	ezad_ammo_list_title:SetText("")

	function ezad_ammo_list_title:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(36, 39, 44, 150))
		draw.DrawText(EZAD_Lang.TName, "EZAD_Font2", (w / 9) * 2 + 40, h / 2 - 12, ezad_accentColor, TEXT_ALIGN_CENTER)
		draw.DrawText(EZAD_Lang.TBullets, "EZAD_Font2", (w / 9) * 6, h / 2 - 12, ezad_accentColor, TEXT_ALIGN_CENTER)
		draw.DrawText(EZAD_Lang.TPrice, "EZAD_Font2", 450, h / 2 - 12, ezad_accentColor, TEXT_ALIGN_CENTER)
	end

	for k, ammo in pairs(ammotable) do
		local hovering = false
		local hoverspace = 0
		local hoveralpha = 0
		local tag = "P"

		if ammo[5] == 1 then
			tag = GAMEMODE.Config.currency
		end

		local ezad_ammo_type = vgui.Create("DPanel", ezad_scroll)
		ezad_ammo_type:SetSize(0, 65)
		ezad_ammo_type:DockMargin(0, 0, 0, 5)
		ezad_ammo_type:Dock(TOP)
		ezad_ammo_type:SetText("")

		local ezad_ammo_model = vgui.Create("SpawnIcon", ezad_ammo_type)
		ezad_ammo_model:SetPos(20, 5)
		ezad_ammo_model:SetSize(55, 55)
		ezad_ammo_model:SetModel(ammo[3])

		local ezad_ammo_btn = vgui.Create("DButton", ezad_ammo_type)
		ezad_ammo_btn:SetSize(90, 45)
		ezad_ammo_btn:SetPos(410, 10)
		ezad_ammo_btn:SetText("")

		function ezad_ammo_btn:OnCursorEntered()
			surface.PlaySound("UI/buttonrollover.wav")

			hovering = true
		end

		function ezad_ammo_btn:OnCursorExited()
			hovering = false
		end

		function ezad_ammo_type:Paint(w, h)
			draw.RoundedBox(3, 0, 0, w, h, Color(46, 49, 54, 255))
			draw.RoundedBox(3, 0, 0, w, h, Color(36, 39, 44, hoveralpha))

			if hovering then draw.RoundedBox(3, 0, 0, 10, h, ezad_accentColor) end

			if hovering and hoveralpha < 255 then
				hoveralpha = math.min(hoveralpha + 20, 255)
			elseif not hovering and hoveralpha > 0 then
				hoveralpha = math.max(hoveralpha - 2, 0)
			end

			if hovering and hoverspace < 10 then
				hoverspace = hoverspace + 1
			elseif not hovering and hoverspace > 0 then
				hoverspace = hoverspace - 1
			end

			if hovering then
				draw.DrawText(ammo[1], "Trebuchet24", (w / 9) * 2 + hoverspace, h / 2 - 14, ezad_accentColor, TEXT_ALIGN_LEFT)
				draw.DrawText(ammo[4], "EZAD_Font", (w / 9) * 6 + hoverspace, h / 2 - 14, ezad_accentColor, TEXT_ALIGN_LEFT)

				surface.SetDrawColor(ezad_accentColor.r, ezad_accentColor.g, ezad_accentColor.b, 255)
			else
				draw.DrawText(ammo[1], "Trebuchet24", (w / 9) * 2 + hoverspace, h / 2 - 14, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
				draw.DrawText(ammo[4], "EZAD_Font", (w / 9) * 6 + hoverspace, h / 2 - 14, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)

				surface.SetDrawColor(255, 255, 255, 255)
			end

			surface.SetMaterial(bullet_txt)
			surface.DrawTexturedRect(((w / 9) * 6) - 25 + hoverspace, 20, 25, 25)
		end

		function ezad_ammo_btn:Paint(w, h)
			draw.RoundedBox(3, 0, 0, w, h, Color(36, 39, 44, 255))
			draw.RoundedBox(3, 0, 0, w, h, Color(28, 31, 36, hoveralpha))

			if hovering then
				draw.DrawText(ammo[6], "EZAD_Font", 45 + hoverspace, h / 2 - 14, ezad_accentColor, TEXT_ALIGN_LEFT)

				surface.SetDrawColor(ezad_accentColor.r, ezad_accentColor.g, ezad_accentColor.b, 255)
			else
				draw.DrawText(ammo[6], "EZAD_Font", 45 + hoverspace, h / 2 - 14, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)

				surface.SetDrawColor(255, 255, 255, 255)
			end

			surface.SetMaterial(price_txt)
			surface.DrawTexturedRect(10 + hoverspace, 10, 25, 25)

			draw.DrawText(tag, "Trebuchet24", 18 + hoverspace, h / 2 - 12, Color(36, 39, 44, 255), TEXT_ALIGN_LEFT)
		end

		function ezad_ammo_btn:DoClick()
			local canBuy = false

			if ammo[5] == 1 and LocalPlayer():canAfford(ammo[6]) then
				canBuy = true
			elseif ammo[5] == 2 and LocalPlayer():PS_GetPoints() >= ammo[6] then
				canBuy = true
			elseif ammo[5] == 3 and LocalPlayer().PS2_Wallet.points >= ammo[6] then
				canBuy = true
			end

			if canBuy then
				net.Start("EZAD_BuyAmmo")
				net.WriteInt(k, 32)
				net.SendToServer()
			else
				EZAD_CL_Notify(EZAD_Lang.CantAfford)
			end
		end
	end
end)

net.Receive("EZAD_ReloadTable", function()
	ammotable = net.ReadTable()

	print(EZAD_Lang.AmmoReloaded)
end)

net.Receive("EZAD_Notify", function()
	local msg = net.ReadString()

	EZAD_CL_Notify(msg)
end)

//Hooks
hook.Add( "HUDPaint", "EZAD_Text", function()
	local localplayer = LocalPlayer()
	local shootPos = localplayer:GetShootPos()
	local aimVec = localplayer:GetAimVector()
	for k, ent in pairs (ents.FindByClass("ez_ammo_dispenser")) do
		local hisPos = ent:GetPos()
		if hisPos:DistToSqr(shootPos) < 20000 then
			local pos = hisPos - shootPos
			local unitPos = pos:GetNormalized()
			if unitPos:Dot(aimVec) > 0.95 then
				local trace = util.QuickTrace(shootPos, pos, localplayer)
				local position = (ent:EyePos() - Vector(0, 0, 25)):ToScreen()
				if trace.Hit and trace.Entity ~= ent then return end

				surface.SetFont("Trebuchet24")
				local w, h = surface.GetTextSize(EZAD_Lang.EtoBuy)

				surface.SetDrawColor(ezad_accentColor.r, ezad_accentColor.g, ezad_accentColor.b, 255)
				surface.SetMaterial(bullet_txt)
				surface.DrawTexturedRect(position.x - 25 - w / 2, position.y - 212, 25, 25)

				draw.SimpleTextOutlined(EZAD_Lang.EtoBuy, "Trebuchet24", position.x, position.y - 200, ezad_accentColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))
			end
		end
	end
end)
