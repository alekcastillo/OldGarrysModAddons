//
/*

  Pet script
  by Josh D.
*/

local config = {

	name = "Pet Antlion Guard",
	price = 12000,
	maxHp = 700,
	maxSize = 0.55,

	customCheck = function(ply) // A custom check for whatever u want
		// Example, if (ply:GetUserGroup() == "vip") then return true else return false end
		return true
	end,

	model = "models/antlion_guard.mdl",
	owner = nil,

	idleAnimation = "idle",
	walkAnimation = "walk1",
	runAnimation = "run1",
	attackAnimation = "physhit_fr",

	walkSpeed = 150,
	runSpeed = 300,

	walkAnimRate = 1.5,
	runAnimRate = 0.9,

	idleSounds = {

		volume = 0.1,
		delay = 4,
		last = 0,

		src = {

			"npc/antlion_guard/angry1.wav",
			"npc/antlion_guard/angry2.wav",
			"npc/antlion_guard/angry3.wav",
		},
	},

	walkSounds = {

		volume = 0.1,
		delay = 0.2,
		last = 0,

		src = {
			"npc/antlion_guard/foot_heavy1.wav",
			"npc/antlion_guard/foot_heavy2.wav",
			"npc/antlion_guard/foot_light1.wav",
			"npc/antlion_guard/foot_light2.wav",},
	},

	attackSounds = {

		volume = 0.15,
		delay = 1,
		last = 0,

		src = {

			"npc/antlion_guard/shove1.wav",
		},
	},
}

RegisterPet(config)
