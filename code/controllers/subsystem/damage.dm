// TO add, more damage procs
SUBSYSTEM_DEF(damage)
	name = "Damage"
	flags = SS_BACKGROUND|SS_NO_INIT|SS_NO_FIRE
	wait = 1 SECONDS

/datum/controller/subsystem/damage/proc/damage_mob(
	mob/living/attacker,
	mob/living/defender,
	base_damage = 0,
	damage_type = BRUTE,
	armor_check = "melee",
	wound_bonus = 0,
	bare_wound_bonus = 0,
	sharpness = SHARP_NONE,
	armor_penetration = 0, // man fuck armor pen
	)
	if(!defender)
		return
	var/target_part = BODY_ZONE_CHEST
	if(isliving(attacker))
		target_part = attacker.zone_selected
	var/armor = defender.run_armor_check(target_part, armor_check, null, null, armor_penetration, null)
	var/dt = max(defender.run_armor_check(target_part, "damage_threshold", null, null, armor_penetration, null), 0)
	defender.apply_damage(
		base_damage,
		damage_type,
		target_part,
		armor,
		FALSE,
		FALSE,
		wound_bonus,
		bare_wound_bonus,
		sharpness,
		dt,
		TRUE,
		)
