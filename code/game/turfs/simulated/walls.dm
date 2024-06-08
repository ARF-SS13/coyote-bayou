#define MAX_DENT_DECALS 15

/turf/closed/wall
	name = "wall"
	desc = "A huge chunk of metal used to separate rooms."
	icon = 'icons/turf/walls/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	explosion_block = 1
	flags_1 = DEFAULT_RICOCHET_1
	flags_ricochet = RICOCHET_HARD
	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 312500 //a little over 5 cm thick , 312500 for 1 m by 2.5 m by 0.25 m plasteel wall
	attack_hand_speed = 8
	attack_hand_is_action = TRUE

	baseturfs = /turf/open/floor/plating

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_WALLS)

	var/hardness = 40 //lower numbers are harder. Used to determine the probability of a hulk smashing through.
	var/slicing_duration = 100  //default time taken to slice the wall
	var/sheet_type = /obj/item/stack/sheet/metal
	var/sheet_amount = 2
	var/girder_type = /obj/structure/girder
	/// Wall breaks on light blast
	var/weak_wall = TRUE
	var/climb_time = 10 SECONDS
	var/stairs_time = 10 SECONDS

	var/list/dent_decals

/*
/turf/closed/wall/Initialize(mapload)
	. = ..()
	if(is_station_level(z))
		GLOB.station_turfs += src
	if(smoothing_flags & SMOOTH_DIAGONAL_CORNERS && fixed_underlay) //Set underlays for the diagonal walls.
		var/mutable_appearance/underlay_appearance = mutable_appearance(layer = TURF_LAYER, plane = FLOOR_PLANE)
		if(fixed_underlay["space"])
			underlay_appearance.icon = 'icons/turf/space.dmi'
			underlay_appearance.icon_state = SPACE_ICON_STATE
			underlay_appearance.plane = PLANE_SPACE
		else
			underlay_appearance.icon = fixed_underlay["icon"]
			underlay_appearance.icon_state = fixed_underlay["icon_state"]
		fixed_underlay = string_assoc_list(fixed_underlay)
		underlays += underlay_appearance


/turf/closed/wall/Destroy()
	if(is_station_level(z))
		GLOB.station_turfs -= src
	return ..()
*/


/turf/closed/wall/examine(mob/user)
	. = ..()
	deconstruction_hints(user)

/turf/closed/wall/proc/deconstruction_hints(mob/user)
	return span_notice("The outer plating is <b>welded</b> firmly in place.")

/turf/closed/wall/attack_tk()
	return

/turf/closed/wall/proc/dismantle_wall(devastated=0, explode=0)
	if(devastated)
		devastate_wall()
	else
		playsound(src, 'sound/items/welder.ogg', 100, 1)
		var/newgirder = break_wall()
		if(newgirder) //maybe we don't /want/ a girder!
			transfer_fingerprints_to(newgirder)

	for(var/obj/O in src.contents) //Eject contents!
		if(istype(O, /obj/structure/sign/poster))
			var/obj/structure/sign/poster/P = O
			P.roll_and_drop(src)

	ScrapeAway()

/turf/closed/wall/proc/break_wall()
	if(sheet_type)
		new sheet_type(src, sheet_amount)
	if(girder_type)
		return new girder_type(src)

/turf/closed/wall/proc/devastate_wall()
	if(sheet_type)
		new sheet_type(src, sheet_amount)
	if(girder_type)
		new /obj/item/stack/sheet/metal(src)

/turf/closed/wall/ex_act(severity, target)
	if(target == src)
		dismantle_wall(1,1)
		return
	switch(severity)
		if(1)
			//SN src = null
			var/turf/NT = ScrapeAway()
			NT.contents_explosion(severity, target)
			return
		if(2)
			if (prob(50))
				dismantle_wall(0,1)
			else
				dismantle_wall(1,1)
		if(3)
			if (weak_wall && prob(hardness))
				dismantle_wall(0,1)
	if(!density)
		..()


/turf/closed/wall/blob_act(obj/structure/blob/B)
	if(prob(50))
		dismantle_wall()
	else
		add_dent(WALL_DENT_HIT)

