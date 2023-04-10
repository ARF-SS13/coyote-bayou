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
	if(SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, user.pulling))
		return // probably eating someone right now
	var/obj/item/held_thing = user.get_active_held_item() // try eating something in your hand
	if(SSvore.can_eat(held_thing))
		if(SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, held_thing))
			return // yay, we ate it
	var/obj/item/hand_item/vorer/nummers = new(user)
	if(user.put_in_hands(nummers)) // NOTE: put_in_hand is MUCH different from put_in_hands - NOTE THE S
		to_chat(user, span_notice("You get ready to eat someone (or something)!"))
	else
		qdel(nummers)

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
/obj/item/hand_item/vorer/examine(mob/user)
	. = ..()
	. += "HOW TO USE:"
	. += "Click this thing onto something, and if its edible, you'll try and stuff it into your selected belly, if any."

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
	if(SEND_SIGNAL(user.pulling, COMSIG_VORE_CAN_BE_FED_PREY))
		living_pred = user.pulling // Cool, we have a pred, our job is halfway done!
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
	if(!user.put_in_hands(feedus))
		qdel(feedus)
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

/obj/item/hand_item/feeder/Destroy()
	our_pred = null
	our_prey = null
	. = ..()

/obj/item/hand_item/feeder/examine(mob/user)
	. = ..()
	. += "HOW TO USE:"
	. += "This thing will pick what will be fed to who. When you click this onto someone, it'll set them as either predator or prey, \
		depending on its current settings. Items can only be prey, and will be selected as prey on either setting. \
		Once you've used this to select a predator and a prey, you'll start stuffing the prey into the predator. \
		Yes you can use this to climb into people."
	. += "Currently selecting a [span_green(grab_pred ? "predator" : "prey")]. Use [span_notice("in hand")] to select something else."
	. += "[span_notice("Alt-click")] this to clear your selected predator/prey."
	if(our_pred)
		var/mob/living/living_pred = RESOLVEREF(our_pred)
		. += span_notice("[living_pred] has been selected to be a [span_green("PREDATOR")].")
	if(our_prey)
		var/atom/movable/movable_prey = RESOLVEREF(our_prey)
		. += span_notice("[movable_prey] has been selected to be [span_green("PREY")].")

/obj/item/hand_item/feeder/AltClick(mob/user)
	. = ..()
	grab_pred = !grab_pred
	to_chat(user, span_notice("Currently selecting a [span_green(grab_pred ? "predator" : "prey")]. Use [span_notice("in hand")] to select something else."))

/obj/item/hand_item/feeder/attack(mob/living/L, mob/living/carbon/user)
	if(grab_pred)
		add_predator(L, user)
		return
	add_prey(L, user)

/obj/item/hand_item/feeder/attack_obj(obj/O, mob/living/user)
	add_prey(O, user)

/obj/item/hand_item/feeder/attack_obj_nohit(obj/O, mob/living/user)
	add_prey(O, user)

/obj/item/hand_item/feeder/proc/add_predator(mob/living/living_pred, mob/living/user)
	if(!isliving(living_pred))
		to_chat(user, span_alert("Only mobs can eat things!"))
		return
	if(!SSvore.can_eat(living_pred))
		to_chat(user, span_alert("[living_pred] can't eat anything!"))
		return
	if(!SEND_SIGNAL(living_pred, COMSIG_VORE_CAN_EAT))
		to_chat(user, span_alert("[living_pred] can't eat anything right now!"))
		return
	to_chat(span_green("[living_pred] selected as predator!"))
	our_pred = WEAKREF(living_pred)
	check_completion(user)

/obj/item/hand_item/feeder/proc/add_prey(atom/movable/movable_prey, mob/living/user)
	if(!SSvore.can_eat(movable_prey))
		to_chat(user, span_alert("[movable_prey] can't be eaten!"))
		return
	to_chat(span_green("[movable_prey] selected as prey!"))
	our_prey = WEAKREF(movable_prey)
	check_completion(user)

/obj/item/hand_item/feeder/proc/check_completion(mob/living/user)
	if(!our_pred || !our_prey)
		return
	var/atom/movable/movable_prey = RESOLVEREF(our_prey)
	if(!movable_prey)
		to_chat(span_alert("Your prey no longer exists, probably!"))
	var/mob/living/living_pred = RESOLVEREF(our_pred)
	if(!living_pred)
		to_chat(span_alert("Your predator no longer exists, probably!"))
	if(!movable_prey || !living_pred)
		return
	SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, living_pred, movable_prey)
	qdel(src)


