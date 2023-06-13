/**
 *This is the proc that handles the order of an item_attack.
 *The order of procs called is:
 *tool_act on the target. If it returns TRUE, the chain will be stopped.
 *pre_attack() on src. If this returns TRUE, the chain will be stopped.
 *attackby on the target. If it returns TRUE, the chain will be stopped.
 *and lastly
 *afterattack. The return value does not matter.
 */
/obj/item/proc/melee_attack_chain(mob/user, atom/target, params, attackchain_flags, damage_multiplier = 1)
	if(isliving(user))
		var/mob/living/L = user
		if(!CHECK_MOBILITY(L, MOBILITY_USE) && !(attackchain_flags & ATTACK_IS_PARRY_COUNTERATTACK))
			to_chat(L, span_warning("You are unable to swing [src] right now!"))
			return
		if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACKCHAIN, user, target, params) & COMPONENT_ITEM_NO_ATTACK)
			return
		if(min_reach && GET_DIST_EUCLIDEAN(user, target) < min_reach)
			return
	. = attackchain_flags
	if(tool_behaviour && ((. = target.tool_act(user, src, tool_behaviour)) & STOP_ATTACK_PROC_CHAIN))
		return
	if((. |= pre_attack(target, user, params, ., damage_multiplier)) & STOP_ATTACK_PROC_CHAIN)
		return
	if((. |= target.attackby(src, user, params, ., damage_multiplier)) & STOP_ATTACK_PROC_CHAIN)
		return
	if(QDELETED(src) || QDELETED(target))
		return
	. |= afterattack(target, user, TRUE, params)

/// Like melee_attack_chain but for ranged.
/obj/item/proc/ranged_attack_chain(mob/user, atom/target, params)
	if(isliving(user))
		var/mob/living/L = user
		if(!CHECK_MOBILITY(L, MOBILITY_USE))
			to_chat(L, span_warning("You are unable to raise [src] right now!"))
			return
		if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACKCHAIN, user, target, params) & COMPONENT_ITEM_NO_ATTACK)
			return
		if(max_reach >= 2 && has_range_for_melee_attack(target, user))
			return ranged_melee_attack(target, user, params)
	return afterattack(target, user, FALSE, params)

// Called when the item is in the active hand, and clicked; alternately, there is an 'activate held object' verb or you can hit pagedown.
/obj/item/proc/attack_self(mob/user)
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_SELF, user) & COMPONENT_NO_INTERACT)
		return
	interact(user)

/obj/item/proc/pre_attack(atom/A, mob/living/user, params, attackchain_flags, damage_multiplier) //do stuff before attackby!
	if(SEND_SIGNAL(src, COMSIG_ITEM_PRE_ATTACK, A, user, params) & COMPONENT_NO_ATTACK)
		return STOP_ATTACK_PROC_CHAIN
	if(!(attackchain_flags & ATTACK_IGNORE_CLICKDELAY) && !CheckAttackCooldown(user, A))
		return STOP_ATTACK_PROC_CHAIN

/atom/proc/attackby(obj/item/W, mob/user, params, attackchain_flags, list/damage_overrides)
	if(SEND_SIGNAL(src, COMSIG_PARENT_ATTACKBY, W, user, params) & COMPONENT_NO_AFTERATTACK)
		return STOP_ATTACK_PROC_CHAIN

/obj/attackby(obj/item/I, mob/living/user, params, attackchain_flags, list/damage_overrides)
	. = ..()
	if(. & STOP_ATTACK_PROC_CHAIN)
		return
	if(obj_flags & CAN_BE_HIT)
		. |= I.attack_obj(src, user, damage_overrides)
	else
		. |= I.attack_obj_nohit(src, user, damage_overrides)

/mob/living/attackby(obj/item/I, mob/living/user, params, attackchain_flags, list/damage_overrides)
	. = ..()
	if(. & STOP_ATTACK_PROC_CHAIN)
		return
	. |= I.attack(src, user, attackchain_flags, damage_overrides)
	if(!(. & NO_AUTO_CLICKDELAY_HANDLING))	// SAFETY NET - unless the proc tells us we should not handle this, give them the basic melee cooldown!
		I.ApplyAttackCooldown(user, src, attackchain_flags)

/**
 * Called when someone uses us to attack a mob in melee combat.
 *
 * This proc respects CheckAttackCooldown() default clickdelay handling.
 *
 * @params
 * * mob/living/M - target
 * * mob/living/user - attacker
 * * attackchain_Flags - see [code/__DEFINES/_flags/return_values.dm]
 * * overrides - The overrides list to use for damage calculation. see [code\controllers\subsystem\damage.dm]
 */
