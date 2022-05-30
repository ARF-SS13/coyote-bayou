#define HARD_PUNCH_COMBO "HH"
#define SHOULDERCHECK_COMBO "HD"
#define CHOKE_SLAM_COMBO "HG"

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
	if(findtext(streak,CHOKE_SLAM_COMBO))
		streak = ""
		chokeSlam(A,D)
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
	D.visible_message("<span class='danger'>[A] [atk_verb]s [D]!</span>", \
					"<span class='userdanger'>[A] [atk_verb]s you!</span>", null, null, A)
	to_chat(A, "<span class='danger'>You [atk_verb] [D]!</span>")
	if(prob(10))
		crit_damage += (damage + 3.5)
		playsound(get_turf(D), 'sound/weapons/bite.ogg', 50, TRUE, -1)
		D.visible_message("<span class='warning'>[D] staggers as they're slammed in the stomach</span>", "<span class='userdanger'>You are struck with incredible precision by [A]!</span>")
		log_combat(A, D, "critcal hard punched (Berserker)")//log it here because a critical can swing for 40 force and it's important for the sake of how hard they hit
	else
		playsound(get_turf(D), 'sound/weapons/punch1.ogg', 25, TRUE, -1)
		log_combat(A, D, "hard punched punched (Berserker)")//so as to not double up on logging
	D.apply_damage(damage + 2.5 + crit_damage, BRUTE, affecting, armor_block, wound_bonus = CANT_WOUND)
	return TRUE

///Shouldercheck: Harm Harm Harm combo, throws people seven tiles backwards
/datum/martial_art/berserker/proc/shoulderCheck(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/damage = (damage_roll(A,D) + 3)
	var/obj/item/bodypart/affecting = D.get_bodypart(BODY_ZONE_CHEST)
	var/armor_block = D.run_armor_check(affecting, "melee")
	A.do_attack_animation(D, ATTACK_EFFECT_KICK)
	D.visible_message("<span class='warning'>[A] shoulder checks [D] square in the chest, sending them flying!</span>", \
					"<span class='userdanger'>You are shoulderchecked in the chest by [A], sending you flying!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	var/atom/throw_target = get_edge_target_turf(D, A.dir)
	D.throw_at(throw_target, 3, 5, A, TRUE)
	D.apply_damage(damage, BRUTE, BODY_ZONE_CHEST, armor_block, wound_bonus = CANT_WOUND, wound_bonus = CANT_WOUND)
	to_chat(A, "<span class='danger'>You shouldercheck [D]!</span>")
	log_combat(A, D, "shoulderchecked (Berserker)")
	return TRUE

///chokeslam: Harm Grab combo, knocks people down, deals stamina damage while they're on the floor
/datum/martial_art/berserker/proc/chokeSlam(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/damage = damage_roll(A,D)
	A.do_attack_animation(D, ATTACK_EFFECT_KICK)
	var/obj/item/bodypart/affecting = D.get_bodypart(BODY_ZONE_HEAD)
	var/armor_block = D.run_armor_check(affecting, "melee")
	playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	if((D.mobility_flags & MOBILITY_STAND))
		D.apply_damage(damage*0.5, BRUTE, BODY_ZONE_HEAD, armor_block, wound_bonus = CANT_WOUND)
		D.DefaultCombatKnockdown(10, null, TRUE)
		D.apply_damage(damage + 20, STAMINA, BODY_ZONE_HEAD, armor_block, wound_bonus = CANT_WOUND) //A cit specific change form the tg port to really punish anyone who tries to stand up
		D.visible_message("<span class='warning'>[A] grabs [D] by the throat, slamming them face first into the ground!</span>", \
					"<span class='userdanger'>[A] grabs you by the throat, slammed your head into the ground!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
		to_chat(A, "<span class='danger'>You chokeslam [D]!</span>")
	else
		D.apply_damage(damage*0.5, BRUTE, BODY_ZONE_HEAD, armor_block, wound_bonus = CANT_WOUND)
		D.apply_damage(damage + 20, STAMINA, BODY_ZONE_HEAD, armor_block, wound_bonus = CANT_WOUND)
		D.drop_all_held_items()
		D.visible_message("<span class='warning'>[A] pummels [D]!</span>", \
					"<span class='userdanger'>You are kicked in the head by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
		to_chat(A, "<span class='danger'>You pummel [D]!</span>")
	log_combat(A, D, "chokeslammed (Berserker")
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
	D.visible_message("<span class='danger'>[A] [atk_verb]s [D]!</span>", \
					"<span class='userdanger'>[A] [atk_verb]s you!</span>", null, null, A)
	to_chat(A, "<span class='danger'>You [atk_verb] [D]!</span>")
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
	ADD_TRAIT(H, TRAIT_NOGUNS, BERSERKER_TRAIT)
	ADD_TRAIT(H, TRAIT_PIERCEIMMUNE, BERSERKER_TRAIT)
	ADD_TRAIT(H, TRAIT_NODISMEMBER, BERSERKER_TRAIT)
	ADD_TRAIT(H, TRAIT_BERSERKER, BERSERKER_TRAIT)
	H.physiology.stamina_mod *= 0.3 //more stamina
	H.physiology.stun_mod *= 0.3 //better stun resistance


/datum/martial_art/berserker/on_remove(mob/living/carbon/human/H)
	. = ..()
	REMOVE_TRAIT(H, TRAIT_NOGUNS, BERSERKER_TRAIT)
	REMOVE_TRAIT(H, TRAIT_PIERCEIMMUNE, BERSERKER_TRAIT)
	REMOVE_TRAIT(H, TRAIT_NODISMEMBER, BERSERKER_TRAIT)
	REMOVE_TRAIT(H, TRAIT_BERSERKER, BERSERKER_TRAIT)
	H.physiology.stamina_mod = initial(H.physiology.stamina_mod)
	H.physiology.stun_mod = initial(H.physiology.stun_mod)

/mob/living/carbon/human/proc/berserker_blows_help()
	set name = "Recall Teachings"
	set desc = "Remember the sacred rites of the Berserker."
	set category = "Berserker"

	to_chat(usr, "<b><i>You retreat inward and recall the rites of the berserker..</i></b>")

	to_chat(usr, "<span class='notice'>Gutpunch</span>: Harm Harm. Deal additional damage every second punch, with a chance for even more damage!")
	to_chat(usr, "<span class='notice'>Shoulder Check</span>: Harm Disarm. Launch people brutally across rooms, and away from you.")
	to_chat(usr, "<span class='notice'>Chokeslam</span>: Harm  Grab. Chokeslam to the floor. Against prone targets, deal additional stamina damage and disarm them.")
	to_chat(usr, "<span class='notice'>In addition, your body is better conditioned, giving you further stamina and increased stun resistance.</span>")

