/obj/item/seeds/yucca
	name = "pack of banana yucca seeds"
	desc = "These seeds grow into a yucca plant."
	icon = 'icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-yucca"
	species = "banna yucca"
	plantname = "Banana Yucca plant"
	product = /obj/item/reagent_containers/food/snacks/grown/yucca
	lifespan = 50
	endurance = 30
	yield = 5
	growthstages = 4
	maturation = 5
	production = 4
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "yucca-grow"
	icon_dead = "yucca-dead"
	icon_harvest = "yucca-harvest"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list( /datum/reagent/consumable/nutriment = 0.2, /datum/reagent/consumable/sugar = 0.1,  /datum/reagent/consumable/nutriment/vitamin = 0.2)


/obj/item/reagent_containers/food/snacks/grown/yucca
	seed = /obj/item/seeds/yucca
	name = "banana yucca fruit"
	desc = "The fleshy banana like fruit, rougly 8 cm long and 6 cm across. It tastes similar to a sweet potato."
	icon_state = "Bannana Yucca"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	bitesize = 3
	juice_results = list(/datum/reagent/consumable/yuccajuice = 0)
	distill_reagent = /datum/reagent/consumable/yuccajuice
