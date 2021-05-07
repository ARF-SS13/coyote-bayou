/datum/species/homunculi
	name = "homunculi"
	id = "homunculi"
	say_mod = "states"
	limbs_id = "homunculi"
	default_color = "FFFFFF"
	blacklisted = 0
	inherent_traits = list(TRAIT_EASYDISMEMBER,TRAIT_NO_PROCESS_FOOD,TRAIT_VIRUSIMMUNE,TRAIT_NOLIMBDISABLE,TRAIT_NOHUNGER,TRAIT_NOBREATH)
	species_traits = list(NOEYES,NOTRANSSTING,HAS_FLESH,HAS_BONE,HAIR,ROBOTIC_LIMBS)
	hair_alpha = 0
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	mutant_bodyparts = list("synth chest", "synth head")
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/ipc
	gib_types = list(/obj/effect/gibspawner/ipc, /obj/effect/gibspawner/ipc/bodypartless)

	//Just robo looking parts.
	mutant_heart = /obj/item/organ/heart/gen2synth
	mutantlungs = /obj/item/organ/lungs/gen2synth
	mutantliver = /obj/item/organ/liver/gen2synth
	mutantstomach = /obj/item/organ/stomach/gen2synth
	mutanteyes = /obj/item/organ/eyes/gen2synth
	mutantears = /obj/item/organ/ears/gen2synth
	mutanttongue = /obj/item/organ/tongue/robot/gen2synth
	mutant_brain = /obj/item/organ/brain/gen2synth

	//special cybernetic organ for getting power from apcs
	mutant_organs = list(/obj/item/organ/cyberimp/arm/power_cord)

	exotic_bloodtype = "HF"
	exotic_blood_color = BLOOD_COLOR_OIL
	species_type = "robotic"

/datum/species/gen2synth/qualifies_for_rank(rank, list/features)
	if(rank in GLOB.legion_positions) //Not sure on this one, are the Legion a fan of sentient robots?
		return 0
	if(rank in GLOB.brotherhood_positions) //Kill it with fire.
		return 0
	if(rank in GLOB.vault_positions) //How did they even get in??.
		return 0
	return ..()

/obj/item/bodypart/chest/synth
	name = "synth chest"
	desc = "It's impolite to stare at a person's chest."
	icon_state = "gen2synth_chest"
	max_damage = 150
	body_zone = BODY_ZONE_CHEST
	body_part = CHEST
	px_x = 0
	px_y = 0

/obj/item/bodypart/head/synth
	name = "synth head"
	desc = "Ooo, flashy."
	icon_state = "gen2synth_head"
	max_damage = 50
	body_zone = BODY_ZONE_HEAD
	body_part = HEAD