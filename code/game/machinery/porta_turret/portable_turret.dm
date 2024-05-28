#define TURRET_STUN 0
#define TURRET_LETHAL 1

#define POPUP_ANIM_TIME 5
#define POPDOWN_ANIM_TIME 5 //Be sure to change the icon animation at the same time or it'll look bad

#define TURRET_LASER_COOLDOWN_TIME 0.5 SECONDS
#define TURRET_SHOOT_DELAY_BASE 1 SECONDS
#define TURRET_BWEEP_COOLDOWN 1 SECONDS
#define TURRET_SCAN_RATE 3 SECONDS
#define TURRET_PREFIRE_DELAY 1 SECONDS

/// Turret is napping and passively scanning the environment at its own pace
#define TURRET_SLEEP_MODE "sleep_mode"
/// Turret is in Alert Mode and actively shooting a visible target
#define TURRET_ALERT_MODE "alert_mode"
/// Turret is in Caution Mode and actively shooting the last place a target was
#define TURRET_CAUTION_MODE "caution_mode"
/// Turret is in Evasion Mode and actively passively (loudly) scanning the environment for targets
#define TURRET_EVASION_MODE "evasion_mode"

/// Turret procesing is OFF
#define TURRET_PROCESS_OFF 0
/// Turret processing is MACHINE
#define TURRET_PROCESS_MACHINE 1
/// Turret processing is FAST
#define TURRET_PROCESS_FAST 2

/// The turret becomes angy at whoever shoots it, regardless of other settings
#define TF_SHOOT_REACTION (1<<0)
/// The turret only shoots people with unauthorized weapons (basically everyone) (currently unused)
#define TF_SHOOT_WEAPONS (1<<1)
/// The turret shoots everything that can be broken. Seriously. (currently unused)
#define TF_SHOOT_EVERYTHING (1<<2)
/// The turret shoots at players
#define TF_SHOOT_PLAYERS (1<<3)
/// The turret shoots at wildlife (ghouls, geckos, etc)
#define TF_SHOOT_WILDLIFE (1<<4)
/// The turret shoots raiders
#define TF_SHOOT_RAIDERS (1<<6)
/// The turret shoots robots (gutsies, handies)
#define TF_SHOOT_ROBOTS (1<<7)
/// Turret ignores faction checks and treats everything is allowed to shoot as hostile
#define TF_IGNORE_FACTION (1<<8)
/// Turret shines a laser at its target
#define TF_USE_LASER_POINTER (1<<9)
/// Turret stays quiet
#define TF_BE_REALLY_LOUD (1<<10)
/// Default utility flags
#define TURRET_DEFAULT_UTILITY TF_USE_LASER_POINTER | TF_BE_REALLY_LOUD | TF_SHOOT_REACTION
/// Default turret targets
#define TURRET_DEFAULT_TARGET_FLAGS TF_SHOOT_PLAYERS | TF_SHOOT_WILDLIFE | TF_SHOOT_RAIDERS | TF_SHOOT_ROBOTS
/// Default turret targets - raider owned turret
#define TURRET_RAIDER_OWNED_FLAGS TF_SHOOT_PLAYERS | TF_SHOOT_WILDLIFE | TF_SHOOT_ROBOTS
/// Default turret targets - robot owned turret
#define TURRET_ROBOT_OWNED_FLAGS TF_SHOOT_PLAYERS | TF_SHOOT_WILDLIFE | TF_SHOOT_RAIDERS
/// Default turret targets - player-domestic turret
#define TURRET_PLAYER_OWNED_FLAGS TF_SHOOT_WILDLIFE | TF_SHOOT_RAIDERS | TF_SHOOT_ROBOTS

/obj/machinery/porta_turret
	name = "turret"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "turretCover"
	layer = OBJ_LAYER
	invisibility = INVISIBILITY_OBSERVER	//the turret is invisible if it's inside its cover
	density = TRUE
	desc = "A covered turret that shoots at its enemies."
	use_power = FALSE //this turret uses and requires power -- no it doesnt~
	idle_power_usage = 50 //when inactive, this turret takes up constant 50 Equipment power
	active_power_usage = 300 //when active, this turret takes up constant 300 Equipment power
	req_access = list(ACCESS_SECURITY) /// Only people with Security access
	power_channel = EQUIP //drains power from the EQUIPMENT channel
	max_integrity = 160 //the turret's health
	integrity_failure = 0.25
	armor = ARMOR_VALUE_HEAVY
	/// Base turret icon state
	base_icon_state = "standard"
	/// Scan range of the turret for locating targets
	var/scan_range = 7
	/// For turrets inside other objects
	var/atom/base = null
	/// If the turret cover is "open" and the turret is raised
	var/raised = FALSE
	/// If the turret is currently opening or closing its cover
	var/raising = FALSE
	/// If the turret's behaviour control access is locked
	var/locked = TRUE
	/// If the turret responds to control panels
	var/controllock = FALSE
	/// The type of weapon installed by default
	var/installation = /obj/item/gun/energy/e_gun/turret
	/// What stored gun is in the turret
	var/obj/item/gun/stored_gun = null
	/// The charge of the gun when retrieved from wreckage
	var/gun_charge = 0
	/// In which mode is turret in, stun or lethal
	var/mode = TURRET_STUN
	/// Stun mode projectile type
	var/stun_projectile = null
	/// Sound of stun projectile
	var/stun_projectile_sound
	/// Lethal mode projectile type
	var/lethal_projectile = null
	/// Sound of lethal projectile
	var/lethal_projectile_sound
	/// Power needed per shot
	var/reqpower = 500
	/// Will stay active
	var/always_up = FALSE
	/// Hides the cover
	var/has_cover = TRUE
	/// The cover that is covering this turret
	var/obj/machinery/porta_turret_cover/cover = null
	/// Turret flags about who is turret allowed to shoot
	var/turret_flags = TURRET_DEFAULT_TARGET_FLAGS | TURRET_DEFAULT_UTILITY
	/// Determines if the turret is on
	var/on = TRUE
	/// Same faction mobs will never be shot at, no matter the other settings
	var/list/faction = list("turret")
	/// The spark system, used for generating... sparks?
	var/datum/effect_system/spark_spread/spark_system
	/// Linked turret control panel of the turret
	var/obj/machinery/turretid/cp = null
	/// The turret will try to shoot from a turf in that direction when in a wall
	var/wall_turret_direction
	/// If the turret is manually controlled
	var/manual_control = FALSE
	/// Action button holder for quitting manual control
	var/datum/action/turret_quit/quit_action
	/// Action button holder for switching between turret modes when manually controlling
	var/datum/action/turret_toggle/toggle_action
	/// Mob that is remotely controlling the turret
	var/mob/remote_controller
	/// MISSING:
	var/shot_stagger = 0
	/// Only try to shoot people at this STAT or lower
	var/maximum_valid_stat = CONSCIOUS
	/// The laserpointer the turret uses' icon
	var/icon/turret_pointer_icon = 'icons/obj/projectiles.dmi'
	/// The laserpointer the turret uses
	var/turret_pointer_state = "red_laser"
	/// Time between being told there's a laser there
	COOLDOWN_DECLARE(turret_laser_pointer_antispam)
	/// Minimum time between shots
	var/shot_delay = TURRET_SHOOT_DELAY_BASE
	/// Cooldown for shooting
	COOLDOWN_DECLARE(turret_refire_delay)
	/// Minimum time between shots
	var/prefire_delay = TURRET_PREFIRE_DELAY
	/// Cooldown for shooting
	COOLDOWN_DECLARE(turret_prefire_delay)
	/// Number of "I scanned" beeps to make
	var/scan_ping_max = 3
	/// Number of "I scanned" beeps left to make
	var/scan_pings_left = 0
	/// Rate the turret will scan for targets
	var/scan_rate = TURRET_SCAN_RATE
	/// Number of bursts to make in caution mode
	var/caution_burst_max = 3
	/// Number of bursts left to make in caution mode
	var/caution_bursts_left = 0
	/// We're in caution mode and beeping every time we scan for something
	var/active_scanning = FALSE
	/// Time between scanning for targets
	COOLDOWN_DECLARE(turret_scan_cooldown)
	/// Noise it makes when it sees someone it doesnt like
	var/target_sound = 'sound/machines/terminal_alert.ogg'
	/// Noise it makes when it scans for targets while interested
	var/scan_ping_sound = 'sound/machines/terminal_emagged.ogg'
	/// Noise it makes when something activates it
	var/wakeup_sound = 'sound/machines/synth_yes.ogg'
	/// Noise it makes when it gets bored and goes to sleep
	var/sleep_sound = 'sound/machines/synth_no.ogg'
	/// Noise it makes when it gets interrupted by someone hitting it
	var/interrupt_sound = 'sound/machines/twobeep.ogg'
	/// Are we awake?
	var/awake = FALSE
	/// The last target we had, so we can shoot while still trying to scan
	var/datum/weakref/last_target
	/// For when we can't see our last target, shoot where they were. Kinda obsess on it, too
	var/datum/weakref/last_target_turf
	/// Number of shots in a burst
	var/burst_count = 1
	/// Delay between burst shots
	var/burst_delay = GUN_BURSTFIRE_DELAY_BASE
	/// Inaccuracy in degrees
	var/shot_spread = 15
	/// The bullet we'll use when we try to shoot. This will override the stun and lethal projectile!
	var/obj/item/ammo_casing/casing_type_lethal
	/// The bullet we'll use when we try to shoot. This will override the stun and lethal projectile!
	var/obj/item/ammo_casing/casing_type_stun
	/// Are we shooting?
	var/am_currently_shooting
	/// did we already drop our loot?
	var/dropped_loot
	/// What state are we in?
	var/activity_state = TURRET_SLEEP_MODE
	/// What processing state are we in?
	var/processing_state
	var/list/stun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(LASER_VOLUME),
		SP_NORMAL_RANGE(LASER_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(LASER_DISTANT_SOUND),
		SP_DISTANT_RANGE(LASER_RANGE_DISTANT)
	)
	var/list/lethal_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(RIFLE_MEDIUM_VOLUME),
		SP_NORMAL_RANGE(RIFLE_MEDIUM_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(RIFLE_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(RIFLE_MEDIUM_RANGE_DISTANT)
	)

/obj/machinery/porta_turret/Initialize()
	. = ..()
	if(!base)
		base = src
	turret_pointer_state = pick("red_laser","green_laser","blue_laser","purple_laser")
	update_icon()
	//Sets up a spark system
	spark_system = new /datum/effect_system/spark_spread
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)
	if(init_process)
		processing_state = TURRET_PROCESS_MACHINE

	setup()
	if(has_cover)
		cover = new /obj/machinery/porta_turret_cover(loc)
		cover.parent_turret = src
		var/mutable_appearance/base = mutable_appearance('icons/obj/turrets.dmi', "basedark")
		base.layer = NOT_HIGH_OBJ_LAYER
		underlays += base
	if(!has_cover)
		INVOKE_ASYNC(src,PROC_REF(popUp))

/obj/machinery/porta_turret/proc/toggle_on(set_to)
	var/current = on
	if (!isnull(set_to))
		on = set_to
	else
		on = !on
	if (current != on)
		check_should_process()
		if (!on)
			popDown()

