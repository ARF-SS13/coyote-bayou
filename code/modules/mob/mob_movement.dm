//DO NOT USE THIS UNLESS YOU ABSOLUTELY HAVE TO. THIS IS BEING PHASED OUT FOR THE MOVESPEED MODIFICATION SYSTEM.

/// The threshold in which all of our movements are fully randomized, in seconds.
#define CONFUSION_FULL_THRESHOLD 40
/// A multiplier applied on how much time is left (in seconds) that determines the chance of moving sideways randomly
#define CONFUSION_SIDEWAYS_MOVE_PROB_PER_SECOND 1.5
/// A multiplier applied on how much time is left (in seconds) that determines the chance of moving diagonally randomly
#define CONFUSION_DIAGONAL_MOVE_PROB_PER_SECOND 3

//See mob_movespeed.dm
/mob/proc/movement_delay()	//update /living/movement_delay() if you change this
	return cached_multiplicative_slowdown

/client/verb/drop_item()
	set hidden = 1
	if(!iscyborg(mob) && mob.stat == CONSCIOUS)
		mob.dropItemToGround(mob.get_active_held_item())
	return

/client/proc/Move_object(direction)
	if(mob && mob.control_object)
		if(mob.control_object.density)
			step(mob.control_object,direction)
			if(!mob.control_object)
				return
			mob.control_object.setDir(direction)
		else
			mob.control_object.forceMove(get_step(mob.control_object,direction))

#define MOVEMENT_DELAY_BUFFER 0.75
#define MOVEMENT_DELAY_BUFFER_DELTA 1.25

/client/Move(n, direction)
	if(world.time < move_delay) //do not move anything ahead of this check please
		return FALSE
	else
		next_move_dir_add = next_move_dir_sub = NONE
	var/old_move_delay = move_delay
	move_delay = world.time + world.tick_lag //this is here because Move() can now be called mutiple times per tick
	if(!n || !direction || !mob?.loc)
		return FALSE
	//GET RID OF THIS SOON AS MOBILITY FLAGS IS DONE
	if(mob.mob_transforming)
		return FALSE

	if(mob.control_object)
		return Move_object(direction)
	if(!isliving(mob))
		return mob.Move(n, direction)
	if(mob.stat == DEAD)
		mob.ghostize()
		return FALSE
	if(mob.force_moving)
		return FALSE

	var/mob/living/L = mob  //Already checked for isliving earlier
	if(L.incorporeal_move)	//Move though walls
		Process_Incorpmove(direction)
		return FALSE

	if(mob.remote_control)					//we're controlling something, our movement is relayed to it
		return mob.remote_control.relaymove(mob, direction)

	if(isAI(mob))
		return AIMove(n,direction,mob)

	if(Process_Grab()) //are we restrained by someone's grip?
		return

	if(mob.buckled)							//if we're buckled to something, tell it we moved.
		return mob.buckled.relaymove(mob, direction)

	if(!CHECK_MOBILITY(L, MOBILITY_MOVE))
		return FALSE

	if(isobj(mob.loc) || ismob(mob.loc))	//Inside an object, tell it we moved
		var/atom/O = mob.loc
		return O.relaymove(mob, direction)

	if(!mob.Process_Spacemove(direction))
		return FALSE

	if(SEND_SIGNAL(mob, COMSIG_MOB_CLIENT_PRE_MOVE, args) & COMSIG_MOB_CLIENT_BLOCK_PRE_MOVE)
		return FALSE

	//We are now going to move
	var/add_delay = mob.movement_delay()
	mob.set_glide_size(DELAY_TO_GLIDE_SIZE(add_delay * ( (NSCOMPONENT(direction) && EWCOMPONENT(direction)) ? 2 : 1 ) ), FALSE) // set it now in case of pulled objects
	if(old_move_delay + (add_delay*MOVEMENT_DELAY_BUFFER_DELTA) + MOVEMENT_DELAY_BUFFER > world.time)
		move_delay = old_move_delay
	else
		move_delay = world.time

	if(L.confused)
		var/newdir = NONE
		if((L.confused > 50) && prob(min(L.confused * 0.5, 50)))
			newdir = pick(GLOB.alldirs)
		else if(prob(L.confused))
			newdir = angle2dir(dir2angle(direction) + pick(90, -90))
		else if(prob(L.confused * 2))
			newdir = angle2dir(dir2angle(direction) + pick(45, -45))
		if(newdir)
			direction = newdir
			n = get_step(L, direction)

	. = ..()

	if((direction & (direction - 1)) && mob.loc == n) //moved diagonally successfully
		add_delay *= SQRT_2
	
	if(visual_delay)
		mob.set_glide_size(visual_delay)
	else
		mob.set_glide_size(DELAY_TO_GLIDE_SIZE(add_delay))
	move_delay += add_delay
	if(.) // If mob is null here, we deserve the runtime
		if(mob.throwing)
			mob.throwing.finalize(FALSE)
		
		SEND_SIGNAL(mob, COMSIG_MOB_CLIENT_MOVED)

	var/atom/movable/AM = L.pulling
	if(AM && AM.density && !SEND_SIGNAL(L, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE) && !ismob(AM))
		L.setDir(turn(L.dir, 180))

	last_move = world.time


