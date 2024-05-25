// see code/module/crafting/table.dm

////////////////////////////////////////////////DONUTS////////////////////////////////////////////////

/datum/crafting_recipe/food/donut
	time = 15
	name = "Donut"
	reqs = list(
		/datum/reagent/consumable/sugar = 1,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/plain
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/donut/jelly
	name = "Jelly donut"
	reqs = list(
		/datum/reagent/consumable/berryjuice = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/plain

/datum/crafting_recipe/food/donut/glaze
	time = 15
	name = "glaze donut"
	reqs = list(
				/datum/reagent/consumable/sugar = 10,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/glaze

/datum/crafting_recipe/food/donut/berry
	name = "Berry Donut"
	reqs = list(
		/datum/reagent/consumable/berryjuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/berry

/datum/crafting_recipe/food/donut/apple
	name = "Apple Donut"
	reqs = list(
		/datum/reagent/consumable/applejuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/apple

/datum/crafting_recipe/food/donut/caramel
	name = "Caramel Donut"
	reqs = list(
		/datum/reagent/consumable/caramel = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/caramel

/datum/crafting_recipe/food/donut/choco
	name = "Chocolate Donut"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/choco

/datum/crafting_recipe/food/donut/blumpkin
	name = "Blumpkin Donut"
	reqs = list(
		/datum/reagent/consumable/blumpkinjuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/blumpkin

/datum/crafting_recipe/food/donut/bungo
	name = "Bungo Donut"
	reqs = list(
		/datum/reagent/consumable/bungojuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/bungo

/datum/crafting_recipe/food/donut/matcha
	name = "Matcha Donut"
	reqs = list(
		/datum/reagent/toxin/teapowder = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/matcha


/datum/crafting_recipe/food/donut/laugh
	name = "Sweet Pea Donut"
	reqs = list(
		/datum/reagent/consumable/laughsyrup = 3,
		/obj/item/reagent_containers/food/snacks/donut/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/laugh

///JELLY DONUTS

/datum/crafting_recipe/food/donut/jelly/apple
	name = "Apple Jelly Donut"
	reqs = list(
		/datum/reagent/consumable/applejuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/apple

/datum/crafting_recipe/food/donut/jelly/berry
	name = "Berry Jelly Donut"
	reqs = list(
		/datum/reagent/consumable/berryjuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/berry

/datum/crafting_recipe/food/donut/jelly/blumpkin
	name = "Blumpkin Jelly Donut"
	reqs = list(
		/datum/reagent/consumable/blumpkinjuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/blumpkin

/datum/crafting_recipe/food/donut/jelly/bungo
	name = "Bungo Jelly Donut"
	reqs = list(
		/datum/reagent/consumable/bungojuice = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/bungo

/datum/crafting_recipe/food/donut/jelly/caramel
	name = "Caramel Jelly Donut"
	reqs = list(
		/datum/reagent/consumable/caramel = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/caramel

/datum/crafting_recipe/food/donut/jelly/choco
	name = "Chocolate Jelly Donut"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/choco

/datum/crafting_recipe/food/donut/jelly/matcha
	name = "Matcha Jelly Donut"
	reqs = list(
		/datum/reagent/toxin/teapowder = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/matcha

/datum/crafting_recipe/food/donut/jelly/trumpet
	name = "Spaceman's Jelly Donut"
	reqs = list(
		/datum/reagent/medicine/polypyr = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/trumpet

/datum/crafting_recipe/food/donut/jelly/laugh
	name = "Sweet Pea Jelly Donut"
	reqs = list(
		/datum/reagent/consumable/laughsyrup = 3,
		/obj/item/reagent_containers/food/snacks/donut/jelly/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/donut/jelly/laugh

//ICECREAM STUFF//

/datum/crafting_recipe/food/dessert
	time = 20
	subcategory = CAT_PASTRY

/datum/crafting_recipe/food/dessert/bluecherryshake
	name = "Blue Cherry Milkshake"
	always_available = FALSE
	reqs = list(
		/obj/item/reagent_containers/food/snacks/icecream = 1,
		/obj/item/reagent_containers/food/snacks/grown/bluecherries = 3,
		/obj/item/reagent_containers/food/drinks/drinkingglass = 1
	)
	result = /obj/item/reagent_containers/food/snacks/bluecharrie_float

/datum/crafting_recipe/food/dessert/cherryshake
	name = "Cherry Milkshake"
	always_available = FALSE
	reqs = list(
		/obj/item/reagent_containers/food/snacks/icecream = 1,
		/obj/item/reagent_containers/food/snacks/grown/cherries = 3,
		/obj/item/reagent_containers/food/drinks/drinkingglass = 1
	)
	result = /obj/item/reagent_containers/food/snacks/charrie_float

/datum/crafting_recipe/food/dessert/sundae
	name ="Sundae"
	reqs = list(
		/datum/reagent/consumable/cream = 5,
		/obj/item/reagent_containers/food/snacks/grown/cherries = 1,
		/obj/item/reagent_containers/food/snacks/grown/banana = 1,
		/obj/item/reagent_containers/food/snacks/icecream = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sundae


////////////////////////////////////////////OTHER////////////////////////////////////////////

/datum/crafting_recipe/food/dessert/mothmallow
	name = "mothmallow tray"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 4,
		/datum/reagent/consumable/sugar = 150,
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/mothmallow
