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
		qdel(S)

/datum/controller/subsystem/processing/blenderbrain/proc/get_impulse(obj/item/persona_core/core, mob/user, index, message, list/extras)
	if(!index || !core || !impulses[index]) //No impulse, no impulse
		return
	var/impulse = impulses[index]
	if(ispath(impulse, /datum/blenderbrain_impulse))
		var/is_speak = (index == IMPULSE_SPEAK_LINE) ? message : null
		var/is_emote = (index == IMPULSE_AUDIBLE_EMOTE) ? message : null
		var/datum/blenderbrain_impulse/BI = new impulse(core, user, is_speak, is_emote, extras)
		return BI
