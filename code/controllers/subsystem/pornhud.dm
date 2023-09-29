// A cute lil subsystem that draws pictures of peoples butts and wieners on your screen
SUBSYSTEM_DEF(pornhud)
	name = "PornHUD"
	wait = 0.2 SECONDS

	// list of all bits
	/// format: list("Jimmy Shits" = /datum/genital_images)
	var/list/hoohaws = list()
	var/image_cache_max = 1024
	var/update_pending = FALSE
	var/debug_clotheshud = TRUE

/datum/controller/subsystem/pornhud/fire(resumed)
	if(update_pending)
		for(var/mob/living/carbon/human/nadhaver in GLOB.human_list)
			nadhaver.update_body(TRUE)
		update_everyone()
		update_pending = FALSE

/datum/controller/subsystem/pornhud/proc/pend_update()
	update_pending = TRUE

/datum/controller/subsystem/pornhud/proc/catalogue_part(mob/living/dork, part, list/images = list())
	if(!isliving(dork) || !part)
		return
	var/datum/genital_images/GI = get_genital_datum(dork)
	GI.add_part(part, images)
	return TRUE

/datum/controller/subsystem/pornhud/proc/get_genital_datum(mob/living/carbon/human/dork)
	if(!ishuman(dork))
		return
	if(!dork.pornhud_key)
		generate_key(dork)
	var/datum/genital_images/GI = LAZYACCESS(hoohaws, dork.pornhud_key)
	if(!GI)
		GI = new /datum/genital_images(dork)
		hoohaws[dork.pornhud_key] = GI
	return GI

/// flush a player's genital images, and give them a fresh copy of everyone's
/// This is the *viewer*, so it'll pull everyone's images
/datum/controller/subsystem/pornhud/proc/update_single(mob/living/dork)
	if(!dork.client)
		return
	var/datum/preferences/P = extract_prefs(dork)
	if(!P)
		return
	for(var/mobname in hoohaws)
		var/datum/genital_images/GI = hoohaws[mobname]
		GI.show_images_to(dork)

/// Flushed everyone's genital images, and gives them a fresh copy of everyone's
/datum/controller/subsystem/pornhud/proc/update_everyone(hard)
	for(var/mob/living/carbon/human/nadhaver in GLOB.human_list)
		update_single(nadhaver, hard)

/datum/controller/subsystem/pornhud/proc/flush_genitals(mob/living/carbon/human/flusher)
	if(!ishuman(flusher))
		return
	var/datum/genital_images/GI = get_genital_datum(flusher)
	if(!GI)
		return
	GI.flush_genitals()

/datum/controller/subsystem/pornhud/proc/flush_undies(mob/living/carbon/human/flusher)
	if(!ishuman(flusher))
		return
	var/datum/genital_images/GI = get_genital_datum(flusher)
	if(!GI)
		return
	GI.flush_genitals()

/datum/controller/subsystem/pornhud/proc/update_visibility(mob/living/carbon/human/dork, part, on_off)
	if(!ishuman(dork))
		return
	var/datum/genital_images/GI = get_genital_datum(dork)
	if(!GI)
		return
	GI.update_visibility(part, on_off)

/datum/controller/subsystem/pornhud/proc/generate_key(mob/living/carbon/human/newnadhaver)
	if(!ishuman(newnadhaver))
		return
	if(newnadhaver.pornhud_key)
		return
	var/key = newnadhaver.ckey ? "[newnadhaver.ckey]-" : "stiff-"
	key += "[LAZYLEN(hoohaws) + 1]-"
	key += "[newnadhaver.real_name]-"
	key += "[world.time]-bepis"
	newnadhaver.pornhud_key = key
	return key

// scornhud
/mob/living/carbon/human
	var/pornhud_key

/// Holds all the genital images of a single human mob
/// This is the *owner*, so it'll only pull their own images
/// also defines if they're visible or not
/// get_all_images() will return a list of all images that should be visible
/// It'll not send images that the viewer has set to be hidden
/datum/genital_images
	var/datum/weakref/owner

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

/datum/genital_images/New(mob/living/carbon/human/newowner)
	. = ..()
	owner = WEAKREF(newowner)
	var/datum/preferences/P = extract_prefs(newowner)
	if(!P)
		return

