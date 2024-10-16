/datum/weather/acid_rain
	name = "miasma storm"
	desc = "The local environment is host to toxic airborn substances that are flowing in."
	probability = 25

	telegraph_duration = 70 SECONDS
	telegraph_overlay = "miasma"
	telegraph_message = span_userdanger("The local environment starts to become hard to breath and your throat grows scratchy, get your mask on!")
	telegraph_sound = 'sound/ambience/acidrain_start.ogg'

	weather_message = span_userdanger("<i>The air around is too heavy to breath without a mask! Get inside!</i>")
	weather_overlay = "nitryl"
	weather_duration_lower = 15 MINUTES
	weather_duration_upper = 25 MINUTES

	end_duration = 100
	end_message = span_userdanger("The winds push away toxic substances in the air, its becoming safe to breath again.")
	end_sound = 'sound/ambience/acidrain_end.ogg'

	tag_weather = WEATHER_ACID
	area_types = list(/area/f13/wasteland, /area/f13/desert, /area/f13/farm, /area/f13/forest)
	target_trait = ZTRAIT_STATION
	protect_indoors = TRUE

	immunity_type = "" // temp

	barometer_predictable = TRUE

	carbons_only = TRUE

	sound_ao_type = /datum/looping_sound/acid_rain
	sound_ai_type = /datum/looping_sound/indoor_rain_sounds

/datum/weather/acid_rain/weather_act(mob/living/carbon/C)
//	var/resist = L.getarmor(null, "acid")
//	if(prob(max(0,100-resist)))
//		L.acid_act(45, 10)
	if(C.has_smoke_protection())
		return 0
	C.adjustToxLoss(rand(1, 15))
	C.emote("gasp")


/datum/weather/acid_rain/weather_act_turf(turf/T)
	SEND_SIGNAL(T, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_MEDIUM)
	for(var/obj/effect/O in T)
		if(is_cleanable(O))
			qdel(O)
	for(var/obj/item/ammo_casing/C in T)
		qdel(C)

