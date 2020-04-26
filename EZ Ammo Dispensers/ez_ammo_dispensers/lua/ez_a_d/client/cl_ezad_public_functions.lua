//Functions
function EZAD_AddAmmoType(name, class, model, bullets, price_type, price) end --This is shitty, but it does the job :V

function EZAD_CL_Notify(msg)
	surface.PlaySound("buttons/lightswitch2.wav")

	chat.AddText(EZAD.ChatTagColor, EZAD.ChatTag.." ", Color(255, 255, 255), msg)
end

function EZAD_DrawBorders(x, y, w, h, up, down, left, right)
	if EZAD.Theme_ColoredBorders then
		surface.SetDrawColor(ezad_accentColor.r, ezad_accentColor.g, ezad_accentColor.b, 255)
	else
		surface.SetDrawColor(25, 25, 25, 255)
	end

	if (up) then surface.DrawRect(x, y, w, 1) end
	if (down) then surface.DrawRect(x, y + h - 1, w, 1) end
	if (left) then surface.DrawRect(x, y, 1, h) end
	if (right) then surface.DrawRect(x + w - 1, y, 1, h) end
end
