//Network Strings
util.AddNetworkString("EZAD_Thanks")
util.AddNetworkString("EZAD_ReloadTable")
util.AddNetworkString("EZAD_OpenMenu")
util.AddNetworkString("EZAD_BuyAmmo")
util.AddNetworkString("EZAD_Notify")
util.AddNetworkString("EZAD_Thanks")
util.AddNetworkString("EZAD_ThanksReceived")

//Functions
function EZAD_AddAmmoType(name, class, model, bullets, price_type, price)
	local newAmmo = {name, class, model, bullets, price_type, price}

	table.insert(EZAD_AmmoTypes, newAmmo)

	EZAD_ReloadAmmoTable(_)
end

function EZAD_Notify(msg, ply)
	net.Start("EZAD_Notify")
	net.WriteString(msg)

	if ply == nil then
		net.Broadcast()
	elseif ply:IsPlayer() then
		net.Send(ply)
	end
end

function EZAD_ReloadAmmoTable(ply)
	net.Start("EZAD_ReloadTable")
	net.WriteTable(EZAD_AmmoTypes)

	if ply != nil then
		net.Send(ply)
	else
		net.Broadcast()
	end
end

function EZAD_DeleteSpawnPositions()
	if file.Exists( "ez_a_d/positions/"..string.lower(game.GetMap())..".txt", "DATA" ) then
		file.Delete( "ez_a_d/positions/"..string.lower(game.GetMap())..".txt" )
	end
end

//Console Commands
concommand.Add("save_ezad", function(ply)
	if !ply:IsPlayer() or !ply:IsSuperAdmin() then return end

	EZAD_DeleteSpawnPositions()

	timer.Simple(1, function()
		local ezad_positions = {}

		for _, ent in pairs( ents.FindByClass( "ez_ammo_dispenser" ) ) do
			table.insert(ezad_positions, {position = ent:GetPos(), angle = ent:GetAngles()})
		end

		file.Write("ez_a_d/positions/"..string.lower(game.GetMap())..".txt", util.TableToJSON(ezad_positions))

		EZAD_Notify(EZAD_Lang.PosSaved, ply)
	end)
end)

concommand.Add("reset_ezad", function(ply)
	if !ply:IsPlayer() or !ply:IsSuperAdmin() then return end

	EZAD_DeleteSpawnPositions()

	EZAD_Notify(EZAD_Lang.PosDeleted, ply)
end)

concommand.Add("reload_ezad", function(ply)
	if !ply:IsPlayer() or !ply:IsSuperAdmin() then return end

	EZAD_ReloadAmmoTable()
end)

concommand.Add("version_ezad", function(ply)
	if !ply:IsPlayer() or !ply:IsSuperAdmin() then return end

	EZAD_Notify("EZ Ammo Dispensers version "..EZAD_Version, ply)
end)