/obj/machinery/porta_turret/proc/check_should_process()
	if (!on || !anchored || (stat & BROKEN) || !powered())
		//end_processing()
		STOP_PROCESSING(SSfastprocess, src)
		STOP_PROCESSING(SSmachines, src)
		processing_state = TURRET_PROCESS_OFF
		return FALSE
	//START_PROCESSING(SSmachines, src)
	//begin_processing()
	if(activity_state == TURRET_SLEEP_MODE)
		STOP_PROCESSING(SSfastprocess, src)
		START_PROCESSING(SSmachines, src)
		processing_state = TURRET_PROCESS_MACHINE
		return TRUE
	else
		STOP_PROCESSING(SSmachines, src)
		START_PROCESSING(SSfastprocess, src)
		processing_state = TURRET_PROCESS_FAST
		return TRUE

/obj/machinery/porta_turret/update_icon_state()
	if(!anchored)
		icon_state = "turretCover"
		return
	if(stat & BROKEN)
		icon_state = "[base_icon_state]_broken"
	else
		if(powered())
			if(on && raised)
				switch(mode)
					if(TURRET_STUN)
						icon_state = "[base_icon_state]_stun"
					if(TURRET_LETHAL)
						icon_state = "[base_icon_state]_lethal"
			else
				icon_state = "[base_icon_state]_off"
		else
			icon_state = "[base_icon_state]_unpowered"

/obj/machinery/porta_turret/proc/setup(obj/item/gun/turret_gun)
	if(!stored_gun)
		return
	if(stored_gun)
		qdel(stored_gun)
		stored_gun = null

	if(installation && !turret_gun)
		stored_gun = new installation(src)
	else if (turret_gun)
		stored_gun = turret_gun

	var/list/gun_properties = stored_gun.get_turret_properties()

	//required properties
	stun_projectile = gun_properties["stun_projectile"]
	stun_projectile_sound = gun_properties["stun_projectile_sound"]
	lethal_projectile = gun_properties["lethal_projectile"]
	lethal_projectile_sound = gun_properties["lethal_projectile_sound"]
	base_icon_state = gun_properties["base_icon_state"]

	//optional properties
	if(gun_properties["shot_delay"])
		shot_delay = gun_properties["shot_delay"]
	if(gun_properties["reqpower"])
		reqpower = gun_properties["reqpower"]

	update_icon()
	return gun_properties

/obj/machinery/porta_turret/Destroy()
	//deletes its own cover with it
	QDEL_NULL(cover)
	base = null
	if(cp)
		cp.turrets -= src
		cp = null
	QDEL_NULL(stored_gun)
	QDEL_NULL(spark_system)
	remove_control()
	return ..()

/obj/machinery/porta_turret/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PortableTurret", name)
		ui.open()

/obj/machinery/porta_turret/ui_data(mob/user)
	var/list/data = list(
		"locked" = locked,
		"on" = on,
		"turret_shoot_weapons" = turret_flags & TF_SHOOT_WEAPONS,
		"turret_shoot_wildlife" = turret_flags & TF_SHOOT_WILDLIFE,
		"turret_shoot_all" = turret_flags & TF_SHOOT_EVERYTHING,
		"turret_shoot_players" = turret_flags & TF_SHOOT_PLAYERS,
		"turret_shoot_raiders" = turret_flags & TF_SHOOT_RAIDERS,
		"turret_shoot_robots" = turret_flags & TF_SHOOT_ROBOTS,
		"turret_shoot_ignore_faction" = turret_flags & TF_IGNORE_FACTION,
		"turret_use_laser_pointer" = turret_flags & TF_USE_LASER_POINTER,
		"turret_make_noise" = turret_flags & TF_BE_REALLY_LOUD,
		"manual_control" = manual_control,
		"silicon_user" = FALSE,
		"allow_manual_control" = FALSE,
		"lasertag_turret" = istype(src, /obj/machinery/porta_turret/lasertag),
	)
	if(issilicon(user))
		data["silicon_user"] = TRUE
		if(!manual_control)
			var/mob/living/silicon/S = user
			if(S.hack_software)
				data["allow_manual_control"] = TRUE
	return data

/obj/machinery/porta_turret/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("power")
			if(anchored)
				toggle_on()
			else
				to_chat(usr, span_warning("It has to be secured first!"))
				return TRUE
		if("turret_return_shoot_weapons")
			turret_flags ^= TF_SHOOT_WEAPONS
		if("turret_return_shoot_wildlife")
			turret_flags ^= TF_SHOOT_WILDLIFE
		if("turret_return_shoot_everything")
			turret_flags ^= TF_SHOOT_EVERYTHING
		if("turret_return_shoot_players")
			turret_flags ^= TF_SHOOT_PLAYERS
		if("turret_return_shoot_raiders")
			turret_flags ^= TF_SHOOT_RAIDERS
		if("turret_return_shoot_robots")
			turret_flags ^= TF_SHOOT_ROBOTS
		if("turret_return_ignore_faction")
			turret_flags ^= TF_IGNORE_FACTION
		if("turret_return_use_laser_pointer")
			turret_flags ^= TF_USE_LASER_POINTER
		if("turret_return_make_noise")
			turret_flags ^= TF_BE_REALLY_LOUD
		if("manual")
			if(!issilicon(usr))
				return
			give_control(usr)
	if(turret_flags & TF_BE_REALLY_LOUD)
		playsound(get_turf(src), 'sound/machines/terminal_prompt_confirm.ogg', 100, FALSE, 0, ignore_walls = TRUE)

/obj/machinery/porta_turret/ui_host(mob/user)
	if(has_cover && cover)
		return cover
	if(base)
		return base
	return src

/obj/machinery/porta_turret/power_change()
	. = ..()
	if(!anchored || (stat & BROKEN) || !powered())
		update_icon()
		remove_control()
	check_should_process()

/obj/machinery/porta_turret/attackby(obj/item/I, mob/user, params)
	if(stat & BROKEN)
		if(istype(I, /obj/item/crowbar))
			//If the turret is destroyed, you can remove it with a crowbar to
			//try and salvage its components
			to_chat(user, span_notice("You begin prying the metal coverings off..."))
			if(I.use_tool(src, user, 20))
				drop_loot(I, user)
				qdel(src)
				return

	else if((istype(I, /obj/item/wrench)) && (!on))
		if(raised)
			return

		//This code handles moving the turret around. After all, it's a portable turret!
		if(!anchored && !isinspace())
			setAnchored(TRUE)
			invisibility = INVISIBILITY_MAXIMUM
			update_icon()
			to_chat(user, span_notice("You secure the exterior bolts on the turret."))
			if(has_cover)
				cover = new /obj/machinery/porta_turret_cover(loc) //create a new turret. While this is handled in process(), this is to workaround a bug where the turret becomes invisible for a split second
				cover.parent_turret = src //make the cover's parent src
		else if(anchored)
			setAnchored(FALSE)
			to_chat(user, span_notice("You unsecure the exterior bolts on the turret."))
			power_change()
			invisibility = 0
			qdel(cover) //deletes the cover, and the turret instance itself becomes its own cover.

	else if(I.GetID())
		//Behavior lock/unlock mangement
		if(allowed(user))
			locked = !locked
			to_chat(user, span_notice("Controls are now [locked ? "locked" : "unlocked"]."))
		else
			to_chat(user, span_alert("Access denied."))
	else if(istype(I, /obj/item/multitool) && !locked)
		if(!multitool_check_buffer(user, I))
			return
		var/obj/item/multitool/M = I
		M.buffer = src
		to_chat(user, span_notice("You add [src] to multitool buffer."))
	else
		return ..()

/obj/machinery/porta_turret/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	to_chat(user, span_warning("You short out [src]'s threat assessment circuits."))
	audible_message(span_hear("[src] hums oddly..."))
	obj_flags |= EMAGGED
	controllock = TRUE
	toggle_on(FALSE) //turns off the turret temporarily
	update_icon()
	//6 seconds for the traitor to gtfo of the area before the turret decides to ruin his shit
	addtimer(CALLBACK(src,PROC_REF(toggle_on), TRUE), 6 SECONDS)
	//turns it back on. The cover popUp() popDown() are automatically called in process(), no need to define it here

/obj/machinery/porta_turret/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return
	if(on)
		//if the turret is on, the EMP no matter how severe disables the turret for a while
		//and scrambles its settings, with a slight chance of having an emag effect
		if(prob(50))
			turret_flags |= TF_SHOOT_WILDLIFE
		if(prob(50))
			turret_flags |= TF_SHOOT_WEAPONS
		if(prob(20))
			turret_flags |= TF_SHOOT_EVERYTHING

		toggle_on(FALSE)
		remove_control()

		addtimer(CALLBACK(src,PROC_REF(toggle_on), TRUE), rand(60,600))

/obj/machinery/porta_turret/take_damage(damage, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, atom/attacked_by)
	. = ..()
	if(. && obj_integrity > 0) //damage received
		spark_system.start()
		if(on && (turret_flags & TF_SHOOT_REACTION) && ismob(attacked_by))
			var/mob/thing_hit_us = attacked_by
			if(!in_faction(thing_hit_us) || CHECK_BITFIELD(turret_flags, TF_IGNORE_FACTION))
				interrupt_and_set_to_alert(attacked_by)

/// dumps loot all over the place
/obj/machinery/porta_turret/proc/drop_loot(obj/item/I, mob/user)
	if(dropped_loot)
		return
	var/turf/right_here = get_turf(src)
	if(!isturf(right_here))
		return
	if(user)
		to_chat(user, span_notice("You remove the turret and salvage some components."))
	if(stored_gun)
		stored_gun.forceMove(right_here)
		stored_gun = null
	new /obj/item/stack/sheet/metal(right_here, rand(10,15))
	new /obj/item/stack/crafting/metalparts(right_here, rand(2,3))
	new /obj/item/stack/crafting/goodparts(right_here, rand(1,2))
	new /obj/item/stack/crafting/electronicparts(right_here, rand(4,6))
	new /obj/item/stack/cable_coil(right_here, rand(15,20))
	if(prob(80))
		new /obj/item/assembly/prox_sensor(right_here)
	if(prob(80))
		new /obj/item/assembly/prox_sensor(right_here)
	var/num_salvage_to_make = 1
	if(user && HAS_TRAIT(user, TRAIT_TECHNOPHREAK))
		num_salvage_to_make++
	for(var/loots in 1 to num_salvage_to_make)
		switch(rand(1,10))
			if(1 to 5)
				new /obj/item/salvage/low(right_here)
			if(6)
				new /obj/item/salvage/tool(right_here)
			if(7 to 10)
				new /obj/item/salvage/high(right_here)
	dropped_loot = TRUE

/obj/machinery/porta_turret/proc/reset_attacked()
	turret_flags &= ~TF_SHOOT_REACTION

/obj/machinery/porta_turret/deconstruct(disassembled = TRUE)
	playsound(get_turf(src), 'sound/weapons/machine_crunch.ogg', 80, 1, SOUND_DISTANCE(10), ignore_walls = TRUE)
	drop_loot(null, null)
	qdel(src)

/obj/machinery/porta_turret/obj_break(damage_flag)
	. = ..()
	if(.)
		playsound(get_turf(src), 'sound/machines/machinery_break_1.ogg', 80, 1, SOUND_DISTANCE(10), ignore_walls = TRUE)
		power_change()
		invisibility = 0
		spark_system.start()	//creates some sparks because they look cool
		qdel(cover)	//deletes the cover - no need on keeping it there!

