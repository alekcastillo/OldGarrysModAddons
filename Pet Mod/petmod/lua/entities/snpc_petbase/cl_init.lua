//
/*
  Pet base AI
  by Nautical
*/

include("shared.lua")

// Cache an emitter
local theEmitter = ParticleEmitter(Vector(0,0,0));

language.Add("snpc_petbase","Pet")

function ENT:Initialize()
end

function ENT:Birthday()

  if (PetConfig == nil) then
    return
  end

  if (PetConfig.soundEffects && PetConfig.birthdayEffects) then
    sound.Play("petmod/noisemaker.wav", self:GetPos(), PetConfig.soundLevel, 100, 0.4);

    for i = 0, 75, 1 do
         local particle = theEmitter:Add("effects/spark", self:GetPos() + Vector(0, 0, self:OBBMaxs().z/2))
         particle:SetStartSize(math.random(2, 6))
         particle:SetEndSize(0)
         particle:SetStartAlpha(math.random(80, 250))
         particle:SetEndAlpha(0)
         particle:SetDieTime(3)

         particle:SetCollide(true)
         particle:SetVelocity(Vector(math.random(-15,15),math.random(-15,15),math.random(100,200)))
         particle:SetRollDelta(math.Rand(-8, 8))
         particle:SetGravity(Vector(0, 0, -200))
         particle:SetRoll(math.Rand(0, 180))


         particle:SetColor(math.random(1, 255), math.random(1, 255), math.random(1, 255), 255)
     end
   end
end

function ENT:Draw()
  self:DrawModel()
  if (PetConfig == nil) then
    return
  end
  if (PetConfig.showPetNames && LocalPlayer():GetPos():Distance(self:GetPos()) < 800) then
    local ang = self:GetAngles();
    ang:RotateAroundAxis(ang:Up(), 90);
    ang:RotateAroundAxis(ang:Forward(), 90);
    ang.y = EyeAngles().y - 90;

    local pos = self:GetPos() + Vector(0,0,self:OBBMaxs().z + 10);

    cam.Start3D2D(pos, ang, 0.25)
      draw.SimpleTextOutlined(self:GetDisplayName(),"Trebuchet24", 0, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,
      1, Color(0,0,0,255));
    cam.End3D2D();
  end
end

function ENT:ShowInfo(data)
  local infoFrame = vgui.Create("DFrame")
  infoFrame:SetSize(300, 270)
  infoFrame:Center()
  infoFrame:ShowCloseButton(false)
  infoFrame:SetTitle("")
  infoFrame:MakePopup()

  function infoFrame:Paint(w, h)
    draw.RoundedBox(6, 0, 0, w, h, Color(44, 47, 53))
    draw.RoundedBox(6, 0, 0, w, h - 5, Color(54, 57, 63))

    pmDrawTitle("Pet Information", "pmTitle", Color(255, 255, 255), w / 2, 35, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1)

    surface.SetFont("pmBody")
    tw, th = surface.GetTextSize(data["name"])

    draw.SimpleText(data["name"], "pmBody", w / 2 - tw / 2 + 12, 78, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    draw.SimpleText("Age: "..data["age"], "pmBody", w / 2 - tw / 2 + 12, 113, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    draw.SimpleText("HP: "..data["health"], "pmBody", w / 2 - tw / 2 + 12, 148, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    pmDrawRhombus(w / 2 - tw / 2 - 12, 70, 20, 20, Color(255, 255, 255))
    pmDrawRhombus(w / 2 - tw / 2 - 12, 105, 20, 20, Color(255, 255, 255))
    pmDrawRhombus(w / 2 - tw / 2 - 12, 140, 20, 20, Color(255, 255, 255))
  end

  local infoOrder = vgui.Create("DButton", infoFrame)
  infoOrder:SetSize(130, 40)
  infoOrder:SetPos(15, 175)
  infoOrder:SetText("")
  infoOrder.ctime = 0
  infoOrder.hovering = false
  infoOrder.alpha = 0
  infoOrder.stayAlpha = 0

  function infoOrder:OnCursorEntered()
    surface.PlaySound("UI/buttonrollover.wav")

    self.hovering = true
  end

  function infoOrder:OnCursorExited()
    self.hovering = false
  end

  function infoOrder:Paint(w, h)
    self.alpha = pmAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)
    self.stayAlpha = pmAnimateHover(self.stayAlpha, 0, 255, 10, 10, data.stay, false)

    local col = Color(100, 100, 100)

    draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
    draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))
    draw.RoundedBox(6, 0, 0, w, h, Color(30, 33, 38, self.stayAlpha))

    if self.hovering then
      col = PetConfig.accentColor
    end

    draw.SimpleText("Stay", "pmBody", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  end

  function infoOrder:DoClick()
    if (CurTime() - self.ctime < 0.5) then return end

  	surface.PlaySound("UI/buttonclickrelease.wav")

    self.ctime = CurTime()

    data.stay = !data.stay

    net.Start("SNPC_PETBASE_UPDATE_STATE")
      net.WriteTable(data)
    net.SendToServer()
  end

  local infoClose = vgui.Create("DButton", infoFrame)
  infoClose:SetSize(130, 40)
  infoClose:SetPos(155, 175)
  infoClose:SetText("")
  infoClose.hovering = false
  infoClose.alpha = 0

  function infoClose:OnCursorEntered()
    surface.PlaySound("UI/buttonrollover.wav")

    self.hovering = true
  end

  function infoClose:OnCursorExited()
    self.hovering = false
  end

  function infoClose:Paint(w, h)
    self.alpha = pmAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

    local col = Color(100, 100, 100, 255)

    draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
    draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

    if self.hovering then
      col = PetConfig.accentColor
    end

    draw.SimpleText("Close", "pmBody", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  end

  function infoClose:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")

    infoFrame:Close()
  end

  -- Disown
  local infoDisown = vgui.Create("DButton", infoFrame)
  infoDisown:SetSize(270, 40)
  infoDisown:SetPos(15, 220)
  infoDisown:SetText("")
  infoDisown.hovering = false
  infoDisown.alpha = 0

  function infoDisown:OnCursorEntered()
    surface.PlaySound("UI/buttonrollover.wav")

    self.hovering = true
  end

  function infoDisown:OnCursorExited()
    self.hovering = false
  end

  function infoDisown:Paint(w, h)
    self.alpha = pmAnimateHover(self.alpha, 0, 255, 10, 10, self.hovering, false)

    local col = Color(100, 100, 100, 255)

    draw.RoundedBox(6, 0, 0, w, h, Color(46, 49, 54, 255))
    draw.RoundedBox(6, 0, 0, w, h, Color(36, 39, 44, self.alpha))

    if self.hovering then
      col = PetConfig.accentColor
    end

    draw.SimpleText("Disown Pet", "pmBody", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  end

  function infoDisown:DoClick()
		surface.PlaySound("UI/buttonclickrelease.wav")
    net.Start("SNPC_PETBASE_DISOWN")
      net.WriteTable(data)
    net.SendToServer()
    infoFrame:Close()
  end
end

// Networking

net.Receive("SNPC_PETBASE_INFO",function()

  local data = net.ReadTable()

  if (data.ent == nil || !data.ent:IsValid()) then return end

  data.ent:ShowInfo(data)
end)

net.Receive("SNPC_PETBASE_BIRTHDAY",function()

  local ent = net.ReadEntity()

  if (ent) then
    if (ent:IsValid()) then
      ent:Birthday()
    end
  end
end)
