///////////////////////////////////
///////Biogenerator Designs ///////
///////////////////////////////////

//Please be wary to not add inorganic items to the results such as generic glass bottles and metal.
//as they kind of defeat the design of this feature.

/datum/design/milk
	name = "10u Milk"
	id = "milk"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 20)
	make_reagents = list(/datum/reagent/consumable/milk = 10)
	category = list("initial","Food")

/datum/design/cream
	name = "10u Cream"
	id = "cream"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 30)
	make_reagents = list(/datum/reagent/consumable/cream = 10)
	category = list("initial","Food")

/datum/design/soymilk
	name = "10u Soymilk"
	id = "soymilk"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 30)
	make_reagents = list(/datum/reagent/consumable/soymilk = 10)
	category = list("initial","Food")

/datum/design/flour
	name = "10u Flour"
	id = "flour"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	make_reagents = list(/datum/reagent/consumable/flour = 10)
	category = list("initial","Food")

/datum/design/black_pepper
	name = "10u Black Pepper"
	id = "black_pepper"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	make_reagents = list(/datum/reagent/consumable/blackpepper = 10)
	category = list("initial","Food")

/datum/design/table_salt
	name = "10u Table Salt"
	id = "table_salt"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	make_reagents = list(/datum/reagent/consumable/sodiumchloride = 10)
	category = list("initial","Food")

/datum/design/sugar
	name = "10u Sugar"
	id = "sugar"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	make_reagents = list(/datum/reagent/consumable/sugar = 10)
	category = list("initial","Food")

/datum/design/enzyme
	name = "10u Universal Enzyme"
	id = "enzyme"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 30)
	make_reagents = list(/datum/reagent/consumable/enzyme = 10)
	category = list("initial","Food")

/datum/design/smeat
	name = "Biomass Meat Slab"
	id = "smeat"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/reagent_containers/food/snacks/meat/slab/synthmeat
	category = list("initial", "Food")

/datum/design/seaweed
	name = "Sea Weed Sheet"
	id = "sweetweed"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/reagent_containers/food/snacks/sea_weed
	category = list("initial", "Food")
/datum/design/ez_nut
	name = "10u E-Z Nutrient"
	id = "ez_nut"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 2)
	make_reagents = list(/datum/reagent/plantnutriment/eznutriment = 10)
	category = list("initial","Botany")

/datum/design/l4z_nut
	name = "10u Left 4 Zed"
	id = "l4z_nut"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 4)
	make_reagents = list(/datum/reagent/plantnutriment/left4zednutriment = 10)
	category = list("initial","Botany")

/datum/design/rh_nut
	name = "10u Robust Harvest"
	id = "rh_nut"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 5)
	make_reagents = list(/datum/reagent/plantnutriment/robustharvestnutriment = 10)
	category = list("initial","Botany")

/datum/design/end_gro
	name = "30u Enduro Grow"
	id = "end_gro"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass= 30)
	make_reagents = list(/datum/reagent/plantnutriment/endurogrow = 30)
	category = list("initial","Botany")

/datum/design/liq_earth
	name = "30u Liquid Earthquake"
	id = "liq_earth"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass= 30)
	make_reagents = list(/datum/reagent/plantnutriment/liquidearthquake = 30)
	category = list("initial","Botany")

/datum/design/weed_killer
	name = "Weed Killer"
	id = "weed_killer"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 10)
	make_reagents = list(/datum/reagent/toxin/plantbgone/weedkiller = 10)
	category = list("initial","Botany")

/datum/design/pest_spray
	name = "Pest Killer"
	id = "pest_spray"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 10)
	make_reagents = list(/datum/reagent/toxin/pestkiller = 10)
	category = list("initial","Botany")

/datum/design/strange_seed
	name = "Strange Seeds"
	id = "strange_seed"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 4000)
	build_path = /obj/item/seeds/random
	category = list("initial","Botany")

/datum/design/ammonia
	name = "10u Ammonia"
	id = "ammonia_biogen"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	make_reagents = list(/datum/reagent/ammonia = 10)
	category = list("initial","Botany")

/datum/design/saltpetre
	name = "10u Saltpetre"
	id = "saltpetre_biogen"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	make_reagents = list(/datum/reagent/saltpetre = 10)
	category = list("initial","Botany")

/datum/design/empty_carton
	name = "Small Empty Carton Box"
	id = "empty_carton"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 15)
	build_path = /obj/item/reagent_containers/food/drinks/bottle/bio_carton
	category = list("initial", "Organic Materials")

/* //and the three men i admired most:
/datum/design/cloth
	name = "Roll of Cloth"
	id = "cloth"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/sheet/cloth
	category = list("initial","Organic Materials")
*/

/datum/design/cardboard
	name = "Sheet of Cardboard"
	id = "cardboard"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/stack/sheet/cardboard
	category = list("initial","Organic Materials")

/* //the father, son, and the holy ghost:
/datum/design/leather
	name = "Sheet of Leather"
	id = "leather"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 225)
	build_path = /obj/item/stack/sheet/leather
	category = list("initial","Organic Materials")
*/

/*/datum/design/secbelt
	name = "Security Belt"
	id = "secbelt"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/belt/army/security
	category = list("initial","Organic Materials")*/

/datum/design/medbelt
	name = "Medical Belt"
	id = "medbel"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/belt/medical
	category = list("initial","Organic Materials")

/datum/design/janibelt
	name = "Janitorial Belt"
	id = "janibelt"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/belt/janitor
	category = list("initial","Organic Materials")

/*/datum/design/s_holster
	name = "Shoulder Holster"
	id = "s_holster"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 400)
	build_path = /obj/item/storage/belt/holster
	category = list("initial","Organic Materials")*/ //removed due to borking the biogen

/datum/design/rice_hat
	name = "Rice Hat"
	id = "rice_hat"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/clothing/head/rice_hat
	category = list("initial","Organic Materials")
