//Load Laws

function GetPLSLaws()
	return PLS_Laws
end

net.Receive("PLS_LoadLaws", function(len)
	PLS_Laws = net.ReadTable()
	print("[The Laws] Laws have been loaded for the first time!")
end)

net.Receive("PLS_ReloadLaws", function(len)
	PLS_Laws = net.ReadTable()
	print("[The Laws] Laws have been reloaded.")
end)

//Recieve Command

net.Receive("PLS_ViewLaws", function() ShowLaws() end)

function ShowLaws()
	local frame = vgui.Create("DFrame")
	frame:SetSize(600,450)
	frame:SetPos(ScrW() / 2 - 300,ScrH() / 2 - 225)
	frame:SetTitle(PLS.LawsBoardTitle)
	frame:SetVisible(true)
	frame:MakePopup()
	function frame:Paint(w,h)
		draw.RoundedBox(0,0,0,w,h,PLS.BackgroundColor)
	end

	local lawspanel = vgui.Create("DPanel", frame)
	lawspanel:SetSize(580,405)
	lawspanel:SetPos(10,35)
	function lawspanel:Paint(w,h)
		draw.RoundedBox(0,0,0,w,h,PLS.BackgroundColor)
	end
	local scroll = vgui.Create("DScrollPanel", lawspanel)
	scroll:Dock(FILL)

	for k, v in pairs(GetPLSLaws()) do
		local lawpanel = vgui.Create("DPanel",scroll)
		lawpanel:SetSize(0,40)
		lawpanel:DockMargin(0,0,0,3)
		lawpanel:Dock(TOP)
		lawpanel:SetText("")
		function lawpanel:Paint(w,h)
			if v[2] == "legal" then
				draw.RoundedBox(0,0,0,w,h,PLS.LegalLawColor)
			elseif v[2] == "illegal" then
				draw.RoundedBox(0,0,0,w,h,PLS.IllegalLawColor)
			else
				draw.RoundedBox(0,0,0,w,h,Color(255,255,255))
			end
			surface.SetFont("Trebuchet24")
			local tw,th = surface.GetTextSize(v[1])
			draw.DrawText(k..".","Trebuchet24",30,h/2 - th/2,Color(255,255,255),TEXT_ALIGN_LEFT)
			draw.DrawText(v[1],"Trebuchet24",w/2,h/2 - th/2,Color(255,255,255),TEXT_ALIGN_CENTER)
		end
		if PLS.AllowLawChangeRequesting and !LocalPlayer():isMayor() then
			local lawbutton = vgui.Create("DButton",lawpanel)
			lawbutton:SetSize(24,24)
			lawbutton:SetPos(532, 8)
			lawbutton:SetText("")
			if v[3] != false then
				lawbutton:SetImage("icon16/pencil.png")
			else
				lawbutton:SetImage("icon16/lock_edit.png")
			end
			function lawbutton:Paint(w,h)
				draw.RoundedBox(0,0,0,w,h,PLS.BackgroundColor)
			end
			lawbutton.DoClick = function()
				local lawchanger = LocalPlayer()
				local lawmenu = DermaMenu()
				if v[2] == "legal" and v[3] == true then
					local requestillegalizebutton = lawmenu:AddOption( "Request the mayor to ilegalize the law "..k )
					requestillegalizebutton:SetIcon( "icon16/cross.png" )
					requestillegalizebutton.DoClick = function()
						LocalPlayer():ConCommand("say /advert mr.Mayor, as a member of this city with rights, I request you to illegalize "..v[1].."!")
					end
				elseif v[2] == "illegal" and v[3] == true then
					local requestlegalizebutton = lawmenu:AddOption( "Request the mayor to legalize the law "..k )
					requestlegalizebutton:SetIcon( "icon16/tick.png" )
					requestlegalizebutton.DoClick = function()
						LocalPlayer():ConCommand("say /advert mr.Mayor, as a member of this city with rights, I request you to legalize "..v[1].."!")
					end
				elseif v[3] == false then
					local lawunchangable = lawmenu:AddOption( "Not even the mayor can change the law "..k.."!" )
					lawunchangable:SetIcon( "icon16/lock_edit.png" )
				else
					local errorbutton = lawmenu:AddOption( "An unexpected error ocurred!" )
					errorbutton:SetIcon( "icon16/bug.png" )
				end
				lawmenu:Open()
			end
		end
	end
end

/*

				if lawchanger:isMayor() then
					if v[2] == "legal" and v[3] == true then
						local illegalizebutton = lawmenu:AddOption( "Illegalize the law "..k )
						illegalizebutton:SetIcon( "icon16/cross.png" )
						illegalizebutton.DoClick = function()
							net.Start("PLS_LawChanged")
							net.WriteTable({k,"illegal"}) 
							net.SendToServer()
							timer.Create("ReloadLaws",0.05,1,function()
								frame:Close()
								ShowLaws()
							end)
						end
					elseif v[2] == "illegal" and v[3] == true then
						local legalizebutton = lawmenu:AddOption( "Legalize the law "..k )
						legalizebutton:SetIcon( "icon16/tick.png" )
						legalizebutton.DoClick = function()
							net.Start("PLS_LawChanged")
							net.WriteTable({k,"legal"})
							net.SendToServer()
							timer.Create("ReloadLaws",0.05,1,function()
								frame:Close()
								ShowLaws()
							end)
						end
					elseif v[3] == false then
						local lawunchangable = lawmenu:AddOption( "The law "..k.." can't be changed!" )
						lawunchangable:SetIcon( "icon16/lock_edit.png" )
					else
						local errorbutton = lawmenu:AddOption( "An unexpected error ocurred!" )
						errorbutton:SetIcon( "icon16/bug.png" )
					end
				else
*/

print("Persistent Laws System (client) successfully loaded!")