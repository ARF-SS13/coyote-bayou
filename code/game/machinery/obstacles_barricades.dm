#define SINGLE "single"
#define VERTICAL "vertical"
#define HORIZONTAL "horizontal"

#define METAL 1
#define WOOD 2
#define SAND 3

//Barricades/cover

/obj/structure/barricade
	name = "boarded up"
	desc = "Bunch of planks nailed to something."
	icon = 'icons/fallout/structures/barricades.dmi'
	icon_state = "boarded"
	anchored = TRUE
	density = TRUE
	obj_integrity = 150
	max_integrity = 150
	pass_flags_self = LETPASSTHROW
//	var/proj_pass_rate = 50 //How many projectiles will pass the cover. Lower means stronger cover
	var/bar_material = METAL

/obj/structure/barricade/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		make_debris()
	qdel(src)

/obj/structure/barricade/proc/make_debris()
	return

/obj/structure/barricade/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weldingtool) && user.a_intent != INTENT_HARM && bar_material == METAL)
		if(obj_integrity < max_integrity)
			if(!I.tool_start_check(user, amount=0))
				return

			to_chat(user, span_notice("You begin repairing [src]..."))
			if(I.use_tool(src, user, 40, volume=40))
				obj_integrity = clamp(obj_integrity + 20, 0, max_integrity)
	else if(istype(I, /obj/item/stack/ore/glass) && bar_material == SAND)
		if(obj_integrity < max_integrity)
			to_chat(user, span_notice("You begin packing sand into the damaged \the [src], repairing them..."))
			if(do_after(user, 30, target = src))
				obj_integrity = clamp(obj_integrity + 30, 0, max_integrity)
				user.visible_message(span_notice("[user] repairs [src] with some sand."),span_notice("You repair [src] with some sand."))
				I.use(1)
		else
			to_chat(user, span_notice("The [src] doesn't need to be repaired."))
	else
		return ..()

/////BARRICADE TYPES AND TENTS///////
//Yeah the new tents go here. Sue me. Use cloth for more posh places like NCR, brahmin skin for tribals/legion  -Pebbles//

/obj/structure/barricade/tentleathercorner
	name = "brahmin skin tent"
	icon = 'icons/fallout/turfs/walls/tents.dmi'
	icon_state = "leather_corner"
	opacity = TRUE

/obj/structure/barricade/tentleatheredge
	name = "brahmin skin tent"
	icon = 'icons/fallout/turfs/walls/tents.dmi'
	icon_state = "leather_edge"
	opacity = TRUE

/obj/structure/barricade/tentclothcorner
	name = "cotton tent"
	icon = 'icons/fallout/turfs/walls/tents.dmi'
	icon_state = "cloth_corner"
	max_integrity = 80
	opacity = TRUE

/obj/structure/barricade/tentclothedge
	name = "cotton tent"
	icon = 'icons/fallout/turfs/walls/tents.dmi'
	icon_state = "cloth_edge"
	max_integrity = 80
	opacity = TRUE
/*
/obj/structure/barricade/wooden
	name = "wooden barricade" 
	desc = "This space is blocked off by a wooden barricade."
	icon = 'icons/obj/structures.dmi'
	icon_state = "woodenbarricade"


/obj/structure/barricade/wooden/attackby(obj/item/I, mob/user)
	if(istype(I,/obj/item/stack/sheet/mineral/wood))
		var/obj/item/stack/sheet/mineral/wood/W = I
		if(W.amount < 5)
			to_chat(user, span_warning("You need at least five wooden planks to make a wall!"))
			return
		to_chat(user, span_notice("You start adding [I] to [src]..."))
		if(do_after(user, 50, target=src))
			W.use(5)
			var/turf/T = get_turf(src)
			T.PlaceOnTop(/turf/closed/wall/mineral/wood/nonmetal)
			qdel(src)
		return
	return ..()
*/




/obj/structure/barricade/sandbags
	name = "sandbags"
	desc = "Bags of sand. Self explanatory."
	icon = 'icons/obj/smooth_structures/sandbags.dmi'
	icon_state = "sandbags-0"
	base_icon_state = "sandbags"
	max_integrity = 280
	proj_pass_rate = 20
	pass_flags_self = LETPASSTHROW
	bar_material = SAND
	climbable = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_SANDBAGS)
	canSmoothWith = list(SMOOTH_GROUP_SANDBAGS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_SECURITY_BARRICADE)
	var/drop_amount = 1

