//Functions

function AsrConfirmationMenu(ply)
	surface.PlaySound("buttons/lightswitch2.wav")

	local closetimer = ASR.AutocloseConfirmationTimer
	local referrername = ply:AsrNick()

	local confirmpanel = vgui.Create("DFrame")
	confirmpanel:SetSize(250, 125)
	confirmpanel:SetPos(ScrW() - 260, ScrH() / 2 - 62)
	confirmpanel:SetTitle("")
	confirmpanel:SetVisible(true)
	confirmpanel:ShowCloseButton(false)

	function confirmpanel:Paint(w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(44, 47, 52, 255))
		draw.RoundedBox(6, 0, 0, w, h - 5, Color(54, 57, 62, 255))

		draw.DrawText("According to "..referrername..", you\nwere invited to this server by him.\nDo you want to confirm this?\nTHIS CAN'T BE CHANGED ("..closetimer..")", "AsrRoboto15", w / 2, h / 2 - 54, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	end

	local confirmbutton = vgui.Create("DButton", confirmpanel)
	confirmbutton:SetText("")
	confirmbutton:SetSize(100, 40)
	confirmbutton:SetPos(20, 75)
	confirmbutton.hovering = false
	confirmbutton.alpha = 0

	function confirmbutton:OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")

		self.hovering = true
	end

	function confirmbutton:OnCursorExited()
		self.hovering = false
	end

	function confirmbutton:Paint(w, h)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

		local col = Color(100, 100, 100, 255)

		draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

		if self.hovering then
			col = asrColor
		end

		draw.SimpleText("Yes", "AsrRoboto30", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	function confirmbutton:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		timer.Remove("AutoCloseWindowTimer")

		net.Start("AsrReferConfirmed")
		net.WriteString(ply:SteamID())
		net.SendToServer()

		confirmpanel:Close()
	end

	local denybutton = vgui.Create("DButton", confirmpanel)
	denybutton:SetText("")
	denybutton:SetSize(100, 40)
	denybutton:SetPos(130, 75)
	denybutton.hovering = false
	denybutton.alpha = 0

	function denybutton:OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")

		self.hovering = true
	end

	function denybutton:OnCursorExited()
		self.hovering = false
	end

	function denybutton:Paint(w, h)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

		local col = Color(100, 100, 100, 255)

		draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

		if self.hovering then
			col = asrColor
		end

		draw.SimpleText("No", "AsrRoboto30", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	function denybutton:DoClick()
		timer.Remove("AutoCloseWindowTimer")

		surface.PlaySound("UI/buttonclickrelease.wav")

		confirmpanel:Close()
	end

	timer.Create("AutoCloseWindowTimer", 1, ASR.AutocloseConfirmationTimer, function()
		closetimer = closetimer - 1

		if timer.RepsLeft("AutoCloseWindowTimer") == 0 then
			confirmpanel:Close()
		end
	end)
end

function AsrReferCodeWindow(frame)
	local refercodepanel = vgui.Create("DFrame")
	refercodepanel:SetSize(250, 200)
	refercodepanel:SetPos(ScrW() / 2 - 125, ScrH() / 2 - 100)
	refercodepanel:SetTitle("")
	refercodepanel:SetVisible(true)
	refercodepanel:ShowCloseButton(false)
	refercodepanel:SetBackgroundBlur(true)
	refercodepanel:MakePopup()

	function refercodepanel:Paint(w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(44, 47, 52, 255))
		draw.RoundedBox(6, 0, 0, w, h - 5, Color(54, 57, 62, 255))

		draw.DrawText("Enter your inviter's\n referral code here!", "AsrRoboto25", w / 2, 15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	end

	local refercodeentry = vgui.Create("DTextEntry", refercodepanel)
	refercodeentry:SetSize(230, 50)
	refercodeentry:SetPos(10, 80)
	refercodeentry:SetText("Code")
	refercodeentry:SetFont("AsrRoboto30")

	function refercodeentry:OnTextChanged()
		if string.len(self:GetValue()) > 6 then
			self:SetText(string.sub(self:GetValue(), 1, 6))
			self:SetValue(string.sub(self:GetValue(), 1, 6))
			self:SetCaretPos(6)

			surface.PlaySound("UI/buttonrollover.wav")
		end
	end

	local confirmbutton = vgui.Create("DButton", refercodepanel)
	confirmbutton:SetText("")
	confirmbutton:SetSize(110, 40)
	confirmbutton:SetPos(130, 148)
	confirmbutton.hovering = false
	confirmbutton.alpha = 0

	function confirmbutton:OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")

		self.hovering = true
	end

	function confirmbutton:OnCursorExited()
		self.hovering = false
	end

	function confirmbutton:Paint(w, h)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

		local col = Color(100, 100, 100, 255)

		draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

		if self.hovering then
			col = asrColor
		end

		draw.SimpleText("Accept", "AsrRoboto30", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	function confirmbutton:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		local enteredcode = refercodeentry:GetValue()
		local codesteamid = AsrSIDFromCode(enteredcode)

		if !codesteamid then
			AsrNotify("The referral code you entered is invalid, please try again!")

			return
		elseif codesteamid == LocalPlayer():SteamID() then
			AsrNotify("You can't reward yourself!")

			return
		elseif AsrReferrerSID(codesteamid) == LocalPlayer():SteamID() then
			AsrNotify("You can't reward a player that you referred to the server!")

			return
		else
			if frame then
				frame:Close()
			end

			AsrConfirmReferrerWindow(codesteamid)

			refercodepanel:Close()
		end
	end

	local denybutton = vgui.Create("DButton", refercodepanel)
	denybutton:SetText("")
	denybutton:SetSize(110, 40)
	denybutton:SetPos(10, 148)
	denybutton.hovering = false
	denybutton.alpha = 0

	function denybutton:OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")

		self.hovering = true
	end

	function denybutton:OnCursorExited()
		self.hovering = false
	end

	function denybutton:Paint(w, h)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

		local col = Color(100, 100, 100, 255)

		draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

		if self.hovering then
			col = asrColor
		end

		draw.SimpleText("Cancel", "AsrRoboto30", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	function denybutton:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		if frame then
			frame:SetVisible(true)
		end

		refercodepanel:Close()
	end
end

function AsrConfirmReferrerWindow(steamid)
	local confirmpanel = vgui.Create("DFrame")
	confirmpanel:SetSize(280, 175)
	confirmpanel:SetPos(ScrW() / 2 - 125, ScrH() / 2 - 62)
	confirmpanel:SetTitle("")
	confirmpanel:SetVisible(true)
	confirmpanel:ShowCloseButton(false)
	confirmpanel:SetBackgroundBlur(true)
	confirmpanel:MakePopup()
	confirmpanel.nick = AsrNickSID(steamid)

	function confirmpanel:Paint(w, h)
		draw.RoundedBox(9, 0, 0, w, h, Color(44, 47, 52, 255))
		draw.RoundedBox(9, 0, 0, w, h - 5, Color(54, 57, 62, 255))

		local txt = "Are you sure you want to set "..AsrCutText(self.nick, "AsrRoboto25", 150).." as your referrer? This can't be changed once confirmed!"

		local parsedTxt = AsrTextWrap(txt, "AsrRoboto25", 260)

		AsrDrawFormatedText(parsedTxt, "AsrRoboto25", 10, 10, Color(255, 255, 255))
	end

	local confirmbutton = vgui.Create( "DButton", confirmpanel)
	confirmbutton:SetText("")
	confirmbutton:SetSize(100, 40)
	confirmbutton:SetPos(130, 120)
	confirmbutton.hovering = false
	confirmbutton.alpha = 0

	function confirmbutton:OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")

		self.hovering = true
	end

	function confirmbutton:OnCursorExited()
		self.hovering = false
	end

	function confirmbutton:Paint(w, h)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

		local col = Color(100, 100, 100, 255)

		draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

		if self.hovering then
			col = asrColor
		end

		draw.SimpleText("Yes", "AsrRoboto30", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	function confirmbutton:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		net.Start("AsrReferConfirmed")
		net.WriteString(steamid)
		net.SendToServer()

		confirmpanel:Close()
	end

	local denybutton = vgui.Create("DButton", confirmpanel)
	denybutton:SetText("")
	denybutton:SetSize(100, 40)
	denybutton:SetPos(20, 120)
	denybutton.hovering = false
	denybutton.alpha = 0

	function denybutton:OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")

		self.hovering = true
	end

	function denybutton:OnCursorExited()
		self.hovering = false
	end

	function denybutton:Paint(w, h)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

		local col = Color(100, 100, 100, 255)

		draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

		if self.hovering then
			col = asrColor
		end

		draw.SimpleText("No", "AsrRoboto30", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	function denybutton:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		confirmpanel:Close()
	end
end

function AsrSpecialRewardWindow(act, frame)
	local rewardpanel = vgui.Create("DFrame")
	rewardpanel:SetSize(280, 144)
	rewardpanel:SetPos(ScrW() / 2 - 140, ScrH() / 2 - 72)
	rewardpanel:SetTitle("")
	rewardpanel:SetVisible(true)
	rewardpanel:ShowCloseButton(false)
	rewardpanel:SetBackgroundBlur(true)
	rewardpanel:MakePopup()

	function rewardpanel:Paint(w, h)
		draw.RoundedBox(3, 0, 0, w, h, Color(54, 57, 62, 255))

		local txt = ""

		if act == 1 then
			txt = AsrTextWrap("Join our official steam group and get special rewards!", "AsrRoboto25", 260)
		elseif act == 2 then
			txt = AsrTextWrap("Add our nametag: "..ASR.ServerNameTag.." to your steam name, and get rewarded!", "AsrRoboto25", 260)
		end

		AsrDrawFormatedText(txt, "AsrRoboto25", 10, 10, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	local confirmbutton = vgui.Create("DButton", rewardpanel)
	confirmbutton:SetText("")
	confirmbutton:SetSize(100, 40)
	confirmbutton:SetPos(145, 94)
	confirmbutton.hovering = false
	confirmbutton.alpha = 0

	function confirmbutton:OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")

		self.hovering = true
	end

	function confirmbutton:OnCursorExited()
		self.hovering = false
	end

	function confirmbutton:Paint(w, h)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

		local col = Color(100, 100, 100, 255)

		draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

		if self.hovering then
			col = asrColor
		end

		draw.SimpleText("Yes", "AsrRoboto30", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	function confirmbutton:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		if act == 1 then
			if LocalPlayer():AsrIsGroupMember() then
				AsrNotify("You were already rewarded for joining our steam group!")

				return
			end

			gui.OpenURL(ASR.SteamGroupLink)

			net.Start("AsrSteamGroupCheck")
			net.SendToServer()
		elseif act == 2 then
			if LocalPlayer():AsrIsAdvertiser() then
				AsrNotify("You were already rewarded for using our nametag!")

				return
			end

			net.Start("AsrNameTagCheck")
			net.SendToServer()
		end

		if frame != nil then
			frame:Close()
		end

		rewardpanel:Close()
	end

	local denybutton = vgui.Create("DButton", rewardpanel)
	denybutton:SetText("")
	denybutton:SetSize(100, 40)
	denybutton:SetPos(35, 94)
	denybutton.hovering = false
	denybutton.alpha = 0

	function denybutton:OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")

		denybutton.hovering = true
	end

	function denybutton:OnCursorExited()
		denybutton.hovering = false
	end

	function denybutton:Paint(w, h)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

		local col = Color(100, 100, 100, 255)

		draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

		if self.hovering then
			col = asrColor
		end

		draw.SimpleText("No", "AsrRoboto30", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	function denybutton:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		if frame != nil then
			frame:SetVisible(true)
		end

		rewardpanel:Close()
	end
end

function AsrThanksWindow()
	surface.PlaySound("ui/achievement_earned.wav")

	local confirmhovering = false

	local asr_thanks_panel = vgui.Create("DFrame")
	asr_thanks_panel:SetSize(300, 450)
	asr_thanks_panel:SetPos(ScrW() / 2 - 150, ScrH() / 2 - 225)
	asr_thanks_panel:SetTitle("")
	asr_thanks_panel:SetVisible(true)
	asr_thanks_panel:ShowCloseButton(false)
	asr_thanks_panel:SetBackgroundBlur(true)
	asr_thanks_panel:MakePopup()
	asr_thanks_panel.txt = "Hello, and thanks for buying my script, Alek's Server Rewards! As always, I just wanted to thank you for your purchase, and to remind you that, since this is a new version of the script, it might have some bugs, so please, post a support ticket when fiding one, and I will fix it as soon as possible. Thanks for your support, and if you haven't, please post a review of the script by clicking [HERE]." --76561198060562411

	function asr_thanks_panel:Paint(w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(44, 47, 52, 255))
		draw.RoundedBox(6, 0, 0, w, h - 5, Color(54, 57, 62, 255))

		local parsedText = AsrTextWrap(self.txt, "AsrRoboto25", 280)

    AsrDrawFormatedText(parsedText, "AsrRoboto25", 10, 10, Color(255, 255, 255))
	end

	local confirmbutton = vgui.Create("DButton", asr_thanks_panel)
	confirmbutton:SetText("")
	confirmbutton:SetSize(270, 40)
	confirmbutton:SetPos(15, 395)
	confirmbutton.hovering = false
	confirmbutton.alpha = 0

	function confirmbutton:OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")

		confirmbutton.hovering = true
	end

	function confirmbutton:OnCursorExited()
		confirmbutton.hovering = false
	end

	function confirmbutton:Paint(w, h)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

		local col = Color(100, 100, 100, 255)

		draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

		if self.hovering then
			col = asrColor
		end

		draw.SimpleText("You're welcome :D!", "AsrRoboto30", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	function confirmbutton:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		net.Start("AsrThanksSent")
		net.SendToServer()

		asr_thanks_panel:Close()
	end

	local reviewbutton = vgui.Create("DButton", asr_thanks_panel)
	reviewbutton:SetText("")
	reviewbutton:SetSize(62, 20)
	reviewbutton:SetPos(12, 362)

	function reviewbutton:Paint(w, h)
		AsrDrawBorders(0, 0, w, h, true, true, true, true)
	end

	function reviewbutton:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		gui.OpenURL("https://scriptfodder.com/scripts/view/2560/reviews")
	end
end
