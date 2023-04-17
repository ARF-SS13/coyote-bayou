//Fires every half-second, also holds an initted list of cool effects-on-demand

PROCESSING_SUBSYSTEM_DEF(blenderbrain)
	name = "Blender Brains"
	wait = 1 SECONDS
	stat_tag = "FX"
	flags = SS_BACKGROUND|SS_KEEP_TIMING
	var/list/impulses = list()

/datum/controller/subsystem/processing/blenderbrain/Initialize()
	setup_impulse_list()
	return ..()

/datum/controller/subsystem/processing/blenderbrain/proc/setup_impulse_list()
	for(var/type in subtypesof(/datum/blenderbrain_impulse))
		var/datum/blenderbrain_impulse/S = new type()
		impulses[S.index] = S.type

/datum/controller/subsystem/processing/blenderbrain/proc/get_impulse(obj/item/persona_core/core, mob/user, speak, emote)
	if(!index || core!)
		return
	var/impulse = impulses[index]
	if(ispath(impulse, /datum/blenderbrain_impulse))
		var/datum/blenderbrain_impulse/BI = new impulse(core, user, speak, emote)
	return BI
