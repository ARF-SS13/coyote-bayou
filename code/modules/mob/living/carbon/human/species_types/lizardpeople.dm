/datum/species/lizard
	// Reptilian humanoids with scaled skin and tails.
	name = "Anthromorphic Lizard"
	id = SPECIES_LIZARD
	limbs_id = BODYTYPE_LIZARD
	say_mod = "hisses"
	default_color = "00FF00"
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		HAIR,
		FACEHAIR,
		LIPS,
		HORNCOLOR,
		WINGCOLOR,
		HAS_FLESH,
		HAS_BONE
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_REPTILE|MOB_BEAST
	mutanttongue = /obj/item/organ/tongue/lizard
	mutanttail = /obj/item/organ/tail/lizard
	coldmod = 1.5
	heatmod = 0.67
	mutant_bodyparts = list(
		MBP_COLOR1 = "0F0",
		MBP_COLOR2 = "0F0",
		MBP_COLOR3 = "0F0",
		MBP_TAIL_LIZARD = "Smooth",
		MBP_SNOUT = "Round",
		MBP_HORNS = "None",
		MBP_FRILLS = "None",
		MBP_TAIL_SPINES = "None",
		MBP_MARKINGS_BODY = list(),
		MBP_LEGS = LIMB_DIGITIGRADE,
		MBP_TAUR = "None",
		MBP_WINGS_DECORATIVE = "None",
		MBP_EARS = "None"
	)
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/lizard
	gib_types = list(
		/obj/effect/gibspawner/lizard,
		/obj/effect/gibspawner/lizard/bodypartless
	)
	skinned_type = /obj/item/stack/sheet/animalhide/lizard
	exotic_bloodtype = "L"
	exotic_blood_color = BLOOD_COLOR_LIZARD
	disliked_food = GRAIN | DAIRY
	liked_food = GROSS | MEAT
	inert_mutation = FIREBREATH
	species_language_holder = /datum/language_holder/lizard

	tail_type = MBP_TAIL_LIZARD
	wagging_type = MBP_TAIL_WAGGING_LIZARD
	species_type = SPECIES_TYPE_LIZARD
	allowed_limb_ids = list(
		BODYTYPE_FURRY,
		BODYTYPE_AQUATIC,
		BODYTYPE_AVIAN,
		BODYTYPE_SHADEKIN
	)

/datum/species/lizard/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_lizard_name(gender)

	var/randname = lizard_name(gender)

	if(lastname)
		randname += " [lastname]"

	return randname

/*
Lizard subspecies: ASHWALKERS
*/
/datum/species/lizard/ashwalker
	name = "Ash Walker"
	id = SPECIES_LIZARD_ASHWALKER
	limbs_id = BODYTYPE_LIZARD
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		DIGITIGRADE
	)
	inherent_traits = list(
		TRAIT_CHUNKYFINGERS
	)
	mutantlungs = /obj/item/organ/lungs/ashwalker
	mutanteyes = /obj/item/organ/eyes/night_vision
	burnmod = 0.9
	brutemod = 0.9
	species_language_holder = /datum/language_holder/lizard/ash

/datum/species/lizard/ashwalker/on_species_gain(mob/living/carbon/human/C, datum/species/old_species)
	if((C.dna.features[MBP_TAIL_SPINES] != "None" ) && (C.dna.features[MBP_TAIL_LIZARD] == "None")) //tbh, it's kinda ugly for them not to have a tail yet have floating spines
		C.dna.features[MBP_TAIL_LIZARD] = "Smooth"
		C.update_body()
	if(C.dna.features[MBP_LEGS] != "digitigrade")
		C.dna.features[MBP_LEGS] = "digitigrade"
		for(var/obj/item/bodypart/leggie in C.bodyparts)
			if(leggie.body_zone == BODY_ZONE_L_LEG || leggie.body_zone == BODY_ZONE_R_LEG)
				leggie.update_limb(FALSE, C)
	return ..()
