#define ART_MASTER var/obj/item/master = parent; if(!isitem(master)) CRASH("Artifact component has no master!!!")

#define ART_EQUIP "art_equip"
#define ART_UNEQUIP "art_unequip"
#define ART_TICK "art_tick"

#define ART_MOB_CHANGED (1 << 0)
#define ART_HOLDER_CHANGED (1 << 1)
#define ART_SLUT_CHANGED (1 << 2)

#define ART_PROCESS_NEEDS_MOB (1 << 0)

/datum/component/artifact
	var/identified_preposition
	var/identified_name = "thing"
	var/list/effects = list()
	var/list/description = list()
	var/list/identified_by = list()
	var/process_flags = ART_PROCESS_NEEDS_MOB
	var/current_slot = null
	var/datum/weakref/current_location
	var/datum/weakref/affecting
	var/my_color = "#FFFFFF"
	var/beatitude = UNCURSED
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/artifact/Initialize(rarity, list/overrides)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_ATOM_ENTERED, .proc/consider_processing)
	// RegisterSignal(parent, COMSIG_ITEM_CLICKED, .proc/on_clicked)
	// RegisterSignal(parent, COMSIG_ITEM_MICROWAVE_ACT, .proc/on_microwave) //c:
	RegisterSignal(parent, COMSIG_ATOM_GET_EXAMINE_NAME, .proc/get_name)
	if(rarity)
		SSartifacts.randomize_artifact(src, rarity)

/// Runs the artifact's main loop. starts when touched by a mob, stops when it doesnt have anything to do
/datum/component/artifact/process()
	mainloop()

/datum/component/artifact/proc/mainloop(force_flags)
	ART_MASTER
	var/update_flags = update_everything() | force_flags
	var/atom/current_holder = GET_WEAKREF(current_location)
	var/mob/living/current_target = GET_WEAKREF(affecting)
	for(var/datum/artifact_effect/effect in effects)
		effect.tick(master, current_target, current_holder, current_slot, update_flags)

/datum/component/artifact/proc/update_everything()
	. = NONE
	. |= update_holder()
	. |= update_mob()
	. |= update_slot()
	. |= consider_updating()

/datum/component/artifact/proc/update_mob()
	. = NONE
	var/mob/living/current = GET_WEAKREF(affecting)
	var/mob/living/newbie = recursive_loc_path_search(GET_WEAKREF(current_location), /mob/living)
	if(current == newbie)
		return
	. |= ART_MOB_CHANGED
	affecting = WEAKREF(newbie) // can be null
	if(isliving((newbie)))
		unregister_mob_signals(current)
		register_mob_signals(newbie)

/datum/component/artifact/proc/register_mob_signals(mob/living/newbie)
	return // todo: this
	//RegisterSignal(newbie, COMSIG_MOB_APPLY_DAMAGE, .proc/on_mob_damage)
	//RegisterSignal(newbie, COMSIG_CARBON_GET_BLEED_MOD, .proc/on_bleed)

/datum/component/artifact/proc/unregister_mob_signals(mob/living/current)
	return // todo: this
	//UnregisterSignal(current, COMSIG_CARBON_GET_BLEED_MOD)

/datum/component/artifact/proc/update_holder()
	. = NONE
	ART_MASTER
	var/atom/prev_loc = GET_WEAKREF(current_location)
	var/atom/new_loc = master.loc
	current_location = WEAKREF(new_loc)
	if(prev_loc != new_loc)
		. |= ART_HOLDER_CHANGED

/datum/component/artifact/proc/update_slot()
	var/obj/item/current_place = GET_WEAKREF(current_location)
	var/prev_slot = current_slot
	if(!isitem(current_place))
		current_slot = null
	else
		current_slot = current_place.current_equipped_slot
	if(prev_slot != current_slot)
		. |= ART_SLUT_CHANGED

/datum/component/artifact/proc/consider_processing()
	if(CHECK_BITFIELD(process_flags, ART_PROCESS_NEEDS_MOB))
		var/mob/living/someone = GET_WEAKREF(affecting)
		if(!isliving(someone))
			stop_processing()
			return
		ART_MASTER
		if(!recursive_loc_search(master, someone))
			stop_processing()
			return
	start_processing()

/datum/component/artifact/proc/stop_processing()
	for(var/datum/artifact_effect/effect in effects)
		effect.cleanup()
	affecting = null
	STOP_PROCESSING(SSartifacts, src)

/datum/component/artifact/proc/start_processing()
	if(CHECK_BITFIELD(datum_flags, DF_ISPROCESSING))
		return
	START_PROCESSING(SSartifacts, src)

