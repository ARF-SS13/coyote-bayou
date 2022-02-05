/obj/item/reagent_containers/food/snacks/roastseeds/buffalogourd
	name = "roasted gourd seeds"
	desc = "Well prepared crispy buffalo gourd seeds, full of chewy protein."
	list_reagents = list(/datum/reagent/consumable/cooking_oil = 1, /datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1.5)

/obj/item/seeds/buffalogourd
	name = "pack of buffalo gourd seeds"
	desc = "These seeds grow into buffalo vines.<br><b>they appear to be edible once cooked!</b>"
	icon_state = "seed-gourd"
	species = "buffalo gourd"
	plantname = "Buffalo Vines"
	product = /obj/item/reagent_containers/food/snacks/grown/buffalogourd
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "gourd-grow"
	icon_dead = "gourd-dead"
	icon_harvest = "gourd-harvest"
	reagents_add = list(/datum/reagent/water = 0.2,  /datum/reagent/toxin = 0.1)
	lifespan = 50
	endurance = 40
	maturation = 10
	production = 1
	yield = 3
	growthstages = 3

/obj/item/seeds/buffalogourd/microwave_act(obj/machinery/microwave/MW) //The act allows it to be cooked over a bonfire grille too.
	..()
	new /obj/item/reagent_containers/food/snacks/roastseeds/buffalogourd(drop_location())
	qdel(src)

/obj/item/reagent_containers/food/snacks/roastseeds/buffalogourd
	name = "roasted gourd seeds"
	desc = "Well prepared crispy buffalo gourd seeds, full of chewy protein."
	list_reagents = list(/datum/reagent/consumable/cooking_oil = 1, /datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1.5)

/obj/item/reagent_containers/food/snacks/grown/buffalogourd
	seed = /obj/item/seeds/buffalogourd
	name = "buffalo gourd"
	desc = "A bitter tasting vine plant, with a watery fleshy texture."
	icon_state = "buffalo_gourd"
	filling_color = "#008000"
	bitesize_mod = 3
	foodtype = FRUIT | GROSS
	juice_results = list(/datum/reagent/lye= 0.5) // The oil made from the gourd plant itself is used in Native American soap.
	distill_reagent = /datum/reagent/consumable/ethanol/buffalo
