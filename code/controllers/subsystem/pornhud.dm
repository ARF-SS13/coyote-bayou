// A cute lil subsystem that draws pictures of peoples butts and wieners on your screen
SUBSYSTEM_DEF(pornhud)
	name = "PornHUD"
	wait = 1 SECONDS

// list of all bits
/// format: list("Jimmy Shits" = /datum/genital_images)
var/list/hoohaws = list()

/datum/controller/subsystem/pornhud/Initialize(start_timeofday)
	initialize_skins()
	. = ..()

/datum/controller/subsystem/pornhud/proc/catalogue_part(mob/living/dork, part, list/images = list())
	if(!isliving(dork) || !part)
		return
	var/datum/genital_images/GI = get_genital_datum(dork)
	GI.add_part(part, images)
	return TRUE

/// flush a player's genital images, and give them a fresh copy of everyone's
/datum/controller/subsystem/pornhud/proc/update_single_pornhud(mob/living/dork)
	if(!dork.client)
		return
	var/datum/preferences/P = extract_prefs(dork)
	if(!P)
		return
	for(var/mobname in hoohaws)
		var/datum/genital_images/GI = hoohaws[mobname]
		dork.client.images -= GI.old_image_cache
		GI.old_image_cache = list()
		var/hideflags = P.features["hide_genitals"]
		if(GI.is_whitelisted())
			hideflags = NONE
		var/list/all_genital_images = GI.get_all_images(P)
		dork.client.images += all_genital_images
		GI.old_image_cache







/datum/genital_images
	var/datum/weakref/owner
	var/list/whitelist = list()

	var/list/butt = list()
	var/butt_visible
	var/butt_priority = 7

	var/list/breasts = list()
	var/breasts_visible
	var/breasts_priority = 9

	var/list/peen = list()
	var/peen_visible
	var/peen_priority = 6

	var/list/balls = list()
	var/balls_visible
	var/balls_priority = 5

	var/list/vag = list()
	var/vag_visible
	var/vag_priority = 4

	var/list/belly = list()
	var/belly_visible
	var/belly_priority = 8

	var/list/tail = list() // nice and suggestive
	var/tail_visible

	var/list/wings = list() // dingo wings
	var/wings_visible

	var/image/undershirt
	var/shirt_visible

	var/image/underpants
	var/underpants_visible

	var/image/socks
	var/socks_visible

	var/undies_over_genitals = TRUE

	/// massive, unwashed list of all images that were on the player at some point
	/// pruned? why? not like we'd be using that ram for anything else
	var/list/old_image_cache = list()

/// is this player whitelisted?
/// if so, they can see genitals even if they're hidden
/datum/genital_images/proc/is_whitelisted(mob/someone)
	if(!someone || !someone.client)
		return FALSE
	for(var/entry in whitelist)
		entry = ckey(entry)
		if(findtext(ckey(someone.real_name), entry))
			return TRUE
		if(findtext(entry, ckey(someone.real_name)))
			return TRUE
		if(findtext(ckey(someone.name), entry))
			return TRUE
		if(findtext(entry, ckey(someone.name)))
			return TRUE
	
/datum/genital_images/proc/update_whitelist(whitestring) // the white string is cum
	whitelist = splittext(whitestring, ",")
	var/datum/preferences/P = extract_prefs(owner)
	P.genital_whitelist = whitestring
	P.save_preferences()
	to_chat(P.parent, span_green("Your genital whitelist has been saved!"))

/datum/genital_images/proc/edit_whitelist()
	var/mob/myowner = GET_WEAKREF(owner)
	if(!myowner)
		return
	var/datum/preferences/P = extract_prefs(myowner)
	if(!P)
		return
	var/def = P.genital_whitelist
	var/ultimatelifeform = input(
		myowner,
		"Enter a list of names (or parts of names) of folk you are comfortable with seeing their genitals. Separate names with commas, partial names match anyone whose name contains it.",
		"Let's see some genitals!",
		default = def
	)
	if(!ultimatelifeform)
		to_chat(myowner, span_notice("Never mind!"))
		return
	update_whitelist(ultimatelifeform)