/obj/item/proc/attack(mob/living/M, mob/living/user, attackchain_flags = NONE, list/overrides)
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK, M, user) & COMPONENT_ITEM_NO_ATTACK)
		return
	SEND_SIGNAL(user, COMSIG_MOB_ITEM_ATTACK, M, user)
	if(item_flags & NOBLUDGEON)
		return

	var/list/damage_list = SSdamage.deal_damage(user, M, src, overrides)

	if(LAZYACCESS(damage_list, DAMAGE_FORCE) <= 0)
		playsound(loc, pokesound, get_clamped_volume(), 1, -1)
	else if(hitsound)
		playsound(loc, hitsound, get_clamped_volume(), 1, -1)

	M.lastattacker = user.real_name
	M.lastattackerckey = user.ckey

	user.do_attack_animation(M)
	M.attacked_by(src, user, attackchain_flags, damage_list)

	log_combat(user, M, "attacked", src.name, "(INTENT: [uppertext(user.a_intent)]) (DAMTYPE: [uppertext(damtype)])")
	add_fingerprint(user)

//the equivalent of the standard version of attack() but for object targets.
/obj/item/proc/attack_obj(obj/O, mob/living/user, list/damage_overrides)
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_OBJ, O, user) & COMPONENT_NO_ATTACK_OBJ)
		return
	if(item_flags & NOBLUDGEON)
		return
	user.do_attack_animation(O)
	var/list/damage_list = SSdamage.deal_damage(user, O, src, damage_overrides)
	O.attacked_by(src, user, NONE, damage_list)

/obj/item/proc/attack_obj_nohit(obj/O, mob/living/user, list/damage_overrides)
	if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_OBJ_NOHIT, O, user) & COMPONENT_NO_ATTACK_OBJ)
		return

/// damage list contains the output of SSdamage.deal_damage()
/atom/movable/proc/attacked_by(obj/item/I, mob/living/user, attackchain_flags = NONE, list/damage_list = DAMAGE_LIST)
	return

/obj/attacked_by(obj/item/I, mob/living/user, attackchain_flags = NONE, list/damage_list = DAMAGE_LIST)
	var/totitemdamage = LAZYACCESS(damage_overrides, DAMAGE_FORCE) || 0
	if(!(attackchain_flags & NO_AUTO_CLICKDELAY_HANDLING))
		I.ApplyAttackCooldown(user, src, attackchain_flags)
	if(totitemdamage)
		visible_message(span_danger("[user] has hit [src] with [I]!"), null, null, COMBAT_MESSAGE_RANGE)
		//only witnesses close by and the victim see a hit message.
		log_combat(user, src, "attacked", I)

/mob/living/attacked_by(obj/item/I, mob/living/user, attackchain_flags = NONE, list/damage_list = DAMAGE_LIST)
	var/list/block_return = list()
	var/totitemdamage = LAZYACCESS(damage_overrides, DAMAGE_FORCE) || I.force
	if((user != src) && mob_run_block(I, totitemdamage, "the [I.name]", ((attackchain_flags & ATTACK_IS_PARRY_COUNTERATTACK)? ATTACK_IS_PARRY_COUNTERATTACK : NONE) | ATTACK_TYPE_MELEE, I.armour_penetration, user, null, block_return) & BLOCK_SUCCESS)
		return FALSE
	. = TRUE // successful attack
	totitemdamage = block_calculate_resultant_damage(totitemdamage, block_return)
	send_item_attack_message(I, user, null, totitemdamage)
	I.do_stagger_action(src, user, totitemdamage)
	if(!I.force)
		return
	if(I.damtype != BRUTE)
		return
	if(!prob(33))
		return
	I.add_mob_blood(src)
	var/turf/location = get_turf(src)
	add_splatter_floor(location)
	if(totitemdamage >= 10 && get_dist(user, src) <= 1)	//people with TK won't get smeared with blood
		user.add_mob_blood(src)

/mob/living/proc/pre_attacked_by(obj/item/I, mob/living/user)
	return

/**
 * Called after attacking something if the melee attack chain isn't interrupted before.
 * Also called when clicking on something with an item without being in melee range
 *
 * WARNING: This does not automatically check clickdelay if not in a melee attack! Be sure to account for this!
 *
 * @params
 * * target - The thing we clicked
 * * user - mob of person clicking
 * * proximity_flag - are we in melee range/doing it in a melee attack
 * * click_parameters - mouse control parameters, check BYOND ref.
 */
