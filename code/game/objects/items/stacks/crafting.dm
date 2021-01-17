/obj/item/stack/crafting
	 "crafting part"
	 'icons/fallout/objects/items.dmi'
	 = 1
	ount = 50
	speed = 3
	range = 7
	s = WEIGHT_CLASS_TINY
	ants = TRUE

/obj/item/stack/crafting/metalparts
	 "metal parts"
	tate = "sheet-metalparts"
	ar_name = "metal part"
	_materials = list(/datum/material/iron = 20000)
	1 = CONDUCT_1

/obj/item/stack/crafting/metalparts/three
	 = 3

/obj/item/stack/crafting/metalparts/five
	 = 5

/obj/item/stack/crafting/goodparts
	 "high quality metal parts"
	tate = "sheet-goodparts"
	ar_name = "high quality metal part"
	_materials = list(/datum/material/iron = 20000)
	1 = CONDUCT_1

/obj/item/stack/crafting/goodparts/three
	 = 3

/obj/item/stack/crafting/goodparts/five
	 = 5

/obj/item/stack/crafting/electronicparts
	 "electronic parts"
	tate = "sheet-electronicparts"
	ar_name = "electronic part"
	_materials = list(/datum/material/glass = 20000)
	1 = CONDUCT_1

/obj/item/stack/crafting/electronicparts/three
	 = 3

/obj/item/stack/crafting/electronicparts/five
	 = 5

/obj/item/stack/crafting/powder
	name = "bullet remnants"
	desc = "A pouch containing some scoops of blackpowder and empty shell casings."
	icon_state = "sheet-powder"
	singular_name = "bullet remnant"
	max_amount = 60
	full_w_class = WEIGHT_CLASS_SMALL

GLOBAL_LIST_INIT(powder_recipes, list ( \
	new/datum/stack_recipe("scavenge blackpowder", /obj/item/reagent_containers/glass/bottle/blackpowder, 60), \
	new/datum/stack_recipe("salvage metal from casings", /obj/item/stack/sheet/metal, 30), \
))

/obj/item/stack/crafting/powder/Initialize(mapload, new_amount, merge = TRUE)
	recipes = GLOB.powder_recipes
	return ..()
