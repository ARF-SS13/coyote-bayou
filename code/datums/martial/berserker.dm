#define HARD_PUNCH_COMBO "HH"
#define SHOULDERCHECK_COMBO "HD"
#define WRIST_WRENCH_COMBO "DD"

/datum/martial_art/berserker
	name = "Berserker Rites"
	id = MARTIALART_BERSERKER
	allow_temp_override = FALSE
	help_verb = /mob/living/carbon/human/proc/berserker_blows_help
	pugilist = TRUE

/datum/martial_art/berserker/proc/check_streak(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(findtext(streak,HARD_PUNCH_COMBO))
		streak = ""
		hardPunch(A,D)
		return TRUE
	if(findtext(streak,SHOULDERCHECK_COMBO))
		streak = ""
		shoulderCheck(A,D)
		return TRUE
	if(findtext(streak,WRIST_WRENCH_COMBO))
		streak = ""
		wristWrench(A,D)
		return TRUE
	return FALSE

///Gutpunch: Harm Harm, high force punch on every second harm punch, has a chance to crit for near triple damage
/datum/martial_art/berserker/proc/hardPunch(mob/living/carbon/human/A, mob/living/carbon/human/D)
	///this var is so that the strong punch is always aiming for the body part the user is targeting and not trying to apply to the chest before deviating
	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected))
	var/armor_block = D.run_armor_check(affecting, "melee")
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	var/atk_verb = pick("forcefully kick", "brutally jab", "cleanly hit", "viciously slam")
	///this is the critical hit damage added to the attack if it rolls, it starts at 0 because it'll be changed when rolled
	var/crit_damage = 0
	var/damage = damage_roll(A,D)
	D.visible_message(span_danger("[A] [atk_verb]s [D]!"), \
					span_userdanger("[A] [atk_verb]s you!"), null, null, A)
	to_chat(A, span_danger("You [atk_verb] [D]!"))
	if(prob(10))
		crit_damage += (damage * 2.5)
		playsound(get_turf(D), 'sound/weapons/bite.ogg', 50, TRUE, -1)
		D.visible_message(span_warning("[D] staggers as they're slammed in the stomach"), span_userdanger("You are struck with incredible precision by [A]!"))
		log_combat(A, D, "critcal hard punched (Berserker)")//log it here because a critical can swing for 40 force and it's important for the sake of how hard they hit
	else
		playsound(get_turf(D), 'sound/weapons/punch1.ogg', 25, TRUE, -1)
		log_combat(A, D, "hard punched punched (Berserker)")//so as to not double up on logging
	D.apply_damage(damage * 2 + crit_damage, BRUTE, affecting, armor_block, wound_bonus = CANT_WOUND)
	return TRUE

