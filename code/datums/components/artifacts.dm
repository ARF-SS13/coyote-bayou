#define ART_MASTER var/obj/item/master = parent; if(!isitem(master)) CRASH("Artifact component has no master!!!")

#define ART_EQUIP "art_equip"
#define ART_UNEQUIP "art_unequip"
#define ART_TICK "art_tick"

/datum/component/artifact
	var/list/effects = list()
	var/list/description = list()
	var/list/identified_by = list()
	/// Quick lookup what our parent is contained in
	var/datum/weakref/container
	var/beatitude = UNCURSED
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/artifact/Initialize(rads_per_second, list/ref_n_type)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, .proc/on_equipped)
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, .proc/on_drop)
	RegisterSignal(parent, COMSIG_ITEM_PICKUP, .proc/on_pickup)
	RegisterSignal(parent, COMSIG_ATOM_ENTERED, .proc/on_entered)
	RegisterSignal(parent, COMSIG_ATOM_EXITED, .proc/on_exited)
	RegisterSignal(parent, COMSIG_ITEM_CLICKED, .proc/on_clicked)
	RegisterSignal(parent, COMSIG_ITEM_MICROWAVE_ACT, .proc/on_microwave) //c:

/datum/component/artifact/proc/update_holder(new_holder)
	var/obj/item/holder = new_holder
	if(!isitem(holder))
		ART_MASTER
		if(isitem(master.loc))
			holder = master.loc
		else
			holder = null
	container = WEAKREF(holder)

/datum/component/artifact/proc/on_entered(atom/entered, obj/item/arrived, atom/old_loc)
	update_holder(entered)
	for(var/artifact_effect/effect in effects)
		effect.entered_handler(entered, old_loc) // arrived will be our paarent, lol

/datum/component/artifact/proc/on_equipped(obj/item/new_holder, mob/living/equipper, slot, previous_slot)
	update_holder(new_holder)
	for(var/artifact_effect/effect in effects)
		effect.equip_handler(equipper, slot, previous_slot)

/datum/component/artifact/process()
	ART_MASTER
	update_holder(master.loc)
	var/mob/living/sucker = recursive_loc_path_search(master, /mob/living)
	for(var/artifact_effect/effect in effects)
		effect.on_tick(sucker)

////////////////////////////
/// The actual effectors ///
/datum/artifact_effect
	var/is_buff
	var/kind
	var/name
	var/amount
	var/tick_length
	/// Bitfields of where we, if we go there, we're considered equipped
	var/datum/weakref/my_parent
	var/datum/weakref/current_location
	/// Where we are stored, if we are stored. is the birb in the oven? its a bitfield hot in here
	var/desired_slots = ITEM_SLOT_OCLOTHING
	var/current_slot = NONE
	COOLDOWN_DECLARE(cooldown)
	var/chance = 100

/datum/artifact_effect/New(
		obj/item/parent, 
		amount,
		name,
		is_buff,
		tick_length,
		chance)
	. = ..()
	if(!isnull(amount))
		src.amount = amount
	if(!isnull(name))
		src.name = name
	if(!isnull(is_buff))
		src.is_buff = is_buff
	if(!isnull(tick_length))
		src.tick_length = tick_length
	if(!isnull(chance))
		src.chance = chance
	my_parent = WEAKREF(parent)

/datum/artifact_effect/Del()
	my_parent = null
	current_location = null
	. = ..()

/// compares where we were to where we are now, and updates our current slot
/datum/artifact_effect/proc/update_location(atom/new_loc)
	if(!istype(new_loc))
		return
	var/atom/prev_loc = GET_WEAKREF(current_location)
	var/prev_slot = current_slot
	current_location = WEAKREF(new_holder)

/* 
/datum/artifact_effect/proc/equip_handler(mob/living/equipper, slot, prev_slot)
	var/coming_from_desired = (prev_slot in desired_slots)
	var/going_to_desired = (slot in desired_slots)
	if(coming_from_desired && !going_to_desired)
		run_effect(equipper, ART_UNEQUIP, slot, prev_slot)
	if(!coming_from_desired && going_to_desired)
		run_effect(equipper, ART_EQUIP, slot, prev_slot)
 */

/// Check if we're now in a desired slot
/datum/artifact_effect/proc/entered_handler(mob/living/mover, atom/new_loc, atom/old_loc)
	var/slot_going = get_slot(new_loc)
	if(slot_going in desired_slots)
		run_effect(mover, ART_EQUIP, slot_going)
	run_effect(mover, ART_INSERTED, new_loc)
	update_location(new_loc)

/// Check if we left a desired slot
/datum/artifact_effect/proc/exited_handler(mob/living/mover, atom/new_loc, atom/old_loc)
	var/previous_slot = get_slot(old_loc)
	if(prev_slot in desired_slots)
		run_effect(mover, ART_UNEQUIP, previous_slot)
	run_effect(mover, ART_REMOVED, old_loc)
	update_location(new_loc)

/// Searches thrugh the parents loc for something worn by a mob
/// Returns the slot it was found in, null if not found
/datum/artifact_effect/proc/get_slot(obj/item/recur)
	if(!isitem(recur))
		return
	if(recur.current_equipped_slot)
		return parent.current_equipped_slot
	if(isitem(recur.loc))
		return get_slot(recur.loc)

/// Prescreen to see if the effect should effect
/datum/artifact_effect/proc/pre_inserted(mob/living/target, atom/location)
	return pre_effect(target, location)

/// The actual effect of the thing
/datum/artifact_effect/proc/on_inserted(mob/living/target, atom/location)
	return TRUE

