//Functions

function playersTab(frame)
	AsrCheckTab(1)

	invitespanel = vgui.Create("DPanel", frame)
	invitespanel:SetSize(624, 534)
	invitespanel:SetPos(135, 35)

	function invitespanel:Paint(w, h)
		AsrDrawTitle("Players", "AsrTitle1", Color(255, 255, 255), w / 2, 35, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2)

		--draw.SimpleText("Click on a player's name to set him as your referrer, or to", "AsrRoboto25", w/2, 18, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		--draw.SimpleText("ask make him to confirm he was invited to the server by you.", "AsrRoboto25", w/2, 35, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	players_panel = vgui.Create("DPanel", invitespanel)
	players_panel:SetSize(603, 428)
	players_panel:SetPos(10, 95)

	function players_panel:Paint(w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(40, 43, 48, 255))
	end

	local players_title = vgui.Create("DPanel", players_panel)
	players_title:SetSize(593, 30)
	players_title:SetPos(5, 5)
	players_title:SetText("")

	function players_title:Paint(w, h)
		draw.SimpleText("Name", "AsrRoboto25", w / 2, h / 2, asrColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("Refers", "AsrRoboto25", w - 20, h / 2, asrColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	end

	local scroll = vgui.Create("DScrollPanel", players_panel)
	scroll:SetSize(593, 383)
	scroll:SetPos(5, 40)

	function scroll:Paint(w, h) end

	local scrollbar = scroll:GetVBar()

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

	for k, ply2 in pairs(player.GetAll()) do
    local plycolor = Color(255, 255, 255, 255)
		local plyname = ply2:Nick()
		local plyrefers = ply2:AsrRefers()
		local plysteamid = "Steamid not valid"
		local plyrefercode = "Refercode not set"
		local plyisadvertiser = false
		local plyismember = false

		if !ply2:IsBot() then
			plyname = ply2:AsrNick()
			plysteamid = ply2:SteamID()
			plyrefercode = ply2:AsrReferCode()
			plyisadvertiser = ply2:AsrIsAdvertiser()
			plyismember = ply2:AsrIsGroupMember()
		end

		local playerbutton = vgui.Create("DButton", scroll)
		playerbutton:SetSize(0, 60)
		playerbutton:DockMargin(0, 0, 0, 2)
		playerbutton:Dock(TOP)
		playerbutton:SetText("")
		playerbutton.hovering = false
		playerbutton.alpha = 0
		playerbutton.space = 0

		local steamavatar = vgui.Create("AvatarImage", playerbutton)
		steamavatar:SetPlayer(ply2, 64)
		steamavatar:SetSize(50, 50)
		steamavatar:SetPos(20, 5)

		function playerbutton:Paint() end

		function playerbutton:OnCursorEntered()
			surface.PlaySound("UI/buttonrollover.wav")

			self.hovering = true
		end

		function playerbutton:OnCursorExited()
			self.hovering = false
		end

		function playerbutton:Paint(w, h)
			self.alpha = AsrAnimateHover(self.alpha, 0, 255, 20, 5, self.hovering, false)
			self.space = AsrAnimateHover(self.space, 0, 10, 1, 1, self.hovering, false)

			local plycolor = Color(100, 100, 100, 255)

			draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
			draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

			if playerbutton.hovering then
        draw.RoundedBox(3, 0, 0, 10, h, asrColor)
      end

			if playerbutton.hovering then
        plycolor = asrColor
			end

			surface.SetFont("AsrRoboto25")

			rw, rh = surface.GetTextSize(plyrefers)

      draw.SimpleText(AsrCutText(plyname, "AsrRoboto25", 200), "AsrRoboto25", w / 2 + self.space, h / 2 - 12, plycolor, TEXT_ALIGN_CENTER)
      draw.SimpleText(plyrefers, "AsrRoboto25", w - 25 + self.space, h / 2 - 12, plycolor, TEXT_ALIGN_RIGHT)

			surface.SetDrawColor(plycolor.r, plycolor.g, plycolor.b)
			surface.SetMaterial(check_texture)
			surface.DrawTexturedRect(w - 25 - 22 - rw + self.space, 23, 18, 18)

			if ASR.EnableNameTagRewards then
				if plyisadvertiser then
					surface.SetDrawColor(plycolor.r, plycolor.g, plycolor.b)
				else
					surface.SetDrawColor(46, 49, 54)
				end

				surface.SetMaterial(name_texture)
				surface.DrawTexturedRect(w / 5 + self.space, 23, 18, 18)
			end

			if ASR.EnableSteamGroupRewards then
				if plyismember then
					surface.SetDrawColor(plycolor.r, plycolor.g, plycolor.b)
				else
					surface.SetDrawColor(46, 49, 54)
				end

				surface.SetMaterial(steam_texture)
				surface.DrawTexturedRect(w / 5 + 23 + self.space, 23, 18, 18)
			end
		end

		function playerbutton:DoClick()
			local playermenu = DermaMenu()

			surface.PlaySound("UI/buttonclickrelease.wav")

			if !ply2:IsValid() or !ply2:IsPlayer() then
				local errorbutton = playermenu:AddOption("An unexpected error ocurred!")
				errorbutton:SetIcon("icon16/exclamation.png")
			elseif ply2:IsBot() then
				local botbutton = playermenu:AddOption("This is a bot!")
				botbutton:SetIcon("icon16/exclamation.png")
			else
				if ply2 == LocalPlayer() then
					local mebutton = playermenu:AddOption("You can't reward yourself!")
					mebutton:SetIcon("icon16/exclamation.png")
				else
					local referrerbutton = playermenu:AddOption("I referred this player to the server")
					referrerbutton:SetIcon("icon16/group_add.png")

					function referrerbutton:DoClick()
						surface.PlaySound("buttons/lightswitch2.wav")

						if ply2:AsrReferrer() then
							AsrNotify(plyname.." has already rewarded the player who referred him, and this can only be done once.")

							return
						end

						net.Start("AsrReferConfirmationRequest")
						net.WriteEntity(ply2)
						net.SendToServer()
					end

					local referredbutton = playermenu:AddOption("This player referred me to the server")
					referredbutton:SetIcon("icon16/group_go.png")

					function referredbutton:DoClick()
						surface.PlaySound("buttons/lightswitch2.wav")

						if LocalPlayer():AsrReferrer() then
							AsrNotify("You have already rewarded your referrer, and this can only be done once.")

							return
						end

						frame:SetVisible(false)

						AsrConfirmReferrerWindow(ply2:SteamID())
					end
				end

				local sprofilebutton = playermenu:AddOption("Show his/her Steam Profile")
				sprofilebutton:SetIcon("icon16/information.png")

				function sprofilebutton:DoClick()
					surface.PlaySound("buttons/lightswitch2.wav")

					ply2:ShowProfile()
				end

				local steamidbutton = playermenu:AddOption("Copy his/her SteamID")
				steamidbutton:SetIcon("icon16/key.png")

				function steamidbutton:DoClick()
					surface.PlaySound("buttons/lightswitch2.wav")

					AsrNotify(plyname.."'s SteamID has been copied to the clipboard!")

					SetClipboardText(plysteamid)
				end

				local profilebutton = playermenu:AddOption("Show his/her Server Rewards Profile")
				profilebutton:SetIcon("icon16/user.png")

				function profilebutton:DoClick()
					surface.PlaySound("buttons/lightswitch2.wav")

					profileTab(frame, ply2:SteamID())
				end

				local refercodebutton = playermenu:AddOption("Copy his/her referral code")
				refercodebutton:SetIcon("icon16/font.png")

				function refercodebutton:DoClick()
					surface.PlaySound("buttons/lightswitch2.wav")

					AsrNotify(plyname.."'s refer code has been copied to the clipboard!")

					SetClipboardText(plyrefercode)
				end
			end

			playermenu:Open()
		end
	end
end
