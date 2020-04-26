//
/*

  Pet script
  by Josh D.
*/

local config = {

	name = "Pet Headcrab",
	price = 7000,
	maxHp = 200,
	maxSize = 1.5,

	customCheck = function(ply) // A custom check for whatever u want
		// Example, if (ply:GetUserGroup() == "vip") then return true else return false end
		return true
	end,

	model = "models/headcrabclassic.mdl",
	owner = nil,

	idleAnimation = "Idle01",
	walkAnimation = "Run1",
	runAnimation = "Run1",
	attackAnimation = "jumpattack_broadcast",

	onAttack = function(self)

		self.loco:Jump()
	end,

	walkSpeed = 200,
	runSpeed = 250,

	idleSounds = {

		volume = 0.6,
		delay = 4,
		last = 0,

		src = {

			"npc/headcrab/idle1.wav",
			"npc/headcrab/idle2.wav",
			"npc/headcrab/idle3.wav",
		},
	},

	walkSounds = {

		volume = 0.2,
		delay = 2,
		last = 0,

		src = {"npc/headcrab/alert1.wav"},
	},

	attackSounds = {

		volume = 1,
		delay = 1,
		last = 0,

		src = {

			"npc/headcrab/attack1.wav",
			"npc/headcrab/attack2.wav",
			"npc/headcrab/attack3.wav",
		},
	},
}

RegisterPet(config)
