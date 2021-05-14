/datum/crafting_recipe/food/moleratwondermeat
	name = "Molerat Wondermeat"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/molerat = 1,
		/obj/item/crafting/wonderglue = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/molejerky
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/caravanlunch
	name = "Caravan Lunch"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/f13/instamash = 1,
		/obj/item/reagent_containers/food/snacks/f13/cram = 1,
		/obj/item/reagent_containers/food/snacks/f13/canned/porknbeans = 1,
		/obj/item/crafting/lunchbox = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/caravanlunch
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/wastelandwellington
	name = "Wasteland Wellington"
	reqs = list(
		/datum/reagent/consumable/flour = 10,
		/obj/item/reagent_containers/food/snacks/f13/blamco = 1,
		/obj/item/reagent_containers/food/snacks/meat/steak = 2
	)
	result = /obj/item/reagent_containers/food/snacks/f13/wastelandwellington
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/deathclawomelette
	name = "Deathclaw Omelette"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/f13/deathclawegg = 1,
		/obj/item/reagent_containers/food/snacks/meat/steak/deathclaw = 1,
		/obj/item/reagent_containers/food/snacks/butter =2,
		/obj/item/reagent_containers/food/snacks/grown/mutfruit = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/deathclawomelette
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/moleratstew
	name = "Molerat Stew"
	reqs = list(
		/obj/item/reagent_containers/food/drinks/beer = 1,
		/obj/item/reagent_containers/food/snacks/meat/slab/molerat = 1,
		/obj/item/reagent_containers/food/snacks/grown/corn = 1,
		/obj/item/reagent_containers/food/snacks/grown/soybeans = 1,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/moleratstew
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/crispysquirrel
	name = "Crispy Squirrel Bits"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/squirrel = 1,
		/obj/item/stack/rods = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/crispysquirrel
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/squirrelstick
	name = "Squirrel on a Stick"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/squirrel = 2,
		/obj/item/stack/rods = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/squirrelstick
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/squirrelstew
	name = "Squirrel Stew"
	reqs = list(
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/food/snacks/meat/steak/squirrel = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/squirrelstew
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/gourdsoup
	name = "Buffalo Gourd Soup"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/buffalogourd = 1,
		/datum/reagent/consumable/milk = 5
	)
	result = /obj/item/reagent_containers/food/snacks/soup/buffalogourd
	subcategory = CAT_WASTEFOOD

/* awaiting assets + code for completion

/datum/crafting_recipe/food/pemmican
	name = "Pemmican"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/corn = 1,
		/obj/item/reagent_containers/food/snacks/sosjerky/healthy = 2,
		/obj/item/reagent_containers/food/snacks/tallow = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pemmican
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/crunchymutfruit
	name = "Crunchy Mutfruit"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/mutfruit = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1,
		/datum/reagent/consumable/sugar = 5
	)
	result = /obj/item/reagent_containers/food/snacks/crunchymutfruit
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/tatofries
	name = "Tato fries"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/tato = 2,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/tatofries
	subcategory = CAT_WASTEFOOD
*/

/datum/crafting_recipe/food/mirelurkstew
	name = "Mirelurk Stew"
	reqs = list(
		/datum/reagent/water = 30,
		/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 2,
		/obj/item/reagent_containers/food/snacks/butter = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/datum/reagent/consumable/milk = 5,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/mirelurkstew
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/mirelurkcake
	name = "Mirelurk Cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 1,
		/datum/reagent/consumable/flour = 15,
		/obj/item/reagent_containers/food/snacks/egg = 2,
		/datum/reagent/consumable/sodiumchloride = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/mirelurkcake
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/ruby_casserole
	name = "Ruby's Radscorpion Casserole"
	reqs = list(
		/datum/reagent/water = 30,
		/obj/item/reagent_containers/food/snacks/meat/slab/radscorpion_meat = 2,
		/obj/item/reagent_containers/food/snacks/grown/chili = 2,
		/obj/item/reagent_containers/food/snacks/meat/slab/molerat = 1,
		/datum/reagent/consumable/milk = 5,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/rubycasserole
	subcategory = CAT_WASTEFOOD

/////////////////
//Sewer Food.  //
/////////////////

/datum/crafting_recipe/food/humankebab
	name = "Human kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/reagent_containers/food/snacks/meat/steak/plain/human = 2
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/human
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/ratkebab
	name = "Rat Kebab"
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/reagent_containers/food/snacks/deadmouse = 1
	)
	result = /obj/item/reagent_containers/food/snacks/kebab/rat
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/ratburger
	name = "Rat burger"
	reqs = list(
			/obj/item/reagent_containers/food/snacks/deadmouse = 1,
			/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/burger/rat
	subcategory = CAT_WASTEFOOD