/obj/effect/proc_holder/spell/targeted/telepathy
	name = "Telepathy"
	desc = "Telepathically transmits a message to the target."
	charge_max = 0
	clothes_req = NONE
	range = 7
	include_user = 0
	action_icon = 'icons/mob/actions/actions_revenant.dmi'
	action_icon_state = "r_transmit"
	action_background_icon_state = "bg_spell"
	antimagic_allowed = TRUE
	var/notice = "notice"
	var/boldnotice = "boldnotice"
	var/magic_check = FALSE
	var/holy_check = FALSE
	var/tinfoil_check = TRUE

/obj/effect/proc_holder/spell/targeted/telepathy/cast(list/targets, mob/living/user = usr)
	for(var/mob/living/M in targets)
		var/msg = stripped_input(usr, "What do you wish to tell [M]?", null, "")
		if(!msg)
			charge_counter = charge_max
			return FALSE
		log_directed_talk(user, M, msg, LOG_SAY, "[name]")
		to_chat(user, "<span class='[boldnotice]'>You transmit to [M]:</span> <span class='[notice]'>[msg]</span>")
		if(!M.anti_magic_check(magic_check, holy_check, tinfoil_check, 0)) //hear no evil
			to_chat(M, "<span class='[boldnotice]'>You hear something behind you talking...</span> <span class='[notice]'>[msg]</span>")
		for(var/ded in GLOB.dead_mob_list)
			if(!isobserver(ded))
				continue
			var/follow_rev = FOLLOW_LINK(ded, user)
			var/follow_whispee = FOLLOW_LINK(ded, M)
			to_chat(ded, "[follow_rev] <span class='[boldnotice]'>[user] [name]:</span> <span class='[notice]'>\"[msg]\" to</span> [follow_whispee] <span class='name'>[M]</span>")
	return TRUE

///Quirk version with a visible emote and sound that gives you away. Also, doesn't change your genes so you can't cheese genetics.
/obj/effect/proc_holder/spell/targeted/telepathy/quirk
	name = "Innate Telepathy"
	action_icon = 'icons/mob/actions/actions_spells.dmi'
	action_icon_state = "telepathy"
	action_background_icon_state = "bg_spell"
	invocation = "glows softly with telepathic energy."
	invocation_type = "me"
	clothes_req = FALSE
	magic_check = FALSE
	clothes_req = NONE
	//the built in sound system wasn't working right so here we go.
	var/target_sound = 'sound/effects/well_wake.ogg'
	var/self_sound = 'sound/effects/well_whine.ogg'
	overlay = TRUE
	overlay_icon_state = "telepathy"
	overlay_lifespan = 2 SECONDS
	charge_max = 5 SECONDS

/obj/effect/proc_holder/spell/targeted/telepathy/quirk/perform(list/targets, recharge = TRUE, mob/user = usr) //if recharge is started is important for the trigger spells
	before_cast(targets)

	if(user && user.ckey)
		user.log_message(span_danger("cast the spell [name]."), LOG_ATTACK)

	if(recharge)
		recharging = TRUE
	
	if(cast(targets,user=user))
		after_cast(targets, user)

	if(action)
		action.UpdateButtonIcon()

/obj/effect/proc_holder/spell/targeted/telepathy/quirk/before_cast(list/targets)
	return

/obj/effect/proc_holder/spell/targeted/telepathy/quirk/after_cast(list/targets, mob/living/user = usr)
	. = ..()
	invocation(user)
	do_overlays(targets, user)
	playsound(get_turf(user), self_sound, 50, 1)
	for(var/A in targets)
		playsound(get_turf(A), target_sound, 50, 1)
