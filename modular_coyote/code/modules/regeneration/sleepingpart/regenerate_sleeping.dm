#define SLEEP_BASE_DURATION 20 SECONDS
#define HEAVY_SLEEPER_EXTRA_SLEEP_MOD 1.5 // 100% longer sleepage
#define REST_HEAL_MULT 0.5
#define SLEEP_HPS_BASE 0.25
#define SLEEP_HPS_BONUS_FED_NUT 0.25
#define SLEEP_HPS_BONUS_FAT_NUT 0.75
#define SLEEP_HPS_BONUS_BED_PER_RANK 0.25 // bonuses from beds, better ones are better
#define SLEEP_HPS_BONUS_BLANKET_IN_INVENTORY 0.25 // bwankie
#define SLEEP_HPS_BONUS_BLANKET_ON_GROUND 0.5 // big bonus from a full bed set
#define SLEEP_HPS_BONUS_BLANKET_ON_BED 0.75 // big bonus from a full bed set
#define SLEEP_HPS_BONUS_DARK 0.1 // slight bonus if its dark

#define SLEEP_NUT_PER_HEAL 2 // 2 nut per healthpoint

#define SLEEP_DURATION 40 SECONDS // how long one click of sleep naps you

#define SLEEP_FOREVER 0 // THE BIG SLEEP
#define SLEEP_UNTIL_AWAKE 1
#define SLEEP_UNTIL_ALARM 2
#define SLEEP_UNTIL_OUT_OF_CRIT 3
#define SLEEP_UNTIL_FULLY_HEALED 4

#define SLEEP_FOOD_MASK_FAT (1<<10) // surely we wont be healing more than (checks calculator) 1024 HP/second
#define SLEEP_FOOD_MASK_FED (1<<22) // and SURELY not 4194304 HP/second

#define SLEEP_MASTER var/mob/living/master = parent; if(!isliving(master)){return};

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
	var/heal_per_second = SLEEP_HPS_BASE
	var/alarm_clock = 1 MINUTES
	var/sleeping_until = 0
	var/sleep_mode = SLEEP_FOREVER
	var/rest_mode = FALSE // rest is sleep, but awake, and worse
	var/datum/weakref/blankie
	var/manual_stir_cooldown = 0

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
	return TRUE

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
	data["InCrit"] = user && user.stat != CONSCIOUS
	data["Health"] = user && user.health
	data["MaxHealth"] = user && user.maxHealth
	data["InBed"] = GetBed()
	data["HasBlanket"] = GetBlanket()
	data["SleepMode"] = sleep_mode
	data["SleepDuration"] = sleep_duration_remaining
	data["AlarmClock"] = alarm_clock

// The actual code!
/datum/component/sleeping_regeneration/proc/BeginSleeping()
	START_PROCESSING(SSprocessing, src)

// The actual code!
/datum/component/sleeping_regeneration/proc/EndSleeping()
	STOP_PROCESSING(SSprocessing, src)

// The actual code!
/datum/component/sleeping_regeneration/proc/GetBed()
	SLEEP_MASTER
	var/obj/buckled_obj = (master.buckled || (locate(/obj/structure/bed) in hereiam))
	return buckled_obj && istype(buckled_obj, /obj/structure/bed)

/datum/component/sleeping_regeneration/proc/GetBlanket()
	SLEEP_MASTER
	var/obj/item/blanket/sheet = GET_WEAKREF(blankie)
	if(sheet)
		if(get_turf(master) != get_turf(sheet))
			sheet = null
			blankie = null
	if(!sheet)
		sheet = FindSheet()
	if(sheet)
		var/turf/

	var/obj/buckled_obj = (master.buckled || (locate(/obj/structure/bed) in hereiam))
	return buckled_obj && istype(buckled_obj, /obj/structure/bed)

/datum/component/sleeping_regeneration/proc/StillAsleep()
	SLEEP_MASTER
	return master.IsSleeping()

// The actual code!
/datum/component/sleeping_regeneration/process()
	// We use master, not parent, this is cause master has all the procs we need to adjust damage values and stuff <3 But we set the parent as master.
	SLEEP_MASTER
	if(!StillAsleep())
		return NowWokeUp()
	CheckAlarmClock()
	SleepHeal()

