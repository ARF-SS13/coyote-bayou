/obj/item/seeds/horsenettle
	name = "pack of horsenettle seeds"
	desc = "These seeds grow into white horsenettles."
	icon_state = "seed-horsenettle"
	species = "horsenettle"
	plantname = "White Horsenettles"
	product = /obj/item/reagent_containers/food/snacks/grown/horsenettle
	lifespan = 30
	endurance = 40
	yield = 4
	growthstages = 4
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "horsenettle-grow"
	icon_dead = "horsenettle-dead"
	icon_harvest = "horsenettle-harvest"
	genes = list(/datum/plant_gene/trait/plant_type/weed_hardy)
	reagents_add = list( /datum/reagent/consumable/nutriment/vitamin = 0.04,  /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/horsenettle
	seed = /obj/item/seeds/horsenettle
	name = "horsenettle berries"
	desc = "The tribes use these berries as a vegetable rennet."
	icon_state = "White Horsenettle"
	filling_color = "#FF00FF"
	bitesize_mod = 2
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/enzyme = 1)
	tastes = list("searing pain" = 1)
	distill_reagent = /datum/reagent/consumable/enzyme