/// is this player whitelisted?
/// if so, they can see genitals even if they're hidden
/datum/genital_images/proc/is_whitelisted(mob/someone)
	if(!someone || !someone.client)
		return FALSE
	if(someone == GET_WEAKREF(owner))
		return TRUE // surely you'd like to see your own genitals (or lack thereof)
	var/datum/preferences/P = extract_prefs(someone)
	var/list/whitelist = splittext(P.genital_whitelist, ",")
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
	
// Updates out owner's appearance
/datum/genital_images/proc/update_owner_appearance(broadcast)
	var/mob/living/carbon/human/myowner = GET_WEAKREF(owner)
	if(!myowner)
		return
	myowner.update_body(TRUE)
	if(broadcast)
		SSpornhud.pend_update()

// add a part to the list
/datum/genital_images/proc/add_part(part, list/images = list())
	if(!islist(images))
		images = list()
	switch(part)
		if(PHUD_BUTT)
			butt = images
		if(PHUD_BOOB)
			breasts = images
		if(PHUD_PENIS)
			peen = images
		if(PHUD_BALLS)
			balls = images
		if(PHUD_VAG)
			vag = images
		if(PHUD_BELLY)
			belly = images
		if(PHUD_TAIL)
			tail = images
		if(PHUD_WINGS)
			wings = images
		if(PHUD_SHIRT)
			undershirt = images
		if(PHUD_PANTS)
			underpants = images
		if(PHUD_SOCKS)
			socks = images
	cache_images(images)
	SSpornhud.pend_update()

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
		if(PHUD_BUTT)
			butt_visible = on_off
		if(PHUD_BOOB)
			breasts_visible = on_off
		if(PHUD_PENIS)
			peen_visible = on_off
		if(PHUD_BALLS)
			balls_visible = on_off
		if(PHUD_VAG)
			vag_visible = on_off
		if(PHUD_BELLY)
			belly_visible = on_off
		if(PHUD_TAIL)
			tail_visible = on_off
		if(PHUD_WINGS)
			wings_visible = on_off
		if(PHUD_SHIRT)
			shirt_visible = on_off
		if(PHUD_PANTS)
			underpants_visible = on_off
		if(PHUD_SOCKS)
			socks_visible = on_off

/datum/genital_images/proc/cache_images(list/imgs = list())
	old_image_cache |= imgs
	if(LAZYLEN(old_image_cache) >= SSpornhud.image_cache_max)
		var/num_to_remove = LAZYLEN(old_image_cache) - SSpornhud.image_cache_max
		if(num_to_remove > 1)
			old_image_cache.Cut(1, num_to_remove)

/datum/genital_images/proc/show_images_to(mob/seer)
	if(!seer || !seer.client)
		return // they cant see us!
	seer.client.images -= old_image_cache
	seer.client.images |= get_all_images(extract_prefs(seer))

/datum/genital_images/proc/get_all_images(datum/preferences/P)
	if(!P)
		return list()
	var/mob/living/carbon/human/myowner = GET_WEAKREF(owner)
	if(!ishuman(myowner))
		return list()
	var/list/cockstring = myowner.dna.decode_cockstring()
	var/list/image_order = reverseList(cockstring)
	var/preflag = is_whitelisted(P.parent.mob) ? NONE : P.features["genital_hide"]
	var/list/all_images = list()
	for(var/entry in image_order)
		switch(entry)
			if(CS_BUTT)
				if(butt_visible && !CHECK_BITFIELD(preflag, HIDE_BUTT))
					all_images += butt
			if(CS_BOOB)
				if(breasts_visible && !CHECK_BITFIELD(preflag, HIDE_BOOBS))
					all_images += breasts
			if(CS_PENIS)
				if(peen_visible && !CHECK_BITFIELD(preflag, HIDE_PENIS))
					all_images += peen
			if(CS_BALLS)
				if(balls_visible && !CHECK_BITFIELD(preflag, HIDE_BALLS))
					all_images += balls
			if(CS_VAG)
				if(vag_visible && !CHECK_BITFIELD(preflag, HIDE_VAG))
					all_images += vag
			if(CS_BELLY)
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
	for(var/image/img in all_images)
		img.loc = myowner // just to be sure they're stuck to the player like a fridge magnet
	return all_images

/datum/genital_images/proc/flush_genitals()
	cache_images(get_all_images())
	butt = list()
	breasts = list()
	peen = list()
	balls = list()
	vag = list()
	belly = list()
	return TRUE

/datum/genital_images/proc/flush_undies()
	cache_images(get_all_images())
	undershirt = null
	underpants = null
	socks = null
	return TRUE



