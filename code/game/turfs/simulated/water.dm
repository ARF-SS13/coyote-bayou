/turf/open/water
	gender = PLURAL
	name = "water"
	desc = "Shallow water."
	icon = 'icons/turf/floors.dmi'
	icon_state = "riverwater_motion"
	baseturfs = /turf/open/indestructible/ground/inside/mountain
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	slowdown = 2
	bullet_sizzle = TRUE
	bullet_bounce_sound = null //needs a splashing sound one day.

	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER
	hard_yardsable = FALSE

	//fortuna edit
	/// Higher numbers indicates deeper water.
	depth = 1

// Fortuna edit. Below is Largely ported from citadels HRP branch

/turf/open/water/Initialize()
	. = ..()
	update_icon()

/turf/open/water/examine(mob/user)
	. = ..()
	. += span_notice("Alt-Click \the [src] to wash yourself off.")

/turf/open/water/update_icon()
	. = ..()

/turf/open/water/Entered(atom/movable/AM, atom/oldloc)
	// if(istype(AM, /mob/living))
	// 	var/mob/living/L = AM
	// 	L.update_water()
	// 	if(L.check_submerged() <= 0)
	// 		return
	// 	if(!istype(oldloc, /turf/open/water))
	// 		to_chat(L, span_warning("You get drenched in water!"))
	AM.water_act(5)
	..()

// /turf/open/water/Exited(atom/movable/AM, atom/newloc)
// 	if(istype(AM, /mob/living))
// 		var/mob/living/L = AM
// 		L.update_water()
// 		if(L.check_submerged() <= 0)
// 			return
// 		if(!istype(newloc, /turf/open/water))
// 			to_chat(L, span_warning("You climb out of \the [src]."))
// 	..()

/turf/open/water/AltClick(mob/user)
	. = ..()
	if(isliving(user))
		var/mob/living/L = user
		L.DelayNextAction(CLICK_CD_RANGE)
		if(!user.incapacitated(allow_crit = TRUE) && Adjacent(user))
			user.visible_message(span_notice("[L] starts washing in \the [src]."),
								span_notice("You start washing in \the [src]."),
								span_notice("You hear splashing water and scrubbing."))
			playsound(user,"water_wade",100,TRUE)
			if(do_after(user,5 SECONDS, TRUE, src, TRUE,allow_movement=FALSE,stay_close=TRUE))
				give_mob_washies(L)
				user.visible_message(span_notice("[L] finishes washing in \the [src]."),
									span_notice("You finish washing in \the [src]."),
									span_notice("The splashing and scrubbing stops."))
				playsound(user,"water_wade",100,TRUE)

/mob/living/proc/check_submerged()
	if(buckled)
		return 0
	if(locate(/obj/structure/lattice/catwalk) in loc)
		return 0
	loc = get_turf(src)
	if(istype(loc, /turf/open/indestructible/ground/outside/water) || istype(loc, /turf/open/water))
		var/turf/open/T = loc
		return T.depth
	return 0

// Use this to have things react to having water applied to them.
/atom/movable/proc/water_act(amount)
	return

/mob/living/water_act(amount)
	// if(ishuman(src))
	// 	var/mob/living/carbon/human/drownee = src
	// 	if(!drownee || drownee.stat == DEAD)
	// 		return
	// 	if(drownee.resting && !drownee.internal)
	// 		if(drownee.stat != CONSCIOUS)
	// 			drownee.adjustOxyLoss(1)
	// 		else
	// 			drownee.adjustOxyLoss(1)
	// 			if(prob(35))
	// 				to_chat(drownee, span_danger("You're drowning!"))
	adjust_fire_stacks(-amount * 5)
	for(var/atom/movable/AM in contents)
		AM.water_act(amount)

