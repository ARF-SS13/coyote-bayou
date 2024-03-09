#define BASE_SLEEP_HPS 0.5
#define BED_HEAL_BONUS 1.5 // big bonus from bed
#define SLEEP_DURATION 40 SECONDS // how long one click of sleep naps you

#define SLEEP_UNTIL_FINISHED 0
#define SLEEP_UNTIL_OUT_OF_CRIT 1
#define SLEEP_FULLY_HEALED 2

// Its a component for healing while u sleep!
// and also a handler for other sleep-related stuff

// To trigger the sleeping tickies when the player is sleeping
// /datum/status_effect/incapacitating/sleeping/tick()
// 	SEND_SIGNAL(owner, COMSIG_MOB_SLEEPING)
// 	..()

// Adding the component onto humans so that they get the good shit. *nut
/mob/living/carbon/human/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/sleeping_regeneration)


/// OKAY NOW THE COMPONENT!

// Definition!
/datum/component/sleeping_regeneration
	COOLDOWN_DECLARE(manual_stir_cooldown)
	var/maxHealAmount = BASE_SLEEP_HPS // idfk
	var/sleeping_until = SLEEP_UNTIL_FINISHED
	var/base_sleep = SLEEP_DURATION

// We want to check to make sure the component is a /mob/living, if it isnt, this component is incompatible.
/datum/component/sleeping_regeneration/Initialize(...)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	. = ..()

// This sets it so when COMSIG_MOB_SLEEPING is called, call the OnSleep() function.
/datum/component/sleeping_regeneration/RegisterWithParent()
	. = ..()
	var/mob/living/M = parent
	RegisterSignal(M, COMSIG_LIVING_RESIST, .proc/StirClicked)
	RegisterSignal(M, COMSIG_MOB_WENT_TO_SLEEP, .proc/NowAsleep)
	RegisterSignal(M, COMSIG_MOB_WOKE_UP, .proc/NowWokeUp)
	RegisterSignal(M, COMSIG_MOB_SLEEP, .proc/GoToSleep)

// We need to unregister it from calling when the component is removed, this is just because it can be a permanent/stacking effect. We dont want that.
/datum/component/sleeping_regeneration/UnregisterFromParent()
	. = ..()
	var/mob/living/M = parent
	UnregisterSignal(M, COMSIG_MOB_SLEEPING)
	UnregisterSignal(M, COMSIG_MOB_SLEEP)
	UnregisterSignal(M, COMSIG_LIVING_RESIST)

/// someone clicked the sleep / healme button! show them a cool TGUI window
/datum/component/sleeping_regeneration/proc/GoToSleep()
	ui_interact(parent)

/datum/component/sleeping_regeneration/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SleepMenu")
		ui.open()

/datum/component/sleeping_regeneration/ui_state(mob/user)
	return GLOB.always_state

/datum/component/sleeping_regeneration/ui_data(mob/user)
	var/list/data = list()
	data["ImDead"] = user && user.stat != DEAD
	data["InBed"] = GetBed()
	data["SleepMode"] = sleeping_until
	data["SleepDuration"] = user && user.AmountSleeping()
	data["TypicalNap"] = base_sleep
	

// The actual code!
/datum/component/sleeping_regeneration/proc/NowAsleep()
	START_PROCESSING(SSprocessing, src)

// The actual code!
/datum/component/sleeping_regeneration/proc/NowWokeUp()
	STOP_PROCESSING(SSprocessing, src)

// The actual code!
/datum/component/sleeping_regeneration/proc/GetBed()
	var/mob/living/L = parent
	var/obj/buckled_obj = (L.buckled || (locate(/obj/structure/bed) in hereiam))
	return buckled_obj && istype(buckled_obj, /obj/structure/bed)

/datum/component/sleeping_regeneration/proc/UpdateSleeping()
	var/mob/living/L = parent
	return L.IsSleeping()

// The actual code!
/datum/component/sleeping_regeneration/process()
	// Just making sure the person is actually /mob/living, ya never know!
	if(!isliving(parent))
		return
	// We use L, not parent, this is cause L has all the procs we need to adjust damage values and stuff <3 But we set the parent as L.
	var/mob/living/L = parent

	if(!UpdateSleeping())
		return NowWokeUp()

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
	COOLDOWN_START(src, next_sleepheal, 1 SECONDS)
	var/in_crit = L.health < 0

	// get a heal amount from 0 to the maxHealAmount.
	var/healAmount = maxHealAmount

	var/turf/hereiam = get_turf(L)
	if(GetBed())
		healAmount += BED_HEAL_BONUS

	var/healbots = isrobotic(L)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		for(var/X in C.bodyparts)
			var/obj/item/bodypart/BAP = X
			BAP.suture_heal(TRUE)
			BAP.bandage_heal(TRUE) // an extra free hungerless tick if sleeping with healgyatts

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
	CheckAlarmClock()
	// And that's it! We dont really need to add anything else, it will continue to call this function every tick.

/// checks if we should try to wake up
/datum/component/sleeping_regeneration/proc/CheckAlarmClock()
	if(sleeping_until == SLEEP_UNTIL_FINISHED)
		return // it'll run out on its own
	if(!isliving(parent))
		return
	var/mob/living/L = parent
	if(sleeping_until == SLEEP_UNTIL_OUT_OF_CRIT)
		if(L.health > 0) // aka out of crit
			Stir()
			return
		else
			RefreshSleep()
	if(sleeping_until == SLEEP_FULLY_HEALED)
		if(L.health > (L.maxHealth * 95)) // juuuust in case
			Stir()
			return
		else
			RefreshSleep()

/datum/component/sleeping_regeneration/proc/StirClicked()
	return Stir(TRUE)

/datum/component/sleeping_regeneration/proc/Stir(resisted)
	if(resisted)
		if(!COOLDOWN_FINISHED(src, manual_stir_cooldown))
			return
		COOLDOWN_START(src, manual_stir_cooldown, 2 SECONDS)
	if(!L.IsSleeping())
		return
	var/mob/living/L = parent
	L.visible_message(span_notice("[L] stirs."))
	L.setDir(pick(GLOB.cardinals)) // sturr
	if(!L.AdjustSleeping(-(1 SECONDS))) // false means its gone
		sleeping_until = SLEEP_UNTIL_FINISHED


SLEEP_UNTIL_OUT_OF_CRIT
SLEEP_FULLY_HEALED
#undef BED_HEAL_BONUS
