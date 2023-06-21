#define RETURN_DL return damage_list
#define CHECKRETURN_DL if(LAZYACCESS(damage_list, DAMAGE_SHOULD_RETURN)) return damage_list
#define NOTSET(X) (isnull(LAZYACCESS(damage_list, X)))
/// SINS sets a variable in a list, if it is not already set
#define SETIFNOTSET(X, Y) if(NOTSET(X)) LAZYSET(damage_list, (X), (Y))

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Welcome to the damage subsystem! Home of the mega monolithic damage proc that does one thing: generate a damage value!
 * If something wants to apply damage to a target, and consider armor, wounding, stamina, etc, it should use one of these procs.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

// TO add, more damage procs
SUBSYSTEM_DEF(damage)
	name = "Damage"
	flags = SS_BACKGROUND|SS_NO_INIT|SS_NO_FIRE
	wait = 1 SECONDS
	COOLDOWN_LIST_DECLARE(armor_messages)

/// A generic proc to apply a kind of damage to a target, without an actual weapon.
/// Weapon here is a string, and will be used for messaging purposes
/// Bit of a mouth full, but its thourough and doesnt need huge blocks of repeated code
/datum/controller/subsystem/damage/proc/deal_damage(
		atom/movable/attacker,
		atom/movable/defender,
		damage = 0,
		stamina = 0,
		damage_type = BRUTE, // for the non-stamina damage
		target_zone = BODY_ZONE_CHEST,
		armor_type = null, // null means dont check armor
		armor_piercing = 0,
		damage_threshold_modifier = 0,
		wound_bonus = 0,
		bare_wound_bonus = 0,
		sharpness = SHARP_NONE,
		dismember_damage = 0,
		show_messages = TRUE,
		weapon,
		list/attack_verbs = list("hit"),
		spread_damage = FALSE,
		sendsignal = TRUE,
		forced = FALSE,
		trait_checks = NONE,
		list/overrides = list(),
		attack_kind, // set to something like ATTACK_EFFECT_KICK to show an effect
	)
	if(!defender)
		return DAMAGE_LIST
	if(!attacker)
		return DAMAGE_LIST
	if(!damage)
		return DAMAGE_LIST
	var/list/damage_list = DAMAGE_LIST
	if(isatom(weapon))
		var/atom/W = weapon
		weapon = W.name
	if(!weapon)
		LAZYSET(damage_list, DAMAGE_SHOW_MESSAGE, FALSE)
	else
		LAZYSET(damage_list, DAMAGE_SHOW_MESSAGE, show_messages)
	LAZYSET(damage_list, DAMAGE_WEAPON_NAME, weapon)
	LAZYSET(damage_list, DAMAGE_ATTACK_VERBS, attack_verbs)
	LAZYSET(damage_list, DAMAGE_FORCE, damage)
	LAZYSET(damage_list, DAMAGE_TYPE, damage_type)
	LAZYSET(damage_list, DAMAGE_ZONE, target_zone)
	LAZYSET(damage_list, DAMAGE_ARMOR_CHECK, armor_type)
	LAZYSET(damage_list, DAMAGE_FORCE_IT, forced)
	LAZYSET(damage_list, DAMAGE_SPREAD, spread_damage)
	LAZYSET(damage_list, DAMAGE_WOUND_BONUS, wound_bonus)
	LAZYSET(damage_list, DAMAGE_WOUND_NAKED, bare_wound_bonus)
	LAZYSET(damage_list, DAMAGE_SHARPNESS, sharpness)
	LAZYSET(damage_list, DAMAGE_DISMEMBER, dismember_damage)
	LAZYSET(damage_list, DAMAGE_EFFECT, attack_kind)
	if(CHECK_BITFIELD(trait_checks, TRAIT_FLAG_UNARMED))
		LAZYSET(damage_list, CHECK_TRAIT_UNARMED, TRUE)
	if(CHECK_BITFIELD(trait_checks, TRAIT_FLAG_MELEE))
		LAZYSET(damage_list, CHECK_TRAIT_MELEE, TRUE)
	if(CHECK_BITFIELD(trait_checks, TRAIT_FLAG_RANGED))
		LAZYSET(damage_list, CHECK_TRAIT_RANGED, TRUE)
	return damage_target(attacker, defender, weapon, 0, damage_list)

/// A generic proc to apply a kind of damage to a target, *without* a weapon
/// Mostly used for unarmed and melee simplemob attacks
/// Bit of a mouth full, but its thourough and doesnt need huge blocks of repeated code
/datum/controller/subsystem/damage/proc/punch_target(
		atom/movable/attacker,
		atom/movable/defender,
		weapon = "fist",
		damage_low = 0,
		damage_high = 0,
		stamina_low = 0,
		stamina_high = 0,
		attack_kind = ATTACK_EFFECT_PUNCH,
		damage_type = BRUTE,
		target_zone = BODY_ZONE_CHEST,
		armor_type = ARMOR_MELEE,
		armor_piercing = 0,
		damage_threshold_modifier = 0,
		wound_bonus = 0,
		bare_wound_bonus = 0,
		sharpness = SHARP_NONE,
		dismember_damage = 0,
		spread_damage = FALSE,
		sendsignal = TRUE,
		forced = FALSE,
		list/overrides = list(),
	)
	if(!defender)
		return DAMAGE_LIST
	if(!attacker)
		return DAMAGE_LIST
	if(isnull(damage_low) || isnull(damage_high))
		return DAMAGE_LIST
	var/list/damage_list = DAMAGE_LIST
	LAZYSET(damage_list, DAMAGE_SHOW_MESSAGE,     FALSE) // It'll end up handled by the attacking mob anyway
	LAZYSET(damage_list, DAMAGE_FORCE,            null )
	switch(attack_kind)
		if(ATTACK_EFFECT_KICK)
			LAZYSET(damage_list, DAMAGE_FORCE_LOW,    damage_low   * 1.5)
			LAZYSET(damage_list, DAMAGE_FORCE_HIGH,   damage_high  * 1.5)
			LAZYSET(damage_list, DAMAGE_STAMINA_LOW,  stamina_low  * 0.5)
			LAZYSET(damage_list, DAMAGE_STAMINA_HIGH, stamina_high * 0.5)
		else
			LAZYSET(damage_list, DAMAGE_FORCE_LOW,    damage_low  )
			LAZYSET(damage_list, DAMAGE_FORCE_HIGH,   damage_high )
			LAZYSET(damage_list, DAMAGE_STAMINA_LOW,  stamina_low )
			LAZYSET(damage_list, DAMAGE_STAMINA_HIGH, stamina_high)
		// if(ATTACK_EFFECT_PUNCH)
		// if(ATTACK_EFFECT_CLAW)
		// if(ATTACK_EFFECT_SMASH)
	LAZYSET(damage_list, DAMAGE_TYPE,         damage_type      )
	LAZYSET(damage_list, DAMAGE_ZONE,         target_zone     )
	LAZYSET(damage_list, DAMAGE_ARMOR_CHECK,  armor_type      )
	LAZYSET(damage_list, DAMAGE_FORCE_IT,     forced          )
	LAZYSET(damage_list, DAMAGE_SPREAD,       spread_damage   )
	LAZYSET(damage_list, DAMAGE_WOUND_BONUS,  wound_bonus     )
	LAZYSET(damage_list, DAMAGE_WOUND_NAKED,  bare_wound_bonus)
	LAZYSET(damage_list, DAMAGE_SHARPNESS,    sharpness       )
	LAZYSET(damage_list, DAMAGE_DISMEMBER,    dismember_damage)
	LAZYSET(damage_list, CHECK_TRAIT_UNARMED, TRUE            )
	LAZYSET(damage_list, DAMAGE_EFFECT,       attack_kind     )
	return damage_target(attacker, defender, weapon, 0, overrides, damage_list)

