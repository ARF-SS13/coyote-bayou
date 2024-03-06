#define STARTUP_STAGE 1
#define MAIN_STAGE 2
#define WIND_DOWN_STAGE 3
#define END_STAGE 4

//Used for all kinds of weather, ex. lavaland ash storms.
PROCESSING_SUBSYSTEM_DEF(weather)
	name = "Weather"
	flags = SS_BACKGROUND
	wait = 10
	runlevels = RUNLEVEL_GAME
	init_order = INIT_ORDER_WEATHER // should be before atoms are initted, cus snow
	var/list/eligible_zlevels = ABOVE_GROUND_Z_LEVELS // 4 through 8, its 4 through 8, fuck you its 4 through 8
	var/list/weather_rolls = list()
	var/next_hit_by_zlevel //Used by barometers to know when the next storm is coming
	/// Was a random weather queued?
	var/weather_queued = FALSE
	var/timerid
	/// What weather is currently running?
	var/datum/weather/current_weather
	/// direction the wind is blowing in
	var/wind_direction = NORTH
	/// wind direction stuff cooldown
	COOLDOWN_DECLARE(wind_change_cooldown)
	/// all the sound emitter datums available
	/// Format: list("key" = /datum/looping_sound)
	var/list/sound_rocks = list()
	var/snowy_time = FALSE
	var/force_snow_state = FALSE // set to a non null to make it snowy or not

/datum/controller/subsystem/processing/weather/fire()
	. = ..() //Active weather is handled by . = ..() processing subsystem base fire().
	if(COOLDOWN_FINISHED(src, wind_change_cooldown))
		set_wind_direction()
		COOLDOWN_START(src, wind_change_cooldown, rand(5 MINUTES, 15 MINUTES))
	// start random weather on relevant levels - the SAME weather on all those Zs!
	if(weather_queued || !LAZYLEN(weather_rolls))
		return FALSE
	var/datum/weather/W = pickweight(weather_rolls)
	var/randTime = rand(WEATHER_WAIT_MIN, WEATHER_WAIT_MAX)
	timerid = addtimer(CALLBACK(src,PROC_REF(run_weather), W), randTime + initial(W.weather_duration_upper), TIMER_UNIQUE | TIMER_STOPPABLE) //Around 25-30 minutes between weathers
	next_hit_by_zlevel = world.time + randTime + initial(W.telegraph_duration)
	weather_queued = TRUE // weather'll set this to FALSE when it ends

/datum/controller/subsystem/processing/weather/Initialize(start_timeofday)
	if(!isnull(force_snow_state))
		snowy_time = force_snow_state
	else
		var/MM = text2num(time2text(world.timeofday, "MM"))
		if(MM == 12 || MM == 1 || MM == 2)
			snowy_time = TRUE
	for(var/V in subtypesof(/datum/weather))
		var/datum/weather/W = V
		var/probability = initial(W.probability)
		// any weather with a probability set may occur at random
		if (probability)
			weather_rolls[W] = probability
	. = ..()
	if(snowy_time)
		to_chat(world, span_boldnotice("Brr! Chilly weather today!"))

/datum/controller/subsystem/processing/weather/proc/run_weather(datum/weather/weather_datum_type, duration)
	if (istext(weather_datum_type))
		for (var/V in subtypesof(/datum/weather))
			var/datum/weather/W = V
			if (initial(W.name) == weather_datum_type)
				weather_datum_type = V
				break
	if (!ispath(weather_datum_type, /datum/weather))
		CRASH("run_weather called with invalid weather_datum_type: [weather_datum_type || "null"]")
/* 	if (isnull(z_levels))
		z_levels = SSmapping.levels_by_trait(initial(weather_datum_type.target_trait))
	else if (isnum(z_levels))
		z_levels = list(z_levels)
	else if (!islist(z_levels))
		CRASH("run_weather called with invalid z_levels: [z_levels || "null"]")
	if(duration && !isnum(duration))
		CRASH("run_weather called with invalid duration: [duration || "null"]") */
	end_weather(FALSE, FALSE, TRUE)
	current_weather = new weather_datum_type(eligible_zlevels, duration)

/datum/controller/subsystem/processing/weather/proc/end_weather(clear_fluff = TRUE, reset_queue = TRUE, delete_weather = TRUE)
	if(clear_fluff)
		next_hit_by_zlevel = null
	if(reset_queue)
		weather_queued = FALSE
	if(delete_weather)
		if(current_weather)
			current_weather.end(TRUE)
			QDEL_NULL(current_weather)
		if(timerid)
			deltimer(timerid)

/datum/controller/subsystem/processing/weather/proc/get_weather(area/active_area)
	if(!current_weather) // No weather, no problems
		return
	if(!isarea(active_area))
		active_area = get_area(active_area)
		if(!isarea(active_area)) // still??
			return
	if(!LAZYLEN(active_area.weather_tags) || !active_area.weather_tags || isnull(active_area.weather_tags))
		return // area cant have weather (or it wasnt set up right), so it doesnt have weather
	if(current_weather.tag_weather in active_area.weather_tags) // weather affects all affectable areas at once, so if we have a weather, and that area can support it, it'll have that weather
		return current_weather

/datum/controller/subsystem/processing/weather/proc/set_wind_direction()
	var/list/possible_directions = list(NORTH, SOUTH, EAST, WEST)
	wind_direction = pick(possible_directions)

/datum/controller/subsystem/processing/weather/proc/add_sound_rock(atom/rock, soundloop)
	if(!ispath(soundloop, /datum/looping_sound))
		CRASH("add_sound_rock called with invalid soundloop: [soundloop || "null"]")
	var/datum/looping_sound/soop = LAZYACCESS(sound_rocks, soundloop)
	if(!soop)
		soop = new soundloop()
		sound_rocks[soop.type] = soop
	soop.start(rock)
	return soop

/datum/controller/subsystem/processing/weather/proc/remove_sound_rock(atom/rock, soundloop)
	if(!ispath(soundloop, /datum/looping_sound))
		CRASH("remove_sound_rock called with invalid soundloop: [soundloop || "null"]")
	var/datum/looping_sound/soop = LAZYACCESS(sound_rocks, soundloop)
	if(!soop)
		return
	soop.remove_atom(rock)
	return TRUE // the soundloops will stay in existence forever, even if they're empty!
