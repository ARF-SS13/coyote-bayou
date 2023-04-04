// Yes, a genital subsystem
SUBSYSTEM_DEF(genitals)
	name = "Genitals"
	flags = SS_NO_INIT | SS_BACKGROUND
	wait = 10 SECONDS

/* 
 *the master list of genitals by ckey
 * format list("ckey" = /datum/genital_display)
 * A FEW ASSUMPTIONS:
 * All genital havers are human
 * All genital havers have a ckey (at some point)
 * All humans are in GLOB.humans_list
 * All viewers are clients
 * All clients have prefs
 * All clients have a list of ckeys they except
 */
var/list/genital_sprites_by_mob = list()

/// Expects a list formated like list("genital_flag" = list(img, img, img), "genital_flag2" = list(img, img, img))
/datum/controller/subsystem/genitals/proc/updateGenitalList(list/nadlist, ckey, mob/living/carbon/human/haver)
	if(!LAZYLEN(nadlist) || !ckey)
		return
	genital_sprites_by_mob[ckey] = list()
	genital_sprites_by_mob[ckey][]
	broadcastGenitals()
	
/// Holds a ckey, some mob weakrefs, several lists of genitals, their ordering
/datum/genital_display
	var/key
	var/list/mobrefs = list()
	var/list/penis = list()
	var/list/vag = list()
	var/list/balls = list()
	var/list/butt = list()
	var/list/belly = list()
	var/list/boobs = list()
	var/list/order = list()

/datum/genital_display/New(newkey)
	if(!newkey)
		qdel(src)
	key = newkey

/datum/genital_display/proc/clearOverlays()
	for(var/client/clent in GLOB.clients)
		clent.images -= penis
		clent.images -= vag
		clent.images -= balls
		clent.images -= butt
		clent.images -= belly
		clent.images -= boobs
	penis.Cut()
	vag.Cut()
	balls.Cut()
	butt.Cut()
	belly.Cut()
	boobs.Cut()

/datum/genital_display/proc/applyOverlays(client/just_me)
	for(var/datum/weakref/nadhaver in mobrefs)
		var/mob/living/carbon/human/crotchum = nadhaver.resolve()
		if(!crotchum)
			continue
		if(QDELETED(crotchum))
			continue
		for(var/part in order)
			switch(part)


/* 	var/list/clunts = istype(just_me) ? list(just_me) : GLOB.clients.Copy()
	for(var/client/clent in clunts)
		for(var/nad in getApprovedGenitalList(clent))
			switch(nad)
				if(CS_PENIS)
					clent.images |= penis
				if(CS_VAG)
					clent.images |= vag
				if(CS_BALLS)
					clent.images |= balls
				if(CS_BUTT)
					clent.images |= butt
				if(CS_BELLY)
					clent.images |= belly
				if(CS_BOOB)
					clent.images |= boobs */

/datum/genital_display/proc/update(list/genitals, mob/owner)
	clearOverlays()
	penis |= genitals[CS_PENIS]
	vag |= genitals[CS_VAG]
	balls |= genitals[CS_BALLS]
	butt |= genitals[CS_BUTT]
	belly |= genitals[CS_BELLY]
	boobs |= genitals[CS_BOOB]
	for(var/image/img in penis + vag + balls + butt + belly + boobs)
		img.loc = owner
	mobrefs |= WEAKREF(owner)
	order = splittext(owner?.dna?.features["genital_order"], ":")
	applyOverlays()

/datum/genital_display/proc/getApprovedGenitalList(client/clint)
	if(!clint)
		return
	//if(ckey == clint.ckey)
	//	return order
	if(ckey in clint.genital_exceptions)
		return order
	if(mobrefs & clint.genital_exceptions_weakrefs)
		return order
	if(clint.prefs.feature["genital_hide"] == NONE)
		return order
	/// okay, no more exceptions...
	. = order.Copy()
	var/hideflags = clint.prefs.feature["genital_hide"]
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

