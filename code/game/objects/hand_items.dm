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
	resistance_flags = FIRE_PROOF | ACID_PROOF
	rad_flags = RAD_NO_CONTAMINATE
	slot_flags = INV_SLOTBIT_DENYPOCKET

/obj/item/hand_item/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_STORAGE_INSERT, TRAIT_GENERIC)

/// Just a cool hand-item that holds a healing... thing
/obj/item/hand_item/tactile
	var/obj/item/stack/medical/healthing = /obj/item/stack/medical/bruise_pack/lick
	/// are we licking something?
	var/working = FALSE
	var/needed_trait = TRAIT_HEAL_TONGUE
	var/tend_word = "licking"
	var/action_verb = "lick"
	var/action_verb_s = "licks"
	var/action_verb_ing = "licking"
	var/can_taste = TRUE
	var/datum/grope_kiss_MERP/grope = /datum/grope_kiss_MERP
	var/list/lastgrope

/// Course our first hand item would be a tongue
/obj/item/hand_item/tactile/tender //chimken
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

/obj/item/hand_item/tactile/toucher //being repurposed as a way to 'feel' the world around the player.  Specifically other players though, lets be real.
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

/obj/item/hand_item/tactile/kisser
	name = "kisser"
	desc = "A kisser, for smooching things."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "kisser"
	attack_verb = list("kissed", "smooched", "snogged")
	grope = /datum/grope_kiss_MERP/kiss
	pokesound = list(
		'sound/effects/kiss.ogg',
		'modular_splurt/sound/interactions/kiss/kiss1.ogg',
		'modular_splurt/sound/interactions/kiss/kiss2.ogg',
		'modular_splurt/sound/interactions/kiss/kiss3.ogg',
		'modular_splurt/sound/interactions/kiss/kiss4.ogg',
	)
	healthing = /obj/item/stack/medical/bruise_pack/lick/touch
	needed_trait = TRAIT_HEAL_TOUCH
	tend_word = "smooching"
	action_verb = "kiss"
	action_verb_s = "kisses"
	action_verb_ing = "kissing"
	can_taste = FALSE

/obj/item/hand_item/tactile/licker
	name = "tongue"
	desc = "Mlem."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "tonguenormal"
	grope = /datum/grope_kiss_MERP/lick
	attack_verb = list("licked", "lapped", "mlemmed")
	pokesound = 'sound/effects/lick.ogg'
	siemens_coefficient = 5 // hewwo mistow ewectwic fence mlem mlem

/obj/item/hand_item/tactile/attack(mob/living/L, mob/living/carbon/user)
	return start_licking(src, L, user)

/obj/item/hand_item/tactile/attack_obj(obj/O, mob/living/user)
	return start_licking(src, O, user)

/obj/item/hand_item/tactile/attack_obj_nohit(obj/O, mob/living/user)
	return start_licking(src, O, user)

/obj/item/hand_item/tactile/proc/start_licking(atom/source, atom/licked, mob/living/user)
	if(!isliving(user))
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

/obj/item/hand_item/tactile/proc/cool_thing(mob/living/user, atom/licked)
	return TRUE

/obj/item/hand_item/tactile/proc/tend_hurt(mob/living/user, mob/living/target)
	if(!isliving(user) || !isliving(target))
		return
	if(!HAS_TRAIT(user, needed_trait))
		return FALSE
	var/mob/living/mlemmed = target
	if(iscarbon(mlemmed) && !mlemmed.get_bodypart(user.zone_selected))
		return FALSE
	if(!istype(healthing))
		healthing = new healthing(src)
	if(!istype(healthing))
		return FALSE
	if(!healthing.try_heal(mlemmed, user, TRUE))
		return FALSE
	healthing.attack(mlemmed, user)
	return TRUE


/obj/item/hand_item/tactile/licker/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_LICK_RETURN,PROC_REF(start_licking))

