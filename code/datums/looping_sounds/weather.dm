/datum/looping_sound/active_outside_ashstorm
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/active_mid1.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/active_mid1.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/active_mid1.ogg', 8 SECONDS, 1)
		)
	mid_length = 8 SECONDS
	start_sound = list(SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/active_start.ogg', 8 SECONDS, 1))
	start_length = 130
	end_sound = list(SOUND_LOOP_ENTRY('sound/weather/ashstorm/outside/active_end.ogg', 13 SECONDS, 1))
	volume = 40

/datum/looping_sound/active_inside_ashstorm
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/active_mid1.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/active_mid2.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/active_mid3.ogg', 8 SECONDS, 1)
		)
	mid_length = 8 SECONDS
	start_sound = list(SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/active_start.ogg', 8 SECONDS, 1))
	start_length = 130
	end_sound = list(SOUND_LOOP_ENTRY('sound/weather/ashstorm/inside/active_end.ogg', 13 SECONDS, 1))
	volume = 30

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
		SOUND_LOOP_ENTRY('sound/weather/rain/outdoors/rain-01.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/rain/outdoors/rain-02.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/rain/outdoors/rain-03.ogg', 8 SECONDS, 1)
		)
	mid_length = 8 SECONDS
	volume = 50

//credit: soundjay.com
/datum/looping_sound/indoor_rain_sounds
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/weather/rain/indoors/rain-01.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/rain/indoors/rain-02.ogg', 8 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weather/rain/indoors/rain-03.ogg', 8 SECONDS, 1)
		)
	mid_length = 8 SECONDS
	volume = 25