/// Process_Grab(): checks for grab, attempts to break if so. Return TRUE to prevent movement.
/client/proc/Process_Grab()
	if(mob.pulledby)
		if((mob.pulledby == mob.pulling) && (mob.pulledby.grab_state == GRAB_PASSIVE))			//Don't autoresist passive grabs if we're grabbing them too.
			return
		if(mob.incapacitated(ignore_restraints = 1))
			move_delay = world.time + 10
			return TRUE
		else if(mob.restrained(ignore_grab = 1))
			move_delay = world.time + 10
			to_chat(src, "<span class='warning'>You're restrained! You can't move!</span>")
			return TRUE
		else
			return !mob.attempt_resist_grab(TRUE)

///Process_Incorpmove
///Called by client/Move()
///Allows mobs to run though walls
/client/proc/Process_Incorpmove(direction)
	var/turf/mobloc = get_turf(mob)
	if(!isliving(mob))
		return
	var/mob/living/L = mob
	switch(L.incorporeal_move)
		if(INCORPOREAL_MOVE_BASIC)
			var/T = get_step(L,direction)
			if(T)
				L.forceMove(T)
			L.setDir(direction)
		if(INCORPOREAL_MOVE_SHADOW)
			if(prob(50))
				var/locx
				var/locy
				switch(direction)
					if(NORTH)
						locx = mobloc.x
						locy = (mobloc.y+2)
						if(locy>world.maxy)
							return
					if(SOUTH)
						locx = mobloc.x
						locy = (mobloc.y-2)
						if(locy<1)
							return
					if(EAST)
						locy = mobloc.y
						locx = (mobloc.x+2)
						if(locx>world.maxx)
							return
					if(WEST)
						locy = mobloc.y
						locx = (mobloc.x-2)
						if(locx<1)
							return
					else
						return
				var/target = locate(locx,locy,mobloc.z)
				if(target)
					L.loc = target
					var/limit = 2//For only two trailing shadows.
					for(var/turf/T in getline(mobloc, L.loc))
						new /obj/effect/temp_visual/dir_setting/ninja/shadow(T, L.dir)
						limit--
						if(limit<=0)
							break
			else
				new /obj/effect/temp_visual/dir_setting/ninja/shadow(mobloc, L.dir)
				var/T = get_step(L,direction)
				if(T)
					L.forceMove(T)
			L.setDir(direction)
		if(INCORPOREAL_MOVE_JAUNT) //Incorporeal move, but blocked by holy-watered tiles and salt piles.
			var/turf/open/floor/stepTurf = get_step(L, direction)
			if(stepTurf)
				for(var/obj/effect/decal/cleanable/salt/S in stepTurf)
					to_chat(L, "<span class='warning'>[S] bars your passage!</span>")
					if(isrevenant(L))
						var/mob/living/simple_animal/revenant/R = L
						R.reveal(20)
						R.stun(20)
					return
				if(stepTurf.flags_1 & NOJAUNT_1)
					to_chat(L, "<span class='warning'>Some strange aura is blocking the way.</span>")
					return
				if (locate(/obj/effect/blessing, stepTurf))
					to_chat(L, "<span class='warning'>Holy energies block your path!</span>")
					return

				L.forceMove(stepTurf)
			L.setDir(direction)
	return TRUE

/**
 * Handles mob/living movement in space (or no gravity)
 *
 * Called by /client/Move()
 *
 * return TRUE for movement or FALSE for none
 *
 * You can move in space if you have a spacewalk ability
 */