/obj/machinery/porta_turret/process()
	//the main machinery process
	if(cover == null && anchored)	//if it has no cover and is anchored
		if(stat & BROKEN)	//if the turret is borked
			qdel(cover)	//delete its cover, assuming it has one. Workaround for a pesky little bug
			return
		else
			if(has_cover)
				cover = new /obj/machinery/porta_turret_cover(loc)	//if the turret has no cover and is anchored, give it a cover
				cover.parent_turret = src	//assign the cover its parent_turret, which would be this (src)

	if(!on || (stat & (NOPOWER|BROKEN)) || manual_control)
		return

	if(!check_should_process())
		return
	/// We dont have a target, look for targets. If we just got out of shooting, beep while scanning for a while
	if(activity_state == TURRET_SLEEP_MODE || activity_state == TURRET_EVASION_MODE)
		if(scan_for_targets())
			change_activity_state(TURRET_ALERT_MODE)
		else
			return

	/// We can see our target, start blasting
	if(activity_state == TURRET_ALERT_MODE)
		record_target_weakref(GET_WEAKREF(last_target)) // Update our target and turf's position every time we process
		INVOKE_ASYNC(src,PROC_REF(shine_laser_pointer)) // lazer
		if(!can_see_target()) // If we cant see the target, go into caution mode
			change_activity_state(TURRET_CAUTION_MODE)
		else
			INVOKE_ASYNC(src,PROC_REF(open_fire_on_target))
	
	/// We lost sight of our target, shoot where we last saw them
	if(activity_state == TURRET_CAUTION_MODE)
		if(can_see_target())
			change_activity_state(TURRET_ALERT_MODE)
		INVOKE_ASYNC(src,PROC_REF(shine_laser_pointer))
		INVOKE_ASYNC(src,PROC_REF(open_fire_on_target))
		if(!caution_bursts_left)
			change_activity_state(TURRET_EVASION_MODE)

/// Interrupts our current mode, and sets it to alert
/// For when something hits it and it needs to retaliate
/obj/machinery/porta_turret/proc/interrupt_and_set_to_alert(atom/assailant)
	clear_targets()
	record_target_weakref(assailant)
	if(!last_target && !last_target_turf)
		change_activity_state(TURRET_SLEEP_MODE, TRUE)
		return
	if(turret_flags & TF_BE_REALLY_LOUD)
		playsound(get_turf(src), interrupt_sound, 100, FALSE, SOUND_DISTANCE(scan_range + 5), ignore_walls = TRUE)
	change_activity_state(TURRET_ALERT_MODE, TRUE)
	
/// Interrupts our current mode, and sets it to evasion
/// For when our target is downed
/obj/machinery/porta_turret/proc/interrupt_and_set_to_evasion()
	clear_targets()
	change_activity_state(TURRET_EVASION_MODE, TRUE)
	
/// Changes our mode to another, and does a thing
/obj/machinery/porta_turret/proc/change_activity_state(new_state, force_it)
	if(new_state == activity_state && !force_it)
		return
	switch(new_state)
		if(TURRET_SLEEP_MODE)
			enter_sleep_mode()
		if(TURRET_ALERT_MODE)
			enter_alert_mode()
		if(TURRET_CAUTION_MODE)
			enter_caution_mode()
		if(TURRET_EVASION_MODE)
			enter_evasion_mode()
	activity_state = new_state
	check_should_process()

/// Clears the cooldowns =3
/obj/machinery/porta_turret/proc/clear_cooldowns()
	COOLDOWN_RESET(src, turret_laser_pointer_antispam)
	COOLDOWN_RESET(src, turret_refire_delay)
	COOLDOWN_RESET(src, turret_prefire_delay)
	COOLDOWN_RESET(src, turret_scan_cooldown)

/// Scans for targets. If we're in evasion mode, also beep
/obj/machinery/porta_turret/proc/scan_for_targets()
	if(COOLDOWN_TIMELEFT(src, turret_scan_cooldown))
		return
	COOLDOWN_START(src, turret_scan_cooldown, scan_rate)
	if(activity_state == TURRET_EVASION_MODE)
		if(scan_pings_left)
			if(turret_flags & TF_BE_REALLY_LOUD)
				playsound(get_turf(src), scan_ping_sound, 100, FALSE, SOUND_DISTANCE(scan_range + 5), ignore_walls = TRUE)
			scan_pings_left--
		else
			change_activity_state(TURRET_SLEEP_MODE)
	if(activity_state == TURRET_ALERT_MODE || activity_state == TURRET_CAUTION_MODE)
		return

	var/list/maybetargets = oview(scan_range, base)
	var/list/scanned = list()
	var/safety = 20000
	while(maybetargets.len && safety--)
		var/atom/movable/potarget = LAZYACCESS(maybetargets, maybetargets.len)
		maybetargets -= potarget
		if(!ismovable(potarget))
			continue
		if(potarget.contents && !(potarget in scanned))
			maybetargets += potarget.contents
		scanned += potarget
		if(!isliving(potarget))
			continue
		var/mob/living/potential_target = potarget
		/// get the basic checks out of the way first
		if(potential_target.invisibility > SEE_INVISIBLE_LIVING)
			continue
		/// Ignore dying targets
		if(potential_target.stat > maximum_valid_stat)
			continue
		// Ignore stamcritted targets
		if(maximum_valid_stat == CONSCIOUS && IS_STAMCRIT(potential_target))
			continue
		/// If it cares about faction, and the thing's your faction, skip it
		if(!(turret_flags & TF_IGNORE_FACTION))
			if(in_faction(potential_target))
				continue
		/// If its got a client, add it
		if(turret_flags & TF_SHOOT_PLAYERS)
			if(potential_target.client)
				record_target_weakref(potential_target)
				return TRUE
		/// If if its an animal (or ghoul), add it
		if(turret_flags & TF_SHOOT_WILDLIFE)
			if(issimplewildlife(potential_target))
				record_target_weakref(potential_target)
				return TRUE
		/// If if its a raider, or some kind of vaguely intelligent humanlike, add it
		if(turret_flags & TF_SHOOT_RAIDERS)
			if(issimplehumanlike(potential_target))
				record_target_weakref(potential_target)
				return TRUE
		/// If if its a robot, add it
		if(turret_flags & TF_SHOOT_ROBOTS)
			if(issimplerobot(potential_target))
				record_target_weakref(potential_target)
				return TRUE

/// Can we see the target?
/obj/machinery/porta_turret/proc/can_see_target()
	if(!last_target)
		return FALSE
	var/atom/seeable_target = GET_WEAKREF(last_target)
	if(!seeable_target)
		return FALSE
	for(var/turf/T in getline(get_turf(src),get_turf(seeable_target)))
		if(T.opacity)
			return FALSE
	return TRUE

/// Enter alert mode!
/obj/machinery/porta_turret/proc/enter_alert_mode()
	clear_cooldowns()
	COOLDOWN_START(src, turret_prefire_delay, prefire_delay)
	awake = TRUE
	popUp()
	if(turret_flags & TF_BE_REALLY_LOUD)
		playsound(get_turf(src), target_sound, 100, FALSE, SOUND_DISTANCE(scan_range + 5), ignore_walls = TRUE) // angry bweep
	var/mob/our_target = GET_WEAKREF(last_target)
	if(!istype(our_target))
		return
	our_target.visible_message(
		span_alert("[src] swivels its gun around to face <b>[our_target]</b>!"),
		span_userdanger("[src] suddenly aims at you!"),
		span_alert("You hear mechanical whirring!")
		)

/// caution mode is mostly handled elsewhere
/obj/machinery/porta_turret/proc/enter_caution_mode()
	caution_bursts_left = caution_burst_max
	return

/// Set up the beeps
/obj/machinery/porta_turret/proc/enter_evasion_mode()
	clear_cooldowns()
	scan_pings_left = scan_ping_max
	caution_bursts_left = 0
	visible_message(span_alert("[src] deploys its active sensors!"))
	if(turret_flags & TF_BE_REALLY_LOUD)
		playsound(get_turf(src), wakeup_sound, 100, FALSE, SOUND_DISTANCE(scan_range + 5), ignore_walls = TRUE)

/// telll everyone we're going to sleep
/obj/machinery/porta_turret/proc/enter_sleep_mode()
	clear_cooldowns()
	clear_targets()
	scan_pings_left = 0
	awake = FALSE
	popDown()
	if(turret_flags & TF_BE_REALLY_LOUD)
		playsound(get_turf(src), sleep_sound, 100, FALSE, SOUND_DISTANCE(scan_range + 5), ignore_walls = TRUE)
	visible_message(span_alert("[src] retracts its active sensors and goes into passive scanning mode!"))

/// clears our targets
/obj/machinery/porta_turret/proc/clear_targets()
	last_target = null
	last_target_turf = null

/// Points a laser at something
/// Kinda ignores line of sight
/obj/machinery/porta_turret/proc/shine_laser_pointer()
	if(!(turret_flags & TF_USE_LASER_POINTER))
		return
	if(COOLDOWN_TIMELEFT(src, turret_laser_pointer_antispam))
		return
	var/turf/where_to_shine = get_turf(activity_state == TURRET_CAUTION_MODE ? GET_WEAKREF(last_target_turf) : GET_WEAKREF(last_target))
	if(!isturf(where_to_shine))
		return
	var/image/I = image(turret_pointer_icon, where_to_shine, turret_pointer_state, -10)
	I.pixel_x = rand(-5,5)
	I.pixel_y = rand(-5,5)
	flick_overlay_view(I, where_to_shine, TURRET_LASER_COOLDOWN_TIME*2)
	COOLDOWN_START(src, turret_laser_pointer_antispam, TURRET_LASER_COOLDOWN_TIME)

/obj/machinery/porta_turret/proc/popUp()	//pops the turret up
	if(!anchored)
		return
	if(raising || raised)
		return
	if(stat & BROKEN)
		return
	invisibility = 0
	raising = 1
	if(cover)
		flick("popup", cover)
	sleep(POPUP_ANIM_TIME)
	raising = 0
	if(cover)
		cover.icon_state = "openTurretCover"
	raised = 1
	layer = MOB_LAYER

/obj/machinery/porta_turret/proc/popDown()	//pops the turret down
	if(raising || !raised)
		return
	if(stat & BROKEN)
		return
	layer = OBJ_LAYER
	raising = 1
	if(cover)
		flick("popdown", cover)
	sleep(POPDOWN_ANIM_TIME)
	raising = 0
	if(cover)
		cover.icon_state = "turretCover"
	raised = 0
	invisibility = 2
	update_icon()

/// Unused (would pretty much always return true, cus everyone's armed)
/obj/machinery/porta_turret/proc/assess_perp(mob/living/carbon/human/perp)
	var/threatcount = 0	//the integer returned

	if(obj_flags & EMAGGED)
		return 10	//if emagged, always return 10.

	if((turret_flags & (TF_SHOOT_EVERYTHING | TF_SHOOT_REACTION)) && !allowed(perp))
		//if the turret has been attacked or is angry, target all non-sec people
		return 10

	if(isnull(perp.wear_id) || istype(perp.wear_id.GetID(), /obj/item/card/id/syndicate))
		if(allowed(perp)) //if the perp has security access, return 0
			return 0
		if(perp.is_holding_item_of_type(/obj/item/gun) ||  perp.is_holding_item_of_type(/obj/item/melee/baton))
			threatcount += 4
		if(istype(perp.belt, /obj/item/gun) || istype(perp.belt, /obj/item/melee/baton))
			threatcount += 2

	return threatcount

/// Checks if the target is in the turret's faction
/obj/machinery/porta_turret/proc/in_faction(mob/target)
	for(var/faction1 in faction)
		if(faction1 in target.faction)
			return TRUE
	return FALSE

