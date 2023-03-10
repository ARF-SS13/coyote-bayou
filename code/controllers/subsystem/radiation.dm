GLOBAL_VAR_INIT(rad_puddle_debug, FALSE)
PROCESSING_SUBSYSTEM_DEF(radiation)
	name = "Radiation"
	flags = SS_NO_INIT | SS_BACKGROUND

	var/list/warned_atoms = list()
	/// Contains a list of coordinates to turfs that are irradiated
	/// list("x:y:z" = rad_level)
	var/list/irradiated_turfs = list()
	/// irradiated mobs, to be blasted with radiation every tick
	/// list("mob_whatever" = rad_level)
	var/list/irradiated_mobs = list()
	/// Occasionally clean up the irradiated mobs and turfs
	COOLDOWN_DECLARE(cleanup_radiation)
	/// debug command, dont usr
	var/greened = FALSE

/datum/controller/subsystem/processing/radiation/fire(resumed)
	if(COOLDOWN_FINISHED(src, cleanup_radiation))
		cleanup_radiation()
		COOLDOWN_START(src, cleanup_radiation, 15 MINUTES)
	var/list/bad_mobs = list()
	for(var/glowie in irradiated_mobs)
		var/mob/living/carbon/human/glowman = locate(glowie)
		if(!istype(glowman))
			bad_mobs += glowie
			continue
		var/coordz = "[glowman.x]:[glowman.y]:[glowman.z]"
		if(!(coordz in irradiated_turfs))
			irradiated_turfs -= coordz
			bad_mobs += glowie
			continue
		var/turf/check_turf = locate(glowman.x, glowman.y, glowman.z)
		if(!SEND_SIGNAL(check_turf, COMSIG_TURF_RADIOACTIVE)) // is that turf radioactive? if not, then, wierd
			irradiated_turfs -= coordz
			bad_mobs += glowie
			continue
		glowman.rad_act(irradiated_turfs[coordz])
	if(LAZYLEN(bad_mobs))
		for(var/baddie in bad_mobs)
			irradiated_mobs -= baddie
	if(GLOB.rad_puddle_debug)
		for(var/coordie in irradiated_turfs)
			var/list/c2xyz = splittext(coordie, ":")
			var/turf/helpme = locate(text2num(c2xyz[1]),text2num(c2xyz[2]),text2num(c2xyz[3]))
			if(helpme)
				helpme.color = greened ? initial(helpme.color) : "#00ff00"
		greened = !greened

/datum/controller/subsystem/processing/radiation/proc/cleanup_radiation()
	var/list/bad_mobs = list()
	for(var/glowie in irradiated_mobs)
		var/mob/living/carbon/human/glowman = locate(glowie)
		if(!istype(glowman))
			bad_mobs += glowie
			continue
	if(LAZYLEN(bad_mobs))
		for(var/baddie in bad_mobs)
			irradiated_mobs -= baddie
	var/list/bad_turfs = list()
	for(var/turfie in irradiated_turfs)
		var/list/c2xyz = splittext(turfie, ":")
		var/turf/fieturf = locate(text2num(c2xyz[1]),text2num(c2xyz[2]),text2num(c2xyz[3]))
		if(!fieturf)
			bad_turfs += turfie
		if(!SEND_SIGNAL(fieturf, COMSIG_TURF_RADIOACTIVE))
			bad_turfs += turfie
	if(LAZYLEN(bad_turfs))
		for(var/badone in bad_turfs)
			irradiated_turfs -= badone

/datum/controller/subsystem/processing/radiation/proc/warn(datum/component/radioactive/contamination)
	if(!contamination || QDELETED(contamination))
		return
	var/ref = REF(contamination.parent)
	if(warned_atoms[ref])
		return
	warned_atoms[ref] = TRUE
	var/atom/master = contamination.parent
	SSblackbox.record_feedback("tally", "contaminated", 1, master.type)
	var/msg = "has become contamintaed with enough radiation to contaminate other objects. || Source: [contamination.source] || Strength: [contamination.strength]"
	master.investigate_log(msg, INVESTIGATE_RADIATION)
