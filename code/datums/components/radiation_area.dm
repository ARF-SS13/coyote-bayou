/datum/component/radiation_area
	var/list/mobs_to_irradiate = list()
	var/rads = 0
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/radiation_area/Initialize(rads_per_second)
	if(!isarea(parent))
		return COMPONENT_INCOMPATIBLE
	if(!isnull(rads_per_second))
		rads = rads_per_second
	RegisterSignal(parent, list(COMSIG_AREA_ENTERED),PROC_REF(AddMob))
	RegisterSignal(parent, list(COMSIG_AREA_EXITED),PROC_REF(RemoveMob))

/datum/component/radiation_area/proc/AddMob(area/the_area, mob/living/carbon/glowy)
	if(!istype(glowy))
		return
	mobs_to_irradiate |= glowy
	START_PROCESSING(SSprocessing, src)

/datum/component/radiation_area/proc/RemoveMob(area/the_area, mob/living/carbon/glowy)
	if(!istype(glowy))
		return
	mobs_to_irradiate -= glowy
	if(!LAZYLEN(mobs_to_irradiate))
		STOP_PROCESSING(SSprocessing, src)

/datum/component/radiation_area/process()
	if(QDELETED(parent))
		return PROCESS_KILL
	if(!LAZYLEN(mobs_to_irradiate))
		return PROCESS_KILL
	for(var/mob/living/carbon/glowie in mobs_to_irradiate)
		glowie.rad_act(rads)

