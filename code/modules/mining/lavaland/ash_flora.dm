/obj/structure/flora/ash
	gender = PLURAL
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER //sporangiums up don't shoot
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "l_mushroom"
	name = "large mushrooms"
	desc = "A number of large mushrooms, covered in a faint layer of ash and what can only be spores."
	var/harvested_name = "shortened mushrooms"
	var/harvested_desc = "Some quickly regrowing mushrooms, formerly known to be quite large."
	var/needs_sharp_harvest = TRUE
	var/harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/shavings
	var/harvest_amount_low = 1
	var/harvest_amount_high = 3
	var/harvest_time = 60
	var/harvest_message_low = "You pick a mushroom, but fail to collect many shavings from its cap."
	var/harvest_message_med = "You pick a mushroom, carefully collecting the shavings from its cap."
	var/harvest_message_high = "You harvest and collect shavings from several mushroom caps."
	var/harvested = FALSE
	var/base_icon
	var/regrowth_time_low = 8 MINUTES
	var/regrowth_time_high = 16 MINUTES

/obj/structure/flora/ash/Initialize()
	. = ..()
	base_icon = "[icon_state][rand(1, 4)]"
	icon_state = base_icon

/obj/structure/flora/ash/proc/harvest(user)
	if(harvested)
		return 0

	var/rand_harvested = rand(harvest_amount_low, harvest_amount_high)
	if(rand_harvested)
		if(user)
			var/msg = harvest_message_med
			if(rand_harvested == harvest_amount_low)
				msg = harvest_message_low
			else if(rand_harvested == harvest_amount_high)
				msg = harvest_message_high
			to_chat(user, span_notice("[msg]"))
		for(var/i in 1 to rand_harvested)
			new harvest(get_turf(src))

	icon_state = "[base_icon]p"
	name = harvested_name
	desc = harvested_desc
	harvested = TRUE
	addtimer(CALLBACK(src,PROC_REF(regrow)), rand(regrowth_time_low, regrowth_time_high))
	return 1

/obj/structure/flora/ash/proc/regrow()
	icon_state = base_icon
	name = initial(name)
	desc = initial(desc)
	harvested = FALSE

/obj/structure/flora/ash/attackby(obj/item/W, mob/user, params)
	if(!harvested && needs_sharp_harvest && W.sharpness)
		user.visible_message(span_notice("[user] starts to harvest from [src] with [W]."),span_notice("You begin to harvest from [src] with [W]."))
		if(do_after(user, harvest_time, target = src))
			harvest(user)
	else
		return ..()

/obj/structure/flora/ash/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(!harvested && !needs_sharp_harvest)
		user.visible_message(span_notice("[user] starts to harvest from [src]."),span_notice("You begin to harvest from [src]."))
		if(do_after(user, harvest_time, target = src))
			harvest(user)

/obj/structure/flora/ash/tall_shroom //exists only so that the spawning check doesn't allow these spawning near other things
	regrowth_time_low = 4200

/obj/structure/flora/ash/leaf_shroom
	icon_state = "s_mushroom"
	name = "leafy mushrooms"
	desc = "A number of mushrooms, each of which surrounds a greenish sporangium with a number of leaf-like structures."
	harvested_name = "leafless mushrooms"
	harvested_desc = "A bunch of formerly-leafed mushrooms, with their sporangiums exposed. Scandalous?"
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_leaf
	needs_sharp_harvest = FALSE
	harvest_amount_high = 4
	harvest_time = 20
	harvest_message_low = "You pluck a single, suitable leaf."
	harvest_message_med = "You pluck a number of leaves, leaving a few unsuitable ones."
	harvest_message_high = "You pluck quite a lot of suitable leaves."
	regrowth_time_low = 2400
	regrowth_time_high = 6000

