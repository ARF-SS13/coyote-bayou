/obj/item/seeds/agave
	name = "pack of agave seeds"
	desc = "These seeds grow into an agave plant."
	icon = 'icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-agave"
	species = "agave"
	plantname = "Agave plant"
	product = /obj/item/reagent_containers/food/snacks/grown/agave
	lifespan = 60
	endurance = 10
	yield = 5
	growthstages = 3
	production = 7
	maturation = 7
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "agave-grow"
	icon_dead = "agave-dead"
	icon_harvest = "agave-harvest"
	reagents_add = list(/datum/reagent/medicine/kelotane = 0.1, /datum/reagent/toxin/lipolicide = 0.1 )


/obj/item/reagent_containers/food/snacks/grown/agave
	seed = /obj/item/seeds/agave
	name = "agave leaf"
	desc = "A strange kind of fleshy grass often used as a primitive burn medication that rapidly depletes stored nutrients in the body."
	icon_state = "Agave Leaf"
	icon = 'icons/obj/flora/wastelandflora.dmi'
	juice_results = list(/datum/reagent/consumable/agavejuice = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/tequila
