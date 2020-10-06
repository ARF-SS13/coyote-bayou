//FOOD FALLOUT 13///////

/obj/item/reagent_containers/food/snacks/soup/macaco
	name = "Macaco soup"
	desc = "To think, the monkey would've beat you to death and steal your gun."
	icon_state = "macaco"
	bonus_reagents = list("nutriment" = 1, "omnizine" = 5, "vitamin" = 5)
	tastes = list("Monkey" = 1)
	foodtype = MEAT | VEGETABLES


/obj/item/reagent_containers/food/snacks/soup/moleratstew
	name = "molerat stew"
	desc = "A nice and warm stew. Healthy and strong."
	icon_state = "stew"
	bonus_reagents = list("nutriment" = 1, "tomatojuice" = 5, "vitamin" = 5)
	list_reagents = list("nutriment" = 10, "oculine" = 5, "tomatojuice" = 5, "vitamin" = 5)
	bitesize = 7
	volume = 100
	tastes = list("gamey meat" = 1, "herbal notes" = 1, "filling stew" = 1)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/grown/buffalogourd
	name = "Buffalo gourd soup"
	desc = "A tasty soup made with roasted gourd"
	icon_state = "Gourd Soup"
	bonus_reagents = list("nutriment" = 4, "vitamin" = 6)
	tastes = list("buttery flesh" = 1, "creamy soup" = 1)
	foodtype = VEGETABLES


/////PLANTS Fallout 13///////
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

/obj/item/seeds/poppy/broc
	name = "pack of broc seeds"
	desc = "These seeds grow into broc flowers."
	icon_state = "seed-broc"
	species = "broc"
	plantname = "broc flowers"
	product = /obj/item/reagent_containers/food/snacks/grown/broc
	lifespan = 25
	endurance = 10
	yield = 4
	growthstages = 3
	production = 4
	maturation = 4
	growing_icon = 'icons/obj/hydroponics/growing_flowers.dmi'
	//mutatelist = list(/obj/item/seeds/geraniumseed, /obj/item/seeds/lilyseed)

/obj/item/reagent_containers/food/snacks/grown/broc
	seed = /obj/item/seeds/poppy/broc
	name = "broc flower"
	desc = "This vibrant, orange flower grows on tall stalks in the wasteland and exhibits moderate healing properties, even when unprocessed."
	icon_state = "broc"
	//slot_flags = SLOT_HEAD
	filling_color = "#FF6347"
	juice_results = list("broctea" = 0)
	distill_reagent = "brocbrew"


/obj/item/reagent_containers/food/snacks/grown/broc/add_juice()
	if(..())
		reagents.add_reagent("dexalin", 1 + round((seed.potency / 5), 1))
		reagents.add_reagent("salglu_solution", 1 + round((seed.potency / 20), 1))
		bitesize = 1 + round(reagents.total_volume / 3, 1)

/obj/item/seeds/xander
	name = "pack of xander seeds"
	desc = "These seeds grow into xander roots."
	icon_state = "seed-xander"
	species = "xander"
	plantname = "xander roots"
	product = /obj/item/reagent_containers/food/snacks/grown/xander
	lifespan = 25
	endurance = 10
	yield = 3
	growthstages = 4
	production = 2
	maturation = 2
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "potato-grow"
	icon_dead = "potato-dead"

/obj/item/reagent_containers/food/snacks/grown/xander
	seed = /obj/item/seeds/xander
	name = "xander root"
	desc = "Xander roots are large, hardy, turnip-like roots with mild healing properties."
	icon_state = "xander"
	filling_color = "#FF6347"
	juice_results = list("xandertea" = 0)
	distill_reagent = "salgam"

/obj/item/reagent_containers/food/snacks/grown/xander/add_juice()
	if(..())
		reagents.add_reagent("antitoxin", 1 + round((seed.potency / 5), 1))
		reagents.add_reagent("salglu_solution", 1 + round((seed.potency / 20), 1))
		bitesize = 1 + round(reagents.total_volume / 3, 1)

/*HRP*/

