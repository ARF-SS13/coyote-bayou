/*
	Screen objects
	Todo: improve/re-implement

	Screen objects are only used for the hud and should not appear anywhere "in-game".
	They are used with the client/screen list and the screen_loc var.
	For more information, see the byond documentation on the screen_loc and screen vars.
*/
/atom/movable/screen
	name = ""
	icon = 'icons/mob/screen_gen.dmi'
	plane = HUD_PLANE
	animate_movement = SLIDE_STEPS
	speech_span = SPAN_ROBOT
	vis_flags = VIS_INHERIT_PLANE
	appearance_flags = APPEARANCE_UI
	/// A reference to the object in the slot. Grabs or items, generally.
	var/obj/master = null
	/// A reference to the owner HUD, if any.
	var/datum/hud/hud = null
	/**
	 * Map name assigned to this object.
	 * Automatically set by /client/proc/add_obj_to_map.
	 */
	var/assigned_map
	/**
	 * Mark this object as garbage-collectible after you clean the map
	 * it was registered on.
	 *
	 * This could probably be changed to be a proc, for conditional removal.
	 * But for now, this works.
	 */
	var/del_on_map_removal = TRUE

/atom/movable/screen/Destroy()
	master = null
	hud = null
	return ..()

/atom/movable/screen/examine(mob/user)
	return list()

/atom/movable/screen/orbit()
	return

/atom/movable/screen/proc/component_click(atom/movable/screen/component_button/component, params)
	return

/atom/movable/screen/text
	icon = null
	icon_state = null
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	screen_loc = "CENTER-7,CENTER-7"
	maptext_height = 480
	maptext_width = 480

/atom/movable/screen/swap_hand
	layer = HUD_LAYER
	plane = HUD_PLANE
	name = "swap hand"

/atom/movable/screen/swap_hand/Click()
	usr.swap_hand()
	return 1

/atom/movable/screen/craft
	name = "crafting menu"
	icon = 'icons/fallout/UI/screen_fallout2.dmi'
	icon_state = "craft"
	screen_loc = ui_crafting

/atom/movable/screen/area_creator
	name = "create new area"
	icon = 'icons/fallout/UI/screen_fallout2.dmi'
	icon_state = "area_edit"
	screen_loc = ui_building

/atom/movable/screen/area_creator/Click()
	if(usr.incapacitated() || (isobserver(usr) && !IsAdminGhost(usr)))
		return TRUE
	var/area/A = get_area(usr)
	if(!A.outdoors)
		to_chat(usr, span_warning("There is already a defined structure here."))
		return TRUE
	create_area(usr)

/atom/movable/screen/language_menu
	name = "language menu"
	icon = 'icons/fallout/UI/screen_fallout2.dmi'
	icon_state = "talk_wheel"
	screen_loc = ui_language_menu

/atom/movable/screen/language_menu/Click()
	var/mob/M = usr
	var/datum/language_holder/H = M.get_language_holder()
	H.open_language_menu(usr)

/atom/movable/screen/inventory
	var/slot_id	// The indentifier for the slot. It has nothing to do with ID cards.
	var/icon_empty // Icon when empty. For now used only by humans.
	var/icon_full  // Icon when contains an item. For now used only by humans.
	var/mutable_appearance/object_overlay
	var/object_overlay_type
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/inventory/Destroy()
	QDEL_NULL(object_overlay)
	cut_overlays()
	. = ..()

/// Removes object overlays on this inventory screen if they exist.
/atom/movable/screen/inventory/proc/ClearGhosts()
	//If we have it, get rid of it now the right way.
	if(object_overlay && overlays.len)
		cut_overlay(object_overlay)
	//If we still have things in our overlays after cutting them, force get rid of all overlays. We only use overlays for the green ghosts anyways.
	if(overlays.len && type != /atom/movable/screen/inventory/hand)
		cut_overlays()

/atom/movable/screen/inventory/hand/ClearGhosts()
	//Hands don't have this problem
	return

/atom/movable/screen/inventory/Click(location, control, params)
	if(hud?.mymob && (hud.mymob != usr))
		return
	// just redirect clicks

	if(hud?.mymob && slot_id)
		var/obj/item/inv_item = hud.mymob.get_item_by_slot(slot_id)
		if(inv_item)
			return inv_item.Click(location, control, params)

	if(usr.attack_ui(slot_id))
		usr.update_inv_hands()
	//Remove the green object overlay since we never had a chance to use MouseExited(). Also removes the red one, but that's okay.
	if(object_overlay)
		cut_overlay(object_overlay)
	return TRUE

