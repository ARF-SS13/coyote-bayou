///VORER//
/datum/emote/living/vore
	key = "vore"
	key_third_person = "vored"
	restraint_check = TRUE
	no_message = TRUE

/datum/emote/living/vore/run_emote(mob/user)
	if(!..())
		return
	if(SEND_SIGNAL(user, COMSIG_VORE_CAN_EAT) == FALSE)
		to_chat(user, span_alert("You can't eat anything right now!"))
		return
	if(SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, user.pulled))
		return // probably eating someone right now
	var/obj/item/hand_item/vorer/nummers = new(user)
	if(user.put_in_hand(nummers))
		to_chat(user, span_notice("You get ready to eat someone (or something)!"))
	else
		qdel(brick)

/// VORE ITEM
/obj/item/hand_item/vorer
	name = "Devourer"
	desc = "Here comes the airplane!"
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "vorer"
	attack_verb = list("nommed", "homfed", "yormfed", "uarffed", "myorarmfghfhed")
	hitsound = "sound/weapons/bite.ogg"
	siemens_coefficient = 5 
	force = 0
	force_wielded = 0
	throwforce = 0
	wound_bonus = -100
	sharpness = SHARP_NONE
	attack_speed = 4
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM

/// Eating stuff yourself? easy peasy, just slap a thing with your chompers and ride the vibes~

/obj/item/hand_item/vorer/attack(mob/living/L, mob/living/carbon/user)
	SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, L)

/obj/item/hand_item/vorer/attack_obj(obj/O, mob/living/user)
	SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, O)

/obj/item/hand_item/vorer/attack_obj_nohit(obj/O, mob/living/user)
	SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, O)

// Feeding someone to someone else? hooboy...

///FEEDER//
/datum/emote/living/feeder
	key = "feed"
	key_third_person = "fed"
	restraint_check = TRUE
	no_message = TRUE

/datum/emote/living/feeder/run_emote(mob/user)
	if(!..())
		return
	// so, we need two things, someone to eat, and someone to be eaten
	// if we grab someone, its reasonable to assume we want them to eat *something*
	var/mob/living/living_pred
	if(SEND_SIGNAL(user.pulled, COMSIG_VORE_CAN_BE_FED_PREY))
		living_pred = user.pulled // Cool, we have a pred, our job is halfway done!
		// is anyone else nearby?
		var/anybody
		for(var/mob/living/dope in view(1, user))
			if(dope == user)
				continue
			if(dope == living_pred)
				continue
			if(!SEND_SIGNAL(dope, COMSIG_VORE_CAN_BE_FED_PREY)) // they've gotta *want* it
				continue
			anybody = TRUE
			break
		if(!anybody && SEND_SIGNAL(living_pred, COMSIG_VORE_DO_VORE, user)) 
			return // nobody else? sweet, lets (be) eat(en)!
	// Okay that didnt work out, spawn a grabby hand and tell it our pred, if any
	var/obj/item/hand_item/feeder/feedus = new(user)
	if(!feedus.put_in_hand(nummers))
		qdel(nummers)
		return
	feedus.our_pred = WEAKREF(living_pred)
	to_chat(user, span_notice("You get ready to feed something to someone!"))


/// VORE ITEM
/obj/item/hand_item/feeder
	name = "Feeder"
	desc = "WAIT PINKIE PIE!! PEPPINO IS NOT FOOD!!!"
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "feeder"
	attack_verb = list("nommed", "homfed", "yormfed", "uarffed", "myorarmfghfhed")
	hitsound = "sound/weapons/bite.ogg"
	siemens_coefficient = 5 
	force = 0
	force_wielded = 0
	throwforce = 0
	wound_bonus = -100
	sharpness = SHARP_NONE
	attack_speed = 4
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	var/datum/weakref/our_pred
	var/datum/weakref/our_prey
	var/grab_pred = TRUE

// So we need two things: One to eat, and one to eaten. 

/obj/item/hand_item/feeder/examine(mob/user)
	. = ..()
	. += "HOW TO USE:"
	. += "This thing will pick what will be fed to who. When you click this onto someone, it'll set them as either predator or prey, \
		depending on its current settings. Once you've used this to select a predator and a prey, you'll start stuffing the prey into \
		the predator. Yes you can use this to climb into people."
	. += "Currently selecting a [span_greentext([grab_pred ? "predator" : "prey"])]. Use [span_notice("in hand")] to select something else."
	. += "[span_notice("Alt-click")] this to clear your selected predator/prey."
	if(our_pred)
		var/mob/living/living_pred = RESOLVEREF(our_pred)
		. += span_notice("[living_pred] has been selected to [span_greentext("EAT")] something.")
	if(our_prey)
		var/atom/movable/movable_prey = RESOLVEREF(our_prey)
		. += span_notice("[movable_prey] has been selected to [span_greentext("BE EATEN")] by something.")

/obj/item/hand_item/feeder/attack(mob/living/L, mob/living/carbon/user)
	SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, L)

/obj/item/hand_item/feeder/attack_obj(obj/O, mob/living/user)
	SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, O)

/obj/item/hand_item/feeder/attack_obj_nohit(obj/O, mob/living/user)
	SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, O)

/obj/item/hand_item/feeder/proc/add_predator(mob/living/living_predator, mob/living/user)
	if(!isliving(living_predator))
		to_chat(user, span_alert("Only mobs can eat things!"))
		return
	if(!SEND_SIGNAL(living_predator, COMSIG_VORE_CAN_EAT))
		to_chat(user, span_alert("!"))


