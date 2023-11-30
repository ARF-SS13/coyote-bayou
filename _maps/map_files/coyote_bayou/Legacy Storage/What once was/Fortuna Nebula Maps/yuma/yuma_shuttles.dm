/* This is commented out until we need it.

/datum/shuttle/autodock/ferry/emergency/escape_shuttle
	name = "Train"
	warmup_time = 10
	location = 1
	dock_target = "endround_train"
	shuttle_area = /area/shuttle/escape_shuttle
	waypoint_offsite = "nav_endround_train_start"
	waypoint_station = "nav_endround_train_station"
	landmark_transition = "nav_endround_train_transit"

/obj/effect/shuttle_landmark/escape_shuttle/start
	landmark_tag = "nav_endround_train_start"
	docking_controller = "centcom_escape_dock"

/obj/effect/shuttle_landmark/escape_shuttle/transit
	landmark_tag = "nav_endround_train_transit"

/obj/effect/shuttle_landmark/escape_shuttle/station
	landmark_tag = "nav_endround_train_station"
	docking_controller = "escape_dock"

*/