// add a part to the list
/datum/genital_images/proc/add_part(part, list/images = list())
	if(!islist(images))
		images = list()
	switch(part)
		if("GENITAL_HUD_BUTT")
			butt = images
		if("GENITAL_HUD_BREASTS")
			breasts = images
		if("GENITAL_HUD_PEEN")
			peen = images
		if("GENITAL_HUD_BALLS")
			balls = images
		if("GENITAL_HUD_VAG")
			vag = images
		if("GENITAL_HUD_BELLY")
			belly = images
		if("GENITAL_HUD_TAIL")
			tail = images
		if("GENITAL_HUD_WINGS")
			wings = images
	old_image_cache |= images

/datum/genital_images/proc/add_shirt(image/pic)
	undershirt = pic
	old_image_cache |= pic

/datum/genital_images/proc/add_pants(image/pic)
	underpants = pic
	old_image_cache |= pic

/datum/genital_images/proc/add_socks(image/pic)
	socks = pic
	old_image_cache |= pic

/datum/genital_images/proc/update_visibility(part, on_off)
	switch(part)
		if("butt")
			butt_visible = on_off
		if("breasts")
			breasts_visible = on_off
		if("peen")
			peen_visible = on_off
		if("balls")
			balls_visible = on_off
		if("vag")
			vag_visible = on_off
		if("belly")
			belly_visible = on_off
		if("tail")
			tail_visible = on_off
		if("wings")
			wings_visible = on_off
		if("shirt")
			shirt_visible = on_off
		if("pants")
			underpants_visible = on_off
		if("socks")
			socks_visible = on_off

/datum/genital_images/proc/get_all_images(preflag)
	if(!P)
		return list()
	var/list/image_order = get_image_order()
	var/list/all_images = list()
	for(var/entry in image_order)
		switch(entry)
			if("butt")
				if(butt_visible && !CHECK_BITFIELD(preflag, HIDE_BUTT))
					all_images += butt
			if("breasts")
				if(breasts_visible && !CHECK_BITFIELD(preflag, HIDE_BREASTS))
					all_images += breasts
			if("peen")
				if(peen_visible && !CHECK_BITFIELD(preflag, HIDE_PEEN))
					all_images += peen
			if("balls")
				if(balls_visible && !CHECK_BITFIELD(preflag, HIDE_BALLS))
					all_images += balls
			if("vag")
				if(vag_visible && !CHECK_BITFIELD(preflag, HIDE_VAG))
					all_images += vag
			if("belly")
				if(belly_visible && !CHECK_BITFIELD(preflag, HIDE_BELLY))
					all_images += belly
	if(undershirt && shirt_visible)
		all_images += undershirt
	if(underpants && underpants_visible)
		all_images += underpants
	if(socks && socks_visible)
		all_images += socks
	if(tail && tail_visible)
		all_images += tail
	if(wings && wings_visible)
		all_images += wings
	var/mob/myowner = GET_WEAKREF(owner)
	for(var/image/img in all_images)
		img.loc = myowner // just to be sure they're stuck to the player like a fridge magnet
	return all_images







/datum/genital_images/proc/get_image_order()
	var/list/key = list(
		"[butt_priority]" = "butt",
		"[breasts_priority]" = "breasts",
		"[peen_priority]" = "peen",
		"[balls_priority]" = "balls",
		"[vag_priority]" = "vag",
		"[belly_priority]" = "belly",
	)
	var/list/priorities = list(
		butt_priority,
		breasts_priority,
		peen_priority,
		balls_priority,
		vag_priority,
		belly_priority,
		)
	var/list/ascending = sort_list(priorities, /proc/cmp_numeric_asc)
	var/list/out = list()
	for(var/priority in ascending)
		var/part = key[priority]
		out += part
	return out


