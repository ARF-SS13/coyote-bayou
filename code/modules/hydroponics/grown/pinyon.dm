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
