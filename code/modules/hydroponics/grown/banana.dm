// Banana
/obj/item/seeds/banana
	name = "pack of banana seeds"
	desc = "They're seeds that grow into banana trees. When grown, keep away from clown."
	icon_state = "seed-banana"
	species = "banana"
	plantname = "Banana Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/banana
	lifespan = 50
	endurance = 30
	instability = 10
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_dead = "banana-dead"
	genes = list(/datum/plant_gene/trait/slip, /datum/plant_gene/trait/repeated_harvest)
	mutatelist = (/obj/item/seeds/banana/exotic_banana)
	reagents_add = list(
		/datum/reagent/consumable/banana = 0.1,
		/datum/reagent/potassium = 0.1,
		/datum/reagent/consumable/nutriment/vitamin = 0.04,
		/datum/reagent/consumable/nutriment = 0.02
	)

/obj/item/reagent_containers/food/snacks/grown/banana
	seed = /obj/item/seeds/banana
	name = "banana"
	desc = "It's an excellent prop for a clown."
	icon_state = "banana"
	inhand_icon_state = "banana"
	trash = /obj/item/grown/bananapeel
	filling_color = "#FFFF00"
	bitesize = 5
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/banana = 0)

/obj/item/reagent_containers/food/snacks/grown/banana/generate_trash(atom/location)
	. = ..()
	var/obj/item/grown/bananapeel/peel = .
	if(istype(peel))
		peel.grind_results = list(/datum/reagent/consumable/banana_peel = seed.potency * 0.2)

//Banana Peel
/obj/item/grown/bananapeel
	seed = /obj/item/seeds/banana
	name = "banana peel"
	desc = "A peel from a banana."
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	icon_state = "banana_peel"
	inhand_icon_state = "banana_peel"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 7

//Banana Spider.
/obj/item/seeds/banana/exotic_banana
	name = "pack of exotic banana seeds"
	desc = "They're seeds that grow into banana trees. However, those bananas might be alive."
	icon_state = "seed-exoticbanana"
	species = "exoticbanana"
	icon_harvest = "banana-harvest"
	icon_grow = "banana-grow"
	plantname = "Exotic Banana Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/banana/banana_spider_spawnable
	mutatelist = list()
	genes = list(/datum/plant_gene/trait/slip)

/obj/item/reagent_containers/food/snacks/grown/banana/banana_spider_spawnable
	seed = /obj/item/seeds/banana/exotic_banana
	name = "banana spider"
	desc = "You do not know what it is, but you can bet the clown would love it."
	icon_state = "exoticbanana"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	foodtype = GROSS | MEAT | RAW | FRUIT
	grind_results = list(/datum/reagent/blood = 20, /datum/reagent/liquidgibs = 5)
	var/awakening = 0

/obj/item/reagent_containers/food/snacks/grown/banana/banana_spider_spawnable/attack_self(mob/user)
	if(awakening || isspaceturf(user.loc))
		return
	to_chat(user, span_notice("You decide to wake up the banana spider..."))
	awakening = 1

	spawn(30)
		if(!QDELETED(src))
			var/mob/living/simple_animal/banana_spider/S = new /mob/living/simple_animal/banana_spider(get_turf(src.loc))
			S.speed += round(10 / max(seed.potency, 1), 1)
			S.visible_message(span_notice("The banana spider chitters as it stretches its legs."))
			qdel(src)

/*
// Bluespace Banana
/obj/item/seeds/banana/bluespace
	name = "pack of bluespace banana seeds"
	desc = "They're seeds that grow into bluespace banana trees. When grown, keep away from bluespace clown."
	icon_state = "seed-banana-blue"
	species = "bluespacebanana"
	icon_grow = "banana-grow"
	plantname = "Bluespace Banana Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/banana/bluespace
	mutatelist = list()
	genes = list(/datum/plant_gene/trait/slip, /datum/plant_gene/trait/teleport, /datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/bluespace = 0.2, /datum/reagent/consumable/banana = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.02)
	rarity = 30

/obj/item/reagent_containers/food/snacks/grown/banana/bluespace
	seed = /obj/item/seeds/banana/bluespace
	name = "bluespace banana"
	icon_state = "banana_blue"
	inhand_icon_state = "bluespace_peel"
	trash = /obj/item/grown/bananapeel/bluespace
	filling_color = "#0000FF"
	tastes = list("banana" = 1)
	wine_power = 60
	wine_flavor = "slippery hypercubes"

/obj/item/grown/bananapeel/bluespace
	seed = /obj/item/seeds/banana/bluespace
	name = "bluespace banana peel"
	desc = "A peel from a bluespace banana."
	icon_state = "banana_peel_blue"
*/
