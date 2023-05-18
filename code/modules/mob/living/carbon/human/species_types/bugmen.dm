/datum/species/insect
	name = "Anthromorphic Insect"
	id = SPECIES_INSECT
	say_mod = "chitters"
	limbs_id = BODYTYPE_INSECT
	allowed_limb_ids = list(
		BODYTYPE_INSECT,
		BODYTYPE_APID,
		BODYTYPE_MOTH,
	)
	default_color = "00FF00"
	species_traits = list(
		LIPS,
		EYECOLOR,
		HAIR,
		FACEHAIR,
		MUTCOLOR1,
		HORNCOLOR,
		WINGCOLOR,
		HAS_FLESH,
		HAS_BONE,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	mutant_bodyparts = list(
		FEATURE_COLOR_1 = "FFFFFF",
		FEATURE_COLOR_2 = "FFFFFF",
		FEATURE_COLOR_3 = "FFFFFF",
		MBP_TAIL = ACCESSORY_NONE,
		MBP_EARS = ACCESSORY_NONE,
		MBP_WINGS_INSECT = ACCESSORY_NONE,
		MBP_FLUFF = ACCESSORY_NONE,
		MBP_SNOUT = ACCESSORY_NONE,
		MBP_TAUR = ACCESSORY_NONE,
		MBP_MARKINGS_INSECT = ACCESSORY_NONE,
		MBP_BODY_MARKINGS = list()
	)
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/insect
	liked_food = MEAT | FRUIT
	disliked_food = TOXIC
	exotic_bloodtype = "BUG"
	exotic_blood_color = BLOOD_COLOR_BUG

	tail_type = MBP_TAIL
	wagging_type = MBP_TAIL_WAGGING
	species_type = SPECIES_TYPE_INSECT

	eye_type = BODYTYPE_INSECT
