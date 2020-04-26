include("shared.lua")
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw()
	self:DrawModel()

	if self:GetPos():Distance(LocalPlayer():GetPos()) < 800 then
		local plyAng = LocalPlayer():GetAngles()
		local ang = Angle(0, plyAng.y - 180, 0)

		ang:RotateAroundAxis(ang:Forward(), 90)
		ang:RotateAroundAxis(ang:Right(), -90)

		cam.Start3D2D(self:GetPos() + self:GetForward() + self:GetUp() * 78, ang, 0.1)
			draw.RoundedBox(7, -175, -80, 350, 100, Color(32, 36, 38, 255))
			draw.RoundedBox(7, -175, -80, 350, 95, Color(42, 46, 48, 255))

			draw.SimpleText("Pet Shop", "pmTitle2", 0, -33, PetConfig.accentColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		cam.End3D2D()
	end
end

//Functions

local function pmNameMenu(pet, frame, data)
	local pmNameFrame = vgui.Create("DFrame")
	pmNameFrame:SetSize(250, 200)
	pmNameFrame:SetPos(ScrW() / 2 - 125, ScrH() / 2 - 100)
	pmNameFrame:SetTitle("")
	pmNameFrame:SetVisible(true)
	pmNameFrame:ShowCloseButton(false)
	pmNameFrame:SetBackgroundBlur(true)
	pmNameFrame:MakePopup()

	function pmNameFrame:Paint(w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(44, 47, 52, 255))
		draw.RoundedBox(6, 0, 0, w, h - 5, Color(54, 57, 62, 255))

		draw.DrawText("Type the name you want\nyour pet to have here!", "pmBody", w / 2, 15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
	end

	local pmNameEntry = vgui.Create("DTextEntry", pmNameFrame)
	pmNameEntry:SetSize(230, 50)
	pmNameEntry:SetPos(10, 80)
	pmNameEntry:SetText("Name")
	pmNameEntry:SetFont("pmBody")

	function pmNameEntry:OnTextChanged()
		if string.len(self:GetValue()) > 12 then
			self:SetText(string.sub(self:GetValue(), 1, 12))
			self:SetValue(string.sub(self:GetValue(), 1, 12))
			self:SetCaretPos(12)

			surface.PlaySound("UI/buttonrollover.wav")
		end
	end

	local pmNameConfirm = vgui.Create("DButton", pmNameFrame)
	pmNameConfirm:SetText("")
	pmNameConfirm:SetSize(110, 40)
	pmNameConfirm:SetPos(130, 148)
	pmNameConfirm.hovering = false
	pmNameConfirm.alpha = 0

	function pmNameConfirm:OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")

		self.hovering = true
	end

	function pmNameConfirm:OnCursorExited()
		self.hovering = false
	end

	function pmNameConfirm:Paint(w, h)
		self.alpha = pmAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

		local col = Color(100, 100, 100, 255)

		draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

		if self.hovering then
			col = PetConfig.accentColor
		end

		draw.SimpleText("Buy", "pmBody", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	function pmNameConfirm:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		local newName = pmNameEntry:GetValue()
		local name = pet["name"]

		if !pmCheckName(LocalPlayer(), newName) then return end

		if pmCanBuy(LocalPlayer(), pet) then
			local netTbl = {pet = name, name = newName}

			net.Start("SNPC_PETBASE_BUY")
			net.WriteTable(netTbl)
			net.SendToServer()
		elseif data then
			local netTbl = {pet = name, name = newNamedata, data = data}

			net.Start("SNPC_PETBASE_UPDATE_NAME")
			net.WriteTable(netTbl)
			net.SendToServer()
		end

		if frame then
			frame:Close()
		end

		pmNameFrame:Close()
	end

	local pmNameClose = vgui.Create("DButton", pmNameFrame)
	pmNameClose:SetText("")
	pmNameClose:SetSize(110, 40)
	pmNameClose:SetPos(10, 148)
	pmNameClose.hovering = false
	pmNameClose.alpha = 0

	function pmNameClose:OnCursorEntered()
		surface.PlaySound("UI/buttonrollover.wav")

		self.hovering = true
	end

	function pmNameClose:OnCursorExited()
		self.hovering = false
	end

	function pmNameClose:Paint(w, h)
		self.alpha = pmAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

		local col = Color(100, 100, 100, 255)

		draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
		draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

		if self.hovering then
			col = PetConfig.accentColor
		end

		draw.SimpleText("Cancel", "pmBody", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	function pmNameClose:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

		if frame then
			frame:SetVisible(true)
		end

		pmNameFrame:Close()
	end
end

local function pmShowShop(data)
	local pmShopFrame = vgui.Create("DFrame")
	pmShopFrame:SetSize(550, 450)
	pmShopFrame:SetPos(ScrW() / 2 - 275, ScrH() / 2 - 225)
	pmShopFrame:SetTitle("")
	pmShopFrame:ShowCloseButton(false)
	pmShopFrame:SetVisible(true)
	pmShopFrame:MakePopup()

	function pmShopFrame:Paint(w, h)
		draw.RoundedBox(6, 0, 0, w, h, Color(44, 47, 52, 255))
		draw.RoundedBox(6, 0, 0, w, h - 5, Color(54, 57, 62, 255))
	end

	local pmShopClose = vgui.Create("DButton", pmShopFrame)
	pmShopClose:SetSize(40, 15)
	pmShopClose:SetPos(500, 5)
	pmShopClose:SetText("")
	pmShopClose:SetTooltip("Close")

	function pmShopClose:Paint(w, h)
		draw.RoundedBox(3, 0, 0, w, h, PetConfig.accentColor)
	end

	function pmShopClose:DoClick()
		pmShopFrame:Close()
	end

	pmShopPanel = vgui.Create("DPanel", pmShopFrame)
	pmShopPanel:SetSize(530, 415)
	pmShopPanel:SetPos(10, 25)

	function pmShopPanel:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(36, 39, 44, 150))
	end

	local pmShopScroll = vgui.Create("DScrollPanel", pmShopPanel)
	pmShopScroll:SetSize(520, 405)
	pmShopScroll:SetPos(5, 5)

	function pmShopScroll:Paint(w, h) end

	local scrollbar = pmShopScroll:GetVBar()

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

	local pmShopScrollTitle = vgui.Create("DPanel", pmShopScroll)
	pmShopScrollTitle:SetSize(0, 30)
	pmShopScrollTitle:DockMargin(0, 0, 0, 5)
	pmShopScrollTitle:Dock(TOP)
	pmShopScrollTitle:SetText("")

	function pmShopScrollTitle:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(36, 39, 44, 150))

		draw.DrawText("Name", "pmBody", (w / 9) * 2 + 40, h / 2 - 12, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		draw.DrawText("Price", "pmBody", 450, h / 2 - 12, Color(255, 255, 255), TEXT_ALIGN_CENTER)
	end

	for k, v in pairs(data) do
		local pmShopPet = vgui.Create("DPanel", pmShopScroll)
		pmShopPet:SetSize(0, 65)
		pmShopPet:DockMargin(0, 0, 0, 5)
		pmShopPet:Dock(TOP)
		pmShopPet:SetText("")
		pmShopPet.hovering = false
		pmShopPet.alpha = 0
		pmShopPet.space  = 0

		local pmShopPetModel = vgui.Create("SpawnIcon", pmShopPet)
		pmShopPetModel:SetPos(20, 5)
		pmShopPetModel:SetSize(55, 55)
		pmShopPetModel:SetModel(v["model"])

		local pmShopPetBuy = vgui.Create("DButton", pmShopPet)
		pmShopPetBuy:SetSize(90, 45)
		pmShopPetBuy:SetPos(410, 10)
		pmShopPetBuy:SetText("")
		pmShopPetBuy.hovering = false
		pmShopPetBuy.alpha = 0
		pmShopPetBuy.space  = 0

		function pmShopPetBuy:OnCursorEntered()
			surface.PlaySound("UI/buttonrollover.wav")

			self.hovering = true
			pmShopPet.hovering = true
		end

		function pmShopPetBuy:OnCursorExited()
			self.hovering = false
			pmShopPet.hovering = false
		end

		function pmShopPet:Paint(w, h)
			self.alpha = pmAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)
			self.space = pmAnimateHover(self.space, 0, 5, 1, 1, self.hovering, false)

	    local col = Color(100, 100, 100, 255)

	    draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
	    draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

	    if self.hovering then
	      col = PetConfig.accentColor
	    end

			draw.DrawText(v["name"], "Trebuchet24", (w / 9) * 2 + self.space, h / 2 - 14, col, TEXT_ALIGN_LEFT)
		end

		function pmShopPetBuy:Paint(w, h)
			self.alpha = pmAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)
			self.space = pmAnimateHover(self.space, 0, 5, 1, 1, self.hovering, false)

	    local col = Color(100, 100, 100, 255)

	    draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, 255))
	    draw.RoundedBox(6, 0, 0, w, h, Color(26, 29, 34, self.alpha))

	    if self.hovering then
	      col = PetConfig.accentColor
	    end

			draw.DrawText("$"..v["price"], "pmBody", w / 2 + self.space, h / 2 - 13, col, TEXT_ALIGN_CENTER)
		end

		function pmShopPetBuy:DoClick()
			surface.PlaySound("UI/buttonclickrelease.wav")

			if pmCanBuy(LocalPlayer(), v) then
				pmNameMenu(v, pmShopFrame)

				pmShopFrame:SetVisible(false)
			end
		end
	end
end

//Networking

net.Receive("SNPC_PETBASE_SHOP",function()
  local data = net.ReadTable()

  pmShowShop(data)
end)
