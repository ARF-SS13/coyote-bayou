/obj/item/seeds/datura
	name = "pack of datura seeds"
	desc = "These seeds grow into datura plants."
	icon_state = "seed-datura"
	species = "Datura"
	plantname = "Datura"
	product = /obj/item/reagent_containers/food/snacks/grown/datura
	lifespan = 30
	maturation = 6
	production = 5
	yield = 4
	growthstages = 5
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "datura-grow"
	icon_dead = "datura-dead"
	icon_harvest = "datura-harvest"
	reagents_add = list(/datum/reagent/medicine/morphine = 0.2, /datum/reagent/drug/mushroomhallucinogen = 0.1, /datum/reagent/toxin = 0.05,  /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/datura
	seed = /obj/item/seeds/datura
	name = "Datura"
	desc = "The sacred datura root, useful as an anesthetic for surgery and in healing salves, as well as for rites of passage rituals and ceremonies"
	icon_state = "Datura"
	filling_color = "#FFA500"
	bitesize_mod = 2
	foodtype = VEGETABLES
	juice_results = list(/datum/reagent/consumable/daturajuice = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/daturatea