/// Records our target's weakref, and their turf's weakref
/// Defaults to whatever's being targetttttttttttttttttted
/obj/machinery/porta_turret/proc/record_target_weakref(atom/new_target, just_turf)
	if(!new_target)
		new_target = GET_WEAKREF(last_target)
	var/turf/target_turf = get_turf(new_target)
	if(isturf(target_turf))
		last_target_turf = WEAKREF(target_turf)
	if(just_turf)
		return
	last_target = WEAKREF(new_target)

/// Read our stored weakref targets, pick if we're aiming at the mob or their last turf
/// then pass that to start_shooting to start shooting at it
/// If passed a target, it'll try to shoot at that target. Mainly used for direct control
/obj/machinery/porta_turret/proc/open_fire_on_target(atom/forced_target)
	if(istype(forced_target))
		record_target_weakref(forced_target)
	if((!last_target && !last_target_turf))
		return FALSE
	var/turf/target_turf = get_turf(activity_state == TURRET_CAUTION_MODE ? GET_WEAKREF(last_target_turf) : GET_WEAKREF(last_target))
	if(!istype(target_turf))
		return FALSE
	setDir(get_dir(base, target_turf)) //even if you can't shoot, follow the target
	if(COOLDOWN_TIMELEFT(src, turret_prefire_delay))
		return
	if(COOLDOWN_TIMELEFT(src, turret_refire_delay))
		return
	if(am_currently_shooting)
		return TRUE

	var/turf/our_turf = get_turf(src)
	if(!istype(our_turf))
		return

	//Wall turrets will try to find adjacent empty turf to shoot from to cover full arc
	if(our_turf.density)
		if(wall_turret_direction)
			var/turf/closer = get_step(our_turf,wall_turret_direction)
			if(istype(closer) && !is_blocked_turf(closer) && our_turf.Adjacent(closer))
				our_turf = closer
		else
			var/target_dir = get_dir(our_turf,target_turf)
			for(var/d in list(0,-45,45))
				var/turf/closer = get_step(our_turf,turn(target_dir,d))
				if(istype(closer) && !is_blocked_turf(closer) && our_turf.Adjacent(closer))
					our_turf = closer
					break

	update_icon()

	COOLDOWN_START(src, turret_refire_delay, shot_delay)
	am_currently_shooting = TRUE
	for(var/burst in 1 to burst_count)
		setDir(get_dir(base, target_turf))
		if(shoot_at_target(target_turf, our_turf))
			sleep(burst_delay)
		else
			interrupt_and_set_to_evasion()
			am_currently_shooting = FALSE
			caution_bursts_left = 0
			return FALSE
	am_currently_shooting = FALSE
	if(caution_bursts_left)
		caution_bursts_left--
	if(forced_target)
		clear_targets()
	return TRUE

/// Fires one shot at the target -- but only if they're okay
/// typically only fed a turf, so if nyou're gonna ncheck for nmobs, locate them on the turf
/obj/machinery/porta_turret/proc/shoot_at_target(atom/movable/target, turf/our_turf)
	if(!target || !our_turf)
		return FALSE
	target = turf_has_valid_target(get_turf(target))
	if(!target)
		return FALSE
	if(mode == TURRET_STUN)
		//use_power(reqpower)
		playsound(
			src,
			stun_projectile_sound,
			stun_sound_properties[SOUND_PROPERTY_VOLUME],
			stun_sound_properties[SOUND_PROPERTY_VARY],
			stun_sound_properties[SOUND_PROPERTY_NORMAL_RANGE],
			ignore_walls = stun_sound_properties[SOUND_PROPERTY_IGNORE_WALLS],
			distant_sound = stun_sound_properties[SOUND_PROPERTY_DISTANT_SOUND],
			distant_range = stun_sound_properties[SOUND_PROPERTY_DISTANT_SOUND_RANGE]
			)
	else
		//use_power(reqpower * 2)
		playsound(
			src,
			lethal_projectile_sound,
			lethal_sound_properties[SOUND_PROPERTY_VOLUME],
			lethal_sound_properties[SOUND_PROPERTY_VARY],
			lethal_sound_properties[SOUND_PROPERTY_NORMAL_RANGE],
			ignore_walls = lethal_sound_properties[SOUND_PROPERTY_IGNORE_WALLS],
			distant_sound = lethal_sound_properties[SOUND_PROPERTY_DISTANT_SOUND],
			distant_range = lethal_sound_properties[SOUND_PROPERTY_DISTANT_SOUND_RANGE]
			)

	var/the_spread = rand(-shot_spread, shot_spread)
	if(casing_type_lethal)
		var/obj/item/ammo_casing/casing
		if(mode == TURRET_STUN)
			casing = new casing_type_stun(our_turf)
		else
			casing = new casing_type_lethal(our_turf)
		if(!casing)
			return FALSE
		casing.BB?.factionize(faction)
		casing.fire_casing(
			target = target,
			user = src,
			params = null,
			distro = shot_spread,
			quiet = null,
			zone_override = ran_zone(),
			spread = the_spread,
			damage_multiplier = null,
			penetration_multiplier = null,
			projectile_speed_multiplier = null,
			fired_from = src
			)
		qdel(casing)
	else
		var/obj/item/projectile/turret_projectile
		if(mode == TURRET_STUN)
			turret_projectile = new stun_projectile(our_turf)
		else
			turret_projectile = new lethal_projectile(our_turf)
		turret_projectile.factionize(faction)
		turret_projectile.preparePixelProjectile(target, our_turf, spread = the_spread)
		turret_projectile.firer = src
		turret_projectile.fired_from = src
		turret_projectile.fire()
	return TRUE

/// Checks if someone on the turf is okay to shoot
/// Returns true if someone in the turf is alive and well
/// Also returns true if nobody's on the turf
/// otherwise it returns false and interrupts the shooting loop
/// oh yeah it returns the mob on the turf if it finds a shootable one
/// and the turf if nobody's on the turf
/// basically throw a corpse at the dot to make it think ur dead
/obj/machinery/porta_turret/proc/turf_has_valid_target(turf/the_turf)
	var/turf_has_nobody_on_it = TRUE
	for(var/mob/living/person in the_turf.contents)
		turf_has_nobody_on_it = FALSE
		if(person.health <= 0)
			continue // Stop stop, its probably dead!
		if(person.stat > maximum_valid_stat)
			continue // Stop stop, he's already asleep!
		if(IS_STAMCRIT(person))
			continue // Stop stop, he's stamcritted to shit!
		return person
	return turf_has_nobody_on_it ? the_turf : null

/obj/machinery/porta_turret/proc/setState(on, mode)
	if(controllock)
		return

	//shoot_cyborgs ? (turret_flags |= TF_SHOOT_ROBOTS) : (turret_flags &= ~TF_SHOOT_ROBOTS)
	toggle_on(on)
	src.mode = mode
	power_change()

/datum/action/turret_toggle
	name = "Toggle Mode"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_cycle_equip_off"

/datum/action/turret_toggle/Trigger()
	var/obj/machinery/porta_turret/P = target
	if(!istype(P))
		return
	P.setState(P.on,!P.mode)

/datum/action/turret_quit
	name = "Release Control"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_eject"

/datum/action/turret_quit/Trigger()
	var/obj/machinery/porta_turret/P = target
	if(!istype(P))
		return
	P.remove_control(FALSE)

/obj/machinery/porta_turret/proc/give_control(mob/A)
	if(manual_control || !can_interact(A))
		return FALSE
	remote_controller = A
	if(!quit_action)
		quit_action = new(src)
	quit_action.Grant(remote_controller)
	if(!toggle_action)
		toggle_action = new(src)
	toggle_action.Grant(remote_controller)
	remote_controller.reset_perspective(src)
	remote_controller.click_intercept = src
	manual_control = TRUE
	always_up = TRUE
	popUp()
	return TRUE

/obj/machinery/porta_turret/proc/remove_control(warning_message = TRUE)
	if(!manual_control)
		return FALSE
	if(remote_controller)
		if(warning_message)
			to_chat(remote_controller, span_warning("Your uplink to [src] has been severed!"))
		quit_action.Remove(remote_controller)
		toggle_action.Remove(remote_controller)
		remote_controller.click_intercept = null
		remote_controller.reset_perspective()
	always_up = initial(always_up)
	manual_control = FALSE
	remote_controller = null
	return TRUE

/obj/machinery/porta_turret/proc/InterceptClickOn(mob/living/caller, params, atom/A)
	if(!manual_control)
		return FALSE
	if(!can_interact(caller))
		remove_control()
		return FALSE
	log_combat(caller,A,"fired with manual turret control at")
	INVOKE_ASYNC(src,PROC_REF(open_fire_on_target), A)
	return TRUE

/obj/machinery/porta_turret/syndicate
	installation = null
	always_up = 1
	use_power = NO_POWER_USE
	has_cover = 0
	scan_range = 9
	req_access = list(ACCESS_SYNDICATE)
	mode = TURRET_LETHAL
	stun_projectile = /obj/item/projectile/bullet
	lethal_projectile = /obj/item/projectile/bullet
	lethal_projectile_sound = 'sound/weapons/gunshot.ogg'
	stun_projectile_sound = 'sound/weapons/gunshot.ogg'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	faction = list(ROLE_SYNDICATE)
	desc = "A ballistic machine gun auto-turret."

/obj/machinery/porta_turret/syndicate/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES)

/obj/machinery/porta_turret/syndicate/setup()
	return

/obj/machinery/porta_turret/syndicate/assess_perp(mob/living/carbon/human/perp)
	return 10 //Syndicate turrets shoot everything not in their faction

/obj/machinery/porta_turret/syndicate/energy
	icon_state = "standard_stun"
	base_icon_state = "standard"
	stun_projectile = /obj/item/projectile/energy/electrode
	stun_projectile_sound = 'sound/weapons/taser.ogg'
	lethal_projectile = /obj/item/projectile/beam/laser
	lethal_projectile_sound = 'sound/weapons/laser.ogg'
	desc = "An energy blaster auto-turret."

/obj/machinery/porta_turret/syndicate/energy/heavy
	icon_state = "standard_stun"
	base_icon_state = "standard"
	stun_projectile = /obj/item/projectile/energy/electrode
	stun_projectile_sound = 'sound/weapons/taser.ogg'
	lethal_projectile = /obj/item/projectile/beam/laser/heavylaser
	lethal_projectile_sound = 'sound/weapons/lasercannonfire.ogg'
	desc = "An energy blaster auto-turret."

/obj/machinery/porta_turret/syndicate/energy/pirate
	max_integrity = 260
	integrity_failure = 0.08

/obj/machinery/porta_turret/syndicate/energy/raven
	stun_projectile =  /obj/item/projectile/beam/laser
	stun_projectile_sound = 'sound/weapons/laser.ogg'
	faction = list("neutral","silicon","turret")

/obj/machinery/porta_turret/syndicate/pod
	integrity_failure = 0.5
	max_integrity = 40
	stun_projectile = /obj/item/projectile/bullet/syndicate_turret
	lethal_projectile = /obj/item/projectile/bullet/syndicate_turret

/obj/machinery/porta_turret/syndicate/shuttle
	scan_range = 9
	shot_delay = 3
	stun_projectile = /obj/item/projectile/plasma/turret
	lethal_projectile = /obj/item/projectile/plasma/turret
	lethal_projectile_sound = 'sound/weapons/gunshot_smg.ogg'
	stun_projectile_sound = 'sound/weapons/gunshot_smg.ogg'

