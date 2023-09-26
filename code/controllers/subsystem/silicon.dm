// A cute lil subsystem that handles robots and silicon stuff
SUBSYSTEM_DEF(silicon)
	name = "Silicon"
	wait = 1 SECONDS

	var/list/silicon_skins = list()

/datum/controller/subsystem/silicon/Initialize(start_timeofday)
	initialize_skins()
	. = ..()
	
/datum/controller/subsystem/silicon/ShowSkinRadial(mob/living/silicon/user, list/allowed_skins)
	if(!istype(user))
		return FALSE
	if(!LAZYLEN(allowed_skins))
		for(var/datum/)
	var/list/skinnies = list()
	for(var/sken in silicon_skins)
		var/datum/robot_skin/skine = LAZYACCESS(silicon_skins, sken)
		if(!skine)
			silicon_skins -= skine
			continue
		skinnies["[skine.skin]"] = skine.get_preview_image()
	var/choice = show_radial_menu(user, user, skinnies, custom_check = CALLBACK(src, .proc/can_reskin, src, user), radius = 40, require_near = TRUE, ultradense = (LAZYLEN(silicon_skins) > 7))
	if(!choice)
		return FALSE
	if(QDELETED(user))
		return FALSE
	var/datum/robot_skin/skindatum = LAZYACCESS(silicon_skins, choice)
	if(!skindatum)
		return FALSE
	INVOKE_ASYNC(src, .proc/RunReskinProcess, user, skindatum)
	return TRUE











