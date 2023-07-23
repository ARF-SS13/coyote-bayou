#define ART_MASTER var/obj/item/master = parent

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
	RegisterSignal(parent, COMSIG_TRY_STORAGE_TAKE, .proc/on_storage_removal)
	RegisterSignal(parent, COMSIG_ITEM_CLICKED, .proc/on_clicked)
	RegisterSignal(parent, COMSIG_ITEM_MICROWAVE_ACT, .proc/on_microwave) //c:


/datum/component/artifact/proc/on_equipped(datum/source, mob/living/equipper, slot)
	ART_MASTER
	for(var/artifact_effect/effect in effects)
		effect.on_equip(equipper, master.loc, master, slot)


////////////////////////////
/// The actual effectors ///
/datum/artifact_effect
	var/is_buff
	var/kind
	var/name
	var/amount
	var/tick_length
	var/datum/weakref/holder
	COOLDOWN_DECLARE(cooldown)
	var/chance = 100

/datum/artifact_effect/New(
	obj/item/my_holder, 
	amount,
	name,
	is_buff,
	tick_length,
	chance
)
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

/datum/artifact_effect/proc/on_equip(mob/living/target, obj/item/holder, obj/item/parent, slot)
	return pre_effect(target, holder, parent, slot)

/datum/artifact_effect/proc/on_unequip(mob/living/target, obj/item/holder, obj/item/parent, slot)
	return pre_effect(target, holder, parent, slot)

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

