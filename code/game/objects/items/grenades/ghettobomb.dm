// HOMEMADE BOMB TEMPLATE
/obj/item/grenade/homemade
	name = "home-made bomb template "
	icon = 'icons/fallout/objects/guns/explosives.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/special_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/special_righthand.dmi'
	inhand_icon_state = "ied"
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT //fenny stinky
	throw_speed = 3
	throw_range = 6
	active = 0
	det_time = 40
	display_timer = 0
	var/range = 3
	var/list/times

/obj/item/grenade/homemade/Initialize()
	. = ..()
	times = list("10" = 5, "-1" = 5, "[rand(25,35)]" = 60, "[rand(35,90)]" = 30)// "Premature, Dud, Short Fuse, Long Fuse"=[weighting value]
	det_time = text2num(pickweight(times))
	if(det_time < 0) //checking for 'duds'
		range = 1
		det_time = rand(30,80)
	else
		range = pick(2,2,2,3,3,3,4)

/obj/item/grenade/homemade/examine(mob/user)
	. = ..()
	. += "You can't tell when it will explode!"


////////////////////
// COFFEEPOT BOMB //
////////////////////  strong explosion, small area

/obj/item/grenade/homemade/coffeepotbomb
	name = "coffeepot bomb"
	desc = "What happens when you fill a coffeepot with blackpowder and bits of metal, then hook up a eggclock timer to a wire stuck inside? Better throw it far away before finding out. Cannot be thrown far."
	icon_state = "coffeebomb"
	inhand_icon_state = "coffeebomb"
	throw_range = 5
	var/datum/looping_sound/reverse_bear_trap/soundloop

/obj/item/grenade/homemade/coffeepotbomb/Initialize()
	. = ..()
	soundloop = new(list(src), FALSE)

/obj/item/grenade/homemade/coffeepotbomb/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/item/grenade/homemade/coffeepotbomb/preprime(mob/user, delayoverride, msg = TRUE, volume = 60)
	. = ..()
	if(soundloop)
		soundloop.start()

/obj/item/grenade/homemade/coffeepotbomb/prime(mob/living/lanced_by)
	. = ..()
	update_mob()
	explosion(src.loc, 1, 2, 2, 3, 0, flame_range = 1)
	qdel(src)


//////////////
// FIREBOMB //
//////////////

/obj/item/grenade/homemade/firebomb
	name = "firebomb"
	desc = "A firebomb, basically a metal flask filled with fuel and a crude igniter to cause a small explosion that sends burning fuel over a large area."
	icon_state = "firebomb"
	inhand_icon_state = "ied"

/obj/item/grenade/homemade/firebomb/prime(mob/living/lanced_by) //Blowing that can up obsolete
	. = ..()
	update_mob()
	explosion(src.loc,-1,-1,2, flame_range = 4)	// small explosion, plus a very large fireball.
	qdel(src)


//////////////////////
// MOLOTOV COCKTAIL //
//////////////////////

/obj/item/reagent_containers/food/drinks/bottle/molotov
	name = "molotov cocktail"
	desc = "A empty bottle with a rag in it. Needs to be filled with a flammable liquid before being lit on fire and chucked at someone you don't like."
	icon = 'icons/fallout/objects/guns/explosives.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/special_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/special_righthand.dmi'
	icon_state = "molotov"
	inhand_icon_state = "ied"
	list_reagents = list()
	volume = 50
	var/list/accelerants = list(
		/datum/reagent/consumable/ethanol = 1,
		/datum/reagent/fuel = 2,
		/datum/reagent/clf3 = 3,
		/datum/reagent/phlogiston = 4,
		/datum/reagent/blackpowder = 1,
		/datum/reagent/napalm = 3,
		/datum/reagent/hellwater = 4,
		/datum/reagent/toxin/plasma = 5,
		/datum/reagent/toxin/spore_burning = 7,
		)
	var/active = FALSE

// PREFILLED MOLOTOV for loadouts, mapping etc
/obj/item/reagent_containers/food/drinks/bottle/molotov/filled
	desc = "A molotov filled with napalm and ready to be thrown."
	list_reagents = list(/datum/reagent/napalm = 40)

/obj/item/reagent_containers/food/drinks/bottle/molotov/CheckParts(list/parts_list)
	. = ..()
	var/obj/item/reagent_containers/food/drinks/bottle/bottle_found = locate() in contents
	if(!bottle_found)
		return
	icon_state = bottle_found.icon_state
	bottle_found.reagents.copy_to(src, 100)
	if(!bottle_found.isGlass)
		desc = "[desc] You're not sure if making this out of a carton was the brightest idea."
		isGlass = FALSE

