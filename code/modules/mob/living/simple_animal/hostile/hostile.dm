/mob/living/simple_animal/hostile
	faction = list("hostile")
	stop_automated_movement_when_pulled = 0
	obj_damage = 40
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES //Bitflags. Set to ENVIRONMENT_SMASH_STRUCTURES to break closets,tables,racks, etc; ENVIRONMENT_SMASH_WALLS for walls; ENVIRONMENT_SMASH_RWALLS for rwalls
	mob_size = MOB_SIZE_LARGE
	gold_core_spawnable = NO_SPAWN
	var/datum/weakref/target
	var/ranged = FALSE
	var/rapid = 0 //How many shots per volley.
	var/rapid_fire_delay = 2 //Time between rapid fire shots

	var/dodging = TRUE
	var/approaching_target = FALSE //We should dodge now
	var/in_melee = FALSE	//We should sidestep now
	var/dodge_prob = 5
	var/sidestep_per_cycle = 1 //How many sidesteps per npcpool cycle when in melee

	var/extra_projectiles = 0 //how many projectiles above 1?
	/// How long to wait between shots?
	var/auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	var/projectiletype	//set ONLY it and NULLIFY casingtype var, if we have ONLY projectile
	var/projectilesound
	/// Makes the mob throw a thing
	var/obj/item/throw_thing
	var/throw_thing_speed = 1
	var/throw_thing_sound = 'sound/weapons/punchmiss.ogg'
	/// Time between throwing things
	var/throw_delay = 10 SECONDS
	COOLDOWN_DECLARE(throw_cooldown)
	/// Play a sound after they shoot?
	var/sound_after_shooting
	/// How long after shooting should it play?
	var/sound_after_shooting_delay = 1 SECONDS
	var/list/projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PLASMA_VOLUME),
		SP_VOLUME_SILENCED(PLASMA_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PLASMA_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(null),
		SP_DISTANT_RANGE(null)
	)

	var/casingtype		//set ONLY it and NULLIFY projectiletype, if we have projectile IN CASING
	/// Deciseconds between moves for automated movement. m2d 3 = standard, less is fast, more is slower.
	var/move_to_delay = 3
	var/list/friends = list()
	var/list/foes = list()
	var/list/emote_taunt
	var/emote_taunt_sound = FALSE // Does it have a sound associated with the emote? Defaults to false.
	var/taunt_chance = 0

	/// What happens when this mob is EMP'd?
	var/list/emp_flags = list()
	/// What emp effects are active?
	var/list/active_emp_flags = list()
	/// Smoke!
	var/datum/effect_system/smoke_spread/bad/smoke

	var/rapid_melee = 1			 //Number of melee attacks between each npc pool tick. Spread evenly.
	var/melee_queue_distance = 4 //If target is close enough start preparing to hit them if we have rapid_melee enabled
	
	/// Does the mob do a little windup before attacking?
	var/telegraphs_melee = TRUE
	/// Mobs will actually attack after this many seconds of winding up.
	var/melee_windup_time = 0.3 SECONDS
	/// This plays when the mob's attack windup starts. It requires melee_windup_time to be set.
	var/melee_windup_sound = 'sound/effects/flip.ogg'
	/// How much to shrink and grow this mob when it's doing a windup attack.
	var/melee_windup_magnitude = 0.3
	/// TRUE while a mob is winding up a melee attack, otherwise FALSE.
	var/winding_up_melee = FALSE
	var/windup_timer_id = 0

	var/melee_attack_cooldown = 2 SECONDS
	COOLDOWN_DECLARE(melee_cooldown)

	var/ranged_attack_cooldown = 2 SECONDS
	COOLDOWN_DECLARE(ranged_cooldown)

	var/sight_shoot_delay_time = 0.7 SECONDS
	COOLDOWN_DECLARE(sight_shoot_delay)

	/// If it can move and shoot on the same turn, set this to TRUE. otherwise it will shoot if it can, or move if it cant
	var/can_move_and_shoot = TRUE
	var/ranged_message = "fires" //Fluff text for ranged mobs
	var/ranged_cooldown = 0 //What the current cooldown on ranged attacks is, generally world.time + ranged_cooldown_time
	var/ranged_cooldown_time = 3 SECONDS //How long, in deciseconds, the cooldown of ranged attacks is
	var/ranged_ignores_vision = FALSE //if it'll fire ranged attacks even if it lacks vision on its target, only works with environment smash
	var/check_friendly_fire = 0 // Should the ranged mob check for friendlies when shooting
	/// If our mob runs from players when they're too close, set in tile distance. By default, mobs do not retreat.
	var/retreat_distance = null
	/// Minimum approach distance, so ranged mobs chase targets down, but still keep their distance set in tiles to the target, set higher to make mobs keep distance
	var/minimum_distance = 1

	var/decompose = TRUE //Does this mob decompose over time when dead?
	//var/decomposition_time = 5 MINUTES
	//COOLDOWN_DECLARE(decomposition_schedule)

//These vars are related to how mobs locate and target
	/// Will a mob attempt to target you even if you've so cleverly hidden yourself in a locker?
	var/understands_lockers = TRUE // only really makes sense for ultradumb robots
	var/robust_searching = 0 //By default, mobs have a simple searching method, set this to 1 for the more scrutinous searching (stat_attack, stat_exclusive, etc), should be disabled on most mobs
	/// Will the mob continue to hunt you down forever and ever, even if they cant see you?
	var/even_robuster_searching = FALSE // okay maybe just 30 seconds
	/// Distance that a mob can detect a non-hidden target
	var/vision_range = 9
	/// Distance that a mob can track a target its mad at
	var/aggro_vision_range = 9 // try to keep this at or aboove vision_range, otherwise they might get stuck getting mad at nothing
	var/search_objects = 0 //If we want to consider objects when searching around, set this to 1. If you want to search for objects while also ignoring mobs until hurt, set it to 2. To completely ignore mobs, even when attacked, set it to 3
	var/search_objects_timer_id //Timer for regaining our old search_objects value after being attacked
	var/search_objects_regain_time = 30 //the delay between being attacked and gaining our old search_objects value back
	var/list/wanted_objects = list() //A typecache of objects types that will be checked against to attack, should we have search_objects enabled
	var/stat_attack = CONSCIOUS //Mobs with stat_attack to UNCONSCIOUS will attempt to attack things that are unconscious, Mobs with stat_attack set to DEAD will attempt to attack the dead.
	var/stat_exclusive = FALSE //Mobs with this set to TRUE will exclusively attack things defined by stat_attack, stat_attack DEAD means they will only attack corpses
	var/attack_same = 0 //Set us to 1 to allow us to attack our own faction
	var/datum/weakref/targetting_origin = null //all range/attack/etc. calculations should be done from this atom, defaults to the mob itself, useful for Vehicles and such
	var/attack_all_objects = FALSE //if true, equivalent to having a wanted_objects list containing ALL objects.

	var/lose_patience_timer_id //id for a timer to call LoseTarget(), used to stop mobs fixating on a target they can't reach
	var/lose_patience_timeout = 300 //30 seconds by default, so there's no major changes to AI behaviour, beyond actually bailing if stuck forever

	var/peaceful = FALSE //Determines if mob is actively looking to attack something, regardless if hostile by default to the target or not