/obj/machinery/porta_turret/ai
	faction = list("silicon")
	turret_flags = TURRET_DEFAULT_TARGET_FLAGS | TURRET_DEFAULT_UTILITY | TF_IGNORE_FACTION

/obj/machinery/porta_turret/ai/assess_perp(mob/living/carbon/human/perp)
	return 10 //AI turrets shoot at everything not in their faction

/obj/machinery/porta_turret/aux_base
	name = "perimeter defense turret"
	desc = "A plasma beam turret calibrated to defend outposts against non-humanoid fauna. It is more effective when exposed to the environment."
	installation = null
	lethal_projectile = /obj/item/projectile/plasma/turret
	lethal_projectile_sound = 'sound/weapons/plasma_cutter.ogg'
	mode = TURRET_LETHAL //It would be useless in stun mode anyway
	faction = list("neutral","silicon","turret") //Minebots, medibots, etc that should not be shot.

/obj/machinery/porta_turret/aux_base/assess_perp(mob/living/carbon/human/perp)
	return 0 //Never shoot humanoids. You are on your own if Ashwalkers or the like attack!

/obj/machinery/porta_turret/aux_base/setup()
	return

/obj/machinery/porta_turret/aux_base/interact(mob/user) //Controlled solely from the base console.
	return

/obj/machinery/porta_turret/aux_base/Initialize()
	. = ..()
	cover.name = name
	cover.desc = desc

/obj/machinery/porta_turret/centcom_shuttle
	installation = null
	max_integrity = 260
	always_up = 1
	use_power = NO_POWER_USE
	has_cover = 0
	scan_range = 9
	stun_projectile = /obj/item/projectile/beam/laser
	lethal_projectile = /obj/item/projectile/beam/laser
	lethal_projectile_sound = 'sound/weapons/plasma_cutter.ogg'
	stun_projectile_sound = 'sound/weapons/plasma_cutter.ogg'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	faction = list("neutral","silicon","turret")
	mode = TURRET_LETHAL

/obj/machinery/porta_turret/centcom_shuttle/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES)

/obj/machinery/porta_turret/centcom_shuttle/assess_perp(mob/living/carbon/human/perp)
	return 0

/obj/machinery/porta_turret/centcom_shuttle/setup()
	return

/obj/machinery/porta_turret/centcom_shuttle/weak
	max_integrity = 120
	integrity_failure = 0.5
	name = "Old Laser Turret"
	desc = "A turret built with substandard parts and run down further with age. Still capable of delivering lethal lasers to the odd space carp, but not much else."
	stun_projectile = /obj/item/projectile/beam/weak/penetrator
	lethal_projectile = /obj/item/projectile/beam/weak/penetrator
	faction = list("neutral","silicon","turret")

/obj/machinery/porta_turret/centcom_shuttle/ballistic
	stun_projectile = /obj/item/projectile/bullet
	lethal_projectile = /obj/item/projectile/bullet
	lethal_projectile_sound = 'sound/weapons/gunshot.ogg'
	stun_projectile_sound = 'sound/weapons/gunshot.ogg'
	desc = "A ballistic machine gun auto-turret."

/obj/machinery/porta_turret/xray
	installation = null
	always_up = 1
	use_power = NO_POWER_USE
	has_cover = 0
	scan_range = 9
	req_access = list(ACCESS_SYNDICATE)
	mode = TURRET_LETHAL
	stun_projectile = /obj/item/projectile/bullet
	lethal_projectile = /obj/item/projectile/bullet
	lethal_projectile_sound = 'sound/weapons/gunshot.ogg'
	stun_projectile_sound = 'sound/weapons/gunshot.ogg'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	faction = list("xray")
	desc = "A ballistic machine gun auto-turret."

/obj/machinery/porta_turret/xray/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES)

/obj/machinery/porta_turret/xray/setup()
	return

/obj/machinery/porta_turret/xray/assess_perp(mob/living/carbon/human/perp)
	return 10 //Syndicate turrets shoot everything not in their faction

////////////////////////
//Turret Control Panel//
////////////////////////

/obj/machinery/turretid
	name = "turret control panel"
	desc = "Used to control a room's automated defenses."
	icon = 'icons/obj/machines/turret_control.dmi'
	icon_state = "control_standby"
	density = FALSE
	req_access = list(ACCESS_AI_UPLOAD)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// Variable dictating if linked turrets are active and will shoot targets
	var/enabled = TRUE
	/// Variable dictating if linked turrets will shoot lethal projectiles
	var/lethal = FALSE
	/// Variable dictating if the panel is locked, preventing changes to turret settings
	var/locked = TRUE
	/// An area in which linked turrets are located, it can be an area name, path or nothing
	var/control_area = null
	/// AI is unable to use this machine if set to TRUE
	var/ailock = FALSE
//	/// Variable dictating if linked turrets will shoot cyborgs
//	var/shoot_cyborgs = FALSE
	/// List of all linked turrets
	var/list/turrets = list()

/obj/machinery/turretid/Initialize(mapload, ndir = 0, built = 0)
	. = ..()
	if(built)
		setDir(ndir)
		locked = FALSE
		pixel_x = (dir & 3)? 0 : (dir == 4 ? -24 : 24)
		pixel_y = (dir & 3)? (dir ==1 ? -24 : 24) : 0
	power_change() //Checks power and initial settings

/obj/machinery/turretid/Destroy()
	turrets.Cut()
	return ..()

/obj/machinery/turretid/Initialize(mapload) //map-placed turrets autolink turrets
	. = ..()
	if(!mapload)
		return

	if(control_area)
		control_area = get_area_instance_from_text(control_area)
		if(control_area == null)
			control_area = get_area(src)
			stack_trace("Bad control_area path for [src], [src.control_area]")
	else if(!control_area)
		control_area = get_area(src)

	for(var/obj/machinery/porta_turret/T in control_area)
		turrets |= T
		T.cp = src

/obj/machinery/turretid/examine(mob/user)
	. += ..()
	if(issilicon(user) && !(stat & BROKEN))
		. += {"<span class='notice'>Ctrl-click [src] to [ enabled ? "disable" : "enable"] turrets.</span>
					<span class='notice'>Alt-click [src] to set turrets to [ lethal ? "stun" : "kill"].</span>"}

/obj/machinery/turretid/attackby(obj/item/I, mob/user, params)
	if(stat & BROKEN)
		return

	if (istype(I, /obj/item/multitool))
		if(!multitool_check_buffer(user, I))
			return
		var/obj/item/multitool/M = I
		if(M.buffer && istype(M.buffer, /obj/machinery/porta_turret))
			turrets |= M.buffer
			to_chat(user, span_notice("You link \the [M.buffer] with \the [src]."))
			return

	if (issilicon(user))
		return attack_hand(user)

	if ( get_dist(src, user) == 0 )		// trying to unlock the interface
		if (allowed(usr))
			if(obj_flags & EMAGGED)
				to_chat(user, span_warning("The turret control is unresponsive!"))
				return

			locked = !locked
			to_chat(user, span_notice("You [ locked ? "lock" : "unlock"] the panel."))
		else
			to_chat(user, span_alert("Access denied."))

/obj/machinery/turretid/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	to_chat(user, span_notice("You short out the turret controls' access analysis module."))
	obj_flags |= EMAGGED
	locked = FALSE

/obj/machinery/turretid/attack_ai(mob/user)
	if(!ailock || IsAdminGhost(user))
		return attack_hand(user)
	else
		to_chat(user, span_warning("There seems to be a firewall preventing you from accessing this device!"))

/obj/machinery/turretid/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TurretControl", name)
		ui.open()

/obj/machinery/turretid/ui_data(mob/user)
	var/list/data = list()
	data["locked"] = locked
	data["siliconUser"] = hasSiliconAccessInArea(user) || IsAdminGhost(user)
	data["enabled"] = enabled
	data["lethal"] = lethal
	//data["shootCyborgs"] = shoot_cyborgs
	return data

/obj/machinery/turretid/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("lock")
			if(!hasSiliconAccessInArea(usr) && !IsAdminGhost(usr))
				return
			if((obj_flags & EMAGGED) || (stat & BROKEN))
				to_chat(usr, span_warning("The turret control is unresponsive!"))
				return
			locked = !locked
			return TRUE
		if("power")
			toggle_on(usr)
			return TRUE
		if("mode")
			toggle_lethal(usr)
			return TRUE
/* 		if("shoot_silicons")
			shoot_silicons(usr)
			return TRUE */

/obj/machinery/turretid/proc/toggle_lethal(mob/user)
	lethal = !lethal
	add_hiddenprint(user)
	log_combat(user, src, "[lethal ? "enabled" : "disabled"] lethals on")
	updateTurrets()

/obj/machinery/turretid/proc/toggle_on(mob/user)
	enabled = !enabled
	add_hiddenprint(user)
	log_combat(user, src, "[enabled ? "enabled" : "disabled"]")
	updateTurrets()

/* /obj/machinery/turretid/proc/shoot_silicons(mob/user)
	shoot_cyborgs = !shoot_cyborgs
	add_hiddenprint(user)
	log_combat(user, src, "[shoot_cyborgs ? "Shooting Borgs" : "Not Shooting Borgs"]")
	updateTurrets() */

/obj/machinery/turretid/proc/updateTurrets()
	for (var/obj/machinery/porta_turret/aTurret in turrets)
		aTurret.setState(enabled, lethal)
	update_icon()

/obj/machinery/turretid/update_icon_state()
	if(stat & NOPOWER)
		icon_state = "control_off"
	else if (enabled)
		if (lethal)
			icon_state = "control_kill"
		else
			icon_state = "control_stun"
	else
		icon_state = "control_standby"

/obj/item/wallframe/turret_control
	name = "turret control frame"
	desc = "Used for building turret control panels."
	icon_state = "apc"
	result_path = /obj/machinery/turretid
	custom_materials = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT)

/obj/item/gun/proc/get_turret_properties()
	. = list()
	.["lethal_projectile"] = null
	.["lethal_projectile_sound"] = null
	.["stun_projectile"] = null
	.["stun_projectile_sound"] = null
	.["base_icon_state"] = "standard"

/obj/item/gun/energy/get_turret_properties()
	. = ..()

	var/obj/item/ammo_casing/primary_ammo = ammo_type[1]

	.["stun_projectile"] = initial(primary_ammo.projectile_type)
	.["stun_projectile_sound"] = initial(primary_ammo.fire_sound)

	if(ammo_type.len > 1)
		var/obj/item/ammo_casing/secondary_ammo = ammo_type[2]
		.["lethal_projectile"] = initial(secondary_ammo.projectile_type)
		.["lethal_projectile_sound"] = initial(secondary_ammo.fire_sound)
	else
		.["lethal_projectile"] = .["stun_projectile"]
		.["lethal_projectile_sound"] = .["stun_projectile_sound"]

/obj/item/gun/ballistic/get_turret_properties()
	. = ..()
	var/obj/item/ammo_box/mag = mag_type
	var/obj/item/ammo_casing/primary_ammo = initial(mag.ammo_type)

	.["base_icon_state"] = "syndie"
	.["stun_projectile"] = initial(primary_ammo.projectile_type)
	.["stun_projectile_sound"] = initial(primary_ammo.fire_sound)
	.["lethal_projectile"] = .["stun_projectile"]
	.["lethal_projectile_sound"] = .["stun_projectile_sound"]