/obj/item/proc/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	SEND_SIGNAL(src, COMSIG_ITEM_AFTERATTACK, target, user, proximity_flag, click_parameters)
	SEND_SIGNAL(user, COMSIG_MOB_ITEM_AFTERATTACK, target, user, proximity_flag, click_parameters)


/obj/item/proc/has_range_for_melee_attack(atom/target, mob/living/user, reach_min, reach_max)
	if(user.z != target.z)
		return FALSE
	var/minimum_reach = reach_min ? reach_min : min_reach
	var/maximum_reach = reach_max ? reach_max : max_reach
	var/euclidean_distance = GET_DIST_EUCLIDEAN(user, target)
	if(euclidean_distance < max(minimum_reach, 2) || round(euclidean_distance) > maximum_reach)
		return FALSE // No need to waste time calculating the path.
	return user.euclidian_reach(target, maximum_reach, REACH_ATTACK) == get_turf(target)


/obj/item/proc/ranged_melee_attack(atom/target, mob/living/user, params)
	melee_attack_chain(user, target, params)


/obj/item/proc/get_clamped_volume()
	if(w_class)
		if(force)
			return clamp((force + w_class) * 4, 30, 100)// Add the item's force to its weight class and multiply by 4, then clamp the value between 30 and 100
		else
			return clamp(w_class * 6, 10, 100) // Multiply the item's weight class by 6, then clamp the value between 10 and 100

/mob/living/proc/send_item_attack_message(obj/item/I, mob/living/user, hit_area, obj/item/bodypart/hit_bodypart)
	var/message_verb = "attacked"
	if(length(I.attack_verb))
		message_verb = "[pick(I.attack_verb)]"
	else if(!I.force)
		return
	var/message_hit_area = ""
	if(hit_area)
		message_hit_area = " in the [hit_area]"
	var/attack_message = "[src] is [message_verb][message_hit_area] with [I]!"
	var/attack_message_local = "You're [message_verb][message_hit_area] with [I]!"
	if(user in viewers(src, null))
		attack_message = "[user] [message_verb] [src][message_hit_area] with [I]!"
		attack_message_local = "[user] [message_verb] you[message_hit_area] with [I]!"
	if(user == src)
		attack_message_local = "You [message_verb] yourself[message_hit_area] with [I]"
	visible_message(span_danger("[attack_message]"),\
		span_userdanger("[attack_message_local]"), null, COMBAT_MESSAGE_RANGE)
	return 1

/// How much stamina this takes to swing this is not for realism purposes hecc off.
/obj/item/proc/getweight(mob/living/user, multiplier = 1, trait = SKILL_STAMINA_COST)
	. = (total_mass || w_class * STAM_COST_W_CLASS_MULT) * multiplier
	if(!user)
		return
	var/bad_trait
	if(SEND_SIGNAL(user, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_INACTIVE))
		. *= STAM_COST_NO_COMBAT_MULT
		bad_trait = SKILL_COMBAT_MODE
	if(used_skills && user.mind)
		. = user.mind.item_action_skills_mod(src, ., skill_difficulty, trait, bad_trait, FALSE)
	var/total_health = user.getStaminaLoss()
	. = clamp(., 0, STAMINA_NEAR_CRIT - total_health)

/// How long this staggers for. 0 and negatives supported.
/obj/item/proc/melee_stagger_duration(force_override)
	if(!isnull(stagger_force))
		return stagger_force
	/// totally not an untested, arbitrary equation.
	return clamp((1.5 + (w_class/7.5)) * ((force_override || force) / 2), 0, 10 SECONDS)

/obj/item/proc/do_stagger_action(mob/living/target, mob/living/user, force_override)
	if(!CHECK_BITFIELD(target.status_flags, CANSTAGGER))
		return FALSE
	if(target.combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
		target.do_staggered_animation()
	var/duration = melee_stagger_duration(force_override)
	if(!duration)		//0
		return FALSE
	else if(duration > 0)
		target.Stagger(duration)
	else				//negative
		target.AdjustStaggered(duration)
	return TRUE

/mob/proc/do_staggered_animation()
	set waitfor = FALSE
	animate(src, pixel_x = -2, pixel_y = -2, time = 1, flags = ANIMATION_RELATIVE | ANIMATION_PARALLEL)
	animate(pixel_x = 4, pixel_y = 4, time = 1, flags = ANIMATION_RELATIVE)
	animate(pixel_x = -2, pixel_y = -2, time = 0.5, flags = ANIMATION_RELATIVE)
