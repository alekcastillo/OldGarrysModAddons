// Clientside by Alek

if SERVER then
	AddCSLuaFile()

	return
end

// Fonts
surface.CreateFont("pmBody", {
  font = "Roboto",
  size = 25,
  weight = 1000,
  antialias = true
})

surface.CreateFont("pmTitle",{
	font = "ONE DAY",
	size = 30,
	weight = 1000,
	antialias = true
})

surface.CreateFont("pmTitle2",{
	font = "Roboto",
	size = 80,
	weight = 1000,
	antialias = true
})

// Methods
function pmDrawTitle(title, font, color, x, y, alignx, aligny, ly)
	draw.SimpleText(title, font, x, y, color, alignx, aligny)

	surface.SetFont(font)

	local tw, th = surface.GetTextSize(title)
	local linex = 0
	local liney = 0

	surface.SetDrawColor(color.r, color.g, color.b)

	if alignx == TEXT_ALIGN_CENTER then
		linex = x - tw / 2
	elseif alignx == TEXT_ALIGN_RIGHT then
		linex = x - tw
	elseif alignx == TEXT_ALIGN_LEFT then
		linex = x
	end

	if aligny == TEXT_ALIGN_CENTER then
		liney = y + th / 2 + 2
	elseif aligny == TEXT_ALIGN_TOP then
		liney = y + th + 2
	elseif aligny == TEXT_ALIGN_BOTTOM then
		liney = y + 2
	end

	surface.DrawRect(linex, liney, tw, ly)
end

function pmAnimateHover(num, startn, endn, byntoend, bytostart, var, inv)
	if var and num < endn and !inv then
		return math.Approach(num, endn, byntoend)
	elseif !var and num > startn and !inv then
		return math.Approach(num, startn, bytostart)
	elseif var and num > startn and inv then
		return math.Approach(num, startn, bytostart)
	elseif !var and num < endn and inv then
		return math.Approach(num, endn, byntoend)
	end

	return num
end

function pmDrawRhombus(px, py, w, h, color)
	local rhombus = {
		{x = px + w / 2, y = py + h},
		{x = px, y = py + h / 2},
		{x = px + w / 2, y = py},
		{x = px + w, y = py + h / 2},
	}

	surface.SetDrawColor(color.r, color.g, color.b, color.alpha)

	draw.NoTexture()

	surface.DrawPoly(rhombus)
end