/obj/structure/flora/ash/cap_shroom
	icon_state = "r_mushroom"
	name = "tall mushrooms"
	desc = "Several mushrooms, the larger of which have a ring of conks at the midpoint of their stems."
	harvested_name = "small mushrooms"
	harvested_desc = "Several small mushrooms near the stumps of what likely were larger mushrooms."
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_cap
	harvest_amount_high = 4
	harvest_time = 50
	harvest_message_low = "You slice the cap off a mushroom."
	harvest_message_med = "You slice off a few conks from the larger mushrooms."
	harvest_message_high = "You slice off a number of caps and conks from these mushrooms."
	regrowth_time_low = 3000
	regrowth_time_high = 5400

/obj/structure/flora/ash/stem_shroom
	icon_state = "t_mushroom"
	name = "numerous mushrooms"
	desc = "A large number of mushrooms, some of which have long, fleshy stems. They're radiating light!"
	light_range = 1.5
	light_power = 2.1
	harvested_name = "tiny mushrooms"
	harvested_desc = "A few tiny mushrooms around larger stumps. You can already see them growing back."
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/mushroom_stem
	harvest_amount_high = 4
	harvest_time = 40
	harvest_message_low = "You pick and slice the cap off a mushroom, leaving the stem."
	harvest_message_med = "You pick and decapitate several mushrooms for their stems."
	harvest_message_high = "You acquire a number of stems from these mushrooms."
	regrowth_time_low = 3000
	regrowth_time_high = 6000

/obj/structure/flora/ash/cacti
	icon_state = "cactus"
	name = "fruiting cacti"
	desc = "Several prickly cacti, brimming with ripe fruit and covered in a thin layer of ash."
	harvested_name = "cacti"
	harvested_desc = "A bunch of prickly cacti. You can see fruits slowly growing beneath the covering of ash."
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/cactus_fruit
	needs_sharp_harvest = FALSE
	harvest_amount_high = 2
	harvest_time = 10
	harvest_message_low = "You pick a cactus fruit."
	harvest_message_med = "You pick several cactus fruit." //shouldn't show up, because you can't get more than two
	harvest_message_high = "You pick a pair of cactus fruit."
	regrowth_time_low = 4800
	regrowth_time_high = 7200

/obj/structure/flora/ash/cacti/Initialize(mapload)
	. = ..()
	// min dmg 3, max dmg 6, prob(70)
	AddComponent(/datum/component/caltrop, 3, 6, 70)

/obj/item/reagent_containers/food/snacks/grown/ash_flora
	name = "mushroom shavings"
	desc = "Some shavings from a tall mushroom. With enough, might serve as a bowl."
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "mushroom_shavings"
	list_reagents = list(/datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/ethanol = 2, /datum/reagent/stabilizing_agent = 3, /datum/reagent/toxin/minttoxin = 2)
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	max_integrity = 100
	seed = /obj/item/seeds/lavaland/polypore
	wine_power = 20

/obj/item/reagent_containers/food/snacks/grown/ash_flora/Initialize()
	. = ..()
	pixel_x = rand(-4, 4)
	pixel_y = rand(-4, 4)

/obj/item/reagent_containers/glass/bowl/mushroom_bowl
	name = "mushroom bowl"
	desc = "A bowl made out of mushrooms. Not food, though it might have contained some at some point."
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "mushroom_bowl"

/obj/item/reagent_containers/glass/bowl/mushroom_bowl/update_icon_state()
	if(!reagents || !reagents.total_volume)
		icon_state = "mushroom_bowl"

/obj/item/reagent_containers/glass/bowl/mushroom_bowl/update_overlays()
	. = ..()
	if(reagents && reagents.total_volume)
		. += mutable_appearance('icons/obj/lavaland/ash_flora.dmi', "fullbowl", color = mix_color_from_reagents(reagents.reagent_list))