/obj/item/gun/energy/laser/bluetag/get_turret_properties()
	. = ..()
	.["stun_projectile"] = /obj/item/projectile/beam/lasertag/bluetag
	.["lethal_projectile"] = /obj/item/projectile/beam/lasertag/bluetag
	.["base_icon_state"] = "blue"
	.["shot_delay"] = 30
	.["team_color"] = "blue"

/obj/item/gun/energy/laser/redtag/get_turret_properties()
	. = ..()
	.["stun_projectile"] = /obj/item/projectile/beam/lasertag/redtag
	.["lethal_projectile"] = /obj/item/projectile/beam/lasertag/redtag
	.["base_icon_state"] = "red"
	.["shot_delay"] = 30
	.["team_color"] = "red"

/obj/item/gun/energy/e_gun/turret/get_turret_properties()
	. = ..()

/obj/machinery/porta_turret/lasertag
	req_access = list(ACCESS_MAINT_TUNNELS, ACCESS_THEATRE)
	turret_flags = TURRET_DEFAULT_TARGET_FLAGS | TURRET_DEFAULT_UTILITY
	var/team_color

/obj/machinery/porta_turret/lasertag/assess_perp(mob/living/carbon/human/perp)
	. = 0
	if(team_color == "blue")	//Lasertag turrets target the opposing team, how great is that? -Sieve
		. = 0		//But does not target anyone else
		if(istype(perp.wear_suit, /obj/item/clothing/suit/redtag))
			. += 4
		if(perp.is_holding_item_of_type(/obj/item/gun/energy/laser/redtag))
			. += 4
		if(istype(perp.belt, /obj/item/gun/energy/laser/redtag))
			. += 2

	if(team_color == "red")
		. = 0
		if(istype(perp.wear_suit, /obj/item/clothing/suit/bluetag))
			. += 4
		if(perp.is_holding_item_of_type(/obj/item/gun/energy/laser/bluetag))
			. += 4
		if(istype(perp.belt, /obj/item/gun/energy/laser/bluetag))
			. += 2

/obj/machinery/porta_turret/lasertag/setup(obj/item/gun/gun)
	var/list/properties = ..()
	if(properties["team_color"])
		team_color = properties["team_color"]

