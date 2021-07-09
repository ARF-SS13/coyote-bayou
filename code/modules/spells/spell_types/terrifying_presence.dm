/* Voice of God, but useless outside of RP situations */
/obj/effect/proc_holder/spell/terrifying_presence
	name = "Terrifying Presence"
	desc = "Speak with an incredibly compelling voice, possibly scaring everyone around you."
	charge_max = 5 MINUTES // No spam
	cooldown_min = 0
	level_max = 1
	clothes_req = NONE
	antimagic_allowed = TRUE
	action_icon = 'icons/mob/actions/actions_spells.dmi'
	action_icon_state = "terri_presence"
	var/message_said
	var/list/span_list = list("danger")
	var/speech_sound = 'sound/f13effects/surrender.ogg'

/obj/effect/proc_holder/spell/terrifying_presence/can_cast(mob/living/user = usr, skipcharge = FALSE, silent = TRUE)
	if(!user.can_speak())
		if(!silent)
			to_chat(user, "<span class='warning'>You are unable to speak!</span>")
		return FALSE
	if(!skipcharge && !charge_check(user, silent))
		return FALSE
	if(user.stat && !stat_allowed)
		if(!silent)
			to_chat(user, "<span class='notice'>Not when you're incapacitated.</span>")
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/terrifying_presence/choose_targets(mob/living/user = usr)
	perform(user=user)

/obj/effect/proc_holder/spell/terrifying_presence/perform(list/targets, recharge = 1, mob/living/user = usr)
	message_said = stripped_input(user, "Speak with the Terrifying Presence", "Command")
	if(!message_said)
		revert_cast()
		return
	..()

/obj/effect/proc_holder/spell/terrifying_presence/cast(list/targets, mob/living/user = usr)
	user.say(message_said, spans = span_list, sanitize = FALSE)
	playsound(get_turf(user), speech_sound, 100, 1, 5)
	for(var/mob/living/carbon/C in get_hearers_in_view(7, user))
		if(!faction_check((user.faction - "neutral"), C.faction))
			C.jitteriness += 5 // Scary, oooooo