/atom/movable/screen/inventory/MouseEntered()
	..()
	add_overlays()

/atom/movable/screen/inventory/MouseExited()
	..()
	if(type != /atom/movable/screen/inventory/hand)
		cut_overlays()

/atom/movable/screen/inventory/update_icon_state()
	if(!icon_empty)
		icon_empty = icon_state

	if(hud?.mymob && slot_id && icon_full)
		if(hud.mymob.get_item_by_slot(slot_id))
			icon_state = icon_full
		else
			icon_state = icon_empty

/*
/atom/movable/screen/inventory/update_icon()
	. = ..()
	if(object_overlay)
		cut_overlay(object_overlay)
		QDEL_NULL(object_overlay)
*/

/atom/movable/screen/inventory/proc/add_overlays()
	var/mob/user = hud?.mymob
	if(!user || !slot_id)
		return

	var/obj/item/holding = user.get_active_held_item()
	if(!holding || user.get_item_by_slot(slot_id))
		ClearGhosts()
		return

	if((holding.type != object_overlay_type) || !object_overlay)
		//Our overlay doesn't match the item we're holding or we don't have an overlay cached at all, make a new one.
		cut_overlay(object_overlay)
		QDEL_NULL(object_overlay)
		var/overlaycolor = "#00ff00"
		if(!user.can_equip(holding, slot_id, TRUE, TRUE, TRUE))
			overlaycolor = "#FF0000"
		var/mutable_appearance/item_overlay = mutable_appearance(holding.icon, holding.icon_state, FLOAT_LAYER, FLOAT_PLANE, overlaycolor)
		item_overlay.alpha = 92
		add_overlay(item_overlay)
		object_overlay = item_overlay
		object_overlay_type = holding.type
	if(holding.type == object_overlay_type && object_overlay)
		//The overlay is PROBABLY the same as the one we have cached so just add that one. Will be inconsistent sometimes but who cares.
		add_overlay(object_overlay)

/atom/movable/screen/inventory/hand
	var/mutable_appearance/handcuff_overlay
	var/static/mutable_appearance/blocked_overlay = mutable_appearance('icons/mob/screen_gen.dmi', "blocked")
	var/held_index = 0

/atom/movable/screen/inventory/hand/add_overlays()
	return

/atom/movable/screen/inventory/hand/update_overlays()
	. = ..()

	if(!handcuff_overlay)
		var/state = (!(held_index % 2)) ? "markus" : "gabrielle"
		handcuff_overlay = mutable_appearance('icons/mob/screen_gen.dmi', state)

	if(!hud?.mymob)
		return

	if(iscarbon(hud.mymob))
		var/mob/living/carbon/C = hud.mymob
		if(C.handcuffed)
			. += handcuff_overlay

		if(held_index)
			if(!C.has_hand_for_held_index(held_index))
				. += blocked_overlay

	if(held_index == hud.mymob.active_hand_index)
		. += "hand_active"


/atom/movable/screen/inventory/hand/Click(location, control, params)
	if(hud?.mymob && (hud.mymob != usr))
		return
	var/mob/user = hud.mymob
	// just redirect clicks

	if(user.active_hand_index == held_index)
		var/obj/item/I = user.get_active_held_item()
		if(I)
			I.Click(location, control, params)
	else
		var/obj/item/I = user.get_inactive_held_item()
		if(I)
			I.Click(location, control, params)
		else
			user.swap_hand(held_index)
	return TRUE


/atom/movable/screen/drop
	name = "drop"
	icon = 'icons/fallout/UI/screen_fallout2.dmi'
	icon_state = "act_drop"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/drop/Click()
	if(usr.stat == CONSCIOUS)
		usr.dropItemToGround(usr.get_active_held_item())

/atom/movable/screen/act_intent
	name = "intent"
	icon_state = "help"
	screen_loc = ui_acti

/atom/movable/screen/act_intent/Click(location, control, params)
	usr.a_intent_change(INTENT_HOTKEY_RIGHT)

/atom/movable/screen/act_intent/segmented/Click(location, control, params)
	if(usr.client.prefs.toggles & INTENT_STYLE)
		var/_x = text2num(params2list(params)["icon-x"])
		var/_y = text2num(params2list(params)["icon-y"])

		if(_x<=16 && _y<=16)
			usr.a_intent_change(INTENT_HARM)

		else if(_x<=16 && _y>=17)
			usr.a_intent_change(INTENT_HELP)

		else if(_x>=17 && _y<=16)
			usr.a_intent_change(INTENT_GRAB)

		else if(_x>=17 && _y>=17)
			usr.a_intent_change(INTENT_DISARM)
	else
		return ..()

