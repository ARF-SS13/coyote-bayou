

/mob/living/simple_animal/on_attack_hand(mob/living/carbon/human/M)
	. = ..()
	if(.) //the attack was blocked
		return
	var/datum/martial_art/attacker_style
	if(M.mind)
		attacker_style = M.mind.martial_art
		if(attacker_style?.pacifism_check && HAS_TRAIT(M, TRAIT_PACIFISM)) // most martial arts are quite harmful, alas.
			attacker_style = null

	switch(M.a_intent)
		if(INTENT_HELP)
			if (health > 0)
				if(!resting)
					visible_message(span_notice("[M] [response_help_continuous] [src]."), \
									span_notice("[M] [response_help_continuous] you."), null, null, null,
									M, span_notice("You [response_help_simple] [src]."))
					playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
				
				else
					M.visible_message(span_warning("[M] helps over [src]."),
						span_notice("You help to get [src] back on its feet."))
					to_chat(src, span_userdanger("You are being helped to get back up by [M]!"))
					playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)

					icon = initial(icon)
					icon_state = icon_living
					density = initial(density)
					lying = FALSE
					set_resting(FALSE, silent = TRUE, updating = TRUE)
					setMovetype(initial(movement_type))

		if(INTENT_GRAB)
			if(!client && M.incapacitated())
				to_chat(M, span_notice("You're too messed up to fight!"))
				return
			if(attacker_style && attacker_style.grab_act(M,src))
				return TRUE
			grabbedby(M)

		if(INTENT_DISARM)
			if(!client && M.incapacitated())
				to_chat(M, span_notice("You're too messed up to fight!"))
				return
			if(attacker_style && attacker_style.disarm_act(M,src))
				return TRUE
			M.do_attack_animation(src, ATTACK_EFFECT_DISARM)
			visible_message(span_danger("[M] [response_disarm_continuous] [src]!"),\
							span_danger("[M] [response_disarm_continuous] you!"), null, COMBAT_MESSAGE_RANGE, null, \
							M, span_danger("You [response_disarm_simple] [src]!"))
			playsound(src, 'sound/weapons/thudswoosh.ogg', 25, 1)
			log_combat(M, src, "disarmed")

		if(INTENT_HARM)
			if(HAS_TRAIT(M, TRAIT_PACIFISM))
				to_chat(M, span_notice("You don't want to hurt [src]!"))
				return
			if(!client && M.incapacitated())
				to_chat(M, span_notice("You're too messed up to fight!"))
				return
			if(attacker_style && attacker_style.harm_act(M,src))
				return TRUE
			M.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
			visible_message(span_danger("[M] [response_harm_continuous] [src]!"),\
							span_userdanger("[M] [response_harm_continuous] you!"), null, COMBAT_MESSAGE_RANGE, null, \
							M, span_danger("You [response_harm_simple] [src]!"))
			playsound(loc, attacked_sound, 25, 1, -1)
			attack_threshold_check(M.dna?.species.punchdamagehigh, M.dna?.species.attack_type, "melee")
			log_combat(M, src, "attacked")
			updatehealth()
			return TRUE

/mob/living/simple_animal/attack_hulk(mob/living/carbon/human/user, does_attack_animation = FALSE)
	if(user.a_intent == INTENT_HARM)
		. = ..(user, TRUE)
		if(.)
			return
		playsound(loc, "punch", 25, 1, -1)
		visible_message(span_danger("[user] punches [src]!"), \
			span_userdanger("[user] punches you!"), null, COMBAT_MESSAGE_RANGE, null, \
			user, span_danger("You punch [src]!"))
		adjustBruteLoss(15)
		return TRUE

/mob/living/simple_animal/attack_paw(mob/living/carbon/monkey/M)
	. = ..()
	if(.) //successful larva bite
		var/damage = rand(1, 3)
		attack_threshold_check(damage, BRUTE, "melee")
		return 1
	if (M.a_intent == INTENT_HELP)
		if (health > 0)
			visible_message(span_notice("[M.name] [response_help_continuous] [src]."), \
							span_notice("[M.name] [response_help_continuous] you."), \
							target = M, target_message = span_notice("You [response_help_simple] [src]."))
			playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)