/datum/component/artifact/proc/generate_name()
	ART_MASTER
	SSartifacts.generate_name(src)

/datum/component/artifact/proc/get_examine_name(mob/user, list/override)
	if(!ismob(user))
		return
	var/can_see_it = FALSE
	if(IsAdminGhost(user))
		can_see_it = TRUE
	for(var/datum/weakref/ider in identified_by)
		var/mob
	override[EXAMINE_POSITION_ARTICLE] = A.gender == PLURAL? "some" : "a"
	override[EXAMINE_POSITION_BEFORE] = " blood-stained "
	return COMPONENT_EXNAME_CHANGED

/* /datum/component/artifact/proc/on_clicked(datum/source, mob/user)
	var/update_flags = update_everything() | force_flags
	var/atom/current_holder = GET_WEAKREF(current_location)
	var/mob/living/current_target = GET_WEAKREF(affecting)
	for(var/datum/artifact_effect/effect in effects)
		effect.clicked(master, current_target, current_holder, current_slot, update_flags)

/datum/component/artifact/proc/on_microwave(datum/source, mob/user)
	var/update_flags = update_everything() | force_flags
	var/atom/current_holder = GET_WEAKREF(current_location)
	var/mob/living/current_target = GET_WEAKREF(affecting)
	for(var/datum/artifact_effect/effect in effects)
		effect.microwaved(master, current_target, current_holder, current_slot, update_flags)

/datum/component/artifact/proc/on_mob_damage(datum/source, mob/user, datum/damage)
	var/update_flags = update_everything() | force_flags
	var/atom/current_holder = GET_WEAKREF(current_location)
	var/mob/living/current_target = GET_WEAKREF(affecting)
	for(var/datum/artifact_effect/effect in effects)
		effect.mob_damage(master, current_target, current_holder, current_slot, update_flags) */

#define EFFECT_MASTER var/obj/item/master = GET_WEAKREF(my_parent); if(!isitem(master)) CRASH("Artifact effect has no master!!!")
////////////////////////////
/// The actual effectors ///
/datum/artifact_effect
	var/is_buff = FALSE
	var/kind = ARTMOD_NONE
	var/name = "Some kind of effect"
	var/ass_color = "#FFFFFF"
	var/list/desired_slots = list(ITEM_SLOT_OCLOTHING)
	var/current_slot
	var/datum/weakref/current_location
	var/prefered_container = /obj/item/clothing/suit
	var/target_path = /mob/living
	/// Mob we've applied our equip/dequip effects to
	var/datum/weakref/applied_effects_to
	var/datum/weakref/my_parent
	var/implanted = FALSE
	var/last_applied = 0
	var/allow_dupes = FALSE

/datum/artifact_effect/New(obj/item/parent, list/parameters = list())
	. = ..()
	if(!isitem(parent))
		qdel(src)
		CRASH("Artifact effect has no parent!!!")
	my_parent = WEAKREF(parent)
	apply_parameters(parameters)

/datum/artifact_effect/Del()
	if(applied_effects_to)
		remove_effects()
		applied_effects_to = null
	. = ..()

/datum/artifact_effect/proc/apply_parameters(list/parameters = list())
	for(var/parm in parameters)
		switch(parm)
			if(ARTVAR_NAME)
				name = LAZYACCESS(parameters, parm)
			if(ARTVAR_DESIRED_SLOTS)
				desired_slots = LAZYACCESS(parameters, parm)
			if(ARTVAR_PREFERED_CONTAINER)
				prefered_container = LAZYACCESS(parameters, parm)
			if(ARTVAR_TARGET_PATH)
				target_path = LAZYACCESS(parameters, parm)
			if(ARTVAR_IS_BUFF)
				is_buff = LAZYACCESS(parameters, parm)
			if(ARTVAR_KIND)
				kind = LAZYACCESS(parameters, parm)
			if(ARTVAR_FLUFF)
				fluff = LAZYACCESS(parameters, parm)
			if(ARTVAR_ALLOW_DUPES)
				allow_dupes = LAZYACCESS(parameters, parm)
	update_name()
	update_color()

/datum/artifact_effect/proc/update_name()
	return

/datum/artifact_effect/proc/update_color()
	return

/datum/artifact_effect/proc/tick(obj/item/master, mob/living/target, obj/item/holder, parent_slot, update_flags)
	/// ensures we only apply and remove effects once
	var/application_flags = NONE
	/// these handle the equip/dequip effects
	if(CHECK_BITFIELD(update_flags, ART_MOB_CHANGED))
		application_flags |= update_affecting(master, target, holder, parent_slot, application_flags)
	if(CHECK_BITFIELD(update_flags, ART_HOLDER_CHANGED))
		application_flags |= update_location(master, target, holder, parent_slot, application_flags)
	if(CHECK_BITFIELD(update_flags, ART_SLUT_CHANGED))
		application_flags |= update_slut(master, target, holder, parent_slot, application_flags)
	return on_tick(master, target, holder)