/turf/closed/wall/mech_melee_attack(obj/mecha/M)
	M.do_attack_animation(src)
	switch(M.damtype)
		if(BRUTE)
			playsound(src, 'sound/weapons/punch4.ogg', 50, 1)
			visible_message(span_danger("[M.name] has hit [src]!"), null, null, COMBAT_MESSAGE_RANGE)
			if(M.force >= hardness*0.8)
				dismantle_wall(1)
				playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)
			else
				add_dent(WALL_DENT_HIT)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 100, 1)
		if(TOX)
			playsound(src, 'sound/effects/spray2.ogg', 100, 1)
			return FALSE

/turf/closed/wall/attack_paw(mob/living/user)
	return attack_hand(user)

/turf/closed/wall/attack_animal(mob/living/simple_animal/M)
	if(!M.CheckActionCooldown(CLICK_CD_MELEE))
		return
	M.DelayNextAction()
	M.do_attack_animation(src)
	if((M.environment_smash & ENVIRONMENT_SMASH_WALLS) || (M.environment_smash & ENVIRONMENT_SMASH_RWALLS))
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)
		dismantle_wall(1)
		return

/turf/closed/wall/attack_hulk(mob/living/carbon/user)
	..()
	var/obj/item/bodypart/arm = user.hand_bodyparts[user.active_hand_index]
	if(!arm)
		return
	if(arm.disabled)
		return
	if(prob(hardness))
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
		user.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ), forced = "hulk")
		//hulk_recoil(arm, user)		// citadel edit - no, hulks are already subject to stamina combat
		dismantle_wall(1)

	else
		playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		add_dent(WALL_DENT_HIT)
		user.visible_message(span_danger("[user] smashes \the [src]!"), \
					span_danger("You smash \the [src]!"), \
					span_hear("You hear a booming smash!"))
	return TRUE

/**
 *Deals damage back to the hulk's arm.
 *
 *When a hulk manages to break a wall using their hulk smash, this deals back damage to the arm used.
 *This is in its own proc just to be easily overridden by other wall types. Default allows for three
 *smashed walls per arm. Also, we use CANT_WOUND here because wounds are random. Wounds are applied
 *by hulk code based on arm damage and checked when we call break_an_arm().
 *Arguments:
 **arg1 is the arm to deal damage to.
 **arg2 is the hulk
 */
/turf/closed/wall/proc/hulk_recoil(obj/item/bodypart/arm, mob/living/carbon/human/hulkman, damage = 20)
	arm.receive_damage(brute = damage, blocked = 0, wound_bonus = CANT_WOUND)
	var/datum/mutation/human/hulk/smasher = locate(/datum/mutation/human/hulk) in hulkman.dna.mutations
	if(!smasher || !damage) //sanity check but also snow and wood walls deal no recoil damage, so no arm breaky
		return
	smasher.break_an_arm(arm)

/turf/closed/wall/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	to_chat(user, span_notice("You push the wall but nothing happens!"))
	playsound(src, 'sound/weapons/genhit.ogg', 25, 1)
	add_fingerprint(user)

/turf/closed/wall/attackby(obj/item/W, mob/user, params)
	if(!user.CheckActionCooldown(CLICK_CD_MELEE))
		return
	if (!user.IsAdvancedToolUser())
		to_chat(user, span_warning("You don't have the dexterity to do this!"))
		return

	//get the user's location
	if(!isturf(user.loc))
		return	//can't do this stuff whilst inside objects and such

	user.DelayNextAction()
	add_fingerprint(user)

	var/turf/T = user.loc	//get user's location for delay checks

	//the istype cascade has been spread among various procs for easy overriding
	var/srctype = type
	if(try_clean(W, user, T) || try_wallmount(W, user, T) || try_decon(W, user, T) || (type == srctype && try_destroy(W, user, T)))
		return

	return ..()

/turf/closed/wall/proc/try_clean(obj/item/W, mob/user, turf/T)
	if((user.a_intent != INTENT_HELP) || !LAZYLEN(dent_decals))
		return FALSE

	if(istype(W, /obj/item/weldingtool))
		if(!W.tool_start_check(user, amount=0))
			return FALSE

		to_chat(user, span_notice("You begin fixing dents on the wall..."))
		if(W.use_tool(src, user, 0, volume=100))
			if(iswallturf(src) && LAZYLEN(dent_decals))
				to_chat(user, span_notice("You fix some dents on the wall."))
				cut_overlay(dent_decals)
				dent_decals.Cut()
			return TRUE

	return FALSE