/obj/structure/barricade/sandbags/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	user.visible_message(span_notice("[user] starts to take down [src]..."), span_notice("You start to take down [src]..."))
	if(!has_buckled_mobs() && do_after(user, 80, target = src))
		to_chat(user, span_notice("You take down [src]."))
		new /obj/item/stack/sheet/mineral/sandbags(src.loc)
		qdel(src)
		return

/*
/obj/structure/barricade/sandbags/attackby(obj/item/W, mob/user)
	if(user.a_intent == INTENT_HELP && istype(W, /obj/item/gun))
		var/obj/item/gun/G = W
		G.gun_brace(user, src)
		return
	return ..()*/
	
/obj/structure/barricade/sandbags/make_debris()
	new /obj/item/stack/ore/glass(get_turf(src), drop_amount)

/obj/structure/barricade/security
	name = "security barrier"
	desc = "A deployable barrier. Provides good cover in fire fights."
	icon = 'icons/obj/objects.dmi'
	icon_state = "barrier0"
	density = FALSE
	anchored = FALSE
	max_integrity = 180
	proj_pass_rate = 20
	armor = ARMOR_VALUE_MEDIUM
	pass_flags = PASSGRILLE | PASSTABLE

	var/deploy_time = 40
	var/deploy_message = TRUE


/obj/structure/barricade/security/Initialize()
	. = ..()
	addtimer(CALLBACK(src,PROC_REF(deploy)), deploy_time)

/obj/structure/barricade/security/proc/deploy()
	icon_state = "barrier1"
	density = TRUE
	anchored = TRUE
	if(deploy_message)
		visible_message(span_warning("[src] deploys!"))


/obj/item/grenade/barrier
	name = "barrier grenade"
	desc = "Instant cover."
	icon = 'icons/obj/grenade.dmi'
	icon_state = "flashbang"
	inhand_icon_state = "flashbang"
	actions_types = list(/datum/action/item_action/toggle_barrier_spread)
	var/mode = SINGLE

/obj/item/grenade/barrier/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to toggle modes.")

/obj/item/grenade/barrier/AltClick(mob/living/carbon/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE))
		return
	toggle_mode(user)
	return TRUE

/obj/item/grenade/barrier/proc/toggle_mode(mob/user)
	switch(mode)
		if(SINGLE)
			mode = VERTICAL
		if(VERTICAL)
			mode = HORIZONTAL
		if(HORIZONTAL)
			mode = SINGLE

	to_chat(user, "[src] is now in [mode] mode.")

/obj/item/grenade/barrier/prime(mob/living/lanced_by)
	. = ..()
	new /obj/structure/barricade/security(get_turf(src.loc))
	switch(mode)
		if(VERTICAL)
			var/target_turf = get_step(src, NORTH)
			if(!(is_blocked_turf(target_turf)))
				new /obj/structure/barricade/security(target_turf)

			var/target_turf2 = get_step(src, SOUTH)
			if(!(is_blocked_turf(target_turf2)))
				new /obj/structure/barricade/security(target_turf2)
		if(HORIZONTAL)
			var/target_turf = get_step(src, EAST)
			if(!(is_blocked_turf(target_turf)))
				new /obj/structure/barricade/security(target_turf)

			var/target_turf2 = get_step(src, WEST)
			if(!(is_blocked_turf(target_turf2)))
				new /obj/structure/barricade/security(target_turf2)
	qdel(src)

/obj/item/grenade/barrier/ui_action_click(mob/user)
	toggle_mode(user)

/obj/structure/barricade/wooden
	name = "wooden barricade"
	desc = "This space is blocked off by a wooden barricade."
	icon_state = "woodenbarricade"
	bar_material = WOOD
	var/drop_amount = 3