/// compares where we were to where we are now, and updates our current location
/datum/artifact_effect/proc/update_mob(obj/item/master, mob/living/target, obj/item/holder, parent_slot, application_flags)
	var/mob/living/prev_mob = GET_WEAKREF(applied_effects_to)
	var/mob/living/new_mob = target
	if(prev_mob == new_mob)
		return
	/// We've affecting a new person!
	if(istype(new_mob, target_path) && !CHECK_BITFIELD(application_flags, ART_STATUS_EFFECT_APPLIED))
		. |= apply_status_effect(master, new_mob, holder) // will update applied_effects_to
	/// We're no longer affecting the other person!
	if(istype(prev_mob, target_path) && !CHECK_BITFIELD(application_flags, ART_STATUS_EFFECT_REMOVED))
		. |= remove_status_effect(master, new_mob, holder)

/// compares where we were to where we are now, and updates our current location
/datum/artifact_effect/proc/update_location(obj/item/master, mob/living/target, obj/item/holder, parent_slot, application_flags)
	var/atom/prev_loc = GET_WEAKREF(current_location)
	var/atom/new_loc = holder
	if(prev_loc == new_loc) // Alrady there!
		return
	if(istype(prev_loc, prefered_container))
		remove_container_effect(master, prev_loc, holder)
	if(istype(new_loc, prefered_container))
		apply_container_effect(master, new_loc, holder)
	current_location = WEAKREF(new_loc)

/// compares where we were to where we are now, and updates our current slot
/datum/artifact_effect/proc/update_slut(obj/item/master, mob/living/target, obj/item/holder, parent_slot, application_flags)
	if(parent_slot == current_slot)
		return // already where we should be
	var/am_in_desired_slot = (current_slot in desired_slots)
	var/going_to_desired_slot = (parent_slot in desired_slots)
	if(am_in_desired_slot && !going_to_desired_slot && !CHECK_BITFIELD(application_flags, ART_STATUS_EFFECT_REMOVED))
		. =| remove_status_effect(master, target, holder)
	if(!am_in_desired_slot && going_to_desired_slot && !CHECK_BITFIELD(application_flags, ART_STATUS_EFFECT_APPLIED))
		. =| apply_status_effect(master, target, holder)
	current_slot = parent_slot

/// Applies our statud effect, if any
/datum/artifact_effect/proc/apply_status_effect(obj/item/master, mob/living/target, obj/item/holder)
	var/mob/living/current = GET_WEAKREF(applied_effects_to)
	if(current == target) // already affecting them!
		return
	return on_equipped(master, target, holder)

/// Applies our statud effect, if any
/datum/artifact_effect/proc/remove_status_effect(obj/item/master, mob/living/target, obj/item/holder)
	var/mob/living/current = GET_WEAKREF(applied_effects_to)
	if(current != target) // We werent affecting them!
		return
	return on_unequipped(master, target, holder)

/// Applies our statud effect, if any
/datum/artifact_effect/proc/apply_container_effect(obj/item/master, mob/living/target, obj/item/holder)
	var/mob/living/current = GET_WEAKREF(current_location)
	if(current == target) // already affecting them!
		return
	return on_equipped(master, target, holder)

/// Applies our statud effect, if any
/datum/artifact_effect/proc/remove_container_effect(obj/item/master, mob/living/target, obj/item/holder)
	var/atom/current = GET_WEAKREF(current_location)
	if(current != holder) // We werent affecting them!
		return
	return on_removed(master, target, holder)

/// Searches thrugh the parents loc for something worn by a mob
/// Returns the slot it was found in, null if not found
/datum/artifact_effect/proc/get_slot(obj/item/recur)
	if(!isitem(recur))
		return
	if(recur.current_equipped_slot)
		return parent.current_equipped_slot
	if(isitem(recur.loc))
		return get_slot(recur.loc)

/////////////////////////////////////////////////
/// The actual effect of the thing
/datum/artifact_effect/proc/on_inserted(mob/living/target, atom/location)
	return TRUE

/////////////////////////////////////////////////
/// Prescreen to see if the effect should effect
/datum/artifact_effect/proc/on_removed(mob/living/target, atom/location)
	return TRUE

/////////////////////////////////////////////////
/// The actual effect of the thing
/datum/artifact_effect/proc/on_equipped(mob/living/target, atom/location)
	return TRUE

