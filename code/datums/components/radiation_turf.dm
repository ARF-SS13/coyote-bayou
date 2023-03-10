/datum/component/radiation_turf
	/// rads per 2 seconds
	var/rads = 0
	/// refs to puddles that supposedly make this tile radioactive, used for tile-changes
	var/list/radioactive_things = list()
	/// our coordinates, for when our parent disappears and we need to latch on to something
	var/our_coordinates
	/// debug thing, makes flashing happen
	var/thingtoggle = FALSE
	/// Turf is changing, dont delete us from the subsystem just yet!
	var/custody_meeting = FALSE
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/radiation_turf/Initialize(rads_per_second, reffie)
	if(!isturf(parent))
		return COMPONENT_INCOMPATIBLE
	if(!isnull(rads_per_second))
		rads = rads_per_second
	if(!rads)
		return COMPONENT_INCOMPATIBLE // gotta have some rads
	if(!reffie)
		return COMPONENT_INCOMPATIBLE // gotta have something irradiating us
	radioactive_things |= reffie // could be a single thing, could be a list, either from a puddle, or SSradiation did a switcheroo
	radiation_list_thing_go()
	RegisterSignal(parent, list(COMSIG_TURF_RADIOACTIVE), .proc/im_still_here)
	RegisterSignal(parent, list(COMSIG_TURF_IRRADIATE), .proc/update_rads)
	RegisterSignal(parent, list(COMSIG_ATOM_ENTERED), .proc/AddMob)
	RegisterSignal(parent, list(COMSIG_ATOM_EXITED), .proc/RemoveMob)
	RegisterSignal(parent, list(COMSIG_TURF_CHANGE), .proc/on_turf_change)
	START_PROCESSING(SSprocessing, src)

/datum/component/radiation_turf/proc/radiation_list_thing_go()
	if(!isturf(parent) || QDELETED(parent))
		unrad(src)
		return
	var/turf/our_turf = parent
	if("[our_turf.x]:[our_turf.y]:[our_turf.z]" in SSradiation.irradiated_turfs)
		stack_trace("[our_turf.x]:[our_turf.y]:[our_turf.z] [our_turf] WAS IN THE SSRADIATION IRRADIATED TURFS LIST WHEN IT SHOULDNT!!!")
	SSradiation.irradiated_turfs["[our_turf.x]:[our_turf.y]:[our_turf.z]"] = rads
	our_coordinates = "[our_turf.x]:[our_turf.y]:[our_turf.z]"

// from this point onwards, we cannot rely on our parent to be our turf. 
// So, we'll have to sit here and treat whatever's at our coordinates *as* our parent 

/datum/component/radiation_turf/proc/AddMob(turf/the_turf, mob/living/carbon/human/glowy)
	if(!istype(glowy))
		return
	var/weakie = WEAKERREF(glowy)
	if((glowy in SSradiation.irradiated_mobs) && SSradiation.irradiated_mobs[weakie] <= rads)
		return // highest rads win
	SSradiation.irradiated_mobs[weakie] = rads

/datum/component/radiation_turf/proc/RemoveMob(turf/the_turf, mob/living/carbon/human/glowy)
	if(!istype(glowy))
		return
	var/weakie = WEAKERREF(glowy)
	SSradiation.irradiated_mobs -= weakie

/datum/component/radiation_turf/proc/update_rads(turf/the_turf, rad_change = 0, reff)
	var/turf/rads_here = coords2turf(our_coordinates)
	if(!isturf(rads_here) || QDELETED(rads_here))
		unrad()
		return
	if(rads > 0)
		radioactive_things |= reff
	else
		radioactive_things -= reff
	if(!LAZYLEN(radioactive_things |= reff)) // check if we're still tied to anything
		unrad()
		return
	if((rads += rad_change) <= 0) // check if our tile is radioactive
		unrad()
		return
	SSradiation.irradiated_turfs["[rads_here.x]:[rads_here.y]:[rads_here.z]"] = rads
	return TRUE
	
/// so the SSradiation can periodically check if the shitload of coordinates its remembering are still radioactive
/datum/component/radiation_turf/proc/im_still_here()
	return TRUE

/datum/component/radiation_turf/UnregisterFromParent()
	unrad(TRUE)

/// tells the radiation subsys (that really does all the work) to remove this tile from its radlist
/datum/component/radiation_turf/proc/unrad(already_qdelling = FALSE)
	var/turf/radbgone = coords2turf(our_coordinates)
	if(thingtoggle)
		radbgone.maptext = ""
	thingtoggle = -1
	if(!custody_meeting)
		SSradiation.irradiated_turfs -= "[radbgone.x]:[radbgone.y]:[radbgone.z]"
	STOP_PROCESSING(SSradiation, src)
	if(!already_qdelling)
		qdel(src)

/// Tell the radiation system that we're gonna die, put another component at whatever's gonna be here
/datum/component/radiation_turf/proc/on_turf_change()
	SIGNAL_HANDLER
	custody_meeting = TRUE
	SSradiation.tile_got_changed(our_coordinates, radioactive_things, rads)

/// debug shit
/datum/component/radiation_turf/process()
	if(GLOB.rad_puddle_debug && thingtoggle != -1)
		var/turf/blinker = coords2turf(our_coordinates)
		if(!isturf(blinker) || QDELETED(blinker))
			qdel(src)
			return
		blinker.maptext = thingtoggle ? "[rads]" : ""
		thingtoggle = !thingtoggle