/// For when a slime tries to hit something
/datum/controller/subsystem/damage/proc/slime_attack(
		mob/living/simple_animal/slime/slime_attacker,
		atom/movable/defender,
		attackchain_flags,
		list/overrides,
		list/damage_list = list(),
	)
	if(!defender || !isslime(slime_attacker))
		return DAMAGE_LIST

	var/dam_lo = SLIME_DAMAGE_LOW
	var/dam_hi = SLIME_DAMAGE_HIGH
	var/wound = SLIME_WOUNDING
	var/dam_type = SLIME_DAMAGE_TYPE

	if(slime_attacker.is_adult)
		dam_lo = ADULT_SLIME_DAMAGE_LOW
		dam_hi = ADULT_SLIME_DAMAGE_HIGH
		wound = ADULT_SLIME_WOUNDING
		dam_type = ADULT_SLIME_DAMAGE_TYPE

	slime_attacker.electrozap(defender)

	return punch_target(
		attacker = slime_attacker,
		defender = defender,
		weapon = "goop",
		damage_low = dam_lo,
		damage_high = dam_hi,
		damage_type = dam_type,
		target_zone = ran_zone(BODY_ZONE_CHEST),
		armor_type = SLIME_ARMOR_CHECK,
		wound_bonus = wound,
		attack_kind = ATTACK_EFFECT_PUNCH,
	)

/// For when a monkey tries to hit something
/datum/controller/subsystem/damage/proc/monkey_attack(
		mob/living/carbon/monkey/monkey_attacker,
		atom/movable/defender,
		attackchain_flags,
		list/overrides,
		list/damage_list = list(),
	)
	if(!defender || !ismonkey(monkey_attacker))
		return
		
	if(monkey_attacker.is_muzzled() || (monkey_attacker.wear_mask && monkey_attacker.wear_mask.flags_cover & MASKCOVERSMOUTH))
		to_chat(monkey_attacker, span_warning("You can't bite with your mouth covered!"))
		return DAMAGE_LIST
	return punch_target(
		attacker = monkey_attacker,
		defender = defender,
		weapon = "chomp",
		damage_low = MONKEY_DAMAGE_LOW,
		damage_high = MONKEY_DAMAGE_HIGH,
		damage_type = MONKEY_DAMAGE_TYPE,
		target_zone = ran_zone(BODY_ZONE_CHEST),
		armor_type = ARMOR_MELEE,
		wound_bonus = MONKEY_WOUNDING,
		attack_kind = ATTACK_EFFECT_BITE,
	)

/// For when a monkey tries to hit something
/datum/controller/subsystem/damage/proc/larva_attack(
		mob/living/carbon/alien/larva/larva_attacker,
		atom/movable/defender,
		attackchain_flags,
		list/overrides,
		list/damage_list = list(),
	)
	if(!defender || !islarva(larva_attacker))
		return DAMAGE_LIST
	return punch_target(
		attacker = larva_attacker,
		defender = defender,
		weapon = "nibble",
		damage_low = LARVA_DAMAGE_LOW,
		damage_high = LARVA_DAMAGE_HIGH,
		damage_type = LARVA_DAMAGE_TYPE,
		target_zone = ran_zone(BODY_ZONE_CHEST),
		armor_type = ARMOR_MELEE,
		wound_bonus = LARVA_WOUNDING,
		attack_kind = ATTACK_EFFECT_BITE,
	)

/// For when an alium tries to hit something
/datum/controller/subsystem/damage/proc/alien_attack(
		mob/living/carbon/alien/alien_attacker,
		atom/movable/defender,
		attackchain_flags,
		list/overrides,
		list/damage_list = list(),
	)
	if(!defender || !isalien(alien_attacker))
		return DAMAGE_LIST

	var/d_low = alien_attacker.meleeSlashHumanPower
	var/d_high = alien_attacker.meleeSlashHumanPower
	if(isanimal(defender))
		d_low = alien_attacker.meleeSlashSAPower
		d_high = alien_attacker.meleeSlashSAPower

	return punch_target(
		attacker = alien_attacker,
		defender = defender,
		weapon = "scythe claws",
		damage_low = d_low,
		damage_high = d_high,
		damage_type = BRUTE,
		target_zone = alien_attacker.zone_selected || ran_zone(BODY_ZONE_CHEST),
		armor_type = ARMOR_MELEE,
		wound_bonus = 25,
		attack_kind = ATTACK_EFFECT_CLAW,
	)

/// A more abbreviated version of deal_damage, which takes in an attacker, a defender, and a weapon
/// And then just deals damage based on the weapon, to the defender
/// Also allows for a list of overrides, which can be used to change the damage type, force, etc
/datum/controller/subsystem/damage/proc/whack_target(
		atom/movable/attacker,
		atom/movable/defender,
		obj/weapon,
		attackchain_flags,
		list/overrides,
		list/damage_list = list(),
	)
	if(!defender || !isobj(weapon)) // try a different proc, this one needs a weapon (i mean it doesnt, but you should use a proc that doesnt need one if you dont have one)
		return DAMAGE_LIST
	LAZYSET(damage_list, CHECK_TRAIT_MELEE, TRUE)
	return damage_target(attacker, defender, weapon, attackchain_flags, overrides, damage_list)

/// A more abbreviated version of deal_damage, which takes in an attacker, a defender, and a projectile (as a weapon)
/// And then just deals damage based on the weapon, to the defender
/// Also allows for a list of overrides, which can be used to change the damage type, force, etc
/datum/controller/subsystem/damage/proc/shoot_target(
		atom/movable/attacker,
		atom/movable/defender,
		obj/item/projectile/weapon,
		attackchain_flags,
		list/overrides,
		list/damage_list = list(),
	)
	if(!istype(defender) || !isprojectile(weapon)) // try a different proc, this one needs a weapon (i mean it doesnt, but you should use a proc that doesnt need one if you dont have one)
		return DAMAGE_LIST
	if(!attacker && ismovable(weapon.firer))
		attacker = weapon.firer
	LAZYSET(damage_list, CHECK_TRAIT_RANGED, TRUE)
	return damage_target(attacker, defender, weapon, attackchain_flags, overrides, damage_list)

