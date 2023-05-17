/datum/looping_sound/active_outside_ashstorm
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/active_mid1.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/active_mid1.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/active_mid1.ogg', 8 SECONDS, 1)
		)
	mid_length = 8 SECONDS
	volume = 50

/datum/looping_sound/active_inside_ashstorm
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/active_mid1.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/active_mid2.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/active_mid3.ogg', 8 SECONDS, 1)
		)
	mid_length = 8 SECONDS
	volume = 25

/datum/looping_sound/weak_outside_ashstorm
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/weak_mid1.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/weak_mid2.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/weak_mid3.ogg', 8 SECONDS, 1)
		)
	mid_length = 8 SECONDS
	start_sound = list(SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/weak_start.ogg', 8 SECONDS, 1))
	start_length = 130
	end_sound = list(SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/weak_end.ogg', 13 SECONDS, 1))
	volume = 25

/datum/looping_sound/weak_inside_ashstorm
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/weak_mid1.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/weak_mid2.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/weak_mid3.ogg', 8 SECONDS, 1)
		)
	mid_length = 8 SECONDS
	start_sound = list(SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/weak_start.ogg', 8 SECONDS, 1))
	start_length = 130
	end_sound = list(SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/weak_end.ogg', 13 SECONDS, 1))
	volume = 15

//credit: soundjay.com
/datum/looping_sound/rain_sounds
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/weather/rain/outdoors/rain-01.ogg', 5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/rain/outdoors/rain-02.ogg', 5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/rain/outdoors/rain-03.ogg', 5 SECONDS, 1)
		)
	mid_length = 5 SECONDS
	volume = 100 //This is already a quiet sound effect
	direct = TRUE

//credit: soundjay.com
/datum/looping_sound/indoor_rain_sounds
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/weather/rain/indoors/rain-01.ogg', 5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/rain/indoors/rain-02.ogg', 5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/rain/indoors/rain-03.ogg', 5 SECONDS, 1)
		)
	mid_length = 5 SECONDS
	volume = 100 //This is already a quiet sound effect
	direct = TRUE

/datum/looping_sound/rad_storm
	mid_sounds = list(
		SOUND_LOOP_ENTRY('modular_sunset/sound/weather/radstorm_loop1.ogg', 4 SECONDS, 1),
		SOUND_LOOP_ENTRY('modular_sunset/sound/weather/radstorm_loop2.ogg', 4 SECONDS, 1)
		)
	volume = 50
	direct = TRUE

/datum/looping_sound/acid_rain
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/ambience/acidrain_mid.ogg', 7.5 SECONDS, 1),
		)
	volume = 75
	direct = TRUE
