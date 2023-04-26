#define LICK_LOCATION "lick_location"
#define LICK_INTENT "lick_intent"
#define LICK_CANCEL "dont_lick"
/// Sounds and text for licking have this range
#define LICK_SOUND_TEXT_RANGE 2

/// For all of the items that are really just the user's hand used in different ways, mostly (all, really) from emotes
/obj/item/hand_item
	name = "your hand"
	desc = "Gimme five (or however many fingers you have, if you have any)!"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM

/obj/item/hand_item/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_STORAGE_INSERT, TRAIT_GENERIC)

/// Just a cool hand-item that holds a healing... thing
/obj/item/hand_item/healable
	var/obj/item/stack/medical/bruise_pack/lick/healthing = /obj/item/stack/medical/bruise_pack/lick
	/// are we licking something?
	var/working = FALSE
	var/needed_trait = TRAIT_HEAL_TONGUE
	var/tend_word = "licking"
	var/action_verb = "lick"
	var/action_verb_s = "licks"
	var/action_verb_ing = "licking"
	var/can_taste = TRUE

/obj/item/hand_item/healable/attack(mob/living/L, mob/living/carbon/user)
	return start_licking(src, L, user)

/obj/item/hand_item/healable/attack_obj(obj/O, mob/living/user)
	return start_licking(src, O, user)

/obj/item/hand_item/healable/attack_obj_nohit(obj/O, mob/living/user)
	return start_licking(src, O, user)

/obj/item/hand_item/healable/proc/start_licking(atom/source, atom/licked, mob/living/carbon/user)
	if(!iscarbon(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	if(working)
		to_chat(user, span_alert("You're already [tend_word] something!"))
		return FALSE
	if(!licked)
		return FALSE
	if(tend_hurt(user, licked))
		return FALSE
	return TRUE

/obj/item/hand_item/healable/proc/tend_hurt(mob/living/user, mob/living/target)
	if(!isliving(user) || !isliving(target))
		return
	//if(!HAS_TRAIT(user, needed_trait))
	//	return
	var/mob/living/mlemmed = target
	if(!mlemmed.get_bodypart(user.zone_selected))
		return FALSE
	//if(bandage_wound(licked, user) == LICK_CANCEL)
	//	return TRUE // one thing at a time
	if(!istype(healthing))
		healthing = new(src)
	if(heal_damage(target, user) == LICK_CANCEL)
		return TRUE // one thing at a time

/obj/item/hand_item/healable/proc/heal_damage(mob/living/licked, mob/living/carbon/user)
	if(!isliving(licked))
		return FALSE
	if(!istype(healthing))
		return FALSE
	healthing.attack(licked, user)
	return TRUE

/// Course our first hand item would be a tongue
/obj/item/hand_item/healable/tender //chimken
	name = "triage kit"
	desc = "A small collection of vital medical supplies."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "traumapack"
	attack_verb = list("tended", "treated", "healed")
	pokesound = 'sound/items/tendingwounds.ogg'
	healthing = /obj/item/stack/medical/bruise_pack/lick/tend
	needed_trait = TRAIT_HEAL_TEND
	tend_word = "tending"
	action_verb = "tend"
	action_verb_s = "tends"
	action_verb_ing = "tending"
	can_taste = FALSE

/obj/item/hand_item/healable/toucher
	name = "touch"
	desc = "A finger, for touching things."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "feeder"
	attack_verb = list("touched", "poked", "prodded")
	pokesound = 'sound/items/tendingwounds.ogg'
	healthing = /obj/item/stack/medical/bruise_pack/lick/touch
	needed_trait = TRAIT_HEAL_TOUCH
	tend_word = "touching"
	action_verb = "touch"
	action_verb_s = "touches"
	action_verb_ing = "touching"
	can_taste = FALSE

/obj/item/hand_item/healable/licker
	name = "tongue"
	desc = "Mlem."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "tonguenormal"
	attack_verb = list("licked", "lapped", "mlemmed")
	pokesound = 'sound/effects/lick.ogg'
	siemens_coefficient = 5 // hewwo mistow ewectwic fence mlem mlem

/obj/item/hand_item/healable/licker/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_LICK_RETURN, .proc/start_licking)

/obj/item/hand_item/healable/licker/start_licking(atom/source, atom/licked, mob/living/carbon/user)
	if(..())
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TONGUE))
		return FALSE
	if(SEND_SIGNAL(licked, COMSIG_ATOM_LICKED, user, src))
		return TRUE
	lick_atom(licked, user)
	return TRUE

