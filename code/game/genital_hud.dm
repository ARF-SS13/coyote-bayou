/// WELCOME TO PORNHUD, HOME OF THE MOST PIXELATED BUTTS AND WIENERS ON SS13


/datum/atom_hud/data/human/genital
	hud_icons = list(GENITAL_HUD)

/// hud_list format list("has_genital" = list("FRONT" = list(img, img), "MID" = list(img)))
/// M is the viewer, A is the thing with the hud stuff on it, remove_list just removes the list and clears it from everyone
/datum/atom_hud/data/human/genital/add_to_single_hud(mob/M, atom/A, send_signal) //unsafe, no sanity apart from client
	if(!M || !M.client || !A)
		return
	if(!ishuman(A))
		return
	if(send_signal)
		SEND_SIGNAL(A, COMSIG_HUMAN_UPDATE_GENITALS)
		SEND_SIGNAL(M, COMSIG_HUMAN_UPDATE_GENITALS)
	var/mob/living/carbon/human/owner = A
	var/list/order = splittext(owner?.dna?.features["genital_order"], ":")
	var/list/true_order = getApprovedGenitalList(M, order)
	for(var/i in hud_icons)
		if(A.hud_list[i])
			for(var/genit in true_order)
				var/list/untyped_genitals = A.hud_list[i]
				for(var/spot in untyped_genitals[genit])
					var/list/what_is_it = untyped_genitals[genit][spot] // test var pls ignore
					for(var/image/img in what_is_it)
						M.client.images |= img // i can see my house from here!

/// M is the viewer, A is the thing with the hud stuff on it, remove_list just removes the list and clears it from everyone
/datum/atom_hud/data/human/genital/remove_from_single_hud(mob/M, atom/A, send_signal) //unsafe, no sanity apart from client
	if(!M || !M.client || !A)
		return
	if(send_signal)
		SEND_SIGNAL(M, COMSIG_HUMAN_UPDATE_GENITALS)
		SEND_SIGNAL(A, COMSIG_HUMAN_UPDATE_GENITALS)
	for(var/i in hud_icons)
		var/list/untyped_genitals = A.hud_list[i]
		for(var/bit in untyped_genitals)
			for(var/spot in list("FRONT", "MID", "BEHIND"))
				var/list/nads = untyped_genitals[bit][spot]
				if(LAZYLEN(nads))
					M.client.images -= nads

	//if(remove_list)
	var/list/image_list = A.hud_list[GENITAL_HUD]
	if(islist(image_list))
		var/list/flat_list = flatten_list_recursive(image_list.Copy()) // wake up hon, its time for your penis flattening
		M.client.images -= flat_list // okah hon
	return TRUE

/datum/atom_hud/data/human/genital/proc/getApprovedGenitalList(mob/viewer, list/order)
	if(!islist(order))
		return
	if(!ismob(viewer))
		return
	var/client/clint = viewer.client
	if(!clint)
		return
	if(clint.prefs.features["genital_hide"] == NONE)
		return order
	if(clint.isGenitalWhitelisted(viewer))
		return order
	/// okay, no more exceptions...
	. = order.Copy()
	var/hideflags = clint.prefs.features["genital_hide"]
	if(CHECK_BITFIELD(hideflags, HIDE_BUTT))
		. -= CS_BUTT
	if(CHECK_BITFIELD(hideflags, HIDE_VAG))
		. -= CS_VAG
	if(CHECK_BITFIELD(hideflags, HIDE_BALLS))
		. -= CS_BALLS
	if(CHECK_BITFIELD(hideflags, HIDE_PENIS))
		. -= CS_PENIS
	if(CHECK_BITFIELD(hideflags, HIDE_BELLY))
		. -= CS_BELLY
	if(CHECK_BITFIELD(hideflags, HIDE_BOOBS))
		. -= CS_BOOB


