#define LOCATION_LIST_MAX 50

/datum/component/stationloving
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	var/inform_admins = FALSE
	var/disallow_soul_imbue = TRUE
	var/allow_death = FALSE
	var/ignore_z_level = FALSE

	/// Just dunk the thing somewhere random if it goes out of its zone
	var/put_somewhere_random = TRUE
	/// Z levels its allowed to be
	var/list/allowed_z = VALIDBALL_Z_LEVELS
	/// List of turfs we've recorded as okay to be
	var/list/put_it_here[LOCATION_LIST_MAX]
	/// The index of put_it_here to add the new turf reference
	var/put_here_index = 1
	/// Turf record cooldown
	COOLDOWN_DECLARE(turf_record_cooldown)

/datum/component/stationloving/Initialize(inform_admins = FALSE, allow_death = FALSE, put_somewhere_random = TRUE, allowed_z = VALIDBALL_Z_LEVELS, ignore_z = FALSE)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_MOVABLE_Z_CHANGED),PROC_REF(check_in_bounds))
	RegisterSignal(parent, list(COMSIG_MOVABLE_SECLUDED_LOCATION),PROC_REF(relocate))
	RegisterSignal(parent, list(COMSIG_PARENT_PREQDELETED),PROC_REF(check_deletion))
	RegisterSignal(parent, list(COMSIG_ITEM_IMBUE_SOUL),PROC_REF(check_soul_imbue))
	RegisterSignal(parent, list(COMSIG_ITEM_PROCESS),PROC_REF(record_position))
	src.allowed_z = allowed_z
	src.put_somewhere_random = put_somewhere_random
	if(!put_somewhere_random)
		record_position() // may as well
	src.inform_admins = inform_admins
	src.allow_death = allow_death
	src.ignore_z_level = ignore_z
	check_in_bounds() // Just in case something is being created outside of station/centcom

/datum/component/stationloving/InheritComponent(datum/component/stationloving/newc, original, inform_admins, allow_death)
	if (original)
		if (newc)
			inform_admins = newc.inform_admins
			allow_death = newc.allow_death
		else
			inform_admins = inform_admins

/datum/component/stationloving/proc/record_position()
	if(!COOLDOWN_FINISHED(src, turf_record_cooldown))
		return FALSE
	var/turf/you_are_here = get_turf(parent)
	if(!isturf(you_are_here)) // shrug
		return FALSE
	if(is_turf_okay_to_use(you_are_here))
		put_it_here[put_here_index] = WEAKREF(you_are_here)
		put_here_index++
		if(put_here_index > LOCATION_LIST_MAX)
			put_here_index = 1
		COOLDOWN_START(src, turf_record_cooldown, 10 SECONDS)
		return TRUE

/datum/component/stationloving/proc/is_turf_okay_to_use(turf/right_here)
	if(right_here.density)
		return FALSE
	if(right_here in put_it_here) // new turfs only
		return FALSE
	if(ignore_z_level)
		return TRUE
	if(!(right_here.z in allowed_z))
		return FALSE
	return TRUE

/datum/component/stationloving/proc/get_recorded_turf()
	if(!LAZYLEN(put_it_here))
		return FALSE // fuck
	var/check_index = put_here_index - 1
	if(check_index < 1)
		check_index = LAZYLEN(put_it_here)
	for(var/index in 1 to LAZYLEN(put_it_here))
		var/datum/weakref/weak_entry = put_it_here[check_index]
		if(isweakref(weak_entry))
			weak_entry = weak_entry.resolve()
			if(isturf(weak_entry))
				return weak_entry

		check_index++
		if(check_index > LAZYLEN(put_it_here))
			check_index = 1
	return FALSE // double fuck

/datum/component/stationloving/proc/relocate()
	var/turf/targetturf
	if(put_somewhere_random)
		targetturf = find_safe_turf()
	else
		targetturf = get_recorded_turf()
		if(!targetturf)
			targetturf = find_safe_turf() // shrug
	if(!targetturf)
		if(GLOB.blobstart.len > 0)
			targetturf = get_turf(pick(GLOB.blobstart))
		else
			CRASH("Unable to find a blobstart landmark, or anywhere else to put [src].")

	var/atom/movable/AM = parent
	to_chat(get(parent, /mob), span_danger("You can't help but feel that you just lost something back there..."))
	AM.forceMove(targetturf)
	// move the disc, so ghosts remain orbiting it even if it's "destroyed"
	return targetturf

/datum/component/stationloving/proc/check_in_bounds()
	if(in_bounds())
		return
	var/turf/currentturf = get_turf(parent)
	var/turf/targetturf = relocate()
	log_game("[parent] has been moved out of bounds in [loc_name(currentturf)]. Moving it to [loc_name(targetturf)].")
	if(inform_admins)
		message_admins("[parent] has been moved out of bounds in [ADMIN_VERBOSEJMP(currentturf)]. Moving it to [ADMIN_VERBOSEJMP(targetturf)].")

/datum/component/stationloving/proc/check_soul_imbue()
	return disallow_soul_imbue

/datum/component/stationloving/proc/in_bounds()
	if(ignore_z_level)
		return TRUE
	var/static/list/allowed_shuttles = typecacheof(list(/area/shuttle/syndicate, /area/shuttle/escape, /area/shuttle/pod_1, /area/shuttle/pod_2, /area/shuttle/pod_3, /area/shuttle/pod_4))
	var/turf/T = get_turf(parent)
	if (!T)
		return FALSE
	var/area/A = T.loc
	if(LAZYLEN(allowed_z))
		if(!(T.z in allowed_z))
			return FALSE
		return TRUE
	if(istype(A, /area/fabric_of_reality)) // Obviously terrible, just for test merging
		return FALSE
	if (is_station_level(T.z) || is_centcom_level(T.z))
		return TRUE
	if (is_reserved_level(T.z))
		if (is_type_in_typecache(A, allowed_shuttles))
			return TRUE

	return FALSE

/datum/component/stationloving/proc/check_deletion(datum/source, force) // TRUE = interrupt deletion, FALSE = proceed with deletion

	var/turf/T = get_turf(parent)

	if(inform_admins && force)
		message_admins("[parent] has been !!force deleted!! in [ADMIN_VERBOSEJMP(T)].")
		log_game("[parent] has been !!force deleted!! in [loc_name(T)].")

	if(!force && !allow_death)
		var/turf/targetturf = relocate()
		log_game("[parent] has been destroyed in [loc_name(T)]. Moving it to [loc_name(targetturf)].")
		if(inform_admins)
			message_admins("[parent] has been destroyed in [ADMIN_VERBOSEJMP(T)]. Moving it to [ADMIN_VERBOSEJMP(targetturf)].")
		return TRUE
	return FALSE

#undef LOCATION_LIST_MAX