/// A proc that handles a thrown object hitting a target
/datum/controller/subsystem/damage/proc/collide_with_target(
		atom/movable/attacker,
		atom/movable/defender,
		atom/movable/weapon,
		damage, // cus it can be various things
		impacting_zone,
		attackchain_flags,
		list/overrides,
		list/damage_list = list(),
	)
	if(!defender)
		return
	/// Okay, so we need to extract the damage from the thrown object
	/// just kidding, we probably dont
	var/list/partial_damage_list = list()
	ENABLE_BITFIELD(attackchain_flags, ATTACK_TYPE_THROWN)
	LAZYSET(partial_damage_list, DAMAGE_FORCE, damage)
	LAZYSET(damage_list, CHECK_TRAIT_MELEE, TRUE)
	if(impacting_zone)
		impacting_zone = ran_zone(BODY_ZONE_CHEST, 65)//Hits a random part of the body, geared towards the chest
	LAZYSET(partial_damage_list, DAMAGE_ZONE, impacting_zone)
	return damage_target(attacker, defender, weapon, attackchain_flags, overrides, partial_damage_list)

/// When something (doesnt have to be anything) wants to attack a target (must be at least a movable)
/// could be with a weapon, or not. This is the proc that handles it
/datum/controller/subsystem/damage/proc/damage_target(
		atom/movable/attacker,
		atom/movable/defender,
		weapon, // can be an atom, text, or nothing at all!!! please make it something
		attackchain_flags,
		list/overrides = list(),
		list/damage_list = list(), // Oh we are gonna pass this list around like a femboy at a furry convention
	)
	if(!ismovable(defender))
		return
	/// Meet the furry convention
	LAZYSET(damage_list, DAMAGE_ATTACKCHAIN_FLAGS, attackchain_flags)
	damage_list = handle_damage_roll(attacker, defender, weapon, damage_list) // order goes: item, item's overrides, attacker's overrides, then defender's overrides
	CHECKRETURN_DL
	damage_list = obj2dmg(attacker, defender, weapon, damage_list)
	CHECKRETURN_DL
	damage_list = handle_overrides(attacker, defender, weapon, damage_list, overrides)
	CHECKRETURN_DL
	if(is_pacifist(attacker, defender, damage_list))
		return DAMAGE_LIST
	if(simplemob_antigrief(attacker, defender, damage_list))
		return DAMAGE_LIST
	damage_list = handle_attacker_traits(attacker, weapon, damage_list)
	CHECKRETURN_DL
	damage_list = handle_attacker_skills(attacker, defender, weapon, damage_list)
	CHECKRETURN_DL
	damage_list = handle_defender_traits(defender, weapon, damage_list)
	CHECKRETURN_DL
	damage_list = handle_block_parry(attacker, defender, weapon, damage_list, overrides)
	CHECKRETURN_DL
	/// Boy that list must be getting sore
	/// Too bad we aint even close to done yet
	/// Now, deal the damage. With the right proc. Cus it could be a mob, or an obj. *shrug*
	if(isobj(defender))
		damage_list = output_damage_obj(attacker, defender, weapon, damage_list, TRUE)
		RETURN_DL
	if(isliving(defender)) // lets not even think about non-living mobs, they dont exist, they dont fucking exist
		if(ishuman(defender))
			damage_list = handle_human(attacker, defender, weapon, damage_list)
			if(LAZYACCESS(damage_list, DAMAGE_SHOULD_RETURN))
				RETURN_DL
		if(iscarbon(defender))
			damage_list = handle_carbon(attacker, defender, weapon, damage_list)
			if(LAZYACCESS(damage_list, DAMAGE_SHOULD_RETURN))
				RETURN_DL
		if(damage_list[DAMAGE_FORCE] > 0)
			output_damage_mob(attacker, defender, weapon, damage_list)
		/// And the stamina damage, if any
		var/list/stamput = split_stamina(damage_list)
		if(LAZYLEN(stamput) && LAZYACCESS(stamput, DAMAGE_STAMINA) > 0)
			output_damage_mob(attacker, defender, weapon, stamput)
	attack_effect(attacker, defender, weapon, damage_list)
	RETURN_DL

// Extracts attack values from an object, be it melee or projectile
// But if any values on the damage_list are already set, this'll fill them in
// See [code\__DEFINES\damage.dm] for more!
/datum/controller/subsystem/damage/proc/obj2dmg(mob/living/attacker, mob/living/defender, obj/weapon, list/damage_list = list())
	if(!istype(weapon)) // proc best have a good set of overrides
		RETURN_DL
	if(!LAZYLEN(damage_list))
		damage_list = DAMAGE_LIST
	var/is_thrown = LAZYACCESS(damage_list, DAMAGE_ATTACKCHAIN_FLAGS) & ATTACK_TYPE_THROWN
	if(istype(weapon, /obj/item/projectile))
		var/obj/item/projectile/damproj = weapon // force? nah, damage
		LAZYSET(damage_list, CHECK_TRAIT_RANGED, TRUE)
		SETIFNOTSET(DAMAGE_WEAPON_NAME,  damproj.name        || "bullet"        ) // also gonna be handled by the bullet
		SETIFNOTSET(DAMAGE_FORCE,        damproj.damage      || 0               )
		SETIFNOTSET(DAMAGE_TYPE,         damproj.damage_type || BRUTE           )
		SETIFNOTSET(DAMAGE_STAMINA,      damproj.stamina     || 0               )
		SETIFNOTSET(DAMAGE_ARMOR_CHECK,  damproj.flag        || ARMOR_BULLET    )
		SETIFNOTSET(DAMAGE_ZONE,         damproj.def_zone    || BODY_ZONE_CHEST ) // handled by the bullet
	else // its a melee weapon (probably)
		LAZYSET(damage_list, CHECK_TRAIT_MELEE, TRUE)
		if(is_thrown)
			SETIFNOTSET(DAMAGE_FORCE,    weapon.throwforce    || 0           )
		else
			SETIFNOTSET(DAMAGE_FORCE,    weapon.force         || 0           )
		SETIFNOTSET(DAMAGE_WEAPON_NAME,  weapon.name          || "something" )
		SETIFNOTSET(DAMAGE_TYPE,         weapon.damtype       || BRUTE       )
		SETIFNOTSET(DAMAGE_STAMINA,      weapon.stamina_force || 0           )
		SETIFNOTSET(DAMAGE_ARMOR_CHECK,  weapon.damage_armor  || ARMOR_MELEE )
		if(NOTSET(DAMAGE_ZONE))
			var/dmg_zone = BODY_ZONE_CHEST
			if(istype(attacker))
				if(attacker == defender)
					dmg_zone = check_zone(attacker.zone_selected)
				else
					dmg_zone = ran_zone(attacker.zone_selected)
			LAZYSET(damage_list, DAMAGE_ZONE, dmg_zone) // just gonna tuck this down here
	SETIFNOTSET(DAMAGE_WOUND_BONUS, weapon.wound_bonus      || 0)
	SETIFNOTSET(DAMAGE_WOUND_NAKED, weapon.bare_wound_bonus || 0)
	if(isitem(weapon))
		var/obj/item/damitem = weapon
		SETIFNOTSET(DAMAGE_ATTACK_VERBS,      damitem.attack_verb               || list("hit") )
		SETIFNOTSET(DAMAGE_SHARPNESS,         damitem.sharpness                 || SHARP_NONE  )
		SETIFNOTSET(DAMAGE_ARMOR_PENETRATION, damitem.armour_penetration        || 0           )
		SETIFNOTSET(DAMAGE_DT_MODIFIER,       damitem.damage_threshold_modifier || 0           )
		damage_list = handle_surgical_tool(attacker, defender, damitem, damage_list)
	RETURN_DL

