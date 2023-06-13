// TO add, more damage procs
SUBSYSTEM_DEF(damage)
	name = "Damage"
	flags = SS_BACKGROUND|SS_NO_INIT|SS_NO_FIRE
	wait = 1 SECONDS

/// Takes in an attacker, defender, and what's doing the damage, and routes it to the proper formatter
/// This is the main proc that should be called for damage. Will handle all the checks and whatnot
/// Currently only handles melee!
/datum/controller/subsystem/damage/proc/deal_damage(mob/living/attacker, mob/living/defender, obj/weapon, list/overrides)
	if(!defender)
		return
	if(!weapon)
		return
	if(isobj(weapon))
		return obj_damage_mob(attacker, defender, weapon, overrides)

	/// Time for a router!
	// if(isliving(weapon) && isliving(attacker))
	// 	if(isobj(defender))
	// 		return mob_damage_obj(attacker, defender, overrides)
	// 	return mob_damage_mob(attacker, defender, overrides)
	// if(istype(weapon, /obj/item/projectile))
	// 	if(isobj(defender))
	// 		return projectile_damage_obj(attacker, defender, weapon, overrides)
	// 	return projectile_damage_mob(attacker, defender, weapon, overrides)
	// if(isobj(weapon))
	// 	if(isobj(defender))
	// 		return obj_damage_obj(attacker, defender, weapon, overrides)
	// 	return obj_damage_mob(attacker, defender, weapon, overrides)

/// When a Movable attacks another Movable with an obj - projectile, melee, etc
/datum/controller/subsystem/damage/proc/damage_movable(atom/movable/attacker, atom/movable/defender, obj/weapon, list/overrides)
	if(!ismovable(defender))
		return
	if(!ismovable(attacker))
		return
	if(is_pacifist(attacker))
		return
	/// First, check if the attacker is a simplemob, and is player controlled
	if(simplemob_antigrief(attacker, defender))
		return
	/// Now, convert the object into a standardized list of damaging attributes
	var/list/output = obj2dmg(weapon)
	if(!output)
		return
	/// Overwrite with any overrides
	if(LAZYLEN(overrides))
		output = handle_overrides(overrides)
	/// Apply any traits
	output = handle_attacker_traits(attacker, weapon, output)
	output = handle_defender_traits(defender, weapon, output)
	/// Attacker skill shit
	output = handle_attacker_skills(attacker, defender, weapon, output)
	/// Now, deal the damage. With the right proc. Cus it could be a mob, or an obj. *shrug*
	if(isobj(defender))
		var/obj/object_defender = defender
		var/dmg = LAZYACCESS(output, DAMAGE_FORCE) || 0
		var/dtype = LAZYACCESS(output, DAMAGE_TYPE) || BRUTE
		var/darmor = LAZYACCESS(output, DAMAGE_ARMOR_CHECK) || ARMOR_MELEE
		var/dap = LAZYACCESS(output, DAMAGE_ARMOR_PENETRATION) || 0
		object_defender.take_damage(dmg, dtype, darmor, TRUE, armour_penetration = dap, attacked_by = attacker)
		return output
	if(isliving(defender)) // lets not even think about non-living mobs, they dont exist, they dont fucking exist
		if(output[DAMAGE_FORCE] > 0)
			output_damage_mob(attacker, defender, output)
		/// And the stamina damage, if any
		var/list/stamput = split_stamina(output)
		if(LAZYLEN(stamput) && LAZYACCESS(stamput, DAMAGE_STAMINA) > 0)
			output_damage_mob(attacker, defender, stamput)
	return output

/datum/controller/subsystem/damage/proc/obj2dmg(mob/living/attacker, obj/weapon)
	if(!weapon)
		return
	var/list/output = DAMAGE_LIST
	if(istype(weapon, /obj/item/projectile))
		var/obj/item/projectile/damproj = weapon // force? nah, damage
		output[DAMAGE_FORCE] = damproj.damage || 0
		output[DAMAGE_TYPE] = damproj.damage_type || BRUTE
		output[DAMAGE_STAMINA] = damproj.stamina || 0
		output[DAMAGE_ARMOR_CHECK] = damproj.flag || ARMOR_BULLET
		output[DAMAGE_ZONE] = damproj.def_zone || BODY_ZONE_CHEST
	else
		output[DAMAGE_FORCE] = weapon.force || 0
		output[DAMAGE_TYPE] = weapon.damtype || BRUTE
		output[DAMAGE_STAMINA] = weapon.stamina_force || 0
		output[DAMAGE_ARMOR_CHECK] = weapon.damage_armor || ARMOR_MELEE
		output[DAMAGE_ZONE] = attacker?.zone_selected || ran_zone(BODY_ZONE_CHEST)
	output[DAMAGE_WOUND_BONUS] = weapon.wound_bonus || 0
	if(isitem(weapon))
		var/obj/item/damitem = weapon
		output[DAMAGE_SHARPNESS] = damitem.sharpness || SHARP_NONE
		output[DAMAGE_ARMOR_PENETRATION] = damitem.armour_penetration || 0
		output[DAMAGE_DT_MODIFIER] = damitem.damage_threshold_modifier || 0
	return output

