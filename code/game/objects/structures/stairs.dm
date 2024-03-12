#define STAIR_TERMINATOR_AUTOMATIC 0
#define STAIR_TERMINATOR_NO 1
#define STAIR_TERMINATOR_YES 2
#define STAIR_NOT_TEMPORARY 0

// dir determines the direction of travel to go upwards (due to lack of sprites, currently only 1 and 2 make sense)
// stairs require /turf/open/transparent/openspace as the tile above them to work
// multiple stair objects can be chained together; the Z level transition will happen on the final stair object in the chain

/obj/structure/stairs
	name = "stairs"
	icon = 'icons/obj/stairs.dmi'
	icon_state = "stairs"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	anchored = TRUE
	var/force_open_above = FALSE // replaces the turf above this stair obj with /turf/open/transparent/openspace
	var/terminator_mode = STAIR_TERMINATOR_AUTOMATIC
	var/turf/listeningTo
	var/indestructible = TRUE
	var/destroy_in = STAIR_NOT_TEMPORARY
	var/icon_state_override
	var/obj/item/spawn_on_break = /obj/item/ammo_casing/caseless/rock

/// Two things will remain after the end of the world, furries and *stairs*

/obj/structure/stairs/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir, armour_penetration = 0, atom/attacked_by)
	if(!indestructible)
		return ..()
	return FALSE

/obj/structure/stairs/fire_act(exposed_temperature, exposed_volume)
	return FALSE

/obj/structure/stairs/acid_act()
	return FALSE

/obj/structure/stairs/mech_melee_attack(obj/mecha/M)
	return FALSE

/obj/structure/stairs/blob_act(obj/structure/blob/B)
	return FALSE

/obj/structure/stairs/attack_hulk(mob/living/carbon/human/user, does_attack_animation = 0)
	return FALSE

/obj/structure/stairs/experience_pressure_difference()
	return FALSE

/obj/structure/stairs/ex_act(severity, target)
	if(!indestructible)
		return ..()
	return FALSE

/obj/structure/stairs/singularity_act()
	return FALSE

/obj/structure/stairs/ConveyorMove()
	return FALSE


/obj/structure/stairs/north
	dir = NORTH

/obj/structure/stairs/south
	dir = SOUTH

/obj/structure/stairs/east
	dir = EAST

/obj/structure/stairs/west
	dir = WEST

/obj/structure/stairs/Initialize(mapload)
	if(force_open_above)
		force_open_above()
		build_signal_listener()
	update_surrounding()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT =PROC_REF(on_exit),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	if(destroy_in > STAIR_NOT_TEMPORARY)
		QDEL_IN(src, destroy_in)
	return ..()

/obj/structure/stairs/Destroy()
	listeningTo = null
	return ..()

/obj/structure/stairs/Move()			//Look this should never happen but...
	. = ..()
	if(force_open_above)
		build_signal_listener()
	update_surrounding()

/obj/structure/stairs/proc/update_surrounding()
	update_icon()
	for(var/i in GLOB.cardinals)
		var/turf/T = get_step(get_turf(src), i)
		var/obj/structure/stairs/S = locate() in T
		if(S)
			S.update_icon()

/obj/structure/stairs/proc/on_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER

	if(leaving == src)
		return //Let's not block ourselves.

	if(!isobserver(leaving) && isTerminator() && direction == dir)
		leaving.set_currently_z_moving(CURRENTLY_Z_ASCENDING)
		INVOKE_ASYNC(src,PROC_REF(stair_ascend), leaving)
		leaving.Bump(src)
		return COMPONENT_ATOM_BLOCK_EXIT

/obj/structure/stairs/Cross(atom/movable/AM)
	if(isTerminator() && (get_dir(src, AM) == dir))
		return FALSE
	return ..()

/obj/structure/stairs/update_icon_state()
	if(icon_state_override)
		icon_state = icon_state_override
		return
	if(isTerminator())
		icon_state = "stairs_t"
	else
		icon_state = "stairs"

/obj/structure/stairs/proc/stair_ascend(atom/movable/climber)
	var/turf/checking = get_step_multiz(get_turf(src), UP)
	if(!istype(checking))
		return
	if(!checking.zPassIn(climber, UP, get_turf(src)))
		return
	var/turf/target = get_step_multiz(get_turf(src), (dir|UP))
	if(istype(target) && !climber.canZMove(DOWN, target, z_move_flags = ZMOVE_FALL_FLAGS)) //Don't throw them into a tile that will just dump them back down.
		climber.zMove(target = target, z_move_flags = ZMOVE_STAIRS_FLAGS)
		/// Moves anything that's being dragged by src or anything buckled to it to the stairs turf.
		climber.pulling?.move_from_pull(climber, loc, climber.glide_size)
		for(var/mob/living/buckled as anything in climber.buckled_mobs)
			buckled.pulling?.move_from_pull(buckled, loc, buckled.glide_size)