/datum/controller/subsystem/damage/proc/handle_surgical_tool(mob/living/attacker, mob/living/defender, obj/item/damitem, list/damage_list = list())
	if(!isliving(defender) || !isliving(attacker) || !isitem(damitem))
		RETURN_DL
	if(!CHECK_BITFIELD(damitem.item_flags, SURGICAL_TOOL))
		RETURN_DL
	if(attacker.a_intent != INTENT_HELP)
		RETURN_DL
	if(!CHECK_BITFIELD(defender.mobility_flags, MOBILITY_STAND))
		RETURN_DL
	if(!LAZYLEN(defender.surgeries))
		RETURN_DL
	LAZYSET(damage_list, DAMAGE_WOUND_BONUS, CANT_WOUND)
	LAZYSET(damage_list, DAMAGE_WOUND_NAKED, CANT_WOUND)
	LAZYSET(damage_list, DAMAGE_FORCE, 0)
	LAZYSET(damage_list, DAMAGE_SHOULD_RETURN, TRUE)
	RETURN_DL

/datum/controller/subsystem/damage/proc/handle_overrides(atom/movable/attacker, atom/movable/defender, obj/weapon, list/overrides = list(), list/damage_list = DAMAGE_LIST)
	if(istype(weapon))
		SEND_SIGNAL(weapon, COMSIG_ATOM_GET_ATTACK_OVERRIDES, attacker, defender, damage_list, overrides)
	if(!LAZYLEN(overrides))
		RETURN_DL
	for(var/newval in overrides)
		if(isnull(LAZYACCESS(overrides, newval)))
			continue
		LAZYSET(damage_list, newval, LAZYACCESS(overrides, newval))
	if(!isnull(LAZYACCESS(overrides, DAMAGE_MULTIPLIER)))
		LAZYSET(damage_list, DAMAGE_FORCE,   LAZYACCESS(damage_list, DAMAGE_FORCE)   * LAZYACCESS(overrides, DAMAGE_MULTIPLIER))
		LAZYSET(damage_list, DAMAGE_STAMINA, LAZYACCESS(damage_list, DAMAGE_STAMINA) * LAZYACCESS(overrides, DAMAGE_MULTIPLIER))
	RETURN_DL

/// If an object does stamina damage, make a copy of the damage list with only stamina damage
/datum/controller/subsystem/damage/proc/split_stamina(list/damage_list = DAMAGE_LIST)
	if(LAZYACCESS(damage_list, DAMAGE_STAMINA) <= 0)
		return
	var/list/stam_list = damage_list.Copy()
	var/stamdam = LAZYACCESS(stam_list, DAMAGE_STAMINA)
	LAZYSET(stam_list, DAMAGE_STAMINA, 0)
	LAZYSET(stam_list, DAMAGE_FORCE, stamdam)
	LAZYSET(stam_list, DAMAGE_TYPE, STAMINA)
	return stam_list

/// Handles random damage stuff
/// Also damage roll related trait stuff
/datum/controller/subsystem/damage/proc/handle_damage_roll(
		atom/movable/attacker,
		atom/movable/defender,
		obj/weapon,
		list/damage_list = DAMAGE_LIST,
	)
	if(NOTSET(DAMAGE_FORCE_LOW) || NOTSET(DAMAGE_FORCE_HIGH)) // no random damage
		RETURN_DL
	var/damage =        LAZYACCESS(damage_list, DAMAGE_FORCE       )
	var/damage_low =    LAZYACCESS(damage_list, DAMAGE_FORCE_LOW   )
	var/damage_high =   LAZYACCESS(damage_list, DAMAGE_FORCE_HIGH  )
	var/stamina =       LAZYACCESS(damage_list, DAMAGE_STAMINA     )
	var/stamina_low =   LAZYACCESS(damage_list, DAMAGE_STAMINA_LOW )
	var/stamina_high =  LAZYACCESS(damage_list, DAMAGE_STAMINA_HIGH)
	var/check_unarmed = LAZYACCESS(damage_list, CHECK_TRAIT_UNARMED)
	if(istype(attacker) && check_unarmed)
		if(HAS_TRAIT(attacker, TRAIT_IRONFIST))
			if(damage_low)
				damage_low += IRON_FIST_LOW_ADD
			if(damage_high)
				damage_high += IRON_FIST_MAX_ADD
			if(stamina_low)
				stamina_low += IRON_FIST_LOW_ADD
			if(stamina_high)
				stamina_high += IRON_FIST_MAX_ADD
		if(HAS_TRAIT(attacker, TRAIT_STEELFIST))
			if(damage_low)
				damage_low += STEEL_FIST_LOW_ADD
			if(damage_high)
				damage_high += STEEL_FIST_MAX_ADD
			if(stamina_low)
				stamina_low += STEEL_FIST_LOW_ADD
			if(stamina_high)
				stamina_high += STEEL_FIST_MAX_ADD
		if(HAS_TRAIT(attacker, TRAIT_PERFECT_ATTACKER))
			damage_low = damage_high // =3
			stamina_low = stamina_high // =3
	damage = rand(damage_low, damage_high)
	stamina = rand(damage_low, damage_high)
	LAZYSET(damage_list, DAMAGE_FORCE, damage)
	LAZYSET(damage_list, DAMAGE_STAMINA, stamina)
	RETURN_DL

/datum/controller/subsystem/damage/proc/handle_attacker_traits(atom/movable/attacker, atom/movable/defender, obj/weapon, list/damage_list = DAMAGE_LIST)
	if(!isliving(attacker))
		RETURN_DL
	if(LAZYACCESS(damage_list, CHECK_TRAIT_MELEE))
		damage_list = handle_weapon_traits(attacker, defender, weapon, damage_list)
	if(LAZYACCESS(damage_list, CHECK_TRAIT_RANGED))
		damage_list = handle_ranged_traits(attacker, defender, weapon, damage_list)
	if(LAZYACCESS(damage_list, CHECK_TRAIT_UNARMED))
		damage_list = handle_unarmed_traits(attacker, defender, weapon, damage_list)
	RETURN_DL

