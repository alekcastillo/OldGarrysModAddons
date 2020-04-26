// NPC data by Alek
if (CLIENT) then
	return;
end

local function pmDeleteSpawnPositions()
	if file.Exists("pet_mod/positions/"..string.lower(game.GetMap())..".txt", "DATA") then
		file.Delete("pet_mod/positions/"..string.lower(game.GetMap())..".txt")
	end
end

concommand.Add("pm_npcsave", function(ply)
	if !ply:IsSuperAdmin() then return end

	pmDeleteSpawnPositions()

	timer.Simple(1, function()
		local positions = {}

		for _, ent in pairs(ents.FindByClass("snpc_petshop")) do
			table.insert(positions, {position = ent:GetPos(), angle = ent:GetAngles()})
		end

		file.Write("pet_mod/positions/"..string.lower(game.GetMap())..".txt", util.TableToJSON(positions))

		ply:ChatPrint("[Pet Mod] The pet shop npc's spawn position has been saved succesfully.")
	end)
end)

concommand.Add("pm_npcreset", function(ply)
	if !ply:IsSuperAdmin() then return end

	pmDeleteSpawnPositions()

	ply:ChatPrint("[Pet Mod] The pet shop npc's spawn position has been reseted succesfully.")
end)

concommand.Add("pm_version", function(ply)
	if !ply:IsSuperAdmin() then return end

	ply:ChatPrint("Running Pet Mod version ".. PetConfig.version)
end)

concommand.Add("pm_spawnshop", function(ply)
	if !ply:IsSuperAdmin() then return end

	local pos = ply:GetEyeTrace().HitPos
	local shop = ents.Create("snpc_petshop")
	shop:SetPos(pos)
	shop:Spawn()

	ply:ChatPrint("[Pet Mod] Spawned Pet Shop successfully.")
end)


// Pet persistence by Nautical

pmPermaPets = {}

function pmAddPermaPet(ply, petClass, petName, petAge)

	if (!PetConfig.permaPets) then
		return
	end
	pmPermaPets[ply:SteamID()] = {class = petClass, name = petName, age = petAge};
	file.Write("pet_mod/permapets.txt", util.TableToJSON(pmPermaPets));
end

function pmUpdatePermaPet(ply, age)

	if (!PetConfig.permaPets) then
		return
	end

	if (pmPermaPets[ply:SteamID()] != nil) then

		pmPermaPets[ply:SteamID()].age = age
		file.Write("pet_mod/permapets.txt", util.TableToJSON(pmPermaPets));
	end
end

function pmRemovePermaPet(ply)

	if (pmPermaPets[ply:SteamID()] != nil) then
		pmPermaPets[ply:SteamID()] = nil;
		file.Write("pet_mod/permapets.txt", util.TableToJSON(pmPermaPets));
	end
end

local function LoadPermaPets()

	if (file.Exists("pet_mod/permapets.txt", "DATA")) then
		pmPermaPets = util.JSONToTable(file.Read("pet_mod/permapets.txt", "DATA"));
	end
end
LoadPermaPets()

local function OnInitialSpawn(ply)

	if (!PetConfig.permaPets) then
		return
	end

	timer.Simple(5,function()

		if (!IsValid(ply)) then
			return
		end

		local permaPet = pmPermaPets[ply:SteamID()]
		if (permaPet != nil) then
			local petConfig = nil
			for k,v in next, pmPetsData do
				if (permaPet.class == v.name) then
					petConfig = v.config
					break
				end
			end
			if (petConfig == nil) then
				return
			end

			pmSpawnPet(ply, ply:GetPos(), petConfig, permaPet.name, permaPet.age)
		end
	end)
end
hook.Add("PlayerInitialSpawn", "PETMOD.PlyInitialSpawn", OnInitialSpawn);


// Pet cleanup

local function OnDisconnect(ply)
	for k,v in next, ents.FindByClass("snpc_petbase") do
		if (!IsValid(v)) then
			continue
		end
		if (v.owner == ply) then
			v:Remove()
		end
	end
end
hook.Add("PlayerDisconnected", "PETMOD.PlyDisconnected", OnDisconnect)