/atom/movable/screen/act_intent/alien
	icon = 'icons/mob/screen_alien.dmi'
	screen_loc = ui_movi

/atom/movable/screen/act_intent/robot
	icon = 'icons/mob/screen_cyborg.dmi'
	screen_loc = ui_borg_intents

/atom/movable/screen/internals
	name = "toggle internals"
	icon_state = "internal0"
	screen_loc = ui_internal

/atom/movable/screen/internals/Click()
	if(!iscarbon(usr))
		return
	var/mob/living/carbon/C = usr
	if(C.incapacitated())
		return

	if(C.internal)
		C.internal = null
		to_chat(C, span_notice("You are no longer running on internals."))
		icon_state = "internal0"
	else
		if(!C.getorganslot(ORGAN_SLOT_BREATHING_TUBE))
			if(HAS_TRAIT(C, TRAIT_NO_INTERNALS))
				to_chat(C, span_warning("Due to cumbersome equipment or anatomy, you are currently unable to use internals!"))
				return
			var/obj/item/clothing/check
			var/internals = FALSE

			for(check in GET_INTERNAL_SLOTS(C))
				if(istype(check, /obj/item/clothing/mask))
					var/obj/item/clothing/mask/M = check
					if(M.mask_adjusted)
						M.adjustmask(C)
				if(CHECK_BITFIELD(check.clothing_flags, ALLOWINTERNALS))
					internals = TRUE
			if(!internals)
				to_chat(C, span_warning("You are not wearing an internals mask!"))
				return

		var/obj/item/I = C.is_holding_item_of_type(/obj/item/tank)
		if(I)
			to_chat(C, span_notice("You are now running on internals from [I] in your [C.get_held_index_name(C.get_held_index_of_item(I))]."))
			C.internal = I
		else if(ishuman(C))
			var/mob/living/carbon/human/H = C
			if(istype(H.s_store, /obj/item/tank))
				to_chat(H, span_notice("You are now running on internals from [H.s_store] on your [H.wear_suit.name]."))
				H.internal = H.s_store
			else if(istype(H.belt, /obj/item/tank))
				to_chat(H, span_notice("You are now running on internals from [H.belt] on your belt."))
				H.internal = H.belt
			else if(istype(H.l_store, /obj/item/tank))
				to_chat(H, span_notice("You are now running on internals from [H.l_store] in your left pocket."))
				H.internal = H.l_store
			else if(istype(H.r_store, /obj/item/tank))
				to_chat(H, span_notice("You are now running on internals from [H.r_store] in your right pocket."))
				H.internal = H.r_store

		//Separate so CO2 jetpacks are a little less cumbersome.
		if(!C.internal && istype(C.back, /obj/item/tank))
			to_chat(C, span_notice("You are now running on internals from [C.back] on your back."))
			C.internal = C.back

		if(C.internal)
			icon_state = "internal1"
		else
			to_chat(C, span_warning("You don't have an oxygen tank!"))
			return
	C.update_action_buttons_icon()

/atom/movable/screen/mov_intent
	name = "run/walk toggle"
	icon = 'icons/fallout/UI/screen_fallout2.dmi'
	icon_state = "running"

/atom/movable/screen/mov_intent/Click()
	toggle(usr)

/atom/movable/screen/mov_intent/update_icon_state()
	switch(hud?.mymob?.m_intent)
		if(MOVE_INTENT_WALK)
			icon_state = "walking"
		if(MOVE_INTENT_RUN)
			icon_state = "running"

/atom/movable/screen/mov_intent/proc/toggle(mob/user)
	if(isobserver(user))
		return
	user.toggle_move_intent(user)

/atom/movable/screen/pull
	name = "stop pulling"
	icon = 'icons/fallout/UI/screen_fallout2.dmi'
	icon_state = "pull"

/atom/movable/screen/pull/Click()
	if(isobserver(usr))
		return
	usr.stop_pulling()

/atom/movable/screen/pull/update_icon_state()
	if(hud?.mymob?.pulling)
		icon_state = "pull"
	else
		icon_state = "pull0"