/obj/item/reagent_containers/glass/bowl/mushroom_bowl/attackby(obj/item/I,mob/user, params)
	if(istype(I, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/S = I
		if(I.w_class > WEIGHT_CLASS_SMALL)
			to_chat(user, span_warning("The ingredient is too big for [src]!"))
		else if(contents.len >= 20)
			to_chat(user, span_warning("You can't add more ingredients to [src]!"))
		else
			if(reagents.has_reagent(/datum/reagent/water, 10)) //are we starting a soup or a salad?
				var/obj/item/reagent_containers/food/snacks/customizable/A = new/obj/item/reagent_containers/food/snacks/customizable/soup/ashsoup(get_turf(src))
				A.initialize_custom_food(src, S, user)
			else
				var/obj/item/reagent_containers/food/snacks/customizable/A = new/obj/item/reagent_containers/food/snacks/customizable/salad/ashsalad(get_turf(src))
				A.initialize_custom_food(src, S, user)
	else
		. = ..()

//COYOTE - Wooden Bowls
/obj/item/reagent_containers/glass/bowl/wooden_bowl
	name = "wooden bowl"
	desc = "A hand-carved wooden bowl, for all your bowl-related needs."
	custom_materials = list(/datum/material/wood = 500) // So that they don't show as made of glass
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "wooden_bowl"
	fill_icon = 'icons/obj/lavaland/ash_flora.dmi'
	fill_state =  "woodenfullbowl"

/obj/item/reagent_containers/glass/bowl/wooden_bowl/update_icon_state()
	if(!reagents || !reagents.total_volume)
		icon_state = "wooden_bowl"

/obj/item/reagent_containers/glass/bowl/wooden_bowl/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/S = I
		if(I.w_class > WEIGHT_CLASS_SMALL)
			to_chat(user, span_warning("The ingredient is too big for [src]!"))
		else if(contents.len >= 20)
			to_chat(user, span_warning("You can't add more ingredients to [src]!"))
		else
			if(reagents.has_reagent(/datum/reagent/water, 10)) //are we starting a soup or a salad?
				var/obj/item/reagent_containers/food/snacks/customizable/A = new/obj/item/reagent_containers/food/snacks/customizable/soup/woodsoup(get_turf(src))
				A.initialize_custom_food(src, S, user)
			else
				var/obj/item/reagent_containers/food/snacks/customizable/A = new/obj/item/reagent_containers/food/snacks/customizable/salad/woodsalad(get_turf(src))
				A.initialize_custom_food(src, S, user)
	else
		. = ..()

////// LAVALAND FLORA was moved to mushrooms.dm in hydroponics //////

//what you can craft with these things
/* COYOTE - Commented out crafting recipe as no mushrooms are here! The one below this is also an optional, but also commented out variety. Actually in sheet_types.dm
/datum/crafting_recipe/mushroom_bowl
	name = "Mushroom Bowl"
	result = /obj/item/reagent_containers/glass/bowl/mushroom_bowl
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/ash_flora/shavings = 5)
	time = 30
	category = CAT_PRIMAL

/datum/crafting_recipe/wooden_bowl
	name = "Wooden Bowl"
	result = /obj/item/reagent_containers/glass/bowl/wooden_bowl
	reqs = list(/obj/item/stack/sheet/mineral/wood = 3)
	time = 30
	category = CAT_PRIMAL
*/

/obj/item/reagent_containers/food/snacks/customizable/salad/woodsalad
	desc = "A hand-made salad in a hand-made bowl. Now to find some hand-made hands to eat it with..."
	trash = /obj/item/reagent_containers/glass/bowl/wooden_bowl
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "wooden_bowl"

/obj/item/reagent_containers/food/snacks/customizable/soup/woodsoup
	desc = "A wooden bowl with a homemade soup. Hope it's good!"
	trash = /obj/item/reagent_containers/glass/bowl/wooden_bowl
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "wooden_soup"

/obj/item/reagent_containers/food/snacks/customizable/salad/ashsalad
	desc = "Very ashy."
	trash = /obj/item/reagent_containers/glass/bowl/mushroom_bowl
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "mushroom_bowl"

/obj/item/reagent_containers/food/snacks/customizable/soup/ashsoup
	desc = "A bowl with ash and... stuff in it."
	trash = /obj/item/reagent_containers/glass/bowl/mushroom_bowl
	icon = 'icons/obj/lavaland/ash_flora.dmi'
	icon_state = "mushroom_soup"
