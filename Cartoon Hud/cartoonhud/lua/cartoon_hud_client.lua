//Load Laws
function GetCHSLaws()
	return CHS_Laws
end
net.Receive("CH_LoadLaws", function(len)
	CHS_Laws = net.ReadTable()
	print("The laws have been loaded for the first time!")
end)
net.Receive("CH_ReloadLaws", function(len)
	CHS_Laws = net.ReadTable()
	print("The laws have been reloaded.")
end)

//Recieve Command
net.Receive("CH_ViewLaws", function() ShowLaws() end)
function ShowLaws()
	local frameborder = vgui.Create("DFrame")
	frameborder:SetSize(610, 450)
	frameborder:SetPos(ScrW() / 2 - 305, ScrH() / 2 - 225)
	frameborder:SetTitle(CartoonHudConfig.LawsBoardTitle)
	frameborder:SetVisible(true)
	frameborder:MakePopup()
	function frameborder:Paint(w,h)
		draw.RoundedBox(0, 0, 0, w, h, CartoonHudConfig.LawBoardBaseBorderColor)
	end
	local frame = vgui.Create("DPanel", frameborder)
	frame:SetSize(600, 415)
	frame:SetPos(5, 30)
	function frame:Paint(w,h)
		draw.RoundedBox(0, 0, 0, w, h, CartoonHudConfig.LawBoardBaseColor)
	end
	local lawspanel = vgui.Create("DPanel", frame)
	lawspanel:SetSize(580, 395)
	lawspanel:SetPos(10, 10)
	function lawspanel:Paint(w,h)
		draw.RoundedBox(0, 0, 0, w, h, CartoonHudConfig.LawBoardBaseColor)
	end
	local scroll = vgui.Create("DScrollPanel", lawspanel)
	scroll:Dock(FILL)
	for k, v in pairs(GetCHSLaws()) do
		local lawpanelborder = vgui.Create("DPanel",scroll)
		lawpanelborder:SetSize(0,40)
		lawpanelborder:DockMargin(0, 0, 0, 3)
		lawpanelborder:Dock(TOP)
		lawpanelborder:SetText("")
		function lawpanelborder:Paint(w,h)
			draw.RoundedBox(0, 0, 0, w, h, CartoonHudConfig.LawBoardLawBorderColor)
		end
		local lawpanel = vgui.Create("DPanel",lawpanelborder)
		lawpanel:SetSize(570,30)
		lawpanel:SetPos(5, 5)
		lawpanel:SetText("")
		function lawpanel:Paint(w,h)
			if v[2] == "legal" then
				draw.RoundedBox(0, 0, 0, w, h, CartoonHudConfig.LawBoardLegalLawColor)
			elseif v[2] == "illegal" then
				draw.RoundedBox(0, 0, 0, w, h, CartoonHudConfig.LawBoardIllegalLawColor)
			else
				draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255))
			end
			draw.RoundedBox(0, 0, h / 2, w, h, Color(0, 0, 0, 75))
			surface.SetFont("Trebuchet24")
			draw.SimpleTextOutlined(k..".", "Trebuchet24", 30, h / 2, CartoonHudConfig.LawBoardLawTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.LawBoardLawTextBorderColor)
			draw.SimpleTextOutlined(v[1], "Trebuchet24", w / 2, h / 2, CartoonHudConfig.LawBoardLawTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, CartoonHudConfig.LawBoardLawTextBorderColor)
		end
		if LocalPlayer():isMayor() then
			local lawbutton = vgui.Create("DButton",lawpanel)
			lawbutton:SetSize(24, 24)
			lawbutton:SetPos(532, 4)
			lawbutton:SetText("")
			if v[3] != false then
				lawbutton:SetImage("icon16/pencil.png")
			else
				lawbutton:SetImage("icon16/lock_edit.png")
			end
			function lawbutton:Paint(w,h)
				draw.RoundedBox(0, 0, 0, w, h, CartoonHudConfig.LawBoardBaseColor)
			end
			lawbutton.DoClick = function()
				local lawchanger = LocalPlayer()
				local lawmenu = DermaMenu()
				if v[2] == "legal" and v[3] == true then
					local illegalizebutton = lawmenu:AddOption("Illegalize the law "..k)
					illegalizebutton:SetIcon("icon16/cross.png")
					illegalizebutton.DoClick = function()
						net.Start("CH_LawChanged")
						net.WriteTable({k,"illegal"}) 
						net.SendToServer()
						timer.Create("ReloadLaws", 0.05, 1, function()
							frameborder:Close()
							ShowLaws()
						end)
					end
				elseif v[2] == "illegal" and v[3] == true then
					local legalizebutton = lawmenu:AddOption("Legalize the law "..k)
					legalizebutton:SetIcon("icon16/tick.png")
					legalizebutton.DoClick = function()
						net.Start("CH_LawChanged")
						net.WriteTable({k, "legal"})
						net.SendToServer()
						timer.Create("ReloadLaws", 0.05, 1, function()
							frameborder:Close()
							ShowLaws()
						end)
					end
				elseif v[3] == false then
					local lawunchangable = lawmenu:AddOption("The law "..k.." can't be changed!")
					lawunchangable:SetIcon("icon16/lock_edit.png")
				else
					local errorbutton = lawmenu:AddOption("An unexpected error ocurred!")
					errorbutton:SetIcon("icon16/bug.png")
				end
			lawmenu:Open()
			end
		end
	end
end
print("Cartoon Hud's persistent laws system has been successfully loaded!")