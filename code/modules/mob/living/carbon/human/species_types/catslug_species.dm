// Its a slugcat!
/datum/species/mammal/catslug
	name = "slugcat"
	id = SPECIES_CATSLUG
	limbs_id = BODYTYPE_CATSLUG
	allowed_limb_ids = list(
		BODYTYPE_CATSLUG,
	)
	say_mod = "chitters"
	lock_other_parts = TRUE
	mutant_bodyparts = list(
		FEATURE_COLOR_1 = "FFFFFF",
		FEATURE_COLOR_2 = "FFFFFF",
		FEATURE_COLOR_3 = "FFFFFF",
		MBP_TAIL = "catslug",
		MBP_EARS = "catslug",
		MBP_LEGS = LEGS_PLANTIGRADE,
		MBP_MEAT_TYPE = MEAT_MAMMAL
	)
	force_plantigrade = TRUE
	species_type = SPECIES_TYPE_FURRY
	/// Wow, totally unused till now, huh?
	offset_features = list(
		OFFSET_UNIFORM = list(0,0),
		OFFSET_ID = list(0,-8),
		OFFSET_GLOVES = list(0,0),
		OFFSET_GLASSES = list(0,-8),
		OFFSET_EARS = list(0,-8),
		OFFSET_SHOES = list(0,0),
		OFFSET_S_STORE = list(0,-8),
		OFFSET_FACEMASK = list(0,-8),
		OFFSET_HEAD = list(0,-8),
		OFFSET_EYES = list(0,-8),
		OFFSET_LIPS = list(0,-8),
		OFFSET_BELT = list(0,-8),
		OFFSET_BACK = list(0,-8),
		OFFSET_HAIR = list(0,-8),
		OFFSET_FHAIR = list(0,-8),
		OFFSET_SUIT = list(0,0),
		OFFSET_NECK = list(0,-8),
		OFFSET_MUTPARTS = list(0,0),
		OFFSET_INHANDS = list(0,-8),
	)
	species_traits = list(
		NO_UNDERWEAR,
		NOEYES,
	)
	no_equip = list(
		SLOT_GLOVES,
		SLOT_SHOES,
		SLOT_WEAR_SUIT,
		SLOT_W_UNIFORM,
	)


/mob/living/carbon/human/species/mammal/catslug
	race = /datum/species/mammal/catslug
