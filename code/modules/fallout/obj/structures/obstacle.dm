#define SINGLE "single"
#define VERTICAL "vertical"
#define HORIZONTAL "horizontal"

#define METAL 1
#define WOOD 2
#define SAND 3

///////////////
// OBSTACLES //
///////////////

/obj/structure/obstacle
	name = "obstacle template"
	desc = "don't use"
	icon = 'icons/fallout/structures/barricades.dmi'
	anchored = TRUE
	density = TRUE
	obj_integrity = 150
	max_integrity = 150

/obj/structure/obstacle/tanktrap
	name = "tanktrap"
	desc = "Metal bars welded together, blocks movement, but terrible cover."
	icon_state = "tanktrap"
	anchored = 1
	density = 1
	obj_integrity = 500
	max_integrity = 500
	proj_pass_rate = 90
	pass_flags = LETPASSTHROW
	climbable = TRUE

/obj/structure/obstacle/old_locked_door
	name = "old locked door"
	desc = "Key long lost, lock rusted shut. Apply violence to gain entry."
	icon_state = "locked"
	opacity = TRUE

/obj/structure/obstacle/jammed_door
	name = "jammed secure door"
	desc = "Heavy doors jammed halfway open. Squeeze past or apply plenty of violence."
	icon_state = "jammed"
	obj_integrity = 800
	max_integrity = 800
	climbable = TRUE


/////////////////
// BARBED WIRE //
/////////////////

/obj/structure/obstacle/barbedwire
	name = "barbed wire"
	desc = "Don't walk into this."
	icon_state = "barbed"
	density = FALSE
	var/slowdown = 40
	var/buildstacktype = /obj/item/stack/rods
	var/buildstackamount = 5
	pass_flags = LETPASSTHROW

/obj/structure/obstacle/barbedwire/end
	icon_state = "barbed_end"

/obj/structure/obstacle/barbedwire/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, 20, 30, 100, CALTROP_BYPASS_SHOES)

/obj/structure/obstacle/barbedwire/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/wirecutters))

		to_chat(user, span_notice("You start cutting the [src]..."))
		if(I.use_tool(src, user, 40, volume=50))
			playsound(src.loc, 'sound/items/deconstruct.ogg', 50, 1)
			deconstruct(TRUE)
			return TRUE

	return ..()

/obj/structure/obstacle/barbedwire/proc/shock(mob/user, prb) 	// war crime mode, if you can find an electrical generator

	if(!in_range(src, user))//To prevent TK and mech users from getting shocked
		return FALSE
	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = T.get_cable_node()
	if(C)
		if(electrocute_mob(user, C, src, 1, TRUE))
			var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
			s.set_up(3, 1, src)
			s.start()
			return TRUE
		else
			return FALSE
	return FALSE

//For adding to tops of fences/walls etc
/obj/effect/overlay/barbed
	name = "razorwire"
	icon = 'icons/fallout/structures/barricades.dmi'
	icon_state = "barbed_single"
	layer = ABOVE_ALL_MOB_LAYER

/////////
//JUNK //
/////////

//Objects to fill ruins with so it looks decayed on the inside too.
//Junk = Blocks movement, bullets, small resource when destroyed.
//small junk = Slows movement, worthless for cover, cleaned with soap etc. Having difficulty making the slowdown work =(

/obj/structure/junk
	icon = 'icons/fallout/objects/furniture/junk.dmi'
	obj_integrity = 100
	max_integrity = 100
	anchored = 1
	density = 1
	var/buildstacktype = /obj/item/stack/rods
	var/buildstackamount = 1

/obj/structure/junk/deconstruct()
	// If we have materials, and don't have the NOCONSTRUCT flag
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
		else
			for(var/i in custom_materials)
				var/datum/material/M = i
				new M.sheet_type(loc, FLOOR(custom_materials[M] / MINERAL_MATERIAL_AMOUNT, 1))
	..()

/obj/structure/junk/machinery
	name = "rusting machine"
	desc = "Some sort of machine rusted solid."
	icon_state = "junk_machine"
	obj_integrity = 200
	max_integrity = 200
	buildstacktype = /obj/item/stack/crafting/metalparts
	buildstackamount = 2

/obj/structure/junk/locker
	name = "decayed locker"
	desc = "Broken, rusted junk."
	icon_state = "junk_locker"

/obj/structure/junk/cabinet
	name = "old rotting furniture"
	desc = "Time and the elements has degraded this furniture beyond repair."
	icon_state = "junk_cabinet"
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 1

/obj/structure/junk/drawer
	name = "ruined old furniture"
	desc = "Time and the elements has degraded this furniture beyond repair."
	icon_state = "junk_dresser"
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 1

