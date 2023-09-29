// Author: Gremling
// Refactored from list to datum types instead to allow customisation per sound file.

GLOBAL_LIST_EMPTY(typing_sounds) // Holds all the sound datums

SUBSYSTEM_DEF(typinginit)
	name = "Typing Indicator Init"
	wait = 6000
	runlevels = RUNLEVEL_INIT

/datum/controller/subsystem/typinginit/Initialize()
	var/list/typingPaths = typesof(/datum/typing_sound)
	
	var/datum/typing_sound/currentSound = null
	for(var/path in typingPaths)
		currentSound = new path
		currentSound.AddToList()
		currentSound = null

	. = ..()

// The new sound files!
// name 					The unique key, CASE SENSITIVE, cannot be duplicates.
// soundFile				Path to sound file
// permitAnimalCrossing		By default allows animal crossing speech type

/datum/typing_sound
	var/name = "Default" 	// Referenced Name
	var/soundFile = 'modular_coyote/sound/typing/default.ogg' // File ref
	var/permitAnimalCrossing = TRUE // Allows animal crossing to work with the sound.

/datum/typing_sound/proc/AddToList()
	if(!(src in GLOB.typing_sounds))
		GLOB.typing_sounds[name] = src
		return TRUE
	CRASH("Invalid/duplicate typing_sound format, please double check the name! Source: [name] | SoundFile = [soundFile]")

/datum/typing_sound/fbmessenger
	name = "FB Messenger"
	soundFile = 'modular_coyote/sound/typing/facebookMessenger.ogg'

/datum/typing_sound/deep
	name = "Deep"
	soundFile = 'modular_coyote/sound/typing/deepspeak.ogg'

/datum/typing_sound/soft
	name = "Soft"
	soundFile = 'modular_coyote/sound/typing/softspeak.ogg'

/datum/typing_sound/beep
	name = "beep"
	soundFile = 'sound/machines/beep.ogg'

/datum/typing_sound/win7
	name = "win7 error"
	soundFile = 'sound/effects/beeper7.ogg'

/datum/typing_sound/harddrive
	name = "hard drive"
	soundFile = 'sound/effects/bootup.ogg'

/datum/typing_sound/buzzsigh
	name = "buzz sigh"
	soundFile = 'sound/machines/buzz-sigh.ogg'

/datum/typing_sound/light
	name = "Light"
	soundFile = 'modular_coyote/sound/typing/lightspeak.ogg'

/datum/typing_sound/jackal
	name = "Jackal"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/anubis1.ogg'

/datum/typing_sound/batchitter
	name = "Bat Chitter"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/bat1.ogg'

/datum/typing_sound/bear
	name = "Bear"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/bear1.ogg'


GLOBAL_LIST_INIT(typing_indicator_sounds, list(
		"Beaver" 				= 'modular_coyote/sound/typing/arfs1sounds/beaver1.ogg',
		"Horrible Bird Kyaa" 	= 'modular_coyote/sound/typing/arfs1sounds/bird1.ogg',
		"Horrible Bird Call 2" 	= 'modular_coyote/sound/typing/arfs1sounds/bird2.ogg',
		"Boar" 					= 'modular_coyote/sound/typing/arfs1sounds/boar1.ogg',
		"Goat" 					= 'modular_coyote/sound/typing/arfs1sounds/capra1.ogg',
		"Corgi (Cody)" 			= 'modular_coyote/sound/typing/arfs1sounds/corgi1.ogg',
		"Corgi" 				= 'modular_coyote/sound/typing/arfs1sounds/corgi2.ogg',
		"Cougar" 				= 'modular_coyote/sound/typing/arfs1sounds/cougar1.ogg',
		"Cow" 					= 'modular_coyote/sound/typing/arfs1sounds/cow1.ogg',
		"Coyote Howl" 			= 'modular_coyote/sound/typing/arfs1sounds/coyote1.ogg',
		"Coyote" 				= 'modular_coyote/sound/typing/arfs1sounds/coyote2.ogg',
		"Crocodile" 			= 'modular_coyote/sound/typing/arfs1sounds/croc1.ogg',
		"Deer" 					= 'modular_coyote/sound/typing/arfs1sounds/deer1.ogg',
		"Drider" 				= 'modular_coyote/sound/typing/arfs1sounds/drider1.ogg',
		"Eevee" 				= 'modular_coyote/sound/typing/arfs1sounds/eevee1.ogg',
		"Elephant" 				= 'modular_coyote/sound/typing/arfs1sounds/elephant1.ogg',
		"Fennec Bark" 			= 'modular_coyote/sound/typing/arfs1sounds/fennec1.ogg',
		"Fennec Squeak" 		= 'modular_coyote/sound/typing/arfs1sounds/fennec2.ogg',
		"Fox Bark" 				= 'modular_coyote/sound/typing/arfs1sounds/fox1.ogg',
		"Husky Bark-bark" 		= 'modular_coyote/sound/typing/arfs1sounds/husky1.ogg',
		"Husky Howl" 			= 'modular_coyote/sound/typing/arfs1sounds/husky2.ogg',
		"Hyena Laugh" 			= 'modular_coyote/sound/typing/arfs1sounds/hyena1.ogg',
		"Lizard?" 				= 'modular_coyote/sound/typing/arfs1sounds/lizard1.ogg',
		"Lynx Growl" 			= 'modular_coyote/sound/typing/arfs1sounds/lynx1.ogg',
		"Orca" 					= 'modular_coyote/sound/typing/arfs1sounds/orca1.ogg',
		"Panda" 				= 'modular_coyote/sound/typing/arfs1sounds/panda1.ogg',
		"Pig Grunt" 			= 'modular_coyote/sound/typing/arfs1sounds/pig1.ogg',
		"Porcupine" 			= 'modular_coyote/sound/typing/arfs1sounds/porcupine1.ogg',
		"Possum Hiss" 			= 'modular_coyote/sound/typing/arfs1sounds/possum1.ogg',
		"Miserable Bark" 		= 'modular_coyote/sound/typing/arfs1sounds/pug1.ogg',
		"Rabbit Squeal" 		= 'modular_coyote/sound/typing/arfs1sounds/rabbit1.ogg',
		"Raccoon Chitter" 		= 'modular_coyote/sound/typing/arfs1sounds/raccoon1.ogg',
		"Red Panda Chitter" 	= 'modular_coyote/sound/typing/arfs1sounds/redpanda1.ogg',
		"Dial Up" 				= 'modular_coyote/sound/typing/arfs1sounds/robot1.ogg',
		"Yappy Dog" 			= 'modular_coyote/sound/typing/arfs1sounds/shihtzu1.ogg',
		"Cat Mrowl" 			= 'modular_coyote/sound/typing/arfs1sounds/siamese1.ogg',
		"Cat Meow" 				= 'modular_coyote/sound/typing/catmeow.ogg',
		"Cat Trill" 			= 'modular_coyote/sound/typing/cattrill.ogg',
		"Skunk Chitter" 		= 'modular_coyote/sound/typing/arfs1sounds/skunk1.ogg',
		"Big Cat Chuff" 		= 'modular_coyote/sound/typing/arfs1sounds/tiger1.ogg',
		"Vulture" 				= 'modular_coyote/sound/typing/arfs1sounds/vulture1.ogg',
		"Wolf Howl" 			= 'modular_coyote/sound/typing/arfs1sounds/wolf1.ogg'
				))
