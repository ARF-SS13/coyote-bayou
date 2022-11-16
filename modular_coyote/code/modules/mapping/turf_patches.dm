/turf/open/floor/plating/dirt
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	sunlight_state = SUNLIGHT_SOURCE
	planetary_atmos = TRUE

/turf/open/floor/plating/dirt/Initialize()
	. = ..()
	flags_2 |= GLOBAL_LIGHT_TURF_2