//These vars activate certain things on the mob depending on what it hears
	var/attack_phrase = "" //Makes the mob become hostile (if it wasn't beforehand) upon hearing
	var/peace_phrase = "" //Makes the mob become peaceful (if it wasn't beforehand) upon hearing
	var/reveal_phrase = "" //Uncamouflages the mob (if it were to become invisible via the alpha var) upon hearing
	var/hide_phrase = "" //Camouflages the mob (Sets it to a defined alpha value, regardless if already 'hiddeb') upon hearing

	/// Probability it'll do some other kind of melee attack, like a knockback hit.
	var/alternate_attack_prob = 0
	/// At what percent of their health does the mob change states? Like, get ANGY on low-health or something. set to 0 or FALSE to disable
	/// Is a decimal, 0 through 1. 0.5 means half health, 0.25 is quarter health, etc
	var/low_health_threshold = 0
	/// Has the mob done its Low Health thing?
	var/is_low_health = FALSE
	/// Does this mob un-itself if nobody's on the Z level?
	var/despawns_when_lonely = TRUE
	/// timer for despawning when lonely
	var/lonely_timer_id

	speed = 3//The default hostile mob speed. If you ever speed the mob ss again please raise this to compensate.

/mob/living/simple_animal/hostile/Initialize(mapload)
	. = ..()
	set_origin(src)
	wanted_objects = typecacheof(wanted_objects)
	if(MOB_EMP_DAMAGE in emp_flags)
		smoke = new /datum/effect_system/smoke_spread/bad
		smoke.attach(src)
	if(mapload && despawns_when_lonely)
		unbirth_self(TRUE)

/mob/living/simple_animal/hostile/Destroy()
	unset_origin()
	unset_target()
	friends = null
	foes = null
	GiveTarget(null)
	if(smoke)
		QDEL_NULL(smoke)
	return ..()

/mob/living/simple_animal/hostile/BiologicalLife(seconds, times_fired)
	if(!CHECK_BITFIELD(mobility_flags, MOBILITY_MOVE))
		walk(src, 0)

	if(!(. = ..()))
		walk(src, 0) //stops walking
		/*if(decompose && COOLDOWN_FINISHED(src, decomposition_schedule))
			visible_message(span_notice("\The dead body of the [src] decomposes!"))
			dust(TRUE)*/
		if(prob(1) && world.time-timeofdeath > 3 MINUTES)//give players enough time to finish their fights and butcher the real way
			visible_message(span_notice("\The dead body of the [src] decomposes!"))
			gib(FALSE, FALSE, FALSE, TRUE)
		return
	queue_naptime()
	check_health()

/mob/living/simple_animal/hostile/proc/check_health()
	if(low_health_threshold <= 0)
		return FALSE
	if(stat == DEAD)
		return FALSE
	if (QDELETED(src)) // diseases can qdel the mob via transformations
		return FALSE
	
	if(is_low_health && health > (maxHealth * low_health_threshold)) // no longer low health
		make_high_health()
		return TRUE
	if(!is_low_health && health < (maxHealth * low_health_threshold))
		make_low_health()
		return TRUE

/// Override this with what should happen when going from low health to high health
/mob/living/simple_animal/hostile/proc/make_high_health()
	return

/// Override this with what should happen when going from high health to low health
/mob/living/simple_animal/hostile/proc/make_low_health()
	return

/mob/living/simple_animal/hostile/handle_automated_action()
	if(AIStatus == AI_OFF) // hard off switch
		return 0
	if(incapacitated())
		return FALSE
	/// first try to kick our way free of whatever
	if(EscapeConfinement()) // we get one kick per turn
		return TRUE
	// if(DoingSomething())
	// 	return TRUE
	/// Now try to do interesting things
	/// find us a target, or retrieve our current one, either'll do
	var/atom/mytarget = PollTarget()
	/// If we're in the middle of something, do the stuff we're in the middle of
	if(mytarget)
		return ActiveHostile(mytarget)
	else
		return SleepyHostile()






	if(AICanContinue(possible_targets))
		var/atom/my_origin = get_origin()
		var/atom/my_target = get_target()
		if(my_target && !QDELETED(target) && my_origin && !my_origin.Adjacent(target))
			DestroyPathToTarget()
		if(!MoveToTarget())     //if we lose our target
			if(AIShouldSleep(possible_targets))	// we try to acquire a new one
				toggle_ai(AI_IDLE)			// otherwise we go idle
	consider_despawning()
	return 1

/// returns either our current target, or a new one, or nothing at all!
/mob/living/simple_animal/hostile/proc/PollTarget()
	var/atom/targa = get_target()
	if(istype(targa))
		return targa
	return FindTarget(possible_targets)

/mob/living/simple_animal/hostile/proc/ActiveHostile(atom/my_target)
	/// first, do we have a target? if so, good!
	if(!isatom(my_target))
		if(target)
			my_target = get_target()
			if(!target)
				return FALSE
	var/coolflags = 0
	// target locked, now do things
	/// JK, first check if we're allowed to attack our target
	if(!AllowedToAttackTarget(my_target))
		return MoveToTarget()
	coolflags |= HOSTILE_AI_FLAG_ALLOWED_TO_ATTACK // skip a few chacks later
	if(!CanSeeTarget(my_target, TRUE))
		return MoveToTarget()
	coolflags |= HOSTILE_AI_FLAG_CAN_SEE_TARGET // skip a few chacks later
	/// first, can we punch em?
	if(COOLDOWN_FINISHED(src, melee_cooldown))
		if(telegraphs_melee)
			TelegraphMeleeAttack(target, coolflags)
		else
			InitiateMeleeAttack(my_target, coolflags)
	/// if not, can we shoot em?
	if(COOLDOWN_FINISHED(src, ranged_cooldown))
		if(InitiateRangedAttack(my_target, coolflags))
			if(!can_move_and_shoot) // Allowed to move and shoot on the same turn?
				return TRUE
	/// if not, try to get closer
	if(MoveToTarget())
		return TRUE





/mob/living/simple_animal/hostile/handle_automated_movement()
	. = ..()
	if(!CHECK_BITFIELD(mobility_flags, MOBILITY_MOVE))
		return
	var/atom/my_target = get_target()
	if(dodging && my_target && in_melee && isturf(loc) && isturf(my_target.loc))
		var/datum/cb = CALLBACK(src,.proc/sidestep)
		if(sidestep_per_cycle > 1) //For more than one just spread them equally - this could changed to some sensible distribution later
			var/sidestep_delay = SSnpcpool.wait / sidestep_per_cycle
			for(var/i in 1 to sidestep_per_cycle)
				addtimer(cb, (i - 1)*sidestep_delay)
		else //Otherwise randomize it to make the players guessing.
			addtimer(cb,rand(1,SSnpcpool.wait))