/mob/living/simple_animal/attack_alien(mob/living/carbon/alien/humanoid/M)
	. = ..()
	if(!.) // the attack was blocked or was help/grab intent
		return
	if(M.a_intent == INTENT_DISARM)
		playsound(loc, 'sound/weapons/pierce.ogg', 25, 1, -1)
		visible_message(span_danger("[M] [response_disarm_continuous] [name]!"), \
				span_userdanger("[M] [response_disarm_continuous] [name]!"), null, COMBAT_MESSAGE_RANGE, null, \
				M, span_danger("You [response_disarm_simple] [name]!"))
		log_combat(M, src, "disarmed")
	else
		visible_message(span_danger("[M] has slashed at [src]!"), \
				span_userdanger("[M] has slashed at [src]!"), null, COMBAT_MESSAGE_RANGE, null, \
				M, span_danger("[M] has slashed at [src]!"))
		playsound(loc, 'sound/weapons/slice.ogg', 25, 1, -1)
		attack_threshold_check(M.meleeSlashSAPower, BRUTE, "melee")
		log_combat(M, src, "attacked")

/mob/living/simple_animal/attack_larva(mob/living/carbon/alien/larva/L)
	. = ..()
	if(. && stat != DEAD) //successful larva bite
		var/damage = rand(5, 10)
		. = attack_threshold_check(damage, BRUTE, "melee")
		if(.)
			L.amount_grown = min(L.amount_grown + damage, L.max_grown)

/mob/living/simple_animal/attack_animal(mob/living/simple_animal/M)
	. = ..()
	if(.)
		var/damage = .
		return attack_threshold_check(damage, M.melee_damage_type, "melee")

/mob/living/simple_animal/attack_slime(mob/living/simple_animal/slime/M)
	. = ..()
	if(.) //successful slime shock
		var/damage = rand(15, 25)
		if(M.is_adult)
			damage = rand(20, 35)
		return attack_threshold_check(damage, BRUTE, "melee")

/mob/living/simple_animal/attack_drone(mob/living/simple_animal/drone/M)
	if(M.a_intent == INTENT_HARM) //No kicking dogs even as a rogue drone. Use a weapon.
		return
	return ..()

/mob/living/simple_animal/proc/attack_threshold_check(damage, damagetype = BRUTE, armorcheck = "melee")
	var/armor = run_armor_check(null, armorcheck, null, null, 0, null)
	var/dt = max(run_armor_check(null, "damage_threshold", null, null, 0, null), 0)
	apply_damage(damage, damagetype, null, armor, null, null, null, damage_threshold = dt)
	return TRUE

/mob/living/simple_animal/bullet_act(obj/item/projectile/P)
	var/totaldamage = P.damage
	var/staminadamage = P.stamina
	var/final_percent = 0
	var/armor = run_armor_check(null, P.flag, null, null, P.armour_penetration, null)
	var/dt = max(run_armor_check(null, "damage_threshold", null, null, 0, null) - P.damage_threshold_penetration, 0)
	if(!P.nodamage)
		apply_damage(totaldamage, P.damage_type, null, armor, null, null, null, damage_threshold = dt)
		if(staminadamage)
			apply_damage(staminadamage, STAMINA, null, armor, null, null, null, damage_threshold = dt)
	var/missing = 100 - final_percent
	var/armor_ratio = armor * 0.01
	if(missing > 0)
		final_percent += missing * armor_ratio
	P.finalmost_damage = totaldamage * (final_percent * 0.01)
	return P.on_hit(src, final_percent, null) ? BULLET_ACT_HIT : BULLET_ACT_BLOCK

/* 	if(!Proj)
		return
	apply_damage(Proj.damage, Proj.damage_type)
	Proj.on_hit(src)
	return BULLET_ACT_HIT */

/mob/living/simple_animal/ex_act(severity, target, origin)
	if(origin && istype(origin, /datum/spacevine_mutation) && isvineimmune(src))
		return
	..()
	var/bomb_armor = getarmor(null, "bomb")
	switch (severity)
		if (EXPLODE_DEVASTATE)
			adjustBruteLoss(500 * (1-min(bomb_armor,100)/100))
			if(health < 0 && bombs_can_gib_me)
				gib()
				return
		if (EXPLODE_HEAVY)
			var/bloss = 100
			if(prob(bomb_armor))
				bloss = bloss / 1.5
			adjustBruteLoss(bloss)

		if(EXPLODE_LIGHT)
			var/bloss = 50
			if(prob(bomb_armor))
				bloss = bloss / 1.5
			adjustBruteLoss(bloss)

/mob/living/simple_animal/blob_act(obj/structure/blob/B)
	adjustBruteLoss(20)
	return

/mob/living/simple_animal/do_attack_animation(atom/A, visual_effect_icon, used_item, no_effect)
	if(!no_effect && !visual_effect_icon && melee_damage_upper)
		if(melee_damage_upper < 10)
			visual_effect_icon = ATTACK_EFFECT_PUNCH
		else
			visual_effect_icon = ATTACK_EFFECT_SMASH
	..()

/mob/living/simple_animal/getarmor(def_zone = null, type)
	return mob_armor.getRating(type)
