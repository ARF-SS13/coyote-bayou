/// Currently moving toward the target, up to their minimum distance
#define HAI_MOVEMODE_APPROACH 1
/// Currently moving away from the target, up to their retreat distance
#define HAI_MOVEMODE_RETREAT 2
/// Currently moving toward the target, up to melee range
#define HAI_MOVEMODE_ATTACK 3
/// Currently moving away from the target, up to 5 times their retreat distance
#define HAI_MOVEMODE_FLEE 4
/// Currently standing ground
#define HAI_MOVEMODE_STAND 5

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
	////// SHORTTERM MEMORY
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

	////// MIDTERM MEMORY
	/// we're locked into doing an attack until...
	var/attacking_until
	/// what kind of movement are we doing?
	var/movement_style = HAI_MOVEMODE_DEFAULT

	/// do we still have the same target as last time?
	var/retained_target

	////// LONGTERM MEMORY
	/// fun coords we wanna remember
	var/targ_x
	var/targ_y
	var/targ_z

	/// the last ckey we've met, mainly for skipping surprise attacks
	var/last_met_ckey
	/// the last time we've met that ckey
	var/last_met_time

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
	blackboard.in_use = null

/datum/hostile_blackboard/proc/wipe_midterm()
	attacking_until = 0
	movement_style = HAI_MOVEMODE_DEFAULT

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


