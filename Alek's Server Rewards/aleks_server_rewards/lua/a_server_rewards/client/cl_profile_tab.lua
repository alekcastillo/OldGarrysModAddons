//Functions

function profileTab(frame, sid)
	AsrCheckTab(4)

	local profileSteamID = sid
	local profileSteamID64 = util.SteamIDTo64(sid)

	local plyname = AsrNickSID(profileSteamID)
	local plysteamid = profileSteamID
	local plyreferralcode = AsrReferCodeSID(profileSteamID)
	local plyrefers = AsrRefersSID(profileSteamID)
	local plyreferrersid = AsrReferrerSID(profileSteamID)
	local plyreferrer = "Not specified"
	local plyleadpos = "Not ranked"
	local plysteamgroup = "No"
	local plynametag = "No"

	local plyreferrednames = AsrReferredPlayersSID(profileSteamID, true)
	local plyreferredsids = AsrReferredPlayersSID(profileSteamID, false)

	local steamidhovering = false
	local referralodehovering = false
	local refers hovering = false
	local referrerhovering = false
	local steamgrouphovering = false
	local nametaghovering = false

	if plyreferrersid then
		plyreferrer = AsrNickSID(plyreferrersid)
	end

	if AsrIsGroupMemberSID(profileSteamID) then
		plysteamgroup = "Yes"
	end

	if AsrIsAdvertiserSID(profileSteamID) then
		plynametag = "Yes"
	end

	for k, v in pairs(asrLeadersTbl) do
		if v["steamid"] == profileSteamID and v["refers"] > 0 then
			plyleadpos = AsrOrdinalNumber(k)
		end
	end

	local refershovering = false
	local referrerhovering = false
	local refercodehovering = false

	invitespanel = vgui.Create("DPanel", frame)
	invitespanel:SetSize(624, 534)
	invitespanel:SetPos(135, 35)

	function invitespanel:Paint(w, h)
		AsrDrawTitle("Profile", "AsrTitle1", Color(255, 255, 255), w / 2, 35, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2)
	end

	local infoscroll = vgui.Create("DScrollPanel", invitespanel)
	infoscroll:SetSize(604, 424)
	infoscroll:SetPos(10, 100)

	function infoscroll:Paint(w, h) end

	local infoscrollbar = infoscroll:GetVBar()

	function infoscrollbar:Paint(w, h)
		draw.RoundedBox(3, 5, 0, 10, h, Color(46, 49, 54, 255))
	end

	function infoscrollbar.btnUp:Paint(w, h)
		draw.RoundedBox(3, 5, 0, 10, h, Color(36, 39, 44, 255))
	end

	function infoscrollbar.btnDown:Paint(w, h)
		draw.RoundedBox(3, 5, 0, 10, h, Color(36, 39, 44, 255))
	end

	function infoscrollbar.btnGrip:Paint(w, h)
		draw.RoundedBox(3, 5, 0, 10, h, Color(36, 39, 44, 255))
	end

	local mainpanel = vgui.Create("DPanel", infoscroll)
	mainpanel:SetSize(0, 100)
	mainpanel:DockMargin(0, 0, 0, 10)
	mainpanel:Dock(TOP)
	mainpanel:SetText("")

	function mainpanel:Paint(w, h)
		draw.RoundedBox(6, 40, 0, w - 65, h, Color(36, 39, 44, 150))

		draw.SimpleText(AsrCutText(plyname, "AsrRoboto60", 409), "AsrRoboto60", 145, h / 2, asrColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		AsrDrawBorders(55, 10, 80, 80, true, true, true, true)
	end

	local avatarimage = vgui.Create( "AvatarImage", infoscroll)
	avatarimage:SetSize(78, 78)
	avatarimage:SetPos(56, 11)
	avatarimage:SetSteamID(profileSteamID64, 80)

	local buttons = {
		{right = "SteamID:", left = plysteamid, clickable = true, hovering = false, onclick = 1},
		{right = "Referral code:", left = plyreferralcode, clickable = true, hovering = false, onclick = 2},
		{right = "Referred players:", left = plyrefers, clickable = plyrefers > 0, hovering = false, onclick = 3},
		{right = "Referrer:", left = plyreferrer, clickable = true, hovering = false, onclick = 4},
		{right = "Leaderboard position:", left = plyleadpos, clickable = false, hovering = false}
	}

	if ASR.EnableSteamGroupRewards then
		local steambtn = {right = "Is a steam group member:", left = plysteamgroup, clickable = profileSteamID == LocalPlayer():SteamID(), hovering = false, onclick = 5}

		table.insert(buttons, steambtn)
	end

	if ASR.EnableNameTagRewards then
		local namebtn = {right = "Uses the server's nametag:", left = plynametag, clickable = profileSteamID == LocalPlayer():SteamID(), hovering = false, onclick = 6}

		table.insert(buttons, namebtn)
	end

	for k, v in pairs(buttons) do
		local infopanel = vgui.Create("DPanel", infoscroll)
		infopanel:SetSize(0, 60)
		infopanel:DockMargin(0, 0, 0, 10)
		infopanel:Dock(TOP)
		infopanel:SetText("")

		local hoverspace = 0
		local hoveralpha = 0

		function infopanel:Paint(w, h)
			hoveralpha = AsrAnimateHover(hoveralpha, 0, 255, 20, 5, v["hovering"], false)
			hoverspace = AsrAnimateHover(hoverspace, 0, 10, 1, 1, v["hovering"], false)

			local col = Color(100, 100, 100, 255)

			draw.RoundedBox(6, 40, 0, w - 65, h, Color(46, 49, 54, 255))
			draw.RoundedBox(6, 40, 0, w - 65, h, Color(36, 39, 44, hoveralpha))

			if v["hovering"] then
				col = asrColor
			end

			AsrDrawRhombus(56 + hoverspace, 18, 24, 24, col)

			draw.SimpleText(v["right"], "AsrRoboto30", 90 + hoverspace, h / 2, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(v["left"], "AsrRoboto35", w - 40 - 10 + hoverspace, h / 2 + 1, col, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end

		if v["clickable"] then
			local infobtn = vgui.Create("DButton", infopanel)
			infobtn:SetPos(40, 0)
			infobtn:SetSize(525, 60)
			infobtn:SetText("")

			function infobtn:Paint(w, h) end

			function infobtn:OnCursorEntered()
				surface.PlaySound("UI/buttonrollover.wav")

				v["hovering"] = true
			end

			function infobtn:OnCursorExited()
				v["hovering"] = false
			end

			function infobtn:DoClick() --This will be... cancer, but seriously, there was no other way to do it since runstring doesn't read local variables... Also, why the fuck are you looking at my code? Seriously, stop! I don't want anyone to notice the fact that I used the old shitty anti-leak tactic of placing the buyer's id right here:
				local act = v["onclick"]

				surface.PlaySound("UI/buttonclickrelease.wav")

				if act == 1 then
					local steamidmenu = DermaMenu()

					local profilebutton = steamidmenu:AddOption("Show his/her Steam profile")
					profilebutton:SetIcon("icon16/information.png")

					function profilebutton:DoClick()
						surface.PlaySound("buttons/lightswitch2.wav")

						gui.OpenURL("http://steamcommunity.com/profiles/"..profileSteamID64)
					end

					local steamidbutton = steamidmenu:AddOption("Copy to clipboard")
					steamidbutton:SetIcon("icon16/key.png")

					function steamidbutton:DoClick()
						surface.PlaySound("buttons/lightswitch2.wav")

						AsrNotify("The SteamID has been copied to the clipboard!")

						SetClipboardText(plysteamid)
					end

					steamidmenu:Open()
				elseif act == 2 then
					local codemenu = DermaMenu()

					local referralbutton = codemenu:AddOption("Copy to clipboard")
					referralbutton:SetIcon("icon16/font.png")

					function referralbutton:DoClick()
						AsrNotify("The referral code has been copied to the clipboard!")

						SetClipboardText(plyreferralcode)
					end

					codemenu:Open()
				elseif act == 3 then
					local names = plyname.."'s referred players: "..string.Implode(", ", plyreferrednames)
					local sids = plyname.."'s referred players: "..string.Implode(", ", plyreferredsids)

					local refersmenu = DermaMenu()

					local namesbutton = refersmenu:AddOption("Copy the referred players' names to clipboard")
					namesbutton:SetIcon("icon16/user.png")

					function namesbutton:DoClick()
						surface.PlaySound("buttons/lightswitch2.wav")

						AsrNotify("The referred players' names has been copied to the clipboard!")

						SetClipboardText(names)
					end

					local sidsbutton = refersmenu:AddOption("Copy the referred players' SteamIDs to clipboard")
					sidsbutton:SetIcon("icon16/font.png")

					function sidsbutton:DoClick()
						surface.PlaySound("buttons/lightswitch2.wav")

						AsrNotify("The referred players' SteamIDs has been copied to the clipboard!")

						SetClipboardText(sids)
					end

					refersmenu:Open()
				elseif act == 4 then
					local referrermenu = DermaMenu()

					if plyreferrersid then
						local sidbutton = referrermenu:AddOption("Copy his/her SteamID to clipboard")
						sidbutton:SetIcon("icon16/key.png")

						function sidbutton:DoClick()
							surface.PlaySound("buttons/lightswitch2.wav")

							AsrNotify("The referrer's SteamID has been copied to the clipboard!")

							SetClipboardText(plyreferrersid)
						end

						local profilebutton = referrermenu:AddOption("View his/her Server Rewards profile")
						profilebutton:SetIcon("icon16/user.png")

						function profilebutton:DoClick()
							surface.PlaySound("buttons/lightswitch2.wav")

							profileTab(frame, plyreferrersid)
						end
					else
						local referralcodebutton = referrermenu:AddOption("Enter his/her referral code")
						referralcodebutton:SetIcon("icon16/font.png")

						function referralcodebutton:DoClick()
							surface.PlaySound("buttons/lightswitch2.wav")

							frame:SetVisible(false)

							AsrReferCodeWindow(frame)
						end
					end

					referrermenu:Open()
				elseif act == 5 then
					if LocalPlayer():AsrIsGroupMember() then
						AsrNotify("You were already rewarded for joining our steam group!")

						return
					end

					frame:SetVisible(false)

					AsrSpecialRewardWindow(1, frame)
				elseif act == 6 then
					if LocalPlayer():AsrIsAdvertiser() then
						AsrNotify("You were already rewarded for using our nametag!")

						return
					end

					frame:SetVisible(false)

					AsrSpecialRewardWindow(2, frame)
				end
			end
		end
	end
end