/obj/structure/stairs/vv_edit_var(var_name, var_value)
	. = ..()
	if(!.)
		return
	if(var_name != NAMEOF(src, force_open_above))
		return
	if(!var_value)
		if(listeningTo)
			UnregisterSignal(listeningTo, COMSIG_TURF_MULTIZ_NEW)
			listeningTo = null
	else
		build_signal_listener()
		force_open_above()

/obj/structure/stairs/proc/build_signal_listener()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_TURF_MULTIZ_NEW)
	var/turf/open/transparent/openspace/T = get_step_multiz(get_turf(src), UP)
	RegisterSignal(T, COMSIG_TURF_MULTIZ_NEW,PROC_REF(on_multiz_new))
	listeningTo = T

/obj/structure/stairs/proc/force_open_above()
	var/turf/open/transparent/openspace/T = get_step_multiz(get_turf(src), UP)
	if(T && !istype(T))
		T.ChangeTurf(/turf/open/transparent/openspace, flags = CHANGETURF_INHERIT_AIR)

/obj/structure/stairs/proc/on_multiz_new(turf/source, dir)
	//SIGNAL_HANDLER
	SHOULD_NOT_SLEEP(TRUE) //the same thing.

	if(dir == UP)
		var/turf/open/transparent/openspace/T = get_step_multiz(get_turf(src), UP)
		if(T && !istype(T))
			T.ChangeTurf(/turf/open/transparent/openspace, flags = CHANGETURF_INHERIT_AIR)

/obj/structure/stairs/intercept_zImpact(atom/movable/AM, levels = 1)
	. = ..()
	if(levels == 1 && isTerminator()) // Stairs won't save you from a steep fall.
		. |= FALL_INTERCEPTED | FALL_NO_MESSAGE | FALL_RETAIN_PULL

/obj/structure/stairs/proc/isTerminator()			//If this is the last stair in a chain and should move mobs up
	if(terminator_mode != STAIR_TERMINATOR_AUTOMATIC)
		return (terminator_mode == STAIR_TERMINATOR_YES)
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	var/turf/them = get_step(T, dir)
	if(!them)
		return FALSE
	for(var/obj/structure/stairs/S in them)
		if(S.dir == dir)
			return FALSE
	return TRUE

/obj/structure/stairs/rockpile
	name = "pile of rocks"
	icon_state = "rockpile"
	resistance_flags = NONE
	icon_state_override = "rockpile"
	indestructible = FALSE
	destroy_in = 15 MINUTES
	icon_state_override = "rockpile"
	spawn_on_break = /obj/item/ammo_casing/caseless/rock

/obj/structure/stairs/rockpile/Destroy()
	visible_message(span_danger("The flimsy [name] falls apart!"))
	playsound(src, "sound/f13effects/rock_mined.ogg", 100, TRUE)
	. = ..()

/obj/structure/stairs/rockpile/attack_hand(mob/user, act_intent, attackchain_flags)
	. = ..()
	try_to_knock_it_down(user)

/obj/structure/stairs/rockpile/proc/try_to_knock_it_down(mob/living/user)
	if(!istype(user) || user.incapacitated())
		return
	visible_message(span_notice("[user] is trying to knock down the [name]!"))
	if(!do_after(user, 5 SECONDS, TRUE, src, allow_movement = TRUE, public_progbar = TRUE))
		visible_message(span_alert("...but the [name] refuse to move!"))
		return
	visible_message(span_danger("The [name] falls apart!"))
	qdel(src)

/obj/structure/stairs/rockpile/north
	dir = NORTH

/obj/structure/stairs/rockpile/south
	dir = SOUTH

/obj/structure/stairs/rockpile/east
	dir = EAST

/obj/structure/stairs/rockpile/west
	dir = WEST

/obj/structure/stairs/rockpile/brickpile
	name = "pile of bricks"
	icon_state = "brickpile"
	resistance_flags = NONE
	icon_state_override = "brickpile"
	indestructible = FALSE
	destroy_in = 15 MINUTES
	icon_state_override = "brickpile"
	spawn_on_break = /obj/item/ammo_casing/caseless/brick

/obj/structure/stairs/rockpile/brickpile/north
	dir = NORTH

/obj/structure/stairs/rockpile/brickpile/south
	dir = SOUTH

/obj/structure/stairs/rockpile/brickpile/east
	dir = EAST

/obj/structure/stairs/rockpile/brickpile/west
	dir = WEST
