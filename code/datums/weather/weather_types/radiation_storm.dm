/datum/weather/rad_storm
	name = "radiation storm"
	desc = "A thunderstorm of intense radiation passes through the area dealing radiation damage to those who are unprotected."
	probability = 6

	telegraph_duration = 700
	telegraph_message = span_userdanger("The skies slowly turn into a glowing green, distant distorted thunder can be heard as dark clouds approach.")
	telegraph_sound = 'modular_sunset/sound/weather/radstorm2.ogg'


	weather_message = span_userdanger("<i>You feel waves of heat wash over you! Find shelter!</i>")
	weather_overlay = "ash_storm"
	weather_duration_lower = 5 MINUTES
	weather_duration_upper = 30 MINUTES
	weather_color = "green"

	end_duration = 100
	end_message = span_userdanger("The air seems to be cooling off again as the radiation storm passes, the sky returning to it's normal color.")

	tag_weather = WEATHER_RADS
	area_types = list(/area/f13/wasteland, /area/f13/desert, /area/f13/farm, /area/f13/forest)
	protected_areas = list(
		/area/maintenance,
		/area/ai_monitored/turret_protected/ai_upload,
		/area/ai_monitored/turret_protected/ai_upload_foyer,
		/area/ai_monitored/turret_protected/ai,
		/area/storage/emergency/starboard,
		/area/storage/emergency/port,
		/area/shuttle,
		/area/security/prison,
		/area/ruin,
		/area/space/nearstation,
		/area/icemoon
		)
	target_trait = ZTRAIT_STATION

	immunity_type = "rad"

	var/radiation_intensity = 100

	sound_ao_type = /datum/looping_sound/rad_storm
	sound_ai_type = /datum/looping_sound/rad_storm_indoors

/datum/weather/rad_storm/telegraph()
	..()
	status_alarm(TRUE)

/datum/weather/rad_storm/weather_act(mob/living/L)
	L.rad_act(rand(10,20))

/datum/weather/rad_storm/end()
	if(..())
		return
	status_alarm(FALSE)

/datum/weather/rad_storm/proc/status_alarm(active)	//Makes the status displays show the radiation warning for those who missed the announcement.
	var/datum/radio_frequency/frequency = SSradio.return_frequency(FREQ_STATUS_DISPLAYS)
	if(!frequency)
		return

	var/datum/signal/signal = new
	if (active)
		signal.data["command"] = "alert"
		signal.data["picture_state"] = "radiation"
	else
		signal.data["command"] = "shuttle"

	var/atom/movable/virtualspeaker/virt = new(null)
	frequency.post_signal(virt, signal)
