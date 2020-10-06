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
	reagents_add = list("nicotine" = 0.03, "nutriment" = 0.03)

/obj/item/reagent_containers/food/snacks/grown/coyotetobacco
	seed = /obj/item/seeds/coyotetobacco
	name = "coyote tobacco leaves"
	desc = "This tobacco like plant is commonly used by tribals for a great variety of medicinal and ceremonial purposes."
	icon_state = "Coyote Tobacco"
	filling_color = "#008000"
	juice_results = list("coyotetea" = 0)
	distill_reagent = "deathroach"


/obj/item/seeds/feracactus
	name = "pack of barrel cactus seeds"
	desc = "These seeds grow into a barrel cactus."
	icon_state = "seed-feracactus"
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "feracactus-grow"
	icon_dead = "feracactus-dead"
	icon_harvest = "feracactus-harvest"
	species = "barrel cactus"
	plantname = "barrel cactus"
	product = /obj/item/reagent_containers/food/snacks/grown/feracactus
	lifespan = 60
	endurance = 20
	yield = 2
	growthstages = 2
	production = 5
	maturation = 5


/obj/item/reagent_containers/food/snacks/grown/feracactus
	seed = /obj/item/seeds/feracactus
	name = "barrel cactus fruit"
	desc = "Barrel cactus fruit are found on spherical barrel cacti and are both nutritious and highly toxic."
	icon_state = "feracactus"
	filling_color = "#FF6347"
	juice_results = list("feratea" = 0)
	distill_reagent = "yellowpulque"

/obj/item/reagent_containers/food/snacks/grown/feracactus/add_juice()
	if(..())
		reagents.add_reagent("nutriment", 3 + round((seed.potency / 20), 1))
		reagents.add_reagent("calomel", 3 + round((seed.potency / 20), 1))
		reagents.add_reagent("radium", 0 + round((seed.potency / 20), 1))
		bitesize = 3 + round(reagents.total_volume / 3, 1)

