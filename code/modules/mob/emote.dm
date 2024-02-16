//The code execution of the emote datum is located at code/datums/emotes.dm
/mob/proc/emote(act, m_type = null, message = null, intentional = FALSE, only_overhead, forced)
	var/input_text = lowertext(act)
	var/param = message
	var/custom_param = findchar(input_text, " ")
	if(custom_param)
		param = copytext(act, custom_param + length(act[custom_param]))
		input_text = copytext(input_text, 1, custom_param)

	var/datum/emote/E
	E = E.emote_list[input_text]
	if(!E)
		to_chat(src, span_notice("Unusable emote '[act]'. Say *help for a list."))
		return
	E.run_emote(src, param, m_type, intentional, only_overhead, forced)

/datum/emote/spin
	key = "spin"
	key_third_person = "spins"
	restraint_check = TRUE
	cooldown = 4 SECONDS
	sound = 'sound/effects/spin.ogg'
	sound_volume = 100
	mob_type_allowed_typecache = list(/mob/living, /mob/dead/observer)
	mob_type_ignore_stat_typecache = list(/mob/dead/observer)

/datum/emote/spin/run_emote(mob/user)
	. = ..()
	if(.)
		user.spin(20, 1)

		if(iscyborg(user) && user.has_buckled_mobs())
			var/mob/living/silicon/robot/R = user
			var/datum/component/riding/riding_datum = R.GetComponent(/datum/component/riding)
			if(riding_datum)
				for(var/mob/M in R.buckled_mobs)
					riding_datum.force_dismount(M)
			else
				R.unbuckle_all_mobs()

/datum/emote/flip
	key = "flip"
	key_third_person = "flips"
	restraint_check = TRUE
	cooldown = 4 SECONDS
	sound = 'sound/effects/flip.ogg'
	sound_volume = 100
	mob_type_allowed_typecache = list(/mob/living, /mob/dead/observer)
	mob_type_ignore_stat_typecache = list(/mob/dead/observer)

/datum/emote/flip/run_emote(mob/user, params)
	. = ..()
	if(.)
		user.SpinAnimation(7,1)

/datum/emote/flip/run_emote(mob/living/user, params)
	if(ishuman(user))
		user.adjustStaminaLoss(5)
	. = ..()
