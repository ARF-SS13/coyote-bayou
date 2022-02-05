/obj/item/seeds/poppy/broc
	name = "pack of broc seeds"
	desc = "These seeds grow into broc flowers."
	icon_state = "seed-broc"
	species = "broc"
	plantname = "Broc Flowers"
	product = /obj/item/reagent_containers/food/snacks/grown/broc
	lifespan = 25
	endurance = 10
	yield = 4
	growthstages = 3
	production = 4
	maturation = 4
	growing_icon = 'icons/obj/hydroponics/growing_flowers.dmi'
	icon_harvest = "broc-harvest"
	icon_grow = "broc-grow"
	icon_dead = "broc-dead"
	mutatelist = list(/obj/item/seeds/poppy/lily) //spaceman's trumpet
	reagents_add = list(/datum/reagent/medicine/dexalin = 0.2, /datum/reagent/medicine/salglu_solution = 0.05, /datum/reagent/consumable/nutriment = 0.1, /datum/reagent/medicine/bicaridine = 0.1,)

/obj/item/reagent_containers/food/snacks/grown/broc
	seed = /obj/item/seeds/poppy/broc
	name = "broc flower"
	desc = "This vibrant, orange flower grows on tall stalks in the wasteland and exhibits moderate healing properties, even when unprocessed."
	icon_state = "broc"
	filling_color = "#FF6347"
	juice_results = list(/datum/reagent/consumable/brocjuice = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/brocbrew
