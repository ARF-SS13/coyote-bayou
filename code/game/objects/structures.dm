/obj/structure
	icon = 'icons/obj/structures.dmi'
	pressure_resistance = 8
	max_integrity = 300
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT
	drag_delay = 0.15 SECONDS
	var/climb_time = 20
	var/climb_stun = 20
	var/climbable = FALSE
	var/mob/living/structureclimber
	var/broken = 0 //similar to machinery's stat BROKEN
	var/barricade = TRUE //set to true to allow projectiles to always pass over it, default false (checks vs density)
	var/proj_pass_rate = 65 //if barricade=1, sets how many projectiles will pass the cover. Lower means stronger cover
	var/max_stuff = 0 //how many items can be salvaged from this structure, if its salvagable
	var/base_stuff = 0 //how many items are guaranteed to be salvaged from this structure, if its salvagable

	var/datum/component/toolable/salvage/salvagecomponent

	layer = BELOW_OBJ_LAYER
	//ricochets on structures commented out for now because there's a lot of structures that /shouldnt/ be ricocheting and those need to be reviewed first
	//flags_1 = DEFAULT_RICOCHET_1
	//flags_ricochet = RICOCHET_HARD
	//ricochet_chance_mod = 0.5

/obj/structure/Initialize()
	. = ..()
	if(smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
		QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)
		icon_state = ""
	GLOB.cameranet.updateVisibility(src)

