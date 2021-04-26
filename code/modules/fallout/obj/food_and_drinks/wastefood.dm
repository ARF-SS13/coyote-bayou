//FOOD FALLOUT 13///////

/obj/item/reagent_containers/food/snacks/soup/macaco
	name = "Macaco soup"
	desc = "To think, the monkey would've beat you to death and steal your gun."
	icon_state = "macaco"
	bonus_reagents = list( /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/medicine/omnizine = 5,  /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("Monkey" = 1)
	foodtype = MEAT | VEGETABLES


/obj/item/reagent_containers/food/snacks/soup/moleratstew
	name = "molerat stew"
	desc = "A nice and warm stew. Healthy and strong."
	icon_state = "stew"
	bonus_reagents = list( /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/consumable/tomatojuice = 5,  /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list( /datum/reagent/consumable/nutriment/vitamin = 10, /datum/reagent/medicine/oculine = 5, /datum/reagent/consumable/tomatojuice = 5,  /datum/reagent/consumable/nutriment/vitamin = 5)
	bitesize = 7
	volume = 100
	tastes = list("gamey meat" = 1, "herbal notes" = 1, "filling stew" = 1)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/soup/buffalogourd
	name = "Buffalo gourd soup"
	desc = "A tasty soup made with roasted gourd"
	icon_state = "Buffalo Soup"
	bonus_reagents = list( /datum/reagent/consumable/nutriment/vitamin = 4,  /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("buttery flesh" = 1, "creamy soup" = 1)
	foodtype = VEGETABLES


/////PLANTS Fallout 13///////

/obj/item/seeds/buffalogourd
	name = "pack of buffalo gourd seeds"
	desc = "These seeds grow into buffalo vines."
	icon_state = "seed-gourd"
	species = "buffalo gourd"
	plantname = "Buffalo Vines"
	product = /obj/item/reagent_containers/food/snacks/grown/buffalogourd
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "gourd-grow"
	icon_dead = "gourd-dead"
	icon_harvest = "gourd-harvest"
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
	filling_color = "#008000"
	bitesize_mod = 3
	foodtype = FRUIT
	distill_reagent = "buffalo"

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
	juice_results = list(/datum/reagent/consumable/tea/coyotetea = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/deathroach


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
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1, /datum/reagent/medicine/calomel = 0.05, /datum/reagent/radium = 0.05)

/obj/item/reagent_containers/food/snacks/grown/feracactus
	seed = /obj/item/seeds/feracactus
	name = "barrel cactus fruit"
	desc = "Barrel cactus fruit are found on spherical barrel cacti and are both nutritious and highly toxic."
	icon_state = "feracactus"
	filling_color = "#FF6347"
	juice_results = list(/datum/reagent/consumable/tea/feratea = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/yellowpulque


/obj/item/seeds/poppy/broc
	name = "pack of broc seeds"
	desc = "These seeds grow into broc flowers."
	icon_state = "seed-broc"
	species = "broc"
	plantname = "Broc Flowers"
	product = /obj/item/reagent_containers/food/snacks/grown/broc
	lifespan = 25
	endurance = 10
	yield = 4
	growthstages = 3
	production = 4
	maturation = 4
	growing_icon = 'icons/obj/hydroponics/growing_flowers.dmi'
	icon_harvest = "broc-harvest"
	icon_grow = "broc-grow"
	icon_dead = "broc-dead"
	//mutatelist = list(/obj/item/seeds/geraniumseed, /obj/item/seeds/lilyseed)
	reagents_add = list(/datum/reagent/medicine/dexalin = 0.2, /datum/reagent/medicine/salglu_solution = 0.05, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/broc
	seed = /obj/item/seeds/poppy/broc
	name = "broc flower"
	desc = "This vibrant, orange flower grows on tall stalks in the wasteland and exhibits moderate healing properties, even when unprocessed."
	icon_state = "broc"
	//slot_flags = SLOT_HEAD
	filling_color = "#FF6347"
	juice_results = list(/datum/reagent/consumable/tea/broctea = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/brocbrew


/obj/item/seeds/xander
	name = "pack of xander seeds"
	desc = "These seeds grow into xander roots."
	icon_state = "seed-xander"
	species = "xander"
	plantname = "Xander Roots"
	product = /obj/item/reagent_containers/food/snacks/grown/xander
	lifespan = 25
	endurance = 10
	yield = 3
	growthstages = 4
	production = 4
	maturation = 4
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "xander-grow"
	icon_harvest = "xander-harvest"
	icon_dead = "xander-dead"
	reagents_add = list(/datum/reagent/medicine/antitoxin = 0.2, /datum/reagent/medicine/salglu_solution = 0.05, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/xander
	seed = /obj/item/seeds/xander
	name = "xander root"
	desc = "Xander roots are large, hardy, turnip-like roots with mild healing properties."
	icon_state = "xander"
	filling_color = "#FF6347"
	juice_results = list(/datum/reagent/consumable/tea/xandertea = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/salgam

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
	reagents_add = list( /datum/reagent/consumable/nutriment/vitamin = 0.04,  /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/horsenettle
	seed = /obj/item/seeds/horsenettle
	name = "horsenettle berries"
	desc = "The tribes use these berries as a vegetable rennet."
	icon_state = "White Horsenettle"
	filling_color = "#FF00FF"
	bitesize_mod = 2
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/enzyme = 1)
	tastes = list("searing pain" = 1)
	distill_reagent = /datum/reagent/consumable/enzyme


/obj/item/seeds/mesquite
	name = "pack of honey mesquite seeds"
	desc = "These seeds grows into a mesquite plant."
	icon_state = "mycelium-tower"
	species = "honey mesquite"
	plantname = "Honey Mesquite"
	product = /obj/item/reagent_containers/food/snacks/grown/mesquite
	lifespan = 80
	endurance = 50
	maturation = 6
	production = 5
	yield = 5
	potency = 50
	growthstages = 4
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "mesquite-grow"
	icon_dead = "mesquite-dead"
	icon_harvest = "mesquite-harvest"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/honey = 0.1, /datum/reagent/consumable/nutriment = 0.05)

/obj/item/reagent_containers/food/snacks/grown/mesquite
	seed = /obj/item/seeds/mesquite
	name = "honey mesquite pods"
	desc = "The honey mesquite pod grows on a short tree with willow-like branches. Trees with pickable pods will appear bushier in foliage and have strings of pods on them, resembling a fern pattern. Pods can be eaten or used in recipes"
	gender = PLURAL
	icon_state = "Mesquite Pod"
	filling_color = "#F0E68C"
	bitesize_mod = 2
	foodtype = VEGETABLES
	juice_results = list(/datum/reagent/consumable/honey = 0.1)
	tastes = list("crunchy sweetness" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/wastemead


/obj/item/seeds/pinyon
	name = "pack of pinyon pine seeds"
	desc = "The seeds of the pinyon pine, known as pine nuts or pi��ns, are an important food for settlers and tribes living in the mountains of the North American Southwest. All species of pine produce edible seeds, but in North America only the pinyon produces seeds large enough to be a major source of food."
	icon_state = "seed-pinyon"
	species = "pinyon pine"
	plantname = "Pinyon Pine"
	product = /obj/item/reagent_containers/food/snacks/grown/pinyon
	lifespan = 80
	endurance = 50
	maturation = 9
	production = 6
	yield = 5
	potency = 50
	growthstages = 4
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "pinyon-grow"
	icon_dead = "pinyon-dead"
	icon_harvest = "pinyon-harvest"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list( /datum/reagent/consumable/nutriment = 0.05)

/obj/item/reagent_containers/food/snacks/grown/pinyon
	seed = /obj/item/seeds/pinyon
	name = "pinyon nuts"
	desc = "The seeds of the pinyon pine, known as pine nuts or pi��ns, are an important food for settlers and tribes living in the mountains of the North American Southwest. All species of pine produce edible seeds, but in North America only the pinyon produces seeds large enough to be a major source of food."
	gender = PLURAL
	icon_state = "Pinyon Nuts"
	filling_color = "#F0E68C"
	bitesize_mod = 2
	foodtype = GRAIN
	grind_results = list(/datum/reagent/consumable/flour = 0)
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
	plantname = "Prickly pear cactus"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	product = /obj/item/reagent_containers/food/snacks/grown/pricklypear
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.2, /datum/reagent/water = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.05)
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
	juice_results = list(/datum/reagent/consumable/tea/pricklytea = 0)
	tastes = list("sweet cactus" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/pinkpulque

/obj/item/grown/pricklypear/pickup(mob/living/user)
	..()
	if(!iscarbon(user))
		return FALSE
	var/mob/living/carbon/C = user
	if(C.gloves)
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
	name = "datura-harvest"
	desc = "The sacred datura root, useful as an anesthetic for surgery and in healing salves, as well as for rites of passage rituals and ceremonies"
	icon_state = "Datura"
	filling_color = "#FFA500"
	bitesize_mod = 2
	foodtype = VEGETABLES
	juice_results = list(/datum/reagent/consumable/ethanol/daturatea = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/daturatea

/obj/item/seeds/punga
	name = "pack of punga seeds"
	desc = "These small black pits grow into a punga bush"
	icon_state = "seed-punga"
	species = "punga"
	plantname = "Punga Bush"
	product = /obj/item/reagent_containers/food/snacks/grown/pungafruit
	lifespan = 100
	endurance = 30
	maturation = 10
	production = 5
	yield = 3
	potency = 30
	growthstages = 4
	rarity = 20
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "punga-grow"
	icon_dead = "punga-dead"
	icon_harvest = "punga-harvest"
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/medicine/charcoal = 0.1, /datum/reagent/consumable/nutriment = 0.1, /datum/reagent/medicine/radaway = 0.05)

/obj/item/reagent_containers/food/snacks/grown/pungafruit
	seed = /obj/item/seeds/punga
	name = "pungafruit"
	desc = "Punga fruit plants flower at a single point at the terminus of their stems, gradually developing into large, fleshy fruits with a yellow/brown, thick skin. They are common throughout Point Lookout, due to the unique conditions offered by the swamps, and scrub radiation when ingested."
	icon_state = "Punga Fruit"
	filling_color = "#FF6347"
	juice_results = list(/datum/reagent/consumable/ethanol/pungajuice = 0)

/obj/item/seeds/yucca
	name = "pack of banana yucca seeds"
	desc = "These seeds grow into a yucca plant."
	icon = 'icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-yucca"
	species = "banna yucca"
	plantname = "Banana Yucca plant"
	product = /obj/item/reagent_containers/food/snacks/grown/yucca
	lifespan = 50
	endurance = 30
	yield = 5
	growthstages = 4
	maturation = 5
	production = 4
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "yucca-grow"
	icon_dead = "yucca-dead"
	icon_harvest = "yucca-harvest"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list( /datum/reagent/consumable/nutriment = 0.2, /datum/reagent/consumable/sugar = 0.1,  /datum/reagent/consumable/nutriment/vitamin = 0.2)


/obj/item/reagent_containers/food/snacks/grown/yucca
	seed = /obj/item/seeds/yucca
	name = "banana yucca fruit"
	desc = "The fleshy banana like fruit, rougly 8 cm long and 6 cm across. It tastes similar to a sweet potato."
	icon_state = "Bannana Yucca"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	bitesize = 3
	juice_results = list(/datum/reagent/consumable/yuccajuice = 0)
	distill_reagent = /datum/reagent/consumable/yuccajuice

/obj/item/seeds/tato
	name = "pack of tato seeds"
	desc = "a pack of tato seeds"
	icon_state = "seed-tato"
	species = "tato"
	plantname = "Tato Plants"
	product = /obj/item/reagent_containers/food/snacks/grown/tato
	lifespan = 30
	maturation = 7
	production = 3
	yield = 4
	growthstages = 4
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	icon_grow = "tato-grow"
	icon_dead = "tato-dead"
	icon_harvest = "tato-harvest"
	genes = list(/datum/plant_gene/trait/battery, /datum/plant_gene/trait/repeated_harvest)
	reagents_add = list( /datum/reagent/consumable/nutriment/vitamin = 0.04,  /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/tato
	seed = /obj/item/seeds/tato
	name = "tato"
	desc = "The outside looks like a tomato, but the inside is brown. Tastes as absolutely disgusting as it looks, but will keep you from starving."
	icon_state = "Tato"
	filling_color = "#E9967A"
	bitesize = 100
	foodtype = VEGETABLES
	juice_results = list(/datum/reagent/consumable/tato_juice = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/tatovodka

/obj/item/reagent_containers/food/snacks/grown/tato/wedges
	name = "tato wedges"
	desc = "Slices of neatly cut tato."
	icon_state = "potato_wedges"
	filling_color = "#E9967A"
	bitesize = 100

/obj/item/reagent_containers/food/snacks/grown/tato/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		to_chat(user, "<span class='notice'>You cut the tato into wedges with [W].</span>")
		var/obj/item/reagent_containers/food/snacks/grown/tato/wedges/Wedges = new /obj/item/reagent_containers/food/snacks/grown/tato/wedges
		remove_item_from_storage(user)
		qdel(src)
		user.put_in_hands(Wedges)
	else
		return ..()


/obj/item/seeds/mutfruit
	name = "pack of mutfruit seeds"
	desc = "These seeds grow into a mutfruit sapling."
	icon_state = "seed-mutfruit"
	species = "mutfruit"
	plantname = "Mutfruit Sapling"
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "mutfruit-grow"
	icon_dead = "mutfruit-dead"
	product = /obj/item/reagent_containers/food/snacks/grown/mutfruit
	lifespan = 30
	endurance = 20
	yield = 3
	growthstages = 3
	production = 5
	maturation = 5
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.05, /datum/reagent/consumable/nutriment = 0.1, /datum/reagent/radium = 0.15)

/obj/item/reagent_containers/food/snacks/grown/mutfruit
	seed = /obj/item/seeds/mutfruit
	name = "mutfruit"
	desc = "Mutfruit provides both hydration and sustenance, but the mutated plant also carries small amounts of radiation."
	icon_state = "mutfruit"
	filling_color = "#FF6347"
	distill_reagent = /datum/reagent/consumable/ethanol/purplecider
	juice_results = list(/datum/reagent/consumable/mutjuice = 0)


/*HRP*/


//// LAVALAND MUSHROOMS ////

// Bracket (Shaving mushroom)

/obj/item/seeds/lavaland
	name = "lavaland seeds"
	desc = "You should never see this."
	lifespan = 50
	endurance = 25
	maturation = 7
	production = 4
	yield = 4
	potency = 15
	growthstages = 3
	rarity = 20
	reagents_add = list( /datum/reagent/consumable/nutriment/vitamin = 0.1)
	resistance_flags = FIRE_PROOF

/obj/item/seeds/lavaland/polypore
	name = "pack of polypore mycelium"
	desc = "This mycelium grows into bracket mushrooms, also known as polypores. Woody and firm, shaft miners often use them for makeshift crafts."
	icon_state = "mycelium-polypore"
	species = "polypore"
	plantname = "Polypore Mushrooms"
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/shavings
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'

// Porcini (Leafy mushroom)

/obj/item/seeds/lavaland/porcini
	name = "pack of porcini mycelium"
	desc = "This mycelium grows into Boletus edulus, also known as porcini. Native to the late Earth, but discovered on Lavaland. Has culinary, medicinal and relaxant effects."
	icon_state = "mycelium-porcini"
	species = "porcini"
	plantname = "Porcini Mushrooms"
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_leaf
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'

// Inocybe (Mushroom caps)

/obj/item/seeds/lavaland/inocybe
	name = "pack of inocybe mycelium"
	desc = "This mycelium grows into an inocybe mushroom, a species of Lavaland origin with hallucinatory and toxic effects."
	icon_state = "mycelium-inocybe"
	species = "inocybe"
	plantname = "Inocybe Mushrooms"
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_cap
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'

// Embershroom (Mushroom stem)

/obj/item/seeds/lavaland/ember
	name = "pack of embershroom mycelium"
	desc = "This mycelium grows into embershrooms, a species of bioluminescent mushrooms native to Lavaland."
	icon_state = "mycelium-ember"
	species = "ember"
	plantname = "Embershroom Mushrooms"
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_stem
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/glow)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'


//Fallout mushrooms

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
	reagents_add = list(/datum/reagent/medicine/charcoal = 0.05, /datum/reagent/medicine/mutadone = 0.05)

/obj/item/reagent_containers/food/snacks/grown/fungus
	seed = /obj/item/seeds/fungus
	name = "cave fungus"
	desc = "Cave fungus is an edible mushroom which has the ability to purge bodily toxins."
	icon_state = "fungus"
	filling_color = "#FF6347"

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
	reagents_add = list(/datum/reagent/drug/space_drugs = 0.04, /datum/reagent/toxin/mindbreaker = 0.1, /datum/reagent/toxin/mutagen = 0.01, /datum/reagent/radium = 0.05)

/obj/item/reagent_containers/food/snacks/grown/glow
	seed = /obj/item/seeds/glow
	name = "shroom"
	desc = "An edible mushroom which has the ability to decrease radiation levels."
	icon_state = "shroom"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	filling_color = "#FF6347"

/*MRP*/


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
	reagents_add = list(/datum/reagent/medicine/kelotane = 0.1, /datum/reagent/toxin/lipolicide = 0.1, /datum/reagent/consumable/nutriment = 0.1)


/obj/item/reagent_containers/food/snacks/grown/agave
	seed = /obj/item/seeds/agave
	name = "agave leaf"
	desc = "A strange kind of fleshy grass often used as a primitive burn medication that rapidly depletes stored nutrients in the body."
	icon_state = "Agave Leaf"
	icon = 'icons/obj/flora/wastelandflora.dmi'
	juice_results = list(/datum/reagent/consumable/tea/agavetea = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/tequila
