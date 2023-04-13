//Fires every half-second, also holds an initted list of cool effects-on-demand

PROCESSING_SUBSYSTEM_DEF(effects)
	name = "Effects Processing"
	wait = 0.5 SECONDS
	stat_tag = "FX"
	flags = SS_BACKGROUND|SS_KEEP_TIMING
	var/list/effect_list = list()

/datum/controller/subsystem/processing/effects/Initialize()
	setup_effect_list()
	return ..()

/datum/controller/subsystem/processing/effects/proc/setup_effect_list()
	for(var/type in subtypesof(/datum/effect_fancy))
		var/datum/effect_fancy/S = new type()
		effect_list[S.index] = S

/datum/controller/subsystem/processing/effects/proc/do_effect(index, atom/source, atom/target, params)
	if(!index)
		return
	var/datum/effect_fancy/EF = effect_list[index]
	if(!EF)
		return
	EF.do_effect(source, target, params)