/turf/closed/wall/proc/try_wallmount(obj/item/W, mob/user, turf/T)
	//check for wall mounted frames
	if(istype(W, /obj/item/wallframe))
		var/obj/item/wallframe/F = W
		if(F.try_build(src, user))
			F.attach(src, user)
		return TRUE
	//Poster stuff
	else if(istype(W, /obj/item/poster))
		place_poster(W,user)
		return TRUE
	//wall mounted IC assembly stuff
	else if(istype(W, /obj/item/electronic_assembly/wallmount))
		var/obj/item/electronic_assembly/wallmount/A = W
		A.mount_assembly(src, user)
		return TRUE
	else if(istype(W, /obj/item/candle/tribal_torch))
		var/obj/item/candle/tribal_torch/torch = W
		torch.do_wallmount(src, user)
		return TRUE

	return FALSE

/turf/closed/wall/proc/try_decon(obj/item/I, mob/user, turf/T)
	if(istype(I, /obj/item/weldingtool) || istype(I, /obj/item/gun/energy/plasmacutter))
		if(!I.tool_start_check(user, amount=0))
			return FALSE

		to_chat(user, span_notice("You begin slicing through the outer plating..."))
		if(I.use_tool(src, user, slicing_duration, volume=100))
			if(iswallturf(src))
				to_chat(user, span_notice("You remove the outer plating."))
				dismantle_wall()
			return TRUE

	return FALSE


/turf/closed/wall/proc/try_destroy(obj/item/I, mob/user, turf/T)
	if(istype(I, /obj/item/pickaxe/drill/jackhammer))
		to_chat(user, span_notice("You begin to smash though [src]..."))
		if(do_after(user, 70, target = src))
			if(!istype(src, /turf/closed/wall))
				return TRUE
			I.play_tool_sound(src)
			visible_message(span_warning("[user] smashes through [src] with [I]!"), span_italic("You hear the grinding of metal."))
			dismantle_wall()
			return TRUE
	return FALSE

/turf/closed/wall/singularity_pull(S, current_size)
	..()
	if(current_size >= STAGE_FIVE)
		if(prob(50))
			dismantle_wall()
		return
	if(current_size == STAGE_FOUR)
		if(prob(30))
			dismantle_wall()

/turf/closed/wall/narsie_act(force, ignore_mobs, probability = 20)
	. = ..()
	if(.)
		ChangeTurf(/turf/closed/wall/mineral/cult)

/*/turf/closed/wall/ratvar_act(force, ignore_mobs)
	. = ..()
	if(.)
		ChangeTurf(/turf/closed/wall/clockwork)

/turf/closed/wall/get_dumping_location(obj/item/storage/source, mob/user)*/
	return null

/turf/closed/wall/acid_act(acidpwr, acid_volume)
	if(explosion_block >= 2)
		acidpwr = min(acidpwr, 50) //we reduce the power so strong walls never get melted.
	. = ..()

/turf/closed/wall/acid_melt()
	dismantle_wall(1)

/turf/closed/wall/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_DECONSTRUCT)
			return list("mode" = RCD_DECONSTRUCT, "delay" = 40, "cost" = 26)
	return FALSE

/turf/closed/wall/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_DECONSTRUCT)
			to_chat(user, span_notice("You deconstruct the wall."))
			ScrapeAway()
			return TRUE
	return FALSE

/turf/closed/wall/proc/add_dent(denttype, x=rand(-8, 8), y=rand(-8, 8))
	if(LAZYLEN(dent_decals) >= MAX_DENT_DECALS)
		return

	var/mutable_appearance/decal = mutable_appearance('icons/effects/effects.dmi', "", BULLET_HOLE_LAYER, ABOVE_WALL_PLANE)
	switch(denttype)
		if(WALL_DENT_SHOT)
			decal.icon_state = "bullet_hole"
		if(WALL_DENT_HIT)
			decal.icon_state = "impact[rand(1, 3)]"

	decal.pixel_x = x
	decal.pixel_y = y

	if(LAZYLEN(dent_decals))
		cut_overlay(dent_decals)
		dent_decals += decal
	else
		dent_decals = list(decal)

	add_overlay(dent_decals)