/obj/item/hand_item/tactile/proc/lick_atom(atom/movable/licked, mob/living/user)
	if(SEND_SIGNAL(licked, COMSIG_ATOM_LICKED, user, src))
		return
	if(do_a_grope(user, licked))
		return
	var/list/lick_words = get_lick_words(user)
	if(isliving(licked))
		user.visible_message(
			span_notice("[user] [lick_words[LICK_INTENT]] [action_verb_s] [user == licked ? "[user.p_their()]" : "[licked]'s"] [lick_words[LICK_LOCATION]]."),
			span_notice("I [lick_words[LICK_INTENT]] [action_verb] [user == licked ? "your" : "[licked]'s"] [lick_words[LICK_LOCATION]]."),
			span_notice("I hear [action_verb_ing]."),
			LICK_SOUND_TEXT_RANGE
		)
	else
		user.visible_message(
			span_notice("[user] [lick_words[LICK_INTENT]] [action_verb_s] [user == licked ? "[user.p_them()]self" : "[licked]"]."),
			span_notice("I [lick_words[LICK_INTENT]] [action_verb] [user == licked ? "yourself" : "[licked]"]."),
			span_notice("I hear [action_verb_ing]."),
			LICK_SOUND_TEXT_RANGE
		)
	var/list/sounds2play = list()
	// sounds2play += hitsound
	sounds2play += pokesound
	playsound(licked, safepick(sounds2play), 85, TRUE)
	if(can_taste && iscarbon(user))
		lick_flavor(atom_licked = licked, licker = user)

/obj/item/hand_item/tactile/proc/lick_flavor(atom/source, atom/atom_licked, mob/living/licker)
	if(!atom_licked)
		return
	if(!licker)
		var/mob/living/maybe_licker = loc
		if(!isliving(maybe_licker))
			return
		licker = maybe_licker
	if(iscarbon(licker))
		var/mob/living/carbon/C = licker
		C.taste(null, atom_licked)
	playsound(get_turf(src), pokesound, 25, 1, SOUND_DISTANCE(LICK_SOUND_TEXT_RANGE))

/obj/item/hand_item/tactile/licker/tend_hurt(mob/living/licked, mob/living/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		var/obj/item/organ/tongue/our_tongue = C.getorganslot(ORGAN_SLOT_TONGUE)
		if(!istype(our_tongue))
			return FALSE
	. = ..()

/obj/item/hand_item/tactile/proc/do_a_grope(mob/living/doer, mob/living/target)
	if(!LAZYLEN(GLOB.gropekissers))
		for(var/booby in typesof(/datum/grope_kiss_MERP))
			var/datum/grope_kiss_MERP/gkm = new booby()
			GLOB.gropekissers[gkm.type] = gkm
	if(!grope)
		return
	var/datum/grope_kiss_MERP/gunkem = LAZYACCESS(GLOB.gropekissers, grope)
	if(!gunkem) // the G is soft
		return
	var/list/gropeturn = gunkem.make_visible_message(doer, target, lastgrope)
	if(gropeturn)
		lastgrope = gropeturn
		return TRUE

/obj/item/hand_item/tactile/proc/get_lick_words(mob/living/user)
	if(!user)
		return

	. = list(LICK_LOCATION = "spot", LICK_INTENT = "like a dork") //👀 Dan I swear to god.
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
/*
You take the item in hand.
The item + the intent + direction of click = outcome.
Example

Touch + Help + facing each other = Hug
Touch + help + facing their side = pat shoulder
touch + help + facing their rear = pat back
*/

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
	slot_flags = INV_SLOTBIT_GLOVES
	w_class = WEIGHT_CLASS_TINY
	flags_1 = CONDUCT_1
	force = 0
	backstab_multiplier = 1.0
	throwforce = 0
	wound_bonus = 0
	sharpness = SHARP_POINTY
	attack_speed = CLICK_CD_MELEE * 0.7
	item_flags = PERSONAL_ITEM | ABSTRACT | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf
	var/can_adjust_unarmed = TRUE
	var/unarmed_adjusted = TRUE

/obj/item/hand_item/biter/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(ishuman(user) && slot == SLOT_GLOVES)
		ADD_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(HAS_TRAIT(user, TRAIT_UNARMED_WEAPON))
			H.dna.species.punchdamagehigh += force + 8 //Work around for turbo bad code here. Makes this correctly stack with your base damage. No longer makes ghouls the kings of melee.
			H.dna.species.punchdamagelow += force + 8
			H.dna.species.attack_sound = hitsound
			if(sharpness == SHARP_POINTY || sharpness ==  SHARP_EDGED)
				H.dna.species.attack_verb = pick("chomped", "gnawed", "bit", "crunched", "nommed")
	if(ishuman(user) && slot != SLOT_GLOVES && !H.gloves)
		REMOVE_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(!HAS_TRAIT(user, TRAIT_UNARMED_WEAPON)) //removing your funny trait shouldn't make your fists infinitely stack damage.
			H.dna.species.punchdamagehigh = 10
			H.dna.species.punchdamagelow = 1
		if(HAS_TRAIT(user, TRAIT_IRONFIST))
			H.dna.species.punchdamagehigh = 12
			H.dna.species.punchdamagelow = 6
		if(HAS_TRAIT(user, TRAIT_STEELFIST))
			H.dna.species.punchdamagehigh = 16
			H.dna.species.punchdamagelow = 10
		H.dna.species.attack_sound = 'sound/weapons/bite.ogg'
		H.dna.species.attack_verb = "bites"

/obj/item/hand_item/biter/creature
	force = 35
	force_wielded = 45
	force_unwielded = 35
	

/obj/item/hand_item/biter/big
	name = "Big Biter"
	desc = "Talk shit, get BIG bit."
	color = "#884444"
	force = 40
	force_wielded = 50
	force_unwielded = 40
	attack_speed = CLICK_CD_MELEE * 0.8

/obj/item/hand_item/biter/sabre
	name = "Sabre Toothed Biter"
	desc = "Damn bitch, you eat with them teeth?"
	color = "#FF4444"
	force = 45
	force_wielded = 55
	force_unwielded = 45
	attack_speed = CLICK_CD_MELEE * 1.2

/obj/item/hand_item/biter/fast
	name = "Fast Biter"
	desc = "Talk shit, get SPEED bit."
	color = "#448844"
	force = 25
	force_wielded = 30
	force_unwielded = 25
	attack_speed = CLICK_CD_MELEE * 0.5

/obj/item/hand_item/biter/play
	name = "Play Biter"
	desc = "Someone really should just muzzle you."
	color = "#ff44ff"
	force = 0
	force_wielded = 0
	force_unwielded = 0
	attack_speed = 1

/obj/item/hand_item/biter/spicy
	name = "Spicy Biter"
	desc = "My sickly little nibbler, good for dropping fools."
	color = "#44FF44"
	force = 35
	force_wielded = 45
	force_unwielded = 35
	attack_speed = CLICK_CD_MELEE * 0.8


/obj/item/hand_item/biter/spicy/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(30, STAMINA, "chest", M.run_armor_check("chest", "melee"))


/obj/item/hand_item/clawer
	name = "Clawer"
	desc = "Thems some claws."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "clawer"
	slot_flags = INV_SLOTBIT_GLOVES
	w_class = WEIGHT_CLASS_TINY
	flags_1 = CONDUCT_1
	sharpness = SHARP_EDGED
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	force = 30
	force_wielded = 40
	force_unwielded = 30
	backstab_multiplier = 1.8
	throwforce = 0
	wound_bonus = 4
	sharpness = SHARP_EDGED
	attack_speed = CLICK_CD_MELEE * 0.7
	item_flags = PERSONAL_ITEM | ABSTRACT | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/hand_item/clawer/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(ishuman(user) && slot == SLOT_GLOVES)
		ADD_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(HAS_TRAIT(user, TRAIT_UNARMED_WEAPON))
			H.dna.species.punchdamagehigh += force + 8 //Work around for turbo bad code here. Makes this correctly stack with your base damage. No longer makes ghouls the kings of melee.
			H.dna.species.punchdamagelow += force + 8
			H.dna.species.attack_sound = hitsound
			if(sharpness == SHARP_POINTY || sharpness ==  SHARP_EDGED)
				H.dna.species.attack_verb = pick("slash","slice","rip","tear","cut","dice","clawed")
	if(ishuman(user) && slot != SLOT_GLOVES && !H.gloves)
		REMOVE_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(!HAS_TRAIT(user, TRAIT_UNARMED_WEAPON)) //removing your funny trait shouldn't make your fists infinitely stack damage.
			H.dna.species.punchdamagehigh = 10
			H.dna.species.punchdamagelow = 1
		if(HAS_TRAIT(user, TRAIT_IRONFIST))
			H.dna.species.punchdamagehigh = 12
			H.dna.species.punchdamagelow = 6
		if(HAS_TRAIT(user, TRAIT_STEELFIST))
			H.dna.species.punchdamagehigh = 16
			H.dna.species.punchdamagelow = 10
		H.dna.species.attack_sound = 'sound/weapons/punch1.ogg'
		H.dna.species.attack_verb = "punch"


/obj/item/hand_item/clawer/creature
	force = 30
	force_wielded = 40
	force_unwielded = 30

/obj/item/hand_item/clawer/big
	name = "Big Clawer"
	desc = "Thems some BIG ASS claws."
	color = "#884444"
	force = 35
	force_wielded = 45
	force_unwielded = 35
	attack_speed = CLICK_CD_MELEE * 0.8

/obj/item/hand_item/clawer/razor
	name = "Razor Sharp Clawers"
	desc = "RIP AND TEAR."
	color = "#FF4444"
	force = 40
	force_wielded = 50
	force_unwielded = 40
	attack_speed = CLICK_CD_MELEE * 1.2

/obj/item/hand_item/clawer/fast
	name = "Fast Clawer"
	desc = "Thems some FAST ASS claws."
	color = "#448844"
	force = 30
	force_wielded = 40
	force_unwielded = 30
	attack_speed = CLICK_CD_MELEE * 0.5

/obj/item/hand_item/clawer/play
	name = "Play Clawer"
	desc = "Basically just a bean thwapper."
	color = "#FF88FF"
	force = 0
	force_wielded = 0
	force_unwielded = 0
	attack_speed = 1

/obj/item/hand_item/clawer/spicy
	name = "Spicy Clawer"
	desc = "My gross little litter box rakes, good for puttings idiots on the ground."
	color = "#44FF44"
	force = 30
	force_wielded = 40
	force_unwielded = 30
	attack_speed = CLICK_CD_MELEE * 0.8

/obj/item/hand_item/clawer/spicy/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(30, STAMINA, "chest", M.run_armor_check("chest", "melee"))

/obj/item/hand_item/arm_blade/mutation
	name = "arm blade"
	desc = "A grotesque blade made out of bone and flesh that cleaves through people as a hot knife through butter."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "arm_blade"
	inhand_icon_state = "arm_blade"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	item_flags = HAND_ITEM | ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 40
	force_wielded = 50
	force_unwielded = 40
	backstab_multiplier = 1.5
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_EDGED
	attack_speed = CLICK_CD_MELEE * 0.8
	wound_bonus = 0
	bare_wound_bonus = 20
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/hand_item/arm_blade/mutation/cyber
	name = "Cyber blade"
	desc = "A advanced cybernetic blade made out of numerous materials that cleaves through people as a hot knife through butter."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "cyber_blade"
	inhand_icon_state = "cyber_blade"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	item_flags = HAND_ITEM | ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 40
	force_wielded = 50
	force_unwielded = 40
	backstab_multiplier = 1.5
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_EDGED
	attack_speed = CLICK_CD_MELEE * 0.8
	wound_bonus = 0
	bare_wound_bonus = 20
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/hand_item/shover
	name = "shover"
	desc = "Stay back!"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "latexballon"
	inhand_icon_state = "nothing"
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
	force = 15
	backstab_multiplier = 1.8
	attack_speed = CLICK_CD_MELEE * 0.7
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/hand_item/tail/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/knockback, 1, FALSE, TRUE)

/obj/item/hand_item/tail/fast
	name = "fast tail"
	desc = "A speedy tail that's very good at whackin' fast."
	icon_state = "proboscis"
	color = "#448844"
	force = 18
	attack_speed = CLICK_CD_MELEE * 0.6

/obj/item/hand_item/tail/big
	name = "big tail"
	desc = "A big tail that whacks hard."
	icon_state = "proboscis"
	color = "#884444"
	force = 25
	attack_speed = CLICK_CD_MELEE * 0.8

/obj/item/hand_item/tail/spicy
	name = "spicy tail"
	desc = "A tail with something that can inject venom on it."
	icon_state = "proboscis"
	color = "#44FF44"
	force = 15
	attack_speed = CLICK_CD_MELEE * 0.8

/obj/item/hand_item/tail/spicy/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(30, STAMINA, "chest", M.run_armor_check("chest", "melee"))

/obj/item/hand_item/tail/thago
	name = "dangerous tail"
	desc = "A god damn mighty tail that would kill an allosaurus.  Maybe."
	icon_state = "proboscis"
	color = "#FF4444"
	force = 40
	attack_speed = CLICK_CD_MELEE * 1.2

/obj/item/hand_item/beans
	name = "beans"
	desc = "Them's ya' beans. Touch em' to things."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "bean"
	color = "#ff88bb"
	attack_verb = list()
	hitsound = "sound/effects/attackblob.ogg"
	force = 0
	force_wielded = 0
	throwforce = 0
	attack_speed = 0
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/hand_item/beans_war
	name = "war beans"
	desc = "Them's ya' war beans. Touch em' to things you want dead."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "bean"
	color = "#ff4444"
	attack_verb = list()
	hitsound = "sound/effects/attackblob.ogg"
	force = 6
	force_wielded = 10
	backstab_multiplier = 3 //OBLITERATE THEM, BOYKISSER. ~TK
	throwforce = 0
	attack_speed = 0
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/hand_item/beans/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(1, STAMINA, "chest", M.run_armor_check("chest", "melee"))
	// would need to be something that can be easily applied to other things
	// without copypasting code
	// probably a component
	// massage beans


/////////////
//Cantrips//
///////////


/obj/item/hand_item/cantrip
	name = "Cantrip"
	desc = "it's magic yo."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "clawer"
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	force = 15
	backstab_multiplier = 1.8
	throwforce = 0
	wound_bonus = 4
	attack_speed = CLICK_CD_MELEE * 0.7
	item_flags = DROPDEL | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf


/obj/item/hand_item/cantrip/godhand
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"
	icon = 'icons/obj/items_and_weapons.dmi'
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	name = "Shocking Grasp"
	desc = "A basic cantrip that allows the caster to inflict nasty shocks on touch"
	item_flags = ABSTRACT | DROPDEL
	force = 30
	backstab_multiplier = 1.6
	hitsound = 'sound/weapons/sear.ogg'
	damtype = BURN
	attack_verb = list("seared", "zapped", "fried", "shocked")


/obj/item/hand_item/merp_doer
	name = "MERP doer"
	desc = "Click someone with this thing to open the MERP interactions menu! From there, you can do all sorts of lewd or not-so-lewd things with them (or yourself!!)!"
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "blushfox"

/obj/item/hand_item/merp_doer/attack(mob/living/M, mob/living/user)
	SEND_SIGNAL(user, COMSIG_CLICK_CTRL_SHIFT, M)
	qdel(src)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/obj/item/hand_item/subtle_catapult
	name = "discrete action delivery system"
	desc = "Do lewd things in public, without anyone (but whoever you're doing it to) knowing!"
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "blushfox"
	item_flags = ABSTRACT | HAND_ITEM | NO_TURN
	max_reach = 70
	var/message
	var/aoe_range = 1

/obj/item/hand_item/subtle_catapult/examine(mob/user)
	. = ..()
	// . += span_green("AOE range: Your tile, plus [aoe_range] tiles in every direction.")
	. += span_green("Current message:")
	. += span_notice(message ? message : "None.")
	. += span_green("--")
	. += span_green("HOW 2 USE:")
	. += span_notice("1. Click it in hand to start writing a message.")
	. += span_notice("2. Click this on someone to send that message to them.")
	. += span_notice("3. Or CtrlShift click it to pick anyone in view")
	. += span_notice("You can also alt-click it to view your previous messages, and even select them to send!")
	. += span_notice("It will ask you to confirm before sending, so don't worry about accidentally sending something you didn't mean to!")
	. += span_notice("Also dont worry about dropping it or anything, it should still take whatever you wrote with it!")
	. += span_green("--")

/obj/item/hand_item/subtle_catapult/pre_attack(atom/A, mob/living/user, params, attackchain_flags, damage_multiplier)
	. = TRUE
	if(!extract_client(A))
		return
	if(message)
		StartSendMessage(user, A)
	else
		EditMessage(user, A)

/obj/item/hand_item/subtle_catapult/attack_self(mob/user)
	. = ..()
	EditMessage(user)

/obj/item/hand_item/subtle_catapult/AltClick(mob/user)
	. = ..()
	var/list/messages = SSchat.GetHornyHistory(user)
	if(!LAZYLEN(messages))
		to_chat(user, span_alert("You haven't made any messages yet!"))
		return
	var/selected = input(
		user, 
		"Here's a list of the messages you've made with this! Pick one to load it into this tool!", 
		"Select a message to send!", 
		message,
	) as null|anything in messages
	if(selected)
		message = selected
		to_chat(user, span_green("Message loaded!"))
	else
		to_chat(user, span_alert("Message selection cancelled!"))

/obj/item/hand_item/subtle_catapult/CtrlShiftClick(mob/user)
	. = ..()
	var/list/ppl = hearers(10, user)
	for(var/mob/M in ppl)
		if(!extract_client(M))
			ppl -= M
		if(!isliving(M))
			ppl -= M
		if(M == user)
			ppl -= M
	var/mob/whomst = input(
		user,
		"Who would you like to send a message to?",
		"Select a target!",
		null
	) as null|anything in ppl
	if(whomst)
		if(message)
			StartSendMessage(user, whomst)
		else
			EditMessage(user, whomst)
	else
		to_chat(user, span_alert("Message selection cancelled!"))

/obj/item/hand_item/subtle_catapult/dropped(mob/user)
	. = ..()
	SSchat.StashHornyThing(user)

/obj/item/hand_item/subtle_catapult/proc/EditMessage(mob/user, mob/living/M, and_send)
	var/head = M ? "Prepare a message for [M]!" : "Prepare a message!"
	var/msg = stripped_multiline_input_or_reflect(user, EMOTE_HEADER_TEXT, head, message, 99999)
	if(msg)
		to_chat(user, span_green("Message prepared:"))
		to_chat(user, span_notice(msg))
		to_chat(user, span_green("Click [M] to send it!"))
		message = msg
		SSchat.StoreHornyMessage(user, msg)
		if(M)
			StartSendMessage(user, M)
	else
		to_chat(user, span_alert("Message cancelled! Nothing's changed!!"))

/obj/item/hand_item/subtle_catapult/proc/StartSendMessage(mob/user, mob/living/M)
	if(!message)
		return
	if(!M || !user)
		return
	// if(M == user || !M.client)
	// 	return
	var/shomsg = message
	if(LAZYLEN(shomsg) > 700)
		shomsg = copytext(shomsg, 0, 700) + "..."
	// first we ask em, you sure you wanna do this?
	var/confirm = alert(user, "You are about to send this message to [M]:\n\n[message]\n\nAre you sure you want to do this?", "Send message?", "Yes", "No")
	if(confirm != "Yes")
		to_chat(user, span_alert("Okay nevermind!!"))
		return
	DeliverMessage(user, M)

/obj/item/hand_item/subtle_catapult/proc/DeliverMessage(mob/user, mob/living/M)
	var/original_message = message
	var/to_send = message

	user.log_message(to_send, LOG_SUBTLE)
	var/msg_check = user.say_narrate_replace(to_send, user)
	if(msg_check)
		to_send = span_subtle("<i>[msg_check]</i>")
	else
		to_send = span_subtle("<b>[user]</b> " + "<i>[user.say_emphasis(to_send)]</i>")

	var/datum/emote/E
	E = E.emote_list["subtle"]

	var/datum/rental_mommy/chat/mommy = E.BuildMommy(user, to_send)
	mommy.original_message = original_message
	mommy.exclusive_targets = list(M, user)

	// Visible to_send, as in only visible to you and them
	user.visible_message(
		message = to_send,
		data = list("mom" = mommy))

	//broadcast to ghosts, if they have a client, are dead, arent in the lobby, allow ghostsight, and, if subtler, are admemes
	user.emote_for_ghost_sight(mommy.message, TRUE, 0)
	mommy.checkin()
	user.playsound_local(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 80, FALSE)
	M.playsound_local(get_turf(M), 'sound/f13effects/sunsetsounds/blush.ogg', 80, FALSE)

////////
//Bite//
////////
/obj/item/hand_item/butt
	name = "your butt"
	desc = "Very smoochable."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "biter"
	attack_verb = list("smecked", "bwapped", "bumped", "clapped", "quapped", "vooped", "whomped")
	// hitsound = "sound/weapons/bite.ogg"
	w_class = WEIGHT_CLASS_GIGANTIC // your butt is HUGE!!!!
	flags_1 = CONDUCT_1
	force = 0

/obj/item/hand_item/butt/equipped(mob/user, slot)
	. = ..()
	buttify(user)

/obj/item/hand_item/butt/pickup(mob/living/user)
	. = ..()
	buttify(user)

/obj/item/hand_item/butt/proc/buttify(mob/user)
	if(!iscarbon(user))
		to_chat(user, span_alert("You aint got a butt!"))
		return
	var/mob/living/carbon/human/H = user
	if(!H.has_butt())
		to_chat(user, span_alert("[H], you have no butt!"))
		H.emote("scream")
		qdel(src)
		return
	var/obj/item/organ/genital/butt/B = H.getorganslot(ORGAN_SLOT_BUTT)
	var/datum/sprite_accessory/sprite_acc = B.get_sprite_accessory()
	icon = 'icons/obj/genitals/butt_onmob.dmi'
	icon_state = B.get_icon_state(user, sprite_acc, FALSE, "FRONT")
	dir = NORTH
	var/datum/preferences/P = extract_prefs(user)
	color = "#[P.features["butt_color"]]"
	force = 6 * B.size
	attack_speed = (CLICK_CD_MELEE / 3) * B.size
	switch(B.size)
		if(1 to 2)
			w_class = WEIGHT_CLASS_TINY
		if(3)
			w_class = WEIGHT_CLASS_SMALL
		if(4)
			w_class = WEIGHT_CLASS_NORMAL
		if(5)
			w_class = WEIGHT_CLASS_BULKY
		if(6 to 7)
			w_class = WEIGHT_CLASS_HUGE
		if(8 to INFINITY)
			w_class = WEIGHT_CLASS_GIGANTIC
