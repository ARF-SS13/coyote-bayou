PROCESSING_SUBSYSTEM_DEF(progress_bars)
	name = "Progress Bars"
	flags = SS_NO_INIT
	wait = 0.2 SECONDS

	/// List of bar_ids and their corresponding progress bars
	/// format: list("bar_id" = /datum/progressbar-initted)
	var/list/progbars = list()

	/// All weakrefs to atoms that are currently using progress bars
	/// Used for correctly positioning the progress bars when added/removed
	/// format: list(/datum/weakref/thing = list("bar_id"))
	var/list/atom_proglist = list()

	/// List of visible progress bars by ckey
	/// format: list(ckey = list("bar_id"))
	var/list/ckey_proglist = list()

/datum/controller/subsystem/processing/progress_bars/proc/add_bar(atom/owner, list/can_see = list(), duration, automatic)
	var/datum/progressbar/bar = new(owner, can_see, duration, automatic)
	register_bar(owner, bar)
	. = bar.bar_id
	INVOKE_ASYNC(bar, /datum/progressbar.proc/start)

/datum/controller/subsystem/processing/progress_bars/proc/remove_bar(bar_id)
	var/datum/weakref/weakbar = LAZYACCESS(progbars, bar_id)
	if(!weakbar)
		return // Already gone!
	var/datum/progressbar/bar = RESOLVEWEAKREF(weakbar)
	if(!istype(bar))
		stack_trace("Attempted to resolve non-existant progress bar with id [bar_id] for removal. Was it already removed?")
		return
	INVOKE_ASYNC(bar, /datum/progressbar.proc/stop)

/datum/controller/subsystem/processing/progress_bars/proc/destroy_bar(bar_id, update = TRUE)
	var/datum/weakref/weakbar = LAZYACCESS(progbars, bar_id)
	if(!weakbar)
		return // Already gone!
	var/datum/progressbar/bar = RESOLVEWEAKREF(weakbar)
	if(!istype(bar))
		stack_trace("Attempted to resolve non-existant progress bar with id [bar_id] for destruction. Was it already removed?")
		return
	unregister_bar(bar_id, update)
	qdel(bar)

/datum/controller/subsystem/processing/progress_bars/proc/register_bar(atom/barowner, datum/progressbar/bar)
	var/datum/weakref/owner = WEAKREF(barowner)
	if(LAZYACCESS(atom_proglist, owner))
		atom_proglist[owner] |= list(bar.bar_id)
	else
		atom_proglist[owner] = list(bar.bar_id)
	progbars[bar.bar_id] = bar
	for(var/ckey in bar.visible_to)
		if(LAZYACCESS(ckey_proglist, ckey))
			ckey_proglist[ckey] |= list(bar)
		else
			ckey_proglist[ckey] = list(bar)
	return TRUE

/datum/controller/subsystem/processing/progress_bars/proc/unregister_bar(datum/progressbar/bar, update = TRUE)
	progbars -= bar.bar_id
	for(var/ckey in bar.visible_to)
		ckey_proglist[ckey] -= bar
		if(!LAZYLEN(ckey_proglist[ckey]))
			ckey_proglist -= ckey
	for(var/thing in atom_proglist)
		atom_proglist[thing] -= bar.bar_id
		if(LAZYLEN(atom_proglist[thing]))
			if(update)
				update_bar_positions(thing)
			continue
		atom_proglist -= thing
	return TRUE

/// When a client who is supposed to see this connects, we need to show it to their client
/datum/controller/subsystem/processing/progress_bars/proc/client_connected(the_ckey)
	if(!LAZYACCESS(ckey_proglist, the_ckey))
		return
	for(var/datum/weakref/weakbar in ckey_proglist[the_ckey])
		var/datum/progressbar/bar = RESOLVEWEAKREF(weakbar)
		INVOKE_ASYNC(bar, /datum/progressbar.proc/show_bar)
	return TRUE

/datum/controller/subsystem/processing/progress_bars/proc/get_bar_index(datum/weakref/owner, bar_id)
	if(!LAZYACCESS(atom_proglist, owner))
		return
	var/list/barlist = LAZYACCESS(atom_proglist, owner)
	return barlist.Find(bar_id)

/datum/controller/subsystem/processing/progress_bars/proc/update_bar_positions(datum/weakref/owner)
	var/list/bar_ids = LAZYACCESS(atom_proglist, owner)
	for(var/barid in bar_ids)
		var/datum/progressbar/bar = LAZYACCESS(progbars, barid)
		if(!bar)
			continue
		INVOKE_ASYNC(bar, /datum/progressbar.proc/update_position, get_bar_index(owner, barid))

#define BAR_MASTER var/atom/master = display_loc?.resolve();if(!master ||(master && QDELETED(master))){master_deleted(); return}
#define PROGRESSBAR_HEIGHT 6
#define PROGRESSBAR_ANIMATION_TIME 5