/turf/closed/wall/rust_heretic_act()
	if(prob(70))
		new /obj/effect/temp_visual/glowing_rune(src)
	ChangeTurf(/turf/closed/wall/rust)

#undef MAX_DENT_DECALS

/turf/closed/wall/AltClick(mob/user)
	. = ..()
	if(can_climb(user))
		return climb_wall(user)

// Free Running perk!
/turf/closed/wall/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/ammo_casing/caseless/rock) || istype(W, /obj/item/ammo_casing/caseless/brick))
		return build_rock_stairs(user, W)
	. = ..()

/turf/closed/wall/proc/can_climb(mob/living/user)
	if(!istype(user))
		return
	if(INTERACTING_WITH(user, src))
		return
	if(user.stat)
		return
	if(!user.can_reach(src)) // Huh, why wasn't this here? I sworn I put this here when I first made this. H m s t v e
		return
	if(user.restrained())
		return
	if(!is_climbable(user))
		to_chat(user, span_alert("You briefly consider climbing the wall, but it is just too perilous to climb! You'd probably fall and break your neck!"))
		return
	return TRUE

/turf/closed/wall/proc/climb_wall(mob/living/user)
	if(!istype(user))
		return
	if(!can_climb(user))
		return
	if(HAS_TRAIT(user, TRAIT_FAT))
		to_chat(user, span_warning("You try to climb up [src], but your big fat gut gets in the way!"))
		return
	var/turf/AboveT = get_step_multiz(get_turf(user), UP)
	var/turf/targetDest = get_step_multiz(get_turf(src), UP)
	if(!can_climb_to(user, targetDest, AboveT))
		return
	var/time_to_climb = climb_time
	if(user.getStaminaLoss() > 0)
		time_to_climb += user.getStaminaLoss() * 0.25 // 25% of your stamina loss will effect the speed on climbing.
	if(HAS_TRAIT(user, TRAIT_FREERUNNING))
		time_to_climb *= 0.25 // Free runners climb 75% faster.
	visible_message(
		span_warning("[user] starts climbing up [name]!"),
		span_notice("You start climbing up [name]!")
	)
	SSweather.add_sound_rock(user, /datum/looping_sound/rockpile)
	var/failed = FALSE
	if(!do_after(user, time_to_climb, TRUE, src, TRUE, public_progbar = TRUE))
		failed = TRUE
	if(!can_climb_to(user, targetDest, AboveT))
		failed = TRUE
		return
	SSweather.remove_sound_rock(user, /datum/looping_sound/rockpile)
	if(failed)
		if(HAS_TRAIT(user, TRAIT_FREERUNNING))
			visible_message(
				span_alert("[user] slips and falls! Shoot!"),
				span_alert("You slip and fall! But, you land on your feet (or whatever it is you use)!"))
		else
			visible_message(
				span_alert("[user] slips and falls flat on their behind! Shoot!"),
				span_alert("You slip and fall! Shoot!"))
			user.DefaultCombatKnockdown(1) // just a lil one
		return
	if(user.zMove(UP, targetDest, z_move_flags = ZMOVE_FLIGHT_FLAGS|ZMOVE_FEEDBACK))
		visible_message(
			span_notice("[user] climbs up [src]!"),
			span_notice("You climb up [src]!"))
		if(!HAS_TRAIT(user, TRAIT_FREERUNNING))
			user.DefaultCombatKnockdown(1, override_stamdmg = 5) // just a lil one

