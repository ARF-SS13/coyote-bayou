/datum/map/yuma
	// Unit test exemptions
	apc_test_exempt_areas = list(
		/area/space = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/shuttle = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/yuma/desert = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/yuma/testhouse = NO_SCRUBBER|NO_VENT|NO_APC
	)

	area_coherency_test_exempt_areas = list(/area/space)

/obj/effect/landmark/map_data/yuma
	height = 2