/mob/Process_Spacemove(movement_dir = 0, continuous_move = FALSE)
	. = ..()
	if(. || HAS_TRAIT(src, TRAIT_SPACEWALK))
		return TRUE

	// FUCK OFF
	if(buckled)
		return TRUE

	var/atom/movable/backup = get_spacemove_backup(movement_dir, continuous_move)
	if(!backup)
		return FALSE
	if(continuous_move || !istype(backup) || !movement_dir || backup.anchored)
		return TRUE
	// last pushoff exists for one reason
	// to ensure pushing a mob doesn't just lead to it considering us as backup, and failing
	last_pushoff = world.time
	if(backup.newtonian_move(turn(movement_dir, 180), instant = TRUE)) //You're pushing off something movable, so it moves
		// We set it down here so future calls to Process_Spacemove by the same pair in the same tick don't lead to fucky
		backup.last_pushoff = world.time
		to_chat(src, span_info("You push off of [backup] to propel yourself."))
	return TRUE

/**
 * Finds a target near a mob that is viable for pushing off when moving.
 * Takes the intended movement direction as input, alongside if the context is checking if we're allowed to continue drifting
 */
/mob/get_spacemove_backup(moving_direction, continuous_move)
	for(var/atom/pushover as anything in range(1, get_turf(src)))
		if(pushover == src)
			continue
		if(isarea(pushover))
			continue
		if(isturf(pushover))
			var/turf/turf = pushover
			if(isspaceturf(turf))
				continue
			if(!turf.density && !mob_negates_gravity())
				continue
			return pushover

		var/atom/movable/rebound = pushover
		if(rebound == buckled)
			continue
		if(ismob(rebound))
			var/mob/lover = rebound
			if(lover.buckled)
				continue

		var/pass_allowed = rebound.CanPass(src, get_dir(rebound, src))
		if(!rebound.density && pass_allowed)
			continue
		//Sometime this tick, this pushed off something. Doesn't count as a valid pushoff target
		if(rebound.last_pushoff == world.time)
			continue
		if(continuous_move && !pass_allowed)
			var/datum/move_loop/move/rebound_engine = SSmove_manager.processing_on(rebound, SSspacedrift)
			// If you're moving toward it and you're both going the same direction, stop
			if(moving_direction == get_dir(src, pushover) && rebound_engine && moving_direction == rebound_engine.direction)
				continue
		else if(!pass_allowed)
			if(moving_direction == get_dir(src, pushover)) // Can't push "off" of something that you're walking into
				continue
		if(rebound.anchored)
			return rebound
		if(pulling == rebound)
			continue
		return rebound

/mob/proc/mob_has_gravity()
	return has_gravity()

/mob/proc/mob_negates_gravity()
	return FALSE


/mob/proc/slip(s_amount, w_amount, obj/O, lube)
	return

/mob/proc/update_gravity(has_gravity, override=FALSE)
	var/speed_change = max(0, has_gravity - STANDARD_GRAVITY)
	if(!speed_change)
		remove_movespeed_modifier(/datum/movespeed_modifier/gravity)
	else
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/gravity, multiplicative_slowdown = speed_change)

//bodypart selection - Cyberboss
//8 toggles through head - eyes - mouth
//4: r-arm 5: chest 6: l-arm
//1: r-leg 2: groin 3: l-leg

/client/proc/check_has_body_select()
	return mob && mob.hud_used && mob.hud_used.zone_select && istype(mob.hud_used.zone_select, /obj/screen/zone_sel)

/client/verb/body_toggle_head()
	set name = "body-toggle-head"
	set hidden = 1

	if(!check_has_body_select())
		return

	var/next_in_line
	switch(mob.zone_selected)
		if(BODY_ZONE_HEAD)
			next_in_line = BODY_ZONE_PRECISE_EYES
		if(BODY_ZONE_PRECISE_EYES)
			next_in_line = BODY_ZONE_PRECISE_MOUTH
		else
			next_in_line = BODY_ZONE_HEAD

	var/obj/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(next_in_line, mob)

/client/verb/body_r_arm()
	set name = "body-r-arm"
	set hidden = 1

	if(!check_has_body_select())
		return

	var/obj/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(BODY_ZONE_R_ARM, mob)

/client/verb/body_chest()
	set name = "body-chest"
	set hidden = 1

	if(!check_has_body_select())
		return

	var/obj/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(BODY_ZONE_CHEST, mob)

/client/verb/body_l_arm()
	set name = "body-l-arm"
	set hidden = 1

	if(!check_has_body_select())
		return

	var/obj/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(BODY_ZONE_L_ARM, mob)

/client/verb/body_r_leg()
	set name = "body-r-leg"
	set hidden = 1

	if(!check_has_body_select())
		return

	var/obj/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(BODY_ZONE_R_LEG, mob)

/client/verb/body_groin()
	set name = "body-groin"
	set hidden = 1

	if(!check_has_body_select())
		return

	var/obj/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(BODY_ZONE_PRECISE_GROIN, mob)