/obj/item/hand_item/healable/licker/heal_damage(mob/living/licked, mob/living/carbon/user)
	if(!..())
		return FALSE
	lick_flavor(atom_licked = licked, licker = user)

/obj/item/hand_item/healable/licker/proc/lick_atom(atom/movable/licked, mob/living/carbon/user)
	var/list/lick_words = get_lick_words(user)
	if(isliving(licked))
		user.visible_message(
			span_notice("[user] [lick_words[LICK_INTENT]] [action_verb_s] [user == licked ? "[user.p_their()]" : "[licked]'s"] [lick_words[LICK_LOCATION]]."),
			span_notice("You [lick_words[LICK_INTENT]] [action_verb] [user == licked ? "your" : "[licked]'s"] [lick_words[LICK_LOCATION]]."),
			span_notice("You hear [action_verb_ing]."),
			LICK_SOUND_TEXT_RANGE
		)
	else
		user.visible_message(
			span_notice("[user] [lick_words[LICK_INTENT]] [action_verb_s] [user == licked ? "[user.p_them()]self" : "[licked]"]."),
			span_notice("You [lick_words[LICK_INTENT]] [action_verb] [user == licked ? "yourself" : "[licked]"]."),
			span_notice("You hear [action_verb_ing]."),
			LICK_SOUND_TEXT_RANGE
		)
	if(can_taste)
		lick_flavor(atom_licked = licked, licker = user)

/obj/item/hand_item/healable/licker/proc/lick_flavor(atom/source, atom/atom_licked, mob/living/carbon/licker)
	if(!atom_licked)
		return
	if(!licker)
		var/mob/living/carbon/maybe_licker = loc
		if(!maybe_licker)
			return
		licker = maybe_licker
		
	licker.taste(null, atom_licked)
	playsound(get_turf(src), pokesound, 25, 1, SOUND_DISTANCE(LICK_SOUND_TEXT_RANGE))

// /obj/item/hand_item/healable/licker/proc/bandage_wound(mob/living/licked, mob/living/carbon/user)
// 	if(!iscarbon(licked))
// 		return FALSE
// 	var/obj/item/organ/tongue/our_tongue = user.getorganslot(ORGAN_SLOT_TONGUE)
// 	if(!istype(our_tongue.lick_bandage))
// 		return FALSE
// 	var/obj/item/stack/medical/tongue_bandage = our_tongue.lick_bandage
// 	var/mob/living/carbon/mlemmed = licked
// 	var/obj/item/bodypart/target_bodypart = mlemmed.get_bodypart(user.zone_selected)
// 	if(!target_bodypart)
// 		return FALSE
// 	if(target_bodypart.status != BODYPART_ORGANIC)
// 		return FALSE
// 	if(target_bodypart.bleed_dam <= 0)
// 		return FALSE
// 	var/has_bleeding_wound = FALSE
// 	for(var/datum/wound/a_wound in target_bodypart.wounds)
// 		if(istype(a_wound, /datum/wound/bleed))
// 			has_bleeding_wound = TRUE
// 			break
// 	if(!has_bleeding_wound)
// 		return FALSE
// 	if(!target_bodypart.apply_gauze(tongue_bandage, 1, TRUE))
// 		return FALSE
// 	working = TRUE
// 	user.visible_message(
// 		span_notice("[user] starts carefully lapping at the wounds on [user == mlemmed ? "[mlemmed.p_their()]" : "[mlemmed]'s"] [target_bodypart.name]..."), 
// 		span_notice("You start running your tongue across the wounds on [user == mlemmed ? "your" : "[mlemmed]'s"] [target_bodypart.name]..."),
// 		span_notice("You hear licking."),
// 		LICK_SOUND_TEXT_RANGE
// 		)
// 	lick_flavor(atom_licked = licked, licker = user)
// 	if(!do_mob(user, mlemmed, tongue_bandage.get_delay_time(user, mlemmed, 1), progress = TRUE))
// 		user.visible_message(span_alert("[user] was interrupted!"))
// 		working = FALSE
// 		return LICK_CANCEL
// 	working = FALSE
// 	if(QDELETED(our_tongue))
// 		user.visible_message(span_notice("[user]'s tongue went missing!"))
// 		return LICK_CANCEL
// 	if(target_bodypart.apply_gauze(tongue_bandage, 1, FALSE))
// 		user.visible_message(
// 			span_green("[user] applies a fresh coat of coagulating saliva on [user == mlemmed ? "[mlemmed.p_their()]" : "[mlemmed]'s"] [target_bodypart.name]!"), 
// 			span_green("You apply a fresh coat of coagulating saliva to [user == mlemmed ? "your" : "[mlemmed]'s"] [target_bodypart.name]!"),
// 			span_notice("You hear licking."),
// 			LICK_SOUND_TEXT_RANGE
// 			)
// 		lick_flavor(atom_licked = licked, licker = user)
// 		return LICK_CANCEL
// 	user.visible_message(span_alert("[user] was interrupted!"))
// 	return LICK_CANCEL

/obj/item/hand_item/healable/tongue/heal_damage(mob/living/licked, mob/living/carbon/user)
	var/obj/item/organ/tongue/our_tongue = user.getorganslot(ORGAN_SLOT_TONGUE)
	if(!istype(our_tongue))
		return FALSE
	. = ..()


/obj/item/hand_item/healable/licker/proc/get_lick_words(mob/living/carbon/user)
	if(!user)
		return

	. = list(LICK_LOCATION = "spot", LICK_INTENT = "like a dork")
	switch(user.zone_selected)
		if(BODY_ZONE_CHEST)
			.[LICK_LOCATION] = "chest"
		if(BODY_ZONE_HEAD)
			.[LICK_LOCATION] = "face"
		if(BODY_ZONE_L_ARM)
			.[LICK_LOCATION] = "left arm"
		if(BODY_ZONE_R_ARM)
			.[LICK_LOCATION] = "right arm"
		if(BODY_ZONE_L_LEG)
			.[LICK_LOCATION] = "left leg"
		if(BODY_ZONE_R_LEG)
			.[LICK_LOCATION] = "right leg"
		if(BODY_ZONE_PRECISE_EYES)
			.[LICK_LOCATION] = "eyes"
		if(BODY_ZONE_PRECISE_MOUTH)
			.[LICK_LOCATION] = "lips"
		if(BODY_ZONE_PRECISE_GROIN)
			.[LICK_LOCATION] = "butt"
		if(BODY_ZONE_PRECISE_L_HAND)
			.[LICK_LOCATION] = "left hand"
		if(BODY_ZONE_PRECISE_R_HAND)
			.[LICK_LOCATION] = "right hand"
		if(BODY_ZONE_PRECISE_L_FOOT)
			.[LICK_LOCATION] = "left foot"
		if(BODY_ZONE_PRECISE_R_FOOT)
			.[LICK_LOCATION] = "right foot"
	switch(user.a_intent)
		if(INTENT_HELP)
			.[LICK_INTENT] = "gently"
		if(INTENT_DISARM)
			.[LICK_INTENT] = "briskly"
		if(INTENT_GRAB)
			.[LICK_INTENT] = "aggressively"
		if(INTENT_HARM)
			.[LICK_INTENT] = "very aggressively"


#undef LICK_LOCATION
#undef LICK_INTENT
#undef LICK_CANCEL

////////
//Bite//
////////
/obj/item/hand_item/biter
	name = "Biter"
	desc = "Talk shit, get bit."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "biter"
	attack_verb = list("chomped", "gnawed", "bit", "crunched", "nommed")
	hitsound = "sound/weapons/bite.ogg"
	siemens_coefficient = 5 
	force = 6
	force_wielded = 10
	throwforce = 0
	wound_bonus = 5
	sharpness = SHARP_EDGED
	attack_speed = 4
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM

/obj/item/hand_item/clawer
	name = "Clawer"
	desc = "Thems some claws."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "clawer"
	attack_verb = list("clawed", "swiped", "raked")
	hitsound = "sound/weapons/bladeslice.ogg"
	force = 5
	force_wielded = 8
	throwforce = 0
	wound_bonus = 4
	sharpness = SHARP_EDGED
	attack_speed = 2
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM

/obj/item/hand_item/shover
	name = "shover"
	desc = "Stay back!"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "latexballon"
	item_state = "nothing"
	attack_verb = list("shoved", "pushed")
	hitsound = "sound/weapons/thudswoosh.ogg"
	force = 0
	force_wielded = 0
	throwforce = 0
	wound_bonus = 0
	attack_speed = 12
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM

/obj/item/hand_item/shover/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/knockback, 1, FALSE, TRUE)
