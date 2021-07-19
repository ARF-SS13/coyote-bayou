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


// Molotov Cocktail
/obj/item/grenade/homemade/molotov
	name = "molotov cocktail"
	desc = "A bottle with flammable stuff and a rag. Either drink it or set it on fire and chuck it at people you don't like."
	icon_state = "molotov"
	item_state = "ied"

/obj/item/grenade/homemade/molotov/attack_self(mob/user) //
	if(!active)
		if(!botch_check(user))
			to_chat(user, "<span class='warning'>You light the rag!</span>")
			primefuse(user, null, FALSE)

/obj/item/grenade/homemade/molotov/prime(mob/living/lanced_by) //Blowing that can up
	. = ..()
	update_mob()
	explosion(src.loc,-1, flame_range = 3)	// tiny explosion, plus a large fireball.
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
