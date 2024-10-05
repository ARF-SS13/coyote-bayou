#define PREFBROKEN if(!..()) return FALSE
/// A whole subsystem dedicated to breaking your prefs~
SUBSYSTEM_DEF(prefbreak) // ALL ABOARD THE S.S. PREFBREAK OFF TO **** YOUR ***************!
	name = "PrefBreaker"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_PREFBREAK
	/// An asslist of prefcheck
	var/list/prefs

/datum/controller/subsystem/prefbreak/Initialize()
	setup_prefcheck()
	return ..()

/datum/controller/subsystem/prefbreak/proc/setup_prefcheck()
	prefs = list()
	for(var/sounpref in subtypesof(/datum/prefcheck))
		var/datum/prefcheck/spref = new sounpref()
		prefs[spref.index] = spref

/datum/controller/subsystem/prefbreak/proc/get_prefs(pingvin)
	if(istype(pingvin, /datum/preferences))
		return pingvin
	if(isclient(pingvin))
		var/client/zloy = pingvin
		return zloy.prefs
	if(ismob(pingvin))
		var/mob/zloy = pingvin
		return zloy.client?.prefs

/// takes in anything, sees if it has a client/prefs/whatever, and checks those prefs
/// Allows things by default, denies it if specifically disallowed
/datum/controller/subsystem/prefbreak/proc/allowed_by_prefs(broken, index)
	if(!broken)
		return TRUE // allow by default
	if(!index)
		return TRUE
	var/datum/preferences/break_me_complitely = get_prefs(broken)
	if(!break_me_complitely)
		return TRUE // either no client, or something went forky
	var/datum/prefcheck/ultimate_breaker = prefs[index]
	if(!ultimate_breaker)
		return TRUE
	return ultimate_breaker.allowed(break_me_complitely)

/* *
 * TGUI-formatted preference system thingy
 * Takes in a prefs and a which to get, and returns a TGUI-compatible thingy
 */ // todo: this

// /datum/controller/subsystem/prefbreak/proc/get_tgui_pref_data(prefs, which)
// 	if(!prefs)
// 		return list()
// 	if(!which)
// 		return list()
// 	var/datum/preferences/P = extract_prefs(prefs)
// 	if(!P)
// 		return list()
// 	if(CHECK_BITFIELD(which, PREF_ERP_TOGGLES))
// 		return get_tgui_erp_toggles(P)


// /datum/controller/subsystem/prefbreak/proc/get_tgui_erp_toggles(datum/preferences/P)
// 	if(!P)
// 		return list()
// 	var/list/erp_toggles = list()
// 	operate_toggle(erp_toggles, "Hear Lewd Sounds", P.toggles, HEAR_LEWD_VERB_SOUNDS)
// 	operate_toggle(erp_toggles, "Verb Consent", P.toggles, VERB_CONSENT)
// 	operate_toggle(erp_toggles, "Auto Wag", P.cit_toggles, NO_AUTO_WAG)
	

/* 
 * Preference lookup table
 * feed it someone's prefs, it spits out a yes or a no
 */
/// Most often, its just checking a flag on a mob's client's prefs
/datum/prefcheck
	var/index = "oopsie"

/datum/prefcheck/proc/allowed(datum/preferences/consumer)
	return !!consumer

/// Master vore prefs
/datum/prefcheck/voreprefs
	index = VOREPREF_MASTER

/datum/prefcheck/voreprefs/allowed(datum/preferences/consumer)
	return consumer.master_vore_toggle // kinda vital here

/// Able to hear eat sounds
/datum/prefcheck/voreprefs/eat_noises
	index = VOREPREF_EAT_SOUNDS

/datum/prefcheck/voreprefs/eat_noises/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_eating_sounds

/// Able to hear digestion
/datum/prefcheck/voreprefs/digest_noises
	index = VOREPREF_DIGESTION_SOUNDS

/datum/prefcheck/voreprefs/digest_noises/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_digestion_sounds

/// Able to be digested harmfully
/datum/prefcheck/voreprefs/digest_damage
	index = VOREPREF_DIGESTION_DAMAGE

/datum/prefcheck/voreprefs/digest_damage/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_digestion_damage

/// Able to be digested to death
/datum/prefcheck/voreprefs/digest_death
	index = VOREPREF_DIGESTION_DEATH

/datum/prefcheck/voreprefs/digest_death/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_digestion_death

/// Able to be absorbed
/datum/prefcheck/voreprefs/absorbable
	index = VOREPREF_ABSORBTION

/datum/prefcheck/voreprefs/absorbable/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_absorbtion

/// Able to be healbellied
/datum/prefcheck/voreprefs/healbellyable
	index = VOREPREF_HEALBELLY

/datum/prefcheck/voreprefs/healbellyable/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_healbelly_healing

/// Able to see belly descs
/datum/prefcheck/voreprefs/examine
	index = VOREPREF_EXAMINE

/datum/prefcheck/voreprefs/examine/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_seeing_belly_descriptions

/// Able to see vorey messages
/datum/prefcheck/voreprefs/text
	index = VOREPREF_VORE_MESSAGES

