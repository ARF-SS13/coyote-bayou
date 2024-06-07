/turf/closed
	layer = CLOSED_TURF_LAYER
	plane = WALL_PLANE
	opacity = 1
	density = TRUE
	blocks_air = 1
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	rad_insulation = RAD_MEDIUM_INSULATION

/turf/closed/Initialize(mapload)
	. = ..()
	add_debris_element()


/turf/closed/Initialize()
	. = ..()


/turf/closed/Initialize()
	. = ..()


/turf/closed/AfterChange()
	. = ..()
	SSair.high_pressure_delta -= src

/turf/closed/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	return FALSE

/turf/closed/CanAllowThrough(atom/movable/mover, border_dir)
	..()
	if(istype(mover) && (mover.pass_flags & PASSCLOSEDTURF))
		return TRUE
	return ..()
//remember folks, numbers are always balance-able
/turf/closed/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum) //don't get thrown into walls, you'll give yourself a concussion
	. = ..()
	if(ishuman(AM))
		var/mob/living/carbon/human/humanAM = AM
		humanAM.adjustBruteLoss(10)
		humanAM.AdjustKnockdown(25)
		visible_message(span_warning("[humanAM] smashes into [src]!"))

/turf/closed/Bumped(atom/movable/AM) //don't run into walls, you'll give yourself a concussion
	. = ..()
	if(ishuman(AM))
		var/mob/living/carbon/human/humanAM = AM
		if(humanAM.combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
			humanAM.disable_sprint_mode()
			humanAM.AdjustKnockdown(25)
			playsound(get_turf(src), 'sound/effects/wallsmack.ogg', 100, 0, 0)
			if(HAS_TRAIT(humanAM, TRAIT_ZOOMIES))
				humanAM.adjustBruteLoss(20) //falling from 1 story is 11 damage. falling from 2 stories is 31
				playsound(get_turf(src), 'sound/effects/slap.ogg', 100, 0, 0)
				visible_message(span_warning("[humanAM] runs straight into [src] with a sickening impact!"))
			if(HAS_TRAIT(humanAM, TRAIT_SUPER_ZOOMIES))
				humanAM.adjustBruteLoss(40)
				visible_message(span_warning("[humanAM] runs straight into [src] with a violent impact!"))
				playsound(get_turf(src), 'sound/effects/slap.ogg', 100, 0, 0)
				playsound(get_turf(src), 'sound/effects/wounds/crack2.ogg', 100, 0, 0)
			else
				visible_message(span_warning("[humanAM] runs straight into [src]!"))

/turf/closed/indestructible
	name = "wall"
	icon = 'icons/turf/walls.dmi'
	explosion_block = 50

/turf/closed/indestructible/rust_heretic_act()
	return

/turf/closed/indestructible/TerraformTurf(path, new_baseturf, flags, defer_change = FALSE, ignore_air = FALSE)
	return

/turf/closed/indestructible/acid_act(acidpwr, acid_volume, acid_id)
	return 0

/turf/closed/indestructible/Melt()
	to_be_destroyed = FALSE
	return src

/turf/closed/indestructible/singularity_act()
	return

/turf/closed/indestructible/oldshuttle
	name = "strange shuttle wall"
	icon = 'icons/turf/shuttleold.dmi'
	icon_state = "block"

/turf/closed/indestructible/sandstone
	name = "sandstone wall"
	desc = "A wall with sandstone plating. Rough."
	icon = 'icons/turf/walls/brick_wall_desert.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	baseturfs = /turf/closed/indestructible/sandstone
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/indestructible/wood
	name = "wooden wall"
	desc = "A wall with wooden plating. Stiff."
	icon = 'icons/turf/walls/wood_wall.dmi'
	icon_state = "wood_wall-0"
	base_icon_state = "wood_wall"
	smoothing_flags = SMOOTH_BITMASK
	baseturfs = /turf/closed/indestructible/wood

/turf/closed/indestructible/oldshuttle/corner
	icon_state = "corner"

/turf/closed/indestructible/splashscreen
	name = "Space Station 13"
	icon = 'icons/blank_title.png'
	icon_state = ""
	layer = FLY_LAYER
	bullet_bounce_sound = null

/turf/closed/indestructible/splashscreen/New()
	SStitle.splash_turf = src
	if(SStitle.icon)
		icon = SStitle.icon
	..()

/turf/closed/indestructible/splashscreen/vv_edit_var(var_name, var_value)
	. = ..()
	if(.)
		switch(var_name)
			if(NAMEOF(src, icon))
				SStitle.icon = icon

/turf/closed/indestructible/riveted
	icon = 'icons/turf/walls/riveted.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS)
	explosion_block = INFINITY

/turf/closed/indestructible/syndicate
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_SYNDICATE_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_SYNDICATE_WALLS, SMOOTH_GROUP_PLASTITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS)

/turf/closed/indestructible/riveted/uranium
	icon = 'icons/turf/walls/uranium_wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/indestructible/wood
	icon = 'icons/turf/walls/wood_wall.dmi'
	icon_state = "wood"
	smoothing_flags = SMOOTH_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WOOD_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WOOD_WALLS)