/obj/item/seeds/horsenettle
	name = "pack of horsenettle seeds"
	desc = "These seeds grow into white horsenettles."
	icon_state = "seed-horsenettle"
	species = "horsenettle"
	plantname = "White Horsenettles"
	product = /obj/item/reagent_containers/food/snacks/grown/horsenettle
	lifespan = 30
	endurance = 40
	yield = 4
	growthstages = 4
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "horsenettle-grow"
	icon_dead = "horsenettle-dead"
	icon_harvest = "horsenettle-harvest"
	genes = list(/datum/plant_gene/trait/plant_type/weed_hardy)
	reagents_add = list("vitamin" = 0.04, "nutriment" = 0.1)

/obj/item/reagent_containers/food/snacks/grown/horsenettle
	seed = /obj/item/seeds/horsenettle
	name = "horsenettle berries"
	desc = "The tribes use these berries as a vegetable rennet."
	icon_state = "White Horsenettle"
	filling_color = "#FF00FF"
	bitesize_mod = 2
	foodtype = FRUIT
	juice_results = list("yeast" = 1)
	tastes = list("searing pain" = 1)
	distill_reagent = "yeast"


/obj/item/seeds/mesquite
	name = "pack of honey mesquite seeds"
	desc = "This mycelium grows into tower-cap mushrooms."
	icon_state = "mycelium-tower"
	species = "honey mesquite"
	plantname = "honey mesquite"
	product = /obj/item/reagent_containers/food/snacks/grown/mesquite
	lifespan = 80
	endurance = 50
	maturation = 15
	production = 1
	yield = 5
	potency = 50
	growthstages = 4
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "mesquite-grow"
	icon_dead = "mesquite-dead"
	icon_harvest = "mesquite-harvest"
	genes = list(/datum/plant_gene/trait/repeated_harvest)

/obj/item/reagent_containers/food/snacks/grown/mesquite
	seed = /obj/item/seeds/mesquite
	name = "honey mesquite pods"
	desc = "The honey mesquite pod grows on a short tree with willow-like branches. Trees with pickable pods will appear bushier in foliage and have strings of pods on them, resembling a fern pattern. Pods can be eaten or used in recipes"
	gender = PLURAL
	icon_state = "Mesquite Pod"
	filling_color = "#F0E68C"
	bitesize_mod = 2
	foodtype = VEGETABLES
	juice_results = list("honey" = 0)
	tastes = list("crunchy sweetness" = 1)
	distill_reagent = "wastemead"


/obj/item/seeds/pinyon
	name = "pack of pinyon pine seeds"
	desc = "The seeds of the pinyon pine, known as pine nuts or piñóns, are an important food for settlers and tribes living in the mountains of the North American Southwest. All species of pine produce edible seeds, but in North America only the pinyon produces seeds large enough to be a major source of food."
	icon_state = "seed-pinyon"
	species = "pinyon pine"
	plantname = "Pinyon Pine"
	product = /obj/item/reagent_containers/food/snacks/grown/pinyon
	lifespan = 80
	endurance = 50
	maturation = 15
	production = 1
	yield = 5
	potency = 50
	growthstages = 4
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "pinyon-grow"
	icon_dead = "pinyon-dead"
	icon_harvest = "pinyon-harvest"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list("nutriment" = 0.04)

/obj/item/reagent_containers/food/snacks/grown/pinyon
	seed = /obj/item/seeds/pinyon
	name = "pinyon nuts"
	desc = "The seeds of the pinyon pine, known as pine nuts or piñóns, are an important food for settlers and tribes living in the mountains of the North American Southwest. All species of pine produce edible seeds, but in North America only the pinyon produces seeds large enough to be a major source of food."
	gender = PLURAL
	icon_state = "Pinyon Nuts"
	filling_color = "#F0E68C"
	bitesize_mod = 2
	foodtype = GRAIN
	grind_results = list("flour" = 0)
	tastes = list("pine nuts" = 1)

/obj/item/seeds/pricklypear
	name = "pack of prickly pear seeds"
	desc = "These seeds grow into a prickly pear cactus."
	icon_state = "seed-prickly"
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "prickly-grow"
	icon_dead = "prickly-dead"
	icon_harvest = "prickly-harvest"
	species = "prickly pear"
	plantname = "prickly pear"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	product = /obj/item/reagent_containers/food/snacks/grown/pricklypear
	reagents_add = list("vitamin" = 0.02, "nutriment" = 0.2, "water" = 0.04)
	lifespan = 60
	endurance = 20
	yield = 2
	growthstages = 4
	production = 4
	maturation = 5