/turf/closed/wall/proc/build_rock_stairs(mob/living/user, obj/item/W)
	if(!istype(user))
		return
	if(!can_climb(user))
		return
	visible_message(
		span_warning("[user] starts piling up rocks against [name]!"),
		span_notice("You begin piling up rocks against [name], trying to build a way up!")
	)
	var/turf/AboveT = get_step_multiz(get_turf(user), UP)
	var/turf/targetDest = get_step_multiz(get_turf(src), UP)
	if(!can_climb_to(user, targetDest, AboveT))
		return
	var/time_to_climb = climb_time
	if(user.getStaminaLoss() > 0)
		time_to_climb += user.getStaminaLoss() * 0.25 // 25% of your stamina loss will effect the speed on climbing.
	if(HAS_TRAIT(user, TRAIT_QUICK_BUILD) || HAS_TRAIT(user, TRAIT_MONKEYLIKE))
		time_to_climb *= 0.50 // Builders and monkes climb 50% faster.
	SSweather.add_sound_rock(user, /datum/looping_sound/rockpile)
	var/failed = FALSE
	if(!do_after(user, time_to_climb, TRUE, src, TRUE, public_progbar = TRUE))
		failed = TRUE
	if(!can_climb_to(user, targetDest, AboveT))
		failed = TRUE
		return
	SSweather.remove_sound_rock(user, /datum/looping_sound/rockpile)
	if(failed)
		visible_message(span_alert("[user]'s pile of stuff falls apart! Shoot!"), span_alert("Your pile of stuff falls apart! Shoot!"))
		return
	var/angle = get_dir(user, src)
	switch(angle)
		if(NORTH)
			if(istype(W, /obj/item/ammo_casing/caseless/brick))
				new /obj/structure/stairs/rockpile/brickpile/north(get_turf(user))
			else
				new /obj/structure/stairs/rockpile/north(get_turf(user))
		if(SOUTH)
			if(istype(W, /obj/item/ammo_casing/caseless/brick))
				new /obj/structure/stairs/rockpile/brickpile/south(get_turf(user))
			else
				new /obj/structure/stairs/rockpile/south(get_turf(user))
		if(EAST)
			if(istype(W, /obj/item/ammo_casing/caseless/brick))
				new /obj/structure/stairs/rockpile/brickpile/east(get_turf(user))
			else
				new /obj/structure/stairs/rockpile/east(get_turf(user))
		if(WEST)
			if(istype(W, /obj/item/ammo_casing/caseless/brick))
				new /obj/structure/stairs/rockpile/brickpile/west(get_turf(user))
			else
				new /obj/structure/stairs/rockpile/west(get_turf(user))
	visible_message(span_notice("[user] stacks a bunch of rocks against [src] as a makeshift staircase!"), span_notice("You stack a bunch of rocks against [src] as a makeshift staircase!"))
	if(istype(W))
		qdel(W)
	return TRUE

/turf/closed/wall/proc/is_climbable(mob/user)
	return TRUE // This is just a placeholder for now. We'll add more stuff later.

/turf/closed/wall/proc/can_climb_to(mob/living/user, turf/targetDest, turf/AboveT)
	var/thingelephant = "something"
	var/ceilingeleephant = "ceiling"
	if(prob(0.1))
		ceilingeleephant = "elephant"
		thingelephant = "an elephant"
	if(!istype(AboveT, /turf/open/transparent/openspace))
		to_chat(user, "You can't get here, there is \a [ceilingeleephant] in the way!") // (0)
		return
	if(istype(targetDest, /turf/open/transparent/openspace))
		to_chat(user, span_warning("There's nothing to stand on up there!"))
		return
	if(istype(targetDest, /turf/closed) || istype(AboveT, /turf/closed))
		to_chat(user, span_warning("On top of the wall seems to be more wall! You can't get up there")) // (1)
		return
	var/list/stuff_to_check = list()
	stuff_to_check |= targetDest.contents
	stuff_to_check |= AboveT.contents
	stuff_to_check |= targetDest
	stuff_to_check |= AboveT
	var/bad
	for(var/atom/A in stuff_to_check)
		if(A.density)
			bad = TRUE
			break
		// if(!A.CanPass(user, get_dir(AboveT, targetDest)))
		// 	bad = TRUE
		// 	break
		// if(!A.CanPass(user, get_dir(AboveT, targetDest)))
		// 	bad = TRUE
		// 	break
		// if(istype(A, /obj/structure) && A.density) // stop climbing into railings and stuff
		// 	bad = TRUE
		// 	break
	if(bad)
		to_chat(user, span_warning("There's [thingelephant] in the way! You can't go there!"))
		return
	return TRUE // If we got here, we can climb!