/////////////////////////////////////////////////
/// The actual effect of the thing
/datum/artifact_effect/proc/on_unequipped(mob/living/target, atom/location)
	return TRUE

/////////////////////////////////////////////////
/// The actual effect of the thing
/datum/artifact_effect/proc/on_tick(mob/living/target, atom/location)
	return TRUE

/// Generic mob-targetted pre-screener
/datum/artifact_effect/proc/check_armor(mob/living/target, armorflag = "melee", zone)
	if(!isliving(target)) // currently all effects affect the living
		return 0
	if(implanted)
		return damage // implants dont care about armor
	return target.getarmor(zone, armorflag)

/// Generic mob-targetted pre-screener
/datum/artifact_effect/proc/check_dt(mob/living/target, zone)
	if(!isliving(target)) // currently all effects affect the living
		return 0
	if(implanted)
		return damage // implants dont care about armor
	return target.getarmor(zone, "damage_threshold")

/datum/artifact/proc/send_message(mob/living/target, damtype)
	return

/datum/artifact/proc/get_prefix()
	return "Ambiguous"

/datum/artifact/proc/get_suffix()
	return "uninitialization"

//// MAX HP MODIFIER ////
/datum/artifact_effect/max_hp_modifier
	kind = ARTMOD_MAX_HP
	var/hp_change = 0
	var/equip_message = "You feel stronger."
	var/unequip_message = "You feel weaker."

/datum/artifact_effect/max_hp_modifier/apply_parameters(list/parameters = list())
	for(var/parm in parameters)
		switch(parm)
			if(ARTVAR_HP_CHANGE)
				hp_change = LAZYACCESS(parameters, parm)
			if(ARTVAR_EQUIP_MESSAGE)
				equip_message = LAZYACCESS(parameters, parm)
			if(ARTVAR_UNEQUIP_MESSAGE)
				unequip_message = LAZYACCESS(parameters, parm)
	is_buff = (hp_change > 0)
	. = ..()

/datum/artifact_effect/max_hp_modifier/on_equipped(mob/living/target)
	target.maxHealth += hp_change
	send_message(target, TRUE)
	return TRUE

/datum/artifact_effect/max_hp_modifier/on_unequipped(mob/living/target)
	target.maxHealth -= hp_change
	target.health -= hp_change
	send_message(target, FALSE)
	return TRUE

/datum/artifact/max_hp_modifier/send_message(mob/living/target, equipped)
	if(equipped)
		to_chat(target, span_notice("[equip_message]"))
	else
		to_chat(target, span_danger("[unequip_message]"))

/datum/artifact/max_hp_modifier/get_prefix()
	if(is_buff)
		var/maxmu = SSartifacts.health_rare_maximum
		var/lenny = LAZYLEN(SSartifacts.prefixes_health_good)
		var/index2use = clamp(round((hp_change / maxmu) * lenny), 1, lenny)
		return LAZYACCESS(SSartifacts.prefixes_health_good, index2use)
	else
		var/maxmu = abs(SSartifacts.health_rare_minimum)
		var/lenny = LAZYLEN(SSartifacts.prefixes_health_bad)
		var/index2use = clamp(round((abs(hp_change) / maxmu) * lenny), 1, lenny)
		return LAZYACCESS(SSartifacts.prefixes_health_bad, index2use)

/datum/artifact/max_hp_modifier/get_suffix()
	if(is_buff)
		var/maxmu = SSartifacts.health_rare_maximum
		var/lenny = LAZYLEN(SSartifacts.suffixes_health_good)
		var/index2use = clamp(round((hp_change / maxmu) * lenny), 1, lenny)
		return LAZYACCESS(SSartifacts.suffixes_health_good, index2use)
	else
		var/maxmu = abs(SSartifacts.health_rare_minimum)
		var/lenny = LAZYLEN(SSartifacts.suffixes_health_bad)
		var/index2use = clamp(round((abs(hp_change) / maxmu) * lenny), 1, lenny)
		return LAZYACCESS(SSartifacts.suffixes_health_bad, index2use)

////////////////////////
//// SPEED MODIFIER ////
/datum/artifact_effect/speed
	kind = ARTMOD_MAX_HP
	var/multiplicative_slowdown = 0 // more is slower
	var/my_unique_id = "bingus"
	var/equip_message = "You feel faster."
	var/unequip_message = "You feel slower."

/datum/artifact_effect/speed/New()
	. = ..()
	my_unique_id = "speed_[world.time]_[rand(1000000, 9999999)]"