/datum/controller/subsystem/damage/proc/handle_overrides(list/overrides, list/damage_list = DAMAGE_LIST)
	for(var/ord in overrides)
		if(isnull(LAZYACCESS(overrides, ord)))
			continue
		LAZYSET(damage_list, ord, LAZYACCESS(overrides, ord))
	if(!isnull(LAZYACCESS(overrides, DAMAGE_MULTIPLIER)))
		LAZYSET(damage_list, DAMAGE_FORCE, LAZYACCESS(damage_list, DAMAGE_FORCE) * LAZYACCESS(overrides, DAMAGE_MULTIPLIER))
		LAZYSET(damage_list, DAMAGE_STAMINA, LAZYACCESS(damage_list, DAMAGE_STAMINA) * LAZYACCESS(overrides, DAMAGE_MULTIPLIER))
	return damage_list

/// If an object does stamina damage, make a copy of the damage list with only stamina damage
/datum/controller/subsystem/damage/proc/split_stamina(list/damage_list = DAMAGE_LIST)
	if(LAZYACCESS(damage_list, DAMAGE_STAMINA) <= 0)
		return
	var/list/output = damage_list
	output[DAMAGE_STAMINA] = output[DAMAGE_STAMINA] || 0
	output[DAMAGE_FORCE] = 0
	output[DAMAGE_TYPE] = STAMINA
	return output

/// Actually deals damage to a mob
/datum/controller/subsystem/damage/proc/handle_attacker_skills(mob/living/attacker, atom/movable/defender, obj/item/I, list/damage_list = DAMAGE_LIST)
	. = damage_list
	if(!isitem(I) || !isliving(attacker))
		return
	if(!attacker.mind || !I.used_skills)
		return
	var/skill_type = SKILL_ATTACK_MOB
	var/skill_train = SKILL_TRAIN_ATTACK_MOB
	if(isobj(defender))
		skill_type = SKILL_ATTACK_OBJ
		skill_train = SKILL_TRAIN_ATTACK_OBJ
	var/force = LAZYACCESS(damage_list, DAMAGE_FORCE) || 0
	if(force)
		force = attacker.mind.item_action_skills_mod(I, force, I.skill_difficulty, skill_type)
		LAZYSET(damage_list, DAMAGE_FORCE, force)
	for(var/skill in I.used_skills)
		if(!(skill_train in I.used_skills[skill]))
			continue
		var/datum/skill/S = GLOB.skill_datums[skill]
		attacker.mind.auto_gain_experience(skill, I.skill_gain*S.item_skill_gain_multi)

/// Actually deals damage to a mob
/datum/controller/subsystem/damage/proc/output_damage_mob(mob/living/attacker, mob/living/defender, list/damage_list = DAMAGE_LIST)
	if(!attacker)
		return
	var/base_damage = LAZYACCESS(damage_list, DAMAGE_FORCE) || 0
	var/damage_type = LAZYACCESS(damage_list, DAMAGE_TYPE) || BRUTE
	var/armor_check = LAZYACCESS(damage_list, DAMAGE_ARMOR_CHECK) || ARMOR_MELEE
	var/armor_penetration = LAZYACCESS(damage_list, DAMAGE_ARMOR_PENETRATION) || 0
	var/dt_modifier = LAZYACCESS(damage_list, DAMAGE_DT_MODIFIER) || 0
	var/target_part = LAZYACCESS(damage_list, DAMAGE_ZONE) || BODY_ZONE_CHEST
	var/wound = LAZYACCESS(damage_list, DAMAGE_WOUND_BONUS) || 0
	var/bare_wound = LAZYACCESS(damage_list, DAMAGE_BARE_WOUND_BONUS) || 0
	var/force_damage = LAZYACCESS(damage_list, DAMAGE_FORCE) || 0
	var/spread = LAZYACCESS(damage_list, DAMAGE_SPREAD) || 0
	var/signal = LAZYACCESS(damage_list, DAMAGE_SIGNAL) || 0

	var/list/armor_values = calculate_armor_values(attacker, target_part, armor_check, armor_penetration, dt_modifier) || list(0, 0)
	attacker.apply_damage(
		damage = base_damage,
		damagetype = damage_type,
		def_zone = target_part,
		blocked = LAZYACCESS(armor_values, 1) || 0,
		forced = force_damage,
		spread_damage = spread,
		wound_bonus = wound,
		bare_wound_bonus = bare_wound,
		sharpness = SHARP_NONE,
		damage_threshold = LAZYACCESS(armor_values, 2) || 0,
		sendsignal = signal
		)

