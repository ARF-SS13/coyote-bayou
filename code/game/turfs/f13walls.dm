/turf/closed/wall/r_wall/f13vault
	name = "vault wall"
	desc = "A huge chunk of metal used to separate rooms."
	icon = 'icons/turf/walls/f13vault_reinforced_wall.dmi'
	icon_state = "vaultwall"
	hardness = 60
	canSmoothWith = null
	smoothing_flags = SMOOTH_CORNERS

/turf/closed/wall/r_wall/f13vaultrusted
	name = "rusty vault wall"
	desc = "A rusty chunk of metal used to separate rooms."
	icon = 'icons/turf/walls/f13vault_rusted_wall.dmi'
	icon_state = "vaultwall"
	hardness = 40
	canSmoothWith = null
	smoothing_flags = SMOOTH_CORNERS

/turf/closed/wall/r_wall/f13composite
	name = "composite wall"
	desc = "A huge chunk of metal used to separate rooms."
	icon = 'icons/turf/walls/f13composite.dmi'
	icon_state = "ruins"
	hardness = 50
	canSmoothWith = null
	smoothing_flags = SMOOTH_CORNERS

/turf/closed/wall/r_wall/f13superstore
	name = "DEPRECATED! TELL MAPPERS TO REPLACE THIS."
	desc = "A huge chunk of metal used to separate rooms."
	icon = 'icons/turf/walls/f13superstore.dmi'
	icon_state = "supermart"
	hardness = 50
	canSmoothWith = null
	smoothing_flags = SMOOTH_CORNERS

/turf/closed/wall/f13wood
	name = "wood wall"
	desc = "A rotting hunk of wood."
	icon = 'icons/turf/walls/f13wood_wall.dmi'
	icon_state = "house"
	hardness = 25
	smoothing_flags = SMOOTH_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_HOUSE_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_HOUSE_WALLS)
