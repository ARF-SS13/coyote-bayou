/obj/effect/oneway
	name = "one way effect"
	desc = "Only lets things in from its dir."
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "field_dir"
	invisibility = INVISIBILITY_MAXIMUM
	anchored = TRUE

/obj/effect/oneway/CanPass(atom/movable/mover, border_dir)
	var/turf/T = get_turf(src)
	var/turf/MT = get_turf(mover)
	return ..() && (T == MT || border_dir == dir)


/obj/effect/wind
	name = "wind effect"
	desc = "Creates pressure effect in its direction. Use sparingly."
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "field_dir"
	invisibility = INVISIBILITY_MAXIMUM
	var/strength = 30

/obj/effect/wind/Initialize()
	. = ..()
	START_PROCESSING(SSobj,src)

/obj/effect/wind/process()
	var/turf/open/T = get_turf(src)
	if(istype(T))
		T.consider_pressure_difference(get_step(T,dir),strength)