/mob/living/simple_animal/hostile/toggle_ai(togglestatus)
	. = ..()
	queue_naptime()

/mob/living/simple_animal/hostile/proc/queue_naptime()
	var/go2bed = consider_despawning()
	if(go2bed)
		if(lonely_timer_id)
			return
		lonely_timer_id = addtimer(CALLBACK(src, .proc/queue_unbirth), 30 SECONDS, TIMER_STOPPABLE)
	else
		if(!lonely_timer_id)
			return
		deltimer(lonely_timer_id)
		lonely_timer_id = null	
		unqueue_unbirth()

/mob/living/simple_animal/hostile/proc/consider_despawning()
	if(!despawns_when_lonely)
		return FALSE
	if(ckey)
		return FALSE
	if(lazarused)
		return FALSE
	if(stat == DEAD)
		return FALSE
	if(CHECK_BITFIELD(datum_flags, DF_VAR_EDITED))
		return FALSE
	if(CHECK_BITFIELD(flags_1, ADMIN_SPAWNED_1))
		return FALSE
	if(health <= 0)
		return FALSE
	if(AIStatus == AI_ON || AIStatus == AI_OFF)
		return FALSE
	return TRUE

/mob/living/simple_animal/hostile/become_the_mob(mob/user)
	if(lonely_timer_id)
		deltimer(lonely_timer_id)
		lonely_timer_id = null	
	unqueue_unbirth()
	. = ..()


/mob/living/simple_animal/hostile/proc/sidestep()
	var/atom/my_target = get_target()
	if(!my_target || !isturf(my_target.loc) || !isturf(loc) || stat == DEAD)
		return
	var/target_dir = get_dir(src,my_target)

	var/static/list/cardinal_sidestep_directions = list(-90,-45,0,45,90)
	var/static/list/diagonal_sidestep_directions = list(-45,0,45)
	var/chosen_dir = 0
	if (target_dir & (target_dir - 1))
		chosen_dir = pick(diagonal_sidestep_directions)
	else
		chosen_dir = pick(cardinal_sidestep_directions)
	if(chosen_dir)
		chosen_dir = turn(target_dir,chosen_dir)
		Move(get_step(src,chosen_dir))
		face_atom(my_target) //Looks better if they keep looking at you when dodging

/mob/living/simple_animal/hostile/attacked_by(obj/item/I, mob/living/user, attackchain_flags = NONE, damage_multiplier = 1, damage_addition, damage_override)
	if (peaceful == TRUE)
		peaceful = FALSE
	if(stat == CONSCIOUS && !get_target() && AIStatus != AI_OFF && !client && user)
		FindTarget(list(user), 1)
	return ..()

/mob/living/simple_animal/hostile/bullet_act(obj/item/projectile/P)
	. = ..()
	if (peaceful == TRUE)
		peaceful = FALSE
	if(stat == CONSCIOUS && !get_target() && AIStatus != AI_OFF && !client)
		if(P.firer && get_dist(src, P.firer) <= aggro_vision_range)
			FindTarget(list(P.firer), 1)
		Goto(P.starting, move_to_delay, 3)
	//return ..()

/mob/living/simple_animal/hostile/Hear(message, atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, message_mode, atom/movable/source)
	. = ..()
	if (raw_message == attack_phrase)
		alpha = 255
		peaceful = FALSE
	if (raw_message == peace_phrase)
		peaceful = TRUE
	if (raw_message == reveal_phrase)
		alpha = 255
	if (raw_message == hide_phrase)
		alpha = 90
	return ..()

//////////////HOSTILE MOB TARGETTING AND AGGRESSION////////////

/mob/living/simple_animal/hostile/proc/ListTargets()//Step 1, find out what we can see
	var/atom/origin = get_origin()
	if(!search_objects)
		. = hearers(vision_range, origin) - src //Remove self

		var/static/hostile_machines = typecacheof(list(/obj/machinery/porta_turret, /obj/mecha, /obj/structure/destructible/clockwork/ocular_warden,/obj/item/electronic_assembly))

		for(var/HM in typecache_filter_list(range(vision_range, origin), hostile_machines))
			CHECK_TICK
			if(can_see(origin, HM, vision_range))
				. += HM
	else
		. = list() // The following code is only very slightly slower than just returning oview(vision_range, origin), but it saves us much more work down the line, particularly when bees are involved
		for (var/obj/A in oview(vision_range, origin))
			CHECK_TICK
			. += A
		for (var/mob/living/A in oview(vision_range, origin)) //mob/dead/observers arent possible targets
			CHECK_TICK
			. += A

/// Takes in a list of targets (or gets one) and returns a target!
/mob/living/simple_animal/hostile/proc/FindTarget(list/possible_targets, HasTargetsList = 0)//Step 2, filter down possible targets to things we actually care about
	. = list()
	if (peaceful == FALSE)
		if(!HasTargetsList)
			possible_targets = ListTargets()
		for(var/pos_targ in possible_targets)
			var/atom/A = pos_targ
			if(Found(A))//Just in case people want to override targetting
				. = list(A)
				break
			if(AllowedToAttackTarget(A))//Can we attack it?
				. += A
				continue
		var/Target = PickTarget(.)
		GiveTarget(Target)
		COOLDOWN_START(src, sight_shoot_delay, sight_shoot_delay_time)
		return Target //We now have a targettte

/mob/living/simple_animal/hostile/proc/PossibleThreats()
	. = list()
	for(var/pos_targ in ListTargets())
		var/atom/A = pos_targ
		if(Found(A))
			. = list(A)
			break
		if(AllowedToAttackTarget(A))
			. += A
			continue

/mob/living/simple_animal/hostile/proc/Found(atom/A)//This is here as a potential override to pick a specific targette if available
	return

/mob/living/simple_animal/hostile/proc/PickTarget(list/Targets)//Step 3, pick amongst the possible, attackable targets
	var/atom/my_target = get_target()
	if(my_target != null)//If we already have a targette, but are told to pick again, calculate the lowest distance between all possible, and pick from the lowest distance targets
		for(var/pos_targ in Targets)
			var/atom/A = pos_targ
			var/atom/origin = get_origin()
			var/target_dist = get_dist(origin, my_target)
			var/possible_target_distance = get_dist(origin, A)
			if(target_dist < possible_target_distance)
				Targets -= A
	if(!Targets.len)//We didnt find nothin!
		return
	var/chosen_target = pick(Targets)//Pick the remaining targets (if any) at random
	return chosen_target

