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