///Shouldercheck: Harm Harm Harm combo, throws people seven tiles backwards
/datum/martial_art/berserker/proc/shoulderCheck(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/damage = (damage_roll(A,D) * 1.5)
	var/obj/item/bodypart/affecting = D.get_bodypart(BODY_ZONE_CHEST)
	var/armor_block = D.run_armor_check(affecting, "melee")
	A.do_attack_animation(D, ATTACK_EFFECT_KICK)
	D.visible_message(span_warning("[A] shoulder checks [D] square in the chest, sending them flying!"), \
					span_userdanger("You are shoulderchecked in the chest by [A], sending you flying!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, A)
	playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	var/atom/throw_target = get_edge_target_turf(D, A.dir)
	D.throw_at(throw_target, 3, 5, A, TRUE)
	D.apply_damage(damage, BRUTE, BODY_ZONE_CHEST, armor_block, wound_bonus = CANT_WOUND, wound_bonus = CANT_WOUND)
	to_chat(A, span_danger("You shouldercheck [D]!"))
	log_combat(A, D, "shoulderchecked (Berserker)")
	return TRUE

///chokeslam: Harm Grab combo, knocks people down, deals stamina damage while they're on the floor
//datum/martial_art/berserker/proc/chokeSlam(mob/living/carbon/human/A, mob/living/carbon/human/D)
	//var/damage = damage_roll(A,D)
	//A.do_attack_animation(D, ATTACK_EFFECT_KICK)
	//var/obj/item/bodypart/affecting = D.get_bodypart(BODY_ZONE_HEAD)
	//var/armor_block = D.run_armor_check(affecting, "melee")
	//playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	//if((D.mobility_flags & MOBILITY_STAND))
		//D.apply_damage(damage*0.5, BRUTE, BODY_ZONE_HEAD, armor_block, wound_bonus = CANT_WOUND)
		//D.DefaultCombatKnockdown(10, null, TRUE)
		//D.apply_damage(damage + 20, STAMINA, BODY_ZONE_HEAD, armor_block, wound_bonus = CANT_WOUND) //A cit specific change form the tg port to really punish anyone who tries to stand up
		//D.visible_message(span_warning("[A] grabs [D] by the throat, slamming them face first into the ground!"),
					//span_userdanger("[A] grabs you by the throat, slammed your head into the ground!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, A)
		//to_chat(A, span_danger("You chokeslam [D]!"))
	//else
		//D.apply_damage(damage*0.5, BRUTE, BODY_ZONE_HEAD, armor_block, wound_bonus = CANT_WOUND)
		//D.apply_damage(damage + 20, STAMINA, BODY_ZONE_HEAD, armor_block, wound_bonus = CANT_WOUND)
		//D.drop_all_held_items()
		//D.visible_message(span_warning("[A] pummels [D]!"),
					//span_userdanger("You are kicked in the head by [A]!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, A)
		//to_chat(A, span_danger("You pummel [D]!"))
	//log_combat(A, D, "chokeslammed (Berserker")
	//return TRUE

/datum/martial_art/berserker/proc/wristWrench(mob/living/carbon/human/A, mob/living/carbon/human/D)
		log_combat(A, D, "wrist wrenched (Berserker)")
		A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
		D.visible_message(span_warning("[A] grabs [D]'s wrist and wrenches it sideways!"), \
						  span_userdanger("[A] grabs your wrist and violently wrenches it to the side!"))
		playsound(get_turf(A), 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
		D.emote("scream")
		D.dropItemToGround(D.get_active_held_item())
		D.apply_damage(20, BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		D.apply_damage(35, STAMINA, pick(A.zone_selected))
		to_chat(A, span_danger("You wrench [D]'s wrist!"))
		log_combat(A, D, "wrist wrenched (Berserker)")

		return TRUE


/datum/martial_art/berserker/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("G",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "grabbed (Berserker)")
	return ..()

/datum/martial_art/berserker/harm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("H",D)
	var/damage = (damage_roll(A,D) + 2)
	if(check_streak(A,D))
		return TRUE
	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected))
	var/armor_block = D.run_armor_check(affecting, "melee")
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	var/atk_verb = pick("slam", "gouge", "hit", "brutalize")
	D.visible_message(span_danger("[A] [atk_verb]s [D]!"), \
					span_userdanger("[A] [atk_verb]s you!"), null, null, A)
	to_chat(A, span_danger("You [atk_verb] [D]!"))
	D.apply_damage(damage, BRUTE, affecting, armor_block, wound_bonus = CANT_WOUND)
	playsound(get_turf(D), 'sound/weapons/punch1.ogg', 25, TRUE, -1)
	log_combat(A, D, "punched (Berserker)")
	return NO_AUTO_CLICKDELAY_HANDLING | ATTACK_IGNORE_ACTION


/datum/martial_art/berserker/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("D",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "disarmed (Berserker)")
	return ..()

/datum/martial_art/berserker/teach(mob/living/carbon/human/H, make_temporary = FALSE)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(H, TRAIT_NOGUNS, TRAIT_BERSERKER)
	//ADD_TRAIT(H, TRAIT_PIERCEIMMUNE, BERSERKER_TRAIT)
	//ADD_TRAIT(H, TRAIT_NODISMEMBER, BERSERKER_TRAIT)
	ADD_TRAIT(H, TRAIT_AUTO_CATCH_ITEM, TRAIT_BERSERKER)
	ADD_TRAIT(H, TRAIT_BERSERKER, TRAIT_BERSERKER)
	ADD_TRAIT(H, TRAIT_MARTIAL_A, TRAIT_BERSERKER)
	ADD_TRAIT(H, TRAIT_NOSLIPALL, TRAIT_BERSERKER)
	H.physiology.stamina_mod *= 0.3 //more stamina
	H.physiology.stun_mod *= 0.3 //better stun resistance


/datum/martial_art/berserker/on_remove(mob/living/carbon/human/H)
	. = ..()
	REMOVE_TRAIT(H, TRAIT_NOGUNS, TRAIT_BERSERKER)
	//REMOVE_TRAIT(H, TRAIT_PIERCEIMMUNE, BERSERKER_TRAIT)
	//REMOVE_TRAIT(H, TRAIT_NODISMEMBER, BERSERKER_TRAIT)
	REMOVE_TRAIT(H, TRAIT_BERSERKER, BERSERKER_TRAIT)
	REMOVE_TRAIT(H, TRAIT_AUTO_CATCH_ITEM, TRAIT_BERSERKER)
	REMOVE_TRAIT(H, TRAIT_MARTIAL_A, TRAIT_BERSERKER)
	REMOVE_TRAIT(H, TRAIT_NOSLIPALL, TRAIT_BERSERKER)
	H.physiology.stamina_mod = initial(H.physiology.stamina_mod)
	H.physiology.stun_mod = initial(H.physiology.stun_mod)

/mob/living/carbon/human/proc/berserker_blows_help()
	set name = "Recall Teachings"
	set desc = "Remember the sacred rites of the Berserker."
	set category = "Berserker"

	to_chat(usr, "<b><i>You retreat inward and recall the rites of the berserker..</i></b>")

	to_chat(usr, "<span class='notice'>Gutpunch</span>: Harm Harm. Deal additional damage every second punch, with a chance for even more damage!")
	to_chat(usr, "<span class='notice'>Shoulder Check</span>: Harm Disarm. Launch people brutally across rooms, and away from you.")
	to_chat(usr, span_notice("<span class='notice'>Wrist Wrench</span>: Disarm Disarm. Grab and painfully wrench someone's wrist, disarming them and dealing minor brute and stamina damage."))
	to_chat(usr, span_notice("In addition, your body is better conditioned, giving you further stamina and increased stun resistance, you also are able to have a better footing and will no longer slip."))
	//to_chat(usr, "<span class='notice'>Chokeslam</span>: Harm  Grab. Chokeslam to the floor. Against prone targets, deal additional stamina damage and disarm them.")
