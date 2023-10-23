/datum/weather/rain
	name = "rain"
	desc = "Rain will fall on the Wasteland, cleaning it."
	probability = 45

	telegraph_duration = 15 SECONDS
	telegraph_overlay = "rain_gathering"
	telegraph_message = span_notice("<font size=2>You hear a rainstorm gathering on the horizon.</font>")
	telegraph_sound = 'sound/weather/thunder.ogg' //credit: boomlibrary
//	weather_sound = 'sound/weather/rain/outdoors/rain-01.ogg' //credit: soundjay.com
	end_sound = 'sound/weather/thunder.ogg' //credit: boomlibrary
	end_duration = 5 SECONDS
	end_message = span_notice("<font size=2>You start to hear the last of the rain as the sky begins to clear up.</font>")
	end_overlay = "rain_gathering"
	weather_message = span_notice("<i>You hear the crack of thunder as the rainstorm grows.</i>")
	weather_overlay = "thunderstorm"
	weather_duration_lower = 5 MINUTES
	weather_duration_upper = 25 MINUTES
	tag_weather = WEATHER_RAIN
	area_types = list(/area/f13/wasteland, /area/f13/desert, /area/f13/farm, /area/f13/forest)
	protected_areas = list(/area/shuttle)
	target_trait = ZTRAIT_STATION
	protect_indoors = TRUE
	immunity_type = "water"
	is_dangerous = FALSE // thankfully our slimes dont mind water

	barometer_predictable = TRUE

	affects_turfs = TRUE
	carbons_only = TRUE

	sound_ao_type = /datum/looping_sound/rain_sounds
	sound_ai_type = /datum/looping_sound/indoor_rain_sounds
	var/list/mobs_washied_cd = list()

/datum/weather/rain/eventarea
	area_types = list(/area/f13/wasteland/event)
	probability = 0
	target_trait = ZTRAIT_AWAY
	weather_duration_lower = 18000
	weather_duration_upper = 18000

/datum/weather/rain/weather_act(mob/living/L)
	if(prob(99.9999))
		return
	if((L.real_name in mobs_washied_cd) && !COOLDOWN_FINISHED(src, mobs_washied_cd[L.real_name]))
		return
	COOLDOWN_START(src, mobs_washied_cd[L.real_name], 15 SECONDS)
	give_mob_washies(L)
	CHECK_TICK

/datum/weather/rain/weather_act_turf(turf/open/T)
/* // Stops weather from cleaning the ground (though it still cleans mobs c:)
	var/cleaned
	if(!cleaned)
		for(var/obj/effect/decal/O in T) //Clean cleanable decals in affected areas
			if(is_cleanable(O))
				qdel(O)
				cleaned = 1
				CHECK_TICK
*/
	for(var/obj/effect/decal/cleanable/blood/B in T)
		qdel(B)
		CHECK_TICK

	for(var/obj/machinery/hydroponics/tray in T) // Makes it so plants get water from rain :o
		tray.adjustWater(80)
		CHECK_TICK

/datum/weather/rain/telegraph()
	. = ..()
	var/list/inside_areas = list()
	var/list/outside_areas = list()
	var/list/eligible_areas = list()
	for (var/z in impacted_z_levels)
		eligible_areas += SSmapping.areas_in_z["[z]"]
	for(var/i in 1 to eligible_areas.len)
		var/area/place = eligible_areas[i]
		if(!place)
			WARNING("Null area in eligible areas: [eligible_areas]")
			continue
		if(place.outdoors)
			outside_areas += place
		else
			inside_areas += place

	sound_ao.output_atoms = outside_areas
	sound_ai.output_atoms = inside_areas

//Fog
/datum/weather/rain/fog
	probability = 60

	telegraph_duration = 300
	telegraph_overlay = "fog"
	telegraph_message = span_notice("<font size=2>You see the fog rolling in.</font>")
	telegraph_sound = 'sound/weather/fog.ogg' 
	weather_sound = 'sound/weather/fog.ogg'

	weather_message = span_notice("<i>You can feel and see the moisture from the fog as it starts to roll in.</i>")
	weather_overlay = "fog"
	weather_duration_lower = 2400
	weather_duration_upper = 7200
	end_sound = 'sound/weather/fog.ogg' 
	end_duration = 250
	end_message = span_notice("<font size=2>The blanket of fog finally lifts up.</font>")
	end_overlay = "fog"
	area_types = list(/area/f13/wasteland, /area/f13/desert, /area/f13/farm, /area/f13/forest)
	protected_areas = list(/area/shuttle)
	target_trait = ZTRAIT_STATION
	protect_indoors = TRUE
	immunity_type = "water"

	barometer_predictable = TRUE

	affects_turfs = TRUE
	carbons_only = TRUE

	//The fog is quiet. It knows that it is quiet because of the way it is.
	sound_ao_type = null
	sound_ai_type = null
