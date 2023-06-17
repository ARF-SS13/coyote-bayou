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
	for(var/offset in 0 to MAX_ACCURACY_OFFSET)
		var/icon/base = icon('modular_coyote/eris/icons/96x96.dmi')
		var/icon/scaled = icon('modular_coyote/eris/icons/standard_grayscale.dmi') //Default cursor, cut into pieces according to their direction
		base.Blend(scaled, ICON_OVERLAY, x = 32, y = 32)
		for(var/dir in list(NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST))
			var/icon/overlay = icon('modular_coyote/eris/icons/standard_grayscale.dmi', "[dir]")
			var/pixel_y
			var/pixel_x
			if(dir & NORTH)
				pixel_y = CLAMP(offset, -MAX_RETICLE_SIZE, MAX_RETICLE_SIZE)
			if(dir & SOUTH)
				pixel_y = CLAMP(-offset, -MAX_RETICLE_SIZE, MAX_RETICLE_SIZE)
			if(dir & EAST)
				pixel_x = CLAMP(offset, -MAX_RETICLE_SIZE, MAX_RETICLE_SIZE)
			if(dir & WEST)
				pixel_x = CLAMP(-offset, -MAX_RETICLE_SIZE, MAX_RETICLE_SIZE)
			base.Blend(overlay, ICON_OVERLAY, x=32+pixel_x, y=32+pixel_y)
		var/spread_color = gradient("#0000FF", "#FFFF00", (offset/MAX_ACCURACY_OFFSET))
		base.Blend(spread_color, ICON_MULTIPLY)
		reticle_icons["reticle-[offset]"] = base
		SSassets.transport.register_asset("reticle-[offset]", base)

/datum/controller/subsystem/reticle/proc/find_cursor_icon(offset)
	offset = CLAMP(offset, 0, MAX_ACCURACY_OFFSET)
	return LAZYACCESS(reticle_icons, "reticle-[offset]")

/datum/controller/subsystem/reticle/proc/send_all_cursor_icons(client/C)
	for(var/icon/reticle in reticle_icons)
		C << reticle

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
	var/recoil = SSrecoil.get_offset(src, G, TRUE)
	var/offset = clamp(CEILING(recoil, 1), 0, MAX_ACCURACY_OFFSET)
	var/icon/base = SSreticle.find_cursor_icon(offset)
	ASSERT(isicon(base))
	client.mouse_pointer_icon = base

/mob/living/proc/remove_cursor()
	if(!client)
		return
	client.mouse_pointer_icon = initial(client.mouse_pointer_icon)

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