// Please do not add one-off mob AIs here, but override this function for your mob
/// Returns if we're actually allowed to attack the target
/mob/living/simple_animal/hostile/AllowedToAttackTarget(atom/the_target)//Can we actually attack a possible targette?
	if(!the_target || the_target.type == /atom/movable/lighting_object || isturf(the_target)) // bail out on invalids
		return FALSE

	if(ismob(the_target)) //Target is in godmode, ignore it.
		var/mob/M = the_target
		if(M.status_flags & GODMODE)
			return FALSE
		if(!M.client)
			var/client_in_range = FALSE
			for(var/client/C in GLOB.clients)
				if(get_dist(M, C) < SSmobs.distance_where_a_player_needs_to_be_in_for_npcs_to_fight_other_npcs)
					client_in_range = TRUE
					break
			if(!client_in_range)
				return FALSE

	if(search_objects < 2)
		if(isliving(the_target))
			var/mob/living/L = the_target
			if(SEND_SIGNAL(L, COMSIG_HOSTILE_CHECK_FACTION, src) == SIMPLEMOB_IGNORE)
				return FALSE
			var/faction_check = !(L in foes) && faction_check_mob(L)
			if(robust_searching)
				if(faction_check && !attack_same)
					return FALSE
				if(L.stat > stat_attack)
					return FALSE
				if(stat_attack == CONSCIOUS && IS_STAMCRIT(L))
					return FALSE
				if(L.stat == UNCONSCIOUS && stat_attack == UNCONSCIOUS && HAS_TRAIT(L, TRAIT_DEATHCOMA))
					return FALSE
				if(friends[L] > 0 && foes[L] < 1)
					return FALSE
			else
				if((faction_check && !attack_same) || L.stat)
					return FALSE
			return TRUE

		if(ismecha(the_target))
			var/obj/mecha/M = the_target
			if(M.occupant)//Just so we don't attack empty mechs
				if(AllowedToAttackTarget(M.occupant))
					return TRUE

		if(istype(the_target, /obj/machinery/porta_turret))
			var/obj/machinery/porta_turret/P = the_target
			if(P.in_faction(src)) //Don't attack if the turret is in the same faction
				return FALSE
			if(P.has_cover &&!P.raised) //Don't attack invincible turrets
				return FALSE
			if(P.stat & BROKEN) //Or turrets that are already broken
				return FALSE
			return TRUE

		if(istype(the_target, /obj/item/electronic_assembly))
			var/obj/item/electronic_assembly/O = the_target
			if(O.combat_circuits)
				return TRUE

	if(isobj(the_target))
		if(attack_all_objects || is_type_in_typecache(the_target, wanted_objects))
			return TRUE

	return FALSE

/mob/living/simple_animal/hostile/proc/GiveTarget(new_target)//Step 4, give us our selected targette
	add_target(new_target)
	LosePatience()
	if(get_target() != null)
		GainPatience()
		Aggro()
		return 1

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////........../////////////////////......................
////////////////////////////////////..........///////////////////////////////////////////
//// MELEE ATTACKING ///////////////..........///////////////////////////////////////////
////////////////////////////////////........../////////////////////......................
///////////////////////////////////////////////////////////////////......................
/////////////////////////////////////////////////////////////////////////////////////////

/// Do an effect to telegraph that we're gonna punch em
/mob/living/simple_animal/hostile/proc/TelegraphMeleeAttack(atom/target, hostile_flags = NONE)
	if(!target)
		return FALSE
	if(windup_timer_id) // we're in the middle of scrotiographing an attack, it'll handle it dont worry
		return FALSE
	hostile_flags |= HOSTILE_AI_TELEGRAPHING_MELEE
	if(!PreMeleeAttack(target, hostile_flags))
		in_melee = FALSE
		return FALSE
	var/m_rd = retreat_distance
	var/m_md = minimum_distance
	/// also a cooldown, just in case something gets interrupted
	COOLDOWN_START(src, winding_up_melee, melee_windup_time*2) //Don't increase our retreating distance while winding up
	retreat_distance = null //Stop retreating
	minimum_distance = 1 //Stop moving away
	if(melee_windup_sound)
		playsound(src.loc, melee_windup_sound, 150, TRUE, distant_range = 4)	//Play the windup sound effect to warn that an attack is coming.
	// if(do_after(user=src,delay=melee_windup_time,needhand=FALSE,progress=FALSE,required_mobility_flags=null,allow_movement=TRUE,stay_close=FALSE,public_progbar=FALSE))
	// 	my_target = get_target() //Switch targets if we did during our windup.
	// 	if(my_target && Adjacent(my_target)) //If we waited, check if we died or something before finishing the attack windup. If so, don't attack.
	// 		retreat_distance = m_rd
	// 		minimum_distance = m_md
	// 		winding_up_melee = FALSE
	// 		return my_target.attack_animal(src)
	// 	else
	// 		retreat_distance = m_rd
	// 		minimum_distance = m_md
	// 		winding_up_melee = FALSE
	// 		return FALSE
	// else
	// 	retreat_distance = m_rd
	// 	minimum_distance = m_md
	// 	winding_up_melee = FALSE
	// 	return FALSE
	INVOKE_ASYNC(src, /atom/.proc/do_windup, melee_windup_magnitude, melee_windup_time)	//Bouncing bitches.
	windup_timer_id = addtimer(CALLBACK(src, .proc/TelegraphSwingFinish, target, HOSTILE_AI_FLAG_WAS_TELEGRAPHED), melee_windup_time) // see you in a bit!
	return TRUE

//Just a thing that whiffs if the target either doesnt exist or is out of range
/mob/living/simple_animal/hostile/proc/TelegraphSwingFinish(atom/my_target, hostile_flags = NONE)
	if(!my_target)
		return FALSE
	if(!InitiateMeleeAttack(my_target, hostile_flags))
		return Whiff() // whiff!

//Does a whiff
/mob/living/simple_animal/hostile/proc/Whiff()
	var/turf/where_to_whiff = get_step(src, dir)
	if(!isturf(where_to_whiff))
		return FALSE
	do_attack_animation(where_to_whiff)
	playsound(where_to_whiff, "sound/effects/eq_whiff.ogg")


/mob/living/simple_animal/hostile/proc/InitiateMeleeAttack(atom/target, hostile_flags = NONE)
	if(!target)
		target = get_target()
	if(!target)
		return FALSE
	if(CHECK_BITFIELD(hostile_flags, HOSTILE_AI_FLAG_WAS_TELEGRAPHED) || COOLDOWN_FINISHED(src,winding_up_melee))
		winding_up_melee = FALSE
		windup_timer_id = 0
	if(winding_up_melee) // we're in the middle of scrotiographing an attack, it'll handle it dont worry
		return FALSE // or it been a while
	/// performs one or more attacks on the target
	if(!MeleeAttackTargetLoop(target, hostile_flags))
		return FALSE


/// checks if we can attack the thing, then attacks the thing over and over
/mob/living/simple_animal/hostile/proc/MeleeAttackTargetLoop(atom/target, hostile_flags = NONE)
	if(!target)
		return FALSE
	if(!MeleeAttackChain(target, hostile_flags))
		return FALSE
	if(rapid_melee > 1)
		var/datum/callback/cb = CALLBACK(src, .proc/MeleeAttackChain, target)
		var/delay = SSnpcpool.wait / rapid_melee
		for(var/i in 1 to rapid_melee)
			addtimer(cb, (i - 1)*delay)
	return TRUE

