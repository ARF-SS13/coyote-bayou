// Watermelon
/obj/item/seeds/watermelon
	name = "pack of watermelon seeds"
	desc = "These seeds grow into watermelon plants."
	icon_state = "seed-watermelon"
	species = "watermelon"
	plantname = "Watermelon Vines"
	product = /obj/item/reagent_containers/food/snacks/grown/watermelon
	lifespan = 50
	endurance = 40
	instability = 20
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_dead = "watermelon-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/watermelon/holy)
	reagents_add = list(
		/datum/reagent/water = 0.2,
		/datum/reagent/consumable/nutriment/vitamin = 0.04,
		/datum/reagent/consumable/nutriment = 0.2
	)

/obj/item/reagent_containers/food/snacks/grown/watermelon
	seed = /obj/item/seeds/watermelon
	name = "watermelon"
	desc = "It's full of watery goodness."
	icon_state = "watermelon"
	slice_path = /obj/item/reagent_containers/food/snacks/watermelonslice
	slices_num = 5
	dried_type = null
	w_class = WEIGHT_CLASS_NORMAL
	filling_color = "#008000"
	bitesize_mod = 3
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/watermelonjuice = 0)
	wine_power = 40

// Holymelon
/obj/item/seeds/watermelon/holy
	name = "pack of goldenmelon seeds"
	desc = "These seeds grow into goldenmelon plants."
	icon_state = "seed-holymelon"
	species = "holymelon"
	plantname = "Golden Melon Vines"
	product = /obj/item/reagent_containers/food/snacks/grown/holymelon
	genes = list(/datum/plant_gene/trait/glow/yellow)
	mutatelist = list()
	reagents_add = list(
		/datum/reagent/gold = 0.2,
		/datum/reagent/consumable/nutriment/vitamin = 0.04,
		/datum/reagent/consumable/nutriment = 0.1
	)
	rarity = 20

/obj/item/reagent_containers/food/snacks/grown/holymelon
	seed = /obj/item/seeds/watermelon/holy
	name = "goldenmelon"
	desc = "This melon shimmers with golden goodness."
	icon_state = "holymelon"
	filling_color = "#FFD700"
	dried_type = null
	wine_power = 70 //Water to wine, baby.
	wine_flavor = "divinity"

/*
/obj/item/reagent_containers/food/snacks/grown/holymelon/Initialize()
	. = ..()
	var/uses = 1
	if(seed)
		uses = round(seed.potency / 20)
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, INV_SLOTBIT_HANDS, uses, TRUE, CALLBACK(src,PROC_REF(block_magic)), CALLBACK(src,PROC_REF(expire))) //deliver us from evil o melon god

/obj/item/reagent_containers/food/snacks/grown/holymelon/proc/block_magic(mob/user, major)
	if(major)
		to_chat(user, span_warning("[src] hums slightly, and seems to decay a bit."))

/obj/item/reagent_containers/food/snacks/grown/holymelon/proc/expire(mob/user)
	to_chat(user, span_warning("[src] rapidly turns into ash!"))
	qdel(src)
	new /obj/effect/decal/cleanable/ash(drop_location())
*/
