
// see code/module/crafting/table.dm

//////////////////Eastern Foods//////////////////////

/datum/crafting_recipe/food/chawanmushi
	name = "Chawanmushi"
	reqs = list(
		/datum/reagent/water = 5,
		/datum/reagent/consumable/soysauce = 5,
		/obj/item/reagent_containers/food/snacks/boiledegg = 2,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/chanterelle = 1
	)
	result = /obj/item/reagent_containers/food/snacks/chawanmushi
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/khachapuri
	name = "Khachapuri"
	reqs = list(
		/datum/reagent/consumable/eggyolk = 2,
		/datum/reagent/consumable/eggwhite = 4,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/store/bread/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/khachapuri
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/rawkhinkali
	name = "Raw Khinkali"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/doughslice = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 1,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1
	)
	result =  /obj/item/reagent_containers/food/snacks/rawkhinkali
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/meatbun
	name = "Meat bun"
	reqs = list(
		/datum/reagent/consumable/soysauce = 5,
		/obj/item/reagent_containers/food/snacks/bun = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1
	)
	result = /obj/item/reagent_containers/food/snacks/meatbun
	subcategory = CAT_MISCFOOD

/////////////////////////////////MISC/////////////////////////////////////

/datum/crafting_recipe/food/beans
	name = "Beans"
	time = 40
	reqs = list(/datum/reagent/consumable/ketchup = 5,
		/obj/item/reagent_containers/food/snacks/grown/soybeans = 2
	)
	result = /obj/item/reagent_containers/food/snacks/beans
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/branrequests
	name = "Bran Requests Cereal"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/wheat = 1,
		/obj/item/reagent_containers/food/snacks/no_raisin = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/branrequests
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/oatmeal
	name = "Oatmeal"
	reqs = list(
		/datum/reagent/consumable/milk = 10,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/oat = 1
	)
	result = /obj/item/reagent_containers/food/snacks/salad/oatmeal
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/cheesyfries
	name = "Cheesy fries"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fries = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1
	)
	result = /obj/item/reagent_containers/food/snacks/cheesyfries
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/chilicheesefries
	name = "Chilli cheese fries"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fries = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1
	)
	result = /obj/item/reagent_containers/food/snacks/chilicheesefries
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/eggplantparm
	name ="Eggplant parmigiana"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1
	)
	result = /obj/item/reagent_containers/food/snacks/eggplantparm
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/loadedbakedpotato
	name = "Loaded baked potato"
	time = 40
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1
	)
	result = /obj/item/reagent_containers/food/snacks/loadedbakedpotato
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/mashedpotato
	name = "Mashed potato"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/sodiumchloride = 1
	)
	result = /obj/item/reagent_containers/food/snacks/mashedpotato
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/butteredpotato
	name = "Buttered mash"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/mashedpotato = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/butteredpotato
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/melonfruitbowl
	name ="Melon fruit bowl"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/watermelon = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1,
		/obj/item/reagent_containers/food/snacks/grown/citrus/orange = 1,
		/obj/item/reagent_containers/food/snacks/grown/citrus/lemon = 1,
		/obj/item/reagent_containers/food/snacks/grown/banana = 1,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia = 1
	)
	result = /obj/item/reagent_containers/food/snacks/melonfruitbowl
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/ricepudding
	name = "Rice pudding"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1
	)
	result = /obj/item/reagent_containers/food/snacks/salad/ricepudding
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/floursack
	name = "Flour sack"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/wheat = 5,
		/obj/item/stack/sheet/leather = 3
	)
	result = /obj/item/reagent_containers/food/condiment/flour
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/poutine
	name = "Poutine"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/fries = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 2
	)
	result = /obj/item/reagent_containers/food/snacks/poutine
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/trailmix
	name = "Trail Mix"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/pinyon = 3,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1,
		/obj/item/reagent_containers/food/snacks/grown/mutfruit = 1
	)
	result = /obj/item/reagent_containers/food/snacks/trailmix
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/herby_cheese
	name = "Herby cheese"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/curd_cheese = 1,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 4
	)
	result = /obj/item/reagent_containers/food/snacks/herby_cheese
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/pesto
	name = "Pesto"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/firm_cheese_slice = 1,
		/datum/reagent/consumable/sodiumchloride = 5,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 2,
		/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
		/datum/reagent/consumable/quality_oil = 5,
		/obj/item/reagent_containers/food/snacks/grown/pinyon = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pesto
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/tomato_sauce
	name = "Tomato sauce"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/datum/reagent/consumable/sodiumchloride = 2,
		/datum/reagent/consumable/quality_oil = 5,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 1
	)
	result = /obj/item/reagent_containers/food/snacks/tomato_sauce
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/bechamel_sauce
	name = "Bechamel sauce"
	reqs = list(
		/datum/reagent/consumable/milk = 10,
		/datum/reagent/consumable/flour = 5,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/bechamel_sauce
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/mozzarella_sticks
	name = "Mozzarella sticks"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/mozzarella = 1,
		/obj/item/reagent_containers/food/snacks/breadslice/plain = 2,
		/obj/item/reagent_containers/food/snacks/tomato_sauce = 1
	)
	result = /obj/item/reagent_containers/food/snacks/mozzarella_sticks
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/pierogi
	name = "Pierogi"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/doughslice = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1
	)
	result = /obj/item/reagent_containers/food/snacks/pierogi
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/stuffed_cabbage
	name = "Stuffed cabbage"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 2,
		/obj/item/reagent_containers/food/snacks/salad/boiledrice = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1
	)
	result = /obj/item/reagent_containers/food/snacks/stuffed_cabbage
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/pickles_jar
	name = "Jar of pickles"
	reqs = list(
		/obj/item/reagent_containers/glass/beaker/large = 1,
		/obj/item/reagent_containers/food/snacks/grown/cucumber = 10,
		/datum/reagent/water = 10,
		/datum/reagent/consumable/sodiumchloride = 10,
	)
	result = /obj/item/storage/fancy/pickles_jar
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/caramel_popcorn
	name = "Caramel Popcorn"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/popcorn = 1,
		/datum/reagent/consumable/caramel = 3,
	)
	result = /obj/item/reagent_containers/food/snacks/popcorn/caramel
	subcategory = CAT_MISCFOOD