/// okay the ACTUAL proc that does the punching
/mob/living/simple_animal/hostile/proc/MeleeAttackChain(atom/target, hostile_flags = NONE)
	if(!target)
		target = get_target()
	if(!target)
		return FALSE
	if(!PreMeleeAttack(target, hostile_flags))
		in_melee = FALSE
		return FALSE
	if(!MeleeAttackTarget(target, hostile_flags))
		return FALSE
	PostMeleeAttack(target, hostile_flags)
	return TRUE

/// check if we're able to punch em
/mob/living/simple_animal/hostile/proc/PreMeleeAttack(atom/target, hostile_flags)
	var/atom/origin = get_origin()
	if(!origin || !isturf(origin.loc))
		return FALSE
	if(!target || !isturf(target.loc))
		return FALSE
	if(!CHECK_BITFIELD(hostile_flags, HOSTILE_AI_FLAG_ALLOWED_TO_ATTACK))
		if(!AllowedToAttackTarget(target))
			return FALSE
	if(!CHECK_BITFIELD(hostile_flags, HOSTILE_AI_FLAG_CAN_SEE_TARGET))
		if(!CanSeeTarget(target, TRUE))
			return FALSE // its fine
	if(!origin.Adjacent(target))
		return FALSE
	in_melee = TRUE
	return TRUE

/mob/living/simple_animal/hostile/proc/MeleeAttackTarget(atom/target)
	var/atom/my_target = get_target()
	SEND_SIGNAL(src, COMSIG_HOSTILE_ATTACKINGTARGET, my_target)
	if(prob(alternate_attack_prob) && AlternateAttackingTarget(my_target))
		return FALSE
	else
		. = my_target.attack_animal(src)
	if(patience)
		GainPatience()

/// Cleaning up after an attack has been made
/mob/living/simple_animal/hostile/proc/PostMeleeAttack(atom/target, hostile_flags)
	COOLDOWN_START(src, melee_cooldown, melee_attack_cooldown)


////////////////////////////////////////////////////////////////////
//// RANGED ATTACKING //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
/////////////////////.............................................................////

/mob/living/simple_animal/hostile/proc/CheckFriendlyFire(atom/A)
	if(ckey)
		return FALSE
	if(!check_friendly_fire)
		return FALSE
	if(!A)
		return FALSE
	for(var/turf/T in getline(src,A)) // Not 100% reliable but this is faster than simulating actual trajectory
		for(var/mob/living/L in T)
			if(L == src || L == A)
				continue
			if(faction_check_mob(L) && !attack_same)
				return TRUE

/mob/living/simple_animal/hostile/proc/OpenFire(atom/A)
	if(!ranged || (!projectiletype && !casingtype))
		return FALSE
	if(COOLDOWN_TIMELEFT(src, sight_shoot_delay))
		return FALSE
	if(CheckFriendlyFire(A))
		return
	visible_message(span_danger("<b>[src]</b> [islist(ranged_message) ? pick(ranged_message) : ranged_message] at [A]!"))
	if(rapid > 1)
		var/datum/callback/cb = CALLBACK(src, .proc/Shoot, A)
		for(var/i in 1 to rapid)
			addtimer(cb, (i - 1)*rapid_fire_delay)
	else
		Shoot(A)
		for(var/i in 1 to extra_projectiles)
			addtimer(CALLBACK(src, .proc/Shoot, A), i * auto_fire_delay)
	ThrowSomething(A)
	COOLDOWN_START(src, ranged_cooldown, ranged_cooldown_time)
	if(sound_after_shooting)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, sound_after_shooting, 100, 0, 0), sound_after_shooting_delay, TIMER_STOPPABLE)
	if(projectiletype)
		if(LAZYLEN(variation_list[MOB_PROJECTILE]) >= 2) // Gotta have multiple different projectiles to cycle through
			projectiletype = vary_from_list(variation_list[MOB_PROJECTILE], TRUE)
	if(casingtype)
		if(LAZYLEN(variation_list[MOB_CASING]) >= 2) // Gotta have multiple different casings to cycle through
			casingtype = vary_from_list(variation_list[MOB_CASING], TRUE)





/mob/living/simple_animal/hostile/proc/MoveToTarget(atom/my_target)//Step 5, handle movement between us and our targette
	if(!my_target)
		LoseTarget()
		return FALSE
	stop_automated_movement = 1
	if (peaceful == TRUE)
		LoseTarget()
		return FALSE
	// if(winding_up_melee)
	// 	return FALSE
	if(!AllowedToAttackTarget(my_target) || !CanSeeTarget(my_target, TRUE))
		LoseTarget()
		return FALSE
	/// by now we've determined that we can see our target and are allowed to attack it, lets go get em
	var/atom/origin = get_origin()
	var/target_distance = get_dist(origin,my_target)
	if(ranged) //We ranged? Shoot at em
		if(!my_target.Adjacent(origin) && ranged_cooldown <= world.time) //But make sure they're not in range for a melee attack and our range attack is off cooldown
			OpenFire(my_target)
	if(!Process_Spacemove()) //Drifting
		walk(src,0)
		return 1
	if(retreat_distance != null && !winding_up_melee) //If we have a retreat distance and aren't winding up an attack, check if we need to run from our targette
		if(target_distance <= retreat_distance && CHECK_BITFIELD(mobility_flags, MOBILITY_MOVE)) //If targette's closer than our retreat distance, run
			set_glide_size(DELAY_TO_GLIDE_SIZE(move_to_delay))
			walk_away(src,my_target,retreat_distance,move_to_delay)
		else
			Goto(my_target,move_to_delay,minimum_distance) //Otherwise, get to our minimum distance so we chase them
	else
		Goto(my_target,move_to_delay,minimum_distance)
	/// roll to randomize this thing... if its an option
	if(!winding_up_melee && variation_list[MOB_RETREAT_DISTANCE_CHANCE] && LAZYLEN(variation_list[MOB_RETREAT_DISTANCE]) && prob(variation_list[MOB_RETREAT_DISTANCE_CHANCE]))
		retreat_distance = vary_from_list(variation_list[MOB_RETREAT_DISTANCE])
	// if(my_target)
	// 	if(COOLDOWN_TIMELEFT(src, melee_cooldown))
	// 		return TRUE
	// 	COOLDOWN_START(src, melee_cooldown, melee_attack_cooldown)
	// 	if(!winding_up_melee && origin && isturf(origin.loc) && my_target.Adjacent(origin)) //If they're next to us, attack
	// 		MeleeAction()
	// 	else
	// 		if(!winding_up_melee && rapid_melee > 1 && target_distance <= melee_queue_distance)
	// 			MeleeAction(FALSE)
	// 		in_melee = FALSE //If we're just preparing to strike do not enter sidestep mode
	// 	return TRUE
	if(!FindHidden()) // calls Goto
		Goto(my_target,move_to_delay,minimum_distance)
		return TRUE
	return FALSE

