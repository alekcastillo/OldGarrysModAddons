//
/*

  Pet script
  by Josh D.
*/

local config = {

	name = "Pet Fast Zombie",
	price = 8000,
	maxHp = 300,
	maxSize = 0.8,

	customCheck = function(ply) // A custom check for whatever u want
		// Example, if (ply:GetUserGroup() == "vip") then return true else return false end
		return true
	end,

	model = "models/zombie/fast.mdl",
	owner = nil,

	idleAnimation = "idle",
	walkAnimation = "walk_all",
	runAnimation = "Run",
	attackAnimation = "Melee",

	walkSpeed = 250,
	runSpeed = 450,

  walkAnimRate = 2,
  runAnimRate = 3,

	idleSounds = {

		volume = 0.6,
		delay = 2.5,
		last = 0,

		src = {

      "npc/fast_zombie/idle1.wav",
      "npc/fast_zombie/idle2.wav",
      "npc/fast_zombie/idle3.wav",
		}
	},

	walkSounds = {

		volume = 0.4,
		delay = 0.15,
		last = 0,

		src = {
      "npc/fast_zombie/foot1.wav",
      "npc/fast_zombie/foot2.wav",
      "npc/fast_zombie/foot3.wav",
      "npc/fast_zombie/foot4.wav",
    }
	},

	attackSounds = {

		volume = 1,
		delay = 1,
		last = 0,

		src = {

      "npc/fast_zombie/claw_strike1.wav",
      "npc/fast_zombie/claw_strike2.wav",
      "npc/fast_zombie/claw_strike3.wav",
      "npc/fast_zombie/fz_scream1.wav",
		}
	}
}

RegisterPet(config)
