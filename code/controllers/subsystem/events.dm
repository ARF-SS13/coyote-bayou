SUBSYSTEM_DEF(events)
	name = "Events"
	init_order = INIT_ORDER_EVENTS
	runlevels = RUNLEVEL_GAME

	var/list/common_control = list() // list of all datum/round_event_control that ignore weight and just happen anyway
	var/list/control = list()	//list of all datum/round_event_control. Used for selecting events based on weight and occurrences.
	var/list/running = list()	//list of all existing /datum/round_event
	var/list/processing = list()
	var/list/currentrun = list()

	var/scheduled = 0			//The next world.time that a naturally occuring random event can be selected.
	var/frequency_lower = 1800	//3 minutes lower bound.
	var/frequency_upper = 6000	//10 minutes upper bound. Basically an event will happen every 3 to 10 minutes.

	var/list/holidays = list()			//List of all holidays occuring today or null if no holidays
	var/list/potential_holidays = list()	//List of all holidays, ordered by path. Used for the admin prompt
	var/wizardmode = FALSE

/datum/controller/subsystem/events/Initialize(time, zlevel)
	for(var/type in typesof(/datum/round_event_control))
		var/datum/round_event_control/E = new type()
		if(!E.typepath)
			continue				//don't want this one! leave it for the garbage collector
		if(E.common_occurrence)
			common_control += E		//add it to the list of all looping events
		else
			control += E				//add it to the list of all events (controls)
	reschedule()
	getHoliday()
	return ..()


/datum/controller/subsystem/events/fire(resumed = 0)
	if(!resumed)
		checkEvent() //only check these if we aren't resuming a paused fire
		currentrun = processing.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/current_run = currentrun

	while(current_run.len)
		var/datum/thing = current_run[current_run.len]
		current_run.len--
		if(QDELETED(thing))
			processing -= thing
		else if(thing.process(wait) == PROCESS_KILL)
			// fully stop so that a future START_PROCESSING will work
			STOP_PROCESSING(src, thing)
		if (MC_TICK_CHECK)
			return


//checks if we should select a random event yet, and reschedules if necessary
/datum/controller/subsystem/events/proc/checkEvent()
//	spawnLoopingEvent()
	if(scheduled <= world.time)
		spawnEvent()
		reschedule()

//decides which world.time we should select another random event at.
/datum/controller/subsystem/events/proc/reschedule()
	scheduled = world.time + rand(frequency_lower, max(frequency_lower,frequency_upper))

//selects a random event based on whether it can occur and it's 'weight'(probability)
/datum/controller/subsystem/events/proc/spawnEvent()
	set waitfor = FALSE	//for the admin prompt
	if(!CONFIG_GET(flag/allow_random_events))
		return

	var/gamemode = SSticker.mode.config_tag
	var/players_amt = get_active_player_count(alive_check = 1, afk_check = 1, human_check = 1)
	// Only alive, non-AFK human players count towards this.

	var/sum_of_weights = 0
	for(var/datum/round_event_control/E in control)
		if(!E.canSpawnEvent(players_amt, gamemode))
			continue
		if(E.weight < 0)						//for round-start events etc.
			var/res = TriggerEvent(E)
			if(res == EVENT_INTERRUPTED)
				continue	//like it never happened
			if(res == EVENT_CANT_RUN)
				return
		sum_of_weights += E.weight

	sum_of_weights = rand(0,sum_of_weights)	//reusing this variable. It now represents the 'weight' we want to select

	for(var/datum/round_event_control/E in control)
		if(!E.canSpawnEvent(players_amt, gamemode))
			continue
		sum_of_weights -= E.weight

		if(sum_of_weights <= 0)				//we've hit our goal
			if(TriggerEvent(E))
				return

//Runs through the looping "guaranted" events
/datum/controller/subsystem/events/proc/spawnLoopingEvent()
	set waitfor = FALSE	//for the admin prompt
	// if(!CONFIG_GET(flag/allow_random_events))
	// 	return

	for(var/datum/round_event_control/E in common_control)
		if(!E.canSpawnLoopingEvent())
			continue
		if(E.preRunCommonEvent())
			E.runCommonEvent(TRUE)

/datum/controller/subsystem/events/proc/TriggerEvent(datum/round_event_control/E)
	. = E.preRunEvent()
	if(. == EVENT_CANT_RUN)//we couldn't run this event for some reason, set its max_occurrences to 0
		E.max_occurrences = 0
	else if(. == EVENT_READY)
		E.random = TRUE
		E.runEvent(TRUE)

//allows a client to trigger an holiday (YES YOU CAN PUT AN BEFORE HOLIDAY LOOK IT UP)
//aka Badmin Central
// > Not in modules/admin
// REEEEEEEEE
/client/proc/forceHoliday()
	set name = "Trigger Holiday"
	set category = "Admin.Events"

	if(!holder ||!check_rights(R_FUN))
		to_chat(src, span_alert("You're not allowed to have fun! :/"))
		return

	SSevents.holiday_picker(src.mob)

//allows a client to trigger an event
//aka Badmin Central
// > Not in modules/admin
// REEEEEEEEE
/client/proc/forceEvent()
	set name = "Trigger Event"
	set category = "Admin.Events"

	if(!holder ||!check_rights(R_FUN))
		return

	holder.forceEvent()

