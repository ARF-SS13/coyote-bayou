GLOBAL_DATUM_INIT(openspace_backdrop_one_for_all, /atom/movable/openspace_backdrop, new)
GLOBAL_DATUM_INIT(openspace_backdrop_one_for_all_but_higher, /atom/movable/openspace_backdrop/higher, new)

/atom/movable/openspace_backdrop
	name			= "openspace_backdrop"

	anchored		= TRUE

	icon            = 'icons/turf/floors.dmi'
	icon_state      = "grey"
	plane           = OPENSPACE_BACKDROP_PLANE
	mouse_opacity 	= MOUSE_OPACITY_TRANSPARENT
	layer           = SPLASHSCREEN_LAYER
	color = list(
		1.0, 0.2, 0.3, 0.0,
		0.2, 1.1, 0.4, 0.0,
		0.2, 0.2, 1.2, 0.0,
		0.0, 0.0, 0.0, 1.0)

/atom/movable/openspace_backdrop/higher

/turf/open/transparent/openspace
	name = "open space"
	desc = "Watch your step!"
	icon_state = "transparent"
	baseturfs = /turf/open/transparent/openspace
	CanAtmosPassVertical = ATMOS_PASS_YES
	//mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/can_cover_up = TRUE
	var/can_build_on = TRUE
	sunlight_state = 1

/turf/open/transparent/openspace/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/transparent/openspace/debug/update_multiz()
	..()
	return TRUE

///No bottom level for openspace.
/turf/open/transparent/openspace/show_bottom_level()
	return FALSE

/turf/open/transparent/openspace/Initialize() // handle plane and layer here so that they don't cover other obs/turfs in Dream Maker
	. = ..()
	is_wall_below()
	vis_contents += GLOB.openspace_backdrop_one_for_all //Special grey square for projecting backdrop darkness filter on it.

/*
Prevents players on higher Zs from seeing into buildings they arent meant to.
*/
/turf/open/transparent/openspace/proc/is_wall_below()
	var/turf/A = SSmapping.get_turf_below(src)
	if(istype(A,/turf/closed/wall))
		opacity = 1

	else if(!isnull(A))
		for(var/obj/O in A.contents)
			if(istype(O,/obj/structure/simple_door))
				opacity = 1

/**
 * Prepares a moving movable to be precipitated if Move() is successful.
 * This is done in Enter() and not Entered() because there's no easy way to tell
 * if the latter was called by Move() or forceMove() while the former is only called by Move().
 */
/turf/open/transparent/openspace/Enter(atom/movable/mover, atom/oldloc)
	. = ..()
	if(be_careful(mover))
		return FALSE
	if(.)
		//higher priority than CURRENTLY_Z_FALLING so the movable doesn't fall on Entered()
		mover.set_currently_z_moving(CURRENTLY_Z_FALLING_FROM_MOVE)

/turf/open/transparent/openspace/proc/be_careful(atom/movable/mover)
	if(!isliving(mover))
		return FALSE
	var/turf/belome = SSmapping.get_turf_below(src)
	for(var/atom/thing in belome)
		if(thing.intercept_zImpact(mover) & FALL_INTERCEPTED)
			return FALSE // no need to be careful, its just stairs
	var/mob/living/L = mover
	if(istype(L, /mob/living/carbon)) // ignore tackling carbons
		var/mob/living/carbon/C = mover
		if(C.tackling)
			return FALSE
	if(L.m_intent == MOVE_INTENT_WALK && (!HAS_TRAIT(L, TRAIT_CLUMSY) || !HAS_TRAIT(L, TRAIT_NORUNNING)))
		to_chat(L, span_warning("Whoa! You nearly fell! Good thing you were careful!"))
		return TRUE

///Makes movables fall when forceMove()'d to this turf.
/turf/open/transparent/openspace/Entered(atom/movable/AM)
	. = ..()
	if(AM.set_currently_z_moving(CURRENTLY_Z_FALLING))
		zFall(AM, falling_from_move = TRUE)

/turf/open/transparent/openspace/can_have_cabling()
	if(locate(/obj/structure/lattice/catwalk, src))
		return TRUE
	return FALSE

/turf/open/transparent/openspace/zAirIn()
	return TRUE

/turf/open/transparent/openspace/zAirOut()
	return TRUE

/turf/open/transparent/openspace/zPassIn(atom/movable/A, direction, turf/source)
	return TRUE

/turf/open/transparent/openspace/zPassOut(atom/movable/A, direction, turf/destination)
	if(A.anchored)
		return FALSE
	for(var/obj/O in contents)
		if(O.obj_flags & BLOCK_Z_OUT_DOWN)
			return FALSE
	return TRUE

/turf/open/transparent/openspace/proc/CanCoverUp()
	return can_cover_up

/turf/open/transparent/openspace/proc/CanBuildHere()
	return can_build_on

/turf/open/transparent/openspace/attackby(obj/item/C, mob/user, params)
	..()
	if(!CanBuildHere())
		return
	if(istype(C, /obj/item/stack/rods))
		if(locate(/obj/structure/lattice/catwalk, src))
			to_chat(user, span_warning("There is already a catwalk here!"))
			return
		var/obj/item/stack/rods/our_rods = C
		var/structural_rods = istype(our_rods, /obj/item/stack/rods/scaffold)
		if(locate(/obj/structure/lattice, src))
			if(structural_rods)
				to_chat(user, span_warning("These scaffolding rods can't fit together tight enough to create a catwalk! Try some iron rods."))
				return
			if(!our_rods.use(2))
				to_chat(user, span_warning("You need two iron rods to build a catwalk!"))
				return
			to_chat(user, span_notice("You construct a catwalk."))
			playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
			new/obj/structure/lattice/catwalk(src)
			return
		if(!structural_rods)
			to_chat(user, span_warning("These rods are too weak to support a whole upper floor! Try some aerial support girders."))
			return
		if(our_rods.use(1))
			to_chat(user, span_notice("You construct a lattice."))
			playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
			ReplaceWithLattice()
			return
		to_chat(user, span_warning("You can't find anywhere to install the supports!"))
		return
	if(istype(C, /obj/item/stack/tile/plasteel))
		if(!CanCoverUp())
			return
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/plasteel/S = C
			if(S.use(1))
				qdel(L)
				playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
				to_chat(user, span_notice("You build a floor."))
				PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			else
				to_chat(user, span_warning("You need one floor tile to build a floor!"))
		else
			to_chat(user, span_warning("The plating is going to need some support! Place metal rods first."))

/turf/open/transparent/openspace/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(!CanBuildHere())
		return FALSE

	switch(the_rcd.mode)
		if(RCD_FLOORWALL)
			var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
			if(L)
				return list("mode" = RCD_FLOORWALL, "delay" = 0, "cost" = 1)
			else
				return list("mode" = RCD_FLOORWALL, "delay" = 0, "cost" = 3)
	return FALSE

/turf/open/transparent/openspace/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_FLOORWALL)
			to_chat(user, span_notice("You build a floor."))
			PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			return TRUE
	return FALSE

/turf/open/transparent/openspace/icemoon
	name = "ice chasm"
	baseturfs = /turf/open/transparent/openspace/icemoon
	can_cover_up = TRUE
	can_build_on = TRUE
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/open/transparent/openspace/icemoon/can_zFall(atom/movable/A, levels = 1, turf/target)
	return TRUE
