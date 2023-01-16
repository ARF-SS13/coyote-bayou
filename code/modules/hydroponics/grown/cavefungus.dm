/obj/item/seeds/fungus
	name = "pack of cave fungus mycelium"
	desc = "This mycelium grows into cave fungi, an edible variety of mushroom with anti-toxic properties."
	icon_state = "seed-fungus"
	species = "cave fungus"
	plantname = "Cave fungi"
	product = /obj/item/reagent_containers/food/snacks/grown/fungus
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'
	icon_grow = "cave_fungus-grow"
	icon_dead = "cave_fungus-dead"
	icon_harvest = "cave_fungus-harvest"
	lifespan = 50
	endurance = 10
	maturation = 8
	production = 3
	yield = 6
	potency = 20
	growthstages = 2
	reagents_add = list(
		/datum/reagent/medicine/charcoal = 0.05,
		/datum/reagent/medicine/mutadone = 0.05
	)
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)

/obj/item/reagent_containers/food/snacks/grown/fungus
	seed = /obj/item/seeds/fungus
	name = "cave fungus"
	desc = "Cave fungus is an edible mushroom which has the ability to purge bodily toxins."
	icon_state = "fungus"
	filling_color = "#FF6347"
	distill_reagent = /datum/reagent/consumable/cavefungusjuice

/obj/item/seeds/glow
	name = "pack of glowing fungus seeds"
	desc = "These seeds grow into glowing fungus."
	icon = 'icons/obj/hydroponics/seeds.dmi'
	icon_state = "mycelium-glow"
	species = "glow"
	plantname = "Glowing Fungus"
	product = /obj/item/reagent_containers/food/snacks/grown/glow
	lifespan = 60
	endurance = 10
	yield = 5
	growthstages = 3
	production = 20
	maturation = 20
	growing_icon = 'icons/fallout/flora/flora.dmi'
	icon_grow = "glow-grow"
	icon_dead = "glow-dead"
	icon_harvest = "glow-harvest"
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/glow)
	reagents_add = list(
		/datum/reagent/drug/space_drugs = 0.04,
		/datum/reagent/toxin/mindbreaker = 0.1,
		/datum/reagent/toxin/mutagen = 0.01, 
		/datum/reagent/radium = 0.05
	)

/obj/item/reagent_containers/food/snacks/grown/glow
	seed = /obj/item/seeds/glow
	name = "shroom"
	desc = "An edible mushroom which has the ability to decrease radiation levels."
	icon_state = "shroom"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	filling_color = "#FF6347"
