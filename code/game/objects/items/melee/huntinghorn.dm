#define HH_WIELD_TIME (2 SECONDS)
#define HH_PERFORMANCE_RANGE 8 //tiles

/obj/item/huntinghorn
	name = "hunting horn"
	icon_state = "guitar"
	icon = 'icons/obj/musician.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/instruments_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/instruments_righthand.dmi'

	force = 20
	throwforce = 20
	force_unwielded = 20
	force_wielded = 40
	sharpness = SHARP_NONE
	weapon_special_component = /datum/component/weapon_special/single_turf

	var/readytoplay = FALSE
	var/list/notes = list()
	var/currentnote = 1
	var/list/datum/huntinghornsong/songlist = newlist(/datum/huntinghornsong,)
	var/list/datum/huntinghornsong/currentsongs = list()
	var/datum/song/handheld/intrument
	var/allowed_instrument_ids = "guitar"

/obj/item/huntinghorn/Initialize()
	..()
	intrument = new(src, allowed_instrument_ids)
	RegisterSignal(src, SIG_ITEM_WIELD, .proc/wield_horn)
	RegisterSignal(src, SIG_ITEM_UNWIELD, .proc/unwield_horn)

/obj/item/huntinghorn/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=20, force_wielded=40)

/obj/item/huntinghorn/Destroy()
	. = ..()
	UnregisterSignal(src, SIG_ITEM_WIELD)
	UnregisterSignal(src, SIG_ITEM_UNWIELD)

/obj/item/huntinghorn/attack_self(mob/user)
	if(SEND_SIGNAL(user, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE))
		var/choice = show_radial_menu(
			user,
			src,
			list(
				"low" = image(icon = 'icons/misc/mark.dmi', icon_state = "b1"),
				"medium" = image(icon = 'icons/misc/mark.dmi', icon_state = "b2"),
				"high" = image(icon = 'icons/misc/mark.dmi', icon_state = "b3"),
				"performance" = image(icon = 'icons/misc/mark.dmi', icon_state = "X"),
			),
			"huntinghornradial",
			CALLBACK(src, .proc/radial_check, user),
			radius = 42,
			require_near = TRUE,
			tooltips = TRUE,
		)
		switch(choice)
			if("low")
				currentnote = 1
				return
			if("medium")
				currentnote = 2
				return
			if("high")
				currentnote = 3
				return
			else
				perform()
				return

	if(!isliving(user) || user.stat || user.restrained())
		return
	//user.set_machine(instrument)
	intrument.ui_interact(user)

/obj/item/huntinghorn/proc/radial_check(mob/user)
	if(!isliving(user) || user.stat || user.restrained())
		return FALSE
	if(QDELETED(src) || user.is_holding(src))
		return FALSE

/obj/item/huntinghorn/proc/set_note(mob/user, to_set)
	currentnote = to_set
	if(currentnote > 3)
		currentnote = 1
	switch(currentnote)
		if(1)
			to_chat(user, span_info("You prepare a low note."))
			return
		if(2)
			to_chat(user, span_info("You prepare a middle note."))
			return
		if(3)
			to_chat(user, span_info("You prepare a high note."))
			return

	
/obj/item/huntinghorn/proc/wield_horn(obj/item/this, mob/user)
	SIGNAL_HANDLER

	spawn(HH_WIELD_TIME)
		if((user.get_active_held_item() == src) && wielded)
			set_ready_to_play(user, TRUE)

/obj/item/huntinghorn/proc/unwield_horn(obj/item/this, mob/user)
	SIGNAL_HANDLER

	set_ready_to_play(user, FALSE)

/obj/item/huntinghorn/proc/set_ready_to_play(mob/user, set_to)
	if(readytoplay == set_to)
		return
	readytoplay = set_to
	if(readytoplay)
		to_chat(user, span_info("You're ready to perform!"))
	else
		to_chat(user, span_info("You relax, finished with your performance for now."))
	currentsongs.Cut()
	notes.Cut()

/obj/item/huntinghorn/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!readytoplay || !CheckAttackCooldown(user, target))
		return
	if(user.a_intent != INTENT_HARM)
		return
	notes.Add(currentnote)
	if(length(notes) > 3)
		notes.Cut(1,length(notes)-2)
	for(var/datum/huntinghornsong/song in songlist)
		if(song.check_notes(notes))
			add_song_effect(user, song)


	// SONG HANDLING //

