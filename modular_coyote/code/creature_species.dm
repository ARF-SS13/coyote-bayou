//Pokemon Start
/datum/species/feral
	name = "REPORT THIS AS A BUG"
	id = "eevee"
	//The id is the living and standing icon state of the creature.
	//The dead icon state must be "id_d" in the .dmi file
	//The resting icon state must be "id_rest" in the .dmi file
	simple_icon = 'modular_coyote/icons/mob/pokemon64.dmi'
	mutant_bodyparts = list("legs" = "Digitigrade", "meat_type" = "Mammalian")//Lets you select digitgrade legs if you want the claw footstep sound.
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_r"
	/// The width of the icon_limbs file. Used to auto-center your sprite.
	icon_width = 64
	roundstart = FALSE
	species_traits = list(HAS_FLESH,HAS_BONE,NOZOMBIE,NO_UNDERWEAR,FERAL,NOEYES,CAN_SCAR)
	inherent_biotypes = MOB_ORGANIC|MOB_BEAST
	meat = /obj/item/reagent_containers/food/snacks/meat/slab
	gib_types = list(/obj/effect/gibspawner/human/bodypartless)
	attack_verb = "claw"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	rotate_on_lying = FALSE
	//We need this so that our limbs don't have null sprites when they get thrown off. (Should almost never happen because I glued them on, but just in case.)
	limbs_id = "mammal"

//Start Pokemon//
//Alphabetical Please//

/datum/species/feral/pokemon
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/pokemon
	roundstart = FALSE
	liked_food = FRUIT
	disliked_food = TOXIC | GROSS
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_r"

/datum/species/feral/pokemon/absol
	name = "Feral Absol"
	id = "absol"
	roundstart = TRUE

/datum/species/feral/pokemon/arcanine
	name = "Feral Acanine"
	id = "arcanine"
	roundstart = TRUE

/datum/species/feral/pokemon/braixen
	name = "Feral Braixen"
	id = "braixen"
	roundstart = TRUE

/datum/species/feral/pokemon/eevee
	name = "Feral Eevee"
	id = "eevee"

/datum/species/feral/pokemon/glaceon
	name = "Feral Glaceon"
	id = "glaceon"
	roundstart = TRUE

/datum/species/feral/pokemon/lycanroc
	name = "Feral Lycanroc"
	id = "lycanroc"
	roundstart = TRUE

//End Pokemon//

//Start Other//

/datum/species/feral/nightstalker
	name = "Feral Nightstalker"
	id = "nightstalker"
	simple_icon = 'icons/fallout/mobs/animals/nightstalker.dmi'
	icon_width = 64
	icon_dead_suffix = "-dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT

/datum/species/feral/cat
	name = "Feral Cat"
	id = "cat2"
	simple_icon = 'icons/mob/pets.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT

/datum/species/feral/black_cat
	name = "Feral Black Cat"
	id = "cat"
	simple_icon = 'icons/mob/pets.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT

/datum/species/feral/striped_cat
	name = "Feral Striped Cat"
	id = "pancake"
	simple_icon = 'icons/mob/pets.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT

/datum/species/feral/space_cat
	name = "Feral Space Cat"
	id = "spacecat"
	simple_icon = 'icons/mob/pets.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT

/datum/species/feral/wolf
	name = "Feral Wolf"
	id = "wolf"
	simple_icon = 'icons/fallout/mobs/animals/dogs.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	rotate_on_lying = TRUE
	roundstart = TRUE
	liked_food = MEAT

/datum/species/feral/dog
	name = "Feral Dog"
	id = "dog_feral"
	simple_icon = 'icons/fallout/mobs/animals/dogs.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	rotate_on_lying = TRUE
	roundstart = TRUE
	liked_food = MEAT

/datum/species/feral/hyotie
	name = "Feral Hyotie"
	id = "andrews"
	simple_icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_width = 64
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT

/datum/species/feral/mousebrown
	name = "Feral Brown Mouse"
	id = "mouse_brown"
	simple_icon = 'icons/mob/animal.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = VEGETABLES

/datum/species/feral/bat
	name = "Feral Bat"
	id = "bat"
	simple_icon = 'modular_coyote/icons/mob/bat.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = FRUIT

/datum/species/feral/gecko
	name = "Feral Gecko"
	id = "gekko"
	simple_icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT

/datum/species/feral/gecko_villager
	name = "Feral Gecko Villager"
	id = "gekko_tribe_villager"
	simple_icon = 'icons/fallout/mobs/animals/gecktribe.dmi'
	icon_width = 32
	icon_dead_suffix = "_dead"
	icon_rest_suffix = "_rest"
	roundstart = TRUE
	liked_food = MEAT

//End Other//
