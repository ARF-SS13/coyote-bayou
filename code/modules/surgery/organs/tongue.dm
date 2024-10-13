#define TONGUE_MAX_HEALTH 60

/obj/item/organ/tongue
	name = "tongue"
	desc = "A fleshy muscle mostly used for lying."
	icon_state = "tonguenormal"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_TONGUE
	attack_verb = list("licked", "slobbered", "slapped", "frenched", "tongued")
	var/list/languages_possible
	var/say_mod = null
	///lower is more sensitive.
	var/taste_sensitivity = 15
	maxHealth = TONGUE_MAX_HEALTH
	///the ones the tongue starts with, not what it currently has
	var/list/initial_accents
	///done in order of priority (please always apply abductor accent and stuttering last)
	var/list/accents = list()
	var/static/list/languages_possible_base = typecacheof(list(
		/datum/language/common,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
//		/datum/language/ratvar,
		/datum/language/aphasia,
		/datum/language/slime,
		/datum/language/vampiric,
		/datum/language/dwarf,
		/datum/language/tribal,
		/datum/language/signlanguage,
		/datum/language/pokemon,
		/datum/language/canine,
		/datum/language/squirrel,
		/datum/language/sergal,
		/datum/language/mouse,
		/datum/language/birdsong,
		/datum/language/rabbit,
		/datum/language/bug,
		/datum/language/fictionalnorse,
		/datum/language/technorussian,
		/datum/language/xenocommon,	//just let it happen
		/datum/language/machine,	//who cares
		/datum/language/spanish,
		/datum/language/serbian,
		/datum/language/freljordian,
	))
	healing_factor = STANDARD_ORGAN_HEALING*5 //Fast!!
	decay_factor = STANDARD_ORGAN_DECAY/2
	/// How much licking someone should heal someone
	var/lick_heal_brute
	/// How much licking someone should heal someone
	var/lick_heal_burn
	/// What kind of bandage is applied by licking someone
	//	var/obj/item/stack/medical/gauze/lick_bandage
	/// What kind of healpack is applied by licking someone
	// var/obj/item/stack/medical/bruise_pack/lick_healer

/obj/item/organ/tongue/Initialize(mapload)
	. = ..()
	for(var/accent in initial_accents)
		accents += new accent
	low_threshold_passed = span_info("Your [name] feels a little sore.")
	low_threshold_cleared = span_info("Your [name] soreness has subsided.")
	high_threshold_passed = span_warning("Your [name] is really starting to hurt.")
	high_threshold_cleared = span_info("The pain of your [name] has subsided a little.")
	now_failing = span_warning("Your [name] feels like it's about to fall out!.")
	now_fixed = span_info("The excruciating pain of your [name] has subsided.")
	languages_possible = languages_possible_base
	// if(lick_bandage) // ew
	// 	initialize_bandage(lick_bandage)
	// if(lick_healer) // ew
	// 	initialize_lickpack(lick_healer)

/obj/item/organ/tongue/Destroy()
	. = ..()
	// if(istype(lick_bandage))
	// 	QDEL_NULL(lick_bandage)
	// if(istype(lick_healer))
	// 	QDEL_NULL(lick_healer)

/// Makes a tongue have a bandage in it, so it can lick wounds and apply some kind of bandage
/*
/obj/item/organ/tongue/proc/initialize_bandage(obj/item/stack/medical/gauze/lick_gauze)
	if(!lick_gauze)
		return FALSE
	lick_bandage = new lick_gauze(src)
	return TRUE
*/
/// Makes a tongue have a bandage in it, so it can lick wounds and apply some kind of bandage
/obj/item/organ/tongue/proc/initialize_lickpack(obj/item/stack/medical/bruise_pack/lick_pack)
	if(!lick_pack)
		return FALSE
	//lick_healer = new lick_pack(src)
	return TRUE

/obj/item/organ/tongue/proc/handle_speech(datum/source, datum/rental_mommy/chat/mom) //this wont proc unless there's initial_accents on the tongue
	for(var/datum/accent/speech_modifier in accents)
		speech_modifier.premodify_speech(mom, source, owner)

