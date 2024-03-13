PROCESSING_SUBSYSTEM_DEF(progress_bars)
	name = "ProgBars" // jitter jitter jitter
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

	var/debug_make_visible_to_everyone = FALSE

/datum/controller/subsystem/processing/progress_bars/proc/add_bar(atom/owner, list/can_see = list(), duration = 5 SECONDS, automatic = TRUE, auto_remove = TRUE)
	if(duration <= 0) // imma divide your zero uwu
		return FALSE // gotta do it safely tho
	var/datum/progressbar/bar = new(owner, can_see, duration, automatic, auto_remove)
	register_bar(owner, bar)
	. = bar.bar_id
	INVOKE_ASYNC(bar, TYPE_PROC_REF(/datum/progressbar,start))

/datum/controller/subsystem/processing/progress_bars/proc/remove_bar(bar_id)
	var/datum/progressbar/bar = LAZYACCESS(progbars, bar_id)
	if(!istype(bar))
		return
	INVOKE_ASYNC(bar, TYPE_PROC_REF(/datum/progressbar,stop))

/datum/controller/subsystem/processing/progress_bars/proc/update_bar(bar_id, number)
	var/datum/progressbar/bar = LAZYACCESS(progbars, bar_id)
	if(!istype(bar))
		return FALSE
	INVOKE_ASYNC(bar, TYPE_PROC_REF(/datum/progressbar,update), number)
	return number

/datum/controller/subsystem/processing/progress_bars/proc/check_bar(bar_id)
	var/datum/progressbar/bar = LAZYACCESS(progbars, bar_id)
	if(!istype(bar))
		return FALSE
	return bar.last_progress

/datum/controller/subsystem/processing/progress_bars/proc/bar_exists(bar_id)
	if(!bar_id)
		return FALSE
	return LAZYACCESS(progbars, bar_id)

/datum/controller/subsystem/processing/progress_bars/proc/destroy_bar(bar_id, update = TRUE)
	var/datum/progressbar/bar = LAZYACCESS(progbars, bar_id)
	if(!istype(bar))
		return
	unregister_bar(bar, update)
	QDEL_IN(bar, bar.end_animation_time)

/datum/controller/subsystem/processing/progress_bars/proc/register_bar(atom/barowner, datum/progressbar/bar)
	var/datum/weakref/owner = WEAKREF(barowner)
	progbars[bar.bar_id] = bar
	if(LAZYACCESS(atom_proglist, owner))
		atom_proglist[owner] |= bar.bar_id
	else
		atom_proglist[owner] = list(bar.bar_id)
	for(var/ckey in bar.visible_to)
		if(LAZYACCESS(ckey_proglist, ckey))
			ckey_proglist[ckey] |= bar.bar_id
		else
			ckey_proglist[ckey] = list(bar.bar_id)
	return TRUE

/datum/controller/subsystem/processing/progress_bars/proc/unregister_bar(datum/progressbar/bar, update = TRUE)
	progbars -= bar.bar_id
	for(var/ckey in bar.visible_to)
		ckey_proglist[ckey] -= bar.bar_id
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
		INVOKE_ASYNC(bar, TYPE_PROC_REF(/datum/progressbar,show_bar))
	return TRUE

/// When a client who is supposed to see this connects, we need to show it to their client
/datum/controller/subsystem/processing/progress_bars/proc/add_viewer(bar_id, the_ckey)
	var/datum/progressbar/bar = LAZYACCESS(progbars, bar_id)
	if(!istype(bar))
		return
	bar.visible_to |= the_ckey
	if(LAZYACCESS(ckey_proglist, the_ckey))
		ckey_proglist[the_ckey] |= bar.bar_id
	else
		ckey_proglist[the_ckey] = list(bar.bar_id)
	bar.add_bar_to_seeing_clients()
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
		INVOKE_ASYNC(bar, TYPE_PROC_REF(/datum/progressbar,update_position), get_bar_index(owner, barid))

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
	var/start_time = 0
	///The goal number of the progress bar, if progress is at this or higher, then its full.
	var/goal = 1
	///Where the progress bar is currently at.
	var/last_progress = 0
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
	///Auto-remove itself when time's up?
	var/auto_remove = TRUE
	/// How long it takes to play the end-animation
	var/end_animation_time = PROGRESSBAR_ANIMATION_TIME

/datum/progressbar/New(atom/location, list/can_see, goal, automatic = TRUE, autoremove = TRUE)
	. = ..()
	if (!istype(location))
		EXCEPTION("Progress Bar needs an atom. Was given ([location]). Invalid target given")
	src.goal = goal
	auto_update = automatic
	auto_remove = autoremove
	start_time = world.time
	display_loc = WEAKREF(location)
	generate_bar_id()
	register_visibility(can_see)
	RegisterSignal(location, COMSIG_PARENT_QDELETING,PROC_REF(master_deleted))

