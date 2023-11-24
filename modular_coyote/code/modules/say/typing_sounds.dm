// Author: Gremling
// Refactored from list to datum types instead to allow customisation per sound file.

GLOBAL_LIST_EMPTY(typing_sounds) // Holds all the sound datums

SUBSYSTEM_DEF(typinginit)
	name = "Typing Indicator Init"
	wait = 6000
	runlevels = RUNLEVEL_INIT
	flags = SS_NO_FIRE

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
	name = "Beep"
	soundFile = 'sound/machines/beep.ogg'

/datum/typing_sound/win7
	name = "Win7 Error"
	soundFile = 'sound/effects/beeper7.ogg'

/datum/typing_sound/harddrive
	name = "Hard Drive"
	soundFile = 'sound/effects/bootup.ogg'

/datum/typing_sound/buzzsigh
	name = "Buzz Sigh"
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

/datum/typing_sound/beaver
	name = "Beaver"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/beaver1.ogg'

/datum/typing_sound/horriblebirdkyaa
	name = "Horrible Bird Kyaa"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/bird1.ogg'

/datum/typing_sound/horriblebirdcall2
	name = "Horrible Bird Call 2"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/bird2.ogg'

/datum/typing_sound/boar
	name = "Boar"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/boar1.ogg'

/datum/typing_sound/goat
	name = "Goat"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/capra1.ogg'

/datum/typing_sound/corgicody
	name = "Corgi (Cody)"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/corgi1.ogg'

/datum/typing_sound/corgi
	name = "Corgi"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/corgi2.ogg'

/datum/typing_sound/cougar
	name = "Cougar"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/cougar1.ogg'

/datum/typing_sound/cow
	name = "Cow"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/cow1.ogg'

/datum/typing_sound/coyotehowl
	name = "Coyote Howl"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/coyote1.ogg'

/datum/typing_sound/coyote
	name = "Coyote"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/coyote2.ogg'

/datum/typing_sound/crocodile
	name = "Crocodile"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/croc1.ogg'

/datum/typing_sound/deer
	name = "Deer"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/deer1.ogg'

/datum/typing_sound/drider
	name = "Drider"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/drider1.ogg'

/datum/typing_sound/eevee
	name = "Eevee"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/eevee1.ogg'

/datum/typing_sound/elephant
	name = "Elephant"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/elephant1.ogg'

/datum/typing_sound/fennecbark
	name = "Fennec Bark"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/fennec1.ogg'

/datum/typing_sound/fennecsqueak
	name = "Fennec Squeak"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/fennec2.ogg'

/datum/typing_sound/foxbark
	name = "Fox Bark"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/fox1.ogg'

/datum/typing_sound/huskybarkbark
	name = "Husky Bark-bark"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/husky1.ogg'

/datum/typing_sound/huskyhowl
	name = "Husky Howl"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/husky2.ogg'

/datum/typing_sound/hyenalaugh
	name = "Hyena Laugh"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/hyena1.ogg'

/datum/typing_sound/lizard
	name = "Lizard?"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/lizard1.ogg'

/datum/typing_sound/lynxgrowl
	name = "Lynx Growl"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/lynx1.ogg'

/datum/typing_sound/orca
	name = "Orca"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/orca1.ogg'

/datum/typing_sound/panda
	name = "Panda"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/panda1.ogg'

/datum/typing_sound/piggrunt
	name = "Pig Grunt"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/pig1.ogg'

/datum/typing_sound/porcupine
	name = "Porcupine"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/porcupine1.ogg'

/datum/typing_sound/possumhiss
	name = "Possum Hiss"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/possum1.ogg'

/datum/typing_sound/miserablebark
	name = "Miserable Bark"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/pug1.ogg'

/datum/typing_sound/rabbitsqueal
	name = "Rabbit Squeal"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/rabbit1.ogg'

/datum/typing_sound/raccoonchitter
	name = "Raccoon Chitter"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/raccoon1.ogg'

/datum/typing_sound/redpandachitter
	name = "Red Panda Chitter"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/redpanda1.ogg'

/datum/typing_sound/dialup
	name = "Dial Up"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/robot1.ogg'

/datum/typing_sound/yappydog
	name = "Yappy Dog"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/shihtzu1.ogg'

/datum/typing_sound/catmrowl
	name = "Cat Mrowl"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/siamese1.ogg'

/datum/typing_sound/catmeow
	name = "Cat Meow"
	soundFile = 'modular_coyote/sound/typing/catmeow.ogg'

/datum/typing_sound/cattrill
	name = "Cat Trill"
	soundFile = 'modular_coyote/sound/typing/cattrill.ogg'

/datum/typing_sound/skunkchitter
	name = "Skunk Chitter"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/skunk1.ogg'

/datum/typing_sound/bigcatchuff
	name = "Big Cat Chuff"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/tiger1.ogg'

/datum/typing_sound/vulture
	name = "Vulture"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/vulture1.ogg'

/datum/typing_sound/wolfhowl
	name = "Wolf Howl"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/wolf1.ogg'

/datum/typing_sound/xenohiss
	name = "Xeno Hiss"
	soundFile = 'modular_coyote/sound/typing/arfs1sounds/xeno1.ogg'
