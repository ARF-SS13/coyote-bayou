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

/datum/controller/subsystem/processing/effects/proc/do_effect(index, atom/source, atom/target, angle, length)
	if(!index)
		return
	var/datum/effect_fancy/EF = effect_list[index]
	if(!EF)
		return
	EF.do_effect(source, target, angle, length)

/datum/controller/subsystem/processing/effects/proc/floaterize(atom/source, angle = EAST, distance = 2, duration = 0.5 SECONDS)
	if(!source)
		return
	var/matrix/M2 = matrix(source.transform)
	M2.Turn(dir2angle(angle))
	M2.Translate(distance*32, rand(-distance, distance)*8)
	animate(source, time = duration, transform = M2, alpha = 0, easing = LINEAR_EASING)
	if(angle == EAST || angle == WEST)
		animate(source, loop = -1, time = 0.5 SECONDS, pixel_y = -16, flags = ANIMATION_PARALLEL)
		animate(loop = -1, time = 0.5 SECONDS, pixel_y = 16)
	else
		animate(source, loop = -1, time = 0.5 SECONDS, pixel_x = -16, flags = ANIMATION_PARALLEL)
		animate(loop = -1, time = 0.5 SECONDS, pixel_x = 16)