/atom/movable/screen/resist
	name = "resist"
	icon = 'icons/fallout/UI/screen_fallout2.dmi'
	icon_state = "act_resist"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/resist/Click()
	if(isliving(usr))
		var/mob/living/L = usr
		L.resist()

/atom/movable/screen/questbook
	name = "Open Questbook"
	icon = 'icons/fallout/UI/buttons_fallout2.dmi'
	icon_state = "act_resist"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/questbook/Click()
	if(isliving(usr))
		SSeconomy.open_quest_console(usr)

/atom/movable/screen/scannerpls
	name = "Get a Quest Scanner"
	icon = 'icons/fallout/UI/buttons_fallout2.dmi'
	icon_state = "act_scannerpls"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/scannerpls/Click()
	if(isliving(usr))
		SSeconomy.give_claimer(usr, usr)

/atom/movable/screen/rest
	name = "rest"
	icon = 'icons/fallout/UI/screen_fallout2.dmi'
	icon_state = "act_rest"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/rest/Click()
	if(isliving(usr))
		var/mob/living/L = usr
		L.lay_down()

/atom/movable/screen/rest/update_icon_state()
	var/mob/living/user = hud?.mymob
	if(!istype(user))
		return
	if(!user.resting)
		icon_state = "act_rest"
	else
		icon_state = "act_rest0"

/atom/movable/screen/throw_catch
	name = "throw/catch"
	icon = 'icons/fallout/UI/screen_fallout2.dmi'
	icon_state = "act_throw_off"

/atom/movable/screen/throw_catch/Click()
	if(iscarbon(usr))
		var/mob/living/carbon/C = usr
		C.toggle_throw_mode()

/atom/movable/screen/zone_sel
	name = "damage zone"
	icon_state = "zone_sel"
	screen_loc = ui_zonesel
	var/overlay_icon = 'icons/mob/screen_gen.dmi'
	var/static/list/hover_overlays_cache = list()
	var/hovering

/atom/movable/screen/zone_sel/Click(location, control,params)
	if(isobserver(usr))
		return

	var/list/PL = params2list(params)
	var/icon_x = text2num(PL["icon-x"])
	var/icon_y = text2num(PL["icon-y"])
	var/choice = get_zone_at(icon_x, icon_y)
	if (!choice)
		return 1

	return set_selected_zone(choice, usr)

/atom/movable/screen/zone_sel/MouseEntered(location, control, params)
	if(isobserver(usr))
		return

	var/list/PL = params2list(params)
	var/icon_x = text2num(PL["icon-x"])
	var/icon_y = text2num(PL["icon-y"])
	var/choice = get_zone_at(icon_x, icon_y)

	if(hovering == choice)
		return
	vis_contents -= hover_overlays_cache[hovering]
	hovering = choice

	var/obj/effect/overlay/zone_sel/overlay_object = hover_overlays_cache[choice]
	if(!overlay_object)
		overlay_object = new
		overlay_object.icon_state = "[choice]"
		hover_overlays_cache[choice] = overlay_object
	vis_contents += overlay_object

/obj/effect/overlay/zone_sel
	icon = 'icons/mob/screen_gen.dmi'
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 128
	anchored = TRUE
	layer = ABOVE_HUD_LAYER
	plane = ABOVE_HUD_PLANE

/atom/movable/screen/zone_sel/MouseExited(location, control, params)
	if(!isobserver(usr) && hovering)
		vis_contents -= hover_overlays_cache[hovering]
		hovering = null

/atom/movable/screen/zone_sel/proc/get_zone_at(icon_x, icon_y)
	switch(icon_y)
		if(1 to 9) //Legs
			switch(icon_x)
				if(10 to 15)
					return BODY_ZONE_R_LEG
				if(17 to 22)
					return BODY_ZONE_L_LEG
		if(10 to 13) //Hands and groin
			switch(icon_x)
				if(8 to 11)
					return BODY_ZONE_R_ARM
				if(12 to 20)
					return BODY_ZONE_PRECISE_GROIN
				if(21 to 24)
					return BODY_ZONE_L_ARM
		if(14 to 22) //Chest and arms to shoulders
			switch(icon_x)
				if(8 to 11)
					return BODY_ZONE_R_ARM
				if(12 to 20)
					return BODY_ZONE_CHEST
				if(21 to 24)
					return BODY_ZONE_L_ARM
		if(23 to 30) //Head, but we need to check for eye or mouth
			if(icon_x in 12 to 20)
				switch(icon_y)
					if(23 to 24)
						if(icon_x in 15 to 17)
							return BODY_ZONE_PRECISE_MOUTH
					if(26) //Eyeline, eyes are on 15 and 17
						if(icon_x in 14 to 18)
							return BODY_ZONE_PRECISE_EYES
					if(25 to 27)
						if(icon_x in 15 to 17)
							return BODY_ZONE_PRECISE_EYES
				return BODY_ZONE_HEAD

