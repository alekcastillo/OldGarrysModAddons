ENT.Type = "ai"
ENT.Base = "base_ai"

ENT.PrintName = "Pets Shop NPC"
ENT.Category = "Pets Mod"
ENT.Author = "Nautical & Alek"
ENT.Purpose = "Press E on me to open the Pet Shop!"

ENT.Spawnable = true
ENT.AdminSpawnable = true

// Shared globals

function pmCanBuy(ply, pet, drp)
	if !ply:canAfford(pet["price"]) then
    if !drp then
		  ply:ChatPrint("[Pet Mod] You can't afford this pet!")
    end

		return false
	end

	local petCount = 0

	for k,v in next, ents.FindByClass("snpc_petbase") do
		if (v.owner != nil) then
			if (v.owner == ply) then
				petCount = petCount + 1
			end
		end
	end

	if (petCount >= PetConfig.maxPets) then
    if !drp then
		  ply:ChatPrint("[Pet Mod] You already reached the max pets limit!")
    end

		return false
	end

	return true
end

function pmCheckName(ply, name)
	if string.len(name) < 3 then
		ply:ChatPrint("[Pet Mod] The pet's name has to be longer than 2 characters!")

		return false
	end

	if string.len(name) > 12 then
		ply:ChatPrint("[Pet Mod] The pet's name has to be shorter than 13 characters!")

		return false
	end

	for k,v in next, ents.FindByClass("snpc_petbase") do
		if v.name == name then
			ply:ChatPrint("[Pet Mod] This name is already taken!")

			return false
		end
	end

	return true
end
