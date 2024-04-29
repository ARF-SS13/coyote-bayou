
// see code/module/crafting/table.dm

////////////////////////////////////////////////SPAGHETTI////////////////////////////////////////////////

/datum/crafting_recipe/food/copypasta
	name = "Copypasta"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastatomato = 2
	)
	result = /obj/item/reagent_containers/food/snacks/copypasta
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/spaghettimeatball
	name = "Spaghetti meatball"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/boiledspaghetti = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 2
	)
	result = /obj/item/reagent_containers/food/snacks/meatballspaghetti
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/spesslaw
	name = "Spesslaw"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/boiledspaghetti = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 4
	)
	result = /obj/item/reagent_containers/food/snacks/spesslaw
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/tomatopasta
	name = "Tomato pasta"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/boiledspaghetti = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 2
	)
	result = /obj/item/reagent_containers/food/snacks/pastatomato
	subcategory = CAT_SPAGHETTI

////////////NOODLES///////////

/datum/crafting_recipe/food/beefnoodle
	name = "Beef noodle"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/boiledspaghetti = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1
	)
	result = /obj/item/reagent_containers/food/snacks/beefnoodle
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/chowmein
	name = "Chowmein"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/boiledspaghetti = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 2,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1
	)
	result = /obj/item/reagent_containers/food/snacks/chowmein
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/butternoodles
	name = "Butter Noodles"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/boiledspaghetti = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/butternoodles
	subcategory = CAT_SPAGHETTI

////////////PIZZA///////////

/datum/crafting_recipe/food/pineapplepizza
	name = "Hawaiian pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2,
		/obj/item/reagent_containers/food/snacks/pineappleslice = 3,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/pineapple
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/margheritapizza
	name = "Cheese pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 4,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/margherita
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/meatpizza
	name = "Meat pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 4,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/meat
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/mushroompizza
	name = "Mushroom pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom = 5
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/mushroom
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/sassysagepizza
	name = "Meatball pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 3,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/sassysage
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/vegetablepizza
	name = "Vegetable pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/corn = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/vegetable
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/mothic_firecracker
	name = "Fire Cracker Pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 4,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/mothic_firecracker
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/mothic_five_cheese
	name = "Five Cheese Pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 4,
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/mothic_five_cheese
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/mothic_white_pie
	name = "White Pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/mothic_white_pie
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/mothic_pesto
	name = "Pesto Pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/mothic_pesto
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/mothic_garlic
	name = "Garlic Pizza"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pizzabread = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 2,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pizza/mothic_garlic
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/meatcalzone
	name = "Meat Calzone"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/doughslice = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1
	)
	result = /obj/item/reagent_containers/food/snacks/meatcalzone
	subcategory = CAT_SPAGHETTI

/datum/crafting_recipe/food/veggiecalzone
	name = "Vegetrian Calzone"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/doughslice = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/chanterelle = 1
	)
	result = /obj/item/reagent_containers/food/snacks/vegetariancalzone
	subcategory = CAT_SPAGHETTI
