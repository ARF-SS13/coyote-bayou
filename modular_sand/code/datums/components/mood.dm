/datum/component/mood
	var/atom/movable/screen/sanity/screen_obj_sanity

/datum/component/mood/proc/HandleThirst(mob/living/L)
	if(HAS_TRAIT(L, TRAIT_NOTHIRST))
		return FALSE //no mood events for thirst
	if(L.thirst >= THIRST_LEVEL_THRESHOLD)
		L.set_thirst(clamp(L.thirst, 0, THIRST_LEVEL_THRESHOLD))
	switch(get_thirst(L))
		if(THIRST_LEVEL_QUENCHED to INFINITY)
			add_event(null, "thirst", /datum/mood_event/quenched)
		if(THIRST_LEVEL_THIRSTY to THIRST_LEVEL_QUENCHED)
			clear_event(null, "thirst")
		if(THIRST_LEVEL_PARCHED to THIRST_LEVEL_THIRSTY)
			add_event(null, "thirst", /datum/mood_event/thirsty)
		if(0 to THIRST_LEVEL_PARCHED)
			add_event(null, "thirst", /datum/mood_event/dehydrated)
