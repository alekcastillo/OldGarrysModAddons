//
/*

  Pet script
  by Josh D.
*/

local config = {

	name = "Pet Zombie Torso",
	price = 10000,
	maxHp = 300,
	maxSize = 1,

	customCheck = function(ply) // A custom check for whatever u want
		// Example, if (ply:GetUserGroup() == "vip") then return true else return false end
		return true
	end,

	model = "models/zombie/classic_torso.mdl",
	owner = nil,

	idleAnimation = "Idle01",
	walkAnimation = "crawl",
	runAnimation = "crawl",
	attackAnimation = "attack",

	walkSpeed = 210,
	runSpeed = 300,

	walkAnimRate = 1.25,
	runAnimRate = 2.2,

	idleSounds = {

		volume = 0.6,
		delay = 4,
		last = 0,

		src = {

      "npc/zombie/zombie_voice_idle1.wav",
      "npc/zombie/zombie_voice_idle10.wav",
      "npc/zombie/zombie_voice_idle11.wav",
      "npc/zombie/zombie_voice_idle12.wav",
      "npc/zombie/zombie_voice_idle13.wav",
      "npc/zombie/zombie_voice_idle14.wav",
      "npc/zombie/zombie_voice_idle2.wav",
      "npc/zombie/zombie_voice_idle3.wav",
      "npc/zombie/zombie_voice_idle4.wav",
      "npc/zombie/zombie_voice_idle5.wav",
      "npc/zombie/zombie_voice_idle6.wav",
      "npc/zombie/zombie_voice_idle7.wav",
      "npc/zombie/zombie_voice_idle8.wav",
      "npc/zombie/zombie_voice_idle9.wav",
		},
	},

	walkSounds = {

		volume = 0.25,
		delay = 0.15,
		last = 0,

		src = {
      "npc/zombie/foot_slide1.wav",
      "npc/zombie/foot_slide2.wav",
      "npc/zombie/foot_slide3.wav"},
	},

	attackSounds = {

		volume = 1,
		delay = 1,
		last = 0,

		src = {

      "npc/zombie/claw_strike1.wav",
      "npc/zombie/claw_strike2.wav",
      "npc/zombie/claw_strike3.wav",
		},
	},
}

RegisterPet(config)
