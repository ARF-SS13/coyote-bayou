SUBSYSTEM_DEF(gun_sprites)
	name = "GunSprites"
	flags = SS_BACKGROUND|SS_NO_FIRE|SS_NO_INIT
	init_order = INIT_ORDER_CMLS

	var/num_ammo_states = 0

	var/list/guns = list()

/datum/controller/subsystem/gun_sprites/proc/RegisterGunSprites(obj/item/gun/ballistic/gun)
	if(!gun || !gun.use_gun_sprite_handler)
		return // opt out
	var/base = gun.icon_state_base || initial(gun.icon_state)
	gun.icon_state_base = base
	if(LAZYACCESS(guns, base))
		return TRUE // already registered
	var/datum/gun_sprite_handler/gsh = new(gun)
	guns[base] = gsh

/datum/controller/subsystem/gun_sprites/proc/SkinGun(obj/item/gun/ballistic/gun)
	if(!gun || !gun.icon_state_base)
		return // not registered
	var/base = gun.icon_state_base || initial(gun.icon_state)
	var/datum/gun_sprite_handler/gsh = LAZYACCESS(guns, base)
	if(!gsh)
		return // not registered
	var/icon = gsh.GetIcon(gun)
	var/icon_state = gsh.GetIconState(gun)
	if(!icon || !icon_state)
		return // something went wrong
	gun.icon = icon
	gun.icon_state = icon_state
	return TRUE

/// handles all the sprites and such for a specific base icon state for an icon state for a ballistic gun
/// PRETTY DARN SPECIFIC HUH? well, ammo sux
/datum/gun_sprite_handler
	var/base_state
	var/icon/icon
	/// states, if it doesnt have a capacity_states entry
	var/datum/gun_sprite_cache/stock = new()
	/// for guns set to have different sprites for different capacities
	var/list/capacity_states = list()
	var/broken = FALSE

/datum/gun_sprite_handler/New(obj/item/gun/ballistic/gun)
	ExtractSprites(gun)
	if(broken)
		gun.use_gun_sprite_handler = FALSE
		message_admins("GunSpriteHandler broke for [gun]! Check the code!")
		CRASH("GunSpriteHandler broke for [gun]! Check the code!")

/datum/gun_sprite_handler/proc/ExtractSprites(obj/item/gun/ballistic/gun)
	base_state = initial(gun.icon_state)
	icon = initial(gun.icon)
	gun.icon_state_base = base_state
	/// and now, the fun begins
	/// SO. gun icon_states tend (and I do mean TEND) to follow a pattern of "gunname" and "gunname-e"
	/// but, they may also have a maga capacity associated, like "gunname-10" or "gunname-10-e"
	/// we will automatically check for all these, and determine what system we'll use accordingly
	var/list/states = icon_states(icon)
	if(!LAZYLEN(states))
		gun.use_gun_sprite_handler = FALSE
		broken = TRUE
		return
	for(var/state in states)
		if(!findtext(state, "[base_state]"))
			continue // not ours
		if(state == "[base_state]") // found the base state, usually the full state
			stock.default = state
			stock.closed_loaded = state
			stock.closed_unloaded = state
			continue
		if(state == "[base_state]-e") // found the empty state
			/// generally an open, unloaded state, though a lot of them use it for any state other than full and ready
			stock.open_unloaded = state
			stock.open_loaded = state
			continue
		/// now, we check for capacity states
		var/list/substates = splittext(state, "-")
		/// we cant rely on number-e to be the second and third entries, cus some jokers love to put dashes wherever
		/// but we can rely on them to be the last two entries
		if(LAZYLEN(substates) < 2)
			continue // good job
		var/lastie = LAZYACCESS(substates, LAZYLEN(substates))
		var/lastie2 = LAZYACCESS(substates, LAZYLEN(substates) - 1)
		var/numlastie = text2num(lastie)
		if(isnum(numlastie)) // a loaded, closed capacity state
			var/datum/gun_sprite_cache/gsc = LAZYACCESS(capacity_states, lastie)
			if(!gsc)
				gsc = new()
				capacity_states[lastie] = gsc
			gsc.closed_loaded = state
			continue
		var/numlastie2 = text2num(lastie2)
		if(isnum(numlastie2)) // a loaded, open capacity state
			var/datum/gun_sprite_cache/gsc = LAZYACCESS(capacity_states, lastie2)
			if(!gsc)
				gsc = new()
				capacity_states[lastie2] = gsc
			gsc.open_loaded = state
			continue
	/// and now, sanitize everything so that we have a full set of states
	SanitizeStates()