/obj/machinery/porta_turret/lasertag/ui_status(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(team_color == "blue" && istype(H.wear_suit, /obj/item/clothing/suit/redtag))
			return UI_CLOSE
		if(team_color == "red" && istype(H.wear_suit, /obj/item/clothing/suit/bluetag))
			return UI_CLOSE
	return ..()

//lasertag presets
/obj/machinery/porta_turret/lasertag/red
	installation = /obj/item/gun/energy/laser/redtag
	team_color = "red"

/obj/machinery/porta_turret/lasertag/blue
	installation = /obj/item/gun/energy/laser/bluetag
	team_color = "blue"

/obj/machinery/porta_turret/lasertag/bullet_act(obj/item/projectile/P)
	. = ..()
	if(on)
		if(team_color == "blue")
			if(istype(P, /obj/item/projectile/beam/lasertag/redtag))
				toggle_on(FALSE)
				addtimer(CALLBACK(src,PROC_REF(toggle_on), TRUE), 10 SECONDS)
		else if(team_color == "red")
			if(istype(P, /obj/item/projectile/beam/lasertag/bluetag))
				toggle_on(FALSE)
				addtimer(CALLBACK(src,PROC_REF(toggle_on), TRUE), 10 SECONDS)

/* * * * * * * * * * * *
 * Fallout 13 turrets  *
 * * * * * * * * * * * */

/// Generic 9mm hates-everything turret
/obj/machinery/porta_turret/f13
	name = "old autoturret"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "An old automatic gun turret chambered in 9mm. Would rather to be left alone to ponder how it's still shooting after all these years."
	density = TRUE
	use_power = FALSE
	max_integrity = 160
	integrity_failure = 0.5
	armor = ARMOR_VALUE_HEAVY
	always_up = TRUE
	has_cover = FALSE
	scan_range = 9
	req_access = list(ACCESS_SYNDICATE)
	mode = TURRET_LETHAL
	installation = null
	turret_flags = TURRET_DEFAULT_TARGET_FLAGS | TURRET_DEFAULT_UTILITY
	stun_projectile = /obj/item/projectile/bullet/c9mm/rubber
	lethal_projectile = /obj/item/projectile/bullet/c9mm/simple
	lethal_projectile_sound = 'sound/f13weapons/9mm.ogg'
	stun_projectile_sound = 'sound/f13weapons/9mm.ogg'
	faction = null

/// .22LR turret
/obj/machinery/porta_turret/f13/turret_22lr
	name = "salvaged mini-plink turret"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		More of a 'polite' model, designed to kindly request intruders to leave with its itty bitty twenty-two. \
		This one is chambered in .22LR and maintained by raccoons, apparently."
	stun_projectile = /obj/item/projectile/bullet/c22/rubber
	lethal_projectile = /obj/item/projectile/bullet/c22
	lethal_projectile_sound = 'sound/f13weapons/servicerifle.ogg'
	stun_projectile_sound = 'sound/f13weapons/servicerifle.ogg'
	shot_spread = 5

/// .22LR turret - raider
/obj/machinery/porta_turret/f13/turret_22lr/raider
	name = "raider mini-plink turret"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		About as 'polite' as a raider gets, designed to kindly request intruders to leave with its itty bitty twenty-two. \
		This one is chambered in .22LR and manaces with bitchin' spikes."
	turret_flags = TURRET_RAIDER_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("raider")

/// .22LR turret - robot
/obj/machinery/porta_turret/f13/turret_22lr/robot
	name = "autonomous mini-plink turret"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		More of a 'polite' model, designed to kindly request intruders to leave with its itty bitty twenty-two. \
		This one is chambered in .22LR and maintained by robots."
	turret_flags = TURRET_ROBOT_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("wastebot")

/// .22LR burst turret
/obj/machinery/porta_turret/f13/turret_22lr/burstfire
	name = "salvaged mini-SMG turret"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		Enthusiasts could drop-in a bump-roller cam that would both boost its rate of fire and make the feds <i>very</i> interested in your location. \
		This one is chambered in .22LR and maintained by raccoons, apparently."
	burst_count = 6
	burst_delay = GUN_BURSTFIRE_DELAY_FASTER
	shot_spread = 10

/// .22LR burst turret - raider
/obj/machinery/porta_turret/f13/turret_22lr/burstfire/raider
	name = "raider mini-SMG turret"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		A favorite of the <span class='swarmer'>STEELHIVE</span> clan as they claim it contains a swarm of angry metal bees. \
		This one, however, is chambered in .22LR and manaces with one huge spike on the back."
	turret_flags = TURRET_RAIDER_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("raider")

/// .22LR burst turret - robot
/obj/machinery/porta_turret/f13/turret_22lr/burstfire/robot
	name = "autonomous mini-SMG turret"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		Enthusiasts could drop-in a bump-roller cam that would both boost its rate of fire and make the feds <i>very</i> interested in your location. \
		This one is chambered in .22LR and maintained by robots."
	turret_flags = TURRET_ROBOT_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("wastebot")

/// 9mm turret
/obj/machinery/porta_turret/f13/turret_9mm
	name = "salvaged autogun"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		This one is chambered in 9mm and maintained by raccoons, apparently."
	stun_projectile = /obj/item/projectile/bullet/c9mm/rubber
	lethal_projectile = /obj/item/projectile/bullet/c9mm/simple
	lethal_projectile_sound = 'sound/f13weapons/9mm.ogg'
	stun_projectile_sound = 'sound/f13weapons/9mm.ogg'
	shot_spread = 10

/// 9mm turret that loves raiders
/obj/machinery/porta_turret/f13/turret_9mm/raider
	name = "raider autogun"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		This one is chambered in 9mm and menaces with spikes. Really sells that badguy chic."
	turret_flags = TURRET_RAIDER_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("raider")

/// 9mm turret that loves robots
/obj/machinery/porta_turret/f13/turret_9mm/robot
	name = "autonomous autogun"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		This one is chambered in 9mm and maintained by robots."
	turret_flags = TURRET_ROBOT_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("wastebot")

/// Burstfire 9mm turret
/obj/machinery/porta_turret/f13/turret_9mm/burstfire
	name = "salvaged fully-autogun"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		Enthusiasts could drop-in a bump-roller cam that would both boost its rate of fire and make the feds <i>very</i> interested in your location. \
		That seems to be the case with this one. It is chambered in 9mm and maintained by raccoons, apparently."
	burst_count = 3
	burst_delay = GUN_BURSTFIRE_DELAY_FAST
	shot_spread = 15

/// 9mm turret that loves raiders
/obj/machinery/porta_turret/f13/turret_9mm/burstfire/raider
	name = "raider fully-autogun"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		Enthusiasts could drop-in a bump-roller cam that would both boost its rate of fire and make the feds <i>very</i> interested in your location. \
		That seems to be the case with this one. It is chambered in 9mm and menaces with rusty metal spikes."
	turret_flags = TURRET_RAIDER_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("raider")

/// 9mm turret that loves robots
/obj/machinery/porta_turret/f13/turret_9mm/burstfire/robot
	name = "autonomous fully-autogun"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		Enthusiasts could drop-in a bump-roller cam that would both boost its rate of fire and make the feds <i>very</i> interested in your location. \
		That seems to be the case with this one. It is chambered in 9mm and maintained by robots."
	turret_flags = TURRET_ROBOT_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("wastebot")

/// 5.56mm turret
/obj/machinery/porta_turret/f13/turret_556
	name = "military autorifle"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		Though the stock models tend to come in 9mm, a few simple tweaks and it can fire just about anything, such as, say, 5.56mm. \
		This one is chambered in 5.56mm and maintained by raccoons, apparently."
	stun_projectile = /obj/item/projectile/bullet/a556/rubber
	lethal_projectile = /obj/item/projectile/bullet/a556/simple
	lethal_projectile_sound = 'sound/f13weapons/assaultrifle_fire.ogg'
	stun_projectile_sound = 'sound/f13weapons/assaultrifle_fire.ogg'
	shot_spread = 3

/// 5.56mm turret that loves raiders
/obj/machinery/porta_turret/f13/turret_556/raider
	name = "raider autorifle"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		Though the stock models tend to come in 9mm, a few simple tweaks and it can fire just about anything, such as, say, 5.56mm. \
		This one is chambered in 5.56mm and has a sweet painting of a flaming skull on the side."
	turret_flags = TURRET_RAIDER_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("raider")

/// 556 turret that loves robots
/obj/machinery/porta_turret/f13/turret_556/robot
	name = "autonomous autorifle"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		Though the stock models tend to come in 9mm, a few simple tweaks and it can fire just about anything, such as, say, 5.56mm. \
		This one is chambered in 5.56mm and maintained by robots."
	turret_flags = TURRET_ROBOT_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("wastebot")

/// Burstfire 5.56mm turret
/obj/machinery/porta_turret/f13/turret_556/burstfire
	name = "military fully-autorifle"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		Though the stock models tend to come in 9mm, a few simple tweaks and it can fire just about anything, such as, say, 5.56mm. \
		Enthusiasts could drop-in a bump-roller cam that would both boost its rate of fire and make the feds <i>very</i> interested in your location. \
		That seems to be the case with this one. It is chambered in 5.56mm and maintained by raccoons, apparently."
	burst_count = 4
	burst_delay = GUN_BURSTFIRE_DELAY_SLOW
	shot_spread = 7

/// burstfire 5.56mm turret that loves raiders
/obj/machinery/porta_turret/f13/turret_556/burstfire/raider
	name = "raider fully-autorifle"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		Though the stock models tend to come in 9mm, a few simple tweaks and it can fire just about anything, such as, say, 5.56mm. \
		Enthusiasts could drop-in a bump-roller cam that would both boost its rate of fire and make the feds <i>very</i> interested in your location. \
		This one is chambered in 5.56mm and has a sweet painting of a flaming skull on the side."
	turret_flags = TURRET_RAIDER_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("raider")

/// 556 turret that loves robots
/obj/machinery/porta_turret/f13/turret_556/burstfire/robot
	name = "autonomous fully-autorifle"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		Though the stock models tend to come in 9mm, a few simple tweaks and it can fire just about anything, such as, say, 5.56mm. \
		Enthusiasts could drop-in a bump-roller cam that would both boost its rate of fire and make the feds <i>very</i> interested in your location. \
		That seems to be the case with this one. It is chambered in 5.56mm and maintained by robots."
	turret_flags = TURRET_ROBOT_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("wastebot")

/// shotgun turret
/obj/machinery/porta_turret/f13/turret_shotgun
	name = "hunting autoshotgun"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		This one seems to be based more on the Woodland King Moosemulcher line, designed for even the most passive hunting enthusiasts. \
		This one is chambered in 12 gauge shotgun shells and maintained by raccoons, apparently."
	stun_projectile = null
	lethal_projectile = null
	lethal_projectile_sound = 'sound/f13weapons/shotgun.ogg'
	stun_projectile_sound = 'sound/f13weapons/shotgun.ogg'
	casing_type_stun = /obj/item/ammo_casing/shotgun/rubbershot
	casing_type_lethal = /obj/item/ammo_casing/shotgun/buckshot

/obj/machinery/porta_turret/f13/turret_shotgun/raider
	name = "raider autoshotgun"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		This one seems to be based more on the Woodland King Moosemulcher line, designed for even the most passive hunting enthusiasts. \
		This one is chambered in 12 gauge shotgun shells and menaces with evil looking spikes."
	turret_flags = TURRET_RAIDER_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("raider")

/// 556 turret that loves robots
/obj/machinery/porta_turret/f13/turret_shotgun/robot
	name = "autonomous autoshotgun"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		This one seems to be based more on the Woodland King Moosemulcher line, designed for even the most passive hunting enthusiasts. \
		This one is chambered in 12 gauge shotgun shells and maintained by robots."
	turret_flags = TURRET_ROBOT_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("wastebot")

/// burst shotgun turret
/obj/machinery/porta_turret/f13/turret_shotgun/burstfire
	name = "\"hunting\" fully-autoshotgun"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		This one seems to be based more on the Woodland King Moosemulcher line, designed for even the most passive hunting enthusiasts. \
		Geez, was there really <i>THAT</i> much wildlife before the war? Talk about a moose mulcher... \
		At any rate, this fully automatic sentry-shotgun is chambered in 12 gauge and maintained by raccoons, apparently."
	burst_count = 3
	burst_delay = GUN_BURSTFIRE_DELAY_SLOWER

/obj/machinery/porta_turret/f13/turret_shotgun/burstfire/raider
	name = "raider auto-streetsweeper"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		This one seems to be based more on the Woodland King Moosemulcher line, designed for even the most passive hunting enthusiasts. \
		The mounted shotgun seems to have been swapped out for some kind of makeshift gatling gun connected to a hopper of shotgun shells. \
		A clever design, leveraging the bump-roller cam's motion to operate the action, truly a marvel of modern suffering. \
		At any rate, this fully automatic sentry-shotgun is chambered in 12 gauge and menaces with rusty spikes."
	turret_flags = TURRET_RAIDER_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("raider")

/// 556 turret that loves robots
/obj/machinery/porta_turret/f13/turret_shotgun/burstfire/robot
	name = "autonomous fully-autoshotgun"
	desc = "A juryrigged autonomous weapon system based off various pre-war Uncle ShootBang2000 designs. \
		Countless sentry guns like these were in use before the war, valued for their ease of setup and surprising ammo efficiency. \
		This one seems to be based more on the Woodland King Moosemulcher line, designed for even the most passive hunting enthusiasts. \
		Geez, was there really <i>THAT</i> much wildlife before the war? Talk about a moose mulcher... \
		At any rate, this fully automatic sentry-shotgun is chambered in 12 gauge and maintained by robots."
	turret_flags = TURRET_ROBOT_OWNED_FLAGS | TURRET_DEFAULT_UTILITY
	faction = list("wastebot")


/// .22LR turret
/obj/machinery/porta_turret/f13/town
	name = "allied point defense system"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A friendly turret here to keep New Boston (or wherever it currenly is) nice and safe! Fires a burst of 9mm bullets \
		at any wasteland annoyances that come too close. Its targetting sensors purposefully ignore friendly targets, like you! \
		<br><br>\
		Don't worry! This thing is ON YOUR SIDE! Seriously, this thing is so fervently aligned with you that it may as well be \
		part of your family. So, say hi to Uncle Turret! He's got your back! -<u>Adventurer's Guild</u>"
	faction = list("neutral")
	stun_projectile = /obj/item/projectile/bullet/c9mm/rubber
	lethal_projectile = /obj/item/projectile/bullet/c9mm
	lethal_projectile_sound = 'sound/f13weapons/9mm.ogg'
	stun_projectile_sound = 'sound/f13weapons/9mm.ogg'
	burst_count = 3
	shot_spread = 5
	req_access = list()

/obj/machinery/porta_turret/f13/town/Initialize()
	. = ..()
	add_atom_colour(list(
		0, 3, 0,
		1, -2, 1,
		0, 0, 0,
	), FIXED_COLOUR_PRIORITY) // makes it a different pallette, all without actual icon editing, lah!

/obj/machinery/porta_turret/f13/town/open_fire_on_target(atom/forced_target)
	var/atom/targetthing = GET_WEAKREF(last_target)
	if(isplayer(targetthing))
		mode = TURRET_STUN
	else
		mode = TURRET_LETHAL
	. = ..()

/obj/machinery/porta_turret/f13/town/rifle
	name = "allied friendly point defense system"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A friendly turret here to keep New Boston (or wherever it currenly is) nice and safe! Fires a burst of 5.56mm shells \
		at any wasteland annoyances that come too close. Its targetting sensors purposefully ignore friendly targets, like you! \
		<br><br>\
		Don't worry! This thing is ON YOUR SIDE! Seriously, this thing is so fervently aligned with you that it may as well be \
		part of your family. So, say hi to Uncle Turret! He's got your back! -<u>Adventurer's Guild</u>"
	stun_projectile = /obj/item/projectile/bullet/m5mm
	lethal_projectile = /obj/item/projectile/bullet/m5mm
	lethal_projectile_sound = 'sound/f13weapons/assault_carbine.ogg'
	stun_projectile_sound = 'sound/f13weapons/assault_carbine.ogg'
	burst_count = 5
	shot_spread = 2
	shot_delay = 1 SECONDS

/obj/machinery/porta_turret/f13/town/shotgun
	name = "allied scattercannon point defense system"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A friendly turret here to keep New Boston (or wherever it currenly is) nice and safe! Fires a spray of buckshot \
		at any wasteland annoyances that come too close. Its targetting sensors purposefully ignore friendly targets, like you! \
		<br><br>\
		Don't worry! This thing is ON YOUR SIDE! Seriously, this thing is so fervently aligned with you that it may as well be \
		part of your family. So, say hi to Uncle Turret! He's got your back! -<u>Adventurer's Guild</u>"
	stun_projectile = null
	lethal_projectile = null
	lethal_projectile_sound = 'sound/f13weapons/shotgun.ogg'
	stun_projectile_sound = 'sound/f13weapons/shotgun.ogg'
	casing_type_stun = /obj/item/ammo_casing/shotgun/rubbershot
	casing_type_lethal = /obj/item/ammo_casing/shotgun/buckshot/wide

/obj/machinery/porta_turret/f13/town/AMR_turret
	name = "allied big game point defense system"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A friendly turret here to keep New Boston (or wherever it currenly is) nice and safe! Fires a big fat .50 BMG round \
		at any wasteland annoyances that come too close. Its targetting sensors purposefully ignore friendly targets, like you! \
		<br><br>\
		Don't worry! This thing is ON YOUR SIDE! Seriously, this thing is so fervently aligned with you that it may as well be \
		part of your family. So, say hi to Uncle Turret! He's got your back! -<u>Adventurer's Guild</u>"
	stun_projectile = /obj/item/projectile/bullet/a50MG/rubber
	lethal_projectile = /obj/item/projectile/bullet/a50MG
	lethal_projectile_sound = 'sound/f13weapons/antimaterialfire.ogg'
	stun_projectile_sound = 'sound/f13weapons/antimaterialfire.ogg'
	burst_count = 1
	shot_spread = 0
	shot_delay = 3 SECONDS
	scan_range = 30 // laggy!

/obj/machinery/porta_turret/f13/town/gauss
	name = "allied railgun point defense system"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A friendly turret here to keep New Boston (or wherever it currenly is) nice and safe! Will blast its frickin railgun \
		at any wasteland annoyances that come too close. Its targetting sensors purposefully ignore friendly targets, like you! \
		<br><br>\
		Don't worry! This thing is ON YOUR SIDE! Seriously, this thing is so fervently aligned with you that it may as well be \
		part of your family. So, say hi to Uncle Turret! He's got your back! -<u>Adventurer's Guild</u>"
	stun_projectile = /obj/item/projectile/bullet/c2mm
	lethal_projectile = /obj/item/projectile/bullet/c2mm
	lethal_projectile_sound = 'sound/f13weapons/gauss_rifle.ogg'
	stun_projectile_sound = 'sound/f13weapons/gauss_rifle.ogg'
	burst_count = 1
	shot_spread = 0
	shot_delay = 3 SECONDS
	scan_range = 30 // laggy!

/obj/machinery/porta_turret/f13/town/gatling_laser
	name = "allied laser defense system"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A friendly turret here to keep New Boston (or wherever it currenly is) nice and safe! Fires a spray of lasers \
		at any wasteland annoyances that come too close. Its targetting sensors purposefully ignore friendly targets, like you! \
		<br><br>\
		Don't worry! This thing is ON YOUR SIDE! Seriously, this thing is so fervently aligned with you that it may as well be \
		part of your family. So, say hi to Uncle Turret! He's got your back! -<u>Adventurer's Guild</u>"
	stun_projectile = /obj/item/projectile/beam/laser/pistol/hitscan/stun
	lethal_projectile = /obj/item/projectile/beam/laser/gatling/hitscan
	lethal_projectile_sound = 'sound/weapons/hyperblaster.ogg'
	stun_projectile_sound = 'sound/weapons/hyperblaster.ogg'
	burst_count = 10
	shot_spread = 7
	shot_delay = 0.1 SECONDS

/// Nash's Friendliest Autogun
/// needs ammo~
/obj/machinery/porta_turret/f13/nash
	name = "portable .22LR sentry turret"
	icon = 'icons/obj/turrets.dmi'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	desc = "A crude, but effective, hand-made auto-turret, chambered in .22LR, with a 300 round hopper. Comes pre-programmed to gun down \
		a wide variety of wasteland annoyances with a spray of bullets and keep our lovely town safe! Keep away from dogs. \
		<br><br>\
		This turret comes unloaded and lacks an ammo-fab, so it will need to be fed <b>.22LR bullets</b> before it can fire. \
		This is a 'portable' turret, in that it can be packaged back up into a handy carrying case if pulsed with a <b>multitool</b>.\
		It can be repaired with a <b>welder<b>."
	density = TRUE
	use_power = FALSE
	max_integrity = 160
	integrity_failure = 0.1
	armor = ARMOR_VALUE_HEAVY
	always_up = TRUE
	has_cover = FALSE
	scan_range = 9
	req_access = list()
	mode = TURRET_LETHAL
	installation = null
	turret_flags = TURRET_DEFAULT_TARGET_FLAGS | TURRET_DEFAULT_UTILITY
	stun_projectile = /obj/item/projectile/bullet/c22/rubber
	lethal_projectile = /obj/item/projectile/bullet/c22
	lethal_projectile_sound = 'sound/f13weapons/servicerifle.ogg'
	stun_projectile_sound = 'sound/f13weapons/servicerifle.ogg'
	burst_count = 2
	burst_delay = GUN_BURSTFIRE_DELAY_SLOW
	shot_spread = 3
	faction = list("neutral")
	/// This turret takes ammo!
	var/obj/item/ammo_box/magazine/internal/our_mag = /obj/item/ammo_box/magazine/internal/turret
	/// Ammunition loaded in the chamber
	var/obj/item/ammo_casing/chambered
	lethal_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_LIGHT_VOLUME),
		SP_NORMAL_RANGE(PISTOL_LIGHT_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_LIGHT_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_LIGHT_RANGE_DISTANT)
	)

