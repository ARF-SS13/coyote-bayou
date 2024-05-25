/datum/crafting_recipe/food/moleratwondermeat
	name = "Molerat Wondermeat"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/molerat = 1
	)
	tools = list(TOOL_LUNCHBOX)
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

/datum/crafting_recipe/food/aethergiestomelette
	name = "Deathclaw Omelette"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/f13/aethergiestegg = 1,
		/obj/item/reagent_containers/food/snacks/meat/steak/aethergiest = 1,
		/obj/item/reagent_containers/food/snacks/butter =2,
		/obj/item/reagent_containers/food/snacks/grown/mutfruit = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/aethergiestomelette
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/longpork_stew
	name = "Longpork Stew"
	reqs = list(/obj/item/reagent_containers/food/snacks/meat/slab/human= 1,
				/obj/item/reagent_containers/glass/bowl = 1,
				/datum/reagent/water = 10
	)
	result = /obj/item/reagent_containers/food/snacks/soup/longpork_stew
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/moleratstew
	name = "Giant Rat Stew"
	reqs = list(
		/datum/reagent/consumable/ethanol/beer = 10,
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

// SUNSET EDIT
//// HAPPY SHARKY LOCKED FLUFF RECIPES

/datum/crafting_recipe/food/sunset/happyshark/jerky
	name = "Happy Sharky Jerky"
	time = 40
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1,
		/obj/item/reagent_containers/food/snacks/grown/coyotetobacco = 1,
		/obj/item/reagent_containers/food/snacks/grown/mesquite =1,
		/datum/reagent/consumable/sodiumchloride = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sunset/happyshark/jerky
	subcategory = CAT_MISCFOOD
	always_available = FALSE


/datum/crafting_recipe/food/sunset/happyshark/candybar
	name = "Happy Sharky Sweet Bar"
	time = 40
	reqs = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/obj/item/reagent_containers/food/snacks/grown/pinyon = 1,
		/obj/item/reagent_containers/food/snacks/grown/yucca = 2
	)
	result = /obj/item/reagent_containers/food/snacks/sunset/happyshark/candybar
	subcategory = CAT_MISCFOOD
	always_available = FALSE


/datum/crafting_recipe/food/sunset/happyshark/bittercola
	name = "Happy Sharky Bittercola"
	time = 40
	reqs = list(
		/datum/reagent/consumable/nuka_cola = 10,
		/obj/item/reagent_containers/food/snacks/grown/broc = 1,
		/obj/item/reagent_containers/food/snacks/grown/xander = 1,
		/datum/reagent/consumable/sodawater = 5,
		/datum/reagent/consumable/sugar = 5
	)
	result = /obj/item/reagent_containers/food/drinks/sunset/happyshark/bittercola
	subcategory = CAT_MISCFOOD
	always_available = FALSE

/datum/crafting_recipe/food/sunset/happyshark/bittercola/alt
	reqs = list(
		/datum/reagent/consumable/nuka_cola = 10,
		/datum/reagent/medicine/healing_powder = 10,
		/datum/reagent/consumable/sodawater = 5,
		/datum/reagent/consumable/sugar = 5
	)

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

/datum/crafting_recipe/food/broiled_death_claw
	name = "Broiled aethergiest"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/aethergiest = 1,
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/broiled_death_claw
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/fire_ant_fricassee
	name = "Fire ant fricassee"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/f13/cram = 1,
		/datum/reagent/consumable/flour = 10,
		/obj/item/reagent_containers/food/snacks/meat/steak/ant_meat = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/fire_ant_fricassee
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/fried_brahmin_skin
	name = "Fried brahmin skin"
	reqs = list(
		/obj/item/stack/sheet/animalhide/brahmin = 2,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/fried_brahmin_skin
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/molerat_manicotti
	name = "Molerat Manicotti"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/molerat = 1,
		/obj/item/reagent_containers/food/snacks/dough = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/molerat_manicotti
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/chitlins_con_carne
	name = "Chitlins con carne"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/cazador_meat = 1,
		/obj/item/crafting/wonderglue = 1,
		/datum/reagent/water = 5,
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/reagent_containers/glass/bowl = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/chitlins_con_carne
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/fried_molerat_lung
	name = "Fried molerat lung"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/molerat = 1,
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/sodiumchloride = 1,
		/datum/reagent/consumable/blackpepper = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/fried_molerat_lung
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/tato_surpise
	name = "Tato surpise"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/tato = 2,
		/obj/item/reagent_containers/food/snacks/grown/xander = 1,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/boiledegg = 1,
		/obj/item/reagent_containers/food/snacks/bun = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/tato_surpise
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/radscorpion_en_croute
	name = "radscorpion en croute"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/radscorpion_meat = 2,
		/obj/item/reagent_containers/food/snacks/dough = 1,
		/obj/item/reagent_containers/food/snacks/grown/fungus = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/radscorpion_en_croute
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/aethergiest_egg_omelette
	name = "aethergiest egg omelette"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/f13/aethergiestegg = 2,
		/obj/item/reagent_containers/food/snacks/meat/steak/aethergiest = 3,
		/obj/item/reagent_containers/food/snacks/butter = 2,
		/obj/item/reagent_containers/food/snacks/grown/mutfruit = 2,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/aethergiest_egg_omelette
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/brahminpotpie
	name = "brahmin potpie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rawbrahmintongue = 2,
		/obj/item/reagent_containers/food/snacks/grown/xander = 1,
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/brahminpotpie
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/gecko_kebab
	name = "gecko kebab"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/gecko = 1,
		/obj/item/stack/rods = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/gecko_kebab
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/baked_nightstalker_tail
	name = "Baked Nightstalker tail"
	reqs = list(
		/obj/item/clothing/head/f13/stalkerpelt = 1,
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/f13/baked_nightstalker_tail
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/imitation_cram
	name = "Imitation Cram"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/plain = 1,
		/datum/reagent/consumable/sodiumchloride = 5,
		/datum/reagent/consumable/blackpepper =5
	)
	result = /obj/item/reagent_containers/food/snacks/f13/cram
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/imitation_ss
	name = "Imitation Salisbury Steak"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/plain = 1,
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/cream =5
	)
	result = /obj/item/reagent_containers/food/snacks/f13/steak
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/imitation_bcm
	name = "Imitation BlamCo Mac and Cheese"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/spaghetti = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/datum/reagent/consumable/cream =5
	)
	result = /obj/item/reagent_containers/food/snacks/f13/blamco
	category = CAT_FOOD
	subcategory = CAT_WASTEFOOD

/datum/crafting_recipe/food/imitation_pab
	name = "Imitation Pork and Beans"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/steak/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/soybeans = 2,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 2
	)
	result = /obj/item/reagent_containers/food/snacks/f13/canned/porknbeans
	category = CAT_FOOD
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

/// Legacy Content

/*
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