// Checks if the target is visible to us
/mob/living/simple_animal/hostile/proc/CanSeeTarget(atom/my_target, already_targetted)
	if(!istype(my_target))
		return FALSE
	if(see_invisible < my_target.invisibility)//Target's invisible to us, forget it
		return FALSE
	var/turf/T = get_turf(src)
	if(my_target.z != T.z)
		return FALSE
	if(already_targetted && even_robuster_searching) // smart mobs can chase you through walls!
		return (get_dist(get_turf(src), get_turf(my_target)) <= aggro_vision_range)
	return (my_target in view(vision_range, get_turf(src)))

/mob/living/simple_animal/hostile/proc/Goto(targette, delay, minimum_distance)
	var/atom/my_target = get_target()
	if(my_target == targette)
		approaching_target = TRUE
	else
		approaching_target = FALSE
	if(CHECK_BITFIELD(mobility_flags, MOBILITY_MOVE))
		set_glide_size(DELAY_TO_GLIDE_SIZE(move_to_delay))
		walk_to(src, my_target, minimum_distance, delay)
	if(variation_list[MOB_MINIMUM_DISTANCE_CHANCE] && LAZYLEN(variation_list[MOB_MINIMUM_DISTANCE]) && prob(variation_list[MOB_MINIMUM_DISTANCE_CHANCE]))
		if(winding_up_melee)//Stay in melee range for the whole attack
			minimum_distance = 1
		else
			minimum_distance = vary_from_list(variation_list[MOB_MINIMUM_DISTANCE])
	if(variation_list[MOB_VARIED_SPEED_CHANCE] && LAZYLEN(variation_list[MOB_VARIED_SPEED]))
		if(prob(variation_list[MOB_VARIED_SPEED_CHANCE]))
			move_to_delay = vary_from_list(variation_list[MOB_VARIED_SPEED])
		if(prob(variation_list[MOB_VARIED_SPEED_CHANCE]))
			set_varspeed(pick(variation_list[MOB_VARIED_SPEED]))


/mob/living/simple_animal/hostile/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(!ckey && !stat && search_objects < 3 && . > 0)//Not unconscious, and we don't ignore mobs
		if(peaceful == TRUE)
			peaceful = FALSE
		if(search_objects)//Turn off item searching and ignore whatever item we were looking at, we're more concerned with fight or flight
			LoseTarget()
			LoseSearchObjects()
		if(AIStatus != AI_ON && AIStatus != AI_OFF)
			toggle_ai(AI_ON)
			FindTarget()
		else if(get_target() != null && prob(40))//No more pulling a mob forever and having a second player attack it, it can switch targets now if it finds a more suitable one
			FindTarget()

/// Does an extra *thing* when attacking. Return TRUE to not do the standard attack
/mob/living/simple_animal/hostile/proc/AlternateAttackingTarget(atom/the_target)
	return

/mob/living/simple_animal/hostile/proc/Aggro()
	if(ckey)
		return TRUE
	vision_range = aggro_vision_range
	var/atom/my_target = get_target()
	if(my_target && LAZYLEN(emote_taunt) && prob(taunt_chance))
		INVOKE_ASYNC(src, .proc/emote, "me", EMOTE_VISIBLE, "[pick(emote_taunt)] at [my_target].")
		taunt_chance = max(taunt_chance-7,2)
	if(LAZYLEN(emote_taunt_sound))
		var/taunt_choice = pick(emote_taunt_sound)
		playsound(loc, taunt_choice, 50, 0, vary = FALSE, frequency = SOUND_FREQ_NORMALIZED(sound_pitch, vary_pitches[1], vary_pitches[2]))


/mob/living/simple_animal/hostile/proc/LoseAggro()
	stop_automated_movement = 0
	vision_range = initial(vision_range)
	taunt_chance = initial(taunt_chance)

/mob/living/simple_animal/hostile/proc/LoseTarget()
	GiveTarget(null)
	approaching_target = FALSE
	in_melee = FALSE
	walk(src, 0)
	LoseAggro()

//////////////END HOSTILE MOB TARGETTING AND AGGRESSION////////////

/mob/living/simple_animal/hostile/death(gibbed)
	LoseTarget()
	..(gibbed)

/mob/living/simple_animal/hostile/proc/summon_backup(distance, exact_faction_match)
	if(COOLDOWN_FINISHED(src, ding_spam_cooldown))
		return TRUE
	COOLDOWN_START(src, ding_spam_cooldown, SIMPLE_MOB_DING_COOLDOWN)
	do_alert_animation(src)
	playsound(loc, 'sound/machines/chime.ogg', 50, 1, -1)
	for(var/mob/living/simple_animal/hostile/M in oview(distance, get_origin()))
		if(faction_check_mob(M, TRUE))
			if(M.AIStatus == AI_OFF || M.stat == DEAD || M.ckey)
				return
			M.Goto(src,M.move_to_delay,M.minimum_distance)

/mob/living/simple_animal/hostile/proc/ThrowSomething(atom/targeted_atom)
	if(!istype(throw_thing) || !istype(targeted_atom))
		return
	if(!COOLDOWN_FINISHED(src, throw_cooldown))
		return
	COOLDOWN_START(src, throw_cooldown, throw_delay)
	var/obj/item/tosser = new throw_thing(get_turf(src))
	tosser.throw_at(targeted_atom, 25, throw_thing_speed, src, TRUE, TRUE)
	playsound(src, throw_thing_sound, 100, TRUE)
	visible_message(span_alert("[src] throws [tosser] at [targeted_atom]!"))

/mob/living/simple_animal/hostile/proc/Shoot(atom/targeted_atom)
	var/atom/origin = get_origin()
	if( !origin || QDELETED(targeted_atom) || targeted_atom == origin.loc || targeted_atom == origin )
		return
	var/turf/startloc = get_turf(origin)
	if(casingtype)
		var/obj/item/ammo_casing/casing = new casingtype(startloc)
		playsound(
			src,
			projectilesound,
			projectile_sound_properties[SOUND_PROPERTY_VOLUME],
			projectile_sound_properties[SOUND_PROPERTY_VARY],
			projectile_sound_properties[SOUND_PROPERTY_NORMAL_RANGE],
			ignore_walls = projectile_sound_properties[SOUND_PROPERTY_IGNORE_WALLS],
			distant_sound = projectile_sound_properties[SOUND_PROPERTY_DISTANT_SOUND],
			distant_range = projectile_sound_properties[SOUND_PROPERTY_DISTANT_SOUND_RANGE], 
			vary = FALSE, 
			frequency = SOUND_FREQ_NORMALIZED(sound_pitch, vary_pitches[1], vary_pitches[2])
			)
		casing.factionize(faction)
		casing.fire_casing(targeted_atom, src, null, null, null, ran_zone(), 0, null, null, null, src)
		qdel(casing)
	else if(projectiletype)
		var/obj/item/projectile/P = new projectiletype(startloc)
		P.factionize(faction)
		playsound(
			src,
			projectilesound,
			projectile_sound_properties[SOUND_PROPERTY_VOLUME],
			projectile_sound_properties[SOUND_PROPERTY_VARY],
			projectile_sound_properties[SOUND_PROPERTY_NORMAL_RANGE],
			ignore_walls = projectile_sound_properties[SOUND_PROPERTY_IGNORE_WALLS],
			distant_sound = projectile_sound_properties[SOUND_PROPERTY_DISTANT_SOUND],
			distant_range = projectile_sound_properties[SOUND_PROPERTY_DISTANT_SOUND_RANGE], 
			vary = FALSE, 
			frequency = SOUND_FREQ_NORMALIZED(sound_pitch, vary_pitches[1], vary_pitches[2])
			)
		P.starting = startloc
		P.firer = src
		P.fired_from = src
		P.yo = targeted_atom.y - startloc.y
		P.xo = targeted_atom.x - startloc.x
		if(AIStatus != AI_ON)//Don't want mindless mobs to have their movement screwed up firing in space
			newtonian_move(get_dir(targeted_atom, origin))
		P.original = targeted_atom
		P.preparePixelProjectile(targeted_atom, src)
		P.fire()
		return P

