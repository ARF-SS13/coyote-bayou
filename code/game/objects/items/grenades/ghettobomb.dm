//improvised explosives//obsolete

/obj/item/grenade/iedcasing
	name = "improvised firebomb"
	desc = "A weak, improvised incendiary device."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/grenade.dmi'
	icon_state = "improvised_grenade"
	item_state = "flashbang"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	throw_speed = 3
	throw_range = 7
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	active = 0
	det_time = 50
	display_timer = 0
	var/range = 3
	var/list/times

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
			to_chat(user, "<span class='warning'>You light the [name]!</span>")
			cut_overlay("improvised_grenade_filled")
			preprime(user, null, FALSE)

/obj/item/grenade/iedcasing/prime(mob/living/lanced_by) //Blowing that can up obsolete
	. = ..()
	update_mob()
	explosion(src.loc,-1,-1,2, flame_range = 4)	// small explosion, plus a very large fireball.
	qdel(src)

/obj/item/grenade/iedcasing/examine(mob/user) // obsolete
	. = ..()
	. += "You can't tell when it will explode!"


// Homemade bomb template
/obj/item/grenade/homemade
	name = "home-made bomb template "
	icon = 'icons/fallout/objects/guns/explosives.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/special_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/special_righthand.dmi'
	item_state = "ied"
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	throw_speed = 3
	throw_range = 6
	active = 0
	det_time = 50
	display_timer = 0
	var/range = 3
	var/list/times

/obj/item/grenade/homemade/Initialize()
	. = ..()
	times = list("5" = 5, "-1" = 5, "[rand(25,60)]" = 60, "[rand(65,180)]" = 30)// "Premature, Dud, Short Fuse, Long Fuse"=[weighting value]
	det_time = text2num(pickweight(times))
	if(det_time < 0) //checking for 'duds'
		range = 1
		det_time = rand(30,80)
	else
		range = pick(2,2,2,3,3,3,4)

/obj/item/grenade/homemade/attack_self(mob/user) //
	if(!active)
		if(!botch_check(user))
			to_chat(user, "<span class='warning'>You light the [name]!</span>")
			preprime(user, null, FALSE)

/obj/item/grenade/homemade/examine(mob/user)
	. = ..()
	. += "You can't tell when it will explode!"


// Coffeepot Bomb
/obj/item/grenade/homemade/coffeepotbomb
	name = "coffeepot bomb"
	desc = "What happens when you fill a coffeepot with blackpowder and bits of metal, then hook up a eggclock timer to a wire stuck inside? Better throw it far away before finding out. Too bad its pretty heavy so its hard to throw far."
	icon_state = "coffeebomb"
	item_state = "coffeebomb"
	throw_range = 4
	var/datum/looping_sound/reverse_bear_trap/soundloop

/obj/item/grenade/homemade/coffeepotbomb/Initialize()
	. = ..()
	soundloop = new(list(src), FALSE)

/obj/item/grenade/homemade/coffeepotbomb/attack_self(mob/user) //
	if(!active)
		if(!botch_check(user))
			to_chat(user, "<span class='warning'>You start the timer! Tick tock</span>")
			primetimer(user, null, FALSE)
			soundloop.start()

/obj/item/grenade/homemade/coffeepotbomb/prime(mob/living/lanced_by)
	. = ..()
	update_mob()
	explosion(src.loc, 0, 1, 2, 3, 0, flame_range = 2)
	qdel(src)


// Firebomb
/obj/item/grenade/homemade/firebomb
	name = "firebomb"
	desc = "A firebomb, basically a metal flask filled with fuel and a crude igniter to cause a small explosion that sends burning fuel over a large area."
	icon_state = "firebomb"
	item_state = "ied"

/obj/item/grenade/homemade/firebomb/prime(mob/living/lanced_by) //Blowing that can up obsolete
	. = ..()
	update_mob()
	explosion(src.loc,-1,-1,2, flame_range = 4)	// small explosion, plus a very large fireball.
	qdel(src)


// Molotov Cocktail
/obj/item/reagent_containers/food/drinks/bottle/molotov
	name = "molotov cocktail"
	desc = "A empty bottle with a rag in it. Needs to be filled with a flammable liquid before being lit on fire and chucked at someone you don't like."
	icon = 'icons/fallout/objects/guns/explosives.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/special_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/special_righthand.dmi'
	icon_state = "molotov"
	item_state = "ied"
	list_reagents = list()
	var/list/accelerants = list(
		/datum/reagent/consumable/ethanol,
		/datum/reagent/fuel,
		/datum/reagent/clf3,
		/datum/reagent/phlogiston,
		/datum/reagent/napalm,
		/datum/reagent/hellwater,
		/datum/reagent/toxin/plasma,
		/datum/reagent/toxin/spore_burning,
		)
	var/active = FALSE

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

/obj/item/reagent_containers/food/drinks/bottle/molotov/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/firestarter = FALSE
	for(var/datum/reagent/reagent_in_bottle as anything in reagents.reagent_list)
		for(var/accelerant_type in accelerants)
			if(istype(reagent_in_bottle, accelerant_type))
				firestarter = TRUE
				break
	if(firestarter && active)
		hit_atom.fire_act()
		new /obj/effect/hotspot(get_turf(hit_atom))
	return ..()

/obj/item/reagent_containers/food/drinks/bottle/molotov/attackby(obj/item/I, mob/user, params)
	if(I.get_temperature() && !active)
		active = TRUE
		var/message = "[ADMIN_LOOKUP(user)] has primed a [name] for detonation at [ADMIN_VERBOSEJMP(user)]."
		GLOB.bombers += message
		message_admins(message)
		log_game("[key_name(user)] has primed a [name] for detonation at [AREACOORD(user)].")

		to_chat(user, "<span class='info'>You light [src] on fire.</span>")
		icon_state = initial(icon_state) + "_active"
		item_state = initial(item_state) + "_active"
		if(isGlass)
			return
		addtimer(CALLBACK(src, .proc/splash_and_boom), 5 SECONDS)


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
	SplashReagents(target)
	target.fire_act()
	qdel(src)

/obj/item/reagent_containers/food/drinks/bottle/molotov/attack_self(mob/user)
	if(active)
		if(!isGlass)
			to_chat(user, "<span class='danger'>The flame's spread too far on it!</span>")
			return
		to_chat(user, "<span class='info'>You snuff out the flame on [src].</span>")
		cut_overlay(GLOB.fire_overlay)
		active = FALSE

/obj/item/export/bottle/attack_self(mob/user)
	to_chat(user, "<span class='danger'>The seal seems fine. Best to not open it.</span>")
