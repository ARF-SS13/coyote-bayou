/area/f13/ambientlighting/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_EXIT_AREA, .proc/HandleExitLighting)
	RegisterSignal(src, COMSIG_ENTER_AREA, .proc/HandleEnterLighting)

/area/f13/ambientlighting/proc/HandleExitLighting(datum/source, mob/user)
	if(!iscarbon(user))
		return

	var/mob/living/carbon/C = user
	var/obj/item/organ/eyes/E = C.getorganslot(ORGAN_SLOT_EYES)
	
	if(!E)
		return
	
	if(see_in_dark_override)
		E.see_in_dark = max(user.see_in_dark, see_in_dark_override)
	if(lighting_alpha_override)
		E.lighting_alpha = min(user.lighting_alpha, lighting_alpha_override)
	
	C.update_sight()

/area/f13/ambientlighting/proc/HandleEnterLighting(datum/source, mob/user)
	if(!isliving(user))
		return
	
	var/mob/living/carbon/C = user
	var/obj/item/organ/eyes/E = C.getorganslot(ORGAN_SLOT_EYES)

	if(!E)
		return
	
	E.see_in_dark = initial(E.see_in_dark)
	E.lighting_alpha = initial(E.lighting_alpha)
	
	C.update_sight()

