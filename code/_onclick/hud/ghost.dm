/obj/screen/ghost
	icon = 'icons/mob/screen_ghost.dmi'

/obj/screen/ghost/MouseEntered()
	flick(icon_state + "_anim", src)

/obj/screen/ghost/jumptomob
	name = "Jump to mob"
	icon_state = "jumptomob"

/obj/screen/ghost/jumptomob/Click()
	var/mob/dead/observer/G = usr
	G.jumptomob()

/obj/screen/ghost/orbit
	name = "Orbit"
	icon_state = "orbit"

/obj/screen/ghost/orbit/Click()
	var/mob/dead/observer/G = usr
	G.follow()

/obj/screen/ghost/reenter_corpse
	name = "Reenter corpse"
	icon_state = "reenter_corpse"

/obj/screen/ghost/reenter_corpse/Click()
	var/mob/dead/observer/G = usr
	G.reenter_corpse()

/obj/screen/ghost/teleport
	name = "Teleport"
	icon_state = "teleport"

/obj/screen/ghost/teleport/Click()
	var/mob/dead/observer/G = usr
	G.dead_tele()

/obj/screen/ghost/spawners
	name = "Ghost role spawners"
	icon_state = "spawners"

/obj/screen/ghost/spawners/Click()
	var/mob/dead/observer/G = usr
	G.open_spawners_menu()

/obj/screen/ghost/second_wind
	name = "Revive yourself"
	icon_state = "reenter_corpse"

/obj/screen/ghost/second_wind/Click()
	var/mob/dead/observer/G = usr
	SSsecondwind.show_menu_to(G)

/obj/screen/ghost/move_ghost_up
	name = "Move up"
	icon_state = "move_ghost_up"

/obj/screen/ghost/move_ghost_up/Click()
	var/mob/dead/observer/G = usr
	G.up()

/obj/screen/ghost/move_ghost_down
	name = "Move down"
	icon_state = "move_ghost_down"

/obj/screen/ghost/move_ghost_down/Click()
	var/mob/dead/observer/G = usr
	G.down()

/datum/hud/ghost/New(mob/owner)
	..()
	var/obj/screen/using

	using = new /obj/screen/ghost/jumptomob()
	using.screen_loc = ui_ghost_jumptomob // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /obj/screen/ghost/orbit()
	using.screen_loc = ui_ghost_orbit // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /obj/screen/ghost/reenter_corpse()
	using.screen_loc = ui_ghost_reenter_corpse // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /obj/screen/ghost/teleport()
	using.screen_loc = ui_ghost_teleport // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /obj/screen/ghost/spawners()
	using.screen_loc = ui_ghost_spawners // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /obj/screen/ghost/second_wind()
	using.screen_loc = ui_ghost_second_wind // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /obj/screen/language_menu
	using.icon = ui_style // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /obj/screen/ghost/move_ghost_up()
	using.screen_loc = ui_ghost_move_up // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /obj/screen/ghost/move_ghost_down()
	using.screen_loc = ui_ghost_move_down // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	HandlePlanes()

/datum/hud/ghost/proc/HandlePlanes()
	if(check_rights(R_ADMIN, 0))
		return
	plane_masters["[OBJITEM_PLANE]"].Hide()
	mymob.client.show_popup_menus = 0

/datum/hud/ghost/show_hud(version = 0, mob/viewmob)
	// don't show this HUD if observing; show the HUD of the observee
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observetarget)
		plane_masters_update()
		HandlePlanes()
		return FALSE

	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client.prefs.ghost_hud)
		screenmob.client.screen -= static_inventory
	else
		screenmob.client.screen += static_inventory