/obj/item/reagent_containers/food/snacks/grown/pricklypear
	seed = /obj/item/seeds/pricklypear
	name = "prickly pear fruit"
	desc = "Distinguished by having cylindrical, rather than flattened, stem segments with large barbed spines. The stem joints are very brittle on young stems, readily breaking off when the barbed spines stick to clothing or animal fur."
	icon_state = "Prickly Pear"
	filling_color = "#FF6347"
	foodtype = FRUIT
	bitesize_mod = 2
	juice_results = list("pricklytea" = 0)
	tastes = list("sweet cactus" = 1)
	distill_reagent = "pinkpulque"

/obj/item/grown/pricklypear/pickup(mob/living/user)
	..()
	if(!iscarbon(user))
		return FALSE
	var/mob/living/carbon/C = user
	if(C.gloves)
		return FALSE
	if(C.has_trait(TRAIT_PIERCEIMMUNE))
		return FALSE
	var/hit_zone = (C.held_index_to_dir(C.active_hand_index) == "l" ? "l_":"r_") + "arm"
	var/obj/item/bodypart/affecting = C.get_bodypart(hit_zone)
	if(affecting)
		if(affecting.receive_damage(0, force))
			C.update_damage_overlays()
	to_chat(C, "<span class='userdanger'>The thorns pierce your bare hand!</span>")
	return TRUE

/obj/item/seeds/datura
	name = "pack of datura seeds"
	desc = "These seeds grow into datura plants."
	icon_state = "seed-datura"
	species = "Datura"
	plantname = "Datura"
	product = /obj/item/reagent_containers/food/snacks/grown/datura
	lifespan = 30
	maturation = 10
	production = 1
	yield = 4
	growthstages = 5
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "datura-grow"
	icon_dead = "datura-dead"
	icon_harvest = "datura-harvest"
	reagents_add = list("morphine" = 0.35, "mushroomhallucinogen" = 0.12, "toxin" = 0.3, "nutriment" = 0.05)

/obj/item/reagent_containers/food/snacks/grown/datura
	seed = /obj/item/seeds/datura
	name = "datura-harvest"
	desc = "The sacred datura root, useful as an anesthetic for surgery and in healing salves, as well as for rites of passage rituals and ceremonies"
	icon_state = "Datura"
	filling_color = "#FFA500"
	bitesize_mod = 2
	foodtype = VEGETABLES
	juice_results = list("daturatea" = 0)
	distill_reagent = "daturatea"

/obj/item/seeds/punga
	name = "pack of punga seeds"
	desc = "These small black pits grow into a punga bush"
	icon_state = "seed-punga"
	species = "punga"
	plantname = "punga bush"
	product = /obj/item/reagent_containers/food/snacks/grown/pungafruit
	lifespan = 100
	endurance = 30
	maturation = 15
	production = 1
	yield = 3
	potency = 30
	growthstages = 4
	rarity = 20
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "punga-grow"
	icon_dead = "punga-dead"
	icon_harvest = "punga-harvest"
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/repeated_harvest)
	reagents_add = list("charcoal" = 0.1, "phosphorus" = 0.1, "nutriment" = 0.04)

/obj/item/reagent_containers/food/snacks/grown/pungafruit
	seed = /obj/item/seeds/punga
	name = "pungafruit"
	desc = "Punga fruit plants flower at a single point at the terminus of their stems, gradually developing into large, fleshy fruits with a yellow/brown, thick skin. They are common throughout Point Lookout, due to the unique conditions offered by the swamps, and the further unique function of scrubbing radiation from the system"
	icon_state = "Punga Fruit"
	filling_color = "#FF6347"
	distill_reagent = "pungajuice"

/obj/item/reagent_containers/food/snacks/grown/pungafruit/add_juice()
	if(..())
		reagents.add_reagent("charcoal", 1 + round((seed.potency / 20), 1))
		reagents.add_reagent("mutadone", 1 + round((seed.potency / 20), 1))
		bitesize = 1 + round(reagents.total_volume / 3, 1)