/atom/movable/screen/zone_sel/proc/set_selected_zone(choice, mob/user)
	if(user != hud?.mymob)
		return

	if(choice != hud.mymob.zone_selected)
		hud.mymob.zone_selected = choice
		update_icon()

	return TRUE

/atom/movable/screen/zone_sel/update_overlays()
	. = ..()
	if(!hud?.mymob)
		return
	. += mutable_appearance(overlay_icon, "[hud.mymob.zone_selected]")

/atom/movable/screen/zone_sel/alien
	icon = 'icons/mob/screen_alien.dmi'
	overlay_icon = 'icons/mob/screen_alien.dmi'

/atom/movable/screen/zone_sel/robot
	icon = 'icons/mob/screen_cyborg.dmi'


/atom/movable/screen/flash
	name = "flash"
	icon_state = "blank"
	blend_mode = BLEND_ADD
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	layer = FLASH_LAYER
	plane = FULLSCREEN_PLANE

/atom/movable/screen/damageoverlay
	icon = 'icons/mob/screen_full.dmi'
	icon_state = "oxydamageoverlay0"
	name = "dmg"
	blend_mode = BLEND_MULTIPLY
	screen_loc = "CENTER-7,CENTER-7"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = UI_DAMAGE_LAYER
	plane = FULLSCREEN_PLANE

#define HEALTH_STATE_BASE 1
#define HEALTH_STATE_FLICKER 2
#define HEALTH_STATE_BLINK 3
#define HEALTH_STATE_BLINK_FLICKER 4

#define HEALTH_STATE_FLICKER_CYCLES 5

/atom/movable/screen/healths
	name = "health"
	icon_state = "health0"
	screen_loc = ui_health
	var/base_state = "%100"
	var/flicker_state = "%100"
	var/blink_state = "%100"
	var/blink_flicker_state = "%100"
	var/curr_text = "%100"
	var/curr_state = HEALTH_STATE_BASE
	/// and so we use a constantly looping global random lookup table and then modulo it against 240 to see if mario should blink this frame
	var/flicker_counter = 3 // in 0.2ths of a second
	var/flicker_counter_max = 3
	var/blink_counter = 200 
	var/blink_counter_max = 200
	var/reopen_counter = 2
	var/reopen_counter_max = 200
	var/update_counter = 5 // ticks before we auto-update

/atom/movable/screen/healths/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSfastprocess, src)

/atom/movable/screen/healths/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	. = ..()

