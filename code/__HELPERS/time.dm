/proc/station_time_debug(force_set)
	if(isnum(force_set))
		SSticker.gametime_offset = force_set
		return
	SSticker.gametime_offset = rand(0, 864000)		//hours in day * minutes in hour * seconds in minute * deciseconds in second
	if(prob(50))
		SSticker.gametime_offset = FLOOR(SSticker.gametime_offset, 3600)
	else
		SSticker.gametime_offset = CEILING(SSticker.gametime_offset, 3600)

/* Returns 1 if it is the selected month and day */
/proc/isDay(month, day)
	if(isnum(month) && isnum(day))
		var/MM = text2num(time2text(world.timeofday, "MM")) // get the current month
		var/DD = text2num(time2text(world.timeofday, "DD")) // get the current day
		if(month == MM && day == DD)
			return 1

//returns timestamp in a sql and a not-quite-compliant ISO 8601 friendly format
/proc/SQLtime(timevar)
	return time2text(timevar || world.timeofday, "YYYY-MM-DD hh:mm:ss")


GLOBAL_VAR_INIT(midnight_rollovers, 0)
GLOBAL_VAR_INIT(rollovercheck_last_timeofday, 0)
/proc/update_midnight_rollover()
	if (world.timeofday < GLOB.rollovercheck_last_timeofday) //TIME IS GOING BACKWARDS!
		GLOB.midnight_rollovers++
	GLOB.rollovercheck_last_timeofday = world.timeofday
	return GLOB.midnight_rollovers

/proc/weekdayofthemonth()
	var/DD = text2num(time2text(world.timeofday, "DD")) 	// get the current day
	switch(DD)
		if(8 to 13)
			return 2
		if(14 to 20)
			return 3
		if(21 to 27)
			return 4
		if(28 to INFINITY)
			return 5
		else
			return 1

//Takes a value of time in deciseconds.
//Returns a text value of that number in hours, minutes, or seconds.
/proc/DisplayTimeText(time_value, round_seconds_to = 0.1, show_zeroes, abbreviated, fixed_digits = 0)
	var/second = FLOOR(time_value * 0.1, round_seconds_to)
	var/second_fixed = pad_number(FLOOR(MODULUS(second, 60), round_seconds_to), fixed_digits)
	if(!second)
		return "right now"
	if(second < 60)
		if(abbreviated)
			return "[second_fixed]s"
		else
			return "[second_fixed] second[(second != 1)? "s":""]"
	var/minute = FLOOR(second / 60, 1)
	var/minute_fixed = pad_number(MODULUS(round(minute), 60), fixed_digits)
	second = FLOOR(MODULUS(second, 60), round_seconds_to)
	var/secondT
	if(second || show_zeroes)
		if(abbreviated)
			secondT = ":[second_fixed]s"
		else
			secondT = " and [second_fixed] second[(second != 1)? "s":""]"
	if(minute < 60)
		if(abbreviated)
			return "[minute_fixed]m[secondT]"
		else
			return "[minute_fixed] minute[(minute != 1)? "s":""][secondT]"
	var/hour = FLOOR(minute / 60, 1)
	var/hour_fixed = pad_number(MODULUS(round(hour), 24), fixed_digits)
	minute = MODULUS(minute, 60)
	var/minuteT
	if(minute || show_zeroes)
		if(abbreviated)
			minuteT = ":[minute_fixed]m"
		else
			minuteT = " and [minute_fixed] minute[(minute != 1)? "s":""]"
	if(hour < 24)
		if(abbreviated)
			return "[hour_fixed]h[minuteT][secondT]"
		else
			return "[hour_fixed] hour[(hour != 1)? "s":""][minuteT][secondT]"
	var/day = FLOOR(hour / 24, 1)
	var/day_fixed = pad_number(round(minute), fixed_digits)
	hour = MODULUS(hour, 24)
	var/hourT
	if(hour || show_zeroes)
		if(abbreviated)
			hourT = ":[hour_fixed]h"
		else
			hourT = " and [hour_fixed] hour[(hour != 1)? "s":""]"
	if(abbreviated)
		return "[day_fixed]d[hourT][minuteT][secondT]"
	else
		return "[day_fixed] day[(day != 1)? "s":""][hourT][minuteT][secondT]"

/proc/daysSince(realtimev)
	return round((world.realtime - realtimev) / (24 HOURS))

/proc/worldtime2text()
	return gameTimestamp("hh:mm:ss", world.time)

/proc/gameTimestamp(format = "hh:mm:ss", wtime=null)
	if(!wtime)
		wtime = world.time
	return time2text(wtime - GLOB.timezoneOffset, format)
