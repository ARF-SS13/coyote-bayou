/obj/item/seeds/xander
	name = "pack of xander seeds"
	desc = "These seeds grow into xander roots."
	icon_state = "seed-xander"
	species = "xander"
	plantname = "Xander Roots"
	product = /obj/item/reagent_containers/food/snacks/grown/xander
	lifespan = 25
	endurance = 10
	yield = 3
	growthstages = 4
	production = 4
	maturation = 4
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "xander-grow"
	icon_harvest = "xander-harvest"
	icon_dead = "xander-dead"
	reagents_add = list(/datum/reagent/medicine/antitoxin = 0.2, /datum/reagent/medicine/salglu_solution = 0.05, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/xander
	seed = /obj/item/seeds/xander
	name = "xander root"
	desc = "Xander roots are large, hardy, turnip-like roots with mild healing properties."
	icon_state = "xander"
	filling_color = "#FF6347"
	juice_results = list(/datum/reagent/consumable/xanderjuice = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/salgam
