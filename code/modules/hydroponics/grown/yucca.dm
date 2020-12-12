/obj/item/seeds/yucca
	name = "pack of banana yucca seeds"
	desc = "These seeds grow into an agave plant."
	icon = 'icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-yucca"
	species = "banna yucca"
	plantname = "banana yucca plant"
	product = /obj/item/reagent_containers/food/snacks/grown/yucca
	lifespan = 50
	endurance = 30
	yield = 5
	growthstages = 4
	production = 2
	maturation = 1
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "yucca-grow"
	icon_dead = "yucca-dead"
	icon_harvest = "yucca-harvest"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.2, /datum/reagent/consumable/sugar = 0.1, /datum/reagent/consumable/nutriment = 0.2)


/obj/item/reagent_containers/food/snacks/grown/yucca
	seed = /obj/item/seeds/yucca
	name = "banana yucca fruit"
	desc = "The fleshy banana banana like fruit, rougly 8 cm long and 6 cm across. It smells tastes similar to a sweet potato."
	icon_state = "Bannana Yucca"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	bitesize = 100
	juice_results = list(/datum/reagent/yuccajuice = 0)
	distill_reagent = /datum/reagent/consumable/yuccajuice