/// Returns a list of armor values for the given zone and attack flag.
/// format: list(armor, DT)
/datum/controller/subsystem/damage/proc/calculate_armor_values(
	mob/living/defender,
	target_zone = BODY_ZONE_CHEST,
	armor_flag = ARMOR_MELEE,
	armor_penetration = 0,
	dt_modifier = 0,
)
	if(!defender)
		stack_trace("run_armor_check() called with null defender")
		return
	var/armor = defender.getarmor(def_zone, attack_flag)
	var/dt = defender.getarmor(def_zone, ARMOR_DAMAGE_THRESHOLD)
	armor_penetration = min(armor_penetration, 1)
	if(armor_penetration == 0 && dt_modifier) // no AP? no problem
		return list(armor, dt)
	if(armor_penetration > 0)
		armor *= (1 - armor_penetration)
	else if (armor_penetration < 0)
		armor *= (1 + armor_penetration) // finally! negative armor!
	dt = dt + dt_modifier
	return list(armor, dt)

/datum/controller/subsystem/damage/proc/handle_attacker_traits(mob/living/attacker, obj/weapon, list/damage_list = DAMAGE_LIST)
	if(!isliving(attacker))
		return
	var/list/output = damage_list
	var/force_modifier = 0
	var/force = LAZYACCESS(damage_list, DAMAGE_FORCE) || 0
	if(!istype(weapon, /obj/item/projectile))
		if(force >= 5)
			if(HAS_TRAIT(attacker, TRAIT_BIG_LEAGUES))
				force_modifier += 10

			if(HAS_TRAIT(attacker, TRAIT_LITTLE_LEAGUES))
				force_modifier += 5

			if(HAS_TRAIT(attacker, TRAIT_GENTLE))
				force_modifier += -5

			if(HAS_TRAIT(attacker, TRAIT_WIMPY))
				force_modifier += -10

			if(HAS_TRAIT(attacker, TRAIT_BUFFOUT_BUFF))
				force_modifier += (force * 0.25)

			if(HAS_TRAIT(attacker, TRAIT_FEV))
				force_modifier += (force * 0.35)

			if(HAS_TRAIT(attacker, TRAIT_SMUTANT))
				force_modifier += (force * 0.25)

			if(HAS_TRAIT(attacker, TRAIT_GHOULMELEE)) //negative trait
				force_modifier -= (force * 0.25)
		force = max(force + force_modifier, 0)

		var/stamloss = attacker.getStaminaLoss()
		if(stamloss) //The more tired you are, the less damage you do.
			var/penalty = clamp(1 - ((stamloss / STAMINA_NEAR_SOFTCRIT) * STAM_CRIT_ITEM_ATTACK_PENALTY), 0, 1)
			if(penalty > LYING_DAMAGE_PENALTY && !CHECK_MOBILITY(user, MOBILITY_STAND)) //damage penalty for fighting prone, doesn't stack with the above.
				penalty = LYING_DAMAGE_PENALTY
			force *= penalty
		LAZYSET(output, DAMAGE_FORCE, force + force_modifier)
	return output

/datum/controller/subsystem/damage/proc/handle_defender_traits(mob/living/defender, list/damage_list = DAMAGE_LIST)
	return

/datum/controller/subsystem/damage/proc/is_pacifist(mob/living/attacker, mob/living/defender, list/damage_list = DAMAGE_LIST)
	if(!isliving(attacker) || !isliving(defender)) // If one of them lack a soul, nobody minds
		return FALSE
	if(!HAS_TRAIT(attacker, TRAIT_PACIFISM))
		return FALSE
	var/force = LAZYACCESS(damage_list, DAMAGE_FORCE) || 0
	if(force <= 0)
		return FALSE
	var/damage_type = LAZYACCESS(damage_list, DAMAGE_TYPE) || BRUTE
	if(damage_type == STAMINA)
		return FALSE
	to_chat(attacker, span_warning("You don't want to harm other living beings!"))
	return TRUE

/datum/controller/subsystem/damage/proc/simplemob_antigrief(mob/living/simple_animal/attacker, mob/living/defender, list/damage_list = DAMAGE_LIST)
	if(!isliving(defender)) // No projectile, no problem (here at least)
		return FALSE
	if(!isanimal(attacker)) // Only simplemobs here pls
		return FALSE
	if(!attacker.ckey) // Only player controlled mobs here pls
		return FALSE
	var/damage = LAZYACCESS(damage_list, DAMAGE_DAMAGE) || 0
	if(damage <= 0) // No damage, no problem
		return FALSE
	if(!defender.stat) // Only if the person getting wrecked is not awake (crit, sleeping, etc)
		return FALSE
	return TRUE