/// Legacy Content

/*
/datum/crafting_recipe/food/melonkeg
	name ="Melon keg"
	reqs = list(
		/datum/reagent/consumable/ethanol/vodka = 25,
		/obj/item/reagent_containers/food/snacks/grown/holymelon = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vodka = 1
	)
	parts = list(/obj/item/reagent_containers/food/drinks/bottle/vodka = 1)
	result = /obj/item/reagent_containers/food/snacks/melonkeg
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/lizardwine //not a subtype of /datum/crafting_recipe/food due to a bug where the resulting bottle would contain 100u of lizardwine and 100u of ethanol.
	name = "Lizard wine"
	time = 40
	reqs = list(
		/obj/item/organ/tail/lizard = 1,
		/datum/reagent/consumable/ethanol = 100
	)
	result = /obj/item/reagent_containers/food/drinks/bottle/lizardwine
	category = CAT_FOOD
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/crepe
	name = "crepe"
	time = 40
	reqs = list(
		/obj/item/reagent_containers/food/snacks/flatdough = 1,
		/datum/reagent/consumable/milk = 1,
		/datum/reagent/consumable/cherryjelly = 5,
		/obj/item/stock_parts/cell/super =1,
		/obj/item/melee/sabre = 1
	)
	result = /obj/item/reagent_containers/food/snacks/crepe
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/butterbear //ITS ALIVEEEEEE!
	name = "Living bear/butter hybrid"
	reqs = list(
		/obj/item/organ/brain = 1,
		/obj/item/organ/heart = 1,
		/obj/item/reagent_containers/food/snacks/butter = 10,
		/obj/item/reagent_containers/food/snacks/meat/slab = 5,
		/datum/reagent/blood = 50,
		/datum/reagent/teslium = 1 //To shock the whole thing into life
	)
	result = /mob/living/simple_animal/hostile/bear/butter
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/royalcheese
	name = "Royal Cheese"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cheesewheel = 1,
		/obj/item/clothing/head/crown = 1,
		/datum/reagent/medicine/strange_reagent = 5,
		/datum/reagent/toxin/mutagen = 5
	)
	result = /obj/item/reagent_containers/food/snacks/royalcheese
	subcategory = CAT_MISCFOOD
*/


