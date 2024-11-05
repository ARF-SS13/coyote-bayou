/obj/item/grenade/f13
	name = "testing grenade"
	desc = "If you are seeing this something went wrong."
	icon = 'icons/obj/grenade.dmi'
	icon_state = "syndicate"
	inhand_icon_state = "flashbang"
	ex_dev = 0
	ex_heavy = 0
	ex_light = 0
	ex_flame = 0

/obj/item/grenade/f13/prime(mob/living/lanced_by)
	. = ..()
	update_mob()
	qdel(src)

/obj/item/grenade/f13/stinger
	name = "stinger grenade"
	desc = "A nonlethal sting-pellet grenade used for riot suppression Pre-Fall."
	icon_state = "stinger"
	throw_speed = 4
	throw_range = 7
	ex_dev = 0
	ex_heavy = 0
	ex_light = 0
	ex_flame = 0
	shrapnel_type = /obj/item/projectile/bullet/pellet/stingball
	shrapnel_radius = 8

/obj/item/grenade/f13/frag
	name = "frag grenade"
	desc = "A prefall military-grade fragmentation grenade with short fuse. Useless against hard armor."
	icon_state = "frag_new"
	throw_speed = 4
	throw_range = 7
	ex_dev = 0
	ex_heavy = 0
	ex_light = 2
	ex_flame = 0
	shrapnel_type = /obj/item/projectile/bullet/shrapnel
	shrapnel_radius = 6

/obj/item/grenade/f13/plasma
	name = "plasma grenade"
	desc = "A prefall military-grade plasma grenade, used for permanent riot suppression Pre-Fall."
	icon_state = "plasma"
	throw_speed = 4
	throw_range = 7
	ex_dev = 0
	ex_heavy = 1
	ex_light = 4
	ex_flame = 4
	shrapnel_type = /obj/item/projectile/bullet/shrapnel/plasma
	shrapnel_radius = 10
	var/rad_damage = 300

/obj/item/grenade/f13/plasma/prime(mob/living/lanced_by)
	. = ..()
	update_mob()
	playsound(loc, 'sound/effects/empulse.ogg', 50, 1)
	radiation_pulse(src, 300)
	qdel(src)

/obj/item/grenade/f13/incendiary
	name = "incendinary grenade"
	desc = "A prefall police supression grenade designed to cause as much agony as possible against large crowds of protestors, very hot."
	icon_state = "incendinary"
	throw_speed = 4
	throw_range = 7
	ex_dev = 0
	ex_heavy = 0
	ex_light = 0
	ex_flame = 5
	shrapnel_radius = 6
	var/fire_stacks = 4
	var/range = 4

/obj/item/grenade/f13/incendiary/prime(mob/living/lanced_by)
	. = ..()
	update_mob()
	for(var/turf/T in view(range,loc))
		if(isfloorturf(T))
			var/turf/open/floor/F = T
			F.hotspot_expose(700,50,1)
			for(var/mob/living/carbon/C in T)
				C.adjust_fire_stacks(fire_stacks)
				C.IgniteMob()
				to_chat(C, span_userdanger("The incendiary grenade sets you ablaze!"))
				C.emote("scream")
	qdel(src)

/obj/item/grenade/f13/radiation
	name = "radiation grenade"
	desc = "A grenade designed to release a strong pulse of gamma radiation through complex Pre-Fall science or...something."
	icon_state = "bluefrag"
	throw_speed = 4
	throw_range = 7
	var/rad_damage = 1500
	var/range = 4
	shrapnel_type = /obj/item/projectile/energy/nuclear_particle/grenade
	shrapnel_radius = 6

/obj/item/grenade/f13/radiation/prime(mob/living/lanced_by)
	. = ..()
	update_mob()
	playsound(loc, 'sound/effects/empulse.ogg', 50, 1)
	radiation_pulse(src, rad_damage)

/obj/item/grenade/f13/dynamite
	name = "stick of dynamite"
	desc = "A stick of good old-fashioned black-powder dynamite. While it doesnt pack as much of a punch as anything else, it'll give rock walls something to think about."
	icon = 'icons/fallout/objects/guns/explosives.dmi'
	icon_state = "dynamite"
	preprime_sound = 'sound/effects/fuse.ogg'
	ex_dev = 0
	ex_heavy = 0
	ex_light = 3
	ex_flame = 0
	w_class = WEIGHT_CLASS_TINY

/obj/item/storage/box/dynamite_box
	name = "dynamite crate"
	desc = "A box full of dynamite!"
	icon_state = "box_brown"
	illustration = "loose_ammo"

/obj/item/storage/box/dynamite_box/PopulateContents()
	. = ..()
	new /obj/item/grenade/f13/dynamite(src)
	new /obj/item/grenade/f13/dynamite(src)
	new /obj/item/grenade/f13/dynamite(src)
	new /obj/item/grenade/f13/dynamite(src)
	new /obj/item/grenade/f13/dynamite(src)
	new /obj/item/grenade/f13/dynamite(src)
	new /obj/item/grenade/f13/dynamite(src)
