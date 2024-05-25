// fuck it i'll just make it its own subsystem whatever
/// Makes people scream and shout a number when irradiated
GLOBAL_VAR_INIT(rad_puddle_debug, FALSE)
SUBSYSTEM_DEF(radturf)
	name = "RadTurfs"
	flags = SS_BACKGROUND|SS_NO_INIT
	wait = 1 SECONDS

	/// irradiated mobs, to be blasted with radiation every tick
	/// list("mob_whatever" = rad_level)
	var/list/irradiated_mobs = list()

/datum/controller/subsystem/radturf/fire(resumed)
	for(var/glowie in irradiated_mobs)
		var/mob/living/carbon/human/glowman = locate(glowie)
		if(!istype(glowman))
			irradiated_mobs -= glowie
			continue
		var/turf/check_turf = get_turf(glowman)
		var/radblastusa = SEND_SIGNAL(check_turf, COMSIG_TURF_CHECK_RADIATION) // is that turf radioactive? if not, then, wierd
		if(radblastusa <= 0) 
			irradiated_mobs -= glowie
			continue
		glowman.rad_act(radblastusa)
		if(GLOB.rad_puddle_debug)
			glowman.emote("scream")
			glowman.say("[radblastusa]")

/// the irradiated tile got changed and its component deleted, check back in a split second and apply a new one there
/datum/controller/subsystem/radturf/proc/tile_got_changed(turf_coords, list/puddles, new_rads)
	addtimer(CALLBACK(src,PROC_REF(add_radtile), turf_coords, puddles, new_rads, 5), 2, TIMER_UNIQUE|TIMER_OVERRIDE) //*pain //*doublepain

/datum/controller/subsystem/radturf/proc/add_radtile(turf_coords, list/puddles, new_rads, tries = 5)
	if(new_rads <= 0) // idk
		return
	var/turf/new_turf = coords2turf(turf_coords)
	/// the new turf either doesnt exist, or is still being replaced, check back in another split second
	if(!new_turf || QDELETED(new_turf))
		if(tries)
			addtimer(CALLBACK(src,PROC_REF(add_radtile), turf_coords, puddles, new_rads, tries - 1), 2, TIMER_UNIQUE|TIMER_OVERRIDE) //*pain //*doublepain
		return // okay fine, there's a hole to nothing right here, fucking, cool.
	// the component itself will figure out of its puddles are still good or not at some point, not our concern
	if(SEND_SIGNAL(new_turf, COMSIG_TURF_CHECK_RADIATION)) // okay check if there's still a component there first
		return // and let it be
	// okay NOW shove a component in there
	new_turf.AddComponent(/datum/component/radiation_turf, new_rads, puddles)