/datum/progressbar/proc/register_visibility(list/can_see)
	if(!LAZYLEN(can_see) || SSprogress_bars.debug_make_visible_to_everyone) // heh
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
		START_PROCESSING(SSprogress_bars, src)

/// Distributes the progress bar to all clients who can see it.
/datum/progressbar/proc/add_bar_to_seeing_clients(list/seeing = visible_to)
	for(var/ck in seeing)
		var/client/clint = GLOB.directory[ck]
		if(!isclient(clint))
			continue
		add_bar_to_client(clint)

/// Distributes the progress bar to all clients who can see it.
/datum/progressbar/proc/remove_bar_from_seeing_clients()
	for(var/ck in visible_to)
		var/client/clint = GLOB.directory[ck]
		if(!isclient(clint))
			continue
		remove_bar_from_client(clint)

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
	bar.pixel_y = 32
	bar.alpha = 0

/// Makes the progress bar visible, and shoot up to where it should be.
/datum/progressbar/proc/show_bar()
	animate(bar, pixel_y = get_dist_to_travel(), alpha = 255, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

/datum/progressbar/proc/get_dist_to_travel()
	var/index = SSprogress_bars.get_bar_index(display_loc, bar_id)
	return 32 + (PROGRESSBAR_HEIGHT * (index - 1))

/datum/progressbar/proc/update_position(index)
	animate(bar, pixel_y = get_dist_to_travel(), time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

/datum/progressbar/proc/stop()
	is_active = FALSE
	STOP_PROCESSING(SSprogress_bars, src)
	if(last_progress >= goal)
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

/// transfers the bar to the turf, then self-destructs
/datum/progressbar/proc/master_deleted()
	SIGNAL_HANDLER
	// var/atom/master = display_loc?.resolve()
	// var/turf/right_here = get_turf(master)
	// display_loc = WEAKREF(right_here)
	// bar.loc = right_here
	INVOKE_ASYNC(src,PROC_REF(stop))

/// Generates a unique ID for the progress bar.
/// I mean the time of day is unique enough, but I like big dumb numbers
/datum/progressbar/proc/generate_bar_id()
	var/atom/master = display_loc?.resolve()
	bar_id = "[master]-[round(world.time, 1)]-[rand(100, 999)]-[rand(1000, 9999)]-[rand(10000, 99999)]"
	return TRUE

/// Only used on automatic progress bars. Updates the progress bar to the current time
/datum/progressbar/process()
	if(!auto_update)
		return
	last_progress = world.time - start_time
	update()

///Updates the progress bar image visually.
/datum/progressbar/proc/update(prog_override)
	if(!is_active)
		return
	if(prog_override)
		last_progress = prog_override
	if(auto_remove && last_progress >= goal)
		stop()
		return
	var/newstate = round(((clamp(last_progress, 0, goal) / goal) * 100), 5)
	bar.icon_state = "prog_bar_[newstate]"

/datum/progressbar/Destroy()
	remove_bar_from_seeing_clients()
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

/obj/item/debug_clicker
	name = "debug clicker"
	desc = "A clicker that creates a progress bar on itself. Hopefully this works."
	icon = 'icons/fallout/objects/guns/explosives.dmi'
	icon_state = "dynamite"
	var/timething = 15 SECONDS
	var/mybar
	var/mybar2
	var/mybar3
	var/mybar_manual
	var/nummy = 0

/obj/item/debug_clicker/AltClick(mob/user)
	. = ..()
	if(!SSprogress_bars.bar_exists(mybar_manual))
		mybar_manual = SSprogress_bars.add_bar(src, list(), 10, FALSE, TRUE)
		say("adding bar id: [mybar_manual]")
		return
	nummy = SSprogress_bars.update_bar(mybar_manual, nummy + 1)
	say("updating manual bar to [nummy] / 10")

/obj/item/debug_clicker/attack_self(mob/user)
	. = ..()
	if(!SSprogress_bars.check_bar(mybar))
		mybar = SSprogress_bars.add_bar(src, list(), timething, TRUE)
		say("adding bar id: [mybar]")
		return
	if(!SSprogress_bars.check_bar(mybar2))
		mybar2 = SSprogress_bars.add_bar(src, list(), timething, TRUE)
		say("adding bar id: [mybar2]")
		return
	if(!SSprogress_bars.check_bar(mybar3))
		mybar3 = SSprogress_bars.add_bar(src, list(), timething, TRUE)
		say("adding bar id: [mybar3]")
		return
	SSprogress_bars.remove_bar(mybar)
	SSprogress_bars.remove_bar(mybar2)
	SSprogress_bars.remove_bar(mybar3)
	mybar = null
	mybar2 = null
	mybar3 = null
	say("removing bars")

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
	new /obj/item/debug_clicker(src)
	new /obj/item/debug_clicker(src)

#undef PROGRESSBAR_ANIMATION_TIME
#undef PROGRESSBAR_HEIGHT