/datum/controller/subsystem/damage/proc/handle_weapon_traits(atom/movable/attacker, atom/movable/defender, obj/weapon, list/damage_list = DAMAGE_LIST)
	if(!isliving(attacker))
		RETURN_DL
	if(!LAZYACCESS(damage_list, CHECK_TRAIT_MELEE))
		RETURN_DL
	LAZYREMOVE(damage_list, CHECK_TRAIT_MELEE) // so we dont check it again
	var/force = LAZYACCESS(damage_list, DAMAGE_FORCE) || 0
	var/force_modifier = 0
	if(force >= 5)
		if(HAS_TRAIT(attacker, TRAIT_BIG_LEAGUES)) // fun fact, traits are set on the datum level, so we can finally make SSsqueak do 10 extra damage. No, not the squeaker, the subsystem itself
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
	LAZYSET(damage_list, DAMAGE_FORCE, force)
	damage_list = handle_melee_stamina_penalty(attacker, defender, weapon, damage_list)
	SEND_SIGNAL(attacker, COMSIG_ATOM_ATTACKER_OVERRIDES, force)
	RETURN_DL

/datum/controller/subsystem/damage/proc/handle_ranged_traits(atom/movable/attacker, atom/movable/defender, obj/weapon, list/damage_list = DAMAGE_LIST)
	RETURN_DL

/datum/controller/subsystem/damage/proc/handle_unarmed_traits(mob/living/attacker, atom/movable/defender, obj/weapon, list/damage_list = DAMAGE_LIST)
	if(!isliving(attacker))
		RETURN_DL
	if(!LAZYACCESS(damage_list, CHECK_TRAIT_UNARMED))
		RETURN_DL
	LAZYREMOVE(damage_list, CHECK_TRAIT_UNARMED) // so we dont check it again
	var/damage =      LAZYACCESS(damage_list, DAMAGE_FORCE)        || 0 // Will still be the output damage
	var/damage_low =  LAZYACCESS(damage_list, DAMAGE_FORCE_LOW)    || 0 // these have already been rolled earlier
	var/damage_high = LAZYACCESS(damage_list, DAMAGE_FORCE_HIGH)   || 0 // but they're still useful for checking
	var/damage_mid = ((damage_high + damage_low) * 0.5)
	var/force_modifier = 0
	var/attack_zone = LAZYACCESS(damage_list, DAMAGE_ZONE) || BODY_ZONE_CHEST
	var/mob/living/living_defender = defender
	if(damage >= damage_mid)
		if(HAS_TRAIT(attacker, TRAIT_KI_VAMPIRE) && isliving(living_defender)) //If we're a ki vampire we also sap them of lifeforce, but only if they're not too beat up. Also living organics only.
			var/half_damage = damage * 0.5
			deal_damage(
				attacker,
				defender,
				weapon = "ki drain",
				damage = half_damage,
				damage_type = CLONE,
				target_zone = attack_zone,
				armor_type = ARMOR_MELEE,
				show_messages = FALSE)
			LAZYSET(damage_list, DAMAGE_TYPE, CLONE)
			force_modifier -= half_damage
	if(!CHECK_MOBILITY(attacker, MOBILITY_STAND))
		damage *= 0.65
	damage = max(damage + force_modifier, 0)
	LAZYSET(damage_list, DAMAGE_FORCE, damage)
	damage_list = handle_melee_stamina_penalty(attacker, defender, weapon, damage_list)
	RETURN_DL

/datum/controller/subsystem/damage/proc/handle_melee_stamina_penalty(mob/living/attacker, atom/movable/defender, weapon, list/damage_list = DAMAGE_LIST)
	if(!isliving(attacker))
		RETURN_DL
	if(LAZYACCESS(damage_list, STAM_PENALTY_HANDLED))
		RETURN_DL
	LAZYSET(damage_list, STAM_PENALTY_HANDLED, TRUE)
	var/stamloss = attacker.getStaminaLoss()
	if(!stamloss) //The more tired you are, the less damage you do.
		RETURN_DL
	var/damage = GET_DAMAGE(damage_list)
	var/penalty = clamp(1 - ((stamloss / STAMINA_NEAR_SOFTCRIT) * STAM_CRIT_ITEM_ATTACK_PENALTY), 0, 1)
	if(penalty > LYING_DAMAGE_PENALTY && !CHECK_MOBILITY(attacker, MOBILITY_STAND)) //damage penalty for fighting prone, doesn't stack with the above.
		penalty = LYING_DAMAGE_PENALTY
	damage *= penalty
	LAZYSET(damage_list, DAMAGE_FORCE, damage)
	RETURN_DL

/datum/controller/subsystem/damage/proc/handle_defender_traits(mob/living/defender, list/damage_list = DAMAGE_LIST)
	RETURN_DL

/// Handles carbon stuff
/datum/controller/subsystem/damage/proc/handle_carbon(
		atom/movable/attacker,
		mob/living/carbon/defender,
		obj/weapon,
		list/damage_list = DAMAGE_LIST,
	)
	RETURN_DL

/// Handles human stuff
/datum/controller/subsystem/damage/proc/handle_human(
		atom/movable/attacker,
		mob/living/carbon/human/human_defender,
		obj/item/weapon,
		list/damage_list = DAMAGE_LIST,
	)
	if(!ishuman(human_defender))
		RETURN_DL
	if(human_defender.check_martial_melee_block())
		human_defender.visible_message(span_warning("[human_defender] BLOCKS \the [weapon]!"))
		RETURN_DL
	SEND_SIGNAL(human_defender, COMSIG_ATOM_DEFENDER_OVERRIDES, human_defender, attacker, damage_list)
	RETURN_DL

/// Processes the attacker's skills
/datum/controller/subsystem/damage/proc/handle_attacker_skills(
		mob/living/attacker,
		atom/movable/defender,
		obj/item/weapon,
		list/damage_list = DAMAGE_LIST,
	)

	if(!isitem(weapon) || !isliving(attacker))
		RETURN_DL
	if(!attacker.mind || !weapon.used_skills)
		RETURN_DL
	var/skill_type = SKILL_ATTACK_MOB
	var/skill_train = SKILL_TRAIN_ATTACK_MOB
	if(isobj(defender))
		skill_type = SKILL_ATTACK_OBJ
		skill_train = SKILL_TRAIN_ATTACK_OBJ
	var/damage = LAZYACCESS(damage_list, DAMAGE_FORCE) || 0
	if(damage)
		damage = attacker.mind.item_action_skills_mod(weapon, damage, weapon.skill_difficulty, skill_type)
		LAZYSET(damage_list, DAMAGE_FORCE, damage)
	for(var/skill in weapon.used_skills)
		if(!(skill_train in weapon.used_skills[skill]))
			continue
		var/datum/skill/S = GLOB.skill_datums[skill]
		attacker.mind.auto_gain_experience(skill, weapon.skill_gain*S.item_skill_gain_multi)
	RETURN_DL