/datum/gun_sprite_handler/proc/SanitizeStates()
	var/list/states = icon_states(icon)
	if(!stock)
		stock = new()
		stock.default = base_state
	if(!stock.closed_loaded)
		if("[base_state]" in states) // better be
			ErrorState() // oh no! break!
			return
		stock.closed_loaded = "[base_state]"
	if(!stock.open_unloaded)
		if("[base_state]-e" in states)
			stock.open_unloaded = "[base_state]-e"
		else
			stock.open_unloaded = base_state
	if(!stock.closed_unloaded)
		stock.closed_unloaded = stock.open_unloaded
	if(!stock.open_loaded)
		stock.open_loaded = stock.closed_loaded
	if(LAZYLEN(capacity_states) == 1)
		/// we're gonna delete this, but extract any different states and put them in the stock
		var/datum/gun_sprite_cache/gsc = capacity_states[capacity_states[1]]
		if(gsc.closed_loaded != stock.closed_loaded)
			stock.closed_loaded = gsc.closed_loaded
		if(gsc.open_loaded != stock.open_loaded)
			stock.open_loaded = gsc.open_loaded
		if(gsc.closed_unloaded != stock.closed_unloaded)
			stock.closed_unloaded = gsc.closed_unloaded
		if(gsc.open_unloaded != stock.open_unloaded)
			stock.open_unloaded = gsc.open_unloaded
		capacity_states.Cut()
		qdel(gsc)
	if(!LAZYLEN(capacity_states))
		return
	/// now, we need to make sure that we have a full set of states for each capacity
	/// if we dont, we'll just use the stock states
	for(var/captext in capacity_states)
		var/datum/gun_sprite_cache/gsc = capacity_states[captext]
		if(!gsc.closed_loaded)
			gsc.closed_loaded = stock.closed_loaded
		if(!gsc.open_loaded)
			gsc.open_loaded = stock.open_loaded
		if(!gsc.closed_unloaded)
			gsc.closed_unloaded = stock.closed_unloaded
		if(!gsc.open_unloaded)
			gsc.open_unloaded = stock.open_unloaded
	/// and, we're done!

/// something went wrong, set everyhting to a gross error state
/datum/gun_sprite_handler/proc/ErrorState()
	icon = 'icons/obj/plushes.dmi'
	QDEL_NULL(stock)
	QDEL_LIST_ASSOC_VAL(capacity_states)
	stock = new()
	stock.default = "fermis"
	stock.closed_loaded = "fox"
	stock.open_loaded = "bird"
	stock.closed_unloaded = "sergal"
	stock.open_unloaded = "hairball"
	broken = TRUE
	/// that should be obvious enough

/// now, to give back the appropriate icon!
/datum/gun_sprite_handler/proc/GetIcon(obj/item/gun/ballistic/gun)
	if(broken)
		return // it'll handle it
	return icon

/// now, to give back the appropriate icon state!
/datum/gun_sprite_handler/proc/GetIconState(obj/item/gun/ballistic/gun)
	if(broken)
		return // it'll handle it
	var/magcap = gun.magazine ? gun.magazine.max_ammo : 0
	var/datum/gun_sprite_cache/gsc = null
	if(magcap > 0 && LAZYLEN(capacity_states))
		var/count = text2num(magcap)
		var/lowesthigher = null
		for(var/captext in capacity_states)
			var/numkey = text2num(captext)
			if(numkey > count)
				if(!lowesthigher || numkey < lowesthigher)
					lowesthigher = numkey
		if(!isnull(lowesthigher))
			gsc = capacity_states["[lowesthigher]"]
	if(!gsc)
		gsc = stock
	if(!gun.magazine)
		if(gun.chambered)
			return gsc.closed_unloaded
		else
			return gsc.open_unloaded
	if(gun.chambered)
		return gsc.closed_loaded
	else
		return gsc.open_loaded

/// i like datums more than lists (even tho its an array)
/datum/gun_sprite_cache
	var/closed_loaded = null
	var/open_loaded = null
	var/closed_unloaded = null
	var/open_unloaded = null
	var/default = null



