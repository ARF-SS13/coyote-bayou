#define STRONG_PUNCH_COMBO "HH"
#define LAUNCH_KICK_COMBO "HD"
#define DROP_KICK_COMBO "HG"

/datum/martial_art/the_sleeping_carp
	name = "The Sleeping Carp"
	id = MARTIALART_SLEEPINGCARP
	allow_temp_override = FALSE
	help_verb = /mob/living/carbon/human/proc/sleeping_carp_help
	pugilist = TRUE
	var/physdammod = 0.5
	var/stamdammod = 0.2
/*
/datum/martial_art/the_sleeping_carp/proc/check_streak(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(findtext(streak,STRONG_PUNCH_COMBO))
		streak = ""
		strongPunch(A,D)
		return TRUE
	if(findtext(streak,LAUNCH_KICK_COMBO))
		streak = ""
		launchKick(A,D)
		return TRUE
	if(findtext(streak,DROP_KICK_COMBO))
		streak = ""
		dropKick(A,D)
		return TRUE
	return FALSE

///Gnashing Teeth: Harm Harm, high force punch on every second harm punch, has a chance to crit for near triple damage
/datum/martial_art/the_sleeping_carp/proc/strongPunch(mob/living/carbon/human/A, mob/living/carbon/human/D)
	///this var is so that the strong punch is always aiming for the body part the user is targeting and not trying to apply to the chest before deviating
	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected))
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	var/atk_verb = pick("precisely kick", "brutally chop", "cleanly hit", "viciously slam")
	///this is the critical hit damage added to the attack if it rolls, it starts at 0 because it'll be changed when rolled
	var/crit_damage = 0
	var/damage = damage_roll(A,D)
	D.visible_message(span_danger("[A] [atk_verb]s [D]!"), \
					span_userdanger("[A] [atk_verb]s you!"), null, null, A)
	to_chat(A, span_danger("You [atk_verb] [D]!"))
	if(prob(10))
		crit_damage += (damage*2 + 15)
		playsound(get_turf(D), 'sound/weapons/bite.ogg', 50, TRUE, -1)
		D.visible_message(span_warning("[D] staggers as the blow strikes them with inhuman force!"), span_userdanger("You are struck with incredible precision by [A]!"))
		log_combat(A, D, "critcal strong punched (Sleeping Carp)")//log it here because a critical can swing for 40 force and it's important for the sake of how hard they hit
	else
		playsound(get_turf(D), 'sound/weapons/punch1.ogg', 25, TRUE, -1)
		log_combat(A, D, "strong punched (Sleeping Carp)")//so as to not double up on logging
	D.apply_damage((damage + 15) + crit_damage, BRUTE, affecting, wound_bonus = CANT_WOUND)
	return TRUE

///Crashing Wave Kick: Harm Disarm combo, throws people seven tiles backwards
/datum/martial_art/the_sleeping_carp/proc/launchKick(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/damage = (damage_roll(A,D) + 15)
	A.do_attack_animation(D, ATTACK_EFFECT_KICK)
	D.visible_message(span_warning("[A] kicks [D] square in the chest, sending them flying!"), \
					span_userdanger("You are kicked square in the chest by [A], sending you flying!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, A)
	playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	var/atom/throw_target = get_edge_target_turf(D, A.dir)
	D.throw_at(throw_target, 7, 14, A)
	D.apply_damage(damage, BRUTE, BODY_ZONE_CHEST, wound_bonus = CANT_WOUND, wound_bonus = CANT_WOUND)
	log_combat(A, D, "launchkicked (Sleeping Carp)")
	return TRUE

///Keelhaul: Harm Grab combo, knocks people down, deals stamina damage while they're on the floor
/datum/martial_art/the_sleeping_carp/proc/dropKick(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/damage = damage_roll(A,D)
	A.do_attack_animation(D, ATTACK_EFFECT_KICK)
	playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	if((D.mobility_flags & MOBILITY_STAND))
		D.apply_damage(damage, BRUTE, BODY_ZONE_HEAD, wound_bonus = CANT_WOUND)
		D.DefaultCombatKnockdown(50, override_hardstun = 0.01, override_stamdmg = 0)
		D.apply_damage(damage + 35, STAMINA, BODY_ZONE_HEAD, wound_bonus = CANT_WOUND) //A cit specific change form the tg port to really punish anyone who tries to stand up
		D.visible_message(span_warning("[A] kicks [D] in the head, sending them face first into the floor!"), \
					span_userdanger("You are kicked in the head by [A], sending you crashing to the floor!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, A)
	else
		D.apply_damage(damage*0.5, BRUTE, BODY_ZONE_HEAD, wound_bonus = CANT_WOUND)
		D.apply_damage(damage + 35, STAMINA, BODY_ZONE_HEAD, wound_bonus = CANT_WOUND)
		D.drop_all_held_items()
		D.visible_message(span_warning("[A] kicks [D] in the head!"), \
					span_userdanger("You are kicked in the head by [A]!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, A)
	log_combat(A, D, "dropkicked (Sleeping Carp)")
	return TRUE

/datum/martial_art/the_sleeping_carp/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("G",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "grabbed (Sleeping Carp)")
	return ..()

/datum/martial_art/the_sleeping_carp/harm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("H",D)
	var/damage = (damage_roll(A,D) + 5)
	var/stunthreshold = A.dna.species.punchstunthreshold
	if(check_streak(A,D))
		return TRUE
	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected))
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	var/atk_verb = pick("kick", "chop", "hit", "slam")
	D.visible_message(span_danger("[A] [atk_verb]s [D]!"), \
					span_userdanger("[A] [atk_verb]s you!"), null, null, A)
	to_chat(A, span_danger("You [atk_verb] [D]!"))
	D.apply_damage(damage, BRUTE, affecting, wound_bonus = CANT_WOUND)
	playsound(get_turf(D), 'sound/weapons/punch1.ogg', 25, TRUE, -1)
	if(CHECK_MOBILITY(D, MOBILITY_STAND) && damage >= stunthreshold)
		to_chat(D, span_danger("You stumble and fall!"))
		D.DefaultCombatKnockdown(10, override_hardstun = 0.01, override_stamdmg = damage)
	log_combat(A, D, "punched (Sleeping Carp)")
	return TRUE


/datum/martial_art/the_sleeping_carp/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("D",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "disarmed (Sleeping Carp)")
	return ..()
*/
/datum/martial_art/the_sleeping_carp/on_projectile_hit(mob/living/carbon/human/A, obj/item/projectile/P, def_zone)
	. = ..()
	if(A.incapacitated(FALSE, TRUE)) //NO STUN
		return BULLET_ACT_HIT
	if(!CHECK_ALL_MOBILITY(A, MOBILITY_USE|MOBILITY_STAND)) //NO UNABLE TO USE, NO DODGING ON THE FLOOR
		return BULLET_ACT_HIT
	if(A.dna && A.dna.check_mutation(HULK)) //NO HULK
		return BULLET_ACT_HIT
	if(!isturf(A.loc)) //NO MOTHERFLIPPIN MECHS!
		return BULLET_ACT_HIT
	A.visible_message(span_danger("[A] dodges the projectile cleanly, they're immune to ranged weapons!"), span_userdanger("You dodge out of the way of the projectile!"))
	playsound(get_turf(A), pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, TRUE)

	var/totalStamDam = (P.damage > P.stamina) ? P.damage * physdammod : P.stamina * stamdammod
	A.apply_damage(totalStamDam, STAMINA) //Changed it so the autododge takes more stamina than carp. -Farmwizard
	return BULLET_ACT_FORCE_PIERCE

