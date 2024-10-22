/atom/movable/screen/ghost
	icon = 'icons/mob/screen_ghost.dmi'

/atom/movable/screen/ghost/MouseEntered()
	flick(icon_state + "_anim", src)

/atom/movable/screen/ghost/jumptomob
	name = "Jump to mob"
	icon_state = "jumptomob"

/atom/movable/screen/ghost/jumptomob/Click()
	var/mob/dead/observer/G = usr
	G.jumptomob()

/atom/movable/screen/ghost/orbit
	name = "Orbit"
	icon_state = "orbit"

/atom/movable/screen/ghost/orbit/Click()
	var/mob/dead/observer/G = usr
	G.follow()

/atom/movable/screen/ghost/reenter_corpse
	name = "Reenter corpse"
	icon_state = "reenter_corpse"

/atom/movable/screen/ghost/reenter_corpse/Click()
	var/mob/dead/observer/G = usr
	G.reenter_corpse()

/atom/movable/screen/ghost/teleport
	name = "Teleport"
	icon_state = "teleport"

/atom/movable/screen/ghost/teleport/Click()
	var/mob/dead/observer/G = usr
	G.dead_tele()

/atom/movable/screen/ghost/spawners
	name = "Ghost role spawners"
	icon_state = "spawners"

/atom/movable/screen/ghost/spawners/Click()
	var/mob/dead/observer/G = usr
	G.open_spawners_menu()

/atom/movable/screen/ghost/second_wind
	name = "Revive yourself"
	icon_state = "reenter_corpse"

/atom/movable/screen/ghost/second_wind/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSprocessing, src)

/atom/movable/screen/ghost/second_wind/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	. = ..()

/atom/movable/screen/ghost/second_wind/process()
	var/hazcorpse = SSsecondwind.has_a_revivable_corpse(hud.mymob)
	if(hazcorpse)
		maptext = "<span style='font-size:1; color:green;'><b>Click Here to live again!<b>\nVVV</span>"
		maptext_height = 200
		maptext_width = 1000
		maptext_x = 0
		maptext_y = 32
		STOP_PROCESSING(SSprocessing, src)


/atom/movable/screen/ghost/second_wind/Click()
	var/mob/dead/observer/G = usr
	SSsecondwind.show_menu_to(G)

/atom/movable/screen/ghost/character_directory
	name = "Character Directory"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "chardir"

/atom/movable/screen/ghost/character_directory/Click()
	var/mob/dead/observer/G = usr
	var/client/C = G.client
	C.who()

/atom/movable/screen/ghost/move_ghost_up
	name = "Move up"
	icon_state = "move_ghost_up"

/atom/movable/screen/ghost/move_ghost_up/Click()
	var/mob/dead/observer/G = usr
	G.up()

/atom/movable/screen/ghost/move_ghost_down
	name = "Move down"
	icon_state = "move_ghost_down"

/atom/movable/screen/ghost/move_ghost_down/Click()
	var/mob/dead/observer/G = usr
	G.down()

/datum/hud/ghost/New(mob/owner)
	..()
	var/atom/movable/screen/using

	using = new /atom/movable/screen/ghost/jumptomob()
	using.screen_loc = ui_ghost_jumptomob // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/ghost/orbit()
	using.screen_loc = ui_ghost_orbit // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/ghost/reenter_corpse()
	using.screen_loc = ui_ghost_reenter_corpse // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/ghost/teleport()
	using.screen_loc = ui_ghost_teleport // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/ghost/spawners()
	using.screen_loc = ui_ghost_spawners // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/ghost/second_wind()
	using.screen_loc = ui_ghost_second_wind // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	// using = new /atom/movable/screen/ghost/character_directory()
	// using.screen_loc = ui_ghost_char_dir // THIS IS A DEFINE!!!
	// using.hud = src
	// static_inventory += using

	using = new /atom/movable/screen/language_menu
	using.icon = ui_style // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/ghost/move_ghost_up()
	using.screen_loc = ui_ghost_move_up // THIS IS A DEFINE!!!
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/ghost/move_ghost_down()
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
