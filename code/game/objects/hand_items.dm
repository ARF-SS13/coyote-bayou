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
	var/obj/item/stack/medical/healthing = /obj/item/stack/medical/bruise_pack/lick
	/// are we licking something?
	var/working = FALSE
	var/needed_trait = TRAIT_HEAL_TONGUE
	var/tend_word = "licking"
	var/action_verb = "lick"
	var/action_verb_s = "licks"
	var/action_verb_ing = "licking"
	var/can_taste = TRUE

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

/obj/item/hand_item/healable/attack(mob/living/L, mob/living/carbon/user)
	return start_licking(src, L, user)

/obj/item/hand_item/healable/attack_obj(obj/O, mob/living/user)
	return start_licking(src, O, user)

/obj/item/hand_item/healable/attack_obj_nohit(obj/O, mob/living/user)
	return start_licking(src, O, user)

/obj/item/hand_item/healable/proc/start_licking(atom/source, atom/licked, mob/living/carbon/user)
	if(!iscarbon(user))
		return FALSE
	if(working)
		to_chat(user, span_alert("You're already [tend_word] something!"))
		return FALSE
	if(!licked)
		return FALSE
	if(tend_hurt(user, licked))
		return TRUE
	lick_atom(licked, user)
	return cool_thing(source, user, licked)

/obj/item/hand_item/healable/proc/cool_thing(mob/living/carbon/user, atom/licked)
	return TRUE

/obj/item/hand_item/healable/proc/tend_hurt(mob/living/user, mob/living/target)
	if(!isliving(user) || !isliving(target))
		return
	if(!HAS_TRAIT(user, needed_trait))
		return FALSE
	var/mob/living/mlemmed = target
	if(!mlemmed.get_bodypart(user.zone_selected))
		return FALSE
	if(!istype(healthing))
		healthing = new healthing(src)
	if(!istype(healthing))
		return FALSE
	if(!healthing.try_heal(mlemmed, user, TRUE))
		return FALSE
	healthing.attack(mlemmed, user)
	return TRUE


/obj/item/hand_item/healable/licker/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_LICK_RETURN, .proc/start_licking)

/obj/item/hand_item/healable/proc/lick_atom(atom/movable/licked, mob/living/carbon/user)
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

/obj/item/hand_item/healable/proc/lick_flavor(atom/source, atom/atom_licked, mob/living/carbon/licker)
	if(!atom_licked)
		return
	if(!licker)
		var/mob/living/carbon/maybe_licker = loc
		if(!maybe_licker)
			return
		licker = maybe_licker
		
	licker.taste(null, atom_licked)
	playsound(get_turf(src), pokesound, 25, 1, SOUND_DISTANCE(LICK_SOUND_TEXT_RANGE))

/obj/item/hand_item/healable/licker/tend_hurt(mob/living/licked, mob/living/carbon/user)
	var/obj/item/organ/tongue/our_tongue = user.getorganslot(ORGAN_SLOT_TONGUE)
	if(!istype(our_tongue))
		return FALSE
	. = ..()

/obj/item/hand_item/healable/proc/get_lick_words(mob/living/carbon/user)
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
	w_class = WEIGHT_CLASS_TINY
	siemens_coefficient = 5 
	force = 6
	force_wielded = 10
	throwforce = 0
	wound_bonus = 5
	sharpness = SHARP_EDGED
	attack_speed = 4
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/hand_item/biter/creature
	force = 25
	force_wielded = 30

/obj/item/hand_item/biter/big
	name = "Big Biter"
	desc = "Talk shit, get BIG bit."
	color = "#884444"
	force = 15
	force_wielded = 18
	attack_speed = 5

/obj/item/hand_item/biter/sabre
	name = "Sabre Toothed Biter"
	desc = "Damn bitch, you eat with them teeth?"
	color = "#FF4444"
	force = 5
	force_wielded = 27
	attack_speed = 6

/obj/item/hand_item/biter/fast
	name = "Big Biter"
	desc = "Talk shit, get SPEED bit."
	color = "#448844"
	force = 4
	force_wielded = 7
	attack_speed = 3

/obj/item/hand_item/biter/play
	name = "Play Biter"
	desc = "Someone really should just muzzle you."
	color = "#ff44ff"
	force = 0
	force_wielded = 0
	attack_speed = 1

/obj/item/hand_item/biter/spicy
	name = "Spicy Biter"
	desc = "Your sickly little nibbler, good for dropping fools."
	color = "#44FF44"
	force = 5
	force_wielded = 10
	attack_speed = 5


