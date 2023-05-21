#define MASTER_MEMORYHOLDER var/datum/blender_brain/master = host.resolve()
/// A datum that holds how we feel about a particular person

/datum/blenderbrain_memory
	/// Realname of the person
	var/name
	/// The person's ckey
	var/ckey
	/// The ckey of the person's name (for indexing)
	var/ckey_name
	/// The person's job
	var/job
	/// The person's gender
	var/gender
	/// relation_flags regarding the person
	var/relation_flags
	/// Events that happened and when they happened
	var/list/events = list()
	/// How we relation them
	var/relation = BB_MR_NEUTRAL
	/// how much we like them
	var/amour = 0
	/// How many times we can forgive this person
	var/strikes = 3
	/// What clarification are we seeking from them?
	var/clarify = FALSE
	/// How closely are we attention_span to them?
	var/attention_span = 0 // usually goes to 2, decrements by 1 when just said hi to, then to 0 if no command is given
	/// Batched amour changes
	var/amour_batch = 0
	/// The owner of this memory
	var/datum/weakref/host
	/// The person connected to this memory (fuckin)

/datum/blenderbrain_memory/New(datum/blender_brain/brain, atom/movable/thingy)
	if(!brain)
		qdel(src)
		return
	if(!thingy)
		thingy = "Unknown"
	host = WEAKREF(brain)
	if(istext(thingy))
		name = thingy
		ckey = "Unknown"
		job = "Unknown"
		gender = "Unknown"
	else if(istype(thingy))
		if(ismob(thingy))
			var/mob/person = thingy
			name = "[person.real_name]"
			ckey = "[person.ckey]"
			ckey_name = "[ckey(person.real_name)]"
			job = person.job ? "[person.job]" : "Unknown"
			gender = "[person.gender]"
		else
			name = "[thingy.name]"
			ckey = "Unknown"
			job = "Unknown"
			gender = "[thingy.gender]"
	brain.memories[ckey(name)] = src

/datum/blenderbrain_memory/Destroy(force, ...)
	var/datum/blender_brain/brain = host?.resolve()
	if(brain)
		brain.memories -= name
	host = null
	. = ..()

/datum/blenderbrain_memory/proc/get_amour()
	return amour

/datum/blenderbrain_memory/proc/adjust_amour(amount)
	amour_batch = clamp(amour_batch + amount, BB_AMOUR_MIN, BB_AMOUR_MAX)
	return amour

/datum/blenderbrain_memory/proc/check_clarify()
	return clarify

/datum/blenderbrain_memory/proc/set_clarify(clarification)
	clarify = clarification
	return TRUE

/datum/blenderbrain_memory/proc/clear_clarify()
	clarify = FALSE
	return TRUE

/datum/blenderbrain_memory/proc/add_relationship(which)
	ENABLE_BITFIELD(relation_flags, which)
	return TRUE

/datum/blenderbrain_memory/proc/remove_relationship(which)
	DISABLE_BITFIELD(relation_flags, which)
	return TRUE

/datum/blenderbrain_memory/proc/check_relationship(which)
	return CHECK_BITFIELD(relation_flags, which)

/datum/blenderbrain_memory/proc/is_owner()
	return CHECK_BITFIELD(relation_flags, BB_MF_IS_OWNER)

/datum/blenderbrain_memory/proc/ownerize()
	ENABLE_BITFIELD(relation_flags, BB_MF_IS_OWNER)
	return TRUE

/datum/blenderbrain_memory/proc/disown_owner(remember)
	if(!CHECK_BITFIELD(relation_flags, BB_MF_IS_OWNER))
		return FALSE
	DISABLE_BITFIELD(relation_flags, BB_MF_IS_OWNER)
	if(remember)
		ENABLE_BITFIELD(relation_flags, BB_MF_WAS_OWNER)
	return TRUE

/datum/blenderbrain_memory/proc/is_paying_attention()
	return attention_span

/datum/blenderbrain_memory/proc/decrease_attention()
	DECREMENTBY(attention_span, 1, 0)
	return attention_span

/datum/blenderbrain_memory/proc/set_paying_attention()
	attention_span = 2
	return attention_span

/datum/blenderbrain_memory/proc/unset_paying_attention()
	attention_span = FALSE
	return attention_span

/datum/blenderbrain_memory/proc/forgive()
	if(strikes > 0)
		strikes--
		remove_relationship(BB_MF_IS_HATED)
		return TRUE
	return FALSE

/datum/blenderbrain_memory/proc/add_forgiveness()
	if(strikes < 3)
		strikes++
		return TRUE
	return FALSE

/datum/blenderbrain_memory/proc/can_forgive()
	return strikes

/// Adds an event to the memory and sets the time it happened
/datum/blenderbrain_memory/proc/event_cooldown(event, cooldown)
	LAZYSET(events, "[event]", world.time + cooldown)
	return TRUE

/// returns the time it happened
/datum/blenderbrain_memory/proc/event_happened(event)
	if(!events["[event]"])
		return FALSE
	return events["[event]"]

/// returns if the event is done on cooldown
/datum/blenderbrain_memory/proc/event_finished(event)
	var/time = LAZYACCESS(events, "[event]")
	if(!time)
		return TRUE
	return (time <= world.time)

/datum/blenderbrain_memory/proc/update_amour()
	if(!amour_batch)
		return FALSE
	amour = clamp(amour + amour_batch, BB_AMOUR_MIN, BB_AMOUR_MAX)
	amour_batch = 0
	return TRUE