/obj/structure/junk/micro
	name = "rusting kitchenmachine"
	desc = "Rusted solid, useless."
	icon_state = "junk_micro"
	buildstacktype = /obj/item/stack/crafting/electronicparts
	buildstackamount = 1

/obj/structure/junk/jukebox
	name = "ancient jukebox"
	desc = "Utterly ruined."
	icon_state = "junk_jukebox"
	buildstacktype = /obj/item/stack/crafting/electronicparts
	buildstackamount = 1

/obj/structure/junk/arcade
	name = "broken down arcade machine"
	desc = "Some sort of entertainment machine, broken down."
	icon_state = "junk_arcade"
	buildstacktype = /obj/item/stack/crafting/electronicparts
	buildstackamount = 1


//Slowdown var not functional Bug
/obj/structure/junk/small
	name = "rotting planks"
	desc = "Remains of small furniture"
	icon_state = "junk_bench"
	density = 0
	var/slowdown = 4

/obj/structure/junk/small/table
	name = "ruined old furniture"
	desc = "Time and the elements has degraded this furniture beyond repair."
	icon_state = "junk_table"
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 1

/obj/structure/junk/small/tv
	name = "pre-war electronic junk"
	desc = "Broken, a useless relic of the past."
	icon_state = "junk_tv"
	buildstacktype = /obj/item/stack/crafting/electronicparts
	buildstackamount = 1

/obj/structure/junk/small/bed
	name = "rotting bed"
	desc = "Rusted and rotting, useless."
	icon_state = "junk_bed1"
	buildstackamount = 2

/obj/structure/junk/small/bed2
	name = "rusty bedframe"
	desc = "Rusted and rotting, useless."
	icon_state = "junk_bed2"
	buildstackamount = 2

/obj/structure/junk/small/disco
	name = "smashed optical machine"
	desc = "A very broken, strange machine"
	icon_state = "junk_disco"

//Junk overlays
/obj/effect/overlay/junk
	name = "junk"
	icon = 'icons/fallout/objects/furniture/junk.dmi'
	icon_state = "junk_clock"

/obj/effect/overlay/junk/toilet
	icon_state = "junk_toilet"

/obj/effect/overlay/junk/sink
	icon_state = "junk_sink"

/obj/effect/overlay/junk/urinal
	icon_state = "junk_urinal"

/obj/effect/overlay/junk/shower
	icon_state = "junk_shower"

/obj/effect/overlay/junk/mirror
	icon_state = "junk_mirror"

/obj/effect/overlay/junk/curtain
	icon_state = "junk_curtain"

/obj/effect/overlay/junk/telescreen
	icon_state = "junk_telescreen"

//Old piping
/obj/effect/overlay/junk/oldpipes
	name = "old pipes"
	desc = "Rusty old pipes."
	icon_state = "rustpipe"

/obj/effect/overlay/junk/oldpipes/manifold
	icon_state = "rustpipe-manifold"

/obj/effect/overlay/junk/oldpipes/manifold/fourway
	icon_state = "rustpipe-fourway"

/obj/effect/overlay/junk/oldpipes/end
	icon_state = "rustpipe-end"

/obj/effect/overlay/junk/oldpipes/vent
	icon_state = "rustpipe-vent"

/obj/effect/overlay/turfs/decoration/oldpipes/valve
	icon_state = "rustpipe-valve"


/obj/effect/overlay/turfs
	name = "asphalt overlay"
	icon = 'icons/fallout/turfs/smoothing.dmi'
	icon_state = "asphalt_side"
	density = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = FLOOR_PLANE
	layer = ABOVE_OPEN_TURF_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE

/obj/effect/overlay/turfs/sidewalk
	name = "sidewalk overlay"
	icon_state = "sidewalk_side"

/obj/effect/overlay/turfs/cliff
	name = "cliff overlay"
	icon_state = "cliff"

/obj/effect/overlay/turfs/cliff/alt
	icon_state = "cliffalt"

/obj/effect/overlay/turfs/cliff/corner
	icon_state = "cliff_corner"

///////////////////////
/// BARRICADE TYPES ///
///////////////////////

/obj/structure/barricade
	name = "boarded up"
	desc = "Bunch of planks nailed to something."
	icon = 'icons/fallout/structures/barricades.dmi'
	icon_state = "boarded"
	anchored = TRUE
	density = TRUE
	obj_integrity = 150
	max_integrity = 150


/obj/structure/barricade/wooden
	name = "wooden barricade"
	desc = "This space is blocked off by a wooden barricade."
	icon_state = "woodenbarricade"
	bar_material = WOOD
	var/drop_amount = 3

