/mob/living/Moved()
	. = ..()
	update_turf_movespeed(loc)
	update_pixel_shifting(TRUE)

/mob/living/setDir(newdir, ismousemovement)
	. = ..()
	if(ismousemovement)
		update_pixel_shifting()

/mob/living/proc/update_pixel_shifting(moved = FALSE)
	if(combat_flags & COMBAT_FLAG_ACTIVE_BLOCKING)
		animate(src, pixel_x = get_standard_pixel_x_offset(), pixel_y = get_standard_pixel_y_offset(), time = 2.5, flags = ANIMATION_END_NOW)
	else if(moved)
		if(is_shifted)
			is_shifted = FALSE
			pixel_x = get_standard_pixel_x_offset(lying)
			pixel_y = get_standard_pixel_y_offset(lying)
		if(is_tilted)
			transform = transform.Turn(-is_tilted)
			is_tilted = 0


/mob/living/CanAllowThrough(atom/movable/mover, border_dir)
	..()
	if((mover.pass_flags & PASSMOB))
		return TRUE
	if(istype(mover, /obj/item/projectile))
		var/obj/item/projectile/P = mover
		return !P.can_hit_target(src, P.permutated, src == P.original, TRUE)
	if(mover.throwing)
		return (!density || lying)
	if(buckled == mover)
		return TRUE
	if(!ismob(mover))
		if(mover.throwing?.thrower == src)
			return TRUE
	if(ismob(mover))
		if(mover in buckled_mobs)
			return TRUE
	var/mob/living/L = mover		//typecast first, check isliving and only check this if living using short circuit
	return (!density || (isliving(mover)? L.can_move_under_living(src) : !mover.density))

/mob/living/toggle_move_intent()
	. = ..()
	update_move_intent_slowdown()

/mob/living/update_config_movespeed()
	update_move_intent_slowdown()
	sprint_buffer_max = CONFIG_GET(number/movedelay/sprint_buffer_max)
	sprint_buffer_regen_ds = CONFIG_GET(number/movedelay/sprint_buffer_regen_per_ds)
	sprint_stamina_cost = CONFIG_GET(number/movedelay/sprint_stamina_cost)
	return ..()

/// whether or not we can slide under another living mob. defaults to if we're not dense. CanPass should check "overriding circumstances" like buckled mobs/having PASSMOB flag, etc.
/mob/living/proc/can_move_under_living(mob/living/other)
	return !density

/mob/living/proc/update_move_intent_slowdown()
	add_movespeed_modifier((m_intent == MOVE_INTENT_WALK)? /datum/movespeed_modifier/config_walk_run/walk : /datum/movespeed_modifier/config_walk_run/run)

/mob/living/proc/update_turf_movespeed(turf/open/T)
	if(isopenturf(T))
		if(T.hard_yardsable)
			if(HAS_TRAIT(src, TRAIT_HARD_YARDS))
				add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/turf_slowdown, multiplicative_slowdown = (T.slowdown * 0.8))
				return
			if(HAS_TRAIT(src, TRAIT_SOFT_YARDS))
				add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/turf_slowdown, multiplicative_slowdown = (T.slowdown * 0.9))
				return
		if(HAS_TRAIT(src, TRAIT_SLUG))
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/turf_slowdown, multiplicative_slowdown = (T.slowdown * 1.5))
			return
		if(HAS_TRAIT(src, TRAIT_SLOWAF))
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/turf_slowdown, multiplicative_slowdown = (T.slowdown * 2.5))
			return
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/turf_slowdown, multiplicative_slowdown = T.slowdown)
		return
	remove_movespeed_modifier(/datum/movespeed_modifier/turf_slowdown)

/mob/living/proc/update_special_speed(speed)//SPECIAL Integration
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/special_speed, multiplicative_slowdown = speed)

/mob/living/proc/update_pull_movespeed()
	if(pulling)
		var/should_slow = FALSE
		if(isliving(pulling))
			var/mob/living/L = pulling
			should_slow = (drag_slowdown && L.lying && !L.buckled && grab_state < GRAB_AGGRESSIVE) ? PULL_PRONE_SLOWDOWN : FALSE
			//var/slow_difference = L.total_multiplicative_slowdown() - total_multiplicative_slowdown()
			//if(slow_difference >= 3)
			//	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/shared_slowdown, multiplicative_slowdown = slow_difference)
		else
			should_slow = pulling.drag_delay
		if(should_slow)
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/bulky_drag, multiplicative_slowdown = should_slow)
			return
	remove_movespeed_modifier(/datum/movespeed_modifier/bulky_drag)
	//remove_movespeed_modifier(/datum/movespeed_modifier/shared_slowdown)

