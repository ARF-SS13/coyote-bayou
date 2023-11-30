/datum/map/yuma
	name          = "Yuma"
	full_name     = "Yuma Region"
	path          = "yuma"

	station_name  = "Yuma Region"
	station_short = "Yuma"
	dock_name     = "Runtime Station"
	boss_name     = "Absolutely Nobody"
	boss_short    = "Nobody"
	company_name  = "None"
	company_short = "N/A"
	system_name   = "Milky Way"

	station_levels = list(1,2)
	contact_levels = list(1,2)
	player_levels =  list(1,2)
	sealed_levels =  list(1,2)
	admin_levels =   list(3,4)

	available_cultural_info = list(
		TAG_HOMEWORLD = list(/decl/cultural_info/location/stateless),
		TAG_FACTION =   list(/decl/cultural_info/faction/other),
		TAG_CULTURE =   list(/decl/cultural_info/culture/human),
		TAG_RELIGION =  list(/decl/cultural_info/religion/other)
	)

	default_cultural_info = list(
		TAG_HOMEWORLD = /decl/cultural_info/location/stateless,
		TAG_FACTION =   /decl/cultural_info/faction/other,
		TAG_CULTURE =   /decl/cultural_info/culture/human,
		TAG_RELIGION =  /decl/cultural_info/religion/other
	)

	base_floor_type = /turf/simulated/open

	overmap_event_areas = 0
	use_overmap = FALSE
	num_exoplanets = 0

	lobby_screens = list(
		'maps/yuma/lobby/title1.png',
		'maps/yuma/lobby/title2.png',
		'maps/yuma/lobby/title3.png',
		'maps/yuma/lobby/title4.png',
		'maps/yuma/lobby/title5.png',
		'maps/yuma/lobby/title6.png',
		'maps/yuma/lobby/title7.png',
		'maps/yuma/lobby/title8.png',
		'maps/yuma/lobby/title9.png',
		'maps/yuma/lobby/title10.png',
		'maps/yuma/lobby/title11.png',
		'maps/yuma/lobby/title12.png'
	)

	evac_controller_type = /datum/evacuation_controller/shuttle
	exterior_atmos_composition = list(/decl/material/gas/oxygen = MOLES_O2STANDARD, /decl/material/gas/nitrogen = MOLES_N2STANDARD)
	exterior_atmos_temp = 313 // Approx 40C

/datum/map/yuma/get_map_info()
	return "Welcome to Yuma. Enjoy your stay!"