/mob/living/simple_animal/hostile/proc/CanSmashTurfs(turf/T)
	return iswallturf(T) || ismineralturf(T)


/mob/living/simple_animal/hostile/Move(atom/newloc, dir , step_x , step_y)
	if(!winding_up_melee && dodging && approaching_target && prob(dodge_prob) && moving_diagonally == 0 && isturf(loc) && isturf(newloc))
		return dodge(newloc,dir)
	else
		return ..()

/mob/living/simple_animal/hostile/proc/dodge(moving_to,move_direction)
	var/cdir = turn(move_direction,90)
	var/ccdir = turn(move_direction,-90)
//	var/next_step_dir = pick(cdir,ccdir) sworddoggirl is way too cute ~Fenny

	dodging = FALSE
	. = Move(get_step(loc,pick(cdir,ccdir)))
	if(!.) //Can't dodge there!
		visible_message("<span class='notice'>[src] dodges!</span>")
		playsound(loc, 'sound/effects/rustle3.ogg', 50, 1, -1)
	else
		// Apply stamina damage if the mob tried to dodge into a wall
		adjustStaminaLoss(10)
		visible_message("<span class='notice'>[src] tries to dodge but hits a wall!</span>")
		playsound(loc, 'sound/effects/hit_punch.ogg', 50, 1, -1) // Play a punch sound
	dodging = TRUE

/mob/living/simple_animal/hostile/proc/DestroyObjectsInDirection(direction)
	var/atom/origin = get_origin()
	if(!origin)
		return
	var/turf/T = get_step(origin, direction)
	if(T && T.Adjacent(origin))
		if(CanSmashTurfs(T))
			T.attack_animal(src)
		for(var/obj/O in T)
			if(O.density && environment_smash >= ENVIRONMENT_SMASH_STRUCTURES && !O.IsObscured())
				O.attack_animal(src)
				return


/mob/living/simple_animal/hostile/proc/DestroyPathToTarget()
	if(environment_smash)
		EscapeConfinement()
		var/dir_to_target = get_dir(get_origin(), get_target())
		var/dir_list = list()
		if(dir_to_target in GLOB.diagonals) //it's diagonal, so we need two directions to hit
			for(var/direction in GLOB.cardinals)
				if(direction & dir_to_target)
					dir_list += direction
		else
			dir_list += dir_to_target
		for(var/direction in dir_list) //now we hit all of the directions we got in this fashion, since it's the only directions we should actually need
			DestroyObjectsInDirection(direction)


mob/living/simple_animal/hostile/proc/DestroySurroundings() // for use with megafauna destroying everything around them
	if(environment_smash)
		EscapeConfinement()
		for(var/dir in GLOB.cardinals)
			DestroyObjectsInDirection(dir)

/// checks if we're contained in something and tries to escape, returns TRUE if we're contained
/mob/living/simple_animal/hostile/proc/EscapeConfinement()
	if(buckled)
		buckled.attack_animal(src)
		return TRUE
	var/atom/origin = get_origin()
	if(!origin)
		return
	var/container = origin.loc
	if(!container)
		return
	if(!container.density)
		return
	if(!isturf(origin.loc) && origin.loc != null)//Did someone put us in something?
		var/atom/A = origin.loc
		A.attack_animal(src)//Bang on it till we get out
		return TRUE

/mob/living/simple_animal/hostile/proc/FindHidden()
	var/atom/my_target = get_target()
	if(!my_target)
		return FALSE
	if(istype(my_target.loc, /obj/structure/closet) || istype(my_target.loc, /obj/machinery/disposal) || istype(my_target.loc, /obj/machinery/sleeper))
		var/atom/A = my_target.loc
		Goto(A,move_to_delay,minimum_distance)
		if(A.Adjacent(get_origin()))
			A.attack_animal(src)
		return 1

/mob/living/simple_animal/hostile/RangedAttack(atom/A, params) //Player firing
	if(ranged && COOLDOWN_FINISHED(ranged_cooldown))
		// GiveTarget(A)
		OpenFire(A)
		DelayNextAction()
	. = ..()
	return TRUE

/mob/living/simple_animal/hostile/proc/get_origin()
	return GET_WEAKREF(targetting_origin) || src

/mob/living/simple_animal/hostile/proc/set_origin(atom/orgin)
	if(!orgin)
		orgin = src
	targetting_origin = WEAKREF(orgin)

/mob/living/simple_animal/hostile/proc/unset_origin()
	targetting_origin = null

////// AI Status ///////
/mob/living/simple_animal/hostile/proc/AICanContinue(list/possible_targets)
	switch(AIStatus)
		if(AI_ON)
			. = 1
		if(AI_IDLE)
			if(FindTarget(possible_targets, 1))
				. = 1
				toggle_ai(AI_ON) //Wake up for more than one Life() cycle.
			else
				. = 0

/mob/living/simple_animal/hostile/proc/AIShouldSleep(list/possible_targets)
	return !FindTarget(possible_targets, 1)


//These two procs handle losing our targette if we've failed to attack them for
//more than lose_patience_timeout deciseconds, which probably means we're stuck
/mob/living/simple_animal/hostile/proc/GainPatience()
	if(QDELETED(src))
		return
	
	if(lose_patience_timeout)
		LosePatience()
		lose_patience_timer_id = addtimer(CALLBACK(src, .proc/LoseTarget), lose_patience_timeout, TIMER_STOPPABLE)


/mob/living/simple_animal/hostile/proc/LosePatience()
	deltimer(lose_patience_timer_id)


//These two procs handle losing and regaining search_objects when attacked by a mob
/mob/living/simple_animal/hostile/proc/LoseSearchObjects()
	if(QDELETED(src))
		return
	
	search_objects = 0
	deltimer(search_objects_timer_id)
	search_objects_timer_id = addtimer(CALLBACK(src, .proc/RegainSearchObjects), search_objects_regain_time, TIMER_STOPPABLE)


/mob/living/simple_animal/hostile/proc/RegainSearchObjects(value)
	if(!value)
		value = initial(search_objects)
	search_objects = value

