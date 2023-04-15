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
	. += span_notice("HOW TO USE:")
	. += "Click this thing onto something, and if its edible, you'll try and stuff it into your selected belly, if any."

/obj/item/hand_item/vorer/attack(mob/living/L, mob/living/carbon/user)
	if(!SEND_SIGNAL(user, COMSIG_VORE_CHECK_EDIBILITY, L))
		return
	SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, L)

/obj/item/hand_item/vorer/attack_obj(obj/O, mob/living/user)
	if(!SEND_SIGNAL(user, COMSIG_VORE_CHECK_EDIBILITY, O))
		return
	SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, O)

/obj/item/hand_item/vorer/attack_obj_nohit(obj/O, mob/living/user)
	if(!SEND_SIGNAL(user, COMSIG_VORE_CHECK_EDIBILITY, O))
		return
	SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, O)

/obj/item/hand_item/vorer/attackby(obj/item/I, mob/living/user, params)
	if(!SEND_SIGNAL(user, COMSIG_VORE_CHECK_EDIBILITY, I))
		return
	SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, user, I)

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
	if(isliving(user.pulling))
		living_pred = user.pulling // Cool, we have a pred, our job is halfway done!
		// is anyone else nearby?
		var/anybody
		for(var/mob/living/dope in view(1, user))
			if(dope == user)
				continue
			if(dope == living_pred)
				continue
			if(dope.ckey && !SEND_SIGNAL(dope, COMSIG_VORE_CAN_BE_FED_PREY)) // they've gotta *want* it
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
	var/grab_pred = FALSE

// So we need two things: One to eat, and one to eaten. 

/obj/item/hand_item/feeder/Destroy()
	our_pred = null
	our_prey = null
	. = ..()

// PREDS in RED, PREY in GREEN
/obj/item/hand_item/feeder/examine(mob/user)
	. = ..()
	. += span_notice("HOW TO USE:")
	. += span_notice("This thing will pick what will be fed to who. When you click this onto someone, it'll set them as either predator or prey, \
		depending on its current settings. Items can only be prey, and will be selected as prey on either setting. \
		Once you've used this to select a predator and a prey, you'll start stuffing the prey into the predator. \
		Yes you can use this to climb into people.")
	. += span_notice("Currently selecting a [grab_pred ? span_alert("predator") : span_green("prey")]. Use [span_bold("in hand")] to select something else.")
	. += span_notice("[span_bold("Alt-click")] this to clear your selected predator/prey.")
	if(our_pred)
		var/mob/living/living_pred = RESOLVEWEAKREF(our_pred)
		var/yew = (living_pred == user) // should only ever be seen by the holder
		if(yew)
			. += span_notice("[span_alert("[living_pred]")] has been selected to be the [span_alert("PREDATOR")].")
		else
			. += span_notice("[span_alert("You")] have selected yourself to be the [span_alert("PREDATOR")].")
	if(our_prey)
		var/atom/movable/movable_prey = RESOLVEWEAKREF(our_prey)
		var/yew = (movable_prey == user) // should only ever be seen by the holder
		if(yew)
			. += span_notice("[span_green("You")] have selected yourself to be someone's [span_green("PREY")].")
		else
			. += span_notice("[span_green("[movable_prey]")] has been selected to be someone's [span_green("PREY")].")

/obj/item/hand_item/feeder/attack_self(mob/user)
	. = ..()
	grab_pred = !grab_pred
	to_chat(user, span_notice("Currently selecting a [grab_pred ? span_alert("predator") : span_green("prey")]. Use [span_bold("in hand")] to select something else."))

/obj/item/hand_item/feeder/AltClick(mob/user)
	. = ..()
	our_pred = null
	our_prey = null
	to_chat(user, span_notice("Cleared your selection!"))

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
	to_chat(user, span_notice("[span_green("[living_pred]")] selected as [span_alert("predator")]!"))
	our_pred = WEAKREF(living_pred)
	user.do_attack_animation(living_pred)
	playsound(get_turf(living_pred), 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
	check_completion(user)

/obj/item/hand_item/feeder/proc/add_prey(atom/movable/movable_prey, mob/living/user)
	if(!SSvore.can_eat(movable_prey))
		to_chat(user, span_alert("[movable_prey] can't be eaten!"))
		return
	if(!SEND_SIGNAL(movable_prey, COMSIG_VORE_CHECK_EDIBILITY, movable_prey))
		return
	to_chat(user, span_notice("[span_green("[movable_prey]")] selected as [span_green("prey")]!"))
	our_prey = WEAKREF(movable_prey)
	user.do_attack_animation(movable_prey)
	playsound(get_turf(movable_prey), 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
	check_completion(user)

/obj/item/hand_item/feeder/proc/check_completion(mob/living/user)
	if(!our_pred || !our_prey)
		if(!our_pred && !our_prey)
			return
		TOGGLE_VAR(grab_pred)	
		if(isweakref(our_prey))
			var/atom/movable/movable_prey = RESOLVEWEAKREF(our_prey)
			var/yew = (movable_prey == user)
			if(yew)
				to_chat(user, span_notice("Now click on someone to [span_alert("eat")] [span_green("you")]!"))
			else
				to_chat(user, span_notice("Now click on who you want to [span_green("feed [movable_prey]")] to!"))
			return
		if(isweakref(our_pred))
			var/mob/living/living_pred = RESOLVEWEAKREF(our_pred)
			var/yew = (living_pred == user)
			if(yew)
				to_chat(user, span_notice("Now click on what [span_alert("you")] want to [span_green("eat")]!"))
			else
				to_chat(user, span_notice("Now click on what you want to [span_green("feed")] [span_alert("[living_pred]")]!"))
			return
	var/atom/movable/movable_prey = RESOLVEWEAKREF(our_prey)
	if(!movable_prey)
		to_chat(user, span_alert("Your prey no longer exists, probably!"))
		our_prey = null
	var/mob/living/living_pred = RESOLVEWEAKREF(our_pred)
	if(!living_pred)
		to_chat(user, span_alert("Your predator no longer exists, probably!"))
		our_pred = null
	if(!movable_prey || !living_pred)
		attack_self(user)
		return
	SEND_SIGNAL(user, COMSIG_VORE_DO_VORE, living_pred, movable_prey)
	qdel(src)