/obj/structure/barricade/wooden/attackby(obj/item/weapon/I, mob/living/user, params)
	if(!istype(src, /obj/structure/barricade/wooden/planks) && !istype(src, /obj/structure/barricade/wooden/crude) && istype(I, /obj/item/stack/sheet/))
		if(isfloorturf(loc) || isplatingturf(loc))
			var/obj/item/stack/sheet/mineral/wood/W = I
			var/obj/item/stack/sheet/cloth/C = I
			var/obj/item/stack/sheet/leather/L = I //???
			var/obj/item/stack/sheet/glass/G = I
			var/obj/item/stack/sheet/rglass/M = I
			if(W.amount >= 3)
				to_chat(user, "<span class='notice'>You start building a wall...</span>")
				if(do_after(user, 100, target = src) && W.use(3))
					var/turf/open/T = loc
					T.ChangeTurf(/turf/closed/wall/f13/wood)
					qdel(src)
					return TRUE
			if(C.amount >= 3)
				to_chat(user, "<span class='notice'>You start building an interior wall...</span>")
				if(do_after(user, 100, target = src) && C.use(3))
					var/turf/open/T = loc
					T.ChangeTurf(/turf/closed/wall/f13/wood/interior)
					qdel(src)
					return TRUE
			if(L.amount >= 3)
				to_chat(user, "<span class='notice'>You start building a house wall...</span>")
				if(do_after(user, 100, target = src) && L.use(3))
					var/turf/open/T = loc
					T.ChangeTurf(/turf/closed/wall/f13/wood/house)
					qdel(src)
					return TRUE
			if(G.amount >= 3)
				to_chat(user, "<span class='notice'>You start building a house window...</span>")
				if(do_after(user, 100, target = src) && G.use(3))
					var/turf/open/T = loc
					new /obj/structure/window/fulltile/house(T)
					qdel(src)
					return TRUE
			if(M.amount >= 3)
				to_chat(user, "<span class='notice'>You start building a wood framed window...</span>")
				if(do_after(user, 100, target = src) && M.use(3))
					var/turf/open/T = loc
					new /obj/structure/window/fulltile/wood(T)
					qdel(src)
					return TRUE
			else
				to_chat(user, "<span class='warning'>You need atleast 3 materials to build a structure!</span>")
		else
			to_chat(user, "<span class='warning'>You can only build the structure on a solid floor!</span>")
	else
		return ..()

/obj/structure/barricade/wooden/strong
	name = "strong wooden barricade"
	desc = "This space is blocked off by a strong wooden barricade."
	icon_state = "woodenbarricade"
	obj_integrity = 300
	max_integrity = 300
	proj_pass_rate = 30

/obj/structure/barricade/wooden/crude
	name = "crude plank barricade"
	desc = "This space is blocked off by a crude assortment of planks."
	icon_state = "woodenbarricade-old"
	drop_amount = 1
	max_integrity = 50
	proj_pass_rate = 65

/obj/structure/barricade/wooden/crude/snow
	desc = "This space is blocked off by a crude assortment of planks. It seems to be covered in a layer of snow."
	icon_state = "woodenbarricade-snow-old"
	max_integrity = 75

/obj/structure/barricade/wooden/make_debris()
	new /obj/item/stack/sheet/mineral/wood(get_turf(src), drop_amount)


/obj/structure/barricade/bars //FighterX2500 is this you?
	name = "metal bars"
	desc = "Old, corroded metal bars. Ain't got a file on you, right?" //Description by Mr.Fagetti
	icon_state = "bars"
	obj_integrity = 400
	max_integrity = 400
	proj_pass_rate = 90
	pass_flags = LETPASSTHROW //Feed the prisoners, or not.
/*
/obj/structure/barricade/sandbags
	name = "sandbags"
	desc = "Bags of sand. Take cover!"
	icon = 'icons/obj/smooth_structures/sandbags.dmi'
	icon_state = "sandbags"
	obj_integrity = 300
	max_integrity = 300
	proj_pass_rate = 20
	pass_flags = LETPASSTHROW
//	material = SAND
	climbable = TRUE
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/obj/structure/barricade/sandbags, /turf/closed/wall, /turf/closed/wall/r_wall, /obj/structure/falsewall, /obj/structure/falsewall/reinforced, /turf/closed/wall/rust, /turf/closed/wall/r_wall/rust, /obj/structure/barricade/security)
*/
#undef SINGLE
#undef VERTICAL
#undef HORIZONTAL

#undef METAL
#undef WOOD
#undef SAND
