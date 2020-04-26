//Functions

function leadersTab(frame)
	AsrCheckTab(2)

	local firstrefers = 0
	local firstplace = 0
	local secondrefers = 0
	local secondplace = 0
	local thirdrefers = 0
	local thirdplace = 0
	local toRemove = {}

	invitespanel = vgui.Create("DPanel", frame)
	invitespanel:SetSize(624, 534)
	invitespanel:SetPos(135, 35)

	function invitespanel:Paint(w, h)
		AsrDrawTitle("Leaderboard", "AsrTitle1", Color(255, 255, 255), w / 2, 35, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2)
	end

	if ASR.LeaderboardExtraSpots == 0 or #asrLeadersTbl < 4 and !ASR.AlwaysShowExtraLeaderboardSpots then
		local firstspot = vgui.Create("DPanel", invitespanel)
		firstspot:SetSize(257, 200)
		firstspot:SetPos(184, 100)

		function firstspot:Paint(w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(46, 48, 52, 255))
			draw.RoundedBox(6, 0, 0, w, 60, Color(192, 155, 35, 255))
			draw.RoundedBox(6, 0, 0, w, 56, Color(212, 175, 55, 255))

			draw.SimpleText("1st", "AsrTitle2", w / 2, 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			if #asrLeadersTbl > 0 then
				draw.SimpleText(asrLeadersTbl[1]["nick"], "AsrRoboto25", w / 2, h / 2 - 5, Color(150, 150, 150, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(asrLeadersTbl[1]["refers"].." refers", "AsrRoboto60", w / 2, h / 2 + 30, Color(100, 100, 100, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("There is no first place", "AsrRoboto25", w / 2, h / 2 + 10, Color(100, 100, 100, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("at the moment...", "AsrRoboto25", w / 2, h / 2 + 30, Color(100, 100, 100, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end

		local secondspot = vgui.Create("DPanel", invitespanel)
		secondspot:SetSize(257, 200)
		secondspot:SetPos(50, 310)

		function secondspot:Paint(w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(46, 48, 52, 255))
			draw.RoundedBox(6, 0, 0, w, 60, Color(172, 172, 172, 255))
			draw.RoundedBox(6, 0, 0, w, 56, Color(192, 192, 192, 255))

			draw.SimpleText("2nd", "AsrTitle2", w / 2, 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			if #asrLeadersTbl > 1 then
				draw.SimpleText(asrLeadersTbl[2]["nick"], "AsrRoboto25", w / 2, h / 2 - 5, Color(150, 150, 150, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(asrLeadersTbl[2]["refers"].." refers", "AsrRoboto60", w / 2, h / 2 + 30, Color(100, 100, 100, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("There is no second place", "AsrRoboto25", w / 2, h / 2 + 10, Color(100, 100, 100, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("at the moment...", "AsrRoboto25", w / 2, h / 2 + 30, Color(100, 100, 100, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end

		local thirdspot = vgui.Create("DPanel", invitespanel)
		thirdspot:SetSize(257, 200)
		thirdspot:SetPos(317, 310)

		function thirdspot:Paint(w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(46, 48, 52, 255))
			draw.RoundedBox(6, 0, 0, w, 60, Color(105, 85, 35, 255))
			draw.RoundedBox(6, 0, 0, w, 56, Color(125, 105, 55, 255))

			draw.SimpleText("3rd", "AsrTitle2", w / 2, 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			if #asrLeadersTbl > 2 then
				draw.SimpleText(asrLeadersTbl[3]["nick"], "AsrRoboto25", w / 2, h / 2 - 5, Color(150, 150, 150, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(asrLeadersTbl[3]["refers"].." refers", "AsrRoboto60", w / 2, h / 2 + 30, Color(100, 100, 100, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("There is no third place", "AsrRoboto25", w / 2, h / 2 + 10, Color(100, 100, 100, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("at the moment...", "AsrRoboto25", w / 2, h / 2 + 30, Color(100, 100, 100, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	else
		local leaderscroll = vgui.Create("DScrollPanel", invitespanel)
		leaderscroll:SetSize(604, 424)
		leaderscroll:SetPos(10, 100)

		function leaderscroll:Paint(w, h) end

		local leaderscrollbar = leaderscroll:GetVBar()

		function leaderscrollbar:Paint(w, h)
			draw.RoundedBox(3, 5, 0, 10, h, Color(46, 49, 54, 255))
		end

		function leaderscrollbar.btnUp:Paint(w, h)
			draw.RoundedBox(3, 5, 0, 10, h, Color(36, 39, 44, 255))
		end

		function leaderscrollbar.btnDown:Paint(w, h)
			draw.RoundedBox(3, 5, 0, 10, h, Color(36, 39, 44, 255))
		end

		function leaderscrollbar.btnGrip:Paint(w, h)
			draw.RoundedBox(3, 5, 0, 10, h, Color(36, 39, 44, 255))
		end

		local topthree = vgui.Create("DPanel", leaderscroll)
		topthree:SetSize(0, 210)
		topthree:DockMargin(0, 0, 0, 10)
		topthree:Dock(TOP)
		topthree:SetText("")

		function topthree:Paint(w, h) end

		local firstspot = vgui.Create("DPanel", topthree)
		firstspot:SetSize(257, 100)
		firstspot:SetPos(173, 0)

		local spot1name = ""

		if #asrLeadersTbl > 0 then
			spot1name = asrLeadersTbl[1]["nick"]
		end

		function firstspot:Paint(w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, 150))

			draw.RoundedBox(6, 0, 0, 60, h, Color(192, 155, 35, 255))
			draw.RoundedBox(6, 0, 0, 56, h - 4, Color(212, 175, 55, 255))

			draw.SimpleText("1", "AsrTitle2", 30, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			if #asrLeadersTbl < 1 then
				spot1name = AsrTextWrap("There is no 1st place at the moment", "AsrRoboto25", 177)

				AsrDrawFormatedText(spot1name, "AsrRoboto25", 70, 15, Color(100, 100, 100, 255))
			else
				spot1name = AsrCutText(spot1name, "AsrRoboto25", 177)

				draw.SimpleText(spot1name, "AsrRoboto25", 70, 20, Color(150, 150, 150, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				draw.SimpleText(asrLeadersTbl[1]["refers"].." refers", "AsrRoboto45", 70, h - 10, Color(100, 100, 100, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			end
		end

		local secondspot = vgui.Create("DPanel", topthree)
		secondspot:SetSize(257, 100)
		secondspot:SetPos(40, 110)

		local spot2name = ""

		if #asrLeadersTbl > 1 then
			spot2name = asrLeadersTbl[2]["nick"]
		end

		function secondspot:Paint(w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, 150))

			draw.RoundedBox(6, 0, 0, 60, h, Color(172, 172, 172, 255))
			draw.RoundedBox(6, 0, 0, 56, h - 4, Color(192, 192, 192, 255))

			draw.SimpleText("2", "AsrTitle2", 30, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			if #asrLeadersTbl < 2 then
				spot2name = AsrTextWrap("There is no 2nd place at the moment", "AsrRoboto25", 177)

				AsrDrawFormatedText(spot2name, "AsrRoboto25", 70, 15, Color(100, 100, 100, 255))
			else
				spot2name = AsrCutText(spot2name, "AsrRoboto25", 177)

				draw.SimpleText(spot2name, "AsrRoboto25", 70, 20, Color(150, 150, 150, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				draw.SimpleText(asrLeadersTbl[2]["refers"].." refers", "AsrRoboto45", 70, h - 10, Color(100, 100, 100, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			end
		end

		local thirdspot = vgui.Create("DPanel", topthree)
		thirdspot:SetSize(257, 100)
		thirdspot:SetPos(307, 110)

		local spot3name = ""

		if #asrLeadersTbl > 2 then
			spot3name = asrLeadersTbl[3]["nick"]
		end

		function thirdspot:Paint(w, h)
			draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, 150))

			draw.RoundedBox(6, 0, 0, 60, h, Color(105, 85, 35, 255))
			draw.RoundedBox(6, 0, 0, 56, h - 4, Color(125, 105, 55, 255))

			draw.SimpleText("3", "AsrTitle2", 30, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			if #asrLeadersTbl < 3 then
				spot3name = AsrTextWrap("There is no 3rd place at the moment", "AsrRoboto25", 177)

				AsrDrawFormatedText(spot3name, "AsrRoboto25", 70, 15, Color(100, 100, 100, 255))
			else
				spot3name = AsrCutText(spot3name, "AsrRoboto25", 177)

				draw.SimpleText(spot3name, "AsrRoboto25", 70, 20, Color(150, 150, 150, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				draw.SimpleText(asrLeadersTbl[3]["refers"].." refers", "AsrRoboto45", 70, h - 10, Color(100, 100, 100, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			end
		end

		for k = 4, ASR.LeaderboardExtraSpots + 4, 1 do
			if k > #asrLeadersTbl and !ASR.AlwaysShowExtraLeaderboardSpots then return end

			local otherspot = vgui.Create("DPanel", leaderscroll)
			otherspot:SetSize(0, 74)
			otherspot:DockMargin(0, 0, 0, 10)
			otherspot:Dock(TOP)

			local spotoname = ""

			if !(#asrLeadersTbl < k) then
				spotoname = asrLeadersTbl[k]["nick"]
			end

			function otherspot:Paint(w, h)
				draw.RoundedBox(6, 40, 0, w - 65, h, Color(36, 39, 44, 150))

				draw.RoundedBox(6, 40, 0, 60, h, Color(75, 75, 75, 255))
				draw.RoundedBox(6, 40, 0, 56, h - 4, Color(95, 95, 95, 255))

				draw.SimpleText(k, "AsrTitle2", 70, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

				if #asrLeadersTbl < k then
					draw.SimpleText("There is no "..AsrOrdinalNumber(k).." place at the moment", "AsrRoboto25", 40 + 70, h / 2, Color(100, 100, 100, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText(asrLeadersTbl[k]["nick"], "AsrRoboto25", 40 + 70, h / 2, Color(150, 150, 150, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					draw.SimpleText(asrLeadersTbl[k]["refers"].." refers", "AsrRoboto45", w - 40, h / 2, Color(100, 100, 100, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				end
			end
		end
	end
end
