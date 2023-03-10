/datum/component/radiation_turf
	/// rads per 2 seconds
	var/rads = 0
	/// our coordinates, for when our parent disappears and we need to latch on to something
	var/our_coordinates
	/// debug thing, makes flashing happen
	var/thingtoggle = FALSE
	/// if we need to change mommies, and we cant find one, how many times should we try?
	var/mommies_left = 5
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/radiation_turf/Initialize(rads_per_second)
	if(!isturf(parent))
		return COMPONENT_INCOMPATIBLE
	if(!isnull(rads_per_second))
		rads = rads_per_second
	if(!rads)
		return COMPONENT_INCOMPATIBLE
	radiation_list_thing_go()
	START_PROCESSING(SSprocessing, src)

/datum/component/radiation_turf/proc/radiation_list_thing_go()
	if(!isturf(parent) || QDELETED(parent))
		qdel(src)
		return
	var/turf/our_turf = parent
	if("[our_turf.x]:[our_turf.y]:[our_turf.z]" in SSradiation.irradiated_turfs)
		stack_trace("[our_turf.x]:[our_turf.y]:[our_turf.z] [our_turf] WAS IN THE SSRADIATION IRRADIATED TURFS LIST WHEN IT SHOULDNT!!!")
		return
	SSradiation.irradiated_turfs["[our_turf.x]:[our_turf.y]:[our_turf.z]"] = rads
	our_coordinates = "[our_turf.x]:[our_turf.y]:[our_turf.z]"
	parentize(our_turf)

/datum/component/radiation_turf/proc/parentize(turf/our_turf)
	RegisterSignal(our_turf, list(COMSIG_TURF_RADIOACTIVE), .proc/im_still_here)
	RegisterSignal(our_turf, list(COMSIG_TURF_IRRADIATE), .proc/update_rads)
	RegisterSignal(our_turf, list(COMSIG_ATOM_ENTERED), .proc/AddMob)
	RegisterSignal(our_turf, list(COMSIG_ATOM_EXITED), .proc/RemoveMob)
	RegisterSignal(our_turf, list(COMSIG_TURF_CHANGE), .proc/on_turf_change)

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

/datum/component/radiation_turf/proc/update_rads(turf/the_turf, rad_change = 0)
	var/list/c2xyz = splittext(our_coordinates, ":")
	var/turf/rads_here = locate(text2num(c2xyz[1]),text2num(c2xyz[2]),text2num(c2xyz[3]))
	if(!isturf(rads_here) || QDELETED(rads_here))
		qdel(src)
		return
	if((rads += rad_change) <= 0)
		unrad()
		return
	SSradiation.irradiated_turfs["[rads_here.x]:[rads_here.y]:[rads_here.z]"] = rads
	return TRUE
	
/// so the SSradiation can periodically check if the shitload of turfs its remembering are still radioactive
/datum/component/radiation_turf/proc/im_still_here()
	return TRUE

/datum/component/radiation_turf/proc/unrad()
	var/list/c2xyz = splittext(our_coordinates, ":")
	var/turf/radbgone = locate(text2num(c2xyz[1]),text2num(c2xyz[2]),text2num(c2xyz[3]))
	if(thingtoggle)
		radbgone.maptext = ""
	thingtoggle = -1
	SSradiation.irradiated_turfs -= "[radbgone.x]:[radbgone.y]:[radbgone.z]"
	STOP_PROCESSING(SSradiation, src)
	qdel(src)

/datum/component/radiation_turf/proc/on_turf_change()
	SIGNAL_HANDLER
	addtimer(CALLBACK(src, .proc/find_new_parent), 1, TIMER_UNIQUE|TIMER_OVERRIDE) //*pain //*doublepain

/datum/component/radiation_turf/proc/find_new_parent()
	var/list/c2xyz = splittext(our_coordinates, ":")
	var/turf/new_mommy = locate(text2num(c2xyz[1]),text2num(c2xyz[2]),text2num(c2xyz[3]))
	if(!isturf(new_mommy) || QDELETED(new_mommy))
		if(mommies_left)
			addtimer(CALLBACK(src, .proc/find_new_parent), 1, TIMER_UNIQUE|TIMER_OVERRIDE) //*pain //*doublepain //*multipain
			mommies_left--
			return
		unrad()
		return
	parentize(new_mommy)

/// debug shit
/datum/component/radiation_turf/process()
	if(GLOB.rad_puddle_debug && thingtoggle != -1)
		var/list/c2xyz = splittext(our_coordinates, ":")
		var/turf/blinker = locate(text2num(c2xyz[1]),text2num(c2xyz[2]),text2num(c2xyz[3]))
		if(!isturf(blinker) || QDELETED(blinker))
			qdel(src)
			return
		blinker.maptext = thingtoggle ? "[rads]" : ""
		thingtoggle = !thingtoggle

