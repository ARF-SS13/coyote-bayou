/obj/item/projectile/bullet/gyro
	name ="explosive bolt"
	icon_state= "bolter"
	damage = 50

/obj/item/projectile/bullet/gyro/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, 0, 2)
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/a84mm
	name ="\improper HEDP rocket"
	desc = "USE A WEEL GUN"
	icon_state= "84mm-hedp"
	damage = 0
	armour_penetration = 0.01
	ricochets_max = 0
	var/anti_armour_damage = 200

/obj/item/projectile/bullet/a84mm/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, 1, 3, 1, 0, flame_range = 4)

	if(ismecha(target))
		var/obj/mecha/M = target
		M.take_damage(anti_armour_damage)
	if(issilicon(target))
		var/mob/living/silicon/S = target
		S.take_overall_damage(anti_armour_damage*0.75, anti_armour_damage*0.25)
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/a84mm_incend
	name ="\improper incendiary missile"
	desc = "Fwoosh."
	icon_state = "missile" //temp until sprites
	ricochets_max = 0
	damage = 15
	var/fire_stacks = 8
	damage_type = BURN

/obj/item/projectile/bullet/a84mm_incend/on_hit(atom/target, blocked=0)
	..()
	explosion(target, -1, -1, -1, -1, 4, flame_range = 5)
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		C.adjustFireLoss(20)
	for(var/mob/living/carbon/C in view(5,target))
		if(istype(C))
			C.adjust_fire_stacks(fire_stacks)
			C.IgniteMob()
			to_chat(C, "<span class='userdanger'>The incendiary rocket sets you ablaze!</span>")
			C.emote("scream")
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/a84mm_incend/Move()
	. = ..()
	var/turf/location = get_turf(src)
	if(location)
		new /obj/effect/hotspot(location)
		location.hotspot_expose(700, 50, 1)

/obj/item/projectile/bullet/a84mm_chem
	name ="\improper chemical payload missile"
	desc = "Rocket propelled chemical warfare."
	icon_state = "missile"
	ricochets_max = 0 //it's a MISSILE
	damage = 0

/obj/item/projectile/bullet/a84mm_chem/Initialize()
	. = ..()
	create_reagents(120, NO_REAGENTS_VALUE)
	reagents.add_reagent(/datum/reagent/toxin/anacea, 30)
	reagents.add_reagent(/datum/reagent/toxin/amatoxin, 30)
	reagents.add_reagent(/datum/reagent/toxin/cyanide, 30)
	reagents.add_reagent(/datum/reagent/toxin/bungotoxin, 30)

/obj/item/projectile/bullet/a84mm_chem/on_hit(atom/target, blocked=0)
	var/turf/T = get_turf(target)
	if(T)
		var/datum/effect_system/smoke_spread/chem/smoke = new()
		smoke.set_up(reagents, 5, T)
		smoke.start()
	..(target, blocked)
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/a84mm_he
	name ="\improper low yield HE missile"
	desc = "Boom."
	icon_state = "missile"
	damage = 25
	ricochets_max = 0 //it's a MISSILE

/obj/item/projectile/bullet/a84mm_he/on_hit(atom/target, blocked=0)
	..()
	explosion(target, 0, 0, 2, 4)
	new /obj/effect/temp_visual/explosion(get_turf(target))
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/a84mm_he_big
	name ="\improper high yield HE missile"
	desc = "Boom plus."
	icon_state = "missile"
	damage = 15
	ricochets_max = 0 //it's a MISSILE

/obj/item/projectile/bullet/a84mm_he_big/on_hit(atom/target, blocked=0)
	..()
	explosion(target, 0, 3, 5, 5)
	new /obj/effect/temp_visual/explosion(get_turf(target))
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/a84mm_br
	name ="\improper APHE missile"
	desc = "Boom."
	icon_state = "missile"
	damage = 20
	armour_penetration = 0.25
	ricochets_max = 0 //Guess what? Still a MISSILE
	var/sturdy = list(
	/turf/closed,
	/obj/mecha,
	/obj/machinery/door,
	/obj/machinery/door/poddoor/shutters
	)

/obj/item/broken_missile
	name = "\improper broken missile"
	desc = "A missile that did not detonate. The tail has snapped and it is in no way fit to be used again."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "missile_broken"
	w_class = WEIGHT_CLASS_TINY


/obj/item/projectile/bullet/a84mm_br/on_hit(atom/target, blocked=0)
	..()
	for(var/i in sturdy)
		if(istype(target, i))
			explosion(target, 0, 1, 1, 2)
			return BULLET_ACT_HIT
	new /obj/item/broken_missile(get_turf(src), 1)