/datum/crafting_recipe/food/cheesepieorgi
	name = "Cheese Pieorgi"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/doughslice = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1
	)
	result = /obj/item/reagent_containers/food/snacks/cheesepierogi
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/meatpieorgi
	name = "Meat Pieorgi"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/doughslice = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1
	)
	result = /obj/item/reagent_containers/food/snacks/meatpierogi
	subcategory = CAT_MISCFOOD


////////////////////////////////////////////////BREAD////////////////////////////////////////////////

/datum/crafting_recipe/food/creamcheesebread
	name = "Cream cheese bread"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/obj/item/reagent_containers/food/snacks/store/bread/plain = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/bread/creamcheese
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/meatbread
	name = "Meat bread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/bread/plain = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet/plain = 3,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 3
	)
	result = /obj/item/reagent_containers/food/snacks/store/bread/meat
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/banananutbread
	name = "Banana nut bread"
	reqs = list(
		/datum/reagent/consumable/milk = 5,
		/obj/item/reagent_containers/food/snacks/store/bread/plain = 1,
		/obj/item/reagent_containers/food/snacks/boiledegg = 3,
		/obj/item/reagent_containers/food/snacks/grown/banana = 1
	)
	result = /obj/item/reagent_containers/food/snacks/store/bread/banana
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/spidermeatbread
	name = "Spidermeat bread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/bread/plain = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet/spider = 3,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 3
	)
	result = /obj/item/reagent_containers/food/snacks/store/bread/spidermeat
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/butterdog
	name = "Butterdog"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/bun = 1,
		/obj/item/reagent_containers/food/snacks/butter = 3,
		)
	result = /obj/item/reagent_containers/food/snacks/butterdog
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/twobread
	name = "Two bread"
	reqs = list(
		/datum/reagent/consumable/ethanol/wine = 5,
		/obj/item/reagent_containers/food/snacks/breadslice/plain = 2
	)
	result = /obj/item/reagent_containers/food/snacks/twobread
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/tofubread
	name = "Tofu bread"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/bread/plain = 1,
		/obj/item/reagent_containers/food/snacks/tofu = 3,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 3
	)
	result = /obj/item/reagent_containers/food/snacks/store/bread/tofu
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/cornbread
	name = "Cornbread"
	reqs = list(
		/datum/reagent/consumable/flour = 10,
		/datum/reagent/consumable/cornoil = 5,
		/datum/reagent/consumable/eggyolk = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/bread/corn
	subcategory = CAT_MISCFOOD


////////////////////////////////////////////////MISC////////////////////////////////////////////////

/datum/crafting_recipe/food/baguette
	name = "Baguette"
	time = 40
	reqs = list(/datum/reagent/consumable/sodiumchloride = 1,
				/datum/reagent/consumable/blackpepper = 1,
				/obj/item/reagent_containers/food/snacks/pastrybase = 2
	)
	result = /obj/item/reagent_containers/food/snacks/baguette
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/garlicbread
	name = "Garlic Bread"
	time = 40
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
				/obj/item/reagent_containers/food/snacks/breadslice/plain = 1,
				/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/garlicbread
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/butterbiscuit
	name = "Butter Biscuit"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/bun = 1,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/butterbiscuit
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/sauteedeggplant
	name ="Sauteed Eggplant"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sauteedeggplant
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/stuffedeggplant
	name ="Stuffed Eggplant"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2,
		/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
		/obj/item/reagent_containers/food/snacks/grown/chili = 1
	)
	result = /obj/item/reagent_containers/food/snacks/stuffedeggplant
	subcategory = CAT_MISCFOOD
