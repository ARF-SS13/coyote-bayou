
/obj/item/seeds/feracactus
	name = "pack of barrel cactus seeds"
	desc = "These seeds grow into a barrel cactus."
	icon_state = "seed-feracactus"
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "feracactus-grow"
	icon_dead = "feracactus-dead"
	icon_harvest = "feracactus-harvest"
	species = "barrel cactus"
	plantname = "Barrel Cactus"
	product = /obj/item/reagent_containers/food/snacks/grown/feracactus
	lifespan = 60
	endurance = 20
	yield = 2
	growthstages = 2
	production = 5
	maturation = 5
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1, /datum/reagent/medicine/calomel = 0.1,)

/obj/item/reagent_containers/food/snacks/grown/feracactus
	seed = /obj/item/seeds/feracactus
	name = "barrel cactus fruit"
	desc = "Carefully harvested spineless barrel-cactus fruit, it feels dry to the touch but appears more than edible."
	icon_state = "feracactus"
	filling_color = "#FF6347"
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/ferajuice = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/yellowpulque
