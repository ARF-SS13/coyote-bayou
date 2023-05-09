
SUBSYSTEM_DEF(magic)
	name = "Magic"
	flags = SS_BACKGROUND|SS_NO_INIT
	wait = 0.2 SECONDS

	/// magic spells
	/// list("index" = /datum/magic_spell)
	var/list/magic_spells = list()

/datum/controller/subsystem/magic/Initialize(start_timeofday)
	. = ..()
	// load all spells
	init_spells()

/datum/controller/subsystem/magic/proc/init_spells()
	// load all spells
	for(var/spel in subtypesof(/datum/magic_spell))
		var/datum/magic_spell/S = new spel()
		magic_spells[S.index] = S

/datum/controller/subsystem/magic/proc/get_spell(index)
	return LAZYACCESS(magic_spells, index)

/datum/controller/subsystem/magic/proc/can_cast(index, mob/living/caster, atom/target)
	var/datum/magic_spell/S = get_spell(index)
	if(!S)
		return FALSE
	return S.can_cast(caster, target)