/atom/movable/screen/healths/proc/FormattifyHealthText(mob/living/mymob, health_to_display)
	if(!mymob)
		base_state = "???%"
		flicker_state = "???%"
		return
	if(isnull(health_to_display))
		health_to_display = mymob.health
	var/dmg_before_crit = mymob.maxHealth - mymob.crit_threshold
	var/dmg_taken = mymob.maxHealth - health_to_display
	var/healthpercent = (((dmg_before_crit - dmg_taken) / (dmg_before_crit == 0 ? 0.01 : dmg_before_crit)) * 100) // displayed HP
	var/rawnum = round(healthpercent, mymob.HP_text_roundto)
	var/textnum_base = "%[rawnum]"
	var/textnum_flicker = "%[rawnum]"
	/// sexy monospaced console font
	// var/font_fam = "monospace"
	var/font_color_base = "#ffffff"
	var/font_color_flicker = "#ffffff"
	var/smiley_base = "'_'"
	var/smiley_flicker = "'_'"
	var/smiley_blink = "'_'"
	var/smiley_blink_flicker = "'_'"
	if(mymob.stat == DEAD)
		font_color_base = "#ffffff"
		font_color_base = "#ffffff"
		smiley_base = "-_- RIP"
		smiley_flicker = "-_- RIP"
		smiley_blink = "-_- RIP"
		smiley_blink_flicker = "-_- RIP"
	else if(healthpercent > 95)
		font_color_base = "#a8a8ff"
		font_color_flicker = "#a8a8ff"
		smiley_base = "^_^"
		smiley_flicker = "^_^"
		smiley_blink = "^_^"
		smiley_blink_flicker = "^_^"
	else if(healthpercent > 10)
		switch(healthpercent)
			if(90 to INFINITY)
				smiley_base          = "^_^"
				smiley_flicker       = "^_^"
				smiley_blink         = "^_^"
				smiley_blink_flicker = "^_^"
				font_color_base = "#5334ff"
				font_color_flicker = font_color_base
			if(85 to 90)
				smiley_base          = "^_^;"
				smiley_flicker       = "^_^;"
				smiley_blink         = "-_-;"
				smiley_blink_flicker = "-_-;"
				font_color_base = "#a8a8ff"
				font_color_flicker = font_color_base
			if(80 to 85)
				smiley_base          = "^_^;"
				smiley_flicker       = "^_^;"
				smiley_blink         = "-_-;"
				smiley_blink_flicker = "-_-;"
				font_color_base = "#b97cff"
				font_color_flicker = font_color_base
			if(75 to 80)
				smiley_base          = "'_'"
				smiley_flicker       = "'_'"
				smiley_blink         = "-_-"
				smiley_blink_flicker = "-_-"
				font_color_base = "#d2a1ff"
				font_color_flicker = font_color_base
			if(70 to 75)
				smiley_base          = "'_'"
				smiley_flicker       = "'_'"
				smiley_blink         = "-_-"
				smiley_blink_flicker = "-_-"
				font_color_base = "#e27bff"
				font_color_flicker = font_color_base
			if(65 to 70)
				smiley_base          = ";_;"
				smiley_flicker       = ";_;"
				smiley_blink         = "-_-"
				smiley_blink_flicker = "-_-"
				font_color_base = "#ff00bf"
				font_color_flicker = font_color_base
			if(60 to 65)
				smiley_base          = ";_;"
				smiley_flicker       = ";_;"
				smiley_blink         = "-_-"
				smiley_blink_flicker = "-_-"
				font_color_base = "#fff200"
				font_color_flicker = "#ffc400"
			if(55 to 60)
				smiley_base          = ";n;"
				smiley_flicker       = ";n;"
				smiley_blink         = "-n-"
				smiley_blink_flicker = "-n-"
				font_color_base = "#ffb700"
				font_color_flicker = "#ff7f00"
			if(50 to 55)
				smiley_base          = "*n*"
				smiley_flicker       = "*n*"
				smiley_blink         = "-n-"
				smiley_blink_flicker = "-n-"
				font_color_base = "#ff7f00"
				font_color_flicker = "#ff0000"
			if(45 to 50)
				smiley_base          = "@n@"
				smiley_flicker       = "@n@"
				smiley_blink         = "-n@"
				smiley_blink_flicker = "-n@"
				font_color_base = "#ff0000"
				font_color_flicker = "#ff0090"
			if(40 to 45)
				smiley_base          = "@n@"
				smiley_flicker       = "@n@"
				smiley_blink         = "-n-"
				smiley_blink_flicker = "-n-"
				font_color_base = "#e600ff"
				font_color_flicker = "#ff00bf"
			if(35 to 40)
				smiley_base          = "OnO"
				smiley_flicker       = "OnO"
				smiley_blink         = "-n-"
				smiley_blink_flicker = "-n-"
				font_color_base = "#e600ff"
				font_color_flicker = "#e100ff"
			if(30 to 35)
				smiley_base          = "0n0"
				smiley_flicker       = "0n0"
				smiley_blink         = "-n-"
				smiley_blink_flicker = "-n-"
				font_color_base = "#e600ff"
				font_color_flicker = "#9d0076"
			if(25 to 30)
				smiley_base          = "#n#"
				smiley_flicker       = "#n#"
				smiley_blink         = "-n-"
				smiley_blink_flicker = "-n-"
				font_color_base = "#e600ff"
				font_color_flicker = "#5f0047"
			if(20 to 25)
				smiley_base          = "#A#"
				smiley_flicker       = "#A#"
				smiley_blink         = "-A-"
				smiley_blink_flicker = "-A-"
				font_color_base = "#e600ff"
				font_color_flicker = "#840025"
			if(15 to 20)
				smiley_base          = ">A<"
				smiley_flicker       = ">A<"
				smiley_blink         = "-A-"
				smiley_blink_flicker = "-A-"
				font_color_base = "#ff00bf"
				font_color_flicker = "#840063"
			if(10 to 15)
				smiley_base          = "wAw"
				smiley_flicker       = "wAw"
				smiley_blink         = "-A-"
				smiley_blink_flicker = "-A-"
				font_color_base = "#ff0090"
				font_color_flicker = "#840063"
			if(5 to 10)
				smiley_base          = "xAx"
				smiley_flicker       = "xAx"
				smiley_blink         = "-A-"
				smiley_blink_flicker = "-A-"
				font_color_base = "#ff0070"
				font_color_flicker = "#840063"
			if(-INFINITY to 5)
				smiley_base    = "X.X"
				smiley_flicker = "X.X"
				smiley_blink   = "-.-"
				smiley_blink_flicker   = "-.-"
				font_color_base = "#ff0050"
				font_color_flicker = "#840063"
	else if(healthpercent > 0)
		font_color_base = "#ff00bf"
		font_color_flicker = "#840063"
		smiley_base = "XnX;;"
		smiley_flicker = "XnX;;"
		smiley_blink = "XnX;;"
		smiley_blink_flicker = "XnX;;"
	else // in crit lol
		// var/total_adjusted_hp = mymob.maxHealth + -HEALTH_THRESHOLD_DEAD // guaranteed to be bigger than dmg_before_crit
		// // how many times larger the health below crit is compared to above crit
		// // so if you have 20 HP before crit, and 80 HP after crit, this will be 4
		// var/crit_scalar = total_adjusted_hp / dmg_before_crit
		// /// we're in crit! so we need to scale down the health percentage to fit in the crit range
		// rawnum /= crit_scalar
		// rawnum = round(rawnum, mymob.HP_text_roundto)
		if(mymob.attackable_in_crit()) // we're downed, and attackable
			font_color_base      = "#ff0000"
			font_color_flicker   = "#350000"
			textnum_base         = "!![textnum_base]!!"
			textnum_flicker      = "!![textnum_flicker]!!"
			smiley_base          = ";XAX;"
			smiley_flicker       = ";XAX;"
			smiley_blink         = ";-A-;"
			smiley_blink_flicker = ";-A-;"
		else
			if(mymob.InFullCritical())
				textnum_base         = ">[textnum_base]<"
				textnum_flicker      = ">[textnum_flicker]<"
				smiley_base          = "/-_-\\"
				smiley_flicker       = "/-_-\\"
				smiley_blink         = "/-_-\\"
				smiley_blink_flicker = "/-_-\\"
				font_color_base = "#c3ddff"
				font_color_flicker = "#4d5662"
			else
				textnum_base         = "~[textnum_base]~"
				textnum_flicker      = "~[textnum_flicker]~"
				smiley_base          = "-,_-"
				smiley_flicker       = "-,_-"
				smiley_blink         = "-,n-"
				smiley_blink_flicker = "-,n-"
				font_color_base = "#9e8a8a"
				font_color_flicker = "#9e8a8a"
	base_state = "<font color='[font_color_base]'>[textnum_base]"
	flicker_state = "<font color='[font_color_flicker]'>[textnum_flicker]"
	blink_state = "<font color='[font_color_base]'>[textnum_base]"
	blink_flicker_state = "<font color='[font_color_flicker]'>[textnum_flicker]"
	var/datum/preferences/P = extract_prefs(mymob)
	if(P?.show_health_smilies)
		base_state += "<br>[smiley_base]"
		flicker_state += "<br>[smiley_flicker]"
		blink_state += "<br>[smiley_blink]"
		blink_flicker_state += "<br>[smiley_blink_flicker]"
		maptext_y = -8
	else
		maptext_y = 0
	base_state += "</font>"
	flicker_state += "</font>"
	blink_state += "</font>"
	blink_flicker_state += "</font>"


