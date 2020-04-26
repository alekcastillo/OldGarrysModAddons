//Fonts

for f = 5, 100, 5 do
	surface.CreateFont("AsrRoboto"..f,{
		font = "Roboto",
		size = f,
		weight = 1000,
		antialias = true
	})
end

surface.CreateFont("AsrTitle1",{
	font = "ONE DAY",
	size = 50,
	weight = 500,
	antialias = true
})

surface.CreateFont("AsrTitle2",{
	font = "ONE DAY",
	size = 34,
	weight = 1000,
	antialias = true
})

//Functions

function AsrRewardsWindow(tab)
	asrCurrentTab = tab

	local frame = vgui.Create("DFrame")
	frame:SetSize(760, 570)

	if ASR.EnableUIAnimations then
		frame:SetPos(ScrW() / 2 - 380, ScrH())
	else
		frame:SetPos(ScrW() / 2 - 380, ScrH() / 2 - 285)
	end

	frame:SetTitle("")
	frame:ShowCloseButton(false)
	frame:SetDraggable(false)
	frame:SetVisible(true)
	frame:MakePopup()

	local openAnim = Derma_Anim("OpenAnimation", frame, function(pnl, anim, delta, data)
		frame:SetPos(ScrW() / 2 - 380, AsrQuad(delta, ScrH(), -(ScrH() / 2 + 285)))
	end)

	local closeAnim = Derma_Anim("CloseAnimation", frame, function(pnl, anim, delta, data)
		frame:SetPos(ScrW() / 2 - 380, AsrQuad(delta, ScrH() / 2 - 285, ScrH()))
	end)

	if ASR.EnableUIAnimations then
		openAnim:Start(0.5)

		function frame:Think()
			if openAnim:Active() then
				openAnim:Run()
			elseif closeAnim:Active() then
				closeAnim:Run()
			end
		end
	end

	function frame:Paint(w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(48, 50, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h - 3, Color(54, 57, 62, 255))
	end

	local closebutton = vgui.Create("DButton", frame)
	closebutton:SetSize(40, 15)
	closebutton:SetPos(710, 10)
	closebutton:SetText("")
	closebutton:SetTooltip("Close")

	function closebutton:Paint(w, h)
		draw.RoundedBox(3, 0, 0, w, h, asrColor)
	end

	function closebutton:DoClick()
		if ASR.EnableUIAnimations then
			closeAnim:Start(0.5)

			timer.Simple(0.6, function()
				frame:Close()
			end)
		else
			frame:Close()
		end
	end

	local buttonspanel = vgui.Create("DPanel", frame)
	buttonspanel:SetSize(135, 570)
	buttonspanel:SetPos(0, 0)

	function buttonspanel:Paint(w, h)
		draw.RoundedBox(6, 0, 0, w + 5, h, Color(22, 24, 28, 255))
		draw.RoundedBox(6, 0, 0, w + 5, h - 3, Color(30, 33, 36, 255))
	end

	local playersbutton = vgui.Create("DButton", buttonspanel)
	playersbutton:SetSize(125, 125)
	playersbutton:SetPos(5, 20)
	playersbutton:SetText("")
	playersbutton:SetTooltip("Players")
	playersbutton.hovering = false
	playersbutton.halpha = 0
	playersbutton.alpha = 0

	function playersbutton:Paint(w, h)
		self.halpha = AsrAnimateHover(self.halpha, 0, 255, 10, 10, self.hovering, false)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 5, 5, asrCurrentTab == 1, false)

		surface.SetDrawColor(46, 49, 54, 255)

		surface.SetMaterial(ply_texture)
		surface.DrawTexturedRect(0, 0, w, h)

		surface.SetDrawColor(52, 55, 60, self.halpha)

		surface.SetMaterial(ply_texture)
		surface.DrawTexturedRect(0, 0, w, h)

		surface.SetDrawColor(asrColor.r, asrColor.g, asrColor.b, self.alpha)

		surface.SetMaterial(ply_texture)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	function playersbutton:OnCursorEntered()
		if asrCurrentTab == 1 then return end

		self.hovering = true
	end

	function playersbutton:OnCursorExited()
		self.hovering = false
	end

	function playersbutton:DoClick()
		if asrCurrentTab == 1 then return end

		surface.PlaySound("UI/buttonclick.wav")

		playersTab(frame)
	end

	local leaderboardbutton = vgui.Create("DButton", buttonspanel)
	leaderboardbutton:SetSize(125, 125)
	leaderboardbutton:SetPos(5, 155)
	leaderboardbutton:SetText("")
	leaderboardbutton:SetTooltip("Leaderboard")
	leaderboardbutton.hovering = false
	leaderboardbutton.halpha = 0
	leaderboardbutton.alpha = 0

	function leaderboardbutton:Paint(w, h)
		self.halpha = AsrAnimateHover(self.halpha, 0, 255, 10, 10, self.hovering, false)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 5, 5, asrCurrentTab == 2, false)

		surface.SetDrawColor(46, 49, 54, 255)

		surface.SetMaterial(leader_texture)
		surface.DrawTexturedRect(0, 0, w, h)

		surface.SetDrawColor(52, 55, 60, self.halpha)

		surface.SetMaterial(leader_texture)
		surface.DrawTexturedRect(0, 0, w, h)

		surface.SetDrawColor(asrColor.r, asrColor.g, asrColor.b, self.alpha)

		surface.SetMaterial(leader_texture)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	function leaderboardbutton:OnCursorEntered()
		if asrCurrentTab == 2 then return end

		self.hovering = true
	end

	function leaderboardbutton:OnCursorExited()
		self.hovering = false
	end

	function leaderboardbutton:DoClick()
		if asrCurrentTab == 2 then return end

		surface.PlaySound("UI/buttonclick.wav")

		leadersTab(frame)
	end

	if ASR.EnableSteamGroupRewards then
		AsrSaveGroupImage()

		local steambutton = vgui.Create("DButton", buttonspanel)
		steambutton:SetSize(125, 125)
		steambutton:SetPos(5, 290)
		steambutton:SetText("")
		steambutton:SetTooltip("Steam group")
		steambutton.hovering = false
		steambutton.halpha = 0
		steambutton.alpha = 0

		function steambutton:Paint(w, h)
			self.halpha = AsrAnimateHover(self.halpha, 0, 255, 10, 10, self.hovering, false)
			self.alpha = AsrAnimateHover(self.alpha, 0, 255, 5, 5, asrCurrentTab == 3, false)

			surface.SetDrawColor(46, 49, 54, 255)

			surface.SetMaterial(steam_texture)
			surface.DrawTexturedRect(0, 0, w, h)

			surface.SetDrawColor(52, 55, 60, self.halpha)

			surface.SetMaterial(steam_texture)
			surface.DrawTexturedRect(0, 0, w, h)

			surface.SetDrawColor(asrColor.r, asrColor.g, asrColor.b, self.alpha)

			surface.SetMaterial(steam_texture)
			surface.DrawTexturedRect(0, 0, w, h)
		end

		function steambutton:OnCursorEntered()
			if asrCurrentTab == 3 then return end

			self.hovering = true
		end

		function steambutton:OnCursorExited()
			self.hovering = false
		end

		function steambutton:DoClick()
			if asrCurrentTab == 3 then return end

			surface.PlaySound("UI/buttonclick.wav")

			otherRewardsTab(frame)
		end
	end

	local profilebutton = vgui.Create("DButton", buttonspanel)
	profilebutton:SetSize(125, 125)
	profilebutton:SetPos(5, 425)
	profilebutton:SetText("")
	profilebutton:SetTooltip("My profile")
	profilebutton.hovering = false
	profilebutton.halpha = 0
	profilebutton.alpha = 0

	function profilebutton:Paint(w, h)
		self.halpha = AsrAnimateHover(self.halpha, 0, 255, 10, 10, self.hovering, false)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 5, 5, asrCurrentTab == 4, false)

		surface.SetDrawColor(46, 49, 54, 255)

		surface.SetMaterial(profile_texture)
		surface.DrawTexturedRect(0, 0, w, h)

		surface.SetDrawColor(52, 55, 60, self.halpha)

		surface.SetMaterial(profile_texture)
		surface.DrawTexturedRect(0, 0, w, h)

		surface.SetDrawColor(asrColor.r, asrColor.g, asrColor.b, self.alpha)

		surface.SetMaterial(profile_texture)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	function profilebutton:OnCursorEntered()
		if asrCurrentTab == 4 then return end

		self.hovering = true
	end

	function profilebutton:OnCursorExited()
		self.hovering = false
	end

	function profilebutton:DoClick()
		if asrCurrentTab == 4 then return end

		surface.PlaySound("UI/buttonclick.wav")

		profileTab(frame, LocalPlayer():SteamID())
	end

	if !ASR.EnableSteamGroupRewards then
		playersbutton:SetPos(5, 49)
		leaderboardbutton:SetPos(5, 218)
		profilebutton:SetPos(5, 397)
	end

	if tab == 1 then
		playersTab(frame)
	elseif tab == 2 then
		leadersTab(frame, asrLeadersTbl)
	elseif tab == 3 then
		otherRewardsTab(frame)
	elseif tab == 4 then
		profileTab(frame, LocalPlayer():SteamID())
	end