/obj/structure/barricade/wooden/attackby(obj/item/weapon/I, mob/living/user, params)
	if(!istype(src, /obj/structure/barricade/wooden/planks) && !istype(src, /obj/structure/barricade/wooden/crude) && istype(I, /obj/item/stack/sheet/))
		if(isfloorturf(loc) || isplatingturf(loc))
			if(istype(I, /obj/item/stack/sheet/mineral/wood))
				var/obj/item/stack/sheet/mineral/wood/W = I
				if(W.amount >= 3)
					var/list/walls = list(
						"Wooden Wall" = image(icon = 'icons/turf/walls/wood_log.dmi', icon_state = "wall-12"),
						"Interior Wall" = image(icon = 'icons/fallout/turfs/walls/interior.dmi', icon_state = "interior0"),
						"House Wall" = image(icon = 'icons/turf/walls/house_wall_dirty.dmi', icon_state = "wall-12")
					)
					var/chosen_wall = show_radial_menu(user, src, walls, custom_check = CALLBACK(src,PROC_REF(check_menu), user, I), require_near = TRUE, tooltips = TRUE)
					if(!check_menu(user, I))
						return
					switch(chosen_wall)
						if("Wooden Wall")
							to_chat(user, span_notice("You start building a wooden wall..."))
							if(do_after(user, 100, target = src) && W.use(3))
								var/turf/open/T = loc
								T.ChangeTurf(/turf/closed/wall/f13/wood)
								qdel(src)
								return TRUE
						if("Interior Wall")
							to_chat(user, span_notice("You start building an interior wall..."))
							if(do_after(user, 100, target = src) && W.use(3))
								var/turf/open/T = loc
								T.ChangeTurf(/turf/closed/wall/f13/wood/interior)
								qdel(src)
								return TRUE
						if("House Wall")
							to_chat(user, span_notice("You start building a house wall..."))
							if(do_after(user, 100, target = src) && W.use(3))
								var/turf/open/T = loc
								T.ChangeTurf(/turf/closed/wall/f13/wood/house/clean)
								qdel(src)
								return TRUE
				else
					to_chat(user, span_warning("You need atleast 3 wood to build a structure!"))
			else if(istype(I, /obj/item/stack/sheet/glass))
				var/obj/item/stack/sheet/glass/G = I
				if(G.amount >= 3)
					var/list/windows = list(
						"House Window" = image(icon = 'icons/obj/wood_window.dmi', icon_state = "housewindow"),
						"Wood Framed Window" = image(icon = 'icons/obj/wood_window.dmi', icon_state = "woodwindow")
					)
					var/chosen_window = show_radial_menu(user, src, windows, custom_check = CALLBACK(src,PROC_REF(check_menu), user, I), require_near = TRUE, tooltips = TRUE)
					if(!check_menu(user, I))
						return
					switch(chosen_window)
						if("House Window")
							to_chat(user, span_notice("You start building a house window..."))
							if(do_after(user, 100, target = src) && G.use(3))
								var/turf/open/T = loc
								new /obj/structure/window/fulltile/house(T)
								qdel(src)
								return TRUE
						if("Wood Framed Window")
							to_chat(user, span_notice("You start building a wood framed window..."))
							if(do_after(user, 100, target = src) && G.use(3))
								var/turf/open/T = loc
								new /obj/structure/window/fulltile/wood(T)
								qdel(src)
								return TRUE
				else
					to_chat(user, span_warning("You need at least 3 glass to build a structure!"))
			else if(istype(I, /obj/item/stack/sheet/cloth))
				var/obj/item/stack/sheet/cloth/C = I
				if(C.amount >= 3)
					var/list/tentwalls = list(
						"Tent Wall" = image(icon = 'icons/turf/walls/tent_wall.dmi', icon_state = "wall-0"),
						"Tent Flaps" = image(icon = 'icons/fallout/structures/doors.dmi', icon_state = "tent")
					)
					var/chosen_tent = show_radial_menu(user, src, tentwalls, custom_check = CALLBACK(src,PROC_REF(check_menu), user, I), require_near = TRUE, tooltips = TRUE)
					if(!check_menu(user, I))
						return
					switch(chosen_tent)
						if("Tent Wall")
							to_chat(user, span_notice("You start building a tent wall..."))
							if(do_after(user, 100, target = src) && C.use(3))
								var/turf/open/T = loc
								T.ChangeTurf(/turf/closed/wall/f13/tentwall)
								qdel(src)
								return TRUE
						if("Tent Flaps")
							to_chat(user, span_notice("You start building tent flaps..."))
							if(do_after(user, 100, target = src) && C.use(3))
								var/turf/open/T = loc
								new /obj/structure/simple_door/tent(T)
								qdel(src)
								return TRUE
				else
					to_chat(user, span_warning("You need at least 3 cloth to build a structure!"))
		else
			to_chat(user, span_warning("You can only build the structure on a solid floor!"))
	else
		return ..()

