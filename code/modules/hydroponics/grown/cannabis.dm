// Cannabis
/obj/item/seeds/cannabis
	name = "pack of cannabis seeds"
	desc = "Taxable."
	icon_state = "seed-cannabis"
	species = "cannabis"
	plantname = "Cannabis Plant"
	product = /obj/item/reagent_containers/food/snacks/grown/cannabis
	maturation = 8
	potency = 20
	growthstages = 1
	instability = 40
	growing_icon = 'goon/icons/obj/hydroponics.dmi'
	icon_grow = "cannabis-grow" // Uses one growth icons set for all the subtypes
	icon_dead = "cannabis-dead" // Same for the dead icon
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(
		/obj/item/seeds/cannabis/white,
		)
	reagents_add = list(/datum/reagent/drug/space_drugs = 0.15, /datum/reagent/toxin/lipolicide = 0.35) // gives u the munchies


/obj/item/seeds/cannabis/white
	name = "pack of lifeweed seeds"
	desc = "I will give unto him that is munchies of the fountain of the cravings of life, freely."
	icon_state = "seed-whitecannabis"
	species = "whitecannabis"
	plantname = "Lifeweed"
	product = /obj/item/reagent_containers/food/snacks/grown/cannabis/white
	mutatelist = list()
	reagents_add = list(/datum/reagent/medicine/omnizine = 0.35, /datum/reagent/drug/space_drugs = 0.15, /datum/reagent/toxin/lipolicide = 0.15)
	rarity = 40


// ---------------------------------------------------------------

/obj/item/reagent_containers/food/snacks/grown/cannabis
	seed = /obj/item/seeds/cannabis
	icon = 'goon/icons/obj/hydroponics.dmi'
	name = "cannabis leaf"
	desc = "Also known as marijuana."
	icon_state = "cannabis"
	filling_color = "#00FF00"
	bitesize_mod = 2
	foodtype = VEGETABLES //i dont really know what else weed could be to be honest
	tastes = list("cannabis" = 1)
	wine_power = 20


/obj/item/reagent_containers/food/snacks/grown/cannabis/white
	seed = /obj/item/seeds/cannabis/white
	name = "white cannabis leaf"
	desc = "It feels smooth and nice to the touch."
	foodtype = VEGETABLES | ANTITOXIC
	icon_state = "whitecannabis"
	wine_power = 10
