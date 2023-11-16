/datum/species/eevee
	name = "Feral Eevee"
	id = "eevee"
	//The id is the living and standing icon state of the creature.
	//The dead icon state must be "id_d" in the .dmi file
	//The resting icon state must be "id_rest" in the .dmi file
	simple_icon = 'modular_coyote/icons/mob/pokemon64.dmi'
	/// The width of the icon_limbs file. Used to auto-center your sprite.
	icon_width = 64
	roundstart = TRUE
	species_traits = list(HAS_FLESH,HAS_BONE,NOZOMBIE,NO_UNDERWEAR,NOGENITALS,FERAL,NOEYES,CAN_SCAR)
	inherent_biotypes = MOB_ORGANIC|MOB_BEAST
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/pokemon
	attack_verb = "claw"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = FRUIT //Berries
	disliked_food = TOXIC | GROSS //Ouchies and ewies
	rotate_on_lying = FALSE
	//We need this so that our limbs don't have null sprites when they get thrown off. (Should never happen because I glued them on, but just in case.)
	limbs_id = "mammal"
