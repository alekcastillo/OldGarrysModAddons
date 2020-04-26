//Functions

function otherRewardsTab(frame)
	AsrCheckTab(3)

	local groupName = asr_groupinfo["name"]
	local groupMembers = asr_groupinfo["members"]

	invitespanel = vgui.Create("DPanel", frame)
	invitespanel:SetSize(624, 534)
	invitespanel:SetPos(135, 35)

	function invitespanel:Paint(w, h)
		AsrDrawTitle("Steam Group", "AsrTitle1", Color(255, 255, 255), w / 2, 35, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2)

		AsrDrawTitle(AsrCutText(groupName, "AsrRoboto55", 380), "AsrRoboto55", asrColor, 239, 190, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 4)

		draw.SimpleText(groupMembers.." members", "AsrRoboto45", 239, 250, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		AsrDrawBorders(87, 152, 136, 144, true, true, true, true)
	end

	local entergroupbtn = vgui.Create("DButton", invitespanel)
	entergroupbtn:SetSize(523, 100)
	entergroupbtn:SetPos(50, 353)
	entergroupbtn:SetText("")
	entergroupbtn.hovering = false
	entergroupbtn.alpha = 0

	local isMember = LocalPlayer():AsrIsGroupMember()

	function entergroupbtn:Paint(w, h)
		self.alpha = AsrAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

		local col = Color(100, 100, 100, 255)

		draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

		if self.hovering then
			col = asrColor
		end

		if isMember then
			draw.SimpleText("You were already rewarded for joining", "AsrRoboto35", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText("Join now, and receive special rewards!", "AsrRoboto35", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end

	function entergroupbtn:OnCursorEntered()
		self.hovering = true
	end

	function entergroupbtn:OnCursorExited()
		self.hovering = false
	end

	function entergroupbtn:DoClick()
		if LocalPlayer():AsrIsGroupMember() then
			AsrNotify("You were already rewarded for joining our steam group!")

			return
		end

		AsrSpecialRewardWindow(1, frame)

		frame:SetVisible(false)
	end

	local asrGroupIcon = util.Base64Encode(file.Read("asr_"..groupName.."_group_icon.txt", "DATA"))

	if asrGroupIcon then
		local groupIcon = vgui.Create("DHTML", invitespanel)
		groupIcon:SetSize(150, 150)
		groupIcon:SetPos(80, 145)
		groupIcon:SetHTML([[
			<style type="text/css">
				body {
					overflow: hidden;
				}

				img {
					width: 100%;
					height: 100%
				}
			</style>

			<img src="data:image/jpg;base64, ]]..asrGroupIcon..[[ ">
		]])
	else
		AsrSaveGroupImage()

		local noicon = vgui.Create("AvatarImage", invitespanel)
		noicon:SetSize(134, 142)
		noicon:SetPos(88, 153)
		noicon:SetSteamID("yep, this is cheap, but it works", 80)
	end
end