/datum/artifact_effect/speed/apply_parameters(list/parameters = list())
	for(var/parm in parameters)
		switch(parm)
			if(ARTVAR_HP_CHANGE)
				hp_change = LAZYACCESS(parameters, parm)
			if(ARTVAR_EQUIP_MESSAGE)
				equip_message = LAZYACCESS(parameters, parm)
			if(ARTVAR_UNEQUIP_MESSAGE)
				unequip_message = LAZYACCESS(parameters, parm)
	is_buff = (multiplicative_slowdown < 0)
	. = ..()

/datum/artifact_effect/speed/on_equipped(mob/living/target)
	target.add_movespeed_modifier(/datum/movespeed_modifier/artifact_slowness, update = TRUE, my_unique_id)
	send_message(target, TRUE)
	return TRUE

/datum/artifact_effect/speed/on_unequipped(mob/living/target)
	target.remove_movespeed_modifier(my_unique_id, update = TRUE)
	send_message(target, FALSE)
	return TRUE

/datum/artifact/speed/send_message(mob/living/target, equipped)
	if(equipped)
		to_chat(target, span_notice("[equip_message]"))
	else
		to_chat(target, span_danger("[unequip_message]"))

/datum/artifact/speed/get_prefix()
	if(!is_buff)
		var/maxmu = SSartifacts.speed_rare_maximum
		var/lenny = LAZYLEN(SSartifacts.prefixes_health_good)
		var/index2use = clamp(round((hp_change / maxmu) * lenny), 1, lenny)
		return LAZYACCESS(SSartifacts.prefixes_health_good, index2use)
	else
		var/maxmu = abs(SSartifacts.speed_rare_minimum)
		var/lenny = LAZYLEN(SSartifacts.prefixes_speed_bad)
		var/index2use = clamp(round((abs(hp_change) / maxmu) * lenny), 1, lenny)
		return LAZYACCESS(SSartifacts.prefixes_speed_bad, index2use)

/datum/artifact/speed/get_suffix()
	if(is_buff)
		var/maxmu = SSartifacts.speed_rare_maximum
		var/lenny = LAZYLEN(SSartifacts.suffixes_health_good)
		var/index2use = clamp(round((hp_change / maxmu) * lenny), 1, lenny)
		return LAZYACCESS(SSartifacts.suffixes_speed_good, index2use)
	else
		var/maxmu = abs(SSartifacts.speed_rare_minimum)
		var/lenny = LAZYLEN(SSartifacts.suffixes_health_bad)
		var/index2use = clamp(round((abs(hp_change) / maxmu) * lenny), 1, lenny)
		return LAZYACCESS(SSartifacts.suffixes_speed_bad, index2use)

/datum/movespeed_modifier/artifact_slowness
	flags = IGNORE_NOSLOW
	variable = TRUE

/// PASSIVE DAMAGE DEALER ///
/// Dont use for healing, it just wont work ///
/// All values are in damage per second     ///
/datum/artifact_effect/passive_damage
	kind = ARTMOD_PASSIVE_DOT
	/// Stop doing damage if their health is below this
	var/min_health = 5
	/// Damage to do to brute
	var/d_brute = 0
	/// Damage to do to burn
	var/d_burn = 0
	/// Damage to do to toxin
	var/d_toxin = 0
	/// Damage to do to oxy
	var/d_oxy = 0
	/// Damage to do to clone
	var/d_clone = 0
	/// Damage to do to brain
	var/d_brain = 0
	/// if we're in a slot that isnt prefered, we do more damage uwu
	var/undesirable_mult = 2
	var/is_dps = TRUE
	var/too_injured = "%SRC is unable to harm you any further."
	var/injured = "%SRC is harming you."
	var/armor_flag = "melee"
	allow_dupes = TRUE

/datum/artifact_effect/passive_damage/apply_parameters(list/parameters = list())
	for(var/parm in parameters)
		switch(parm)
			if(ARTVAR_MIN_HEALTH)
				min_health = LAZYACCESS(parameters, parm)
			if(ARTVAR_BRUTE)
				d_brute = LAZYACCESS(parameters, parm)
			if(ARTVAR_BURN)
				d_burn = LAZYACCESS(parameters, parm)
			if(ARTVAR_TOXIN)
				d_toxin = LAZYACCESS(parameters, parm)
			if(ARTVAR_OXY)
				d_oxy = LAZYACCESS(parameters, parm)
			if(ARTVAR_CLONE)
				d_clone = LAZYACCESS(parameters, parm)
			if(ARTVAR_BRAIN)
				d_brain = LAZYACCESS(parameters, parm)
			if(ARTVAR_IS_DPS)
				is_dps = LAZYACCESS(parameters, parm)
			if(ARTVAR_TOO_INJURED)
				too_injured = LAZYACCESS(parameters, parm)
			if(ARTVAR_INJURED)
				injured = LAZYACCESS(parameters, parm)
			if(ARTVAR_ARMOR_FLAG)
				armor_flag = LAZYACCESS(parameters, parm)
	. = ..()