/obj/structure/Destroy()
	GLOB.cameranet.updateVisibility(src)
	if(smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
		QUEUE_SMOOTH_NEIGHBORS(src)
	return ..()

/obj/structure/ComponentInitialize()
	. = ..()
	if(salvagecomponent)
		AddComponent(salvagecomponent)
		if(max_stuff && base_stuff)
			var/datum/component/toolable/salvage/S = GetComponent(/datum/component/toolable/salvage)
			if(istype(S, /datum/component/toolable/salvage))
				S.max_drops = max_stuff
				S.guaranteed_drops = base_stuff
	

/obj/structure/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	. = ..()
	if(structureclimber && structureclimber != user)
		user.DelayNextAction(CLICK_CD_MELEE)
		user.do_attack_animation(src)
		structureclimber.DefaultCombatKnockdown(40)
		structureclimber.visible_message(span_warning("[structureclimber] has been knocked off [src]."), span_warning("You're knocked off [src]!"), span_warning("You see [structureclimber] get knocked off [src]."))

/obj/structure/ui_act(action, params)
	. = ..()
	add_fingerprint(usr)

/obj/structure/MouseDrop_T(atom/movable/O, mob/user)
	. = ..()
	if(!climbable)
		return
	if(user == O && iscarbon(O))
		var/mob/living/L = O
		if(CHECK_MOBILITY(L, MOBILITY_MOVE))
			climb_structure(user)
			return
	if(!istype(O, /obj/item) || user.get_active_held_item() != O)
		return
	if(iscyborg(user))
		return
	if(!user.dropItemToGround(O))
		return
	if (O.loc != src.loc)
		step(O, get_dir(O, src))

/obj/structure/proc/do_climb(atom/movable/A)
	if(climbable)
		density = FALSE
		. = step(A, (A.loc == loc ? dir : get_dir(A,src.loc)))
		density = TRUE

/obj/structure/proc/climb_structure(mob/living/user)
	src.add_fingerprint(user)
	user.visible_message(span_warning("[user] starts climbing onto [src]."), \
								span_notice("You start climbing onto [src]..."))
	var/adjusted_climb_time = climb_time
	if(user.restrained()) //climbing takes twice as long when restrained.
		adjusted_climb_time *= 2
	if(isalien(user))
		adjusted_climb_time *= 0.25 //aliens are terrifyingly fast
	if(HAS_TRAIT(user, TRAIT_FREERUNNING)) //do you have any idea how fast I am???
		adjusted_climb_time *= 0.25
	structureclimber = user
	if(do_mob(user, user, adjusted_climb_time))
		if(src.loc) //Checking if structure has been destroyed
			if(do_climb(user))
				user.visible_message(span_warning("[user] climbs onto [src]."), \
									span_notice("You climb onto [src]."))
				log_combat(user, src, "climbed onto")
				if(climb_stun && !HAS_TRAIT(user, TRAIT_FREERUNNING))
					user.Stun(climb_stun)
				. = 1
			else
				to_chat(user, span_warning("You fail to climb onto [src]."))
	structureclimber = null

/obj/structure/examine(mob/user)
	. = ..()
	if(!(resistance_flags & INDESTRUCTIBLE))
		if(resistance_flags & ON_FIRE)
			. += span_warning("It's on fire!")
		if(broken)
			. += span_notice("It appears to be broken.")
		var/examine_status = examine_status(user)
		if(examine_status)
			. +=  examine_status

/obj/structure/proc/examine_status(mob/user) //An overridable proc, mostly for falsewalls.
	var/healthpercent = (obj_integrity/max_integrity) * 100
	switch(healthpercent)
		if(50 to 99)
			return  "It looks slightly damaged."
		if(25 to 50)
			return  "It appears heavily damaged."
		if(0 to 25)
			if(!broken)
				return  span_warning("It's falling apart!")

/obj/structure/rust_heretic_act()
	take_damage(500, BRUTE, "melee", 1)

/obj/structure/CanAllowThrough(atom/movable/mover, border_dir)
	..()//So bullets will fly over and stuff.
	if(istype(mover, /obj/item/projectile)) // Treats especifically projectiles
		var/obj/item/projectile/proj = mover
		if(proj.firer && Adjacent(proj.firer))
			return 1
		else if(prob(proj_pass_rate))
			return 1
		else if(barricade == FALSE)
			return !density
		else if(density == FALSE)
			return 1
		return 0
	else // All other than projectiles should use the regular CanPass inheritance
		return ..()

// /obj/structure/welder_act(mob/living/user, obj/item/I)
// 	if(!can_salvage)
// 		return ..()
// 	return scrap_it(user, I)

// /obj/structure/proc/scrap_it(mob/living/user, obj/item/I)
// 	if(!can_salvage) //this means that if mappers or admins want an nonharvestable version, set the uses_left to 0
// 		return
// 	if(!user || !user.ckey)
// 		return
// 	if(using_this[user.ckey] == TRUE)
// 		return
// 	if(!I.tool_start_check(user, amount=2)) //this seems to be called everywhere, so for consistency's sake
// 		return
// 	if(!free_spin(user, I, TRUE))
// 		return its_dead(user, I)

// 	using_this[user.ckey] = TRUE
// 	var/turf/usr_turf = get_turf(user) //Bellow are the changes made by Dan
// 	user.visible_message("[user] starts disassembling [src].")
// 	while(made_stuff < max_stuff && !QDELETED(src))
// 		var/welder_akimbo = FALSE
// 		var/obj/item/l = user.get_inactive_held_item()
// 		var/obj/item/weldingtool/WO
// 		if(istype(l,/obj/item/weldingtool))
// 			WO = l
// 			if(WO.tool_start_check(user, amount=2))
// 				welder_akimbo = TRUE
// 		var/salvage_time = disassembly_duration
// 		if(welder_akimbo)
// 			salvage_time /= 1.5
// 		if(!I.use_tool(src, user, salvage_time, volume=75))
// 			user.visible_message("[user] stops disassembling [src].")
// 			break //you did something, like moving, so stop
// 		WO.use(1)
// 		var/fake_dismantle = pick("plating", "rod", "rim", "part of the frame")
// 		user.visible_message("[user] slices through a [fake_dismantle][welder_akimbo ? " with both their welders at once!" : "."]")
// 		made_stuff++
// 		var/scrap_amount = rand(1,4)						//controls basic scrap amount
// 		for(var/i1 in 1 to scrap_amount)
// 			new (usr_turf)
// 		if(prob(30))										//controls chance of advanced scrap
// 			new (usr_turf)
// 		if(prob(5))											//controls chance of high quality tool
// 			new (usr_turf)
// 		var/trash_amount = rand(1,3)						//controls trash amount
// 		for(var/i2 in 1 to (1+trash_amount))
// 			new /obj/effect/spawner/lootdrop/f13/trash(usr_turf)
// 		if(!free_spin(user, I))
// 			return its_dead(user, I)
// 	using_this-= user.ckey

// /obj/structure/proc/its_dead(mob/user, obj/item/I)
// 	visible_message("[src] falls apart, the final components having been removed.")
// 	qdel(src)

// /obj/structure/proc/free_spin(mob/user, obj/item/I, pre_check)
// 	if(pre_check && made_stuff < base_stuff)
// 		return TRUE
// 	if(made_stuff >= max_stuff)
// 		return FALSE
// 	if(made_stuff >= base_stuff)
// 		var/chance_for_extra = 15
// 		if(HAS_TRAIT(user,TRAIT_TECHNOPHREAK))
// 			chance_for_extra += 50
// 		if(made_stuff < max_stuff && prob(chance_for_extra))
// 			to_chat(user, span_green("Your expert salvaging sense lets you spot a bit more usable scrap!"))
// 			return TRUE
// 		else
// 			return FALSE

