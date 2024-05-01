/datum/species/synthfurry
	name = "Synthetic Anthropomorph"
	id = "synthliz"
	say_mod = "beeps"
	default_color = "00FF00"
	species_traits = list(
		MUTCOLORS,
		NOTRANSSTING,
		EYECOLOR,
		FACEHAIR,
		LIPS,
		HAIR,
		ROBOTIC_LIMBS,
		HORNCOLOR,
		WINGCOLOR,
		NO_DNA_COPY,
		)
	inherent_traits = list(
		TRAIT_EASYDISMEMBER,
		TRAIT_LIMBATTACHMENT,
		TRAIT_RADIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_CLONEIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_MUTATION_STASIS,
		)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID|MOB_REPTILE|MOB_BEAST|MOB_SYNTH
	mutant_bodyparts = list(
		"ipc_antenna" = "Synthetic Lizard - Antennae",
		"mam_tail" = "Synthetic Lizard",
		"mam_snouts" = "Synthetic Lizard - Snout",
		"legs" = "Digitigrade",
		"mam_body_markings" = "Synthetic Lizard - Plates",
		"mam_ears" = "None",
		"taur" = "None",
		"horns" = "None", 
		"deco_wings" = "None"
		)
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/ipc
	gib_types = list(/obj/effect/gibspawner/ipc, /obj/effect/gibspawner/ipc/bodypartless)
	//Just robo looking parts.
	mutant_heart = /obj/item/organ/heart/ipc
	mutantlungs = /obj/item/organ/lungs/ipc
	mutantliver = /obj/item/organ/liver/ipc
	mutantstomach = /obj/item/organ/stomach/ipc
	mutanteyes = /obj/item/organ/eyes/ipc
	mutantears = /obj/item/organ/ears/ipc
	mutanttongue = /obj/item/organ/tongue/robot/ipc
	mutant_brain = /obj/item/organ/brain/ipc

	//special cybernetic organ for getting power from apcs
	mutant_organs = list(/obj/item/organ/cyberimp/arm/power_cord)

	exotic_bloodtype = "S"
	exotic_blood_color = BLOOD_COLOR_OIL

	tail_type = "mam_tail"
	wagging_type = "mam_waggingtail"
	species_type = "robotic"
	allowed_limb_ids = list("mammal","aquatic","avian", "human", "shadekin", "protectron", "golem")

/datum/species/synthfurry/spec_life(mob/living/carbon/human/H)
/*	if(H.nutrition < NUTRITION_LEVEL_FED)
		H.nutrition = NUTRITION_LEVEL_FED
	if(H.nutrition > NUTRITION_LEVEL_FED)
		H.nutrition = NUTRITION_LEVEL_FED*/ // Because not having to eat is dumb
	if(H.losebreath != 0)
		H.losebreath = 0 // just in case
	if(H.toxloss)
		H.adjustToxLoss(-H.toxloss)

/datum/species/synthfurry/handle_mutations_and_radiation(mob/living/carbon/human/H)
	return TRUE

/datum/species/synthfurry/synth_anthromorph
	name = "Synthetic Anthromorph"
	id = "synthfurry"

/datum/species/synthfurry/ipc
	name = "I.P.C."
	id = "ipc"
	limbs_id = "ipc"
	icon_limbs = "ipc"
	sexes = FALSE // NO WAY MY IPC SEXES ALL THE TIME
	hair_alpha = 210
	exotic_bloodtype = "HF"
	exotic_blood_color = BLOOD_COLOR_OIL
	var/datum/action/innate/monitor_change/screen

/datum/species/synthfurry/ipc/on_species_gain(mob/living/carbon/human/C)
	if(isipcperson(C) && !screen)
		screen = new
		screen.Grant(C)
	..()

/datum/species/synthfurry/ipc/on_species_loss(mob/living/carbon/human/C)
	if(screen)
		screen.Remove(C)
	..()

/datum/action/innate/monitor_change
	name = "Screen Change"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "drone_vision"

/datum/action/innate/monitor_change/Activate()
	var/mob/living/carbon/human/H = owner
	var/new_ipc_screen = input(usr, "Choose your character's screen:", "Monitor Display") as null|anything in GLOB.ipc_screens_list
	if(!new_ipc_screen)
		return
	H.dna.features["ipc_screen"] = new_ipc_screen
	H.update_body()