/datum/artifact_effect/passive_damage/on_tick(mob/living/target, obj/item/holder)
	if(!isliving(target))
		return
	if(target.health < min_health)
		return
	var/mult = is_dps ? ((world.time - last_applied) * 0.1) : 1
	var/zone = pick(GLOB.main_body_parts)
	var/dr = 1
	var/dt = 0
	EFFECT_MASTER
	if(!implanted)
		dr = check_armor(target, armor_flag, zone)
		dt = check_dt(target, zone)
	if(!((get_slot(master)) in desired_slots))
		mult *= undesirable_mult
	target.apply_damages(
		brute = ((d_brute * mult) - dt) * dr,
		burn  = ((d_burn  * mult) - dt) * dr,
		toxin = ((d_toxin * mult) - dt) * dr,
		oxy   = ((d_oxy   * mult) - dt) * dr,
		clone = ((d_clone * mult) - dt) * dr,
		brain = ((d_brain * mult) - dt) * dr,
		def_zone = zone,
	)
	last_applied = world.time
	send_message(target, zone)
	return TRUE

/datum/artifact/passive_damage/send_message(mob/living/target, damtype)
	if(!prob(1))
		return
	if(target.health < min_health)
		to_chat(target, span_danger("[too_injured]"))
	else
		to_chat(target, span_danger("[injured]"))

/// PASSIVE DAMAGE DEALER - RANDOM TYPE EDITION ///
/datum/artifact_effect/passive_damage/random
	var/brute_flavor = "You feel a dull ache."
	var/burn_flavor = "You feel a burning sensation."
	var/toxin_flavor = "You feel sick."
	var/oxy_flavor = "You feel out of breath."
	var/clone_flavor = "You feel a worrying growth shift about."
	var/brain_flavor = "Your head aches."

/datum/artifact_effect/passive_damage/random/apply_parameters(list/parameters = list())
	for(var/parm in parameters)
		switch(parm)
			if(ARTVAR_BRUTE_FLAVOR)
				brute_flavor = LAZYACCESS(parameters, parm)
			if(ARTVAR_BURN_FLAVOR)
				burn_flavor = LAZYACCESS(parameters, parm)
			if(ARTVAR_TOXIN_FLAVOR)
				toxin_flavor = LAZYACCESS(parameters, parm)
			if(ARTVAR_OXY_FLAVOR)
				oxy_flavor = LAZYACCESS(parameters, parm)
			if(ARTVAR_CLONE_FLAVOR)
				clone_flavor = LAZYACCESS(parameters, parm)
			if(ARTVAR_BRAIN_FLAVOR)
				brain_flavor = LAZYACCESS(parameters, parm)
	. = ..()

/datum/artifact_effect/passive_damage/random/on_tick(mob/living/target, obj/item/holder)
	if(!isliving(target))
		return
	if(target.health < min_health)
		return
	var/mult = is_dps ? ((world.time - last_applied) * 0.1) : 1
	var/list/dmgs = list()
	if(d_brute)
		dmgs += list(BRUTE = d_brute * mult)
	if(d_burn)
		dmgs += list(BURN = d_burn * mult)
	if(d_toxin)
		dmgs += list(TOXIN = d_toxin * mult)
	if(d_oxy)
		dmgs += list(OXY = d_oxy * mult)
	if(d_clone)
		dmgs += list(CLONE = d_clone * mult)
	if(d_brain)
		dmgs += list(BRAIN = d_brain * mult)
	var/dmg_out = pick(dmgs)
	if(implanted || !((get_slot(master)) in desired_slots))
		dmg_out *= undesirable_mult
	dmg_out -= check_armor(target, armor_flag)
	dmg_out *= check_dt(target)
	dmg_out = check_armor(target, dmg_out)
	target.apply_damage(LAZYACCESS(dmg_out, 2), LAZYACCESS(dmg_out, 1))
	last_applied = world.time
	send_message(target, LAZYACCESS(dmg_out, 2))
	return TRUE

/datum/artifact_effect/passive_damage/random/send_message(mob/living/target, damtype, zone)
	if(!prob(1))
		return
	var/msg_out = "You hurt."
	switch(damtype)
		if(BRUTE)
			msg_out = brute_flavor
		if(BURN)
			msg_out = burn_flavor
		if(TOXIN)
			msg_out = toxin_flavor
		if(OXY)
			msg_out = oxy_flavor
		if(CLONE)
			msg_out = clone_flavor
		if(BRAIN)
			msg_out = brain_flavor
	to_chat(target, span_danger(msg_out))