/atom/movable/screen/healths/process()
	update_counter--
	if(update_counter <= 0)
		update_counter = 5
		var/mob/living/maybeowner = hud.mymob
		if(maybeowner)
			FormattifyHealthText(maybeowner)
	flicker_counter--
	if(flicker_counter <= 0)
		flicker_counter = flicker_counter_max
		switch(curr_state) // invert our flicker state
			if(HEALTH_STATE_BASE)
				curr_state = HEALTH_STATE_FLICKER
			if(HEALTH_STATE_FLICKER)
				curr_state = HEALTH_STATE_BASE
			if(HEALTH_STATE_BLINK)
				curr_state = HEALTH_STATE_BLINK_FLICKER
			if(HEALTH_STATE_BLINK_FLICKER)
				curr_state = HEALTH_STATE_BLINK

	blink_counter--
	if(blink_counter <= 0)
		switch(curr_state)
			if(HEALTH_STATE_BASE)
				curr_state = HEALTH_STATE_BLINK
			if(HEALTH_STATE_FLICKER)
				curr_state = HEALTH_STATE_BLINK_FLICKER
		reopen_counter--
		if(reopen_counter <= 0)
			reopen_counter = reopen_counter_max
			blink_counter = rand(blink_counter_max, blink_counter_max * 2)
			if(curr_state == HEALTH_STATE_BLINK)
				curr_state = HEALTH_STATE_BASE
			if(curr_state == HEALTH_STATE_BLINK_FLICKER)
				curr_state = HEALTH_STATE_FLICKER

	switch(curr_state)
		if(HEALTH_STATE_BASE)
			curr_text = base_state
		if(HEALTH_STATE_FLICKER)
			curr_text = flicker_state
		if(HEALTH_STATE_BLINK)
			curr_text = blink_state
		if(HEALTH_STATE_BLINK_FLICKER)
			curr_text = blink_flicker_state
	maptext = curr_text
	maptext_width = 64


