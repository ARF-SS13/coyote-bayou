/obj/item/stack/sheet/animalhide
	name = "hide"
	desc = "skin from a beast."
	icon_state = "sheet-hide"
	inhand_icon_state = "sheet-hide"
	novariants = TRUE

/obj/item/stack/sheet/animalhide/human
	name = "human skin"
	desc = "hopefully it was cut from a feral ghoul."
	icon_state = "sheet-humhide"
	singular_name = "human skin piece"
	novariants = FALSE
	merge_type = /obj/item/stack/sheet/animalhide/human

GLOBAL_LIST_INIT(human_recipes, list(
	new/datum/stack_recipe("bloated human costume", /obj/item/clothing/suit/hooded/bloated_human, 5),
	))

/obj/item/stack/sheet/animalhide/human/get_main_recipes()
	. = ..()
	. += GLOB.human_recipes

/obj/item/stack/sheet/animalhide/generic
	name = "skin"
	desc = "A piece of skin."
	singular_name = "skin piece"
	novariants = FALSE
	merge_type = /obj/item/stack/sheet/animalhide/generic

/obj/item/stack/sheet/animalhide/corgi
	name = "corgi hide"
	desc = "The by-product of corgi farming."
	singular_name = "corgi hide piece"
	icon_state = "sheet-corgi"
	inhand_icon_state = "sheet-corgi"
	merge_type = /obj/item/stack/sheet/animalhide/corgi


GLOBAL_LIST_INIT(gondola_recipes, list (
	new/datum/stack_recipe("gondola mask", /obj/item/clothing/mask/gondola, 1),
	new/datum/stack_recipe("gondola suit", /obj/item/clothing/under/costume/gondola, 2),
	new/datum/stack_recipe("gondola bedsheet", /obj/item/bedsheet/gondola, 1),
	))

/obj/item/stack/sheet/animalhide/gondola
	name = "gondola hide"
	desc = "The extremely valuable product of gondola hunting."
	singular_name = "gondola hide piece"
	icon_state = "sheet-gondola"
	inhand_icon_state = "sheet-gondola"
	merge_type = /obj/item/stack/sheet/animalhide/gondola

/obj/item/stack/sheet/animalhide/gondola/get_main_recipes()
	. = ..()
	. += GLOB.gondola_recipes

GLOBAL_LIST_INIT(corgi_recipes, list (
	new/datum/stack_recipe("corgi costume", /obj/item/clothing/suit/hooded/ian_costume, 3),
	))

/obj/item/stack/sheet/animalhide/corgi/get_main_recipes()
	. = ..()
	. += GLOB.corgi_recipes

/obj/item/stack/sheet/animalhide/cat
	name = "cat hide"
	desc = "The by-product of cat farming."
	singular_name = "cat hide piece"
	icon_state = "sheet-cat"
	inhand_icon_state = "sheet-cat"
	merge_type = /obj/item/stack/sheet/animalhide/cat

/obj/item/stack/sheet/animalhide/monkey
	name = "monkey hide"
	desc = "The by-product of monkey farming."
	singular_name = "monkey hide piece"
	icon_state = "sheet-monkey"
	merge_type = /obj/item/stack/sheet/animalhide/monkey

GLOBAL_LIST_INIT(monkey_recipes, list (
	new/datum/stack_recipe("monkey mask", /obj/item/clothing/mask/gas/monkeymask, 1),
	new/datum/stack_recipe("monkey suit", /obj/item/clothing/suit/monkeysuit, 2),
	))

/obj/item/stack/sheet/animalhide/monkey/get_main_recipes()
	. = ..()
	. += GLOB.monkey_recipes

/obj/item/stack/sheet/animalhide/lizard
	name = "lizard skin"
	desc = "Sssssss..."
	singular_name = "lizard skin piece"
	icon_state = "sheet-lizard"
	inhand_icon_state = "sheet-lizard"
	merge_type = /obj/item/stack/sheet/animalhide/lizard

