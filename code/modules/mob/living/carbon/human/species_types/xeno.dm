/datum/species/xeno
	// A cloning mistake, crossing human and xenomorph DNA
	name = "Xenomorph Hybrid"
	id = SPECIES_XENO
	limbs_id = BODYTYPE_XENO
	say_mod = "hisses"
	default_color = "00FF00"
	species_traits = list(
		MUTCOLOR1,
		EYECOLOR,
		LIPS,
		CAN_SCAR,
		HAS_FLESH,
		HAS_BONE
	)
	mutant_bodyparts = list(
		MBP_XENO_TAIL="Xenomorph Tail",
		MBP_XENO_HEAD="Standard",
		MBP_XENO_DORSAL="Standard",
		MBP_MARKINGS_BODY = list(),
		MBP_COLOR1 = "0F0",
		MBP_COLOR2 = "0F0",
		MBP_COLOR3 = "0F0",
		MBP_TAUR = "None",
		MBP_LEGS = LEGS_DIGITIGRADE,
		MBP_WINGS_DECORATIVE= "None"
	)
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/xeno
	gib_types = list(
		/obj/effect/gibspawner/xeno/xenoperson,
		/obj/effect/gibspawner/xeno/xenoperson/bodypartless
	)
	skinned_type = /obj/item/stack/sheet/animalhide/xeno
	exotic_bloodtype = "X*"
	damage_overlay_type = SPECIES_XENO
	liked_food = MEAT
	species_type = SPECIES_TYPE_ALIEN
