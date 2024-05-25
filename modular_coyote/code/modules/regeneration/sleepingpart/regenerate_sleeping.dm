#define BED_HEAL_BONUS 0.02

// To trigger the sleeping tickies when the player is sleeping
/datum/status_effect/incapacitating/sleeping/tick()
	SEND_SIGNAL(owner, COMSIG_MOB_SLEEPING)
	..()

// Adding the component onto humans so that they get the good shit. *nut
/mob/living/carbon/human/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/sleeping_regeneration)


/// OKAY NOW THE COMPONENT!

// Definition!
/datum/component/sleeping_regeneration
	var/maxHealAmount = 0.02 // idfk

// We want to check to make sure the component is a /mob/living, if it isnt, this component is incompatible.
/datum/component/sleeping_regeneration/Initialize(...)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	. = ..()

// This sets it so when COMSIG_MOB_SLEEPING is called, call the OnSleep() function.
/datum/component/sleeping_regeneration/RegisterWithParent()
	. = ..()
	var/mob/living/M = parent
	RegisterSignal(M, COMSIG_MOB_SLEEPING,PROC_REF(OnSleep))

// We need to unregister it from calling when the component is removed, this is just because it can be a permanent/stacking effect. We dont want that.
/datum/component/sleeping_regeneration/UnregisterFromParent()
	. = ..()
	var/mob/living/M = parent
	UnregisterSignal(M, COMSIG_MOB_SLEEPING)

// The actual code!
/datum/component/sleeping_regeneration/proc/OnSleep()
	// Just making sure the person is actually /mob/living, ya never know!
	if(!isliving(parent))
		return

	// We use L, not parent, this is cause L has all the procs we need to adjust damage values and stuff <3 But we set the parent as L.
	var/mob/living/L = parent

	// A list ready to store the damage values
	var/list/damagedParts = list()

	// this checks if there's any damage on each type and if there is, add it to the list. |= adds it to the list but stops you adding it twice.
	if(L.getBruteLoss() > 0)
		damagedParts += BRUTE
	if(L.getOxyLoss() > 0)
		damagedParts += OXY
	if(L.getToxLoss() > 0)
		damagedParts += TOX
	if(L.getFireLoss() > 0)
		damagedParts += BURN

	if(!damagedParts.len) // We're done here!
		return

	// get a heal amount from 0 to the maxHealAmount.
	var/healAmount = rand(0,maxHealAmount)

	var/turf/hereiam = get_turf(L)
	var/obj/buckled_obj = (L.buckled || (locate(/obj/structure/bed) in hereiam))
	if(buckled_obj && istype(buckled_obj, /obj/structure/bed))
		if(!is_type_in_list(get_area(L), GLOB.outdoor_areas))
			healAmount += BED_HEAL_BONUS

	var/healbots = isrobotic(L)

	// Now pick a random element from the list, if it is BRUTE, OXY, TOX or BURN, apply the heal amount to one of them.
	switch(pick(damagedParts))
		if(BRUTE)
			L.adjustBruteLoss(-healAmount, include_roboparts = healbots)
		if(OXY)
			L.adjustOxyLoss(-healAmount)
		if(TOX)
			L.adjustToxLoss(-healAmount)
		if(BURN)
			L.adjustFireLoss(-healAmount, include_roboparts = healbots)
	
	// And that's it! We dont really need to add anything else, it will continue to call this function every tick.

#undef BED_HEAL_BONUS
