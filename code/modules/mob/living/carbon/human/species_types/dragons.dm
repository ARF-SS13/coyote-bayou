// Wizards's dumb attempt at dragon porting
// yoinked icons and idea from Chompers/Virgo
#define SPECIES_DRAGON dragon

/datum/species/dragon
	simple_icon = 'icons/mob/dragon/dragon_parts_greyscaled.dmi'
	icon_rest_suffix = "-rest"
	icon_dead_suffix = "-dead"
	roundstart = TRUE
	id = "dragon_bodyEmpty" //This is correct, the base icon must be empty, everything else are mutant body parts

	name = "Feral Dragon"
	say_mod = "hisses"
	default_color = "00FF00"
	species_traits = list(FERAL,NOZOMBIE,NO_UNDERWEAR,MUTCOLORS,NOEYES,CAN_SCAR,LIPS,HAS_FLESH,HAS_BONE,NO_INHAND)
	inherent_biotypes = MOB_ORGANIC|MOB_REPTILE|MOB_BEAST
	coldmod = 1.5
	heatmod = 0.67
	gib_types = list(/obj/effect/gibspawner/human/bodypartless)
	mutant_bodyparts = list("mcolor" = "0F0", "mcolor2" = "0F0", "mcolor3" = "0F0", "derg_body" = "Smooth Dragon Body", "derg_belly" = "Dragon Under Smooth",
							"derg_horns" = "Pointy", "derg_mane" = "None", "derg_ears" = "None", "derg_eyes" = "Normal", "frills" = "None")
							 
	attack_verb = "claw"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/lizard
	skinned_type = /obj/item/stack/sheet/animalhide/lizard
	exotic_bloodtype = "L"
	exotic_blood_color = BLOOD_COLOR_LIZARD
	disliked_food = GRAIN
	liked_food = GROSS | MEAT
	inert_mutation = FIREBREATH
	species_language_holder = /datum/language_holder/lizard
	species_type = "dragon"
	allowed_limb_ids = list("dragon")
	damage_overlay_type = null
	limbs_id = "dragon"
	footstep_type = FOOTSTEP_MOB_CLAW

	icon_width = 128

/mob/living/carbon/human/species/dragon
	race = /datum/species/dragon
