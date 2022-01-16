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


////////////////////////////////////////////////CAKES////////////////////////////////////////////////

/datum/crafting_recipe/food/dessert/applecake
	name = "Apple cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/apple

/datum/crafting_recipe/food/dessert/bscccake
	name = "Blackberry and strawberry chocolate cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 2,
		/obj/item/reagent_containers/food/snacks/grown/berries = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/bscc

/datum/crafting_recipe/food/dessert/limecake
	name = "Lime cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/citrus/lime = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/lime

/datum/crafting_recipe/food/dessert/peachcake
	name = "Peach cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/peach = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/peach_cake

/datum/crafting_recipe/food/dessert/birthdaycake
	name = "Birthday cake"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/caramel =2,
		/obj/item/candle = 1,
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/birthday

/datum/crafting_recipe/food/dessert/briochecake
	name = "Brioche cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/datum/reagent/consumable/sugar = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/brioche

/datum/crafting_recipe/food/dessert/carrotcake
	name = "Carrot cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/carrot

/datum/crafting_recipe/food/dessert/cheesecake
	name = "Cheese cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/cheese

/datum/crafting_recipe/food/dessert/chocolatecake
	name = "Chocolate cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/chocolate

/datum/crafting_recipe/food/dessert/pumpkinspicecake
	name = "Pumpkin spice cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/pumpkin = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/pumpkinspice

/datum/crafting_recipe/food/dessert/vanillacake
	name = "Vanilla cake"
	always_available = FALSE
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/vanillapod = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/vanilla_cake


////////////////////////////////////////////////MUFFINS////////////////////////////////////////////////

/datum/crafting_recipe/food/dessert/muffin
	time = 15
	name = "Muffin"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/muffin

/datum/crafting_recipe/food/dessert/berrymuffin
	name = "Berry muffin"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries = 1
	)
	result = /obj/item/reagent_containers/food/snacks/muffin/berry
/datum/crafting_recipe/food/dessert/poppymuffin

	name = "Poppy muffin"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/reagent_containers/food/snacks/grown/citrus/lemon = 1,
		/obj/item/seeds/poppy = 1
	)
	result = /obj/item/reagent_containers/food/snacks/muffin/poppy

////////////////////////////////////////////CUPCAKES////////////////////////////////////////////

/datum/crafting_recipe/food/dessert/bluecherrycupcake
	name = "Blue cherry cupcake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/reagent_containers/food/snacks/grown/bluecherries = 1
	)
	result = /obj/item/reagent_containers/food/snacks/bluecherrycupcake

/datum/crafting_recipe/food/dessert/strawberrycupcake
	name = "Strawberry cherry cupcake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/reagent_containers/food/snacks/grown/strawberry  = 1
	)
	result = /obj/item/reagent_containers/food/snacks/strawberrycupcake

////////////////////////////////////////////COOKIES////////////////////////////////////////////

/datum/crafting_recipe/food/dessert/raisincookie
	name = "Raisin cookie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/no_raisin = 1,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/reagent_containers/food/snacks/grown/oat = 1
	)
	result = /obj/item/reagent_containers/food/snacks/raisincookie

/datum/crafting_recipe/food/dessert/sugarcookie
	time = 15
	name = "Sugar cookie"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sugarcookie

////////////////////////////////////////////////WAFFLES AND PANCAKES////////////////////////////////////////////////

/datum/crafting_recipe/food/dessert/waffles
	time = 15
	name = "Waffles"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastrybase = 2
	)
	result = /obj/item/reagent_containers/food/snacks/waffles

/datum/crafting_recipe/food/dessert/pancakes
	name = "Pancake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pancakes

/datum/crafting_recipe/food/dessert/bbpancakes
	name = "Blueberry pancake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pancakes/blueberry

/datum/crafting_recipe/food/dessert/ccpancakes
	name = "Chocolate chip pancake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pancakes/chocolatechip

////////////////////////////////////////////OTHER////////////////////////////////////////////

/datum/crafting_recipe/food/dessert/cracker
	time = 15
	name = "Cracker"
	reqs = list(
		/datum/reagent/consumable/sodiumchloride = 1,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/cracker

/datum/crafting_recipe/food/dessert/fortunecookie
	time = 15
	name = "Fortune cookie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/paper = 1
	)
	parts =	list(
		/obj/item/paper = 1
	)
	result = /obj/item/reagent_containers/food/snacks/fortunecookie

/datum/crafting_recipe/food/dessert/honeybun
	name = "Honey bun"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/reagent_containers/food/snacks/honeybun

/datum/crafting_recipe/food/dessert/hotcrossbun
	name = "Hot-Cross Bun"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/bread/plain = 1,
		/datum/reagent/consumable/sugar = 1
	)
	result = /obj/item/reagent_containers/food/snacks/hotcrossbun

/datum/crafting_recipe/food/dessert/poppypretzel
	time = 15
	name = "Poppy pretzel"
	reqs = list(
		/obj/item/seeds/poppy = 1,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/poppypretzel

/datum/crafting_recipe/food/dessert/plumphelmetbiscuit
	time = 15
	name = "Plumphelmet biscuit"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/plumphelmet = 1
	)
	result = /obj/item/reagent_containers/food/snacks/plumphelmetbiscuit
