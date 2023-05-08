SUBSYSTEM_DEF(progress_bars)
	name = "Progress Bars"
	flags = SS_NO_INIT
	wait = 0.2 SECONDS

	/// All the progress bars that are currently active and need to be updated
	/// Not a weakref cus we own them
	/// format: list(/datum/progressbar-initted)
	var/list/progbars = list()
	/// All weakrefs to atoms that are currently using progress bars
	/// format: list(/datum/weakref/thing = list(/datum/progressbar-initted))
	var/list/atom_proglist = list()

/datum/controller/subsystem/progress_bars/fire(resumed)






#define PROGRESSBAR_HEIGHT 6
#define PROGRESSBAR_ANIMATION_TIME 5

/datum/progressbar
	///The progress bar visual element.
	var/image/bar
	///The place where the progress bar is shown.
	var/datum/weakref/display_loc
	///The clients who can see this thing.
	var/list/visible_to = list()
	///If the progress bar should be visible to everyone. Overrides the above
	var/visible_to_all = FALSE
	///The client seeing the progress bar.
	var/client/user_client
	///Effectively the number of steps the progress bar will need to do before reaching completion.
	var/goal = 1
	///Control check to see if the progress was interrupted before reaching its goal.
	var/last_progress = 0
	///Variable to ensure smooth visual stacking on multiple progress bars.
	var/listindex = 0
	///The previous icon state of the progress bar.
	var/last_icon_state

/datum/progressbar/New(atom/display_loc, list/can_see)
	. = ..()
	if (!istype(display_loc))
		EXCEPTION("Invalid target given")
	// if((QDELETED(User) || !istype(User)) && !visible_to_all)
	// 	stack_trace("/datum/progressbar created with [isnull(User) ? "null" : "invalid"] user")
	// 	qdel(src)
	// 	return
	// if(!isnum(goal_number))
	// 	stack_trace("/datum/progressbar created with [isnull(User) ? "null" : "invalid"] goal_number")
	// 	qdel(src)
	// 	return
	display_loc = owner
	bar = image('icons/effects/progessbar.dmi', display_loc, "prog_bar_0")
	bar.plane = display_loc.plane + 100
	// if(visible_to_all)
	// 	bar.plane = HUD_PLANE - 100
	// else
	// 	bar.plane = ABOVE_HUD_PLANE
	bar.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	listindex = SSprogress_bars.add_bar(src, display_loc)
	if(isnull(listindex))
		qdel(src)
		return
	register_visibility(can_see)

	// LAZYADDASSOC(user.progressbars, display_loc, src)
	// var/list/bars = user.progressbars[display_loc]
	// listindex = bars.len

	// if(user.client)
	// 	user_client = user.client
	// 	add_prog_bar_image_to_client()

/datum/register_visibility(list/can_see = list())
	if(LAZYLEN(can_see))
		for(var/atom/thing in can_see)
			visible_to |= WEAKREF(thing)
			RegisterSignal(thing, COMSIG_PARENT_QDELETING, .proc/on_user_delete)
			RegisterSignal(thing, COMSIG_MOB_CLIENT_LOGOUT, .proc/on_user_logout)
			RegisterSignal(thing, COMSIG_MOB_CLIENT_LOGIN, .proc/on_user_login)
		return
	else


/datum/progressbar/Destroy()
	if(user)
		for(var/pb in user.progressbars[display_loc])
			var/datum/progressbar/progress_bar = pb
			if(progress_bar == src || progress_bar.listindex <= listindex)
				continue
			progress_bar.listindex--

			progress_bar.bar.pixel_y = 32 + (PROGRESSBAR_HEIGHT * (progress_bar.listindex - 1))
			var/dist_to_travel = 32 + (PROGRESSBAR_HEIGHT * (progress_bar.listindex - 1)) - PROGRESSBAR_HEIGHT
			animate(progress_bar.bar, pixel_y = dist_to_travel, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

		LAZYREMOVEASSOC(user.progressbars, display_loc, src)
		user = null

	if(user_client)
		clean_user_client()

	display_loc = null

	if(bar)
		QDEL_NULL(bar)

	return ..()


///Called right before the user's Destroy()
/datum/progressbar/proc/on_user_delete(datum/source)
	SIGNAL_HANDLER

	user.progressbars = null //We can simply nuke the list and stop worrying about updating other prog bars if the user itself is gone.
	user = null
	qdel(src)


///Removes the progress bar image from the user_client and nulls the variable, if it exists.
/datum/progressbar/proc/clean_user_client(datum/source)
	SIGNAL_HANDLER

	if(!user_client) //Disconnected, already gone.
		return
	user_client.images -= bar
	user_client = null


///Called by user's Login(), it transfers the progress bar image to the new client.
/datum/progressbar/proc/on_user_login(datum/source)
	SIGNAL_HANDLER

	if(user_client)
		if(user_client == user.client) //If this was not client handling I'd condemn this sanity check. But clients are fickle things.
			return
		clean_user_client()
	if(!user.client) //Clients can vanish at any time, the bastards.
		return
	user_client = user.client
	add_prog_bar_image_to_client()


///Adds a smoothly-appearing progress bar image to the player's screen.
/datum/progressbar/proc/add_prog_bar_image_to_client()
	user_client.images += bar
	show_bar()

/datum/progressbar/proc/show_bar()
	bar.pixel_y = 0
	bar.alpha = 0
	bar.loc = display_loc
	animate(bar, pixel_y = 32 + (PROGRESSBAR_HEIGHT * (listindex - 1)), alpha = 255, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

/datum/progressbar/proc/hide_bar()
	bar.alpha = 255
	animate(bar, pixel_y = 0, alpha = 0, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)
	bar.icon_state = "prog_bar_0"

/datum/progressbar/proc/set_new_goal(newgoal)
	goal = newgoal
	last_progress = 0
	update(0)

///Updates the progress bar image visually.
/datum/progressbar/proc/update(progress)
	progress = clamp(progress, 0, goal)
	if(progress == last_progress)
		return
	last_progress = progress
	bar.icon_state = "prog_bar_[round(((progress / goal) * 100), 5)]"
	if(last_icon_state != bar.icon_state)
		last_icon_state = bar.icon_state
		return TRUE

///Called on progress end, be it successful or a failure. Wraps up things to delete the datum and bar.
/datum/progressbar/proc/end_progress()
	if(last_progress != goal)
		bar.icon_state = "[bar.icon_state]_fail"

	animate(bar, alpha = 0, time = PROGRESSBAR_ANIMATION_TIME)
	if(visible_to_all)
		hide_bar()
		return

	QDEL_IN(src, PROGRESSBAR_ANIMATION_TIME)


#undef PROGRESSBAR_ANIMATION_TIME
#undef PROGRESSBAR_HEIGHT