/obj/item/huntinghorn/proc/add_song_effect(mob/user, datum/huntinghornsong/song)
	if(currentsongs.Find(song))
		return
	currentsongs += song
	to_chat(user, span_info("You've prepared the [capitalize(song.name)]!"))

/obj/item/huntinghorn/proc/perform()
	for(var/datum/huntinghornsong/song in currentsongs)
		for(var/mob/living/L in range(src, HH_PERFORMANCE_RANGE))
			if(L.client)
				var/datum/status_effect/music/effect = new song.effect()
				L.apply_status_effect(effect)
	currentsongs = list()
	notes = list()

	/// HUNTING HORN SUBTYPES ///
	
/obj/item/huntinghorn/offense
	name = "hunting horn - offense"
	songlist = newlist(/datum/huntinghornsong/attack_up_xs, /datum/huntinghornsong/speed_up, /datum/huntinghornsong/cooldown_ignore)

/obj/item/huntinghorn/defense
	name = "hunting horn - defense"
	songlist = newlist(/datum/huntinghornsong/iron_skin, /datum/huntinghornsong/knockdown_res, /datum/huntinghornsong/divine_blessing)

/obj/item/huntinghorn/utility
	name = "hunting horn - utility"
	songlist = newlist(/datum/huntinghornsong/draw_speed, /datum/huntinghornsong/fast_actions, /datum/huntinghornsong/stamina_up)

/obj/item/huntinghorn/healing
	name = "hunting horn - healing"
	songlist = newlist(/datum/huntinghornsong/instaheal, /datum/huntinghornsong/recovery, /datum/huntinghornsong/maxhp_up)



/// SONG DATUMS ///

/datum/huntinghornsong
	var/name = "indescribable song"
	var/list/required_notes = list(1, 1, 1)
	var/datum/status_effect/music/effect = /datum/status_effect/music

/datum/huntinghornsong/proc/check_notes(list/notes)
	if(notes ~= required_notes)
		return TRUE
	return FALSE



	// OFFENSE //

/datum/huntinghornsong/attack_up_xs
	name = "song of strength"
	required_notes = list(2, 2, 2)
	effect = /datum/status_effect/music/attack_up_xs

/datum/huntinghornsong/speed_up
	name = "song of agility"
	required_notes = list(3, 2, 1)
	effect = /datum/status_effect/music/speed_up

/datum/huntinghornsong/cooldown_ignore
	name = "song of ruthlessness"
	required_notes = list(1, 1, 1)
	effect = /datum/status_effect/music/cooldown_ignore

	// DEFENSE //

/datum/huntinghornsong/iron_skin
	name = "song of endurance"
	required_notes = list(2, 1, 2)
	effect = /datum/status_effect/music/iron_skin

/datum/huntinghornsong/knockdown_res
	name = "song of steadiness"
	required_notes = list(1, 2, 1)
	effect = /datum/status_effect/music/knockdown_res

/datum/huntinghornsong/divine_blessing
	name = "song of luck"
	required_notes = list(3, 2, 1)
	effect = /datum/status_effect/music/divine_blessing

	// UTILITY //

/datum/huntinghornsong/draw_speed
	name = "song of alertness"
	required_notes = list(2, 2, 3)
	effect = /datum/status_effect/music/draw_speed

/datum/huntinghornsong/fast_actions
	name = "song of dexterity"
	required_notes = list(1, 2, 3)
	effect = /datum/status_effect/music/fast_actions

/datum/huntinghornsong/stamina_up
	name = "song of persistence"
	required_notes = list(3, 2, 3)
	effect = /datum/status_effect/music/stamina_up

	// HEALING //

/datum/huntinghornsong/instaheal
	name = "song of health"
	required_notes = list(3, 3, 3)
	effect = /datum/status_effect/music/instaheal

/datum/huntinghornsong/recovery
	name = "song of recovery"
	required_notes = list(1, 2, 3)
	effect = /datum/status_effect/music/instaheal

/datum/huntinghornsong/maxhp_up
	name = "song of vigor"
	required_notes = list(1, 1, 1)
	effect = /datum/status_effect/music/maxhp_up
