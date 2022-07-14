/area/f13/ambientlighting/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_EXIT_AREA, .proc/HandleExitLighting)
	RegisterSignal(src, COMSIG_ENTER_AREA, .proc/HandleEnterLighting)

/area/f13/ambientlighting/proc/HandleExitLighting(datum/source, mob/user)
	if(!isliving(user))
		return

	var/mob/living/L = user

	if()

/area/f13/ambientlighting/proc/HandleEnterLighting(datum/source, mob/user)
	if(!isliving(user))
		return
	
	var/mob/living/L = user

