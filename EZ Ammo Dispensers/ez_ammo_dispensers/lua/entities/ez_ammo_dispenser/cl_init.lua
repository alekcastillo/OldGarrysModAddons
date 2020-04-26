include("shared.lua")

hook.Add("PostDrawOpaqueRenderables", "EZAD_Title", function()
	for _, ent in pairs (ents.FindByClass("ez_ammo_dispenser")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 800 then
			local ang = ent:GetAngles()

			ang:RotateAroundAxis( ang:Forward(), 90)
			ang:RotateAroundAxis( ang:Right(), -90)

			cam.Start3D2D(ent:GetPos() + ent:GetForward() * 21 + ent:GetUp() * 28, ang, 0.1)
				draw.RoundedBox(7, -215, -100, 350, 200, Color(32, 36, 38, 255))
				draw.RoundedBox(7, -215, -100, 350, 195, Color(42, 46, 48, 255))

				draw.SimpleText( "Ammo", "EZAD_Font3", -40, -90, ezad_accentColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				draw.SimpleText( "Dispenser", "EZAD_Font4", -40, -10, ezad_accentColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			cam.End3D2D()
		end
	end
end)

function ENT:Draw()
	self:DrawModel()
end