/client/verb/body_l_leg()
	set name = "body-l-leg"
	set hidden = 1

	if(!check_has_body_select())
		return

	var/obj/screen/zone_sel/selector = mob.hud_used.zone_select
	selector.set_selected_zone(BODY_ZONE_L_LEG, mob)

/client/verb/toggle_walk_run()
	set name = "toggle-walk-run"
	set hidden = TRUE
	set instant = TRUE
	if(mob)
		mob.toggle_move_intent(usr)

/mob/proc/toggle_move_intent(mob/user)
	if(m_intent == MOVE_INTENT_RUN)
		m_intent = MOVE_INTENT_WALK
	else
		if (HAS_TRAIT(src,TRAIT_NORUNNING))
			to_chat(src, "You find yourself unable to run.")
			return FALSE
		m_intent = MOVE_INTENT_RUN
	if(hud_used && hud_used.static_inventory)
		for(var/obj/screen/mov_intent/selector in hud_used.static_inventory)
			selector.update_icon()

#define MOB_LAYER_SHIFT_INCREMENT    0.01
#define MOB_LAYER_SHIFT_MIN         3.75
//#define MOB_LAYER                 4   // This is a byond standard define
#define MOB_LAYER_SHIFT_MAX           4.05
//Layer code ported from Skyrat, credit to Ranged66

/mob/living/verb/layershift_up()
	set name = "Shift Layer Upwards"
	set category = "IC"

	if(incapacitated())
		to_chat(src, span_warning("You can't do that right now!"))
		return

	if(layer >= MOB_LAYER_SHIFT_MAX)
		to_chat(src, span_warning("You cannot increase your layer priority any further."))
		return

	layer += MOB_LAYER_SHIFT_INCREMENT
	var/layer_priority = (layer - MOB_LAYER) * 100 // Just for text feedback
	to_chat(src, span_notice("Your layer priority is now [layer_priority]."))

/mob/living/verb/layershift_reset()
	set name = "Reset Layer"
	set category = "IC"

	if(incapacitated())
		to_chat(src, span_warning("You can't do that right now!"))
		return

	if(lying)
		layer = LYING_MOB_LAYER //so mob lying always appear behind standing mobs
	else
		layer = initial(layer)
	var/layer_priority = (layer - MOB_LAYER) * 100 // Just for text feedback
	to_chat(src, span_notice("Your layer priority is now [layer_priority]."))

/mob/living/verb/layershift_down()
	set name = "Shift Layer Downwards"
	set category = "IC"

	if(incapacitated())
		to_chat(src, span_warning("You can't do that right now!"))
		return

	if(layer <= MOB_LAYER_SHIFT_MIN)
		to_chat(src, span_warning("You cannot decrease your layer priority any further."))
		return

	layer -= MOB_LAYER_SHIFT_INCREMENT
	var/layer_priority = (layer - MOB_LAYER) * 100 // Just for text feedback
	to_chat(src, span_notice("Your layer priority is now [layer_priority]."))
	
/mob/verb/up()
	set name = "Move Upwards"
	set category = "IC"

	var/turf/current_turf = get_turf(src)
	var/turf/above_turf = SSmapping.get_turf_above(current_turf)

	var/ventcrawling_flag = HAS_TRAIT(src, TRAIT_MOVE_VENTCRAWLING) ? ZMOVE_VENTCRAWLING : 0
	if(!above_turf)
		to_chat(src, span_warning("There's nowhere to go in that direction!"))
		return

	if(canZMove(DOWN, above_turf, current_turf, ZMOVE_FALL_FLAGS|ventcrawling_flag)) //Will we fall down if we go up?
		if(buckled)
			to_chat(src, span_warning("[buckled] is is not capable of flight."))
		else
			to_chat(src, span_warning("You are not Superman."))
		return

	if(zMove(UP, z_move_flags = ZMOVE_FLIGHT_FLAGS|ZMOVE_FEEDBACK|ventcrawling_flag))
		to_chat(src, span_notice("You move upwards."))

/mob/verb/down()
	set name = "Move Down"
	set category = "IC"

	var/ventcrawling_flag = HAS_TRAIT(src, TRAIT_MOVE_VENTCRAWLING) ? ZMOVE_VENTCRAWLING : 0
	if(zMove(DOWN, z_move_flags = ZMOVE_FLIGHT_FLAGS|ZMOVE_FEEDBACK|ventcrawling_flag))
		to_chat(src, span_notice("You move down."))
	return FALSE