/////////////////////////////
/// PASSIVE DAMAGE HEALER ///
/// jk it can heal~       ///
/datum/artifact_effect/passive_damage/healer
	kind = ARTMOD_PASSIVE_HEAL
	/// Stop doing damage if their health is below this
	var/min_health = 5
	/// Damage to do to brute
	var/d_brute = 0
	/// Damage to do to burn
	var/d_burn = 0
	/// Damage to do to toxin
	var/d_toxin = 0
	/// Damage to do to oxy
	var/d_oxy = 0
	/// Damage to do to clone
	var/d_clone = 0
	/// Damage to do to brain
	var/d_brain = 0
	/// if we're in a slot that isnt prefered, we do more damage uwu
	var/undesirable_mult = 2
	var/is_dps = TRUE
	var/too_injured = "%SRC is unable to harm you any further."
	var/injured = "%SRC is harming you."
	var/armor_flag = "melee"
	allow_dupes = TRUE
/datum/artifact_effect/passive_damage/random/apply_parameters(list/parameters = list())
	for(var/parm in parameters)
		switch(parm)
			if(ARTVAR_BRUTE_FLAVOR)
				brute_flavor = LAZYACCESS(parameters, parm)
			if(ARTVAR_BURN_FLAVOR)
				burn_flavor = LAZYACCESS(parameters, parm)
			if(ARTVAR_TOXIN_FLAVOR)
				toxin_flavor = LAZYACCESS(parameters, parm)
			if(ARTVAR_OXY_FLAVOR)
				oxy_flavor = LAZYACCESS(parameters, parm)
			if(ARTVAR_CLONE_FLAVOR)
				clone_flavor = LAZYACCESS(parameters, parm)
			if(ARTVAR_BRAIN_FLAVOR)
				brain_flavor = LAZYACCESS(parameters, parm)
	. = ..()

/datum/artifact_effect/passive_damage/random/on_tick(mob/living/target, obj/item/holder)
	if(!isliving(target))
		return
	if(target.health < min_health)
		return
	var/mult = is_dps ? ((world.time - last_applied) * 0.1) : 1
	var/list/dmgs = list()
	if(d_brute)
		dmgs += list(BRUTE = d_brute * mult)
	if(d_burn)
		dmgs += list(BURN = d_burn * mult)
	if(d_toxin)
		dmgs += list(TOXIN = d_toxin * mult)
	if(d_oxy)
		dmgs += list(OXY = d_oxy * mult)
	if(d_clone)
		dmgs += list(CLONE = d_clone * mult)
	if(d_brain)
		dmgs += list(BRAIN = d_brain * mult)
	var/dmg_out = pick(dmgs)
	if(implanted || !((get_slot(master)) in desired_slots))
		dmg_out *= undesirable_mult
	dmg_out -= check_armor(target, armor_flag)
	dmg_out *= check_dt(target)
	dmg_out = check_armor(target, dmg_out)
	target.apply_damage(LAZYACCESS(dmg_out, 2), LAZYACCESS(dmg_out, 1))
	last_applied = world.time
	send_message(target, LAZYACCESS(dmg_out, 2))
	return TRUE

/datum/artifact_effect/passive_damage/random/send_message(mob/living/target, damtype, zone)
	if(!prob(1))
		return
	var/msg_out = "You hurt."
	switch(damtype)
		if(BRUTE)
			msg_out = brute_flavor
		if(BURN)
			msg_out = burn_flavor
		if(TOXIN)
			msg_out = toxin_flavor
		if(OXY)
			msg_out = oxy_flavor
		if(CLONE)
			msg_out = clone_flavor
		if(BRAIN)
			msg_out = brain_flavor
	to_chat(target, span_danger(msg_out))

///////////////////////////
/// STAMINA ADJUSTER    ///
/// Can use for healing ///
/datum/artifact_effect/stamina
	kind = ARTMOD_STAMINA
	/// How much to adjust stamina by
	var/stamina_adjustment = 0
	/// Cooldown if it stamcrits the user
	var/stamcrit_cooldown = 20 SECONDS
	COOLDOWN_DECLARE(stamcritted)

/datum/artifact_effect/stamina/apply_parameters(list/parameters = list())
	for(var/parm in parameters)
		switch(parm)
			if(ARTVAR_STAMINA_ADJUSTMENT)
				stamina_adjustment = LAZYACCESS(parameters, parm)
			if(ARTVAR_STAMCRIT_COOLDOWN)
				stamcrit_cooldown = LAZYACCESS(parameters, parm)
	is_buff = (stamina_adjustment > 0)
	. = ..()