/mob/living/Move(atom/newloc, direct, glide_size_override)
	if (buckled && buckled.loc != newloc) //not updating position
		if (!buckled.anchored)
			return buckled.Move(newloc, direct, glide_size)
		else
			return FALSE

	var/old_direction = dir
	var/turf/T = loc

	if(pulling)
		update_pull_movespeed()

	. = ..()

	if(pulledby && moving_diagonally != FIRST_DIAG_STEP && get_dist(src, pulledby) > 1 && (pulledby != moving_from_pull))//separated from our puller and not in the middle of a diagonal move.
		pulledby.stop_pulling()
	else
		if(isliving(pulledby))
			var/mob/living/L = pulledby
			L.set_pull_offsets(src, pulledby.grab_state)

	if(active_storage && !(can_reach(active_storage.parent, STORAGE_VIEW_DEPTH)))
		active_storage.close(src)

	if(lying && !buckled && prob(getBruteLoss()*200/maxHealth))
		makeTrail(newloc, T, old_direction)

/mob/living/forceMove(atom/destination)
	if(!currently_z_moving)
		stop_pulling()
		if(buckled)
			buckled.unbuckle_mob(src, force = TRUE)
		if(has_buckled_mobs())
			unbuckle_all_mobs(force = TRUE)
	. = ..()
	if(. && client)
		reset_perspective()

/mob/living/update_z(new_z) // 1+ to register, null to unregister
	if(isnull(new_z) && audiovisual_redirect)
		return
	if (registered_z != new_z)
		if (registered_z)
			SSmobs.clients_by_zlevel[registered_z] -= src
		if (client || audiovisual_redirect)
			if (new_z)
				SSmobs.clients_by_zlevel[new_z] += src
				for (var/I in length(SSidlenpcpool.idle_mobs_by_zlevel[new_z]) to 1 step -1) //Backwards loop because we're removing (guarantees optimal rather than worst-case performance), it's fine to use .len here but doesn't compile on 511
					var/mob/living/simple_animal/SA = SSidlenpcpool.idle_mobs_by_zlevel[new_z][I]
					if (SA)
						SA.toggle_ai(AI_ON) // Guarantees responsiveness for when appearing right next to mobs
					else
						SSidlenpcpool.idle_mobs_by_zlevel[new_z] -= SA

			registered_z = new_z
		else
			registered_z = null

/mob/living/onTransitZ(old_z,new_z)
	..()
	update_z(new_z)

/mob/living/canface()
	if(!CHECK_MOBILITY(src, MOBILITY_MOVE))
		return FALSE
	return ..()


/**
 * We want to relay the zmovement to the buckled atom when possible
 * and only run what we can't have on buckled.zMove() or buckled.can_z_move() here.
 * This way we can avoid esoteric bugs, copypasta and inconsistencies.
 */
/mob/living/zMove(dir, turf/target, z_move_flags = ZMOVE_FLIGHT_FLAGS)
	if(buckled)
		if(buckled.currently_z_moving)
			return FALSE
		if(!(z_move_flags & ZMOVE_ALLOW_BUCKLED))
			buckled.unbuckle_mob(src, force = TRUE)
		else
			if(!target)
				target = canZMove(dir, get_turf(src), null, z_move_flags, src)
				if(!target)
					return FALSE
			return buckled.zMove(dir, target, z_move_flags) // Return value is a loc.
	return ..()

/mob/living/canZMove(direction, turf/start, turf/destination, z_move_flags = ZMOVE_FLIGHT_FLAGS, mob/living/rider)
	if(z_move_flags & ZMOVE_INCAPACITATED_CHECKS && incapacitated())
		if(z_move_flags & ZMOVE_FEEDBACK)
			to_chat(rider || src, span_warning("[rider ? src : "You"] can't do that right now!"))
		return FALSE
	if(!buckled || !(z_move_flags & ZMOVE_ALLOW_BUCKLED))
		if(!(z_move_flags & ZMOVE_FALL_CHECKS) && incorporeal_move && (!rider || rider.incorporeal_move))
			//An incorporeal mob will ignore obstacles unless it's a potential fall (it'd suck hard) or is carrying corporeal mobs.
			//Coupled with flying/floating, this allows the mob to move up and down freely.
			//By itself, it only allows the mob to move down.
			z_move_flags |= ZMOVE_IGNORE_OBSTACLES
		return ..()
	switch(SEND_SIGNAL(buckled, COMSIG_BUCKLED_CAN_Z_MOVE, direction, start, destination, z_move_flags, src))
		if(COMPONENT_RIDDEN_ALLOW_Z_MOVE) // Can be ridden.
			return buckled.canZMove(direction, start, destination, z_move_flags, src)
		if(COMPONENT_RIDDEN_STOP_Z_MOVE) // Is a ridable but can't be ridden right now. Feedback messages already done.
			return FALSE
		else
			if(!(z_move_flags & ZMOVE_CAN_FLY_CHECKS) && !buckled.anchored)
				return buckled.canZMove(direction, start, destination, z_move_flags, src)
			if(z_move_flags & ZMOVE_FEEDBACK)
				to_chat(src, span_warning("Unbuckle from [buckled] first."))
			return FALSE