/obj/item/stack/sheet/animalhide/xeno
	name = "alien hide"
	desc = "The skin of a terrible creature."
	singular_name = "alien hide piece"
	icon_state = "sheet-xeno"
	inhand_icon_state = "sheet-xeno"
	merge_type = /obj/item/stack/sheet/animalhide/xeno

GLOBAL_LIST_INIT(xeno_recipes, list (
	new/datum/stack_recipe("alien helmet", /obj/item/clothing/head/xenos, 1),
	new/datum/stack_recipe("alien suit", /obj/item/clothing/suit/xenos, 2),
	))

/obj/item/stack/sheet/animalhide/xeno/get_main_recipes()
	. = ..()
	. += GLOB.xeno_recipes

//don't see anywhere else to put these, maybe together they could be used to make the xenos suit?
/obj/item/stack/sheet/xenochitin
	name = "alien chitin"
	desc = "A piece of the hide of a terrible creature."
	singular_name = "alien hide piece"
	icon = 'icons/mob/alien.dmi'
	icon_state = "chitin"
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/xenochitin

/obj/item/xenos_claw
	name = "alien claw"
	desc = "The claw of a terrible creature."
	icon = 'icons/mob/alien.dmi'
	icon_state = "claw"

/obj/item/weed_extract
	name = "weed extract"
	desc = "A piece of slimy, purplish weed."
	icon = 'icons/mob/alien.dmi'
	icon_state = "weed_extract"

/obj/item/stack/sheet/hairlesshide
	name = "hairless hide"
	desc = "This hide was stripped of its hair, but still needs washing and tanning."
	singular_name = "hairless hide piece"
	icon_state = "sheet-hairlesshide"
	inhand_icon_state = "sheet-hairlesshide"
	merge_type = /obj/item/stack/sheet/hairlesshide

/obj/item/stack/sheet/wetleather
	name = "wet leather"
	desc = "This leather has been cleaned but still needs to be dried."
	singular_name = "wet leather piece"
	icon_state = "sheet-wetleather"
	inhand_icon_state = "sheet-wetleather"
	var/wetness = 30 //Reduced when exposed to high temperautres
	var/drying_threshold_temperature = 500 //Kelvin to start drying
	merge_type = /obj/item/stack/sheet/wetleather

/*
 * Leather Sheet
 */
/obj/item/stack/sheet/leather
	name = "leather"
	desc = "The by-product of mob grinding."
	singular_name = "leather piece"
	icon_state = "sheet-leather"
	inhand_icon_state = "sheet-leather"
	custom_materials = list(/datum/material/leather=MINERAL_MATERIAL_AMOUNT) //mineral_material_amount is used for cargo compatability
	merge_type = /obj/item/stack/sheet/leather

