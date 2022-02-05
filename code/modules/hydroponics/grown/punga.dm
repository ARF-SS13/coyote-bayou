/obj/item/seeds/punga
	name = "pack of punga seeds"
	desc = "These small black pits grow into a punga bush"
	icon_state = "seed-punga"
	species = "punga"
	plantname = "Punga Bush"
	product = /obj/item/reagent_containers/food/snacks/grown/pungafruit
	lifespan = 100
	endurance = 30
	maturation = 10
	production = 5
	yield = 3
	potency = 30
	growthstages = 4
	rarity = 20
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "punga-grow"
	icon_dead = "punga-dead"
	icon_harvest = "punga-harvest"
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/medicine/charcoal = 0.1, /datum/reagent/consumable/nutriment = 0.1, /datum/reagent/medicine/radaway = 0.05)

/obj/item/reagent_containers/food/snacks/grown/pungafruit
	seed = /obj/item/seeds/punga
	name = "pungafruit"
	desc = "Punga fruit plants flower at a single point at the terminus of their stems, gradually developing into large, fleshy fruits with a yellow/brown, thick skin. They are common throughout Point Lookout, due to the unique conditions offered by the swamps, and scrub radiation when ingested."
	icon_state = "Punga Fruit"
	filling_color = "#FF6347"
	juice_results = list(/datum/reagent/consumable/ethanol/pungajuice = 0)
