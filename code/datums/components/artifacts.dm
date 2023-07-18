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

/datum/artifact_effect/proc/pre_effect(mob/living/target, obj/item/holder, obj/item/parent)
	if(!isliving(target))
		return
	if(!isitem(holder))
		return
	if(!isitem(parent))
		return
	if(!COOLDOWN_FINISHED(src, cooldown))
		return
	COOLDOWN_START(src, cooldown, tick_length)
	if(!prob(chance))
		return
	return TRUE

/datum/artifact_effect/proc/on_equip(mob/living/target, obj/item/holder, obj/item/parent)
	return pre_effect(target, holder, parent)

/datum/artifact_effect/proc/on_unequip(mob/living/target, obj/item/holder, obj/item/parent)
	return pre_effect(target, holder, parent)

/datum/artifact_effect/proc/on_tick(mob/living/target, obj/item/holder, obj/item/parent)
	return pre_effect(target, holder, parent)

//// MAX HP MODIFIER ////
/datum/artifact_effect/max_hp_modifier
	kind = ARTMOD_MAX_HP

/datum/artifact_effect/max_hp_modifier/on_equip(mob/living/target)
	if(!..())
		return
	if(!istype(target))
		return
	target.maxHealth += amount

/datum/artifact_effect/max_hp_modifier/on_unequip(mob/living/target)
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

/datum/artifact_effect/passive_damage/on_tick(mob/living/target, obj/item/holder, obj/item/parent)
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

/datum/artifact_effect/stamina/on_tick(mob/living/target, obj/item/holder, obj/item/parent)
	if(!..())
		return
	if(stamina_adjustment < 0)
		return do_stamage(target, holder, parent)
	else
		return do_stamheal(target, holder, parent)

/datum/artifact_effect/stamina/proc/do_stamage(mob/living/target, obj/item/holder, obj/item/parent)
	if(!COOLDOWN_FINISHED(src, ))

