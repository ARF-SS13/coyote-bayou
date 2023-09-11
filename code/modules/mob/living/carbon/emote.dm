/datum/emote/living/carbon/airguitar
	key = "airguitar"
	message = "is strumming the air and headbanging like a lunatic."
	restraint_check = TRUE
	sound = 'sound/effects/airguitar.ogg'

/datum/emote/living/carbon/blink
	key = "blink"
	key_third_person = "blinks"
	message = "blinks."
	sound = 'sound/effects/blink.ogg'

/datum/emote/living/carbon/blink_r
	key = "blink_r"
	message = "blinks rapidly."

/datum/emote/living/carbon/clap
	key = "clap"
	key_third_person = "claps"
	message = "claps."
	muzzle_ignore = TRUE
	restraint_check = TRUE
	emote_type = EMOTE_AUDIBLE
	sound = list('sound/misc/clap1.ogg',
				'sound/misc/clap2.ogg',
				'sound/misc/clap3.ogg',
				'sound/misc/clap4.ogg')


/datum/emote/living/carbon/clap/can_run_emote(mob/living/user, status_check, intentional)
	. = ..()
	// Need hands to clap
	if(!user.get_bodypart(BODY_ZONE_L_ARM) || !user.get_bodypart(BODY_ZONE_R_ARM))
		return

/datum/emote/living/carbon/gnarl
	key = "gnarl"
	key_third_person = "gnarls"
	message = "gnarls and shows thier teeth..."
	sound = 'sound/alien/voice/gnarl1.ogg'

/datum/emote/living/carbon/moan
	key = "moan"
	key_third_person = "moans"
	message = "moans!"
	emote_type = EMOTE_AUDIBLE
	stat_allowed = SOFT_CRIT
	
/*
/datum/emote/living/carbon/moan/get_sound(mob/living/M) //need better, ie. more pleasured (because these are mostly when doing drugs) moans
	if(ishuman(M))
		if(M.gender == FEMALE)
			. = list(
				'sound/effects/female_moan1.ogg',
				'sound/effects/female_moan2.ogg',
				'sound/effects/female_moan3.ogg'
			)
		else
			. = list(
				'sound/effects/male_moan1.ogg',
				'sound/effects/male_moan2.ogg',
				'sound/effects/male_moan3.ogg'
			)
		return 
*/
/datum/emote/living/carbon/roll
	key = "roll"
	key_third_person = "rolls"
	message = "rolls."
	restraint_check = TRUE

/datum/emote/living/carbon/scratch
	key = "scratch"
	key_third_person = "scratches"
	message = "scratches."
	restraint_check = TRUE

/datum/emote/living/carbon/screech
	key = "screech"
	key_third_person = "screeches"
	message = "screeches."

/datum/emote/living/carbon/sign
	key = "sign"
	key_third_person = "signs"
	message_param = "signs the number %t."
	restraint_check = TRUE

/datum/emote/living/carbon/sign/select_param(mob/user, params)
	. = ..()
	if(!isnum(text2num(params)))
		return message

/datum/emote/living/carbon/sign/signal
	key = "signal"
	key_third_person = "signals"
	message_param = "raises %t fingers."
	restraint_check = TRUE

/datum/emote/living/carbon/tail
	key = "tail"
	message = "waves their tail."

/datum/emote/living/carbon/wink
	key = "wink"
	key_third_person = "winks"
	message = "winks."

/datum/emote/living/carbon/lick
	key = "lick"
	key_third_person = "licks"
	restraint_check = TRUE

/datum/emote/living/carbon/lick/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your active hand is full, and therefore you can't lick anything! Don't ask why!"))
		return
	var/obj/item/hand_item/healable/licker/licky = new(user)
	if(user.put_in_active_hand(licky))
		to_chat(user, span_notice("You extend your tongue and get ready to lick something."))
	else
		qdel(licky)

/datum/emote/living/carbon/touch
	key = "touch"
	key_third_person = "touches"
	restraint_check = TRUE

/datum/emote/living/carbon/touch/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your active hand is full, and therefore you can't touch anything!"))
		return
	var/obj/item/hand_item/healable/toucher/touchy = new(user)
	if(user.put_in_active_hand(touchy))
		to_chat(user, span_notice("You get ready to touch something."))
	else
		qdel(touchy)

/datum/emote/living/carbon/tend
	key = "tend"
	key_third_person = "tends"
	restraint_check = TRUE

/datum/emote/living/carbon/tend/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your active hand is full, and therefore you can't tend anything!"))
		return
	var/obj/item/hand_item/healable/tender/tendy = new(user)
	if(user.put_in_active_hand(tendy))
		to_chat(user, span_notice("You retrieve your emergency kit and get ready to tend something."))
	else
		qdel(tendy)

