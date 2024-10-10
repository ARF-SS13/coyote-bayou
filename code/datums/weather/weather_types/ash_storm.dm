//Ash storms happen frequently on lavaland. They heavily obscure vision, and cause high fire damage to anyone caught outside.
/datum/weather/ash_storm
	name = "ash storm"
	desc = "An intense atmospheric storm lifts ash off of the planet's surface and billows it down across the area, dealing intense fire damage to the unprotected."

	telegraph_message = span_boldwarning("An eerie moan rises on the wind. Sheets of burning ash blacken the horizon. Seek shelter.")
	telegraph_duration = 300
	telegraph_overlay = "light_ash"

	weather_message = span_userdanger("<i>Smoldering clouds of scorching ash billow down around you! Get inside!</i>")
	weather_duration_lower = 5 MINUTES
	weather_duration_upper = 40 MINUTES
	weather_overlay = "ash_storm"

	end_message = span_boldannounce("The shrieking wind whips away the last of the ash and falls to its usual murmur. It should be safe to go outside now.")
	end_duration = 300
	end_overlay = "light_ash"

	area_types = list(
		/area/f13/wasteland,
		/area/f13/desert,
		/area/f13/farm,
		/area/f13/forest,
		)
	protect_indoors = TRUE
	target_trait = ZTRAIT_ASHSTORM
	tag_weather = WEATHER_SAND

	immunity_type = "ash"

	probability = 0

	barometer_predictable = TRUE

	sound_ao_type = /datum/looping_sound/active_outside_ashstorm
	sound_ai_type = /datum/looping_sound/active_inside_ashstorm

/datum/weather/ash_storm/telegraph()
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
		CHECK_TICK

	sound_ao.output_atoms = outside_areas
	sound_ai.output_atoms = inside_areas

/datum/weather/ash_storm/proc/is_ash_immune(atom/L)
	while (L && !isturf(L))
		if(ismecha(L)) //Mechs are immune
			return TRUE
		if(ishuman(L)) //Are you immune?
			var/mob/living/carbon/human/H = L
			var/thermal_protection = H.easy_thermal_protection()
			if(thermal_protection >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
				return TRUE
		if(isliving(L))// if we're a non immune mob inside an immune mob we have to reconsider if that mob is immune to protect ourselves
			var/mob/living/the_mob = L
			if("ash" in the_mob.weather_immunities)
				return TRUE
		L = L.loc //Check parent items immunities (recurses up to the turf)
	return FALSE //RIP you

/datum/weather/ash_storm/weather_act(mob/living/L)
	if(is_ash_immune(L))
		return
	if(is_species(L, /datum/species/lizard/ashwalker))
		if(!IS_STAMCRIT(L))
			L.adjustStaminaLossBuffered(4)
		return
	L.adjustFireLoss(4)


/datum/weather/ash_storm/sandstorm
	name = "sandstorm"
	desc = "A passing sand storm blankets the area in harmless sands."
	probability = 15

	telegraph_message = span_userdanger("Sandstorm is coming to the area, decreasing overall visibility outside.")

	weather_message = span_boldannounce("Sand waft down around you like grotesque snow. The sandstorm is here...")

	end_message = span_boldannounce("The sandstorm slows, stops. Another layer of sand to the ground beneath your feet.")
	end_sound = null

	aesthetic = TRUE
	obscures_sight = TRUE // try seeing stuff now! YOU CANT!

	target_trait = ZTRAIT_STATION

	sound_ao_type = /datum/looping_sound/active_outside_ashstorm
	sound_ai_type = /datum/looping_sound/active_inside_ashstorm

/datum/weather/ash_storm/dust_event
	name = "toxic cloud"
	desc = "A mysterious red cloud, incredibly dangerous to most living things."

	telegraph_message = span_boldwarning("On the horizon, a thick red cloud can be seen approaching the area. It is unlike anything you've ever seen before. Seek shelter, lest you want to find out what's in store for yourself.")
	telegraph_duration = 3000
	telegraph_overlay = "light_ash"

	weather_message = span_userdanger("<i>The red cloud is here, and it is incredibly dangerous to be in! Get inside!</i>")
	weather_duration_lower = 108000 //Three hours. Lasts the whole round, basically
	weather_duration_upper = 108000
	weather_overlay = "ash_storm"

	end_message = span_boldannounce("The cloud has passed over the region. It should be safe to go outside now.")
	end_duration = 3000
	end_overlay = "light_ash"

	area_types = list(/area/f13/wasteland, /area/f13/desert, /area/f13/farm, /area/f13/forest)
	protect_indoors = TRUE
	target_trait = ZTRAIT_STATION

	probability = 0

/datum/weather/ash_storm/dust_event/weather_act(mob/living/L)
	if(is_ash_immune(L))
		return
	if(is_species(L, /datum/species/lizard/ashwalker))
		if(!IS_STAMCRIT(L))
			L.adjustStaminaLossBuffered(4)
		return
	L.adjustToxLoss(7.5)