/// Handles block/parry
/datum/controller/subsystem/damage/proc/handle_block_parry(
		mob/living/attacker,
		mob/living/defender,
		obj/weapon,
		list/damage_list = DAMAGE_LIST,
		list/overrides,
	)

	if(!isliving(attacker))
		RETURN_DL // proc needs a living attacker
	if(attacker == defender)
		RETURN_DL // no parrying your own seppuku
	var/attk_chain_flags = LAZYACCESS(damage_list, DAMAGE_ATTACKCHAIN_FLAGS) || 0
	var/impacting_zone = LAZYACCESS(damage_list, DAMAGE_ZONE) || BODY_ZONE_CHEST
	var/list/block_return = list()
	var/attack_flags = NONE
	var/attack_text = "the [weapon]"
	var/is_projectile = istype(weapon, /obj/item/projectile)
	if(is_projectile)
		ENABLE_BITFIELD(attack_flags, ATTACK_TYPE_PROJECTILE)
	else if(CHECK_BITFIELD(attk_chain_flags, ATTACK_TYPE_THROWN))
		ENABLE_BITFIELD(attack_flags, ATTACK_TYPE_THROWN)
	else if(isobj(weapon))
		ENABLE_BITFIELD(attack_flags, ATTACK_TYPE_MELEE)
	else
		ENABLE_BITFIELD(attack_flags, ATTACK_TYPE_UNARMED)
	if(CHECK_BITFIELD(attk_chain_flags, ATTACK_IS_PARRY_COUNTERATTACK))
		ENABLE_BITFIELD(attack_flags, ATTACK_TYPE_PARRY_COUNTERATTACK)
	var/base_damage = LAZYACCESS(damage_list, DAMAGE_FORCE) || 0
	var/base_stamina = LAZYACCESS(damage_list, DAMAGE_STAMINA) || 0
	var/armor_pen = LAZYACCESS(damage_list, DAMAGE_ARMOR_PENETRATION) || 0
	var/block_results = attacker.mob_run_block(
		weapon,
		(base_damage > base_stamina ? base_damage : base_stamina),
		attack_text,
		attack_flags,
		armor_pen,
		attacker,
		impacting_zone,
		block_return)
	
	LAZYSET(damage_list, DAMAGE_BLOCK_FLAGS, block_results) // *shrug
	LAZYSET(damage_list, DAMAGE_BLOCK_RETURN, block_return) // *shrug
	if(is_projectile && isliving(defender))
		var/obj/item/projectile/P = weapon
		var/final_percent = block_return[BLOCK_RETURN_PROJECTILE_BLOCK_PERCENTAGE]
		LAZYSET(damage_list, DAMAGE_BLOCKED_PERCENT, final_percent)
		if(CHECK_BITFIELD(block_results, BLOCK_SHOULD_REDIRECT))
			defender.handle_projectile_attack_redirection(P, block_return[BLOCK_RETURN_REDIRECT_METHOD])
			LAZYSET(damage_list, DAMAGE_SHOULD_RETURN, TRUE)
			LAZYSET(damage_list, BULLET_ACT_RETURN_VALUE, BULLET_ACT_FORCE_PIERCE)
			RETURN_DL
		if(CHECK_BITFIELD(block_results, BLOCK_REDIRECTED))
			LAZYSET(damage_list, DAMAGE_SHOULD_RETURN, TRUE)
			LAZYSET(damage_list, BULLET_ACT_RETURN_VALUE, BULLET_ACT_FORCE_PIERCE)
			RETURN_DL
		if(CHECK_BITFIELD(block_results, BLOCK_SUCCESS))
			P.on_hit(src, final_percent, impacting_zone)
			LAZYSET(damage_list, BULLET_ACT_RETURN_VALUE, BULLET_ACT_BLOCK)
			LAZYSET(damage_list, DAMAGE_SHOULD_RETURN, TRUE)
			RETURN_DL
	if(CHECK_BITFIELD(block_results, BLOCK_SUCCESS))
		LAZYSET(damage_list, DAMAGE_SHOULD_RETURN, BLOCK_SUCCESS)
		playsound(defender, 'sound/weapons/parry_blade.ogg', 50, TRUE)
		RETURN_DL

	var/damage_out = block_calculate_resultant_damage(base_damage, block_return)
	var/stamina_out = block_calculate_resultant_damage(base_stamina, block_return)
	LAZYSET(damage_list, DAMAGE_FORCE, damage_out)
	LAZYSET(damage_list, DAMAGE_STAMINA, stamina_out)
	RETURN_DL

/datum/controller/subsystem/damage/proc/check_damage_dismemberment(mob/living/attacker, mob/living/carbon/carbon_defender, obj/weapon, dam_zone = BODY_ZONE_CHEST)
	if(!isliving(attacker) || !iscarbon(carbon_defender))
		return
	if(!attacker.limb_destroyer && !isobj(weapon))
		return
	var/obj/item/bodypart/affecting
	if(attacker.client)
		affecting = carbon_defender.get_bodypart(ran_zone(dam_zone))
	else
		affecting = carbon_defender.get_bodypart(dam_zone)
		// var/list/things_to_ruin = shuffle(carbon_defender.bodyparts.Copy())
		// for(var/B in things_to_ruin)
		// 	var/obj/item/bodypart/bodypart = B
		// 	if(bodypart.body_zone == BODY_ZONE_HEAD || bodypart.body_zone == BODY_ZONE_CHEST)
		// 		continue
		// 	if(!affecting)
		// 		affecting = bodypart
		// 		continue
		// 	if((affecting.get_damage() / affecting.max_damage) < (bodypart.get_damage() / bodypart.max_damage))
		// 		affecting = bodypart
		// 		continue
	if(!affecting)
		return
	if(affecting.get_damage() < affecting.max_damage)
		return
	affecting.dismember()
	return affecting

/// Actually deals damage to an obj. Attacker can be anything, defender can be anything, too.
/// Yes most of this proc is unpacking a list and loading up logging information.
/datum/controller/subsystem/damage/proc/output_damage_obj(
		atom/attacker,
		obj/defender,
		atom/weapon,
		list/damage_list = DAMAGE_LIST,
		process_armor = TRUE,
	)
	if(!isobj(defender))
		stack_trace("output_damage_obj() called without an obj! It is: [defender]!")
		return
	var/base_damage = GET_DAMAGE(damage_list)
	var/final_damage = base_damage
	var/damage_type = GET_DAMAGE_TYPE(damage_list)
	var/armor_check = GET_ARMOR_CHECK(damage_list)
	var/armor_penetration = GET_ARMOR_PENETRATION(damage_list)
	var/dt_modifier = GET_DT_MODIFIER(damage_list)
	var/force_damage = GET_FORCE_IT(damage_list)

	if(damage_type != BRUTE && damage_type != BURN) // got tired of looking at that wierd switch filter
		return 0 // 0 damage for non-brute/burn damage types
	/// All this stuff, above and below, just to be fed into two lines of code. =3
	if(!force_damage)
		final_damage = calculate_damage(
			defender,
			weapon,
			damage_amount = base_damage,
			target_zone = BODY_ZONE_CHEST,
			armor_flag = armor_check,
			armor_penetration = armor_penetration,
			dt_modifier = dt_modifier,
		)
	var/blocked_percent = (1 - ((final_damage / max(base_damage, 0.01)) * 100))
	LAZYSET(damage_list, DAMAGE_BLOCKED_PERCENT, blocked_percent)
	LAZYSET(damage_list, DAMAGE_FORCE, final_damage)

	if(SEND_SIGNAL(defender, COMSIG_OBJ_ATTACK_GENERIC, attacker, damage_type, armor_check, TRUE, armor_penetration) & COMPONENT_STOP_GENERIC_ATTACK)
		RETURN_DL
	var/attk_dir = get_dir(defender, attacker)
	/// this proc has too many overrides to safely extract, and honestly it works well enough
	defender.take_damage(final_damage, damage_type, armor_check, TRUE, attk_dir, 0, attacker)
	RETURN_DL

