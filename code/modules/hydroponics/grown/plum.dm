/obj/item/seeds/plum
	name = "pack of plum seeds"
	desc = "These seeds grow into plum trees."
	icon_state = "seed_plum"
	species = "plum"
	plantname = "Plum Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/plum
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "plum-grow"
	icon_dead = "plum-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/plum
	seed = /obj/item/seeds/plum
	name = "plum"
	desc = "A poet's favorite fruit. Noice."
	icon_state = "plum"
	foodtype = FRUIT
//	juice_results = list(/datum/reagent/consumable/plumjuice = 0)
	tastes = list("plum" = 1)
//	distill_reagent = /datum/reagent/consumable/ethanol/plumwine - Will add another time