/datum/progressbar
	///The progress bar visual element.
	var/image/bar
	///The place where the progress bar is shown.
	var/datum/weakref/display_loc
	///The ckeys who can see this thing.
	var/list/visible_to = list()
	///The start number of the progress bar, if progress is at this or lower, then its empty.
	var/start_num = 0
	///The goal number of the progress bar, if progress is at this or higher, then its full.
	var/goal = 1
	///Where the progress bar is currently at.
	var/progress = 0
	///Variable to ensure smooth visual stacking on multiple progress bars.
	var/listindex = 0
	///The previous icon state of the progress bar.
	var/last_icon_state
	///the bar's cool-ass ID
	var/bar_id = "butt"
	///Manually updated?
	var/auto_update = TRUE
	///Is it currently active? Visible, ect
	var/is_active = FALSE

/datum/progressbar/New(atom/location, list/can_see, goal, automatic)
	. = ..()
	if (!istype(location))
		EXCEPTION("Progress Bar needs an atom. Was given ([location]). Invalid target given")
	// if((QDELETED(User) || !istype(User)) && !visible_to_all)
	// 	stack_trace("/datum/progressbar created with [isnull(User) ? "null" : "invalid"] user")
	// 	qdel(src)
	// 	return
	// if(!isnum(goal_number))
	// 	stack_trace("/datum/progressbar created with [isnull(User) ? "null" : "invalid"] goal_number")
	// 	qdel(src)
	// 	return
	// if(visible_to_all)
	// 	bar.plane = HUD_PLANE - 100
	// else
	// 	bar.plane = ABOVE_HUD_PLANE
	src.goal = goal
	auto_update = automatic
	generate_bar_id()
	register_visibility(can_see)
	RegisterSignal(location, COMSIG_PARENT_QDELETING, .proc/master_deleted)
	display_loc = WEAKREF(location)

	// LAZYADDASSOC(user.progressbars, display_loc, src)
	// var/list/bars = user.progressbars[display_loc]
	// listindex = bars.len

	// if(user.client)
	// 	user_client = user.client
	// 	add_prog_bar_image_to_client()

/datum/progressbar/proc/register_visibility(list/can_see)
	if(!LAZYLEN(can_see))
		for(var/ckey in GLOB.directory)
			visible_to |= ckey
		return
	for(var/seer in can_see)
		if(istext(seer) && GLOB.directory[seer])
			visible_to |= ckey(seer)
			continue
		if(ismob(seer))
			var/mob/mb = seer
			if(mb.client)
				visible_to |= mb.client.ckey
			continue
		if(isclient(seer))
			var/client/clint = seer
			visible_to += clint.ckey

/datum/progressbar/proc/start()
	make_bar()
	add_bar_to_seeing_clients(visible_to)
	show_bar()
	is_active = TRUE
	if(auto_update)
		start_num = world.time
		goal = world.time + goal
		START_PROCESSING(SSprogress_bars, src)

/// Distributes the progress bar to all clients who can see it.
/datum/progressbar/proc/add_bar_to_seeing_clients(list/seeing = visible_to)
	for(var/ck in seeing)
		var/client/clint = GLOB.directory[ck]
		if(!isclient(clint))
			continue
		add_bar_to_client(clint)

/// Adds the progress bar to a client's screen.
/datum/progressbar/proc/add_bar_to_client(client/clint)
	if(!clint)
		return
	clint.images |= bar

/// removes the progress bar to a client's screen.
/datum/progressbar/proc/remove_bar_from_client(client/clint)
	if(!clint)
		return
	clint.images -= bar

/// Makes the progress bar visible, and shoot up to where it should be.
/datum/progressbar/proc/make_bar()
	BAR_MASTER
	bar = image('icons/effects/progessbar.dmi', master, "prog_bar_0")
	bar.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	bar.plane = master.plane + 100
	bar.pixel_y = 0
	bar.alpha = 0

