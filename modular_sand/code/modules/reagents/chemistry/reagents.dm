/datum/reagent
	var/hydration = 0 //does this hydrate your thirst?

/datum/reagent/consumable/on_mob_life(mob/living/carbon/M)
	M.adjust_thirst(hydration)
	. = ..()

/// Don't blame me if they have negative thirst, admeme.
/proc/get_thirst(mob/living/user)
	if(!istype(user))
		return
	. = user.thirst
	for(var/datum/reagent/water in LAZYCOPY(user?.reagents.reagent_list))
		. += water.hydration

	. = min(., THIRST_LEVEL_THRESHOLD)