end

//Net Messages

net.Receive("AsrMenu", function()
	AsrRewardsWindow(1)
end)

net.Receive("AsrOpenConfirmationMenu", function()
	local ply = net.ReadEntity(referrerply)

	AsrConfirmationMenu(ply)
end)

net.Receive("AsrReferCodeMenu", function()
	AsrReferCodeWindow()
end)

net.Receive("AsrSteamGroupMenu", function()
	AsrSpecialRewardWindow(1)
end)

net.Receive("AsrNameTagMenu", function()
	AsrSpecialRewardWindow(2)
end)

net.Receive("AsrThanks", function()
	AsrThanksWindow()
end)

//Hooks

hook.Add("Initialize", "AsrInit", function()
	asrColor = ASR.Theme_AccentColor

	AsrPrepareMaterials()

	if ASR.Theme_RainbowAccentColor then
		local asr_r = 100
		local asr_g = 150
		local asr_b  = 200
		timer.Create("AsrRainbowColorsTimer", 0.1, 0, function()
			asr_r = math.random(-35, 35)
			asr_g = math.random(-35, 35)
			asr_b = math.random(-35, 35)

			asrColor = Color(math.min(math.max(asrColor.r + asr_r, 0), 255), math.min(math.max(asrColor.g + asr_g, 0), 255), math.min(math.max(asrColor.b + asr_b, 0), 255))
		end)
	else
		asrColor = ASR.Theme_AccentColor
	end
end)
