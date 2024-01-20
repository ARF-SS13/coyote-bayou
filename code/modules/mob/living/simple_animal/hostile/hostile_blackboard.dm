/// <reference path="../../typings/tsd.d.ts" />
/// A dynamic thoughts-at-this-instant blackboard for the hostile AI.
/// written t by Michael Leonffu on 01/26/2016
/// written to at the beginning of an AI action, and overwritten at the start of the next action
/datum/hostile_blackboard
	var/written // is the blackboard written to yet?
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

/datum/hostile_blackboard/proc/wipe()
	allowed_to_attack_target = null
	allowed_to_melee_target = null
	allowed_to_shoot_target = null
	is_adjacent_to_target = null
	is_far_from_target = null
	can_chase_target = null
	has_line_of_sight_to_target = null
	is_busy = null
	just_move_to_target = null
	blackboard.written = null








