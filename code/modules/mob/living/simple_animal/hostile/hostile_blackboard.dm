
/// <reference path="../../typings/tsd.d.ts" />
/// {FILE: /hostile_ai.dm} (C) 2015-2016 Arthur Moore (MooreShark) a part of the /hostile_ai/ package
/// {FILE: /hostile_ai.dm} (C) 2012-2015 Dan Geyette (McGlaspie) a part of the /dev_null/ package
/// {FILE: /hostile_ai.dm} (C) 1989-2012 Michael Leonffu (Leonffu) a part of the /chadhack/ package
/// See: www.github.com/MooreShark/SS14/blob/master/LICENSE.md for details about licensing :D
/// A dynamic thoughts-at-this-instant blackboard for the hostile AI.
/// in_use t by Michael Leonffu on 01/26/2016 <- dunno who that is
/// in_use to at the beginning of an AI action, and overin_use at the start of the next action

/// SO HERE OME IMPORTANT DISTINCTIONS
/// This is all working memory, things that the mob wants to remember for more than a single proc
/// This is *not* used to define how the mob acts, those vars are stored on the mob (annoyingly enough)
/// If its a behavior, it should be on the mob
/// If its the result of a behavior, or something that could influence another behavior, it should be here
/// Short term memory is for things that are relevant for the split instance that is a turn's worth of decisions
/// Used mostly for precaching checks that would be inconvenient to pass through multiple procs
/// Things like "can I see the target" or "am I next to the target"
/// Midterm memory is for things that are relevant for the duration of a single complete action
/// Things actions that take more than a split instant to complete, like attacking or moving
/// Longterm memory is for things that are relevant for multiple actions, possibly even indefinitely
/// Things like a target's last known position, whether or not we've seen this target before, etc
/// Try not to store any hard references to things in longterm memory, as they'll surely cause hard dels
/// Coordinates, strings, and other primitives are good, weak references might be okay, but be careful
/datum/hostile_blackboard
	var/in_use // is the blackboard in_use to yet?

	//////////////////////////////////////////////////
	////// SHORTTERM MEMORY //////////////////////////
	/// We are allowed to move this turn!
	var/allowed_to_move
	// allowed_to_attack_target // confirmed verified to be allowed to attack the target
	var/allowed_to_attack_target 
	/// confirmed verified to be allowed to punch the target
	var/allowed_to_melee_target
	/// confirmed verified to be allowed to shoot the target
	var/allowed_to_shoot_target
	/// confirmed verified to be next to a target
	var/is_adjacent_to_target
	/// confirmed verified to be not next to a target
	var/is_far_from_target // BUT DAN WHY NOT JUST USE NOT IS_ADJACENT_TO_TARGET-- sh-shut up
	/// confirmed verified to be able to see the target
	var/can_chase_target
	/// confirmed verified to have a line of sight to the target
	var/has_line_of_sight_to_target
	/// is the mob doing something?
	var/is_busy
	/// abort and just move to the target
	var/just_move_to_target
	/// We did a shot this turn!
	var/shot_was_performed
	/// We did a punch this turn!
	var/punch_was_performed
	/// Target is the container of our true target
	var/target_in_something

	//////////////////////////////////////////////////
	////// MIDTERM MEMORY ////////////////////////////
	/// we're locked into doing an attack until...
	var/attacking_until
	/// we're locked into telegraphing an attack until...
	var/telegraphing_until
	/// what kind of movement are we doing?
	var/movement_style = HAI_MOVEMODE_WANDER
	/// if we're locked into a movement mode, this is it
	var/movement_mode_lock
	/// when did we last attack?
	var/last_attack_time = 0
	/// are we mad at our target, or just told to go there? for whether or not we should respect chase laws (est. 2016)
	var/mad_at_target

	/// The coords of wherever we're moving, if anything
	var/move_to_x
	var/move_to_y
	var/move_to_z
	/// How many turns have we been trying to get there? Used to determine if our pathfinding is bingused
	var/move_to_attempts = 0
	/// do we still have the same target as last time?
	var/retained_target
	var/in_combat
	/// Time at which we just give up on our target
	var/give_up_time = 0

	//////////////////////////////////////////////////
	////// LONGTERM MEMORY ///////////////////////////
	/// fun coords we wanna remember
	var/targ_x
	var/targ_y
	var/targ_z

	/// the last ckey we've met, mainly for skipping surprise attacks
	var/last_met_ckey
	/// the last time we've met that ckey
	var/last_met_time

	/// If a player is in us, just ignore anything that isnt cooldowns
	var/player_controlled

	/// When we're out of combat, try to approach this guy, up to their minimum distance
	var/datum/weakref/follow_target

/datum/hostile_blackboard/proc/wipe_shortterm()
	allowed_to_attack_target = null
	allowed_to_melee_target = null
	allowed_to_shoot_target = null
	is_adjacent_to_target = null
	is_far_from_target = null
	can_chase_target = null
	has_line_of_sight_to_target = null
	is_busy = null
	just_move_to_target = null
	in_use = null
	shot_was_performed = null
	punch_was_performed = null
	target_in_something = null

/datum/hostile_blackboard/proc/wipe_midterm()
	attacking_until = 0
	movement_style = HAI_MOVEMODE_WANDER
	last_attack_time = 0
	shot_was_performed = null
	mad_at_target = null
	move_to_x = null
	move_to_y = null
	move_to_z = null
	move_to_attempts = 0
	retained_target = null

/datum/hostile_blackboard/proc/wipe_longterm()
	targ_x = null
	targ_y = null
	targ_z = null
	last_met_ckey = null
	last_met_time = null
	give_up_time = null
	follow_target = null

