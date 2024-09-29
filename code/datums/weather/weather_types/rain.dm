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


//////////////////////////
//Fenny losing his mind//
////////////////////////
/*
/datum/weather/rain/fog/nashdown_event //I'm totally not using weather as a makeshift randomized event creator, shut up cactus.  This system already works.
	probability = 100

	telegraph_duration = 10
	telegraph_overlay = ""
	telegraph_message = ""
	telegraph_message_list = list( //Always reads as 'someone is sending (for)', in the radio font.
		"<font size=2><span class='green'><bold>\[Common\] The Nash Shadow Council</b> has a demand...</span></font>",
		"<font size=2><span class='green'><bold>\[Common\] The Nash Shadow Council</b> has a request...</font>",
		"<font size=2><span class='green'><bold>\[Common\] The Ashdown Shadow Council</b> is sending a plea...</font>",
		"<font size=2><span class='green'><bold>\[Common\] The Ashdown Shadow Council</b> is asking...</font>"
		)
	telegraph_sound = 'sound/effects/sparks1.ogg'
	weather_sound = 'sound/effects/texar-morse.ogg'

	weather_message = ""
	weather_message_list = list(
		"<span class='green'><font size=2><span class='green'>...For more chicken nuggets to be sold on the train.</span></font>",
		"<span class='green'><font size=2>...For more gecko hides to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more Nightstalker hides to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more cloth to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more bloatfly meat to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more metal to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more raw ores to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more weapons to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more armor to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more medical supplies to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more toys to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more ammo to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more chemical cartridges to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more advanced tools to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more crafting materials to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more cleaning supplies to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more wood to be sold on the train.</font>",
		"<span class='green'><font size=2>...For more seeds to be sold on the train.</font>",
		"<span class='green'><font size=2>...For people to clean up the town.</font>",
		"<span class='green'><font size=2>...For people to fix up the roads.</font>",
		"<span class='green'><font size=2>...For people to clear the trees from all the roads to help foot traffic.</font>",
		"<span class='green'><font size=2>...For people to clean up the workshop.</font>",
		"<span class='green'><font size=2>...For adventurers to check the museum for spare scrap.</font>",
		"<span class='green'><font size=2>...For adventurers to check the hospital for spare medical gear.</font>",
		"<span class='green'><font size=2>...For adventurers to check the mall for spare equipment.</font>",
		"<span class='green'><font size=2>...For adventurers to check Mass Fusion for spare black boxes.</font>",
		"<span class='green'><font size=2>...For adventurers to check Mass Fusion for spare unused nuclear fuel rods, and put them in storage.</font>",
		"<span class='green'><font size=2>...For adventurers to seek out the unaccounted for nuclear weapon.</font>",
		"<span class='green'><font size=2>...For adventurers to seek out and do battle with the members of the Fruit Gang.</font>",
		"<span class='green'><font size=2>...For adventurers to seek out and do battle with the geckos of the area.</font>",
		"<span class='green'><font size=2>...For adventurers to seek out and do battle with the raiders of the area.</font>",
		"<span class='green'><font size=2>...For adventurers to seek out and do battle with the renegades of the area.</font>",
		"<span class='green'><font size=2>...For adventurers to seek out and do battle with the rogue robots of the area.</font>",
		"<span class='green'><font size=2>...For adventurers to seek out and do battle with the feral ghouls of the area.</font>",
		"<span class='green'><font size=2>...For adventurers to seek out and do battle with the radscorpions of the area.</font>",
		"<span class='green'><font size=2>...For adventurers to seek out and do battle with the aethergiests of the area.</font>",
		"<span class='green'><font size=2>...For adventurers to loot the city of Redlick, west of Ashdown, for supplies.</font>",
		"<span class='green'><font size=2>...For adventurers to loot the city of Texarkana, east of Nash, for supplies.</font>",
		"<span class='green'><font size=2>...For adventurers to loot the mines north of the Christus Saint Michaels hospital in Texarkana.</font>",
		"<span class='green'><font size=2>...For adventurers to seek out the Chinese ghouls and raid their fortifications under Texarkana.</font>",
		"<span class='green'><font size=2>...For adventurers to seek out the ruins of the park far east of Nash and clear out its inhabitants.</font>",
		"<span class='green'><font size=2>...For adventurers to seek the mansion north of Ashdown and make certain it is safe.</font>",
		"<span class='green'><font size=2>...For adventurers to collect all the wild fruit they can back at town.</font>",
		"<span class='green'><font size=2>...For adventurers to collect all the spare weapons they can back at town.</font>",
		"<span class='green'><font size=2>...For adventurers to collect all the spare armor they can back at town.</font>",
		"<span class='green'><font size=2>...For adventurers to collect all the spare medical supplies they can back at town.</font>",
		"<span class='green'><font size=2>...For adventurers to make sure the Renegade fortress north of Nash is destroyed.</font>",
		"<span class='green'><font size=2>...For adventurers to make sure the Renegade camp to the south of Nash is destroyed.</font>",
		"<span class='green'><font size=2>...For adventurers to make sure the gecko tribes camp south of Nash on the main road has been cleared out.</font>",
		"<span class='green'><font size=2>...For adventurers to make sure the mines north of the hospital have been cleared out.</font>",
		"<span class='green'><font size=2>...For adventurers to make sure the hospital has been made safe.</font>",
		"<span class='green'><font size=2>...For looters to collect more beans in town.</font>",
		"<span class='green'><font size=2>...For looters to collect more dogfood in town.</font>",
		"<span class='green'><font size=2>...For looters to collect more peanut butter in town.</font>",
		"<span class='green'><font size=2>...For looters to collect more ammo in town.</font>",
		"<span class='green'><font size=2>...For looters to collect more guns in town.</font>",
		"<span class='green'><font size=2>...For the citizens to gather in for role call.</font>",
		"<span class='green'><font size=2>...For the citizens to throw a pool party.</font>",
		"<span class='green'><font size=2>...For the citizens to spend more time making new art.</font>",
		"<span class='green'><font size=2>...For the citizens to write more books. There should be a spare computer for doing so in the Texarkana school.</font>",
		"<span class='green'><font size=2>...For the citizens to clear vines from buildings.</font>",
		"<span class='green'><font size=2>...For the citizens to hunt frogs.</font>",
		"<span class='green'><font size=2>...For the citizens to hunt radstags.</font>",
		"<span class='green'><font size=2>...For the citizens to go fishing and either sell or eat what they catch.</font>",
		)
	weather_overlay = ""
	weather_duration_lower = 2 SECONDS
	weather_duration_upper = 6 SECONDS
	end_sound = 'sound/effects/sparks1.ogg' 
	end_duration = 250
	end_message = span_notice("<font size=2>This has been a test of the Tejaxicoana Automated Announcement System</font>")
	end_overlay = ""
	area_types = list(/area) //hahahahhahaa ~TK
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
*/
