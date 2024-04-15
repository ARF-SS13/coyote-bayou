/atom/movable/screen/rts_button
	icon = 'icons/misc/rts_button.dmi'
	var/datum/rts/my_parent
	// If we don't do this, we get occluded by item action buttons
	layer = ABOVE_HUD_LAYER

/atom/movable/screen/rts_button/New(wannabe_parent)
	my_parent = wannabe_parent
	return ..()

/atom/movable/screen/rts_button/Destroy()
	my_parent = null
	return ..()

/atom/movable/screen/rts_button/mode
	name = "Toggle Mode"
	icon_state = "rts_button_basic"
	screen_loc = "NORTH,WEST"

/atom/movable/screen/rts_button/mode/Click(location, control, params)
	var/list/pa = params2list(params)

	if(pa.Find("left"))
		my_parent.toggle_modeswitch()
	else if(pa.Find("right"))
		my_parent.mode.change_settings(usr.client)
	update_icon()
	return 1

/atom/movable/screen/rts_button/mode/update_icon_state()
	icon_state = my_parent.mode.get_button_iconstate()

/atom/movable/screen/rts_button/help
	icon_state = "buildhelp"
	screen_loc = "NORTH,WEST+1"
	name = "rts_button Help"

/atom/movable/screen/rts_button/help/Click(location, control, params)
	my_parent.mode.show_help(usr.client)
	return 1

/atom/movable/screen/rts_button/bdir
	icon_state = "build"
	screen_loc = "NORTH,WEST+2"
	name = "Change Dir"

/atom/movable/screen/rts_button/bdir/update_icon_state()
	dir = my_parent.build_dir

/atom/movable/screen/rts_button/bdir/Click()
	my_parent.toggle_dirswitch()
	update_icon()
	return 1

// used to switch between modes
/atom/movable/screen/rts_button/modeswitch
	var/datum/rts_button_mode/modetype

/atom/movable/screen/rts_button/modeswitch/New(wannabe_parent, mt)
	modetype = mt
	icon_state = "rts_button_[initial(modetype.key)]"
	name = initial(modetype.key)
	return ..(wannabe_parent)

/atom/movable/screen/rts_button/modeswitch/Click()
	my_parent.change_mode(modetype)
	return 1

// used to switch between dirs
/atom/movable/screen/rts_button/dirswitch
	icon_state = "build"

/atom/movable/screen/rts_button/dirswitch/New(wannabe_parent, dir)
	src.dir = dir
	name = dir2text(dir)
	return ..(wannabe_parent)

/atom/movable/screen/rts_button/dirswitch/Click()
	my_parent.change_dir(dir)
	return 1

/atom/movable/screen/rts_button/quit
	icon_state = "buildquit"
	screen_loc = "NORTH,WEST+3"
	name = "Quit rts_button"

/atom/movable/screen/rts_button/quit/Click()
	my_parent.quit()
	return 1
