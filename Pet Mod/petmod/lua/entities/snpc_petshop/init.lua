//Files
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

// Pooled strings
util.AddNetworkString("SNPC_PETBASE_SHOP")
util.AddNetworkString("SNPC_PETBASE_BUY")

// Entity Functions
function ENT:Initialize()
	self:SetModel(PetConfig.shopNPCModel)
	self:SetSolid(SOLID_BBOX);
	self:PhysicsInit(SOLID_BBOX);
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:CapabilitiesAdd(CAP_TURN_HEAD)
	self:SetUseType(SIMPLE_USE)
	self:SetMaxYawSpeed(90)
	self:DropToFloor()
end

function ENT:AcceptInput(input, activator, caller)

	if input == "Use" and activator:IsPlayer() then
		net.Start("SNPC_PETBASE_SHOP")
			net.WriteTable(pmPetsTbl)
		net.Send(activator)
	end
end

function ENT:Think()
	self:DropToFloor()
end

//Spawn Hooks

hook.Add("PostGamemodeLoaded", "pmFiles", function()
	if not file.IsDir("pet_mod", "DATA") then
		file.CreateDir("pet_mod", "DATA")
	end

	if not file.IsDir("pet_mod/positions", "DATA") then
		file.CreateDir("pet_mod/positions", "DATA")

		print("[Pet Mod] The pet mod data directory has been created succesfully.")
	end
end)

hook.Add("InitPostEntity", "pmSpawn", function()
	local spawnTable = {}
	local spawnFile = file.Read("pet_mod/positions/"..string.lower(game.GetMap())..".txt", "DATA")

	if spawnFile != nil then
		spawnTable = util.JSONToTable(spawnFile)
	end

	for _, spawn in pairs(spawnTable) do
		local position = spawn.position
		local angle = spawn.angle
		local shop_ent = ents.Create("snpc_petshop")

		shop_ent:SetPos(position)
		shop_ent:SetAngles(angle)
		shop_ent:SetMoveType(0)
		shop_ent:Spawn()

		local phys = shop_ent:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:EnableMotion(false)
		end
	end

	print("[Pet Mod] Succesfully spawned the pet shop npc!")
end)

//Networking

net.Receive("SNPC_PETBASE_BUY", function(_, ply)
	local info = net.ReadTable()

	local pet = info["pet"]
	local name = info["name"]

	local isAPet = false
	local petRef = nil;

	for k, v in next, pmPetsData do
		if (v.name == pet) then
			isAPet = true
			petRef = v
		end
	end

	if !isAPet then return end
	if !pmCheckName(ply, name) then return end
	if !pmCanBuy(ply, petRef) then return end

	if (!petRef.config.customCheck(ply)) then

		ply:ChatPrint("[Pet Mod] You cannot buy this pet! (Custom Check)")
		return
	end


	ply:addMoney(-petRef.price)

	pmSpawnPet(ply, ply:GetPos(), petRef.config, name)
	ply:ChatPrint("[Pet Mod] Successfully purchased pet!")
end)