/obj/item/organ/tongue/applyOrganDamage(d, maximum = maxHealth)
	. = ..()
	if(damage >= maxHealth)
		to_chat(owner, span_userdanger("Your tongue is singed beyond recognition, and disintegrates!"))
		SSblackbox.record_feedback("tally", "fermi_chem", 1, "Tongues lost to Fermi")
		qdel(src)

/obj/item/organ/tongue/Insert(mob/living/carbon/M, special = 0, drop_if_replaced = TRUE)
	..()
	if(say_mod && M.dna && M.dna.species)
		M.dna.species.say_mod = say_mod
	if(length(initial_accents) || length(accents))
		//M.UnregisterSignal(M, COMSIG_MOB_SAY)
		RegisterSignal(M, COMSIG_MOB_SAY,PROC_REF(handle_speech), override = TRUE)


/obj/item/organ/tongue/Remove(special = FALSE)
	if(!QDELETED(owner))
		if(say_mod && owner.dna?.species)
			owner.dna.species.say_mod = initial(owner.dna.species.say_mod)
		UnregisterSignal(owner, COMSIG_MOB_SAY,PROC_REF(handle_speech))
		//owner.RegisterSignal(owner, TYPE_PROC_REF(COMSIG_MOB_SAY, /mob/living/carbon/,handle_tongueless_speech))
	return ..()

/obj/item/organ/tongue/could_speak_language(language)
	return is_type_in_typecache(language, languages_possible)

/obj/item/organ/tongue/lizard
	name = "forked tongue"
	desc = "A thin and long muscle typically found in reptilian races, apparently moonlights as a nose."
	icon_state = "tonguelizard"
	say_mod = "hisses"
	taste_sensitivity = 10 // combined nose + tongue, extra sensitive
	maxHealth = 40 //extra sensitivity means tongue is more susceptible to damage
	initial_accents = list(/datum/accent/lizard)

/obj/item/organ/tongue/healing
	name = "soft tongue"
	desc = "A soft, pleasant tongue that seems to be coated in some kind of medicinal fluid. Ew."
	say_mod = "purrs"
	lick_heal_brute = 1
	lick_heal_burn = 1
//	lick_bandage = /obj/item/stack/medical/gauze/lick

/obj/item/organ/tongue/cat
	name = "cat tongue"
	desc = "A rough tongue cats use to sandpaper meat from bones, and tend to various wounds."
	say_mod = "meows"

/obj/item/organ/tongue/dog
	name = "dog tongue"
	desc = "A long floppy tongue dogs use to express both affection and thirst. Allegedly the cleanest things in the wasteland."
	say_mod = "woofs"

/obj/item/organ/tongue/fly
	name = "proboscis"
	desc = "A freakish looking meat tube that apparently can take in liquids."
	icon_state = "tonguefly"
	say_mod = "buzzes"
	taste_sensitivity = 25 // you eat vomit, this is a mercy
	maxHealth = 80 //years of eatting trash has made your tongue strong
	initial_accents = list(/datum/accent/fly)

/obj/item/organ/tongue/abductor
	name = "superlingual matrix"
	desc = "A mysterious structure that allows for instant communication between users. Pretty impressive until you need to eat something."
	icon_state = "tongueayylmao"
	say_mod = "gibbers"
	taste_sensitivity = 101 // ayys cannot taste anything.
	maxHealth = 120 //Ayys probe a lot
	initial_accents = list(/datum/accent/abductor)
	var/mothership

/obj/item/organ/tongue/abductor/attack_self(mob/living/carbon/human/H)
	if(!istype(H))
		return

	var/obj/item/organ/tongue/abductor/T = H.getorganslot(ORGAN_SLOT_TONGUE)
	if(!istype(T))
		return

	if(T.mothership == mothership)
		to_chat(H, span_notice("[src] is already attuned to the same channel as your own."))
		return

	H.visible_message(span_notice("[H] holds [src] in their hands, and concentrates for a moment."), span_notice("You attempt to modify the attunation of [src]."))
	if(do_after(H, delay=15, target=src))
		to_chat(H, span_notice("You attune [src] to your own channel."))
		mothership = T.mothership