/datum/admins/proc/forceEvent()
	var/dat 	= ""
	var/normal 	= ""
	var/magic 	= ""
	var/holiday = ""
	for(var/datum/round_event_control/E in SSevents.control)
		dat = "<BR><A href='?src=[REF(src)];[HrefToken()];forceevent=[REF(E)]'>[E]</A>"
		if(E.holidayID)
			holiday	+= dat
		else if(E.wizardevent)
			magic 	+= dat
		else
			normal 	+= dat

	dat = normal + "<BR>" + magic + "<BR>" + holiday

	var/datum/browser/popup = new(usr, "forceevent", "Force Random Event", 300, 750)
	popup.set_content(dat)
	popup.open()


/*
//////////////
// HOLIDAYS //
//////////////
//Uncommenting ALLOW_HOLIDAYS in config.txt will enable holidays

//It's easy to add stuff. Just add a holiday datum in code/modules/holiday/holidays.dm
//You can then check if it's a special day in any code in the game by doing if(SSevents.holidays["Groundhog Day"])

//You can also make holiday random events easily thanks to Pete/Gia's system.
//simply make a random event normally, then assign it a holidayID string which matches the holiday's name.
//Anything with a holidayID, which isn't in the holidays list, will never occur.

//Please, Don't spam stuff up with stupid stuff (key example being april-fools Pooh/ERP/etc),
//And don't forget: CHECK YOUR CODE!!!! We don't want any zero-day bugs which happen only on holidays and never get found/fixed!

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//ALSO, MOST IMPORTANTLY: Don't add stupid stuff! Discuss bonus content with Project-Heads first please!//
//////////////////////////////////////////////////////////////////////////////////////////////////////////
*/

//sets up the holidays and holidays list
/datum/controller/subsystem/events/proc/getHoliday()
	// if(!CONFIG_GET(flag/allow_holidays)) // frik configs
	// 	return		// Holiday stuff was not enabled in the config!

	var/YY = text2num(time2text(world.timeofday, "YY")) 	// get the current year
	var/MM = text2num(time2text(world.timeofday, "MM")) 	// get the current month
	var/DD = text2num(time2text(world.timeofday, "DD")) 	// get the current day
	var/DDD = time2text(world.timeofday, "DDD")	// get the current weekday
	var/W = weekdayofthemonth()	// is this the first monday? second? etc.

	for(var/H in subtypesof(/datum/holiday))
		var/datum/holiday/holiday = new H()
		if(holiday.shouldCelebrate(DD, MM, YY, W, DDD))
			holiday.celebrate()
			if(!holidays)
				holidays = list()
			holidays[holiday.name] = holiday
		else
			potential_holidays[holiday.name] = holiday.type
			qdel(holiday) // xmas is gonna be a bit later this year

//	if(holidays)
//		holidays = shuffle(holidays)
//		// regenerate station name because holiday prefixes.
//		set_station_name(new_station_name())
//		world.update_status()

/datum/controller/subsystem/events/proc/toggleWizardmode()
	wizardmode = !wizardmode
	message_admins("Summon Events has been [wizardmode ? "enabled, events will occur every [SSevents.frequency_lower / 600] to [SSevents.frequency_upper / 600] minutes" : "disabled"]!")
	log_game("Summon Events was [wizardmode ? "enabled" : "disabled"]!")


/datum/controller/subsystem/events/proc/resetFrequency()
	frequency_lower = initial(frequency_lower)
	frequency_upper = initial(frequency_upper)

/datum/controller/subsystem/events/proc/holiday_picker(mob/doer)
	if(!doer || !doer.client || !doer.client.mob)
		return
	if(!potential_holidays)
		to_chat(doer, span_phobia("There arent any other holidays to celebrate! :("))
		return
	if(!doer.client.holder || !check_rights(R_FUN))
		to_chat(doer, span_phobia("You're not allowed to have fun! :/"))
		return
	var/list/show_list = list()
	for(var/holiday in potential_holidays)
		if(holiday in holidays)
			continue
		show_list += holiday
	var/xmas = input(doer, "Holiday Picker", "Pick a holiday to force!") as null|anything in show_list
	if(!xmas)
		to_chat(doer, span_alert("Good point, life itself is something we celebrate each day, isn't it? :)"))
		return
	if(!(xmas in potential_holidays))
		to_chat(doer, span_phobia("That's not a holiday I've ever heard of! >:("))
		return
	if(xmas in holidays)
		to_chat(doer, span_greentext("Its already [xmas]! Go celebrate! :D"))
		return
	if(!holidayify(potential_holidays[xmas], doer))
		to_chat(doer, span_phobia("Great job, you failed [xmas]! :3"))
	else
		to_chat(doer, span_greentext("You've made [xmas] come early! Merry [xmas]! :DDD"))

/// Manually forces a holiday into reality.
/datum/controller/subsystem/events/proc/holidayify(datum/holiday/xmas, mob/doer)
	if(!ispath(xmas) || !doer)
		return // xmas is cancelled :c
	var/holiname = initial(xmas.name)
	if(holidays[holiname])
		return // its already xmas! :D
	var/datum/holiday/merry = new xmas() // merry xmas
	merry.celebrate()
	if(SSticker.setup_done)
		merry.late_start()
	if(!holidays)
		holidays = list()
	holidays[holiname] = merry
	message_admins("[doer.ckey] has made [holiname] come early this year! Merry [holiname]!")
	log_game("[doer.ckey] has made [holiname] come early this year! Merry [holiname]!")
	potential_holidays -= holiname
	return TRUE

/datum/controller/subsystem/events/proc/holiday_on_join(mob/living/joiner)
	if(!holidays)
		return
	for(var/holiday in holidays)
		var/datum/holiday/H = holidays[holiday]
		H.on_join_game(joiner)