/obj/machinery/porta_turret/f13/nash/Initialize()
	. = ..()
	if(our_mag)
		var/obj/item/ammo_box/magazine/internal/newmag = our_mag
		our_mag = new newmag(src)
	chamber_new_round(FALSE)

/obj/machinery/porta_turret/f13/nash/Destroy()
	. = ..()
	if(istype(our_mag) && obj_integrity <= 0)
		for(var/obj/item/ammo_casing/casing_to_eject in our_mag.stored_ammo)
			our_mag.eject_round(casing_to_eject)
	QDEL_NULL(our_mag)
	QDEL_NULL(chambered)

/obj/machinery/porta_turret/f13/nash/examine(mob/user)
	. = ..()
	if(istype(our_mag) && length(our_mag.caliber))
		. += "It accepts [span_notice(english_list(our_mag.caliber))]"
	. += "It has [span_notice("[our_mag.ammo_count() + (!!chambered)]")] / [span_notice("[our_mag.max_ammo]")] round\s remaining."

/obj/machinery/porta_turret/f13/nash/proc/out_of_ammo_alert()
	playsound(get_turf(src), 'sound/machines/triple_beep.ogg', 100, FALSE, 0, ignore_walls = TRUE)
	say("OUT OF: AMMO! NEED: [span_notice(english_list(our_mag.caliber))]!")

/obj/machinery/porta_turret/f13/nash/proc/eject_chambered_round(keep_it)
	if(!istype(chambered))
		return FALSE
	if(keep_it && our_mag.give_round(chambered))
		return TRUE
	chambered.forceMove(get_turf(src))
	chambered.bounce_away(TRUE, 3, turn(dir, -90))
	chambered = null
	return TRUE

/obj/machinery/porta_turret/f13/nash/proc/chamber_new_round(eject_current)
	if(istype(chambered))
		if(eject_current || !chambered.BB)
			eject_chambered_round()
	if(istype(our_mag))
		chambered = our_mag.get_round(FALSE)
	if(istype(chambered) && chambered.BB)
		return TRUE
	return FALSE

/obj/machinery/porta_turret/f13/nash/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/ammo_box))
		if(istype(our_mag))
			our_mag.attackby(I, user)
			chamber_new_round(FALSE)
			return
	if(istype(I, /obj/item/ammo_casing))
		if(istype(our_mag))
			our_mag.attackby(I, user)
			chamber_new_round(FALSE)
	if(istype(I, /obj/item/storage/bag/casings))
		if(istype(our_mag))
			dump_bag_in_turret(I, user)
	if(I.tool_behaviour == TOOL_MULTITOOL)
		undeploy_turret(I, user)
		return
	if(I.tool_behaviour == TOOL_WELDER)
		heal_turret(I, user)
		return
	. = ..()

/obj/machinery/porta_turret/f13/nash/proc/dump_bag_in_turret(obj/item/storage/bag/casings/saq, mob/user)
	if(!istype(saq))
		return
	if(!istype(user))
		return
	if(INTERACTING_WITH(user, src))
		return
	if(!LAZYLEN(saq.contents))
		to_chat(user, span_warning("There's nothing in \the [saq] to load into \the [src]!"))
		return
	to_chat(user, span_notice("You start dumping \the [saq] into \the [src]."))
	playsound(get_turf(src), "sound/effects/rustle[rand(1,4)].ogg", 50, TRUE, 0, ignore_walls = TRUE)
	if(!do_after(user, 1 SECONDS, target = src))
		to_chat(user, span_alert("You were interrupted!."))
		return
	var/count = 0
	for(var/obj/item/ammo_casing/casing in saq.contents)
		if(!casing.BB)
			continue
		if(our_mag.give_round(casing))
			SEND_SIGNAL(saq, COMSIG_TRY_STORAGE_TAKE, casing, our_mag, FALSE)
		else
			continue
		count++
	if(count > 0)
		to_chat(user, span_notice("You insert [count] casing\s into \the [src]."))
		playsound(get_turf(src), "sound/weapons/gun_magazine_insert_empty_[rand(1,4)].ogg", 50, TRUE, 0, ignore_walls = TRUE)
	else
		to_chat(user, span_warning("You couldn't fit anything into [src]!"))

/obj/machinery/porta_turret/f13/nash/proc/undeploy_turret(obj/item/m_tool, mob/user)
	visible_message(span_notice("[user] starts packing up [src]!"),
		span_notice("You starts packing up [src]!"))
	if(!m_tool.use_tool(src, user, 3 SECONDS, 0, 100))
		user.show_message(span_alert("You were interrupted"))
	visible_message(span_notice("[user] packed up [src]!"),
		span_green("You packed up [src]!"))
	var/obj/item/turret_box/the_box = new(get_turf(src))
	eject_chambered_round(TRUE)
	the_box.turret_type = type
	the_box.stored_mag = our_mag
	our_mag.forceMove(the_box)
	our_mag = null
	qdel(src)

/obj/machinery/porta_turret/f13/nash/proc/heal_turret(obj/item/weldertool, mob/user)
	if(stat & BROKEN)
		user.show_message(span_alert("It's beyond repair!"))
		return
	if(!weldertool.tool_start_check(user, amount=1))
		user.show_message(span_alert("You need at least 1 unit of fuel in your welder!"))
		return

	visible_message(span_notice("[user] starts repairing [src]!"),
		span_notice("You starts repairing [src]!"))
	if(weldertool.use_tool(src, user, 3 SECONDS, 0, 100))
		obj_integrity = initial(obj_integrity)
		visible_message(span_notice("[user] repaired [src]!"),
			span_green("You repaired [src]!"))

/// modified to use our silly ammo system
/obj/machinery/porta_turret/f13/nash/shoot_at_target(atom/movable/target, turf/our_turf)
	if(!target || !our_turf)
		return FALSE
	if(!chambered || (chambered && !chambered.BB))
		eject_chambered_round()
		chamber_new_round(TRUE)
		if((!chambered || (chambered && !chambered.BB)) && !our_mag.ammo_count())
			out_of_ammo_alert()
			return FALSE
	target = turf_has_valid_target(get_turf(target))
	if(!target)
		return FALSE
	//use_power(reqpower * 2)
	var/the_spread = rand(-shot_spread, shot_spread)
	chambered.fire_casing(
		target = target,
		user = src,
		params = null,
		distro = shot_spread,
		quiet = null,
		zone_override = ran_zone(),
		spread = the_spread,
		damage_multiplier = 1,
		penetration_multiplier = 1,
		projectile_speed_multiplier = 1,
		fired_from = src
		)

	playsound(
		src,
		lethal_projectile_sound,
		lethal_sound_properties[SOUND_PROPERTY_VOLUME],
		lethal_sound_properties[SOUND_PROPERTY_VARY],
		lethal_sound_properties[SOUND_PROPERTY_NORMAL_RANGE],
		ignore_walls = lethal_sound_properties[SOUND_PROPERTY_IGNORE_WALLS],
		distant_sound = lethal_sound_properties[SOUND_PROPERTY_DISTANT_SOUND],
		distant_range = lethal_sound_properties[SOUND_PROPERTY_DISTANT_SOUND_RANGE]
		)
	eject_chambered_round()
	chamber_new_round(TRUE)
	if(!chambered && !our_mag.ammo_count())
		out_of_ammo_alert()
	return TRUE

/// dumps loot all over the place
/obj/machinery/porta_turret/f13/nash/drop_loot(obj/item/I, mob/user)
	new /obj/item/gun/ballistic/automatic/sportcarbine(get_turf(src))
	..()

/obj/item/ammo_box/magazine/internal/turret
	name = "turret ammo hopper"
	desc = "A huge cannister of ammo designed to go into a turret."
	ammo_type = /obj/item/ammo_casing/a22
	caliber = list(CALIBER_22LR)
	max_ammo = 300
	start_empty = FALSE
	w_class = WEIGHT_CLASS_GIGANTIC
	start_ammo_count = 100
	randomize_ammo_count = TRUE

/obj/item/ammo_box/magazine/internal/turret/get_random_bullet_amount(num_bullets = max_ammo)
	var/amount = FLOOR(rand(num_bullets * 0.5, num_bullets), 1)
	return amount

/// A packed up turrent
/obj/item/turret_box
	name = "packaged port-a-turret"
	desc = "A turret, packed up and ready to deploy. Ammo not included, unless repackaged."
	icon = 'icons/obj/objects.dmi'
	icon_state = "hivebot_fab_on"
	w_class = WEIGHT_CLASS_GIGANTIC
	/// type of turret to make
	var/obj/machinery/porta_turret/f13/nash/turret_type = /obj/machinery/porta_turret/f13/nash
	/// magazine inside the gun, if it was packed up after deploying
	var/obj/item/ammo_box/magazine/stored_mag

/obj/item/turret_box/Initialize()
	. = ..()
	
/obj/item/turret_box/Destroy()
	. = ..()
	QDEL_NULL(stored_mag)

/obj/item/turret_box/attack_self(mob/user)
	. = ..()
	var/turf/u_r_here = get_turf(user)
	if(!u_r_here)
		return
	var/obj/machinery/porta_turret/turrent_here = locate(/obj/machinery/porta_turret) in u_r_here
	if(turrent_here)
		user.show_message(span_alert("There's already a turret here!"))
		return
	user.visible_message(span_notice("[user] starts unpacking [src]."))
	if(!do_after(user, 3 SECONDS, FALSE, user))
		user.show_message(span_alert("You were interrupted!"))
		return
	var/obj/machinery/porta_turret/f13/nash/turret_new = new turret_type(get_turf(src))
	if(istype(stored_mag))
		QDEL_NULL(turret_new.our_mag)
		turret_new.our_mag = stored_mag
		stored_mag.forceMove(turret_new)
		turret_new.eject_chambered_round(TRUE)
		turret_new.chamber_new_round()
	user.visible_message(span_notice("[user] unpacks [src], deploying [turret_new]."))
	stored_mag = null
	qdel(src)
	
