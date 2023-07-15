/datum/component/artifact
	var/list/effect_on_equip = list()
	var/list/effect_on_unequip = list()
	var/list/effect_on_tick = list()
	var/buff_text
	var/debuff_text
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/artifact/Initialize(rads_per_second, list/ref_n_type)
	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE
	if(!isnull(rads_per_second))
		rads = rads_per_second
	if(!rads)
		return COMPONENT_INCOMPATIBLE // gotta have some rads
	if(!ref_n_type)
		return COMPONENT_INCOMPATIBLE // gotta have something irradiating us
	for(var/reff in ref_n_type)
		radioactive_things[reff] = ref_n_type[reff]
	var/turf/our_turf = parent
	our_coordinates = "[our_turf.x]:[our_turf.y]:[our_turf.z]"
	RegisterSignal(parent, list(COMSIG_TURF_CHECK_RADIATION), .proc/im_still_here)

/datum/component/artifact/proc/do_passive_effect_mob(mob/living/target)
	for(var/effect in effect_on_tick)
		effect(target)

/datum/artifact_effect
	var/is_buff
	var/kind
	var/name
	var/amount
	var/tick_length
	COOLDOWN_DECLARE(cooldown)
	var/chance = 100

/datum/artifact_effect/New(amount, name, is_buff, tick_length, chance)
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

/datum/artifact_effect/proc/on_equip(mob/living/target, obj/item/holder, obj/item/parent)
	return

/datum/artifact_effect/proc/on_unequip(mob/living/target, obj/item/holder, obj/item/parent)
	return

/datum/artifact_effect/proc/on_tick(mob/living/target, obj/item/holder, obj/item/parent)
	return

//// MAX HP MODIFIER ////
/datum/artifact_effect/max_hp_modifier
	kind = ARTMOD_MAX_HP

/datum/artifact_effect/max_hp_modifier/on_equip(mob/living/target)
	if(!istype(target))
		return
	target.maxHealth += amount

/datum/artifact_effect/max_hp_modifier/on_unequip(mob/living/target)
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

/datum/artifact_effect/passive_damage/on_tick(mob/living/target, obj/item/holder, obj/item/parent)
	if(!istype(target))
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