GLOBAL_LIST_INIT(leather_recipes, list (
	new/datum/stack_recipe("farmers gloves", /obj/item/clothing/gloves/botanic_leather, 3),
	new/datum/stack_recipe("gardeners belt", /obj/item/storage/belt/utility/gardener, 4),
	null,
	new/datum/stack_recipe("toolbelt", /obj/item/storage/belt/utility, 4),
	new/datum/stack_recipe("leather satchel", /obj/item/storage/backpack/satchel/leather, 5),
	new/datum/stack_recipe("wallet", /obj/item/storage/wallet, 1),
	null,
	new/datum/stack_recipe("cowboy hat", /obj/item/clothing/head/f13/cowboy, 3),
	new/datum/stack_recipe("rustic cowboy hat", /obj/item/clothing/head/helmet/f13/brahmincowboyhat, 3),
	null,
	new/datum/stack_recipe("leather jacket", /obj/item/clothing/suit/jacket/leather, 7),
	new/datum/stack_recipe("leather mantle", /obj/item/clothing/suit/armor/outfit/jacket/mantle, 7),
	new/datum/stack_recipe("leather shoes", /obj/item/clothing/shoes/laceup, 2),
	new/datum/stack_recipe("leather overcoat", /obj/item/clothing/suit/jacket/leather/overcoat, 10),
	new/datum/stack_recipe("leather cloak", /obj/item/clothing/suit/hooded/cloak/desert, 3),
	null,
	new/datum/stack_recipe("survival pouch", /obj/item/storage/survivalkit/empty, 5),
	new/datum/stack_recipe("rugged pouch", /obj/item/storage/survivalkit/outlaw/empty, 5),
	new/datum/stack_recipe("tribal pouch", /obj/item/storage/survivalkit/tribal/empty, 5),
	new/datum/stack_recipe("medical pouch", /obj/item/storage/survivalkit/medical/empty, 5),
	new/datum/stack_recipe("combat pouch", /obj/item/storage/survivalkit/combat, 5),
	new/datum/stack_recipe("tribal medicine pouch", /obj/item/storage/survivalkit/medical/tribal/empty, 5),
	new/datum/stack_recipe("extra large pouch", /obj/item/storage/survivalkit/triple, 25),
	new/datum/stack_recipe("sack", /obj/item/storage/bag/trash/sack, 15),
	null, 
	new /datum/stack_recipe("leather waterskin", /obj/item/reagent_containers/glass/waterskin, 10, time = 30, one_per_turf = FALSE, on_floor = TRUE), 
))

/obj/item/stack/sheet/leather/get_main_recipes()
	. = ..()
	. += GLOB.leather_recipes

/obj/item/stack/sheet/leather/five
	amount = 5

/obj/item/stack/sheet/leather/ten
	amount = 10

/obj/item/stack/sheet/leather/twenty
	amount = 20

/*
 * Sinew
 */
/obj/item/stack/sheet/sinew
	name = "sinew"
	icon = 'icons/obj/mining.dmi'
	desc = "Long stringy filaments, presumably from some kind of animal."
	singular_name = "sinew"
	icon_state = "sinew"
	custom_materials = list(/datum/material/sinew=MINERAL_MATERIAL_AMOUNT)
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/sinew

GLOBAL_LIST_INIT(sinew_recipes, list (
	new/datum/stack_recipe("sinew restraints", /obj/item/restraints/handcuffs/sinew, 1),
))

/obj/item/stack/sheet/sinew/get_main_recipes()
	. = ..()
	. += GLOB.sinew_recipes

		/*
 * Plates
 */

/obj/item/stack/sheet/animalhide/goliath_hide
	name = "goliath hide plates"
	desc = "Pieces of a goliath's rocky hide, these might be able to make your suit a bit more durable to attack from the local fauna."
	icon = 'icons/obj/mining.dmi'
	icon_state = "goliath_hide"
	singular_name = "hide plate"
	max_amount = 6
	novariants = FALSE
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_NORMAL
	layer = MOB_LAYER
	merge_type = /obj/item/stack/sheet/animalhide/goliath_hide

/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide
	name = "polar bear hides"
	desc = "Pieces of a polar bear's fur, these might be able to make your suit a bit more durable to attack from the local fauna."
	icon_state = "polar_bear_hide"
	singular_name = "polar bear hide"
	merge_type = /obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide

/obj/item/stack/sheet/animalhide/chitin
	name = "insect chitin"
	desc = "Thick insect chitin, tough but light."
	singular_name = "piece of insect chitin"
	icon_state = "sheet-chitin"
	custom_materials = list(/datum/material/chitin=MINERAL_MATERIAL_AMOUNT)
	grind_results = list(/datum/reagent/sodium = 3, /datum/reagent/chlorine = 3)
	merge_type = /obj/item/stack/sheet/animalhide/chitin

