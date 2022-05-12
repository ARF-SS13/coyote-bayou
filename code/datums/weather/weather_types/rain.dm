/datum/weather/rain
	name = "rain"
	desc = "Rain will fall on the Wasteland, cleaning it."
	probability = 15

	telegraph_duration = 300
	telegraph_overlay = "rain_gathering"
	telegraph_message = "<span class='notice'><font size=2>You hear a rainstorm gathering on the horizon.</font></span>"
	telegraph_sound = 'sound/weather/thunder.ogg' //credit: boomlibrary

	weather_message = "<span class='notice'><i>You hear the crack of thunder as the rainstorm grows.</i></span>"
	weather_overlay = "thunderstorm"
	weather_duration_lower = 2400
	weather_duration_upper = 7200
	end_sound = 'sound/weather/thunder.ogg' //credit: boomlibrary
	end_duration = 250
	end_message = "<span class='notice'><font size=2>You start to hear the last of the rain as the sky begins to clear up.</font></span>"
	end_overlay = "rain_gathering"
	area_types = list(/area/f13/wasteland, /area/f13/desert, /area/f13/farm, /area/f13/forest, /area/f13/ruins)
	protected_areas = list(/area/shuttle)
	target_trait = ZTRAIT_STATION
	protect_indoors = TRUE
	immunity_type = "water"

	barometer_predictable = TRUE

	affects_turfs = TRUE
	carbons_only = TRUE


	var/datum/looping_sound/rain_sounds/sound_ao = new(list(), FALSE, TRUE)
	var/datum/looping_sound/indoor_rain_sounds/sound_ai = new(list(), FALSE, TRUE)

/datum/weather/rain/eventarea
	area_types = list(/area/f13/wasteland/event)
	probability = 0
	target_trait = ZTRAIT_AWAY
	weather_duration_lower = 18000
	weather_duration_upper = 18000

/datum/weather/rain/weather_act(mob/living/L)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		SEND_SIGNAL(C, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_WEAK)
		C.wash_cream()
		C.ExtinguishMob()
		C.adjust_fire_stacks(-20) //Douse ourselves with water to avoid fire more easily
		C.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
		for(var/obj/item/I in C.held_items)
			wash_obj(I)
		if(C.back)
			if(wash_obj(C.back))
				C.update_inv_back(0)

		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			var/washgloves = TRUE
			var/washshoes = TRUE
			var/washmask = TRUE
			var/washears = TRUE
			var/washglasses = TRUE

			if(H.wear_suit)
				washgloves = !(H.wear_suit.flags_inv & HIDEGLOVES)
				washshoes = !(H.wear_suit.flags_inv & HIDESHOES)
			if(H.head)
				washmask = !(H.head.flags_inv & HIDEMASK)
				washglasses = !(H.head.flags_inv & HIDEEYES)
				washears = !(H.head.flags_inv & HIDEEARS)
			if(H.wear_mask)
				if(washears)
					washears = !(H.wear_mask.flags_inv & HIDEEARS)
				if(washglasses)
					washglasses = !(H.wear_mask.flags_inv & HIDEEYES)
			if(H.head && wash_obj(H.head))
				H.update_inv_head()
			if(H.wear_suit && wash_obj(H.wear_suit))
				H.update_inv_wear_suit()
			else if(H.w_uniform && wash_obj(H.w_uniform))
				H.update_inv_w_uniform()
			if(washgloves)
				SEND_SIGNAL(H, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_WEAK)
			if(H.shoes && washshoes && wash_obj(H.shoes))
				H.update_inv_shoes()
			if(H.wear_mask && washmask && wash_obj(H.wear_mask))
				H.update_inv_wear_mask()
			else
				H.lip_style = null
				H.update_body()
			if(H.glasses && washglasses && wash_obj(H.glasses))
				H.update_inv_glasses()
			if(H.ears && washears && wash_obj(H.ears))
				H.update_inv_ears()
			if(H.belt && wash_obj(H.belt))
				H.update_inv_belt()
		CHECK_TICK


/datum/weather/rain/weather_act_turf(turf/open/T)
	var/cleaned
	if(!cleaned)
		for(var/obj/effect/decal/O in T) //Clean cleanable decals in affected areas
			if(is_cleanable(O))
				qdel(O)
				cleaned = 1
				CHECK_TICK

/datum/weather/rain/proc/wash_obj(obj/O)
	. = SEND_SIGNAL(O, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_WEAK)
	O.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	if(isitem(O))
		var/obj/item/I = O
		I.acid_level = 0
		I.extinguish()



/datum/weather/rain/telegraph()
	. = ..()
	var/list/inside_areas = list()
	var/list/outside_areas = list()
	var/list/eligible_areas = list()
	for (var/z in impacted_z_levels)
		eligible_areas += SSmapping.areas_in_z["[z]"]
	for(var/i in 1 to eligible_areas.len)
		var/area/place = eligible_areas[i]
		if(place.outdoors)
			outside_areas += place
		else
			inside_areas += place

	sound_ao.output_atoms = outside_areas
	sound_ai.output_atoms = inside_areas

/datum/weather/rain/start()
	. = ..()
	sound_ao.start()
	sound_ai.start()

/datum/weather/rain/end()
	. = ..()
	sound_ao.stop()
	sound_ai.stop()

	return ..()
