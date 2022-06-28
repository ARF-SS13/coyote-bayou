// /mob/dead/observer/canZMove(direction, turf/target)
//	return TRUE
/mob/dead/on_changed_z_level(turf/old_turf, turf/new_turf)
	..()
	update_z(new_turf?.z)
