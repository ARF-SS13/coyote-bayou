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