/mob/living/simple_animal/hostile/consider_wakeup()
	..()
	var/list/tlist
	var/turf/T = get_turf(src)

	if (!T)
		return

	if (!length(SSmobs.clients_by_zlevel[T.z])) // It's fine to use .len here but doesn't compile on 511
		toggle_ai(AI_Z_OFF)
		return
	
	tlist = ListTargetsLazy(T.z)

	if(AIStatus == AI_IDLE && tlist.len)
		toggle_ai(AI_ON)

/mob/living/simple_animal/hostile/proc/ListTargetsLazy(_Z)//Step 1, find out what we can see
	var/static/hostile_machines = typecacheof(list(/obj/machinery/porta_turret, /obj/mecha, /obj/structure/destructible/clockwork/ocular_warden))
	. = list()
	for (var/I in SSmobs.clients_by_zlevel[_Z])
		var/mob/M = I
		if (get_dist(M, src) < vision_range)
			if (isturf(M.loc))
				. += M
			else if (M.loc.type in hostile_machines)
				. += M.loc

/mob/living/simple_animal/hostile/proc/handle_target_del(datum/source)
	SIGNAL_HANDLER
	unset_target()
	LoseTarget()

/mob/living/simple_animal/hostile/proc/unset_target()
	var/atom/my_target = get_target()
	if(my_target)
		UnregisterSignal(my_target, COMSIG_PARENT_QDELETING)
	target = null

/mob/living/simple_animal/hostile/proc/get_target()
	return GET_WEAKREF(target)

/mob/living/simple_animal/hostile/proc/add_target(new_target)
	var/datum/weakref/newtarget = WEAKREF(new_target)
	if(!newtarget || newtarget == target)
		return
	unset_target()
	target = newtarget
	var/atom/nutarget = get_target()
	if(nutarget)
		RegisterSignal(nutarget, COMSIG_PARENT_QDELETING, .proc/handle_target_del, TRUE)

/mob/living/simple_animal/hostile/proc/queue_unbirth()
	SSidlenpcpool.add_to_culling(src)

/mob/living/simple_animal/hostile/proc/unqueue_unbirth()
	SSidlenpcpool.remove_from_culling(src)

/// return to monke-- stuffs a mob into their own special nest
/mob/living/simple_animal/hostile/proc/unbirth_self(forced)
	if(!forced && !consider_despawning()) // check again plz
		return
	var/obj/structure/nest/my_home
	if(isweakref(nest))
		my_home = RESOLVEWEAKREF(nest)
	if(!my_home)
		my_home = new/obj/structure/nest/special(get_turf(src))
	SEND_SIGNAL(my_home, COMSIG_SPAWNER_ABSORB_MOB, src)

/mob/living/simple_animal/hostile/setup_variations()
	if(!..())
		return
	if(LAZYLEN(variation_list[MOB_VARIED_VIEW_RANGE]))
		vision_range = vary_from_list(variation_list[MOB_VARIED_VIEW_RANGE])
	if(LAZYLEN(variation_list[MOB_VARIED_AGGRO_RANGE]))
		aggro_vision_range = vary_from_list(variation_list[MOB_VARIED_AGGRO_RANGE])
	if(LAZYLEN(variation_list[MOB_VARIED_SPEED]))
		move_to_delay = vary_from_list(variation_list[MOB_VARIED_SPEED])
	if(LAZYLEN(variation_list[MOB_RETREAT_DISTANCE]))
		retreat_distance = vary_from_list(variation_list[MOB_RETREAT_DISTANCE])
	if(LAZYLEN(variation_list[MOB_MINIMUM_DISTANCE]))
		minimum_distance = vary_from_list(variation_list[MOB_MINIMUM_DISTANCE])

/mob/living/simple_animal/hostile/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	emp_effect(severity)

/// EMP intensity tends to be 20-40
/mob/living/simple_animal/hostile/proc/emp_effect(intensity)
	if(!LAZYLEN(emp_flags))
		return FALSE
	if(!islist(emp_flags))
		return FALSE

	switch(pick(emp_flags))
		if(MOB_EMP_STUN)
			do_emp_stun(intensity)
		if(MOB_EMP_BERSERK)
			do_emp_berserk(intensity)
		if(MOB_EMP_DAMAGE)
			do_emp_damage(intensity)
		if(MOB_EMP_SCRAMBLE)
			do_emp_scramble(intensity)
	do_sparks(3, FALSE, src)
	return TRUE

/mob/living/simple_animal/hostile/proc/do_emp_stun(intensity)
	if(!intensity)
		return FALSE
	if(MOB_EMP_STUN in active_emp_flags)
		return FALSE
	active_emp_flags |= MOB_EMP_STUN
	visible_message(span_green("[src] shudders as the EMP overloads its servos!"))
	LoseTarget()
	toggle_ai(AI_OFF)
	addtimer(CALLBACK(src, .proc/un_emp_stun), min(intensity, 3 SECONDS))

/mob/living/simple_animal/hostile/proc/un_emp_stun()
	active_emp_flags -= MOB_EMP_STUN
	LoseTarget()
	toggle_ai(AI_ON)

/mob/living/simple_animal/hostile/proc/do_emp_berserk(intensity)
	if(!intensity)
		return FALSE
	if(MOB_EMP_BERSERK in active_emp_flags)
		return FALSE
	active_emp_flags |= MOB_EMP_BERSERK
	LoseTarget()
	visible_message(span_green("[src] lets out a burst of static and whips its gun around wildly!"))
	var/list/old_faction = faction
	faction = null
	addtimer(CALLBACK(src, .proc/un_emp_berserk, old_faction), intensity SECONDS * 0.5)

/mob/living/simple_animal/hostile/proc/un_emp_berserk(list/unberserk)
	active_emp_flags -= MOB_EMP_BERSERK
	faction = unberserk
	LoseTarget()

/mob/living/simple_animal/hostile/proc/do_emp_damage(intensity)
	if(!intensity)
		return FALSE
	smoke.set_up(round(clamp(intensity*0.5, 1, 3), 1), src)
	smoke.start()
	visible_message(span_green("[src] shoots out a plume of acrid smoke!"))
	adjustBruteLoss(maxHealth * 0.01 * intensity)
	playsound(src.loc, 'sound/effects/smoke.ogg', 50, 1, -3)

/mob/living/simple_animal/hostile/proc/do_emp_scramble(intensity)
	if(!intensity)
		return FALSE
	move_to_delay = rand(move_to_delay * 0.5, move_to_delay * 2)
	auto_fire_delay = rand(auto_fire_delay * 0.8, auto_fire_delay * 1.5)
	extra_projectiles = rand(extra_projectiles - 1, extra_projectiles + 1)
	ranged_attack_cooldown = rand(ranged_attack_cooldown * 0.5, ranged_attack_cooldown * 2)
	retreat_distance = rand(0, 10)
	minimum_distance = rand(0, 10)
	LoseTarget()
	visible_message(span_notice("[src] jerks around wildly and starts acting strange!"))
