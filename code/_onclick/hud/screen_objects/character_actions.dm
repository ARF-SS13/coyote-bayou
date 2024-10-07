//-->Addition of some character actions that go on the same spot

/atom/movable/screen/autowhisper
	name = "autowhisper"
	icon_state = "autowhisper0"
	screen_loc = ui_character_actions

/atom/movable/screen/autowhisper/Click(location,control,params)
	var/mob/M = usr
	M.is_autowhisper = M.is_autowhisper ? FALSE : TRUE
	if(M.is_autowhisper)
		to_chat(M, span_notice("You'll now whisper everything you say."))
		icon_state = "autowhisper1"
	else
		to_chat(M, span_notice("You'll no longer whisper everything you say."))
		icon_state = "autowhisper0"

/atom/movable/screen/pose
	name = "pose"
	icon_state = "pose"
	screen_loc = ui_character_actions

/atom/movable/screen/pose/Click(location,control,params)
	var/mob/M = usr
	M.manage_flavor_tests()

/atom/movable/screen/up
	name = "up"
	icon_state = "up"
	screen_loc = ui_character_actions

/atom/movable/screen/up/Click(location,control,params)
	if(isliving(usr))
		var/mob/living/L = usr
		to_chat(L, span_danger("Double clicking on the same button will make you travel up, if possible."))
		L.lookup()

/atom/movable/screen/up/DblClick(location,control,params)
	var/mob/L = usr
	L.up()

/atom/movable/screen/down
	name = "down"
	icon_state = "down"
	screen_loc = ui_character_actions

/atom/movable/screen/down/Click(location,control,params)
	var/mob/L = usr
	L.down()

/atom/movable/screen/sleep_hud_button
	name = "sleep toggle"
	icon_state = "sleep"
	screen_loc = ui_character_actions

/atom/movable/screen/sleep_hud_button/Click(location,control,params)
	if(isliving(usr))
		var/mob/living/L = usr
		L.toggle_mob_sleep()

// Despite being defined, this doesn't render on screen in any capacity, didnt extensively test
/atom/movable/screen/roll_hud_button
	name = "roll dice"
	icon_state = "skillcheck"
	screen_loc = ui_mood

/atom/movable/screen/roll_hud_button/Click(location,control,params,mob/user)
// This stuff needs to be changed because it was directly lifted from clothing
	var/static/list/choices = list(
			"Black" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black"),
			"Green Stripe" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black-green"),
			"Orange Stripe" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black-orange"),
			"Blue Stripe" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black-blue"),
			"Red Stripe" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black-red"),
			"Medic Marks" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black-med"),
			"Engi Marks" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black-engie"),
		)
	var/choice = show_radial_menu(user, src, choices, radius = 32, require_near = TRUE)
	switch(choice)
		if("Black")
			user.say(forced = "*special_strength")
		if("Green Stripe")
			user.say(forced = "*special_perception")
		if("Orange Stripe")
			user.say(forced = "*special_endurance")
		if("Blue Stripe")
			user.say(forced = "*special_charisma")
		if("Red Stripe")
			user.say(forced = "*special_intelligence")
		if("Medic Marks")
			user.say(forced = "*special_agility")
		if("Engi Marks")
			user.say(forced = "*special_luck")
		else
			return

/atom/movable/screen/triage
	name = "triage button"
	icon_state = "triage"
	screen_loc = ui_character_actions

/atom/movable/screen/triage/Click(location,control,params)
	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		if(isnull(H.get_active_held_item()))
			if(HAS_TRAIT(H, TRAIT_HEAL_TONGUE))
				H.emote("lick")
			else if(HAS_TRAIT(H, TRAIT_HEAL_TOUCH))
				H.emote("touch")
			else if(HAS_TRAIT(H, TRAIT_HEAL_TEND))
				H.emote("tend")

/atom/movable/screen/triage/DblClick(location,control,params)
	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		var/obj/item/I = H.get_active_held_item()
		if(isnull(I))
			if(HAS_TRAIT(H, TRAIT_HEAL_TONGUE))
				H.emote("lick")
			else if(HAS_TRAIT(H, TRAIT_HEAL_TOUCH))
				H.emote("touch")
			else if(HAS_TRAIT(H, TRAIT_HEAL_TEND))
				H.emote("tend")

			I = H.get_active_held_item()
			I?.melee_attack_chain(H, H, params)

		else if(istype(I, /obj/item/hand_item/tactile/))
			I = H.get_active_held_item()
			I?.melee_attack_chain(H, H, params)

/atom/movable/screen/aooc_hud_button
	name = "AOOC"
	icon_state = "aooc"
	screen_loc = ui_character_actions

/atom/movable/screen/aooc_hud_button/Click(location,control,params)
	if(usr.client)
		var/msg = input(usr, "AOOC Message", "AOOC", null)
		usr.client.aooc(msg)

/atom/movable/screen/newbie_hud_button
	name = "Help/Newbie"
	icon_state = "newbie"
	screen_loc = ui_character_actions

/atom/movable/screen/newbie_hud_button/Click(location,control,params)
	if(usr.client)
		var/msg = input(usr, "Help/Newbie Message", "Help/Newbie", null)
		usr.client.newbie(msg)

/atom/movable/screen/chardir_hud_button
	name = "Character Directory"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "chardir"
	screen_loc = ui_bayou

// /atom/movable/screen/chardir_hud_button/Click(location,control,params)
// 	if(usr.client)
// 		usr.client.show_character_directory()

/atom/movable/screen/pvp_focus_toggle
	name = "PVP focus On/Off"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "pvp_blank"
	screen_loc = ui_pvpbuttons
	var/mytobe = PVP_NEUTRAL

/atom/movable/screen/pvp_focus_toggle/Initialize(mapload)
	. = ..()
	update_icon()

/atom/movable/screen/pvp_focus_toggle/Click(location,control,params)
	if(!usr.client || !ismob(usr))
		return

	var/changeto = PVP_NEUTRAL
	var/_y = text2num(params2list(params)["icon-y"])
	if(_y>=25) // PVP focus on
		if(HAS_TRAIT(usr, TRAIT_PVPFOC))
			changeto = PVP_NEUTRAL
		else
			changeto = PVP_YES
	else if(_y>=17) // PVP opt out on
		if(HAS_TRAIT(usr, TRAIT_PVEFOC))
			changeto = PVP_NEUTRAL
		else
			changeto = PVP_NO
	usr.SetPVPflag(changeto, TRUE)

/atom/movable/screen/pvp_focus_toggle/proc/update_intento(towhat)
	mytobe = towhat
	update_icon()

/atom/movable/screen/pvp_focus_toggle/update_overlays()
	. = ..()
	var/mutable_appearance/top = mutable_appearance('icons/mob/screen_gen.dmi')
	var/mutable_appearance/bottom = mutable_appearance('icons/mob/screen_gen.dmi')
	switch(mytobe)
		if(PVP_NEUTRAL)
			top.icon_state = "pvp_top_off"
			bottom.icon_state = "pvp_bottom_off"
		if(PVP_YES)
			top.icon_state = "pvp_top_on"
			bottom.icon_state = "pvp_bottom_off"
		if(PVP_NO)
			top.icon_state = "pvp_top_off"
			bottom.icon_state = "pvp_bottom_on"
	. += top
	. += bottom


