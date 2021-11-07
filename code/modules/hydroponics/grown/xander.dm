/obj/item/seeds/xander
	name = "pack of xander seeds"
	desc = "These seeds grow into xander roots."
	icon_state = "seed-xander"
	species = "xander"
	plantname = "xander roots"
	product = /obj/item/reagent_containers/food/snacks/grown/xander
	lifespan = 25
	endurance = 10
	yield = 3
	growthstages = 4
	production = 2
	maturation = 2
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "potato-grow"
	icon_dead = "potato-dead"

/obj/item/reagent_containers/food/snacks/grown/xander
	seed = /obj/item/seeds/xander
	name = "xander root"
	desc = "Xander roots are large, hardy, turnip-like roots with mild healing properties."
	icon_state = "xander"
	filling_color = "#FF6347"
	juice_results = list(/datum/reagent/xandertea = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/salgam

/obj/item/reagent_containers/food/snacks/grown/xander/add_juice()
	if(..())
		reagents.add_reagent(/datum/reagent/medicine/antitoxin, 1 + round((seed.potency / 5), 1))
		reagents.add_reagent(/datum/reagent/consumable/xanderjuice, 1 + round((seed.potency/5), 1))
		reagents.add_reagent(/datum/reagent/medicine/salglu, 1 + round((seed.potency / 20), 1))
		bitesize = 1 + round(reagents.total_volume / 3, 1)

/*HRP*/
