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
	reagents_add = list(
		/datum/reagent/consumable/nutriment = 0.2,
		/datum/reagent/water = 0.1,
		/datum/reagent/consumable/nutriment/vitamin = 0.05,
		/datum/reagent/medicine/neurine = 0.05,
		/datum/reagent/medicine/mutadone = 0.05
	)
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
	to_chat(C, span_userdanger("The thorns pierce your bare hand!"))
	return TRUE