/obj/item/stack/sheet/animalhide/ashdrake
	name = "ash drake hide"
	desc = "The strong, scaled hide of an ash drake."
	icon = 'icons/obj/mining.dmi'
	icon_state = "dragon_hide"
	singular_name = "drake plate"
	max_amount = 10
	novariants = FALSE
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_NORMAL
	layer = MOB_LAYER
	merge_type = /obj/item/stack/sheet/animalhide/ashdrake


//////////////////////////////////
//								//
//		LEATHER PROCESSING		//
//								//
//////////////////////////////////

// CURING HIDES TO LEATHER
//Step one - dehairing.

/obj/item/stack/sheet/animalhide/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		playsound(loc, 'sound/weapons/slice.ogg', 50, 1, -1)
		user.visible_message("[user] starts cutting hair off the [src].", span_notice("You start cutting the hair off the [src]..."), span_italic("You hear the sound of a knife rubbing against flesh."))
		if(do_after(user, 50, target = src))
			to_chat(user, span_notice("You cut the hair from this [src.singular_name]."))
			new /obj/item/stack/sheet/hairlesshide(user.drop_location(), 1)
			use(1)
	else
		return ..()


//Step two - washing..... it's actually in washing machine code.

//Step three - drying
/obj/item/stack/sheet/wetleather/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	..()
	if(exposed_temperature >= drying_threshold_temperature)
		wetness--
		if(wetness == 0)
			new /obj/item/stack/sheet/leather(drop_location(), 1)
			wetness = initial(wetness)
			use(1)

/obj/item/stack/sheet/wetleather/microwave_act(obj/machinery/microwave/MW)
	..()
	new /obj/item/stack/sheet/leather(drop_location(), amount)
	qdel(src)

// CUTTING LEATHER INTO STRIPS (for further crafting)
/obj/item/stack/sheet/leather/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		playsound(loc, 'sound/weapons/slice.ogg', 50, 1, -1)
		user.visible_message("[user] starts shredding the [src] into strips.", span_notice("You start shredding the [src] into strips"), span_italic("You hear the sound of leather being ripped."))
		if(do_after(user, 50, target = src))
			to_chat(user, span_notice("You cut strips from this [src.singular_name]."))
			new /obj/item/stack/sheet/leatherstrips(user.drop_location(), 1)
			use(1)
	else
		return ..()

/obj/item/stack/sheet/leatherstrips
	name = "leather strips"
	desc = "long leather strips that can be used for crafting various things."
	singular_name = "strip of leather"
	icon_state = "leather-strip"
	inhand_icon_state = "sheet-leather"
	merge_type = /obj/item/stack/sheet/leatherstrips

GLOBAL_LIST_INIT(leatherstrips_recipes, list (
	new/datum/stack_recipe("gear harness", /obj/item/clothing/under/misc/gear_harness, 2, time = 40),
	new/datum/stack_recipe("slave labor outfit", /obj/item/clothing/suit/armor/outfit/slavelabor, 2, time = 50), 
	new/datum/stack_recipe("jabroni outfit", /obj/item/clothing/under/jabroni, 4, time = 80),
	new/datum/stack_recipe("muzzle", /obj/item/clothing/mask/muzzle, 2, time = 40), 
	new/datum/stack_recipe("pet collar", /obj/item/clothing/neck/petcollar, 2, time = 40),
	new/datum/stack_recipe("secondary gear harness", /obj/item/clothing/suit/chameleon/harness/second_gear_harness, 4, time = 40), //From here on, this is all so people can have their snowflake loadout drip incase it gets burnt in a fire or w\e
	new/datum/stack_recipe("light harness", /obj/item/clothing/suit/chameleon/harness, 6, time = 40), 
	new/datum/stack_recipe("medium harness", /obj/item/clothing/suit/chameleon/harness/medium, 10, time = 40),
	new/datum/stack_recipe("heavy harness", /obj/item/clothing/suit/chameleon/harness/heavy, 12, time = 40),
))

/obj/item/stack/sheet/leatherstrips/get_main_recipes()
	. = ..()
	. += GLOB.leatherstrips_recipes