/// After-effects of the thing
/datum/artifact_effect/proc/post_inserted(mob/living/target, atom/location)
	return TRUE

/// Prescreen to see if the effect should effect
/datum/artifact_effect/proc/pre_removed(mob/living/target, atom/location)
	return pre_effect(target, location)

/// The actual effect of the thing
/datum/artifact_effect/proc/on_removed(mob/living/target, atom/location)
	return TRUE

/// After-effects of the thing
/datum/artifact_effect/proc/post_removed(mob/living/target, atom/location)
	return TRUE

/// Prescreen to see if the effect should effect
/datum/artifact_effect/proc/pre_equipped(mob/living/target, atom/location)
	return pre_effect(target, location)

/// The actual effect of the thing
/datum/artifact_effect/proc/on_equipped(mob/living/target, atom/location)
	return TRUE

/// After-effects of the thing
/datum/artifact_effect/proc/post_equipped(mob/living/target, atom/location)
	return TRUE

/// Prescreen to see if the effect should effect
/datum/artifact_effect/proc/pre_unequipped(mob/living/target, atom/location)
	return pre_effect(target, location)

/// The actual effect of the thing
/datum/artifact_effect/proc/on_unequipped(mob/living/target, atom/location)
	return TRUE

/// After-effects of the thing
/datum/artifact_effect/proc/post_unequipped(mob/living/target, atom/location)
	return TRUE

/// Prescreen to see if the effect should effect
/datum/artifact_effect/proc/pre_tick(mob/living/target, atom/location)
	if(!isliving(target)) // currently all effects affect the living
		return
	if(!COOLDOWN_FINISHED(src, cooldown))
		return
	if(!prob(chance))
		return
	var/obj/item/parent = GET_WEAKREF(my_parent)
	if(!istype(parent))
		return
	var/obj/item/holder = GET_WEAKREF(current_location)
	if(!istype(holder))
		return
	COOLDOWN_START(src, cooldown, tick_length)
	return TRUE

/// The actual effect of the thing
/datum/artifact_effect/proc/on_tick(mob/living/target, atom/location)
	return TRUE

/// After-effects of the thing
/datum/artifact_effect/proc/post_tick(mob/living/target, atom/location)
	return TRUE

/datum/artifact_effect/proc/run_effect(mob/living/target, action, atom/location)
	var/pre_return = FALSE
	switch(action)
		if(ART_INSERTED)
			if(!pre_inserted(target, location))
				return
			if(!on_inserted(target, location))
				return
			if(!post_inserted(target, location))
				return
		if(ART_REMOVED)
			if(!pre_removed(target, location))
				return
			if(!on_removed(target, location))
				return
			if(!post_removed(target, location))
				return
		if(ART_EQUIP)
			if(!pre_equipped(target, location))
				return
			if(!on_equipped(target, location))
				return
			if(!post_equipped(target, location))
				return
		if(ART_UNEQUIP)
			if(!pre_unequipped(target, location))
				return
			if(!on_unequipped(target, location))
				return
			if(!post_unequipped(target, location))
				return
		if(ART_TICK)
			if(!pre_tick(target))
				return
			if(!on_tick(target))
				return
			if(!post_tick(target))
				return
	return TRUE

/datum/artifact_effect/proc/pre_effect(mob/living/target, atom/location)
	if(!isliving(target)) // currently all effects affect the living
		return
	var/obj/item/parent = GET_WEAKREF(my_parent)
	if(!istype(parent))
		return
	return TRUE

//// MAX HP MODIFIER ////
/datum/artifact_effect/max_hp_modifier
	kind = ARTMOD_MAX_HP

/datum/artifact_effect/max_hp_modifier/on_equipped(mob/living/target)
	if(!..())
		return
	if(!istype(target))
		return
	target.maxHealth += amount

/datum/artifact_effect/max_hp_modifier/on_unequipped(mob/living/target)
	if(!..())
		return
	if(!istype(target))
		return
	target.maxHealth -= amount

/// PASSIVE DAMAGE DEALER ///
/// Dont use for healing, it just wont work ///
/datum/artifact_effect/passive_damage
	kind = ARTMOD_PASSIVE_DOT
	/// Stop doing damage if their health is below this
	var/min_health = 5
	/// Damage to do to brute
	var/brute = 0
	/// Damage to do to burn
	var/burn = 0
	/// Damage to do to toxin
	var/toxin = 0
	/// Damage to do to oxy
	var/oxy = 0
	/// Damage to do to clone
	var/clone = 0
	/// Damage to do to brain
	var/brain = 0
	/// Damage to do to organs
	var/organ = 0

/datum/artifact_effect/passive_damage/on_tick(mob/living/target, obj/item/holder)
	if(!..())
		return
	if(target.health < min_health)
		return
	target.apply_damages(
		brute,
		burn,
		toxin,
		oxy,
		clone,
		brain,
		organ,
	)

/// STAMINA ADJUSTER ///
/// Dont use for healing, it just wont work ///
/datum/artifact_effect/stamina
	kind = ARTMOD_STAMINA
	/// How much to adjust stamina by
	var/stamina_adjustment = 0
	/// Cooldown if it stamcrits the user
	var/stamcrit_cooldown = 45 SECONDS

/datum/artifact_effect/stamina/on_tick(mob/living/target, obj/item/holder)
	if(!..())
		return
	if(stamina_adjustment < 0)
		return do_stamage(target, holder, parent)
	else
		return do_stamheal(target, holder, parent)

/datum/artifact_effect/stamina/proc/do_stamage(mob/living/target, obj/item/holder)
	if(!COOLDOWN_FINISHED(src, ))