/obj/structure/barricade/wooden/proc/check_menu(mob/living/user, obj/item/I)
	if(!istype(user))
		return FALSE
	if(user.incapacitated(allow_crit = TRUE) || !user.Adjacent(src) || user.get_active_held_item() != I)
		return FALSE
	return TRUE

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
	if(drop_amount)
		new /obj/item/stack/sheet/mineral/wood(get_turf(src), drop_amount)


/obj/structure/barricade/bars //FighterX2500 is this you?
	name = "metal bars"
	desc = "Old, corroded metal bars. Ain't got a file on you, right?" //Description by Mr.Fagetti
	icon_state = "bars"
	obj_integrity = 400
	max_integrity = 400
	proj_pass_rate = 50
	pass_flags_self = null

/obj/structure/barricade/barswindow
	name = "metal bars"
	desc = "Old, corroded metal bars. The bars have a window for easily passing things through!" 
	icon_state = "barswindow"
	obj_integrity = 400
	max_integrity = 400
	proj_pass_rate = 80
	pass_flags_self = LETPASSTHROW

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
	smoothing_flags = SMOOTH_TRUE
	canSmoothWith = list(/obj/structure/barricade/sandbags, /turf/closed/wall, /turf/closed/wall/r_wall, /obj/structure/falsewall, /obj/structure/falsewall/reinforced, /turf/closed/wall/rust, /turf/closed/wall/r_wall/rust, /obj/structure/barricade/security)
*/


///////////////
// OBSTACLES //
///////////////

/obj/structure/obstacle
	name = "obstacle template"
	desc = "don't use"
	icon = 'icons/fallout/structures/barricades.dmi'
	anchored = TRUE
	density = TRUE
	pass_flags_self = LETPASSTHROW
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
	pass_flags_self = PASSTABLE | LETPASSTHROW
	climbable = TRUE

/obj/structure/obstacle/old_locked_door
	name = "old locked door"
	desc = "Key long lost, lock rusted shut. Apply violence to gain entry."
	icon_state = "locked"
	opacity = TRUE
	pass_flags_self = FALSE

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
	pass_flags_self = PASSTABLE | LETPASSTHROW
	var/slowdown = 40
	var/buildstacktype = /obj/item/stack/rods
	var/buildstackamount = 5

/obj/structure/obstacle/barbedwire/end
	icon_state = "barbed_end"

/obj/structure/obstacle/barbedwire/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, 20, 30, 100, CALTROP_BYPASS_SHOES)

/obj/structure/obstacle/barbedwire/wirecutter_act(mob/user, obj/item/tool)
	user.visible_message(span_warning("[user] cuts apart [src]."), span_notice("You start to cut apart [src]."), "You hear cutting.")
	if(tool.use_tool(src, user, 4 SECONDS, volume=50))
		deconstruct(TRUE)
		playsound(src.loc, 'sound/items/deconstruct.ogg', 50, 1)
	return TRUE

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
	plane = MOB_PLANE
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
	pass_flags_self = LETPASSTHROW
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
	name = "Pre-Fall electronic junk"
	desc = "Broken, a useless relic of the past."
	icon_state = "junk_tv"

/obj/structure/junk/small/prefalltv
	desc = "This is a Pre-Fall television made with modern technology."
	icon = 'icons/fallout/objects/decorations.dmi'
	icon_state = "television"
	name = "Pre-Fall television"
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
	
/obj/effect/overlay/junk/wrench_act(mob/user, obj/item/tool)
	if(tool.use_tool(src, user, 30, volume=100))
		to_chat(user, span_notice("You dismantle the junk."))
		qdel(src)
	return TRUE

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

#undef SINGLE
#undef VERTICAL
#undef HORIZONTAL

#undef METAL
#undef WOOD
#undef SAND
