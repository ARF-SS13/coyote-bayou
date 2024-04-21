////////////////////////////////////////////COOKIES////////////////////////////////////////////

/datum/crafting_recipe/food/raisincookie
	name = "Raisin cookie"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/no_raisin = 1,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/reagent_containers/food/snacks/grown/oat = 1
	)
	result = /obj/item/reagent_containers/food/snacks/raisincookie
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/sugarcookie
	time = 15
	name = "Sugar cookie"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sugarcookie
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/oreocookie
	time = 15
	name = "Oreo cookie"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1
	)
	result = /obj/item/reagent_containers/food/snacks/oreocookie
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/sugarcookie/tree
	time = 15
	name = "Sugar cookie Tree"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sugarcookie/tree
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/sugarcookie/bear
	time = 15
	name = "Sugar cookie Bear"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sugarcookie/bear
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/sugarcookie/santa
	time = 15
	name = "Sugar cookie Santa"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sugarcookie/santa
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/sugarcookie/stocking
	time = 15
	name = "Sugar cookie Stocking"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sugarcookie/stocking
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/sugarcookie/present
	time = 15
	name = "Sugar cookie Present"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sugarcookie/present
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/sugarcookie/cane
	time = 15
	name = "Sugar cookie Cane"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/sugarcookie/cane
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/fortunecookie
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
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/peanut_butter_cookie
	name = "Peanut butter cookie"
	reqs = list(
		/datum/reagent/consumable/peanut_butter = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/peanut_butter
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/thumbprintcookie
	name = "Thumb print sugar cookie"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/thumbprintcookie
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/snickerdoodle
	name = "snickerdoodle cookie"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/snickerdoodle
	subcategory = CAT_DESERT

////////////////////////////////////////////CUPCAKES////////////////////////////////////////////

/datum/crafting_recipe/food/bluecherrycupcake
	name = "Blue cherry cupcake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/reagent_containers/food/snacks/grown/bluecherries = 1
	)
	result = /obj/item/reagent_containers/food/snacks/bluecherrycupcake
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/strawberrycupcake
	name = "Strawberry cherry cupcake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/obj/item/reagent_containers/food/snacks/grown/strawberry  = 1
	)
	result = /obj/item/reagent_containers/food/snacks/strawberrycupcake
	subcategory = CAT_DESERT


/datum/crafting_recipe/food/raw_brownie_batter
	name = "Raw brownie batter"
	reqs = list(
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/egg = 2,
		/datum/reagent/consumable/coco = 5,
		/obj/item/reagent_containers/food/snacks/butter = 1
	)
	result = /obj/item/reagent_containers/food/snacks/raw_brownie_batter
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/peanut_butter_brownie_sheet
	name = "Peanut Butter Brownie Sheet"
	reqs = list(
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/egg = 2,
		/datum/reagent/consumable/coco = 5,
		/obj/item/reagent_containers/food/snacks/butter = 1,
		/datum/reagent/consumable/peanut_butter = 5
	)
	result = /obj/item/reagent_containers/food/snacks/brownie_sheet_peanut
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/crunchy_peanut_butter_tart
	name = "Crunchy peanut butter tart"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/pastrybase = 1,
		/datum/reagent/consumable/peanut_butter = 5,
		/datum/reagent/consumable/cream = 5,
	)
	result = /obj/item/reagent_containers/food/snacks/crunchy_peanut_butter_tart
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/moth_cheese_cakes
	name = "Ælorölen (Cheesecake balls)"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/reagent_containers/food/snacks/moth_cheese_cakes
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/candiedapple
	name = "Candied apple"
	reqs = list(/datum/reagent/water = 5,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1
	)
	result = /obj/item/reagent_containers/food/snacks/candiedapple
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/chocolatestrawberry
	name = "Chocolate Strawberry"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/obj/item/reagent_containers/food/snacks/grown/strawberry  = 1
	)
	result = /obj/item/reagent_containers/food/snacks/chocolatestrawberry
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/honeybar
	name = "Honey nut bar"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/grown/oat = 1,
		/datum/reagent/consumable/honey = 5
	)
	result = /obj/item/reagent_containers/food/snacks/honeybar
	subcategory = CAT_DESERT

/////////CAKES//////

