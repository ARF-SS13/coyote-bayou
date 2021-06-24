/obj/item/grenade/smokebomb
	name = "smoke grenade"
	desc = "The word 'Dank' is scribbled on it in crayon."
	icon = 'icons/obj/grenade.dmi'
	icon_state = "smokewhite"
	det_time = 20
	item_state = "flashbang"
	slot_flags = ITEM_SLOT_BELT
	var/datum/effect_system/smoke_spread/bad/smoke

/obj/item/grenade/smokebomb/New()
	..()
	src.smoke = new /datum/effect_system/smoke_spread/bad
	src.smoke.attach(src)

/obj/item/grenade/smokebomb/Destroy()
	qdel(smoke)
	return ..()

/obj/item/grenade/smokebomb/prime(mob/living/lanced_by)
	. = ..()
	update_mob()
	playsound(src.loc, 'sound/effects/smoke.ogg', 50, 1, -3)
	smoke.set_up(4, src)
	smoke.start()


	for(var/obj/structure/blob/B in view(8,src))
		var/damage = round(30/(get_dist(B,src)+1))
		B.take_damage(damage, BURN, "melee", 0)
	sleep(80)
	qdel(src)


/obj/item/grenade/smokebomb/ncr
	name = "ncr smoke grenade"
	desc = "NCR issue. Not as good as the pre-war ones but there's a lot of them. The fuse is very short."
	icon = 'icons/obj/grenade.dmi'
	icon_state = "smokewhite"
	det_time = 10
	item_state = "flashbang"
	slot_flags = ITEM_SLOT_BELT

/obj/item/grenade/smokebomb/ncr/New()
	..()
	src.smoke = /datum/effect_system/smoke_spread/bad
	src.smoke.attach(src)

/obj/item/grenade/smokebomb/ncr/Destroy()
	qdel(smoke)
	return ..()

/obj/item/grenade/smokebomb/ncr/prime(mob/living/lanced_by)
	. = ..()
	update_mob()
	playsound(src.loc, 'sound/effects/smoke.ogg', 50, 1, -3)
	smoke.set_up(3, src)
	smoke.start()


	for(var/obj/structure/blob/B in view(8,src))
		var/damage = round(30/(get_dist(B,src)+1))
		B.take_damage(damage, BURN, "melee", 0)
	sleep(80)
	qdel(src)
