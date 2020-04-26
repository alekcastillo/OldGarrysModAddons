// Pet Config by Nautical & Alek
PetConfig = {}

-- BASIC PET CONFIGURATION

PetConfig.shouldAge = true
--[[ Should pets age? (If set to false, pets will
spawn as adults and never age)]]

PetConfig.ageRate = 75
--[[ How many seconds for a pet to age
1 year? DO NOT SET THIS TO 0 ]]

PetConfig.maxPets = 1
--[[ How many pets can a player own at
the same time? Set it to 0 to disable
the limit (not recommended) ]]

PetConfig.canDefend = true
--[[ Should pets defend their owners?
(not recommended if petGodMode is set
to true) ]]

PetConfig.petGodMode = false
--[[ Should pets have god mode?
(not recommended if canDefend is
set to true) ]]

PetConfig.showPetNames = true
--[[ Should pets show their names
above their heads? ]]

PetConfig.maxDamage = 50
--[[ Max damage a pet can do per attack ]]

PetConfig.permaPets = true
--[[ Should pets be permanent? (Should pets persist in between player leave and reconnect and server restart?)]]

PetConfig.birthdayEffects = true
--[[ Should pets have birthday effects? ]]

-- PET SOUNDS
PetConfig.soundEffects = true
--[[ Should pets have sound effects? ]]

PetConfig.idleSounds = true
--[[ Should pets make idle sounds? ]]

PetConfig.soundLevel = 75
--[[ How far away should pet sounds be heard? (100 = normal, 60 = quiet, 180 = loud)]]

-- DARKRP INTEGRATION
PetConfig.useF4Menu = false
--[[ Should pets be purchaseable from
the DarkRP's F4 menu? ]]

-- PET SHOP
PetConfig.accentColor = Color(125, 250, 140)
--[[ Gui accent color, default is light green ]]

PetConfig.shopNPCModel = "models/mossman.mdl"
--[[ NPC Model for the Pet Shop ]]


-- VERSION
PetConfig.version = "1.0.5"
