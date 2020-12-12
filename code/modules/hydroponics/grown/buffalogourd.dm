/obj/item/seeds/buffalogourd
	name = "pack of buffalo gourd seeds"
	desc = "These seeds grow into buffalo vines."
	icon_state = "seed-gourd"
	species = "buffalo gourd"
	plantname = "buffalo vines"
	product = /obj/item/reagent_containers/food/snacks/grown/buffalogourd
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "gourd-grow"
	icon_dead = "gourd-dead"
	icon_harvest = "tato-harvest"
	reagents_add = list(/datum/reagent/water = 0.2, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.2)
	lifespan = 50
	endurance = 40
	maturation = 10
	production = 1
	yield = 3
	growthstages = 3

/obj/item/reagent_containers/food/snacks/grown/buffalogourd
	seed = /obj/item/seeds/buffalogourd
	name = "buffalo gourd"
	desc = "It's full of watery goodness."
	icon_state = "Buffalo Gourd"
	w_class = WEIGHT_CLASS_NORMAL
	filling_color = "#008000"
	bitesize_mod = 3
	foodtype = FRUIT
	distill_reagent = /datum/reagent/consumable/ethanol/buffalo"
