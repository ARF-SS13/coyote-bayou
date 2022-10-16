
// see code/module/crafting/table.dm

////////////////////////////////////////////////SALADS////////////////////////////////////////////////

/datum/crafting_recipe/food/citrusdelight
	name = "Citrus delight"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/citrus/lime = 1,
		/obj/item/reagent_containers/food/snacks/grown/citrus/lemon = 1,
		/obj/item/reagent_containers/food/snacks/grown/citrus/orange = 1
	)
	result = /obj/item/reagent_containers/food/snacks/salad/citrusdelight
	subcategory = CAT_SALAD //This one is the only one I'm unsure about.

/datum/crafting_recipe/food/fruitsalad
	name = "Fruit salad"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/citrus/orange = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1,
		/obj/item/reagent_containers/food/snacks/grown/grapes = 1,
		/obj/item/reagent_containers/food/snacks/watermelonslice = 2

	)
	result = /obj/item/reagent_containers/food/snacks/salad/fruit
	subcategory = CAT_SALAD

/datum/crafting_recipe/food/herbsalad
	name = "Herb salad"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia/vulgaris = 3,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1
	)
	result = /obj/item/reagent_containers/food/snacks/salad/herbsalad
	subcategory = CAT_SALAD

/datum/crafting_recipe/food/junglesalad
	name = "Jungle salad"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/apple = 1,
		/obj/item/reagent_containers/food/snacks/grown/grapes = 1,
		/obj/item/reagent_containers/food/snacks/grown/banana = 2,
		/obj/item/reagent_containers/food/snacks/watermelonslice = 2

	)
	result = /obj/item/reagent_containers/food/snacks/salad/jungle
	subcategory = CAT_SALAD

/datum/crafting_recipe/food/caesarsalad
	name = "Caesar salad"
	reqs = list(
		/obj/item/kitchen/knife = 1,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia/gaia = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1
	)
	result = /obj/item/reagent_containers/food/snacks/salad/caesar
	subcategory = CAT_SALAD

/datum/crafting_recipe/food/edensalad
	name = "Salad of Eden"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl =1,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia/vulgaris = 1,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia/deus = 1,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia/gaia = 1,
		/obj/item/reagent_containers/food/snacks/grown/peace = 1
	)
	result = /obj/item/reagent_containers/food/snacks/salad/edensalad
	subcategory = CAT_SALAD

/datum/crafting_recipe/food/aesirsalad
	name = "Aesir salad"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia/deus = 3,
		/obj/item/reagent_containers/food/snacks/grown/apple/gold = 1
	)
	result = /obj/item/reagent_containers/food/snacks/salad/aesirsalad
	subcategory = CAT_SALAD

/datum/crafting_recipe/food/kale_salad
	name = "Kale salad"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/onion_slice/red = 2,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 1,
		/datum/reagent/consumable/quality_oil = 2,
	)
	result = /obj/item/reagent_containers/food/snacks/salad/kale_salad
	subcategory = CAT_SALAD

/datum/crafting_recipe/food/greek_salad
	name = "Greek salad"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/olive = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/onion_slice/red = 2,
		/obj/item/reagent_containers/food/snacks/cheesewedge = 1,
		/datum/reagent/consumable/quality_oil = 5,
	)
	result = /obj/item/reagent_containers/food/snacks/salad/greek_salad
	subcategory = CAT_SALAD

/datum/crafting_recipe/food/spring_salad
	name = "Spring salad"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 2,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/grown/peas = 1,
		/datum/reagent/consumable/quality_oil = 5,
	)
	result = /obj/item/reagent_containers/food/snacks/salad/spring_salad
	subcategory = CAT_SALAD

/datum/crafting_recipe/food/potato_salad
	name = "Potato salad"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/potato = 2,
		/obj/item/reagent_containers/food/snacks/boiledegg = 2,
		/obj/item/reagent_containers/food/snacks/grown/onion = 1,
		/datum/reagent/consumable/mayonnaise = 5,
	)
	result = /obj/item/reagent_containers/food/snacks/salad/potato_salad
	subcategory = CAT_SALAD

/datum/crafting_recipe/food/spinach_fruit_salad
	name = "Spinach fruit salad"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/herbs = 3,
		/obj/item/reagent_containers/food/snacks/grown/berries = 2,
		/obj/item/reagent_containers/food/snacks/pineappleslice = 2,
		/datum/reagent/consumable/quality_oil = 2,
	)
	result = /obj/item/reagent_containers/food/snacks/salad/spinach_fruit_salad
	subcategory = CAT_SALAD

/datum/crafting_recipe/food/antipasto_salad
	name = "Antipasto salad"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/cabbage = 2,
		/obj/item/reagent_containers/food/snacks/grown/olive = 1,
		/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
		/obj/item/reagent_containers/food/snacks/meat/cutlet = 1,
		/obj/item/reagent_containers/food/snacks/mozzarella = 1,
	)
	result = /obj/item/reagent_containers/food/snacks/salad/antipasto_salad
	subcategory = CAT_SALAD

/*
/datum/crafting_recipe/food/monkeysdelight
	name = "Monkeys delight"
	reqs = list(
		/datum/reagent/consumable/flour = 5,
		/datum/reagent/consumable/sodiumchloride = 1,
		/datum/reagent/consumable/blackpepper = 1,
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/cube/monkey = 1,
		/obj/item/reagent_containers/food/snacks/grown/banana = 1
	)
	result = /obj/item/reagent_containers/food/snacks/soup/monkeysdelight
	subcategory = CAT_SALAD

/datum/crafting_recipe/food/validsalad
	name = "Valid salad"
	reqs = list(
		/obj/item/reagent_containers/glass/bowl = 1,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia/vulgaris = 3,
		/obj/item/reagent_containers/food/snacks/grown/potato = 1,
		/obj/item/reagent_containers/food/snacks/meatball = 1
	)
	result = /obj/item/reagent_containers/food/snacks/salad/validsalad
	subcategory = CAT_SALAD
*/
