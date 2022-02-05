/obj/item/seeds/coyotetobacco
	name = "pack of coyote tobacco seeds"
	desc = "These seeds grow into coyote tobacco plants."
	icon_state = "seed-coyote"
	species = "coyote tobacco"
	plantname = "Coyote Tobacco Bush"
	product = /obj/item/reagent_containers/food/snacks/grown/coyotetobacco
	genes = list(/datum/plant_gene/trait/plant_type/weed_hardy)
	lifespan = 20
	maturation = 5
	production = 5
	yield = 10
	growthstages = 4
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "coyote-grow"
	icon_dead = "coyote-dead"
	icon_harvest = "coyote-harvest"
	reagents_add = list(/datum/reagent/drug/nicotine = 0.1,  /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/coyotetobacco
	seed = /obj/item/seeds/coyotetobacco
	name = "coyote tobacco leaves"
	desc = "This tobacco like plant is commonly used by tribals for a great variety of medicinal and ceremonial purposes."
	icon_state = "Coyote Tobacco"
	filling_color = "#008000"
	juice_results = list(/datum/reagent/consumable/coyotejuice = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/deathroach
