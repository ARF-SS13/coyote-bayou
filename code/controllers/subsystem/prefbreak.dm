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
	if(isclient(pingvin))
		var/client/zloy = pingvin
		return zloy.prefs
	if(ismob(pingvin))
		var/mob/zloy = pingvin
		return zloy?.client.prefs

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
	pref = VORE_EATING_NOISES

/datum/prefcheck/voreprefs/eat_noises
	index = VOREPREF_EAT_SOUNDS
	pref = VORE_EATING_NOISES

/datum/prefcheck/voreprefs/digest_noises
	index = VOREPREF_DIGESTION_SOUNDS
	pref = VORE_DIGESTION_NOISES

/datum/prefcheck/voreprefs/digest_damage
	index = VOREPREF_VORE_DIGESTION_DAMAGE
	pref = VORE_DIGESTION_DAMAGE

/datum/prefcheck/voreprefs/absorbable
	index = VOREPREF_ABSORBTION
	pref = VORE_ABSORBABLE

/datum/prefcheck/voreprefs/healbellyable
	index = VOREPREF_HEALBELLY
	pref = VORE_HEALBELLY

/datum/prefcheck/voreprefs/death
	index = VOREPREF_DEATH
	pref = VORE_DEATH

/datum/prefcheck/voreprefs/examine
	index = VOREPREF_EXAMINE
	pref = VORE_EXAMINE

/datum/prefcheck/voreprefs/text
	index = VOREPREF_TEXT
	pref = VORE_TEXT

/datum/prefcheck/voreprefs/text_xtreme
	index = VOREPREF_TEXT_DEATH
	pref = VORE_TEXT_DEATH

/datum/prefcheck/voreprefs/being_prey
	index = VOREPREF_BEING_PREY
	pref = VORE_BEING_PREY

/datum/prefcheck/voreprefs/being_fed_prey
	index = VOREPREF_BEING_FED
	pref = VORE_BEING_FED

/datum/prefcheck/voreprefs/sniff
	index = VOREPREF_SNIFFABLE
	pref = VORE_SNIFFABLE

/datum/prefcheck/voreprefs/allowed(datum/preferences/consumer)
	if(CHECK_BITFIELD(consumer.vore_prefs, pref))
		return TRUE

