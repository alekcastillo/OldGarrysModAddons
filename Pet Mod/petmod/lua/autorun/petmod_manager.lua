//
/*
	Pet manager
	by Nautical
*/

if (SERVER) then
	AddCSLuaFile("autorun/petmod_config.lua")
	pmPetsTbl = {}
	pmPetsData = {}
else
	include("autorun/petmod_config.lua")
end

// Helper methods
local function CanSpawnPet(ply)

	local petCount = 0
	for k,v in next, ents.FindByClass("snpc_petbase") do

		if (v.owner != nil) then

			if (v.owner == ply) then
				petCount = petCount + 1
			end
		end
	end

	if (petCount >= PetConfig.maxPets) then // our pet limit is 1
		return false
	else
		return true
	end
end

function pmSpawnPet(ply, pos, config, name, age)

	if (CLIENT) then
		return
	end

	age = age || 0

	local info = table.Copy(config)
	info.owner = ply
	info.age = age

	local ent = ents.Create("snpc_petbase")
	ent:SetPos(pos)
	ent:Spawn()
	ent:Prep(info)
	ent:SetPetName(name)

	timer.Simple(2,function() // wait for a little bit incase we have to get a name from the api
		if (!IsValid(ply)) then
			return
		end
		pmAddPermaPet(ply, info.name, ent:GetDisplayName(), age)
	end)
	return ent
end

local function PrepScript(script) // prepares a script to be downloaded, and executes on a delay

	local relPath = string.gsub(script, "autorun/", "")

	AddCSLuaFile(relPath)
	timer.Simple(5,function()

		print("Running pet script: " .. relPath)
		include(script)
	end)
end

petManager_petCmd = petManager_petCmd || 420 // little hack to avoid dumbass darkrp cmd errors...

function RegisterPet(config) // Registers a pet with dark rp
	if (SERVER) then
		table.insert(pmPetsTbl, {name = config.name, price = config.price, model = config.model})
		table.insert(pmPetsData, {name = config.name, price = config.price, model = config.model, config = config})
	end

	if (!PetConfig.useF4Menu) then
		return;
	end

	DarkRP.createEntity(config.name, {
		ent = "snpc_petbase",
		model = config.model,
		price = config.price,
		max = 1,
		cmd = tostring(petManager_petCmd),
	  category = "Other",

		customCheck = function(ply)
			if (!CanSpawnPet(ply)) then return false end // Leave this here
			if (!config.customCheck(ply)) then return false end
			return true;
		end,

	  spawn = function(ply,tr,tbleEnt)
	    return pmSpawnPet(ply, tr.HitPos, config, nil)
	  end,
	})

	petManager_petCmd = petManager_petCmd + 1
end

// ADD TO F4 MENU
PrepScript("autorun/petscripts/antlion.lua")
PrepScript("autorun/petscripts/headcrab.lua")
PrepScript("autorun/petscripts/antlionguard.lua")
PrepScript("autorun/petscripts/fastzombie.lua")
PrepScript("autorun/petscripts/zombietorso.lua")
PrepScript("autorun/petscripts/dog.lua")
PrepScript("autorun/petscripts/vortiguant.lua")
//PrepScript("autorun/petscripts/test.lua")
