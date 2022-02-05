//FOOD FALLOUT 13///////

/obj/item/reagent_containers/food/snacks/soup/macaco
	name = "Macaco soup"
	desc = "To think, the monkey would've beat you to death and steal your gun."
	icon_state = "macaco"
	bonus_reagents = list( /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/medicine/omnizine = 5,  /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("Monkey" = 1)
	foodtype = MEAT | VEGETABLES
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
	reagents_add = list(/datum/reagent/drug/space_drugs = 0.04, /datum/reagent/toxin/mindbreaker = 0.1, /datum/reagent/toxin/mutagen = 0.01, /datum/reagent/radium = 0.05)

/obj/item/reagent_containers/food/snacks/grown/glow
	seed = /obj/item/seeds/glow
	name = "shroom"
	desc = "An edible mushroom which has the ability to decrease radiation levels."
	icon_state = "shroom"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	filling_color = "#FF6347"

/*MRP*/