/// Actually deals damage to a mob. Attacker can be anything, defender must be a mob/living.
/// Yes most of this proc is unpacking a list and loading up logging information.
/datum/controller/subsystem/damage/proc/output_damage_mob(
		mob/living/attacker, 
		mob/living/defender, 
		atom/weapon, 
		list/damage_list = DAMAGE_LIST,
		process_armor = TRUE,
	)
	if(!isliving(defender))
		stack_trace("output_damage_mob() called without a mob! It is: [defender]!")
		return
	var/base_damage =  (LAZYACCESS(damage_list, DAMAGE_FORCE)             || 0              )
	var/final_damage = (base_damage                                                         )
	var/damage_type =  (LAZYACCESS(damage_list, DAMAGE_TYPE)              || BRUTE          )
	var/armor_check =  (LAZYACCESS(damage_list, DAMAGE_ARMOR_CHECK)       || ARMOR_MELEE    )
	var/armor_pen =    (LAZYACCESS(damage_list, DAMAGE_ARMOR_PENETRATION) || 0              )
	var/dt_modifier =  (LAZYACCESS(damage_list, DAMAGE_DT_MODIFIER)       || 0              )
	var/target_part =  (LAZYACCESS(damage_list, DAMAGE_ZONE)              || BODY_ZONE_CHEST)
	var/wound =        (LAZYACCESS(damage_list, DAMAGE_WOUND_BONUS)       || 0              )
	var/bare_wound =   (LAZYACCESS(damage_list, DAMAGE_WOUND_NAKED)       || 0              )
	var/force_damage = (LAZYACCESS(damage_list, DAMAGE_FORCE_IT)          || 0              )
	var/sharp =        (LAZYACCESS(damage_list, DAMAGE_SHARPNESS)         || 0              )
	var/spread =       (LAZYACCESS(damage_list, DAMAGE_SPREAD)            || 0              )
	var/signal =       (LAZYACCESS(damage_list, DAMAGE_SIGNAL)            || 0              )

	var/list/log_list = list()
	LAZYSET(log_list, DAMLOG_DEFENDER_BEFORE_HP,      (defender.health            || 0))
	LAZYSET(log_list, DAMLOG_DEFENDER_MAX_HP,         (defender.maxHealth         || 0))
	LAZYSET(log_list, DAMLOG_DEFENDER_BEFORE_STAMINA, (defender.getStaminaLoss()  || 0))
	LAZYSET(log_list, DAMLOG_ATTACKER_BEFORE_HP,      (attacker?.health           || 0))
	LAZYSET(log_list, DAMLOG_ATTACKER_MAX_HP,         (attacker?.maxHealth        || 0))
	LAZYSET(log_list, DAMLOG_ATTACKER_BEFORE_STAMINA, (attacker?.getStaminaLoss() || 0))
	LAZYSET(log_list, DAMLOG_ATTACKER_IS_LIVING,      isliving(attacker))

	/// All this stuff, above and below, just to be fed into two lines of code. =3
	if(!force_damage)
		final_damage = calculate_damage(
			defender,
			weapon,
			damage_amount = base_damage,
			target_zone = BODY_ZONE_CHEST,
			armor_flag = armor_check,
			armor_penetration = armor_pen,
			dt_modifier = dt_modifier,
		)
	var/blocked_percent = (1 - ((final_damage / max(base_damage, 0.01)) * 100))
	LAZYSET(damage_list, DAMAGE_BLOCKED_PERCENT, blocked_percent)
	LAZYSET(damage_list, DAMAGE_FORCE, final_damage)

	defender.apply_damage(
		damage = final_damage,
		damagetype = damage_type,
		def_zone = target_part,
		blocked = 0,
		forced = force_damage,
		spread_damage = spread,
		wound_bonus = wound,
		bare_wound_bonus = bare_wound,
		sharpness = sharp,
		damage_threshold = 0,
		sendsignal = signal
		)
	var/obj/item/dismambered = check_damage_dismemberment(attacker, defender, weapon, target_part)
	if(istype(dismambered))
		LAZYSET(log_list, DAMLOG_DEFENDER_DID_DISMEMBER, dismambered)

	LAZYSET(log_list, DAMLOG_DEFENDER_AFTER_HP,      (defender.health           || 0))
	LAZYSET(log_list, DAMLOG_DEFENDER_AFTER_STAMINA, (defender.getStaminaLoss() || 0))
	
	damage_list |= log_list
	log_the_attack(attacker, defender, weapon, damage_list, blocked_percent)
	RETURN_DL

/// Makes the attacker do an attack animation.
/datum/controller/subsystem/damage/proc/attack_effect(
	atom/movable/attacker,
	atom/movable/defender,
	atom/weapon,
	list/damage_list = DAMAGE_LIST,
	)
	if(!attacker)
		return
	var/efect = LAZYACCESS(damage_list, DAMAGE_EFFECT)
	attacker.do_attack_animation(defender, efect, weapon)

/// Returns a list of armor values for the given zone and attack flag.
/// format: list(armor, DT)
/datum/controller/subsystem/damage/proc/calculate_armor_values(
	atom/movable/defender,
	atom/weapon,
	target_zone = BODY_ZONE_CHEST,
	armor_flag = ARMOR_MELEE,
	armor_penetration = 0,
	dt_modifier = 0,
)
	if(!defender)
		stack_trace("run_armor_check() called with null defender")
		return
	var/armor = defender.getarmor(target_zone, armor_flag)
	var/dt = defender.getarmor(target_zone, ARMOR_DAMAGE_THRESHOLD)
	armor_penetration = min(armor_penetration, 1)
	if(armor_penetration == 0 && dt_modifier) // no AP? no problem
		return list(armor, dt)
	if(armor_penetration > 0)
		armor *= (1 - armor_penetration) // There used to be a fuckhuge equation here. I didnt understand it, so now its this
	else if (armor_penetration < 0)
		armor *= (1 + armor_penetration) // finally! negative armor!
	dt = dt + dt_modifier
	// armor_message(defender, weapon, armor_flag, armor, armor_penetration, dt, dt_modifier)
	return list(armor, dt)

