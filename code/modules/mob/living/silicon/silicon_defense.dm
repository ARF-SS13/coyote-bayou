/mob/living/silicon/KnockToFloor(disarm_items = FALSE, silent = TRUE, updating = TRUE)
	return

/mob/living/silicon/grippedby(mob/living/user, instant = FALSE)
	return //can't upgrade a simple pull into a more aggressive grab.

/mob/living/silicon/get_ear_protection()//no ears
	return 2

/mob/living/silicon/attack_alien(mob/living/carbon/alien/humanoid/M)
	. = ..()
	if(!.) // the attack was blocked or was help/grab intent
		return
	if(M.a_intent == INTENT_HARM)
		var/list/damage_return = islist(.) ? . : list()
		var/damage = GET_DAMAGE(damage_return)
		log_combat(M, src, "attacked")
		playsound(loc, 'sound/weapons/slash.ogg', 25, 1, -1)
		visible_message(
			span_danger("[M] has slashed at [src]!"),
			span_userdanger("[M] has slashed at you!"),
			target = M,
			target_message = span_danger("You have slashed at [src]!")
		)
		if(prob(8))
			flash_act(affect_silicon = 1)
		log_combat(M, src, "attacked")
		updatehealth()

/mob/living/silicon/post_attack_animal(mob/living/simple_animal/M, list/damage_list = DAMAGE_LIST)
	. = ..()
	var/damage = GET_DAMAGE(damage_list)
	if(!prob(damage))
		return damage_list
	for(var/mob/living/N in buckled_mobs)
		N.DefaultCombatKnockdown(20)
		unbuckle_mob(N)
		N.visible_message(span_boldwarning(
			"[N] is knocked off of [src] by [M]!"),
			span_boldwarning("You are knocked off of [src] by [M]!")
		)

/mob/living/silicon/attack_hulk(mob/living/carbon/human/user, does_attack_animation = FALSE)
	if(user.a_intent == INTENT_HARM)
		. = ..(user, TRUE)
		if(.)
			return
		adjustBruteLoss(rand(10, 15))
		playsound(loc, "punch", 25, 1, -1)
		visible_message(span_danger("[user] has punched [src]!"), \
				span_userdanger("[user] has punched you!"), target = user, \
				target_message = span_danger("You have punched [src]!"))
		return TRUE
	return FALSE

/mob/living/silicon/on_attack_hand(mob/living/carbon/human/M)
	. = ..()
	if(.) //the attack was blocked
		return
	switch(M.a_intent)
		if (INTENT_HELP)
			M.visible_message("[M] pets [src].", \
							span_notice("You pet [src]."), target = src,
							target_message = "[M] pets you.")
		if(INTENT_GRAB)
			grabbedby(M)
		else
			M.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
			playsound(src.loc, 'sound/effects/bang.ogg', 10, 1)
			visible_message(span_danger("[M] punches [src], but doesn't leave a dent."), \
				span_warning("[M] punches you, but doesn't leave a dent."), null, COMBAT_MESSAGE_RANGE, null, M,
				span_danger("You punch [src], but don't leave a dent."))

/mob/living/silicon/attack_drone(mob/living/simple_animal/drone/M)
	if(M.a_intent == INTENT_HARM)
		return
	return ..()

/mob/living/silicon/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	if(buckled_mobs)
		for(var/mob/living/M in buckled_mobs)
			unbuckle_mob(M)
			M.electrocute_act(shock_damage/100, source, siemens_coeff, flags)	//Hard metal shell conducts!
	return 0 //So borgs they don't die trying to fix wiring

/mob/living/silicon/emp_act(severity)
	. = ..()
	to_chat(src, span_danger("Warning: Electromagnetic pulse detected."))
	if(. & EMP_PROTECT_SELF)
		return
	src.take_bodypart_damage(severity/5)
	to_chat(src, span_userdanger("*BZZZT*"))
	for(var/mob/living/M in buckled_mobs)
		if(prob(severity/2))
			unbuckle_mob(M)
			M.DefaultCombatKnockdown(40)
			M.visible_message(span_boldwarning("[M] is thrown off of [src]!"),
				span_boldwarning("You are thrown off of [src]!"))
	flash_act(affect_silicon = 1)

/mob/living/silicon/flash_act(intensity = 1, override_blindness_check = 0, affect_silicon = 0, visual = 0, type = /obj/screen/fullscreen/flash/static)
	if(affect_silicon)
		return ..()
