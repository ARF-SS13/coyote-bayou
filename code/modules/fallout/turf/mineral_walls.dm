/turf/closed/wall/mineral
	name = "mineral wall"
	desc = "This shouldn't exist"
	icon_state = ""
//	var/last_event = 0
//	var/active = null
	canSmoothWith = null
	smoothing_flags = SMOOTH_BITMASK
	weak_wall = TRUE

/turf/closed/wall/mineral/gold
	name = "gold wall"
	desc = "A wall with gold plating. Swag!"
	icon = 'icons/turf/walls/gold_wall.dmi'
	icon_state = "gold"
	sheet_type = /obj/item/stack/sheet/mineral/gold
	//var/electro = 1
	//var/shocked = null
	explosion_block = 0 //gold is a soft metal you dingus.
	canSmoothWith = list(/turf/closed/wall/mineral/gold, /obj/structure/falsewall/gold)

/turf/closed/wall/mineral/silver
	name = "silver wall"
	desc = "A wall with silver plating. Shiny!"
	icon = 'icons/turf/walls/silver_wall.dmi'
	icon_state = "silver"
	sheet_type = /obj/item/stack/sheet/mineral/silver
	//var/electro = 0.75
	//var/shocked = null
	canSmoothWith = list(/turf/closed/wall/mineral/silver, /obj/structure/falsewall/silver)

/turf/closed/wall/mineral/diamond
	name = "diamond wall"
	desc = "A wall with diamond plating. You monster."
	icon = 'icons/turf/walls/diamond_wall.dmi'
	icon_state = "diamond"
	sheet_type = /obj/item/stack/sheet/mineral/diamond
	slicing_duration = 200   //diamond wall takes twice as much time to slice
	explosion_block = 3
	canSmoothWith = list(/turf/closed/wall/mineral/diamond, /obj/structure/falsewall/diamond)
	weak_wall = FALSE
/*
/turf/closed/wall/mineral/diamond/thermitemelt(mob/user)
	return

/turf/closed/wall/mineral/sandstone
	name = "sandstone wall"
	desc = "A wall with sandstone plating. Rough."
	icon = 'icons/turf/walls/sandstone_wall.dmi'
	icon_state = "sandstone"
	sheet_type = /obj/item/stack/sheet/mineral/sandstone
	explosion_block = 0
	canSmoothWith = list(/turf/closed/wall/mineral/sandstone, /obj/structure/falsewall/sandstone)

/turf/closed/wall/mineral/uranium
	name = "uranium wall"
	desc = "A wall with uranium plating. This is probably a bad idea."
	icon = 'icons/turf/walls/uranium_wall.dmi'
	icon_state = "uranium"
	sheet_type = /obj/item/stack/sheet/mineral/uranium
	canSmoothWith = list(/turf/closed/wall/mineral/uranium, /obj/structure/falsewall/uranium)

/turf/closed/wall/mineral/uranium/proc/radiate()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			radiation_pulse(get_turf(src), 3, 3, 4, 0)
			for(var/turf/closed/wall/mineral/uranium/T in orange(1,src))
				T.radiate()
			last_event = world.time
			active = null
			return
	return

/turf/closed/wall/mineral/uranium/attack_hand(mob/user)
	radiate()
	..()

/turf/closed/wall/mineral/uranium/attackby(obj/item/weapon/W, mob/user, params)
	radiate()
	..()

/turf/closed/wall/mineral/uranium/Bumped(AM as mob|obj)
	radiate()
	..()

/turf/closed/wall/mineral/plasma
	name = "plasma wall"
	desc = "A wall with plasma plating. This is definitely a bad idea."
	icon = 'icons/turf/walls/plasma_wall.dmi'
	icon_state = "plasma"
	sheet_type = /obj/item/stack/sheet/mineral/plasma
	thermal_conductivity = 0.04
	canSmoothWith = list(/turf/closed/wall/mineral/plasma, /obj/structure/falsewall/plasma)

/turf/closed/wall/mineral/plasma/attackby(obj/item/weapon/W, mob/user, params)
	if(W.is_hot() > 300)//If the temperature of the object is over 300, then ignite
		message_admins("Plasma wall ignited by [key_name_admin(user)](<A HREF='?_src_=holder;adminmoreinfo=\ref[user]'>?</A>) (<A HREF='?_src_=holder;adminplayerobservefollow=\ref[user]'>FLW</A>) in ([x],[y],[z] - <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)",0,1)
		log_game("Plasma wall ignited by [key_name(user)] in ([x],[y],[z])")
		ignite(W.is_hot())
		return
	..()

/turf/closed/wall/mineral/plasma/proc/PlasmaBurn(temperature)
	new girder_type(src)
	src.ChangeTurf(/turf/open/floor/plasteel)
	var/turf/open/T = src
	T.atmos_spawn_air("plasma=400;TEMP=1000")

/turf/closed/wall/mineral/plasma/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)//Doesn't fucking work because walls don't interact with air :(
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)

/turf/closed/wall/mineral/plasma/proc/ignite(exposed_temperature)
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)

/turf/closed/wall/mineral/plasma/bullet_act(obj/item/projectile/Proj)
	if(istype(Proj,/obj/item/projectile/beam))
		PlasmaBurn(2500)
	else if(istype(Proj,/obj/item/projectile/ion))
		PlasmaBurn(500)
	..()

*/
/turf/closed/wall/mineral/wood
	name = "wooden wall"
	desc = "A wall made by a wasteland dweller."
	icon = 'icons/turf/walls/wood_log.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	sheet_type = /obj/item/stack/sheet/mineral/wood
	hardness = 70
	explosion_block = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WOOD_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WOOD_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE)

/turf/closed/wall/mineral/iron
	name = "rough metal wall"
	desc = "A wall with rough metal plating."
	icon = 'icons/turf/walls/iron_wall.dmi'
	icon_state = "iron"
	sheet_type = /obj/item/stack/rods
	smoothing_groups = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_IRON_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_IRON_WALLS)
	weak_wall = FALSE

/turf/closed/wall/mineral/snow
	name = "packed snow wall"
	desc = "A wall made of densely packed snow blocks."
	icon = 'icons/turf/walls/snow_wall.dmi'
	icon_state = "snow"
	hardness = 80
	sheet_type = /obj/item/stack/sheet/mineral/snow
	canSmoothWith = null

/turf/closed/wall/mineral/abductor
	name = "polymer wall" // Fortuna edit: alien alloy -> polymer
	desc = "A wall with an advanced polymer alloy plating."
	icon = 'icons/turf/walls/abductor_wall.dmi'
	icon_state = "abductor"
	smoothing_flags = SMOOTH_BITMASK
	sheet_type = /obj/item/stack/sheet/mineral/abductor
	slicing_duration = 200   //alien wall takes twice as much time to slice
	explosion_block = 3
	canSmoothWith = list(/turf/closed/wall/mineral/abductor, /obj/structure/falsewall/abductor)
	weak_wall = FALSE