/// Returns a list of armor values for the given zone and attack flag.
/// format: list(armor, DT)
/datum/controller/subsystem/damage/proc/calculate_damage(
	atom/movable/defender,
	atom/weapon,
	damage_amount,
	target_zone = BODY_ZONE_CHEST,
	armor_flag = ARMOR_MELEE,
	armor_penetration = 0,
	dt_modifier = 0,
)
	if(!defender)
		stack_trace("run_armor_check() called with null defender")
		return
	var/list/armor_values = calculate_armor_values(defender, weapon, target_zone, armor_flag, armor_penetration, dt_modifier) || list(0, 0)
	damage_amount -= LAZYACCESS(armor_values, 2)
	damage_amount *= (1 - LAZYACCESS(armor_values, 1))
	damage_amount = round(damage_amount, DAMAGE_PRECISION)
	return damage_amount

// /datum/controller/subsystem/damage/proc/armor_message(
// 	mob/living/defender,
// 	atom/weapon,
// 	armor_flag = ARMOR_MELEE,
// 	armor = 0,
// 	armor_penetration = 0,
// 	damage_threshold = 0,
// 	damage_threshold_mod = 0,
// )
// 	if(!isliving(defender))
// 		return
// 	if(!defender.client)
// 		return
// 	if(COOLDOWN_LIST_FINISHED(src, armor_messages, defender.ckey))
// 		return
// 	COOLDOWN_LIST_START(src, armor_messages, defender.ckey, 2 SECONDS)
// 	var/ap_
// 	if(armor_penetration)
// 		if(armor_penetration < 0)
// "Your armor has protected your [hit_area]."


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
	var/damage = LAZYACCESS(damage_list, DAMAGE_FORCE) || 0
	if(damage <= 0) // No damage, no problem
		return FALSE
	if(!defender.stat) // Only if the person getting wrecked is not awake (crit, sleeping, etc)
		return FALSE
	to_chat(attacker, span_alert("Your attack honorably misses your sleeping or wounded target!"))
	return TRUE

/// Fuckhuge one-size-fits-all logging proc for attacks
/datum/controller/subsystem/damage/proc/log_the_attack(
		mob/living/attacker,
		atom/movable/defender,
		atom/weapon,
		blocked_percent,
		list/armor_values = list(0, 0),
		obj/item/dismambered,
	)

	if(!attacker || !isliving(defender))
		return
	var/mob/living/live_attacker = attacker && isliving(attacker)
	var/mob/living/live_defender = isliving(defender)
	var/turf/attacker_turf = get_turf(attacker)
	var/area/attacker_area = get_area(attacker)
	var/turf/defender_turf = get_turf(defender)
	var/area/defender_area = get_area(defender)
	var/their_distance =    (isturf(attacker_turf) && isturf(defender_turf) && round(GET_DIST_EUCLIDEAN(attacker_turf, defender_turf), 1)) || "???"
	// Fun fact, when used in-line like this, || and && can help 'short-circuit' expressions!
	// && resolves to the right-most (last) true statement if all statements to the left of that statement are true
	// (X && Y && Z && Q) would resolve to Q if X Y and Z are true, and to FALSE if any are not true.
	// Evaluation of the line ends at the first false statement, so if X is false, Y, Z, and Q are never evaluated.
	// || resolves to the left-most (first) true statement, period.
	// (X || Y || Z || Q) would resolve to the first true variable reading left-to-right, or to FALSE if none are true.
	// Evaluation of the line ends at the first true statement, so if X is true, Y, Z, and Q are never evaluated.
	// here is an example:
	var/attacker_ci =    (live_attacker && SEND_SIGNAL(attacker, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE) && "~ON~") || "/OFF/"
	var/defender_ci =    (defender && SEND_SIGNAL(defender, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE) && "~ON~") || "/OFF/"
	var/damage =         LAZYACCESS(damage_list, DAMAGE_FORCE) || 0
	var/damage_type =    LAZYACCESS(damage_list, DAMAGE_TYPE) || BRUTE
	var/weapon_name =    weapon?.name || weapon || "something"
	var/weapon_type =    weapon?.type || "a custom thing"
	var/target_part =    LAZYACCESS(damage_list, DAMAGE_ZONE) || BODY_ZONE_CHEST

	var/attacker_hp_before =           LAZYACCESS(damage_list, DAMLOG_ATTACKER_BEFORE_HP)      || 0
	var/attacker_max_hp =              LAZYACCESS(damage_list, DAMLOG_ATTACKER_MAX_HP)         || 0
	var/attacker_stamina_before =      LAZYACCESS(damage_list, DAMLOG_ATTACKER_BEFORE_STAMINA) || 0
	var/defender_hp_before =           LAZYACCESS(damage_list, DAMLOG_DEFENDER_BEFORE_HP)      || 0
	var/defender_hp_after =            LAZYACCESS(damage_list, DAMLOG_DEFENDER_AFTER_HP)       || 0
	var/defender_max_hp =              LAZYACCESS(damage_list, DAMLOG_DEFENDER_MAX_HP)         || 0
	var/defender_stamina_before =      LAZYACCESS(damage_list, DAMLOG_DEFENDER_BEFORE_STAMINA) || 0
	var/defender_stamina_after =       LAZYACCESS(damage_list, DAMLOG_DEFENDER_AFTER_STAMINA)  || 0
	var/obj/item/defender_disembered = LAZYACCESS(damage_list, DAMLOG_DEFENDER_DID_DISMEMBER)  || 0

	var/list/list_log = list()
	list_log += "- [attacker] dealt [damage] [damage_type] damage to [defender] in [target_part] with [weapon_name] ([weapon_type])."
	if(damage_type == STAMINA)
		list_log += "[defender] STAM: [defender_stamina_before] -> [defender_stamina_after]"
	else
		list_log += "[defender] HP: [defender_hp_before]/[defender_max_hp] -> [defender_hp_after]/[defender_max_hp]"
	if(istype(defender_disembered))
		list_log += "[defender]'s [defender_disembered] was DISMEMBERED!!! D:"
	if(isliving(live_attacker))
		list_log += "[live_attacker] HP: [attacker_hp_before]/[attacker_max_hp]"
		list_log += "[live_attacker] STAM: [attacker_stamina_before]"
	list_log += "[defender]'s armor blocked [blocked_percent] damage."
	if(their_distance)
		list_log += "[attacker] was [their_distance] tiles away from [defender]. [attacker] was in [attacker_area] and [defender] was in [defender_area]."
	if(live_attacker?.ckey && live_defender?.ckey)
		list_log += "[attacker]'s CI was [attacker_ci], and [defender]'s CI was [defender_ci]."	
	var/output_message = list_log.Join(" | ")
	if(isliving(live_attacker))
		attacker.log_message(output_message, LOG_ATTACK)
	else
		log_attack(output_message)

#undef CHECKRETURN_DL
#undef SETIFNOTSET
#undef RETURN_DL
#undef NOTSET