/datum/hostile_blackboard/proc/forget_target()
	targ_x = null
	targ_y = null
	targ_z = null

/datum/hostile_blackboard/proc/remember_target(atom/target)
	if(!target)
		return
	targ_x = target.x
	targ_y = target.y
	targ_z = target.z

/datum/hostile_blackboard/proc/get_target()
	var/turf/targturf = locate(targ_x, targ_y, targ_z)
	if(!targturf)
		targ_x = null
		targ_y = null
		targ_z = null
		return
	return targturf

/datum/hostile_blackboard/proc/target_lost()
	clear_movement_target()
	wipe_shortterm()
	wipe_midterm()

/datum/hostile_blackboard/proc/set_in_combat()
	in_combat = TRUE

/datum/hostile_blackboard/proc/set_out_of_combat()
	in_combat = FALSE

/datum/hostile_blackboard/proc/telegraphing_melee_until(time)
	COOLDOWN_START(src, telegraphing_until, time)

/datum/hostile_blackboard/proc/is_telegraphing_melee()
	return COOLDOWN_TIMELEFT(src, telegraphing_until)

/datum/hostile_blackboard/proc/finished_telegraphing_melee()
	telegraphing_until = 0

/datum/hostile_blackboard/proc/attack_until(time)
	COOLDOWN_START(src, attacking_until, time)

/datum/hostile_blackboard/proc/is_attacking()
	return COOLDOWN_TIMELEFT(src, attacking_until)

/datum/hostile_blackboard/proc/force_allowed_to_melee()
	allowed_to_melee_target = TRUE
	allowed_to_attack_target = TRUE
	has_line_of_sight_to_target = TRUE

/datum/hostile_blackboard/proc/remember_ckey(targck)
	last_met_ckey = targck
	last_met_time = world.time

/datum/hostile_blackboard/proc/set_approaching() // or following
	movement_style = HAI_MOVEMODE_APPROACH

/datum/hostile_blackboard/proc/set_retreating()
	movement_style = HAI_MOVEMODE_RETREAT

/datum/hostile_blackboard/proc/set_rushing()
	if(!isnull(movement_mode_lock) && movement_mode_lock != HAI_MOVEMODE_RUSH)
		return
	movement_style = HAI_MOVEMODE_RUSH
	clear_movement_target() // no target means we default to running up to the mob's target

/datum/hostile_blackboard/proc/set_fleeing()
	if(!isnull(movement_mode_lock) && movement_mode_lock != HAI_MOVEMODE_FLEE)
		return
	movement_style = HAI_MOVEMODE_FLEE

/datum/hostile_blackboard/proc/set_standing()
	movement_style = HAI_MOVEMODE_STAND

/datum/hostile_blackboard/proc/set_wandering()
	movement_style = HAI_MOVEMODE_WANDER
	clear_movement_target()

/datum/hostile_blackboard/proc/is_rushing()
	return movement_style == HAI_MOVEMODE_RUSH

/datum/hostile_blackboard/proc/is_engaging()
	return movement_style == HAI_MOVEMODE_APPROACH || movement_style == HAI_MOVEMODE_RUSH

/datum/hostile_blackboard/proc/is_retreating()
	return movement_style == HAI_MOVEMODE_RETREAT || movement_style == HAI_MOVEMODE_FLEE

/datum/hostile_blackboard/proc/is_wandering()
	return movement_style == HAI_MOVEMODE_WANDER

/datum/hostile_blackboard/proc/force_rush()
	set_rushing()
	movement_mode_lock = movement_style

/datum/hostile_blackboard/proc/unforce_rush()
	movement_mode_lock = null

/datum/hostile_blackboard/proc/force_flee()
	set_fleeing()
	movement_mode_lock = movement_style

/datum/hostile_blackboard/proc/unforce_flee()
	movement_mode_lock = null

/datum/hostile_blackboard/proc/set_movement_target(atom/there)
	if(!there)
		return
	clear_movement_target()
	move_to_x = there.x
	move_to_y = there.y
	move_to_z = there.z
	move_to_attempts = 0

/datum/hostile_blackboard/proc/get_movement_target()
	var/turf/there = locate(move_to_x, move_to_y, move_to_z)
	if(!there)
		clear_movement_target()
		return
	return there

/datum/hostile_blackboard/proc/clear_movement_target()
	move_to_x = null
	move_to_y = null
	move_to_z = null
	move_to_attempts = 0

/// Used to both ticking our attempts to move to a target, and whether we should retain the target or get a new one, if any
/datum/hostile_blackboard/proc/should_retain_target(atom/me)
	var/turf/there = get_movement_target()
	if(!there)
		clear_movement_target()
		return FALSE
	if(get_turf(me) == get_turf(there))
		clear_movement_target()
		return FALSE // we're there!
	if(move_to_attempts > 5)
		clear_movement_target()
		return FALSE
	move_to_attempts++
	return TRUE

/datum/hostile_blackboard/proc/check_pursuit_time()
	if(!give_up_time)
		return FALSE
	if(world.time > give_up_time)
		give_up_time = 0
		return TRUE
	return FALSE

/datum/hostile_blackboard/proc/seen_target(atom/target, gup)
	give_up_time = world.time + gup

/datum/hostile_blackboard/proc/melee_thought_performed()
	punch_was_performed = TRUE

/datum/hostile_blackboard/proc/ranged_thought_performed()
	shot_was_performed = TRUE

/datum/hostile_blackboard/proc/had_combat_thought()
	return punch_was_performed || shot_was_performed
