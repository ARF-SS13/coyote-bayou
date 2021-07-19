
// see code/module/crafting/table.dm

////////////////////////////////////////////////PIES////////////////////////////////////////////////



/datum/crafting_recipe/food/meatpie
	name = "Meat pie"
	reqs = list(
		/datum/reagent/consumable/blackpepper = 1,
		/datum/reagent/consumable/sodiumchloride = 1,
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/meat/steak/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/meatpie
	subcategory = CAT_PIE

/datum/crafting_recipe/food/burek
	name = "Burek"
	reqs = list(
		/datum/reagent/consumable/blackpepper = 3,
		/datum/reagent/consumable/sodiumchloride = 3,
		/obj/item/reagent_containers/food/snacks/pizzabread = 2,
		/obj/item/reagent_containers/food/snacks/meat/cutlet/plain = 6,
		/obj/item/reagent_containers/food/snacks/butter = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/pie/burek
	subcategory = CAT_PIE

/* requires code
/datum/crafting_recipe/food/brahminpotpie
	name = "Brahmin potpie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/rawbrahmintongue = 2,
		/obj/item/reagent_containers/food/snacks/grown/xander = 1,
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/brahminpotpie
	subcategory = CAT_PIE
*/

////////////////////////////////////////////SWEETS////////////////////////////////////////////



/datum/crafting_recipe/food/bananacreampie
	name = "Banana cream pie"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/banana = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/cream
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/berryclafoutis
	name = "Berry clafoutis"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/berryclafoutis
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/cherrypie
	name = "Cherry pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/cherries = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/cherrypie
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/candiedapple
	name = "Candied apple"
	reqs = list(/datum/reagent/water = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1
	)
	result = /obj/item/reagent_containers/food/snacks/candiedapple
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/chocolatestrawberry
	name = "Chocolate Strawberry"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/obj/item/reagent_containers/food/snacks/grown/strawberry  = 1
	)
	result = /obj/item/reagent_containers/food/snacks/chocolatestrawberry
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/plumppie
	name = "Plump pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/plumphelmet = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/plump_pie
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/applepie
	name = "Apple pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/applepie
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/pumpkinpie
	name = "Pumpkin pie"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/pumpkin = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/pumpkinpie
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/grapetart
	name = "Grape tart"
	reqs = list(
			/datum/reagent/consumable/milk = 5,
			/datum/reagent/consumable/sugar = 5,
			/obj/item/reagent_containers/food/snacks/pie/plain = 1,
			/obj/item/reagent_containers/food/snacks/grown/grapes = 3
			)
	result = /obj/item/reagent_containers/food/snacks/pie/grapetart
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/blumpkinpie
	name = "Blumpkin pie"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/blumpkin = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/blumpkinpie
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/honeybar
	name = "Honey nut bar"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/oat = 1,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/reagent_containers/food/snacks/honeybar
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/dulcedebatata
	name = "Dulce de batata"
	reqs = list(
		/datum/reagent/consumable/vanilla = 5,
		/datum/reagent/water = 5,
		/obj/item/reagent_containers/food/snacks/grown/potato/sweet = 2
	)
	result = /obj/item/reagent_containers/food/snacks/pie/dulcedebatata
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/frostypie
	name = "Frosty pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/bluecherries = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/frostypie
	subcategory = CAT_PASTRY

/*
/datum/crafting_recipe/food/goldenappletart
	name = "Golden apple tart"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple/gold = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/appletart
	subcategory = CAT_PIE

	/datum/crafting_recipe/food/bearypie
	name = "Beary Pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries = 1,
		/obj/item/reagent_containers/food/snacks/meat/steak/bear = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/bearypie
	subcategory = CAT_PIE

/datum/crafting_recipe/food/amanitapie
	name = "Amanita pie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pie/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/amanita = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pie/amanita_pie
	subcategory = CAT_PIE
*/
