//Acid rain is part of the natural weather cycle in the humid forests of Planetstation, and cause acid damage to anyone unprotected.
/datum/weather/acid_rain
	name = "acid rain"
	desc = "The planet's thunderstorms are by nature acidic, and will incinerate anyone standing beneath them without protection."

	telegraph_duration = 400
	telegraph_message = "<span class='notice'>Thunder rumbles far above. You hear droplets drumming against the canopy. Seek shelter.</span>"
	telegraph_sound = 'sound/weather/thunder.ogg' //credit: boomlibrary

	weather_message = "<span class='notice'><i>Acidic rain pours down around you! Get inside!</i></span>"
	weather_overlay = "acid_rain"
	weather_duration_lower = 600
	weather_duration_upper = 1500
	weather_sound = 'sound/weather/rain.ogg' //credit: soundjay.com

	end_duration = 100
	end_message = "<span class='notice'>The downpour gradually slows to a light shower. It should be safe outside now.</span>"

	area_types = list(/area/f13/wasteland, /area/f13/desert, /area/f13/farm, /area/f13/forest, /area/f13/ruins)
	protect_indoors = TRUE
	target_trait = ZTRAIT_ACIDRAIN

	immunity_type = "acid" // temp

	barometer_predictable = TRUE


/datum/weather/acid_rain/weather_act(mob/living/L)
	var/resist = L.getarmor(null, "acid")
	if(prob(max(0,100-resist)))
		L.acid_act(20,20)