/datum/crafting_recipe/food/applecake
	name = "Apple cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/apple
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/bscccake
	name = "Blackberry and strawberry chocolate cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 2,
		/obj/item/reagent_containers/food/snacks/grown/berries = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/bscc
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/limecake
	name = "Lime cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/citrus/lime = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/lime
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/peachcake
	name = "Peach cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/peach = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/peach_cake
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/birthdaycake
	name = "Birthday cake"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/caramel =2,
		/obj/item/candle = 1,
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/birthday
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/briochecake
	name = "Brioche cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/datum/reagent/consumable/sugar = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/brioche
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/carrotcake
	name = "Carrot cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/carrot
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/cheesecake
	name = "Cheese cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/cheese
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/chocolatecake
	name = "Chocolate cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/chocolate
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/pumpkinspicecake
	name = "Pumpkin spice cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/pumpkin = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/pumpkinspice
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/vanillacake
	name = "Vanilla cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/vanillapod = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/vanilla_cake
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/fruitcake
	name = "Fruit Cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/cherries = 2,
		/datum/reagent/consumable/ethanol/rum  = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/fruit
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/plumcake
	name = "Plum Cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/plum = 2,
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/plum
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/weddingcake
	name = "Wedding Cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 4,
		/datum/reagent/consumable/sugar = 150,
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/wedding
	subcategory = CAT_DESERT

/////////////SPECIAL////////////
/datum/crafting_recipe/food/holycake
	name = "Angel food cake"
	reqs = list(
		/datum/reagent/water/holywater = 15,
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/holy_cake
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/braincake
	name = "Brain cake"
	reqs = list(
		/obj/item/organ/brain = 1,
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/brain
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/clowncake
	name = "Clown cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/sundae = 2,
		/obj/item/reagent_containers/food/snacks/grown/banana = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/clown_cake
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/hardwarecake
	name = "Hardware cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/circuitboard = 2,
		/datum/reagent/toxin/acid = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/hardware_cake
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/slimecake
	name = "Slime cake"
	reqs = list(
		/obj/item/slime_extract = 1,
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/slimecake
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/trumpetcake
	name = "Spaceman's Cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/trumpet = 2,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/berryjuice = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/trumpet
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/pavlova
	name = "Pavlova"
	reqs = list(
		/datum/reagent/consumable/eggwhite = 12,
		/datum/reagent/consumable/sugar = 15,
		/datum/reagent/consumable/whipped_cream = 10,
		/obj/item/reagent_containers/food/snacks/grown/berries = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/pavlova
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/carameltruffle
	name = "Caramel Truffle"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/caramel = 3

	)
	result = /obj/item/reagent_containers/food/snacks/carameltruffle
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/chocolatetruffle
	name = "Chocolate Truffle"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/datum/reagent/consumable/sugar = 5

	)
	result = /obj/item/reagent_containers/food/snacks/chocolatetruffle
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/peanuttruffle
	name = "Peanut Truffle"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/grown/peanut = 1

	)
	result = /obj/item/reagent_containers/food/snacks/peanuttruffle
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/peanutbuttercup
	name = "Peanut Butter Cup"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 1,
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/grown/peanut = 1

	)
	result = /obj/item/reagent_containers/food/snacks/peanutbuttercup
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/cak //I'm readding this. - TP
	name = "Living cat/cake hybrid"
	reqs = list(
		/obj/item/organ/brain = 1,
		/obj/item/organ/heart = 1,
		/obj/item/reagent_containers/food/snacks/store/cake/birthday = 1,
		/obj/item/reagent_containers/food/snacks/meat/slab = 3,
		/datum/reagent/blood = 30 //To shock the whole thing into life
	)
	result = /mob/living/simple_animal/pet/cat/cak
	subcategory = CAT_DESERT //Cat! Haha, get it? CAT? GET IT? We get it - Love Catpeople

//Macarons//

/datum/crafting_recipe/food/macaronred
	name = "red macaron"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/macaronred
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/macaronyellow
	name = "yellow macaron"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/macaronyellow
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/macaronpurple
	name = "purple macaron"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/macaronpurple
	subcategory = CAT_DESERT

/datum/crafting_recipe/food/macarongreen
	name = "green macaron"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/reagent_containers/food/snacks/pastrybase = 1
	)
	result = /obj/item/reagent_containers/food/snacks/macarongreen
	subcategory = CAT_DESERT