/obj/item/hand_item/biter/spicy/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(30, STAMINA, "chest", M.run_armor_check("chest", "brute"))


/obj/item/hand_item/clawer
	name = "Clawer"
	desc = "Thems some claws."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "clawer"
	attack_verb = list("clawed", "swiped", "raked")
	hitsound = "sound/weapons/bladeslice.ogg"
	w_class = WEIGHT_CLASS_TINY
	force = 5
	force_wielded = 8
	throwforce = 0
	wound_bonus = 4
	sharpness = SHARP_EDGED
	attack_speed = 2
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/hand_item/clawer/creature
	force = 25
	force_wielded = 30

/obj/item/hand_item/clawer/big
	name = "Big Clawer"
	desc = "Thems some BIG ASS claws."
	color = "#884444"
	force = 7
	force_wielded = 9
	attack_speed = 3

/obj/item/hand_item/clawer/razor
	name = "Razor Sharp Clawers"
	desc = "RIP AND TEAR."
	color = "#FF4444"
	force = 5
	force_wielded = 17
	attack_speed = 4

/obj/item/hand_item/clawer/fast
	name = "Fast Clawer"
	desc = "Thems some FAST ASS claws."
	color = "#448844"
	force = 4
	force_wielded = 7
	attack_speed = 1

/obj/item/hand_item/clawer/play
	name = "Play Clawer"
	desc = "Basically just a bean thwapper."
	color = "#FF88FF"
	force = 0
	force_wielded = 0
	attack_speed = 1

/obj/item/hand_item/clawer/spicy
	name = "Spicy Clawer"
	desc = "Your gross little litter box rakes, good for puttings idiots on the ground."
	color = "#44FF44"
	force = 7
	force_wielded = 11 //7-11 haha get it bad gas station food lmao ~TK
	attack_speed = 4

/obj/item/hand_item/clawer/spicy/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(30, STAMINA, "chest", M.run_armor_check("chest", "brute"))

/obj/item/hand_item/arm_blade/mutation
	name = "arm blade"
	desc = "A grotesque blade made out of bone and flesh that cleaves through people as a hot knife through butter."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "arm_blade"
	item_state = "arm_blade"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	item_flags = HAND_ITEM | ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 40
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_EDGED
	wound_bonus = 0
	bare_wound_bonus = 20

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

/obj/item/hand_item/playfultail/
	name = "playful tail"
	desc = "A playful tail, good for teasing."
	icon_state = "proboscis"
	force = 0
	force_wielded = 0
	attack_speed = 3
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/hand_item/tail
	name = "tailwhack"
	desc = "A tail. Good for whacking."
	icon_state = "proboscis"
	w_class = WEIGHT_CLASS_TINY
	force = 5
	force_wielded = 10
	attack_speed = 4 
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/hand_item/tail/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/knockback, 1, FALSE, TRUE)

/obj/item/hand_item/tail/fast
	name = "fast tail"
	desc = "A speedy tail that's very good at whackin' fast."
	icon_state = "proboscis"
	color = "#448844"
	force = 3
	force_wielded = 7
	attack_speed = 2

/obj/item/hand_item/tail/big
	name = "big tail"
	desc = "A big tail that whacks hard."
	icon_state = "proboscis"
	color = "#884444"
	force = 10
	force_wielded = 20
	attack_speed = 5

/obj/item/hand_item/tail/spicy
	name = "spicy tail"
	desc = "A tail with something that can inject venom on it."
	icon_state = "proboscis"
	color = "#44FF44"
	force = 4
	force_wielded = 8
	attack_speed = 5

/obj/item/hand_item/tail/spicy/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(30, STAMINA, "chest", M.run_armor_check("chest", "brute"))

/obj/item/hand_item/tail/thago
	name = "dangerous tail"
	desc = "A god damn mighty tail that would kill an allosaurus.  Maybe."
	icon_state = "proboscis"
	color = "#FF4444"
	force = 12
	force_wielded = 24
	attack_speed = 6

/obj/item/hand_item/beans
	name = "beans"
	desc = "Them's ya' beans. Touch em' to things."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "bean"
	color = "#ff88bb"
	attack_verb = list("beans", "baps", "smushes")
	hitsound = "sound/effects/attackblob.ogg"
	force = 0
	force_wielded = 0
	throwforce = 0
	attack_speed = 0
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/hand_item/beans/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(1, STAMINA, "chest", M.run_armor_check("chest", "brute"))

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


