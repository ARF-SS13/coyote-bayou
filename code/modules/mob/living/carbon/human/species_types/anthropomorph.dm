/* 
/datum/species/mammal/synthetic
	name = "Synthetic Anthromorph"
	id = SPECIES_SYNTH_FURRY

	species_traits = list(MUTCOLOR1,NOTRANSSTING,EYECOLOR,LIPS,HAIR,ROBOTIC_LIMBS,HAS_FLESH,HAS_BONE,WINGCOLOR,HORNCOLOR)
	inherent_traits = list(TRAIT_NODISMEMBER,TRAIT_NOLIMBDISABLE,TRAIT_NOHUNGER,TRAIT_NOBREATH)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID|MOB_BEAST

	mutant_bodyparts = list(MBP_COLOR1 = "FFFFFF",MBP_COLOR2 = "FFFFFF",MBP_COLOR3 = "FFFFFF", MBP_SNOUT = "Husky", MBP_TAIL = "Husky", MBP_EARS = "Husky", MBP_WINGS_DECORATIVE = "None",
						MBP_BODY_MARKINGS = "Husky", MBP_TAUR = "None", MBP_HORNS = "None", MBP_LEGS = LEGS_PLANTIGRADE, MBP_MEAT_TYPE = MEAT_MAMMAL)

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

	tail_type = MBP_TAIL
	wagging_type = MBP_TAIL_WAGGING
	species_type = "furry"

	allowed_limb_ids = list(SPECIES_FURRY,BODYTYPE_AQUATIC,BODYTYPE_AVIAN, SPECIES_HUMAN, SPECIES_SHADEKIN)
 */