/atom/movable/screen/healths/alien
	icon = 'icons/mob/screen_alien.dmi'
	screen_loc = ui_alien_health

/atom/movable/screen/healths/robot
	icon = 'icons/mob/screen_cyborg.dmi'
	screen_loc = ui_borg_health

/atom/movable/screen/healths/blob
	name = "blob health"
	icon_state = "block"
	screen_loc = ui_internal
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/healths/blob/naut
	name = "health"
	icon = 'icons/mob/blob.dmi'
	icon_state = "nauthealth"

/atom/movable/screen/healths/blob/naut/core
	name = "overmind health"
	screen_loc = ui_health
	icon_state = "corehealth"

/atom/movable/screen/healths/guardian
	name = "summoner health"
	icon = 'icons/mob/guardian.dmi'
	icon_state = "base"
	screen_loc = ui_health
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/healths/clock
	icon = 'icons/mob/actions.dmi'
	icon_state = "bg_clock"
	screen_loc = ui_health
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/healths/clock/gear
	icon = 'icons/mob/clockwork_mobs.dmi'
	icon_state = "bg_gear"
	screen_loc = ui_internal

/atom/movable/screen/healths/revenant
	name = "essence"
	icon = 'icons/mob/actions.dmi'
	icon_state = "bg_revenant"
	screen_loc = ui_health
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/healths/construct
	icon = 'icons/mob/screen_construct.dmi'
	icon_state = "artificer_health0"
	screen_loc = ui_construct_health
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/healths/lavaland_elite
	icon = 'icons/mob/screen_elite.dmi'
	icon_state = "elite_health0"
	screen_loc = ui_health
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/healthdoll
	name = "health doll"
	screen_loc = ui_healthdoll

/atom/movable/screen/mood
	name = "mood"
	icon_state = "mood5"
	screen_loc = ui_mood

/atom/movable/screen/splash
	icon = 'icons/blank_title.png'
	icon_state = ""
	screen_loc = "1,1"
	plane = SPLASHSCREEN_PLANE
	var/client/holder

INITIALIZE_IMMEDIATE(/atom/movable/screen/splash)

/atom/movable/screen/splash/Initialize(mapload, client/C, visible, use_previous_title)
	. = ..()
	if(!istype(C))
		return

	holder = C

	if(!visible)
		alpha = 0

	if(!use_previous_title)
		if(SStitle.icon)
			icon = SStitle.icon
	else
		if(!SStitle.previous_icon)
			return INITIALIZE_HINT_QDEL
		icon = SStitle.previous_icon

	holder.screen += src

/atom/movable/screen/splash/proc/Fade(out, qdel_after = TRUE)
	if(QDELETED(src))
		return
	if(out)
		animate(src, alpha = 0, time = 30)
	else
		alpha = 0
		animate(src, alpha = 255, time = 30)
	if(qdel_after)
		QDEL_IN(src, 30)

/atom/movable/screen/splash/Destroy()
	if(holder)
		holder.screen -= src
		holder = null
	return ..()


/atom/movable/screen/component_button
	var/atom/movable/screen/parent

/atom/movable/screen/component_button/Initialize(mapload, atom/movable/screen/parent)
	. = ..()
	src.parent = parent

/atom/movable/screen/component_button/Click(params)
	if(parent)
		parent.component_click(src, params)
