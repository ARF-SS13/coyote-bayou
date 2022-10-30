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
	var/list/eligible_zlevels = ABOVE_GROUND_Z_LEVELS // 4 through 8, its 4 through 8, fuck you its 4 through 8
	var/list/weather_rolls = list()
	var/next_hit_by_zlevel //Used by barometers to know when the next storm is coming
	/// Was a random weather queued?
	var/weather_queued = FALSE
	/// What weather is currently running?
	var/datum/weather/current_weather

/datum/controller/subsystem/processing/weather/fire()
	. = ..() //Active weather is handled by . = ..() processing subsystem base fire().

	// start random weather on relevant levels - the SAME weather on all those Zs!
	if(weather_queued || !LAZYLEN(weather_rolls))
		return FALSE
	var/datum/weather/W = pickweight(weather_rolls)
	var/randTime = rand(WEATHER_WAIT_MIN, WEATHER_WAIT_MAX)
	addtimer(CALLBACK(src, .proc/run_weather, W), randTime + initial(W.weather_duration_upper), TIMER_UNIQUE) //Around 25-30 minutes between weathers
	next_hit_by_zlevel = world.time + randTime + initial(W.telegraph_duration)
	weather_queued = TRUE // weather'll set this to FALSE when it ends

/datum/controller/subsystem/processing/weather/Initialize(start_timeofday)
	for(var/V in subtypesof(/datum/weather))
		var/datum/weather/W = V
		var/probability = initial(W.probability)
		// any weather with a probability set may occur at random
		if (probability)
			weather_rolls[W] = probability
	return ..()

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
	current_weather = new weather_datum_type(eligible_zlevels, duration)

/datum/controller/subsystem/processing/weather/proc/end_weather(z, possible_weather)
	next_hit_by_zlevel = null
	weather_queued = FALSE
	current_weather = null

/datum/controller/subsystem/processing/weather/proc/get_weather(area/active_area)
	var/datum/weather/A
	for(var/V in processing)
		var/datum/weather/W = V
		if((W.tag_weather in active_area.weather_tags))
			A = W
			break
	return A
