/datum/species/gen2synth
	name = "second generation synth"
	id = "gen2synth"
	say_mod = "states"
	limbs_id = "gen2synth"
	default_color = "F5F5DC"
	blacklisted = 0
	sexes = 1
	inherent_traits = list(TRAIT_EASYDISMEMBER,TRAIT_NO_PROCESS_FOOD,TRAIT_VIRUSIMMUNE,TRAIT_NOLIMBDISABLE,TRAIT_NOHUNGER,TRAIT_NOBREATH)
	species_traits = list(NOEYES,NOTRANSSTING,HAS_FLESH,HAS_BONE,HAIR,ROBOTIC_LIMBS)
	hair_alpha = 0
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
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