/// heals the player if asleep
/datum/component/sleeping_regeneration/proc/SleepHeal()
	if(!StillAsleep())
		return // kinda like santa, only works while you're asleep (or lounging)
	// A list ready to store the damage values
	var/list/damagedParts = list()

	// this checks if there's any damage on each type and if there is, add it to the list. |= adds it to the list but stops you adding it twice.
	if(master.getBruteLoss() > 0)
		damagedParts += BRUTE
	if(master.getOxyLoss() > 0)
		damagedParts += OXY
	if(master.getToxLoss() > 0)
		damagedParts += TOX
	if(master.getFireLoss() > 0)
		damagedParts += BURN

	if(!damagedParts.len) // We're done here!
		return

	var/healAmount = GetHealAmount()
	var/nut_heals = 0
	if(healAmount - SLEEP_FOOD_MASK_FED > 0) // check the big one first
		nut_heals = SLEEP_HPS_BONUS_FED_NUT
		healAmount -= SLEEP_FOOD_MASK_FED
	else if(healAmount - SLEEP_FOOD_MASK_FAT > 0) // check the little one last
		nut_heals = SLEEP_HPS_BONUS_FAT_NUT
		healAmount -= SLEEP_FOOD_MASK_FAT

	var/healbots = isrobotic(master)
	if(iscarbon(master))
		var/mob/living/carbon/C = master
		for(var/X in C.bodyparts)
			var/obj/item/bodypart/BAP = X
			BAP.suture_heal(TRUE)
			BAP.bandage_heal(TRUE) // an extra free hungerless tick if sleeping with healgyatts

	// Now pick a random element from the list, if it is BRUTE, OXY, TOX or BURN, apply the heal amount to one of them.
	switch(pick(damagedParts))
		if(BRUTE)
			master.adjustBruteLoss(-healAmount, include_roboparts = healbots)
		if(OXY)
			master.adjustOxyLoss(-healAmount)
		if(TOX)
			master.adjustToxLoss(-healAmount)
		if(BURN)
			master.adjustFireLoss(-healAmount, include_roboparts = healbots)
	// And that's it! We dont really need to add anything else, it will continue to call this function every tick.

/// checks if we should try to wake up
/datum/component/sleeping_regeneration/proc/GetHealAmount()
	SLEEP_MASTER
	var/heal_amt = SLEEP_HPS_BASE
	if(rest_mode)
		return heal_amt * REST_HEAL_MULT
	switch(WhereBlanket())
		if(BLANKET_IN_INVENTORY)
			heal_amt += SLEEP_HPS_BONUS_BLANKET_IN_INVENTORY
		if(BLANKET_ON_GROUND)
			heal_amt += SLEEP_HPS_BONUS_BLANKET_ON_GROUND
		if(BLANKET_ON_BED)
			heal_amt += SLEEP_HPS_BONUS_BLANKET_ON_BED
	heal_amt += (SLEEP_HPS_BONUS_BED_PER_RANK * GetBedPower())
	var/hevyd = HAS_TRAIT(master, TRAIT_HEAVY_SLEEPER)
	var/turf/T = get_turf(master)
	if(T.is_softly_lit())
		heal_amt += SLEEP_HPS_BONUS_DARK
	if(hevyd)
		heal_amt /= HEAVY_SLEEPER_EXTRA_SLEEP_MOD
	var/nut = master.nutrition
	if(nut > NUTRITION_LEVEL_FAT)
		heal_amt += SLEEP_HPS_BONUS_FAT_NUT // hi fred, loved that scorn stream
		heal_amt += SLEEP_FOOD_MASK_FAT
	else if(nut > NUTRITION_LEVEL_FED)
		heal_amt += SLEEP_HPS_BONUS_FED_NUT
		heal_amt += SLEEP_FOOD_MASK_FED
	return heal_amt

/// checks if we should try to wake up
/datum/component/sleeping_regeneration/proc/CheckAlarmClock()
	switch(sleeping_until)
		if(SLEEP_UNTIL_AWAKE) // waking up
			return // it'll naturally wear off
		if(SLEEP_FOREVER)
			RefreshSleep()
		if(SLEEP_UNTIL_ALARM)
			if(world.time > sleeping_until)
				Stir()
			else
				RefreshSleep()
		if(SLEEP_UNTIL_OUT_OF_CRIT)
			SLEEP_MASTER
			if(master.health > 0) // aka out of crit
				Stir()
			else
				RefreshSleep()
		if(SLEEP_FULLY_HEALED)
			if(master.health > (master.maxHealth * 95)) // wiggle room, sleep decay will handle the rest
				Stir()
			else
				RefreshSleep()

/datum/component/sleeping_regeneration/proc/RefreshSleep()
	SLEEP_MASTER
	var/sleeptime = SLEEP_BASE_DURATION
	if(HAS_TRAIT(master, TRAIT_HEAVY_SLEEPER))
		sleeptime *= HEAVY_SLEEPER_EXTRA_SLEEP_MOD
	master.Sleeping(sleeptime, TRUE, TRUE)

/datum/component/sleeping_regeneration/proc/StirClicked()
	return Stir(TRUE)

/datum/component/sleeping_regeneration/proc/Stir(resisted)
	sleep_mode = SLEEP_UNTIL_AWAKE
	if(!StillAsleep())
		return
	if(resisted)
		if(!COOLDOWN_FINISHED(src, manual_stir_cooldown))
			return
		COOLDOWN_START(src, manual_stir_cooldown, 2 SECONDS)
	SLEEP_MASTER
	master.visible_message(span_notice("[master] stirs."))
	master.setDir(pick(GLOB.cardinals)) // sturr
	master.AdjustSleeping(-(1 SECONDS)) // false means its gone

