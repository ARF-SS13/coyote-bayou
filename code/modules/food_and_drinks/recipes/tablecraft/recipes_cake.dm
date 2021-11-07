

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
	always_availible = FALSE
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
/*
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