/obj/item/organ/tongue/abductor/examine(mob/M)
	. = ..()
	if(HAS_TRAIT(M, TRAIT_ABDUCTOR_TRAINING) || HAS_TRAIT(M.mind, TRAIT_ABDUCTOR_TRAINING) || isobserver(M))
		if(!mothership)
			. += span_notice("It is not attuned to a specific mothership.")
		else
			. += span_notice("It is attuned to [mothership].")

/obj/item/organ/tongue/zombie
	name = "rotting tongue"
	desc = "Between the decay and the fact that it's just lying there you doubt a tongue has ever seemed less sexy."
	icon_state = "tonguezombie"
	say_mod = "moans"
	taste_sensitivity = 32
	maxHealth = 65 //Stop! It's already dead...!
	initial_accents = list(/datum/accent/zombie)

/obj/item/organ/tongue/alien
	name = "alien tongue"
	desc = "According to leading xenobiologists the evolutionary benefit of having a second mouth in your mouth is \"that it looks badass\"."
	icon_state = "tonguexeno"
	say_mod = "hisses"
	taste_sensitivity = 10 // LIZARDS ARE ALIENS CONFIRMED
	maxHealth = 500 //They've a little mouth for a tongue, so it's pretty rhobust
	initial_accents = list(/datum/accent/alien)
	var/static/list/languages_possible_alien = typecacheof(list(
		/datum/language/xenocommon,
		/datum/language/common,
		/datum/language/draconic,
//		/datum/language/ratvar,
		/datum/language/monkey))

/obj/item/organ/tongue/alien/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_alien

/obj/item/organ/tongue/bone
	name = "bone \"tongue\""
	desc = "Apparently skeletons alter the sounds they produce through oscillation of their teeth, hence their characteristic rattling."
	icon_state = "tonguebone"
	say_mod = "rattles"
	organ_flags = ORGAN_NO_SPOIL
	attack_verb = list("bitten", "chattered", "chomped", "enamelled", "boned")
	taste_sensitivity = 101 // skeletons cannot taste anything
	maxHealth = 75 //Take brute damage instead
	var/chattering = FALSE
	var/phomeme_type = "sans"
	var/list/phomeme_types = list(/datum/accent/span/sans, /datum/accent/span/papyrus)

/obj/item/organ/tongue/bone/Initialize()
	initial_accents += pick(phomeme_types)
	. = ..()

/obj/item/organ/tongue/bone/applyOrganDamage(d, maximum = maxHealth)
	if(d < 0)
		return
	if(!owner)
		return
	var/target = owner.get_bodypart(BODY_ZONE_HEAD)
	owner.apply_damage(d, BURN, target)
	to_chat(owner, span_userdanger("You feel your skull burning! Oof, your bones!"))
	return

/obj/item/organ/tongue/bone/handle_speech(datum/source, list/speech_args)
	if(chattering)
		chatter(speech_args[SPEECH_MESSAGE], phomeme_type, source)
	..()

/obj/item/organ/tongue/bone/plasmaman
	name = "plasma bone \"tongue\""
	desc = "Like animated skeletons, Plasmamen vibrate their teeth in order to produce speech."
	icon_state = "tongueplasma"

/obj/item/organ/tongue/robot
	name = "robotic voicebox"
	desc = "A voice synthesizer that can interface with organic lifeforms."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_NO_SPOIL
	icon_state = "tonguerobot"
	say_mod = "states"
	attack_verb = list("beeped", "booped")
	initial_accents = list(/datum/accent/span/robot)
	taste_sensitivity = 25 // not as good as an organic tongue
	maxHealth = 100 //RoboTongue!
	var/electronics_magic = TRUE

/obj/item/organ/tongue/robot/could_speak_language(language)
	return ..() || electronics_magic

/obj/item/organ/tongue/fluffy
	name = "fluffy tongue"
	desc = "OwO what's this?"
	icon_state = "tonguefluffy"
	taste_sensitivity = 10 // extra sensitive and inquisitive uwu
	maxHealth = 35 //Sensitive tongue!
	initial_accents = list(/datum/accent/fluffy)

