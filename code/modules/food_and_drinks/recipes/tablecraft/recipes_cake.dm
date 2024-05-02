////////////////////////////////////////////////CAKES////////////////////////////////////////////////

/datum/crafting_recipe/food/applecake
	name = "Apple cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/apple
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/bscccake
	name = "Blackberry and strawberry chocolate cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 2,
		/obj/item/reagent_containers/food/snacks/grown/berries = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/bscc
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/limecake
	name = "Lime cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/citrus/lime = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/lime
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/peachcake
	name = "Peach cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/peach = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/peach_cake
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/birthdaycake
	name = "Birthday cake"
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/consumable/caramel =2,
		/obj/item/candle = 1,
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/birthday
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/briochecake
	name = "Brioche cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/datum/reagent/consumable/sugar = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/brioche
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/carrotcake
	name = "Carrot cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/carrot
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/cheesecake
	name = "Cheese cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/cheese
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/chocolatecake
	name = "Chocolate cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/chocolatebar = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/chocolate
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/pumpkinspicecake
	name = "Pumpkin spice cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/pumpkin = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/pumpkinspice
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/vanillacake
	name = "Vanilla cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/vanillapod = 2
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/vanilla_cake
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/fruitcake
	name = "Fruit Cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/cherries = 2,
		/datum/reagent/consumable/ethanol/rum  = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/fruit
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/plumcake
	name = "Plum Cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/plum = 2,
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/plum
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/weddingcake
	name = "Wedding Cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 4,
		/datum/reagent/consumable/sugar = 150,
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/wedding
	subcategory = CAT_CAKE

/////////////SPECIAL////////////
/datum/crafting_recipe/food/holycake
	name = "Angel food cake"
	reqs = list(
		/datum/reagent/water/holywater = 15,
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/holy_cake
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/braincake
	name = "Brain cake"
	reqs = list(
		/obj/item/organ/brain = 1,
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/brain
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/clowncake
	name = "Clown cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/sundae = 2,
		/obj/item/reagent_containers/food/snacks/grown/banana = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/clown_cake
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/hardwarecake
	name = "Hardware cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/circuitboard = 2,
		/datum/reagent/toxin/acid = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/hardware_cake
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/slimecake
	name = "Slime cake"
	reqs = list(
		/obj/item/slime_extract = 1,
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/slimecake
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/trumpetcake
	name = "Spaceman's Cake"
	reqs = list(
		/obj/item/reagent_containers/food/snacks/store/cake/plain = 1,
		/obj/item/reagent_containers/food/snacks/grown/trumpet = 2,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/berryjuice = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/trumpet
	subcategory = CAT_CAKE

/datum/crafting_recipe/food/pavlova
	name = "Pavlova"
	reqs = list(
		/datum/reagent/consumable/eggwhite = 12,
		/datum/reagent/consumable/sugar = 15,
		/datum/reagent/consumable/whipped_cream = 10,
		/obj/item/reagent_containers/food/snacks/grown/berries = 5
	)
	result = /obj/item/reagent_containers/food/snacks/store/cake/pavlova
	subcategory = CAT_CAKE




/// Funny Archive

/*
/datum/crafting_recipe/food/cak
	name = "Living cat/cake hybrid"
	reqs = list(
		/obj/item/organ/brain = 1,
		/obj/item/organ/heart = 1,
		/obj/item/reagent_containers/food/snacks/store/cake/birthday = 1,
		/obj/item/reagent_containers/food/snacks/meat/slab = 3,
		/datum/reagent/blood = 30,
		/datum/reagent/consumable/sprinkles = 5,
		/datum/reagent/teslium = 1 //To shock the whole thing into life
	)
	result = /mob/living/simple_animal/pet/cat/cak
	subcategory = CAT_CAKE //Cat! Haha, get it? CAT? GET IT? We get it - Love Catpeople
*/
