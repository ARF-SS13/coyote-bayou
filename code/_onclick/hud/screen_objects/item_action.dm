//-----------------------------------------------ITEM ACTION---------------------------------------------------------
/atom/movable/screen/item_action
	var/obj/item/owner

/atom/movable/screen/item_action/Destroy()
	. = ..()
	owner = null

/atom/movable/screen/item_action/Click()
	if(!usr || !owner)
		return TRUE
	if(!usr.CheckActionCooldown())
		return
	if(usr.stat || usr.restrained())
		return TRUE
	if(!(owner in usr))
		return TRUE
	owner.ui_action_click(usr, name)
	update_icon()
	return TRUE

/atom/movable/screen/item_action/top_bar
	name = "actionA"
	//icon = 'icons/mob/screen/ErisStyle.dmi'
	icon_state = "actionA"
	screen_loc = "8,1:13"
	var/minloc = "7,2:13"
	layer = ABOVE_HUD_LAYER
	plane = ABOVE_HUD_PLANE

/atom/movable/screen/item_action/top_bar/Initialize()
	. = ..()
	name = initial(name)

/atom/movable/screen/item_action/top_bar/update_icon()
	..()
	if(!ismob(owner.loc))
		return

	var/mob/living/M = owner.loc
	if(M.client && M.get_active_hand() == owner)
		screen_loc = initial(screen_loc)


/atom/movable/screen/item_action/top_bar/A
	icon_state = "actionA"
	screen_loc = "8,1:13"

/atom/movable/screen/item_action/top_bar/B
	icon_state = "actionB"
	screen_loc = "8,1:13"

/atom/movable/screen/item_action/top_bar/C
	icon_state = "actionC"
	screen_loc = "9,1:13"

/atom/movable/screen/item_action/top_bar/D
	icon_state = "actionD"
	screen_loc = "9,1:13"


//-----------------------------------------------ITEM ACTION END---------------------------------------------------------

//-----------------------------------------------GUN ACTION--------------------------------------------------------------

/atom/movable/screen/item_action/top_bar/gun
	icon = 'modular_coyote/eris/icons/gun_actions.dmi'
	screen_loc = "CENTER-1:14,SOUTH+1:13"

/atom/movable/screen/item_action/top_bar/gun/safety
	name = "safety"
	icon_state = "safety1"

/atom/movable/screen/item_action/top_bar/gun/safety/update_icon()
	..()
	var/obj/item/gun/G = owner
	icon_state = "safety[G.safety]"


/atom/movable/screen/item_action/top_bar/gun/fire_mode
	name = "fire mode"
	icon_state = "mode_semi"

/atom/movable/screen/item_action/top_bar/gun/fire_mode/update_icon()
	..()
	var/obj/item/gun/G = owner
	if(G.sel_mode <= length(G.firemodes))
		var/datum/firemode/cur_mode = G.firemodes[G.sel_mode]
		icon_state = "mode_[cur_mode.icon_state]"


/atom/movable/screen/item_action/top_bar/gun/scope
	name = "scope"
	icon_state = "scope0"
	screen_loc = "CENTER:15,SOUTH+1:13"
	minloc = null

/atom/movable/screen/item_action/top_bar/gun/scope/update_icon()
	..()
	var/obj/item/gun/G = owner
	icon_state = "scope[G.zoomed]"


/atom/movable/screen/item_action/top_bar/weapon_info
	icon = 'modular_coyote/eris/icons/gun_actions.dmi'
	screen_loc = "CENTER+1,SOUTH+1:13"
	minloc = null
	name = "Weapon Info"
	icon_state = "info"
