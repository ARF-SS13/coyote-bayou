/// Its like a spell, but less FUCKED
/datum/action/spell
	name = "Generic Action"
	desc = null
	required_mobility_flags = MOBILITY_USE
	button_icon = 'icons/mob/actions/backgrounds.dmi' //This is the file for the BACKGROUND icon
	background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND //And this is the state for the background icon

	icon_icon = 'icons/mob/actions.dmi' //This is the file for the ACTION icon
	button_icon_state = "default" //And this is the state for the action icon
	check_flags = AB_CHECK_RESTRAINED|AB_CHECK_STUN|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	button_icon_state = null
	use_target_appearance = TRUE
	var/spell_index

/// Okay its just a thing that summons a thing that shoots the spell
/datum/action/spell/Trigger()
	. = ..()
	if(!.)
		return
	var/datum/magic_spell/myspell = SSmagic.get_spell(get_spell)
	if(!myspell)
		to_chat(owner, span_phobia("The spell tried to reference an invalid spell index! Panic, and call 1-800-IMC-ODER!"))
		return
	var/mob/living/living_owner = owner
	if(isanimal(owner))
		var/mob/living/simple_animal/simple_owner = owner
		if(!simple_owner.dextrous)
			to_chat(simple_owner, span_alert("You're not dextrous enough to use this!"))
			return
	if(living_owner.get_active_held_item())
		to_chat(user, span_warning("Your hands are too full to properly bite!  Don't ask!"))
		return
	var/obj/item/hand_item/caster/magic = new(living_owner)
	if(living_owner.put_in_active_hand(magic))
		magic.attune(spell_index)
		to_chat(living_owner, span_notice("You ready [myspell.name]!"))
	else
		qdel(magic)

/// A spell! in holdable form
/obj/item/hand_item/caster
	name = "magic spell"
	desc = "YORAF UHRY"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	/// The spell we're gonna be using
	var/spelldex
	/// our owner, sorta
	var/datum/weakref/owner

/obj/item/hand_item/caster/ComponentInitialize()
	. = ..()
	if(!isliving(loc)) // fuck
		qdel(src)
		return
	RegisterSignal(loc, COMSIG_MOB_CLICKON,PROC_REF(intercept_click))
	owner = WEAKREF(loc)

/obj/item/hand_item/caster/Destroy()
	var/mob/living/pwner = (isliving(loc) ? loc : RESOLVEWEAKREF(owner))
	if(pwner)
		UnregisterSignal(pwner, COMSIG_MOB_CLICKON)
	owner = null
	. = ..()

/obj/item/hand_item/caster/proc/attune(index)
	spelldex = index // easy huh?

/obj/item/hand_item/caster/proc/intercept_click(datum/source, atom/clicked, params)
	SIGNAL_HANDLER

/datum/magic_spell
	var/name = "Magic!"
	var/cast_time = 2 SECONDS
	var/sound_start
	var/sound_cast
	var/list/required_intents = list()
	var/max_distance = 7
	var/min_distance = 0
	var/obey_antimagic = TRUE
	var/spell_flags = NONE
	var/delete_
	var/list/valid_types
	var/list/cooldowns = list()
























