//
/*

  Pet script
  by Josh D.
*/

local config = {

	name = "Pet T-Rex",
	price = 10000,
	maxHp = 500, // How much health will the pet have when fully grown?
	maxSize = 0.7, // How large should the pet become when fully grown? (0.5 = half size, 1 = normal size)

	customCheck = function(ply) // A custom check for whatever u want
		// Example, if (ply:GetUserGroup() == "vip") then return true else return false end
		return true
	end,

	model = "models/trex_player/trex_player_gray.mdl", // What should the model be?
	owner = nil, // DONT TOUCH

	idleAnimation = "idle_all_01", // What animation do we use for idling?
	walkAnimation = "walk_all", // What animation do we use for walking?
	runAnimation = "run_all_01", // What animation do we use for running?
	attackAnimation = "seq_meleeattack01", // What animation do we use for attacking?

	walkSpeed = 250, // How fast does the pet walk?
	runSpeed = 350, // How fast does the pet run?

	walkAnimRate = 1.5, // How fast to cycle through walk animation
	runAnimRate = 1.25, // How fast to cycle through run animation

	idleSounds = { // Idle sounds

		volume = 0.6,
		delay = 4,
		last = 0,

		src = {

			"npc/antlion/idle1.wav",
			"npc/antlion/idle2.wav",
			"npc/antlion/idle3.wav",
			"npc/antlion/idle4.wav",
			"npc/antlion/idle5.wav",
		},
	},

	walkSounds = { // Walking sounds

		volume = 0.1,
		delay = 0.15,
		last = 0,

		src = {
			"npc/antlion/foot1.wav",
			"npc/antlion/foot2.wav",
			"npc/antlion/foot3.wav",
			"npc/antlion/foot4.wav",},
	},

	attackSounds = { // Attacking sounds

		volume = 1,
		delay = 1,
		last = 0,

		src = {

			"npc/antlion/attack_single1.wav",
			"npc/antlion/attack_single2.wav",
			"npc/antlion/attack_single3.wav",
		},
	},
}

RegisterPet(config) // Register the pet through PetManager