/obj/item/organ/tongue/cybernetic
	name = "cybernetic tongue"
	desc = "A state of the art robotic tongue that can detect the pH of anything drank."
	icon_state = "tonguecybernetic"
	initial_accents = list(/datum/accent/span/robot)
	taste_sensitivity = 10
	maxHealth = 60 //It's robotic!
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/tongue/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	var/errormessage = list("Runtime in tongue.dm, line 39: Undefined operation \"zapzap ow my tongue\"", "afhsjifksahgjkaslfhashfjsak", "-1.#IND", "Graham's number", "inside you all along", "awaiting at least 1 approving review before merging this taste request")
	owner.say("The pH is appropriately [pick(errormessage)].", forced = "EMPed synthetic tongue")

/obj/item/organ/tongue/robot/ipc
	name = "positronic voicebox"
	say_mod = "beeps"
	desc = "A voice synthesizer used by IPCs to smoothly interface with organic lifeforms."
	electronics_magic = FALSE
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/tongue/robot/gen2synth
	name = "electronic tongue"
	say_mod = "says"
	desc = "A voice synthesizer used by second generation synths in order to communicate."
	electronics_magic = FALSE
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/tongue/ethereal
	name = "electric discharger"
	desc = "A sophisticated ethereal organ, capable of synthesising speech via electrical discharge."
	icon_state = "electrotongue"
	say_mod = "crackles"
	attack_verb = list("shocked", "jolted", "zapped")
	taste_sensitivity = 101 // Not a tongue, they can't taste shit
	var/static/list/languages_possible_ethereal = typecacheof(list(
		/datum/language/common,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/sylvan,
		/datum/language/voltaic
	))

/obj/item/organ/tongue/ethereal/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_ethereal

/obj/item/organ/tongue/french
	name = "\improper French tongue"
	desc = "A tongue that is quite human-like, but speaks with a French accent."
	icon_state = "tonguenormal"
	say_mod = "says"
	initial_accents = list(/datum/accent/french)

/obj/item/organ/tongue/scottish
	name = "\improper Scottish tongue"
	desc = "A tongue that is quite human-like, but speaks with a Scottish accent."
	icon_state = "tonguenormal"
	say_mod = "says"
	initial_accents = list(/datum/accent/scottish)

/obj/item/organ/tongue/bug
	name = "\improper buggish tongue"
	desc = "A tongue that is quite human-like, but speaks with a bug accent."
	icon_state = "tonguenormal"
	say_mod = "says"
	initial_accents = list(/datum/accent/bug)

/obj/item/organ/tongue/dutch
	name = "\improper Dutch tongue"
	desc = "A tongue that is quite human-like, but speaks with a Dutch accent."
	icon_state = "tonguenormal"
	say_mod = "says"
	initial_accents = list(/datum/accent/dutch)

/obj/item/organ/tongue/redriver
	name = "\improper Red Riverian tongue"
	desc = "A tongue that is quite human-like, but speaks with a Red River basin accent."
	icon_state = "tonguenormal"
	say_mod = "says"
	initial_accents = list(/datum/accent/redriver)

/obj/item/organ/tongue/swedish
	name = "\improper Swedish tongue"
	desc = "A tongue that is quite human-like, but speaks with a Swedish accent."
	icon_state = "tonguenormal"
	say_mod = "says"
	initial_accents = list(/datum/accent/swedish)

/obj/item/organ/tongue/chinese
	name = "\improper Chinese tongue"
	desc = "A tongue that is quite human-like, but speaks with a Chinese accent."
	icon_state = "tonguenormal"
	say_mod = "says"
	initial_accents = list(/datum/accent/chinese)

/obj/item/organ/tongue/japanese
	name = "\improper Japanese tongue"
	desc = "A tongue that is quite human-like, but speaks with a Japanese accent."
	icon_state = "tonguenormal"
	say_mod = "says"
	initial_accents = list(/datum/accent/japanese)

/obj/item/organ/tongue/irish
	name = "\improper Irish tongue"
	desc = "A tongue that is quite human-like, but speaks with an Irish accent."
	icon_state = "tonguenormal"
	say_mod = "says"
	initial_accents = list(/datum/accent/irish)

/obj/item/organ/tongue/slurry
	name = "\improper Slurry tongue"
	desc = "A tongue that is quite human-like, but speaks with a slurred and kind of goofy accent."
	icon_state = "tonguenormal"
	say_mod = "says"
	initial_accents = list(/datum/accent/slurry)
