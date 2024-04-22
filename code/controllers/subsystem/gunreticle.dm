// A subsystem? For reticle? In MY BYOND? It's more likely than you think.
// Also includes a dynamic cursor, simulating accuracy. If you want to resprite this, go ahead.
SUBSYSTEM_DEF(reticle)
	name = "Reticle"
	flags = SS_BACKGROUND|SS_NO_FIRE
	var/list/reticle_icons = list()

/datum/controller/subsystem/reticle/Initialize(start_timeofday)
	build_reticle_icons()
	. = ..()

/datum/controller/subsystem/reticle/proc/build_reticle_icons()
	for(var/offset in 0 to SSrecoil.recoil_max_spread*2)
		var/true_offset = offset - SSrecoil.recoil_max_spread // -SSrecoil.recoil_max_spread to SSrecoil.recoil_max_spread
		var/apparent_offset = max(true_offset, 0) // The negatives just get color differences
		var/icon/base = icon('modular_coyote/eris/icons/96x96.dmi')
		var/icon/scaled = icon('modular_coyote/eris/icons/standard_grayscale.dmi') //Default cursor, cut into pieces according to their direction
		base.Blend(scaled, ICON_OVERLAY, x = 32, y = 32)
		for(var/dir in list(NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST))
			var/icon/overlay = icon('modular_coyote/eris/icons/standard_grayscale.dmi', "[dir]")
			var/pixel_y
			var/pixel_x
			if(dir & NORTH)
				pixel_y = CLAMP(apparent_offset, -MAX_RETICLE_SIZE, MAX_RETICLE_SIZE)
			if(dir & SOUTH)
				pixel_y = CLAMP(-apparent_offset, -MAX_RETICLE_SIZE, MAX_RETICLE_SIZE)
			if(dir & EAST)
				pixel_x = CLAMP(apparent_offset, -MAX_RETICLE_SIZE, MAX_RETICLE_SIZE)
			if(dir & WEST)
				pixel_x = CLAMP(-apparent_offset, -MAX_RETICLE_SIZE, MAX_RETICLE_SIZE)
			base.Blend(overlay, ICON_OVERLAY, x=32+pixel_x, y=32+pixel_y)
			CHECK_TICK
		var/spread_color = gradient("#00FF00", "#0000FF", "#FFFF00", (offset/(SSrecoil.recoil_max_spread*2)))
		base.Blend(spread_color, ICON_MULTIPLY)
		reticle_icons["reticle-[round(true_offset)]"] = base
		SSassets.transport.register_asset("reticle-[offset]", base)
		CHECK_TICK

/datum/controller/subsystem/reticle/proc/find_cursor_icon(offset)
	var/my_cursor = LAZYACCESS(reticle_icons, "reticle-[offset]")
	if(!my_cursor)
		return LAZYACCESS(reticle_icons, "reticle-0")
	return LAZYACCESS(reticle_icons, "reticle-[offset]")

/datum/controller/subsystem/reticle/proc/send_all_cursor_icons(client/C)
	for(var/reticle in reticle_icons)
		C << LAZYACCESS(reticle_icons, reticle)

/mob/living/proc/update_cursor(obj/item/gun/G)
	if(!client)
		return
	if(!istype(G))
		remove_cursor()
		return
	if(!CHECK_BITFIELD(client.prefs.cb_toggles, AIM_CURSOR_ON))
		remove_cursor()
		return
	if(get_active_held_item() != G)
		remove_cursor()
		return
	//client.mouse_pointer_icon = initial(client.mouse_pointer_icon)
	var/recoil = SSrecoil.get_offset(src, FALSE, TRUE)
	var/offset = clamp(round(recoil, 1), -MAX_ACCURACY_OFFSET, MAX_ACCURACY_OFFSET)
	var/icon/base = SSreticle.find_cursor_icon(offset)
	ASSERT(isicon(base))
	client.mouse_pointer_icon = base

/mob/living/proc/remove_cursor()
	if(!client)
		return
	update_mouse_pointer()

//Allows for a dynamic cursor, simulating accuracy. If you want to resprite this, go ahead.

/obj/item/gun/equipped(mob/living/H)
	. = ..()
	if(H.client && !CHECK_BITFIELD(H.client.prefs.cb_toggles, AIM_CURSOR_ON))
		H.remove_cursor()
		return
	if(H.get_active_held_item() == src && !safety)
		H.update_cursor(src)
	else
		H.remove_cursor()

/obj/item/gun/afterattack(obj/target, mob/living/user, flag)
	. = ..()
	if(user.get_active_held_item() != src)
		user.remove_cursor()

/obj/item/gun/dropped(mob/living/user)
	user.remove_cursor()
	. = ..()

/obj/item/gun/afterattack(atom/A, mob/living/user, adjacent, params)
	check_safety_cursor(user)
	. = ..()

/obj/item/gun/Destroy()
	if(ismob(loc))
		var/mob/living/L = loc
		L.remove_cursor()
	. = ..()


/mob
	var/examine_cursor_icon = 'icons/mouse_icons/examine.dmi'
	var/pull_cursor_icon = 'icons/mouse_icons/pull.dmi'
	var/throw_cursor_icon = 'icons/mouse_icons/throw.dmi'

/mob/proc/update_mouse_pointer()
	if (!client)
		return
	if(pull_cursor_icon && client.keys_held["Ctrl"])
		client.mouse_pointer_icon = pull_cursor_icon
	else if(throw_cursor_icon && in_throw_mode != 0)
		client.mouse_pointer_icon = throw_cursor_icon
	else if(examine_cursor_icon && client.keys_held["Shift"]) //mouse shit is hardcoded, make this non hard-coded once we make mouse modifiers bindable
		client.mouse_pointer_icon = examine_cursor_icon
	else
		client.mouse_pointer_icon = initial(client.mouse_pointer_icon)
	// if (ismecha(loc))
	// 	var/obj/mecha/M = loc
	// 	if(M.mouse_pointer)
	// 		client.mouse_pointer_icon = M.mouse_pointer




