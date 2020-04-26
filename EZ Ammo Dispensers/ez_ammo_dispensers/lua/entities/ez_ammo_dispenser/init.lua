//Files
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

//Entity Functions
function ENT:Initialize()
	self:SetModel(EZAD.DispenserModel)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use(activator, caller)
	if caller:IsPlayer() then
		net.Start("EZAD_OpenMenu")
		net.Send(caller)
	end
end

//Spawn Hooks
hook.Add("PostGamemodeLoaded", "EZAD_Files", function()
	if not file.IsDir( "ez_a_d", "DATA" ) then
		file.CreateDir( "ez_a_d", "DATA" )
	end

	if not file.IsDir( "ez_a_d/positions", "DATA" ) then
		file.CreateDir( "ez_a_d/positions", "DATA" )

		print(EZAD_Lang.DirCreated)
	end
end)

hook.Add("InitPostEntity", "EZAD_Spawn", function()
	local spawnTable = {}
	local spawnFile = file.Read("ez_a_d/positions/"..string.lower(game.GetMap())..".txt", "DATA")

	if spawnFile != nil then
		spawnTable = util.JSONToTable(spawnFile)
	end

	for _, spawn in pairs(spawnTable) do
		local position = spawn.position
		local angle = spawn.angle
		local ez_a_d = ents.Create("ez_ammo_dispenser")

		ez_a_d:SetPos(position)
		ez_a_d:SetAngles(angle)
		ez_a_d:SetMoveType(0)
		ez_a_d:Spawn()

		local phys = ez_a_d:GetPhysicsObject()
		if phys and phys:IsValid() then
			phys:EnableMotion(false)
		end
	end

	print(EZAD_Lang.DispensersSpawned)
end)
