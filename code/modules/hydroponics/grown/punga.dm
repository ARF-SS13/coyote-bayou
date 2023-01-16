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
	reagents_add = list(
		/datum/reagent/consumable/nutriment = 0.1,
		/datum/reagent/medicine/punga_extract = 0.1
	)

/obj/item/reagent_containers/food/snacks/grown/pungafruit
	seed = /obj/item/seeds/punga
	name = "pungafruit"
	desc = "A leathery, green fruit, with an excellent taste and radiation cleansing properties, but highly addictive."
	icon_state = "Punga Fruit"
	filling_color = "#FF6347"
	juice_results = list(/datum/reagent/medicine/potass_iodide = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/vodka
