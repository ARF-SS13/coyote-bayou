#define MASTER_MEMORYHOLDER var/datum/blender_brain/master = host.resolve()
/// A datum that holds memories specific to a particular person

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
	/// flags regarding the person
	var/flags
	/// how much we like them
	var/amour = 0
	/// What clarification are we seeking from them?
	var/clarify = FALSE
	/// Are we listening to them?
	var/listening = FALSE
	/// The owner of this memory
	var/datum/weakref/host

/datum/blenderbrain_memory/New(datum/blender_brain/brain, atom/movable/thingy)
	if(!thingy || !brain)
		qdel(src)
		return
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
	var/datum/blender_brain/brain = host.resolve()
	if(brain)
		brain.memories -= name
	host = null
	. = ..()

/datum/blenderbrain_memory/proc/get_amour()
	return amour

/datum/blenderbrain_memory/proc/adjust_amour(amount)
	amour = clamp(amour + amount, AMOUR_MIN, AMOUR_MAX)
	return amour

/datum/blenderbrain_memory/proc/check_clarify()
	return clarify

/datum/blenderbrain_memory/proc/set_clarify(clarification)
	clarify = clarification
	return TRUE

/datum/blenderbrain_memory/proc/clear_clarify()
	clarify = FALSE
	return TRUE

/datum/blenderbrain_memory/proc/is_owner()
	return CHECK_BITFIELD(flags, BB_IS_OWNER)

/datum/blenderbrain_memory/proc/set_owner()
	ENABLE_BITFIELD(flags, BB_IS_OWNER)
	return TRUE

/datum/blenderbrain_memory/proc/disown_owner()
	if(!CHECK_BITFIELD(flags, BB_IS_OWNER))
		return FALSE
	DISABLE_BITFIELD(flags, BB_IS_OWNER)
	ENABLE_BITFIELD(flags, BB_WAS_OWNER)
	return TRUE

/datum/blenderbrain_memory/proc/was_owner()
	return CHECK_BITFIELD(flags, BB_WAS_OWNER)

/datum/blenderbrain_memory/proc/is_mean_person()
	return CHECK_BITFIELD(flags, BB_WAS_MEAN)

/datum/blenderbrain_memory/proc/add_mean_person()
	ENABLE_BITFIELD(flags, BB_WAS_MEAN)
	return TRUE

/datum/blenderbrain_memory/proc/unset_mean()
	ENABLE_BITFIELD(flags, BB_WAS_MEAN)
	return TRUE

/datum/blenderbrain_memory/proc/is_listening()
	return listening

/datum/blenderbrain_memory/proc/set_listening()
	listening = TRUE
	return listening

/datum/blenderbrain_memory/proc/set_not_listening()
	listening = TRUE
	return listening




