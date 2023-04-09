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
		return TRUE // either no client, or something went fucky
	var/datum/prefcheck/ultimate_breaker = prefs[index]
	if(!ultimate_breaker)
		return TRUE
	return ultimate_breaker.allowed(break_me_complitely)

/* 
 * Preference lookup table
 * feed it someone's prefs, it spits out a yes or a no
 */
/// Most often, its just checking a flag on a mob's client's prefs
/datum/prefcheck
	var/index = "oopsie"
	var/pref

/datum/prefcheck/proc/allowed(datum/preferences/consumer)
	return TRUE

/datum/prefcheck/voreprefs
	index = "vore"
	pref = VOREALLOW_EATING_NOISES

/datum/prefcheck/voreprefs/eat_noises
	index = VOREPREF_EAT_SOUNDS
	pref = VOREALLOW_EATING_NOISES

/datum/prefcheck/voreprefs/digest_noises
	index = VOREPREF_DIGESTION_SOUNDS
	pref = VOREALLOW_DIGESTION_NOISES

/datum/prefcheck/voreprefs/digest_damage
	index = VOREPREF_DIGESTION_DAMAGE
	pref = VOREALLOW_DIGESTION_DAMAGE

/datum/prefcheck/voreprefs/absorbable
	index = VOREPREF_ABSORBTION
	pref = VOREALLOW_ABSORBTION

/datum/prefcheck/voreprefs/healbellyable
	index = VOREPREF_HEALBELLY
	pref = VOREALLOW_HEALBELLY_HEALING

/datum/prefcheck/voreprefs/death
	index = VOREPREF_DEATH
	pref = VOREALLOW_DIGESTION_DEATH

/datum/prefcheck/voreprefs/examine
	index = VOREPREF_EXAMINE
	pref = VOREALLOW_SEEING_BELLY_DESC

/datum/prefcheck/voreprefs/text
	index = VOREPREF_TEXT
	pref = VOREALLOW_VORE_MESSAGES

/datum/prefcheck/voreprefs/text_xtreme
	index = VOREPREF_TEXT_DEATH
	pref = VOREALLOW_DEATH_MESSAGES

/datum/prefcheck/voreprefs/being_prey
	index = VOREPREF_BEING_PREY
	pref = VOREALLOW_BEING_PREY

/datum/prefcheck/voreprefs/being_fed_prey
	index = VOREPREF_BEING_FED
	pref = VOREALLOW_BEING_FED_OTHERS

/datum/prefcheck/voreprefs/sniff
	index = VOREPREF_SNIFFABLE
	pref = VOREALLOW_BEING_SNIFFED

/datum/prefcheck/voreprefs/allowed(datum/preferences/consumer)
	if(CHECK_BITFIELD(consumer.vore_prefs, pref))
		return TRUE