/// Makes the progress bar visible, and shoot up to where it should be.
/datum/progressbar/proc/show_bar()
	animate(bar, pixel_y = get_dist_to_travel(), alpha = 255, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

/datum/progressbar/proc/get_dist_to_travel()
	BAR_MASTER
	var/index = SSprogress_bars.get_bar_index(display_loc, bar_id)
	return 32 + (PROGRESSBAR_HEIGHT * (index - 1))

/datum/progressbar/proc/update_position(index)
	BAR_MASTER
	var/dist_to_travel = 32 + (PROGRESSBAR_HEIGHT * (index - 1)) - PROGRESSBAR_HEIGHT
	animate(bar, pixel_y = dist_to_travel, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

/datum/progressbar/proc/stop()
	is_active = FALSE
	STOP_PROCESSING(SSprogress_bars, src)
	if(progress >= 90)
		success_bar()
	else
		fail_bar()
	SSprogress_bars.destroy_bar(bar_id, TRUE)

/datum/progressbar/proc/success_bar()
	bar.alpha = 255
	animate(bar, pixel_y = 0, alpha = 0, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)
	bar.icon_state = "prog_bar_0"
	
///Called on progress end, be it successful or a failure. Wraps up things to delete the datum and bar.
/datum/progressbar/proc/fail_bar()
	bar.alpha = 255
	animate(bar, alpha = 0, color = "#FF0000", time = PROGRESSBAR_ANIMATION_TIME)

/datum/progressbar/proc/master_deleted()
	SIGNAL_HANDLER
	SSprogress_bars.destroy_bar(bar_id, FALSE) // calls qdel

/datum/progressbar/proc/generate_bar_id()
	bar_id = "prog_bar_[world.time]_[rand(0, 1000000)]_[rand(0, 1000000)]"
	return TRUE

/// Only used on automatic progress bars. Updates the progress bar to the current time
/datum/progressbar/process()
	if(!auto_update)
		return
	progress = world.time
	update(world.time - start_num)

///Updates the progress bar image visually.
/datum/progressbar/proc/update(progress)
	if(!is_active)
		return
	var/newstate = round(((clamp(progress, 0, goal) / goal) * 100), 5)
	bar.icon_state = "prog_bar_[newstate]"

/datum/progressbar/Destroy()
	// if(user)
	// 	for(var/pb in user.progressbars[display_loc])
	// 		var/datum/progressbar/progress_bar = pb
	// 		if(progress_bar == src || progress_bar.listindex <= listindex)
	// 			continue
	// 		progress_bar.listindex--

	// 		progress_bar.bar.pixel_y = 32 + (PROGRESSBAR_HEIGHT * (progress_bar.listindex - 1))
	// 		var/dist_to_travel = 32 + (PROGRESSBAR_HEIGHT * (progress_bar.listindex - 1)) - PROGRESSBAR_HEIGHT
	// 		animate(progress_bar.bar, pixel_y = dist_to_travel, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

	// 	LAZYREMOVEASSOC(user.progressbars, display_loc, src)
	// 	user = null

	// if(user_client)
	// 	clean_user_client()

	for(var/ck in visible_to)
		for(var/client/clint in GLOB.directory[ck])
			if(!clint.mob)
				continue
			remove_bar_from_client(clint)
	display_loc = null
	if(bar)
		QDEL_NULL(bar)
	return ..()

/obj/item/grenade/debug_dynamite
	name = "Debug progress bar grenade"
	desc = "A grenade that creates a progress bar on itself. Hopefully this works."
	icon = 'icons/fallout/objects/guns/explosives.dmi'
	icon_state = "dynamite"
	preprime_sound = 'sound/effects/fuse.ogg'
	ex_dev = 0
	ex_heavy = 0
	ex_light = 1
	ex_flame = 0
	det_time = 5 SECONDS

/obj/item/grenade/debug_dynamite/preprime(mob/user, delayoverride, msg = TRUE, volume = 60)
	SSprogress_bars.add_bar(src, list(), det_time, TRUE)
	. = ..()

/obj/item/storage/box/debug_progbar
	name = "debug dynamite crate"
	desc = "A box full of devshit!"
	icon_state = "box_brown"
	illustration = "loose_ammo"

/obj/item/storage/box/debug_progbar/PopulateContents()
	. = ..()
	new /obj/item/grenade/debug_dynamite(src)
	new /obj/item/grenade/debug_dynamite(src)
	new /obj/item/grenade/debug_dynamite(src)
	new /obj/item/grenade/debug_dynamite(src)
	new /obj/item/grenade/debug_dynamite(src)
	new /obj/item/grenade/debug_dynamite(src)
	new /obj/item/grenade/debug_dynamite(src)

///Removes the progress bar image from the user_client and nulls the variable, if it exists.
// /datum/progressbar/proc/clean_user_client(datum/source)
// 	SIGNAL_HANDLER

// 	if(!user_client) //Disconnected, already gone.
// 		return
// 	user_client.images -= bar
// 	user_client = null


// ///Called by user's Login(), it transfers the progress bar image to the new client.
// /datum/progressbar/proc/on_user_login(datum/source)
// 	SIGNAL_HANDLER

// 	if(user_client)
// 		if(user_client == user.client) //If this was not client handling I'd condemn this sanity check. But clients are fickle things.
// 			return
// 		clean_user_client()
// 	if(!user.client) //Clients can vanish at any time, the bastards.
// 		return
// 	user_client = user.client
// 	add_prog_bar_image_to_client()




// /datum/progressbar/proc/set_new_goal(newgoal)
// 	goal = newgoal
// 	last_progress = 0
// 	update(0)




#undef PROGRESSBAR_ANIMATION_TIME
#undef PROGRESSBAR_HEIGHT