//Biter//
/datum/emote/living/carbon/bite
	key = "bite"
	key_third_person = "bites"
	restraint_check = TRUE

/datum/emote/living/carbon/bite/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are too full to properly bite!  Don't ask!"))
		return
	if(ishuman(user))
		var/obj/item/hand_item/biter/bite = new(user)
		if(user.put_in_active_hand(bite))
			to_chat(user, span_notice("You show your fangs and prepare to bite the mess out of something or someone!"))
		else
			qdel(bite)
	else
		var/obj/item/hand_item/biter/creature/bite = new(user)
		if(user.put_in_active_hand(bite))
			to_chat(user, span_notice("You show your fangs and prepare to bite the mess out of something or someone!"))
		else
			qdel(bite)


//Clawer//
/datum/emote/living/carbon/claw
	key = "claw"
	key_third_person = "claws"
	restraint_check = TRUE

/datum/emote/living/carbon/claw/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are too full to use your claws!"))
		return
	if(ishuman(user))
		var/obj/item/hand_item/clawer/claw = new(user)
		if(user.put_in_active_hand(claw))
			to_chat(user, span_notice("You get your claws ready to slice!"))
		else
			qdel(claw)
	else
		var/obj/item/hand_item/clawer/creature/claw = new(user)
		if(user.put_in_active_hand(claw))
			to_chat(user, span_notice("You get your claws ready to slice!"))
		else
			qdel(claw)


//Shover//
/datum/emote/living/carbon/shover
	key = "shove"
	key_third_person = "shoves"
	restraint_check = TRUE

/datum/emote/living/carbon/shover/run_emote(mob/user)
	. = ..()
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are too full to really shove someone!"))
		return
	var/obj/item/hand_item/shover/shove = new(user)
	if(user.put_in_active_hand(shove))
		to_chat(user, span_notice("You get ready to shove someone back!"))
	else
		qdel(shove)

//Rock throw//
/datum/emote/living/carbon/rocker
	key = "rocks"
	key_third_person = "rocks"
	restraint_check = TRUE
	COOLDOWN_DECLARE(rock_cooldown)
	var/damageMult
	var/hasPickedUp = FALSE
	var/timerEnabled
	var/damageNerf = 2.2


/datum/emote/living/carbon/rocker/run_emote(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, rock_cooldown) && !HAS_TRAIT(user, TRAIT_MONKEYLIKE))
		to_chat(user, span_warning("You cant find any rocks yet!"))
		return
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are too full to go looking for rocks!"))
		return
	var/obj/item/ammo_casing/caseless/rock/rock = new(user)

	if(hasPickedUp)
		rock.throwforce = damageMult / damageNerf

	if(user.put_in_active_hand(rock))
		hasPickedUp = TRUE
		damageMult = rock.throwforce
		if(!timerEnabled)
			addtimer(CALLBACK(src, .proc/reset_damage), 2.5 SECONDS)
			timerEnabled = TRUE
		COOLDOWN_START(src, rock_cooldown, 2.5 SECONDS)
		to_chat(user, span_notice("You find a nice hefty throwing rock!"))
	else
		qdel(rock)

/datum/emote/living/carbon/rocker/proc/reset_damage()
	hasPickedUp = FALSE
	timerEnabled = FALSE
	damageMult = initial(damageMult)

//brick//
/datum/emote/living/carbon/bricker
	key = "brick"
	key_third_person = "bricks"
	restraint_check = TRUE
	COOLDOWN_DECLARE(brick_cooldown)
	var/damageMult
	var/hasPickedUp = FALSE
	var/timerEnabled
	var/damageNerf = 2.2

/datum/emote/living/carbon/bricker/run_emote(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, brick_cooldown) && !HAS_TRAIT(user, TRAIT_QUICK_BUILD))
		to_chat(user, span_warning("You cant find any bricks yet!"))
		return
	if(user.get_active_held_item())
		to_chat(user, span_warning("Your hands are too full to go looking for bricks!"))
		return
	var/obj/item/ammo_casing/caseless/brick/brick = new(user)

	if(hasPickedUp)
		brick.throwforce = damageMult / damageNerf

	if(user.put_in_active_hand(brick))
		hasPickedUp = TRUE
		damageMult = brick.throwforce
		if(!timerEnabled)
			addtimer(CALLBACK(src, .proc/reset_damage), 2.5 SECONDS)
			timerEnabled = TRUE
		COOLDOWN_START(src, brick_cooldown, 2.5 SECONDS)
		to_chat(user, span_notice("You find a nice weighty brick!"))
	else
		qdel(brick)

/datum/emote/living/carbon/bricker/proc/reset_damage()
	hasPickedUp = FALSE
	timerEnabled = FALSE
	damageMult = initial(damageMult)