/datum/prefcheck/voreprefs/text/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_vore_messages

/// Able to see vorey death messages
/datum/prefcheck/voreprefs/text_xtreme
	index = VOREPREF_DEATH_MESSAGES

/datum/prefcheck/voreprefs/text_xtreme/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_death_messages

/// Able to be vored
/datum/prefcheck/voreprefs/being_prey
	index = VOREPREF_BEING_PREY

/datum/prefcheck/voreprefs/being_prey/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_being_prey

/// Able to be fed prey by others
/datum/prefcheck/voreprefs/being_fed_prey
	index = VOREPREF_BEING_FED_PREY

/datum/prefcheck/voreprefs/being_fed_prey/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_being_fed_prey

/// Able to be fed to others
/datum/prefcheck/voreprefs/being_fed_to_others
	index = VOREPREF_BEING_FED_TO_OTHERS

/datum/prefcheck/voreprefs/being_fed_to_others/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_being_fed_to_others

/// Able to be sniffad
/datum/prefcheck/voreprefs/sniff
	index = VOREPREF_SNIFFABLE

/datum/prefcheck/voreprefs/sniff/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_being_sniffed

/// Able to see people yartz up trash
/datum/prefcheck/voreprefs/hork_trash_see
	index = VOREPREF_TRASH_MESSAGES

/datum/prefcheck/voreprefs/hork_trash_see/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.allow_trash_messages

/// wanna cum?
/datum/prefcheck/splurt
	index = "splurtstuff"

/datum/prefcheck/splurt/allowed(datum/preferences/consumer)
	return TRUE //consumer.splurt_master_toggle // kinda vital here // todo, add this

/// autoclimax
/datum/prefcheck/splurt/autoclimax
	index = NOTMERP_AUTOCLIMAX

/datum/prefcheck/splurt/autoclimax/allowed(datum/preferences/consumer)
	PREFBROKEN

/// hear lewd-related stuff
/datum/prefcheck/splurt/lewd_sounds
	index = NOTMERP_LEWD_SOUNDS

/datum/prefcheck/splurt/lewd_sounds/allowed(datum/preferences/consumer)
	PREFBROKEN
	return CHECK_BITFIELD(consumer.toggles, HEAR_LEWD_VERB_SOUNDS) // kinda vital here

/// hear lewd-related stuff
/datum/prefcheck/splurt/lewd_words
	index = NOTMERP_LEWD_WORDS

/datum/prefcheck/splurt/lewd_words/allowed(datum/preferences/consumer)
	PREFBROKEN
	return CHECK_BITFIELD(consumer.toggles, HEAR_LEWD_VERB_WORDS) // kinda vital here


/// hear lewd-related stuff
/datum/prefcheck/radio_blurbles
	index = RADIOPREF_HEAR_RADIO_BLURBLES

/datum/prefcheck/radio_blurbles/allowed(datum/preferences/consumer)
	PREFBROKEN
	return CHECK_BITFIELD(consumer.chat_toggles, CHAT_HEAR_RADIOBLURBLES) // kinda vital here

/datum/prefcheck/radio_blurbles
	index = RADIOPREF_HEAR_RADIO_STATIC

/datum/prefcheck/radio_blurbles/allowed(datum/preferences/consumer)
	PREFBROKEN
	return CHECK_BITFIELD(consumer.chat_toggles, CHAT_HEAR_RADIOSTATIC) // kinda vital here

/// im an admin and i dont want to hear about how you want to destroy someone's bussy
/datum/prefcheck/admin_wire_tap
	index = ADMIN_CHAT_FILTER_DMS

/datum/prefcheck/admin_wire_tap/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.admin_wire_tap // kinda vital here

/datum/prefcheck/see_fancy_offscreen_runechat
	index = SEE_FANCY_OFF_SCREEN_RUNECHAT

/datum/prefcheck/see_fancy_offscreen_runechat/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.see_fancy_offscreen_runechat // kinda vital here


/datum/prefcheck/see_horny_furry_stuff
	index = SHOW_ME_HORNY_FURRIES

/datum/prefcheck/see_horny_furry_stuff/allowed(datum/preferences/consumer)
	PREFBROKEN
	return CHECK_BITFIELD(consumer.chat_toggles, CHAT_SEE_COOLCHAT) // kinda vital here
	// return consumer.see_fancy_offscreen_runechat // kinda vital here

/datum/prefcheck/visualchat_use_contrasting_color
	index = USE_AUTO_CONTRAST

/datum/prefcheck/visualchat_use_contrasting_color/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.visualchat_use_contrasting_color // kinda vital here
	// return consumer.see_fancy_offscreen_runechat // kinda vital here

/datum/prefcheck/visualchat_see_horny_radio_stuff
	index = SHOW_ME_HORNY_RADIO

/datum/prefcheck/visualchat_see_horny_radio_stuff/allowed(datum/preferences/consumer)
	PREFBROKEN
	return consumer.visualchat_see_horny_radio // kinda vital here
	// return consumer.see_fancy_offscreen_runechat // kinda vital here






