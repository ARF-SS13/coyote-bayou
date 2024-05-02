// CUSTOM RECIPES FOR FLUFF SKILL BOOK

//--
//Blood Slime Cookie:

//Health Slime Cookie:

//Time Slime Cookie:
//--

/datum/crafting_recipe/food/sunset/slimecookie/blood
	name = "Blood Cookie"
	time = 30
	reqs = list(
		/datum/reagent/blood = 5,
		/datum/reagent/iron  = 5,
		/datum/reagent/medicine/salglu_solution =5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/slime_cookie/red
	subcategory = CAT_PASTRY
	always_available = FALSE


/datum/crafting_recipe/food/sunset/slimecookie/health
	name = "Health Cookie"
	time = 30
	reqs = list(
		/datum/reagent/consumable/doctor_delight = 5,
		/datum/reagent/medicine/tricordrazine = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/slime_cookie/purple
	subcategory = CAT_PASTRY
	always_available = FALSE


/datum/crafting_recipe/food/sunset/slimecookie/time
	name = "Time Cookie"
	time = 30
	reqs = list(
		/datum/reagent/bluespace = 5,
		/obj/item/integrated_circuit/time/delay/five_sec = 1,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/slime_cookie/sepia
	subcategory = CAT_PASTRY
	always_available = FALSE
