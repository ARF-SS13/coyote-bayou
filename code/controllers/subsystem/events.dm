SUBSYSTEM_DEF(events)
	name = "Events"
	init_order = INIT_ORDER_EVENTS
	runlevels = RUNLEVEL_GAME

	var/list/control = list()	//list of all datum/round_event_control. Used for selecting events based on weight and occurrences.
	var/list/running = list()	//list of all existing /datum/round_event
	var/list/currentrun = list()

	var/scheduled = 0			//The next world.time that a naturally occuring random event can be selected.
	var/frequency_lower = 1800	//3 minutes lower bound.
	var/frequency_upper = 6000	//10 minutes upper bound. Basically an event will happen every 3 to 10 minutes.

	var/list/holidays			//List of all holidays occuring today or null if no holidays
	var/wizardmode = FALSE
	/// if true, makes all guns and ammo be american 180s and 22s. address all pipebombs to my butt uwu
	var/american180

/datum/controller/subsystem/events/Initialize(time, zlevel)
	for(var/type in typesof(/datum/round_event_control))
		var/datum/round_event_control/E = new type()
		if(!E.typepath)
			continue				//don't want this one! leave it for the garbage collector
		control += E				//add it to the list of all events (controls)
	reschedule()
	getHoliday()
	return ..()


/datum/controller/subsystem/events/fire(resumed = 0)
	if(!resumed)
		checkEvent() //only check these if we aren't resuming a paused fire
		src.currentrun = running.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/datum/thing = currentrun[currentrun.len]
		currentrun.len--
		if(thing)
			thing.process()
		else
			running.Remove(thing)
		if (MC_TICK_CHECK)
			return

//checks if we should select a random event yet, and reschedules if necessary
/datum/controller/subsystem/events/proc/checkEvent()
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

/datum/controller/subsystem/events/proc/TriggerEvent(datum/round_event_control/E)
	. = E.preRunEvent()
	if(. == EVENT_CANT_RUN)//we couldn't run this event for some reason, set its max_occurrences to 0
		E.max_occurrences = 0
	else if(. == EVENT_READY)
		E.random = TRUE
		E.runEvent(TRUE)

/datum/controller/subsystem/events/proc/show_180_message(mob/target)
	var/fuck = alert(
				target,
				"Hey its April Fools, want to piss everyone off and lag the server out and make every gun and magazine runtime \
				the moment they spawn? If you say yes, every gun will turn into an American180, and every magazine \
				turn into the wierd ammo it uses. No there isnt a way to turn this off. Yes it will cause a few thousand runtimes. \
				Yes you will probably have to tell Lagg to restart the server.", 
				"April.", 
				"ITS AMERICAN 180 TIME", 
				"No please!"
				)
	if(fuck == "ITS AMERICAN 180 TIME" && SSevents.american180 == -1)
		confirm_bad_idea(target, 1)

/datum/controller/subsystem/events/proc/confirm_bad_idea(mob/target, stage = 1)
	if(SSevents.american180 == 1)
		return
	if(SSevents.american180 == 0)
		to_chat(target, span_alert("Its not april fools, as far as the server is concerned! If you're dead set on ruining everything, trigger it through secrets!"))
		return
	switch(stage)
		if(1)
			var/fuck = alert(
						target,
						"Are you sure?", 
						"April.", 
						"MAKE IT HAPPEN", 
						"Not really!"
						)
			if(fuck == "MAKE IT HAPPEN" && SSevents.american180 == -1)
				confirm_bad_idea(target, 2)
		if(2)
			var/fuck = alert(
						target,
						"Are you really sure?", 
						"April.", 
						"Not really!",
						"YES!",
						)
			if(fuck == "YES!" && SSevents.american180 == -1)
				confirm_bad_idea(target, 3)
		if(3)
			var/fuck = alert(
						target,
						"Last chance to stop it!", 
						"April.", 
						"AMERICANIZE", 
						"Stop!"
						)
			if(fuck == "AMERICANIZE" && SSevents.american180 == -1)
				to_chat(target, span_phobia("Kay!"))
				americanize(TRUE)
		


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
	if(!CONFIG_GET(flag/allow_holidays))
		return		// Holiday stuff was not enabled in the config!

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
			qdel(holiday)

/*	if(holidays)
		holidays = shuffle(holidays)
		// regenerate station name because holiday prefixes.
		set_station_name(new_station_name())
		world.update_status()*/

/datum/controller/subsystem/events/proc/toggleWizardmode()
	wizardmode = !wizardmode
	message_admins("Summon Events has been [wizardmode ? "enabled, events will occur every [SSevents.frequency_lower / 600] to [SSevents.frequency_upper / 600] minutes" : "disabled"]!")
	log_game("Summon Events was [wizardmode ? "enabled" : "disabled"]!")


/datum/controller/subsystem/events/proc/resetFrequency()
	frequency_lower = initial(frequency_lower)
	frequency_upper = initial(frequency_upper)
