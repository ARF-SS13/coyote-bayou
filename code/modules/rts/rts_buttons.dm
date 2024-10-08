/atom/movable/screen/rts_button
	icon = 'icons/misc/rts_buttons.dmi'
	// If we don't do this, we get occluded by item action buttons
	layer = ABOVE_HUD_LAYER
	var/active

/atom/movable/screen/rts_button/proc/Hide()
	icon_state = null

/atom/movable/screen/rts_button/proc/Show(mob/user)
	icon_state = initial(icon_state)

/atom/movable/screen/rts_button/proc/Activate(datum/rts_commander/c)

/atom/movable/screen/rts_button/proc/Deactivate(datum/rts_commander/c)

/atom/movable/screen/rts_button/mode
	name = "Toggle Mode"
	icon_state = "rts_off"
	screen_loc = "NORTH,WEST"

/atom/movable/screen/rts_button/mode/Click(location, control, params)
	var/mob/user = usr
	SSrts.ToggleCommander(user)

/atom/movable/screen/rts_button/mode/Activate()
	name = "Turn off RTS mode"
	icon_state = "rts_on"
	desc = "Click to turn off RTS mode"

/atom/movable/screen/rts_button/mode/Deactivate()
	name = "Turn on RTS mode"
	icon_state = "rts_off"
	desc = "Click to turn on RTS mode"

/atom/movable/screen/rts_button/help
	name = "How to Commander!"
	icon_state = "rts_help"
	screen_loc = "NORTH,WEST+1"
	desc = "Click to get a quick rundown of how to use the RTS system!"

/atom/movable/screen/rts_button/help/Click(location, control, params)
	var/list/msg = list()
	msg += "*****"
	msg += "Hi, Commander! Here's a quick rundown of how to use the RTS system:"
	msg += "*****"
	msg += "Leftclick drag to select creatures."
	msg += "Shift+Leftclick drag to remove from selection."
	msg += "Ctrl+Leftclick drag to add to selection."
	msg += "If you clickdrag over or alt-rightclick a mob nest, it'll spawn something from it, if it can."
	msg += "*****"
	msg += "Rightclick to tell them to move to that tile."
	msg += "Ctrl+Rightclick to tell them to melee in that direction."
	msg += "Shift+Rightclick to tell them to shoot in that direction, if they can."
	msg += "Alt+Rightclick to open doors."
	msg += "*****"
	to_chat(usr, span_green(msg.Join("\n")))

/atom/movable/screen/rts_button/counter
	name = "You have THIS MANY creatures selected!"
	icon_state = "rts_blank"
	screen_loc = "NORTH,WEST+2"
	desc = "This is how many creatures you have selected!"

/atom/movable/screen/rts_button/counter/proc/UpdateMaptext(thismany)
	maptext = "<center>Selected:\n<b>[thismany] / [SSrts.max_select]</b></center>"

