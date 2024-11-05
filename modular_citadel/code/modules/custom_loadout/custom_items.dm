//For custom items.

// Unless there's a digitigrade version make sure you add mutantrace_variation = NONE to all clothing/under and shoes - Pooj
// Digitigrade stuff is uniform_digi.dmi and digishoes.dmi in icons/mob

/obj/item/toy/darksabre
	name = "Kiara's Sabre"
	desc = "This blade looks as dangerous as its owner."
	icon = 'icons/obj/custom.dmi'
	mob_overlay_icon = 'icons/mob/clothing/custom_w.dmi'
	icon_state = "darksabre"
	inhand_icon_state = "darksabre"
	lefthand_file = 'modular_citadel/icons/mob/inhands/stunsword_left.dmi'
	righthand_file = 'modular_citadel/icons/mob/inhands/stunsword_right.dmi'
	attack_verb = list("attacked", "struck", "hit")

/obj/item/toy/darksabre/get_belt_overlay()
	return mutable_appearance('icons/obj/custom.dmi', "darksheath-darksabre")

/obj/item/toy/darksabre/get_worn_belt_overlay(icon_file)
	return mutable_appearance(icon_file, "darksheath-darksabre")

/obj/item/storage/belt/sabre/darksabre
	name = "Ornate Sheathe"
	desc = "An ornate and rather sinister looking sabre sheathe."
	icon = 'icons/obj/custom.dmi'
	mob_overlay_icon = 'icons/mob/clothing/custom_w.dmi'
	icon_state = "darksheath"
	inhand_icon_state = "darksheath"
	fitting_swords = list(/obj/item/toy/darksabre)
	starting_sword = /obj/item/toy/darksabre

/obj/item/lighter/gold
	name = "engraved zippo"
	desc = "A shiny and relatively expensive zippo lighter. There's a small etched in verse on the bottom that reads, 'No Gods, No Masters, Only Man.'"
	icon = 'icons/obj/custom.dmi'
	icon_state = "gold_zippo"
	inhand_icon_state = "gold_zippo"
	w_class = WEIGHT_CLASS_TINY
	flags_1 = CONDUCT_1
	slot_flags = SLOT_BELT
	heat = 1500
	resistance_flags = FIRE_PROOF
	light_color = LIGHT_COLOR_FIRE

/obj/item/toy/plush/tree
	name = "christmass tree plushie"
	desc = "A festive plush that squeeks when you squeeze it!"
	icon = 'icons/obj/custom.dmi'
	icon_state = "pine_c"
	inhand_icon_state = "pine_c"
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("slapped")
	resistance_flags = FLAMMABLE
	squeak_override = list('sound/misc/server-ready.ogg'= 1)

/obj/item/clothing/head/hardhat/reindeer/fluff
	name = "novelty reindeer hat"
	desc = "Some fake antlers and a very fake red nose - Sponsored by PWR Game(tm)"
	icon_state = "hardhat0_reindeer"
	inhand_icon_state = "hardhat0_reindeer"
	hat_type = "reindeer"
	flags_inv = 0
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0)
	light_range = 0
	dynamic_hair_suffix = ""

/obj/item/clothing/head/santa/fluff
	name = "santa's hat"
	desc = "On the first day of christmas my employer gave to me! - From Vlad with Salad"
	icon_state = "santahatnorm"
	inhand_icon_state = "that"
	dog_fashion = /datum/dog_fashion/head/santa

//Removed all of the space flags from this suit so it utilizes nothing special.
/obj/item/clothing/suit/space/santa/fluff
	name = "Santa's suit"
	desc = "Festive!"
	icon_state = "santa"
	inhand_icon_state = "santa"
	slowdown = 0

/obj/item/reagent_containers/food/drinks/flask/russian
	name = "russian flask"
	desc = "Every good russian spaceman knows it's a good idea to bring along a couple of pints of whiskey wherever they go."
	icon = 'icons/obj/custom.dmi'
	icon_state = "russianflask"
	volume = 60

/obj/item/clothing/mask/gas/stalker
	name = "S.T.A.L.K.E.R. mask"
	desc = "Smells like reactor four."
	icon = 'icons/obj/custom.dmi'
	inhand_icon_state = "stalker"
	mob_overlay_icon = 'icons/mob/clothing/custom_w.dmi'
	icon_state = "stalker"

/obj/item/reagent_containers/food/drinks/flask/steel
	name = "The End"
	desc = "A plain steel flask, sealed by lock and key. The front is inscribed with The End."
	icon = 'icons/obj/custom.dmi'
	icon_state = "steelflask"
	volume = 60

/obj/item/custom/leechjar
	name = "Jar of Leeches"
	desc = "A dubious cure-all. The cork seems to be sealed fairly well, and the glass impossible to break."
	icon = 'icons/obj/custom.dmi'
	icon_state = "leechjar"
	inhand_icon_state = "leechjar"

/obj/item/clothing/neck/devilwings
	name = "Strange Wings"
	desc = "These strange wings look like they once attached to something... or someone...? Whatever the case, their presence makes you feel uneasy.."
	icon = 'icons/obj/custom.dmi'
	icon_state = "devilwings"
	mob_overlay_icon = 'modular_citadel/icons/mob/clothing/devilwings64x64.dmi'
	inhand_icon_state = "devilwings"
	worn_x_dimension = 64
	worn_y_dimension = 34

/obj/item/toy/plush/mammal/dog/fritz
	icon = 'icons/obj/custom.dmi'
	icon_state = "fritz"
	inhand_icon_state = "fritz"
	attack_verb = list("barked", "boofed", "shotgun'd")
	obj_flags = UNIQUE_RENAME
	reskinnable_component = /datum/component/reskinnable/fritz
	mutantrace_variation = NONE



