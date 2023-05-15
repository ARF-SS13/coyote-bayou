/datum/species/mammal
	name = "Anthromorph"
	id = SPECIES_FURRY
	limbs_id = BODYTYPE_FURRY
	default_color = "4B4B4B"
	species_traits = list(
		MUTCOLOR1,
		EYECOLOR,
		LIPS,
		HAIR,
		HORNCOLOR,
		WINGCOLOR,
		HAS_FLESH,
		HAS_BONE
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BEAST
	mutant_bodyparts = list(
		MBP_COLOR1 = "FFFFFF",
		MBP_COLOR2 = "FFFFFF",
		MBP_COLOR3 = "FFFFFF",
		MBP_SNOUT = "Husky",
		MBP_TAIL = "Husky",
		MBP_EARS = "Husky",
		MBP_WINGS_DECORATIVE = "None",
		MBP_MARKINGS_BODY = "Husky",
		MBP_TAUR = "None",
		MBP_HORNS = "None",
		MBP_LEGS = LEGS_DIGITIGRADE,
		MBP_MEAT_TYPE = MEAT_MAMMAL
	)
	attack_verb = "claw"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/mammal
	liked_food = MEAT | FRIED
	disliked_food = TOXIC

	tail_type = MBP_TAIL
	wagging_type = MBP_TAIL_WAGGING
	species_type = SPECIES_TYPE_FURRY

	allowed_limb_ids = list(
		BODYTYPE_FURRY,
		BODYTYPE_AQUATIC,
		BODYTYPE_AVIAN,
		BODYTYPE_SHADEKIN
	)
