//
/*

  Pet script
  by Josh D.
*/

local config = {

	name = "Pet Dog",
	price = 9000,
	maxHp = 1000,
	maxSize = 0.7,

	customCheck = function(ply) // A custom check for whatever u want
		// Example, if (ply:GetUserGroup() == "vip") then return true else return false end
		return true
	end,

	model = "models/dog.mdl",
	owner = nil,

	idleAnimation = "D_p_sitloop",
	walkAnimation = "walk_all",
	runAnimation = "run_all",
	attackAnimation = "throw",

	walkSpeed = 210,
	runSpeed = 350,

	walkAnimRate = 1.6,
	runAnimRate = 1.5,
  attackAnimRate = 2.5,

	idleSounds = {

		volume = 0.3,
		delay = 4,
		last = 0,

		src = {

      "npc/dog/dog_idle1.wav",
      "npc/dog/dog_idle2.wav",
      "npc/dog/dog_idle3.wav",
      "npc/dog/dog_idle4.wav",
      "npc/dog/dog_idle5.wav",
      "npc/dog/dog_playfull1.wav",
      "npc/dog/dog_playfull3.wav",
      "npc/dog/dog_playfull4.wav",
      "npc/dog/dog_playfull5.wav",
		},
	},

	walkSounds = {

		volume = 0.05,
		delay = 0.15,
		last = 0,

		src = {
      "npc/dog/dog_footstep1.wav",
      "npc/dog/dog_footstep2.wav",
      "npc/dog/dog_footstep3.wav",
      "npc/dog/dog_footstep4.wav"},
	},

	attackSounds = {

		volume = 0.5,
		delay = 1,
		last = 0,

		src = {

      "npc/dog/dog_angry1.wav",
      "npc/dog/dog_angry2.wav",
      "npc/dog/dog_angry3.wav",
		},
	},
}

RegisterPet(config)