/datum/artifact_effect/stamina/on_tick(mob/living/target, obj/item/holder)
	if(!isliving(target))
		return
	if(!is_buff)
		if(stamcritted && !COOLDOWN_FINISHED(src, stamcritted))
			return
		if(IS_STAMCRIT(target))
			COOLDOWN_START(src, stamcritted, stamcrit_cooldown)
			return
	target.adjustStaminaLossBuffered(stamina_adjustment)
	return TRUE

///////////////////////////
/// RADIATION           ///
/// Can use for healing ///
/datum/artifact_effect/radiation
	kind = ARTMOD_RADIATION
	var/target_radiation = 0
	var/radiation_adjustment = 0

/datum/artifact_effect/radiation/apply_parameters(list/parameters = list())
	for(var/parm in parameters)
		switch(parm)
			if(ARTVAR_RADIATION_ADJUSTMENT)
				radiation_adjustment = LAZYACCESS(parameters, parm)
			if(ARTVAR_TARGET_RADIATION)
				target_radiation = LAZYACCESS(parameters, parm)
	is_buff = (target_radiation < RAD_MOB_SAFE)
	. = ..()

/datum/artifact_effect/radiation/on_tick(mob/living/target, obj/item/holder)
	if(!isliving(target))
		return
	var/mult = (world.time - last_applied) * 0.1
	var/radz = target.radiation
	if(ISABOUTEQUAL(radz, target_radiation, radiation_adjustment * 5))
		return TRUE // already where we want it
	if(radz > target_radiation)
		target.radiation =+ (radiation_adjustment * mult)
	else
		target.rad_act(radiation_adjustment * mult, implanted)
	return TRUE

///////////////////////////////////
/// BLOOD ADJUSTER              ///
/// Trends blood toward a value ///
/datum/artifact_effect/blood
	kind = ARTMOD_BLOOD
	/// Target blood amount, if any
	var/target_blood = null
	/// How much to adjust blood by per second
	var/blood_adjustment = 0

/datum/artifact_effect/blood/apply_parameters(list/parameters = list())
	for(var/parm in parameters)
		switch(parm)
			if(ARTVAR_BLOOD_ADJUSTMENT)
				blood_adjustment = LAZYACCESS(parameters, parm)
			if(ARTVAR_TARGET_BLOOD)
				target_blood = LAZYACCESS(parameters, parm)
	is_buff = (target_blood > BLOOD_VOLUME_SYMPTOMS_WARN)
	. = ..()

/datum/artifact_effect/blood/on_tick(mob/living/target, obj/item/holder)
	if(!isliving(target))
		return
	var/mult = (world.time - last_applied) * 0.1
	var/bloodvol = target.get_blood(TRUE)
	if(ISABOUTEQUAL(bloodvol, target_blood, 10))
		return TRUE // already where we want it
	var/up_or_down = bloodvol < target_blood ? 1 : -1
	target.blood_volume += (blood_adjustment * mult * up_or_down)
	return TRUE

///////////////////////////////////
/// BLEEDING ADJUSTER           ///
/// Trends blood loss toward a value ///
// /datum/artifact_effect/bleed
// 	kind = ARTMOD_BLOOD
// 	/// Target blood amount, if any
// 	var/target_blood = null
// 	/// How much to adjust blood by per second
// 	var/blood_adjustment = 0

// /datum/artifact_effect/bleed/apply_parameters(list/parameters = list())
// 	for(var/parm in parameters)
// 		switch(parm)
// 			if(ARTVAR_BLOOD_ADJUSTMENT)
// 				blood_adjustment = LAZYACCESS(parameters, parm)
// 			if(ARTVAR_TARGET_BLOOD)
// 				target_blood = LAZYACCESS(parameters, parm)
// 	is_buff = (target_blood > BLOOD_VOLUME_SYMPTOMS_WARN)
// 	. = ..()

// /datum/artifact_effect/bleed/on_tick(mob/living/target, obj/item/holder)
// 	if(!isliving(target))
// 		return
// 	var/mult = (world.time - last_applied) * 0.1
// 	var/bloodvol = target.get_blood(TRUE)
// 	if(ISABOUTEQUAL(bloodvol, target_blood, 10))
// 		return TRUE // already where we want it
// 	var/up_or_down = bloodvol < target_blood ? 1 : -1
// 	target.blood_volume += (blood_adjustment * mult * up_or_down)
// 	return TRUE





