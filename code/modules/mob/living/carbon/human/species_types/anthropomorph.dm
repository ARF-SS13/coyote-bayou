/datum/species/mammal/synthetic
	name = "Synthetic Anthromorph"
	id = "synthfurry"

	species_traits = list(MUTCOLORS,NOTRANSSTING,EYECOLOR,FACEHAIR,LIPS,HAIR,ROBOTIC_LIMBS,HAS_FLESH,HAS_BONE,WINGCOLOR,HORNCOLOR)
	inherent_traits = list(TRAIT_NODISMEMBER,TRAIT_NOLIMBDISABLE,TRAIT_NOHUNGER,TRAIT_NOBREATH)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID|MOB_BEAST|MOB_SYNTH

	mutant_bodyparts = list("mcolor" = "FFFFFF","mcolor2" = "FFFFFF","mcolor3" = "FFFFFF", "mam_snouts" = "Husky", "mam_tail" = "Husky", "mam_ears" = "Husky", "deco_wings" = "None",
						"mam_body_markings" = "Husky", "taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "Mammalian")

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


	attack_verb = "claw"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'

	tail_type = "mam_tail"
	wagging_type = "mam_waggingtail"
	species_type = "furry"

	allowed_limb_ids = list("mammal","aquatic","avian", "human", "shadekin")
