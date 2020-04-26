//
/*

  Pet script
  by Josh D.
*/

local config = {

	name = "Pet Vortiguant",
	price = 10000,
	maxHp = 400, // How much health will the pet have when fully grown?
	maxSize = 0.6, // How large should the pet become when fully grown? (0.5 = half size, 1 = normal size)

	customCheck = function(ply) // A custom check for whatever u want
		// Example, if (ply:GetUserGroup() == "vip") then return true else return false end
		return true
	end,

	model = "models/vortigaunt_slave.mdl", // What should the model be?
	owner = nil, // DONT TOUCH

	idleAnimation = "Idle01", // What animation do we use for idling?
	walkAnimation = "Walk_all", // What animation do we use for walking?
	runAnimation = "Run_all", // What animation do we use for running?
	attackAnimation = "MeleeHigh1", // What animation do we use for attacking?

	walkSpeed = 85, // How fast does the pet walk?
	runSpeed = 190, // How fast does the pet run?

	walkAnimRate = 2.5, // How fast to cycle through walk animation
	runAnimRate = 2.5, // How fast to cycle through run animation

	idleSounds = { // Idle sounds

		volume = 0.6,
		delay = 4,
		last = 0,

		src = {
			"npc/antlion/idle1.wav",
			"vo/canals/vort_reckoning.wav",
			"vo/npc/vortigaunt/beofservice.wav",
			"vo/npc/vortigaunt/asyouwish.wav",
		},
	},

	walkSounds = { // Walking sounds

		volume = 0.1,
		delay = 0.6,
		last = 0,

		src = {
			"npc/vort/vort_foot1.wav",
			"npc/vort/vort_foot2.wav",
			"npc/vort/vort_foot3.wav",
			"npc/vort/vort_foot4.wav",},
	},

	attackSounds = { // Attacking sounds

		volume = 1,
		delay = 1,
		last = 0,

		src = {

			"npc/vort/claw_swing1.wav",
			"npc/vort/claw_swing2.wav",
		},
	},
}

RegisterPet(config) // Register the pet through PetManager
