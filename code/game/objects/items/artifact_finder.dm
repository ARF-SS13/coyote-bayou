/// Click it to send a ping to its chosen artifact, or just some random one I guess
/// Altclick it to bring up a TGUI window to select an artifact to ping
/// Can hold up to 10 artifacts in memory at once
/obj/item/artifact_finder
	name = "\improperFlufferNut Artifinder"
	desc = "A device that can be used to find artifacts."
	icon = 'icons/obj/device.dmi'
	icon_state = "pinpointer"
	w_class = WEIGHT_CLASS_SMALL
	/// format: list("artifact_tag" = /datum/weakref/the_artifact)
	var/list/memory = list()
	var/current_artifact = null
	var/currently_scanning = FALSE
	var/scan_time = 5 SECONDS
	var/datum/weakref/scan_turf
	var/list/papers = list()
	var/max_paper = 5
	var/start_paper = 5
	COOLDOWN_DECLARE(scan_cooldown)

/obj/item/artifact_finder/Initialize(mapload)
	. = ..()
	for(var/i in 1 to start_paper)
		papers += new /obj/item/paper(src)

/obj/item/artifact_finder/proc/ping(mob/user)
	if(!user)
		return
	if(!COOLDOWN_FINISHED(src, scan_cooldown))
		return
	if(currently_scanning)
		return
	area_scan(user)
	if(!current_artifact)
		return
	var/datum/weakref/thingy = LAZYACCESS(memory, current_artifact)
	var/obj/item/arti = GET_WEAKREF(thingy)
	if(!arti)
		return
	var/turf/here = get_turf(src)
	var/turf/there = get_turf(arti)
	var/angle = Get_Angle(here, there)
	angle += rand(-5, 5)

/obj/item/artifact_finer/AltClick(mob/user)
	. = ..()
	ping(user)

/obj/item/artifact_finder/area_scan(mob/user)
	var/list/arts = list()
	for(var/obj/item/I in range(5, get_turf(src)))
		if(SEND_SIGNAL(I, COMSIG_ITEM_ARTIFACT_EXISTS))
			arts += I
	if(LAZYLEN(arts))
		for(var/obj/item/arty in arts)
			var/obj/effect/temp_visual/detector_overlay/oldC = locate(/obj/effect/temp_visual/detector_overlay) in M
			if(oldC)
				qdel(oldC)
			new /obj/effect/temp_visual/detector_overlay(M)