/datum/martial_art/the_sleeping_carp/teach(mob/living/carbon/human/H, make_temporary = FALSE)
	. = ..()
	if(!.)
		return
	/*ADD_TRAIT(H, TRAIT_NOGUNS, SLEEPING_CARP_TRAIT) */
	ADD_TRAIT(H, TRAIT_NODISMEMBER, SLEEPING_CARP_TRAIT)
	ADD_TRAIT(H, TRAIT_NODRUGS, SLEEPING_CARP_TRAIT)
/*	ADD_TRAIT(H, TRAIT_MARTIAL_A, SLEEPING_CARP_TRAIT) */
	ADD_TRAIT(H, TRAIT_NO_MED_HVY_ARMOR, SLEEPING_CARP_TRAIT)
	H.physiology.stamina_mod *= 1.8 //You take a little more stamina damage
	H.physiology.stun_mod *= 0.3 //for those rare stuns
	H.physiology.brute_mod *= 2
	H.physiology.burn_mod *= 2 // You generally take more damage
	//H.physiology.pressure_mod *= 0.3 //go hang out with carp
	//H.physiology.cold_mod *= 0.3 //cold mods are different to burn mods, they do stack however
	//H.physiology.heat_mod *= 2 //this is mostly so sleeping carp has a viable weakness. Cooking them alive. Setting them on fire and heating them will be their biggest weakness. The reason for this is....filet jokes.

	H.faction |= "carp" //:D

/datum/martial_art/the_sleeping_carp/on_remove(mob/living/carbon/human/H)
	. = ..()
	/*REMOVE_TRAIT(H, TRAIT_NOGUNS, SLEEPING_CARP_TRAIT)*/
	REMOVE_TRAIT(H, TRAIT_NODISMEMBER, SLEEPING_CARP_TRAIT)
	REMOVE_TRAIT(H, TRAIT_NODRUGS, SLEEPING_CARP_TRAIT)
	/*REMOVE_TRAIT(H, TRAIT_MARTIAL_A, SLEEPING_CARP_TRAIT)*/
	REMOVE_TRAIT(H, TRAIT_NO_MED_HVY_ARMOR, SLEEPING_CARP_TRAIT)
	H.physiology.stamina_mod = initial(H.physiology.stamina_mod)
	H.physiology.stun_mod = initial(H.physiology.stun_mod)
	H.physiology.brute_mod = initial(H.physiology.brute_mod)
	H.physiology.burn_mod = initial(H.physiology.burn_mod)
	/*H.physiology.pressure_mod = initial(H.physiology.pressure_mod) //no more carpies
	H.physiology.cold_mod = initial(H.physiology.cold_mod)
	H.physiology.heat_mod = initial(H.physiology.heat_mod)*/

	H.faction -= "carp" //:(

/mob/living/carbon/human/proc/sleeping_carp_help()
	set name = "Recall Teachings"
	set desc = "Remember the martial techniques of the Sleeping Carp clan."
	set category = "Sleeping Carp"

	to_chat(usr, "<b><i>You retreat inward and recall the teachings of the Sleeping Carp...</i></b>")

	//to_chat(usr, "<span class='notice'>Gnashing Teeth</span>: Harm Harm. Deal additional damage every second punch, with a chance for even more damage!")
	//to_chat(usr, "<span class='notice'>Crashing Wave Kick</span>: Harm Disarm. Launch people brutally across rooms, and away from you.")
	//to_chat(usr, "<span class='notice'>Keelhaul</span>: Harm Grab. Kick opponents to the floor. Against prone targets, deal additional stamina damage and disarm them.")
	to_chat(usr, span_notice("You can dodge all projectiles. However, you are not invincible, and sustained damage will take it's toll on your stamina before your health."))