/turf/closed/indestructible/abductor
	icon_state = "alien1"

/turf/closed/indestructible/opshuttle
	icon_state = "wall3"


/turf/closed/indestructible/fakeglass
	name = "window"
	icon = 'icons/obj/smooth_structures/reinforced_window.dmi'
	icon_state = "fake_window"
	base_icon_state = "reinforced_window"
	opacity = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WINDOW_FULLTILE)
	canSmoothWith = list(SMOOTH_GROUP_WINDOW_FULLTILE)

/turf/closed/indestructible/fakeglass/Initialize()
	. = ..()
	underlays += mutable_appearance('icons/obj/structures.dmi', "grille") //add a grille underlay
	underlays += mutable_appearance('icons/turf/floors.dmi', "plating") //add the plating underlay, below the grille


/turf/closed/indestructible/fakedoor
	name = "CentCom Access"
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	icon_state = "fake_door"

/turf/closed/indestructible/rock
	name = "dense rock"
	desc = "An extremely densely-packed rock, most mining tools or explosives would never get through this."
	icon = 'icons/fallout/turfs/mining.dmi' //fortuna edit. fixing icon path.
	icon_state = "rock"

/turf/closed/indestructible/rock/sand
	name = "dense sandstone"
	desc = "An extremely densely-packed rock, most mining tools or explosives would never get through this."
	icon = 'modular_coyote/icons/turfs/walls.dmi'
	icon_state = "cliff-top-goonorig"

/turf/closed/indestructible/f13vaultrusted
	name = "rusty vault wall"
	desc = "A rusty chunk of metal used to separate rooms."
	icon = 'icons/turf/walls/rusty_reinforced_wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	baseturfs = /turf/open/floor/plating
	smoothing_flags = SMOOTH_CORNERS
	canSmoothWith = null

/turf/closed/indestructible/rock/snow
	name = "mountainside"
	desc = "An extremely densely-packed rock, sheeted over with centuries worth of ice and snow."
	icon = 'icons/turf/walls.dmi'
	icon_state = "snowrock"
	bullet_sizzle = TRUE
	bullet_bounce_sound = null

/turf/closed/indestructible/vaultdoor
	name = "vault wall"
	desc = "A wall made out of metal, really fucking tough metal. They definitely didn't want everything to give away around the door."
	icon = 'icons/turf/walls/f13vault_reinforced_wall.dmi'
	icon_state = "vaultwall"

/turf/closed/indestructible/rock/snow/ice
	name = "iced rock"
	desc = "Extremely densely-packed sheets of ice and rock, forged over the years of the harsh cold."
	icon = 'icons/turf/walls.dmi'
	icon_state = "icerock"

/turf/closed/indestructible/rock/snow/ice/ore
	icon = 'icons/turf/walls/icerock_wall.dmi'
	icon_state = "icerock_wall-0"
	base_icon_state = "icerock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS)
	pixel_x = -4
	pixel_y = -4


/turf/closed/indestructible/paper
	name = "thick paper wall"
	desc = "A wall layered with impenetrable sheets of paper."
	icon = 'icons/turf/walls.dmi'
	icon_state = "paperwall"

/turf/closed/indestructible/necropolis
	name = "necropolis wall"
	desc = "A seemingly impenetrable wall."
	icon = 'icons/turf/walls.dmi'
	icon_state = "necro"
	explosion_block = 50
	baseturfs = /turf/closed/indestructible/necropolis

/turf/closed/indestructible/necropolis/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/floors.dmi'
	underlay_appearance.icon_state = "necro1"
	return TRUE

/turf/closed/indestructible/riveted/boss
	name = "necropolis wall"
	desc = "A thick, seemingly indestructible stone wall."
	icon = 'icons/turf/walls/boss_wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_BOSS_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_BOSS_WALLS)
	explosion_block = 50
	baseturfs = /turf/closed/indestructible/riveted/boss

/turf/closed/indestructible/riveted/boss/see_through
	opacity = FALSE

/turf/closed/indestructible/riveted/boss/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/floors.dmi'
	underlay_appearance.icon_state = "basalt"
	return TRUE

/turf/closed/indestructible/riveted/hierophant
	name = "wall"
	desc = "A wall made out of a strange metal. The squares on it pulse in a predictable pattern."
	icon = 'icons/turf/walls/hierophant_wall.dmi'
	icon_state = "wall"
	smoothing_flags = SMOOTH_CORNERS

/turf/closed/indestructible/rock/glacierrock
	name = "unaturally hard ice wall"
	desc = "Ice, hardened over thousands of years, you're not breaking through this."
	icon = 'icons/turf/walls.dmi'
	icon_state = "snow_rock"

/turf/closed/indestructible/rock/glacierrock/blue
	name = "blue ice wall"
	desc = "The incredible compressive forces that formed this sturdy ice wall gave it a blue color."
	icon = 'icons/turf/walls.dmi'
	icon_state = "ice"
	canSmoothWith = list(/turf/closed/indestructible/rock/glacierrock/blue)