/obj/item/reagent_containers/food/drinks/bottle/molotov/bullet_act(obj/item/projectile/P)
	. = ..()
	make_boom()
	qdel(src)

/obj/item/reagent_containers/food/drinks/bottle/molotov/ex_act()
	make_boom()
	. = ..()

/obj/item/reagent_containers/food/drinks/bottle/molotov/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	make_boom()
	. = ..()
	qdel(src)

/obj/item/reagent_containers/food/drinks/bottle/molotov/attackby(obj/item/I, mob/user, params)
	if(I.get_temperature() && !active)
		active = TRUE
		var/message = "[ADMIN_LOOKUP(user)] primed [name] at [ADMIN_VERBOSEJMP(user)]."
		GLOB.bombers += message
		message_admins(message)
		log_game("[key_name(user)] primed [name] at [AREACOORD(user)].")

		to_chat(user, span_info("You light [src] on fire."))
		icon_state = initial(icon_state) + "_active"
		inhand_icon_state = initial(inhand_icon_state) + "_active"
		if(isGlass)
			return
		addtimer(CALLBACK(src,PROC_REF(splash_and_boom)), 5 SECONDS)

/obj/item/reagent_containers/food/drinks/bottle/molotov/proc/make_boom()
	var/boomsize
	var/extra_boom = 0
	for(var/datum/reagent/reagent_in_bottle as anything in reagents.reagent_list)
		if(reagent_in_bottle.volume < 1)
			continue
		if(!(reagent_in_bottle.type in accelerants))
			continue
		if(reagent_in_bottle.type == /datum/reagent/blackpowder && (reagent_in_bottle.volume > (volume * 0.8)))
			extra_boom = 1
		boomsize = accelerants[reagent_in_bottle.type] * (reagent_in_bottle.volume / volume)
	if(boomsize >= 1 || extra_boom)
		explosion(get_turf(src),-1, -1, extra_boom, flame_range = (boomsize + extra_boom))

/obj/item/reagent_containers/food/drinks/bottle/molotov/proc/splash_and_boom()
	if(QDELETED(src) || !active || isnull(loc))
		return
	var/atom/target = loc
	if(!isturf(target) && !isturf(target.loc))
		for(var/i in 1 to 3)
			target = target.loc
			if(isturf(target.loc))
				break
	if(!isturf(target))
		target = get_turf(target) // Too deep, let's just bypass to the end.
	make_boom()
	if(!QDELETED(src))
		SplashReagents(target)
	qdel(src)

/obj/item/reagent_containers/food/drinks/bottle/molotov/attack_self(mob/user)
	if(active)
		if(!isGlass)
			to_chat(user, span_danger("The flame's spread too far on it!"))
			return
		to_chat(user, span_info("You snuff out the flame on [src]."))
		cut_overlay(GLOB.fire_overlay)
		active = FALSE

/obj/item/export/bottle/attack_self(mob/user)
	to_chat(user, span_danger("The seal seems fine. Best to not open it."))


/obj/item/reagent_containers/glass/bottle/napalm
	name = "napalm mix"
	desc = "Add this mix to the molotov cocktail before lighting it." 
	list_reagents = list(/datum/reagent/napalm = 30)


/*IED code remnant, not used

/obj/item/grenade/iedcasing/Initialize()//obsolete
	. = ..()
	add_overlay("improvised_grenade_filled")
	add_overlay("improvised_grenade_wired")
	times = list("5" = 10, "-1" = 20, "[rand(30,80)]" = 50, "[rand(65,180)]" = 20)// "Premature, Dud, Short Fuse, Long Fuse"=[weighting value]
	det_time = text2num(pickweight(times))
	if(det_time < 0) //checking for 'duds'
		range = 1
		det_time = rand(30,80)
	else
		range = pick(2,2,2,3,3,3,4)

/obj/item/grenade/iedcasing/CheckParts(list/parts_list) //obsolete
	..()
	var/obj/item/reagent_containers/food/drinks/soda_cans/can = locate() in contents
	if(can)
		can.pixel_x = 0 //Reset the sprite's position to make it consistent with the rest of the IED
		can.pixel_y = 0
		var/mutable_appearance/can_underlay = new(can)
		can_underlay.layer = FLOAT_LAYER
		can_underlay.plane = FLOAT_PLANE
		underlays += can_underlay

/obj/item/grenade/iedcasing/attack_self(mob/user) //
	if(!active)
		if(!botch_check(user))
			to_chat(user, span_warning("You light the [name]!"))
			cut_overlay("improvised_grenade_filled")
			preprime(user, null, FALSE)
*/
