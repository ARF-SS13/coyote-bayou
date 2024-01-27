/mob/living/simple_animal/hostile
	faction = list("hostile")
	stop_automated_movement_when_pulled = 0
	obj_damage = 40
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES //Bitflags. Set to ENVIRONMENT_SMASH_STRUCTURES to break closets,tables,racks, etc; ENVIRONMENT_SMASH_WALLS for walls; ENVIRONMENT_SMASH_RWALLS for rwalls
	mob_size = MOB_SIZE_LARGE
	gold_core_spawnable = NO_SPAWN
	var/datum/weakref/target
	// var/target_ckey // for memory purposes, mainly for surprise rounds
	var/ranged = FALSE
	var/dodging = TRUE
	var/approaching_target = FALSE //We should dodge now
	var/in_melee = FALSE	//We should sidestep now
	var/dodge_prob = 5
	var/sidestep_per_cycle = 1 //How many sidesteps per npcpool cycle when in melee

	/// How many shots to shoot per burst?
	var/auto_fire_burst_count = 1 //how many projectiles above 1?
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

	var/melee_attacks_per_tick = 1			 //Number of melee attacks that a mob can do per tick, set to 1 to just make it attack once per tick
	var/delay_between_melee_attacks = 0.5 //Time between each melee attack in a melee_attacks_per_tick volley.
	var/melee_queue_distance = 4 //If target is close enough start preparing to hit them if we have melee_attacks_per_tick enabled
	
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

	/// Every tick we arent rushing in, we have a chance to rush in
	var/rush_per_tick_prob = 100
	/// Every tick we arent approaching, and are not rushing, we have a chance to approach
	var/approach_per_tick_prob = 100
	/// Every tick we arent retreating, and are not the other two, we have a chance to retreat
	var/retreat_per_tick_prob = 100
	/// If we're rushing, and we dont do an attack, we have a chance to stop rushing, with the above probability
	var/can_leave_rush_mode_without_attacking = FALSE // Can we leave rush mode without attacking?

	var/flees_at_low_health = FALSE // Does this mob run away when it's low on health?
	var/flee_health_threshold = 0.25 // What percent of health does it run away at?

	var/always_rush_at_low_health = FALSE // Does this mob always rush when it's low on health?
	var/always_rush_health_threshold = 0.50

	var/retreat_after_melee_attack_prob = 25

	var/retreat_after_ranged_attack_prob = 0
	var/approach_after_ranged_attack_prob = 0
	var/rush_after_ranged_attack_prob = 0

	/// if we havent seen our targt for this long, give up
	var/pursuit_duration = 10 SECONDS

	var/melee_attack_cooldown = 2 SECONDS
	COOLDOWN_DECLARE(melee_cooldown)


	var/sight_shoot_delay_time = 0.7 SECONDS
	COOLDOWN_DECLARE(sight_shoot_delay)
	var/sight_shoot_timer_id = 0

	/// If it can move and shoot on the same turn, set this to TRUE. otherwise it will shoot if it can, or move if it cant
	var/can_move_and_shoot = TRUE
	var/ranged_message = "fires" //Fluff text for ranged mobs
	var/ranged_attack_cooldown = 2 SECONDS
	COOLDOWN_DECLARE(ranged_cooldown)
	var/ranged_cooldown_time = 3 SECONDS //How long, in deciseconds, the cooldown of ranged attacks is
	var/ranged_ignores_vision = FALSE //if it'll fire ranged attacks even if it lacks vision on its target, only works with environment smash
	var/check_friendly_fire = 0 // Should the ranged mob check for friendlies when shooting
	/// If our mob runs from players when they're too close, set in tile distance. By default, mobs do not retreat.
	var/retreat_distance = null
	/// Minimum approach distance, so ranged mobs chase targets down, but still keep their distance set in tiles to the target, set higher to make mobs keep distance
	var/approach_distance = 1
	var/blindfires = FALSE // Will they keep shooting even without a line of sight to the gtarget?
	var/can_shoot_in_melee = FALSE // Can they shoot in melee?

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

	/// stores some flags about the mob's AI, like if it's allowed to attack the target, or if it can see the target
	/// currently only stores things relevant for a single action
	var/datum/hostile_blackboard/blackboard

	speed = 3//The default hostile mob speed. If you ever speed the mob ss again please raise this to compensate.

/mob/living/simple_animal/hostile/Initialize(mapload)
	. = ..()
	blackboard = new()
	set_origin(src)
	wanted_objects = typecacheof(wanted_objects)
	if(MOB_EMP_DAMAGE in emp_flags)
		smoke = new /datum/effect_system/smoke_spread/bad
		smoke.attach(src)
	if(mapload && despawns_when_lonely)
		unbirth_self(TRUE)

/mob/living/simple_animal/hostile/Destroy()
	QDEL_NULL(blackboard)
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
		return FALSE
	if(client)
		return FALSE
	if(!blackboard)
		blackboard = new()
	// if(incapacitated())
	// 	return FALSE
	/// first try to kick our way free of whatever
	if(EscapeConfinement()) // we get one kick per turn
		return TRUE
	// if(DoingSomething())
	// 	return TRUE
	/// Now try to do interesting things
	/// find us a target, or retrieve our current one, either'll do
	if(blackboard.check_pursuit_time()) // true if its time to give up
		LoseTarget()
	var/atom/mytarget = PollTarget()
	/// If we're in the middle of something, do the stuff we're in the middle of
	if(mytarget) // found something! turn on the AI
		. = ActiveHostile(mytarget)
	else // Nothing, so, mill around and go to sleep eventually
		. = SleepyHostile()
	blackboard.wipe_shortterm()

/// No targets, so just chill and try to go to sleep
/mob/living/simple_animal/hostile/proc/SleepyHostile()
	toggle_ai(AI_IDLE)
	consider_despawning()
	return TRUE

/// returns either our current target, or a new one, or nothing at all!
/mob/living/simple_animal/hostile/proc/PollTarget()
	var/atom/targa = get_target()
	if(istype(targa))
		blackboard.retained_target = TRUE // yeah hi im a hardcore retainer
		return targa
	return FindTarget()

/* 
 * This is the main proc for the mob's AI. It's called every time the mob is allowed to do something.
 * Attempts to punch the target, shoot the target, and move towards the target, in that order.
 */
/mob/living/simple_animal/hostile/proc/ActiveHostile(atom/my_target)
	/// first, do we have a target? if so, good!
	if(!isatom(my_target))
		if(target)
			my_target = get_target()
			if(!target)
				return FALSE
	/// prechecks!
	var/atom/my_origin = get_origin()
	my_target = FindHidden(my_target, my_origin) // if the target is inside something, target what they're inside instead
	UpdateBlackboard(my_target, my_origin)
	// if(blackboard.has_line_of_sight_to_target) // update last seen position! // some day will lead to firing at ur last seen position
	// 	blackboard.remember_target(my_target) // not today tho~
	// target locked, blackboard updated, lets zoom
	/// first, can we punch em?
	if(COOLDOWN_FINISHED(src, melee_cooldown) && blackboard.allowed_to_melee_target)
		. |= InitiateMeleeAttack(my_target)
	/// if not, can we shoot em?
	if(COOLDOWN_FINISHED(src, ranged_cooldown) && blackboard.allowed_to_shoot_target)
		. |= InitiateRangedAttack(my_target)
	/// if not, try to get closer
	. |= InitiateMovement(my_target)
	/// Also try to break stuff
	if(blackboard.mad_at_target)
		DestroyPathToTarget()
	/// Now think about our life choices
	. |= ThinkPostTurn(my_target)

/// generates a precached bitfield of flags about us in relation to the target at this instant
/mob/living/simple_animal/hostile/proc/UpdateBlackboard(atom/my_target, atom/my_origin = src)
	if(!my_target)
		return FALSE
	if(!blackboard)
		blackboard = new()
	blackboard.wipe_shortterm()
	if(!my_target)
		my_target = get_target()
		if(!my_target)
			return FALSE
	blackboard.in_use = TRUE
	blackboard.allowed_to_move = CHECK_BITFIELD(mobility_flags, MOBILITY_MOVE)
	blackboard.allowed_to_attack_target = AllowedToAttackTarget(my_target)
	/// allowed to attack the target! now, can we see it?
	blackboard.can_chase_target = CheckChaseDistance(my_target) /// simplified check that assumes that we could see them originally when they were targetted
	blackboard.has_line_of_sight_to_target = HasLineOfSightTo(my_target)
	if(blackboard.has_line_of_sight_to_target)
		blackboard.seen_target(my_target, pursuit_duration)
	blackboard.is_adjacent_to_target = my_origin.Adjacent(my_target)
	blackboard.is_far_from_target = !blackboard.is_adjacent_to_target && blackboard.can_chase_target // HA THATS WHY I USED IT!!!!!!!
	if(!blackboard.allowed_to_attack_target) // we're not allowed to attack, so we're not allowed to do anything
		blackboard.allowed_to_shoot_target = FALSE
		blackboard.allowed_to_melee_target = FALSE
		return
	blackboard.allowed_to_shoot_target = blackboard.has_line_of_sight_to_target && (blackboard.is_far_from_target || (can_shoot_in_melee && blackboard.is_adjacent_to_target)) // no muzzle stuffing (unless its a whole wedding cake at our wedding)
	blackboard.allowed_to_melee_target = blackboard.is_adjacent_to_target
	/// cached for sanic speed


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
	if(stat == CONSCIOUS && AIStatus != AI_OFF && !client && user)
		FindTarget(list(user), 1)
	return ..()

/mob/living/simple_animal/hostile/bullet_act(obj/item/projectile/P)
	. = ..()
	if (peaceful == TRUE)
		peaceful = FALSE
	if(stat == CONSCIOUS && !get_target() && AIStatus != AI_OFF && !client)
		if(P.firer && get_dist(src, P.firer) <= aggro_vision_range)
			FindTarget(list(P.firer), 1)
		Goto(P.starting)
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

	if(isliving(the_target))
		var/mob/living/L = the_target
		if(SEND_SIGNAL(L, COMSIG_HOSTILE_CHECK_FACTION, src) == SIMPLEMOB_IGNORE)
			return FALSE
		var/faction_check = !(L in foes) && faction_check_mob(L)
		if(!faction_check && !L.client)
			var/client_in_range = FALSE
			for(var/client/C in GLOB.clients)
				var/mob/D = C.mob
				if(get_dist(L, D) <= SSmobs.distance_where_a_player_needs_to_be_in_for_npcs_to_fight_other_npcs)
					client_in_range = TRUE
					break
			if(!client_in_range)
				return FALSE
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

/mob/living/simple_animal/hostile/proc/GiveTarget(atom/new_target, am_angry_at_them)//Step 4, give us our selected targette
	if(!new_target)
		LoseTarget(TRUE)
		return
	blackboard.mad_at_target = am_angry_at_them // grr
	add_target(new_target) // betcha just love these mixed name cases
	LosePatience() // betcha just wanna marry them
	if(get_target() != null)
		GainPatience()
		Aggro()
		return 1

///////////////////////////////////////////////////////////////////////
////// THINKING ABOUT LIFE CHOICES ///////////////////////////////////

/*
 * This is the main set of procs for deciding what state to be in!
 * When a mob does something interesting, think about what it just did or had happen to it, and then decide what to do next.
 */

/// called after when we successfully punch something
/mob/living/simple_animal/hostile/proc/ThinkMeleeAttackSuccess(atom/target)
	blackboard.last_attack_time = world.time
	if(blackboard.is_attacking()) // Just had a successful attack, roll for running away
		if(prob(retreat_after_melee_attack_prob))
			blackboard.set_retreating()
			blackboard.melee_thought_performed()

/// called after we shoot at something
/mob/living/simple_animal/hostile/proc/ThinkRangedAttackSuccess(atom/target)
	if(blackboard.is_retreating())
		if(prob(approach_after_ranged_attack_prob))
			blackboard.set_approaching()
			blackboard.ranged_thought_performed()
		else if(prob(rush_after_ranged_attack_prob))
			blackboard.set_rushing()
			blackboard.ranged_thought_performed()

/// called after our turn
/mob/living/simple_animal/hostile/proc/ThinkPostTurn(atom/target)
	if(blackboard.had_combat_thought())
		return TRUE // something took priority~
	var/hp_fraction = health / max(maxHealth, 1)
	if(always_rush_at_low_health && hp_fraction < always_rush_health_threshold)
		blackboard.force_rush()
		return TRUE
	if(flees_at_low_health && hp_fraction < flee_health_threshold)
		blackboard.force_flee()
		return TRUE
	if(blackboard.is_rushing())
		if(!can_leave_rush_mode_without_attacking)
			return TRUE // we're rushing, but we didnt attack, so we're still rushing
		else if(prob(retreat_per_tick_prob))
			blackboard.set_retreating()
			return TRUE
		else if(prob(approach_per_tick_prob))
			blackboard.set_approaching()
			return TRUE
	else
		if(prob(rush_per_tick_prob))
			blackboard.set_rushing()
			return TRUE
	return TRUE

/////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////........../////////////////////......................
////////////////////////////////////..........///////////////////////////////////////////
//// MELEE ATTACKING ///////////////..........//////////DD///////////////////////////////
////////////////////////////////////..........//////////DD/////////......................
////////////////////////////////////////////////////////DD/////////......................
/////////////////////////////////////////////////////////////////////////////////////////

/* 
 * Automated melee attack! This is called by the mob's AI when it wants to punch something.
 */
/mob/living/simple_animal/hostile/proc/InitiateMeleeAttack(atom/target, was_telegraphed_its_okay)
	if(!target)
		target = get_target()
	if(!target)
		return FALSE
	if(!blackboard.in_use)
		UpdateBlackboard(target)
	if(!was_telegraphed_its_okay && TelegraphMeleeAttack(target) == HAI_TELEGRAPH_ABORT_MELEE)
		return TRUE
	StopTelegraphingMelee(FALSE)
	return MeleeAttackTargetLoop(target)

/// Do an effect to telegraph that we're gonna punch em
/// returns if we shouldnt attack em
/mob/living/simple_animal/hostile/proc/TelegraphMeleeAttack(atom/target, hostile_flags = NONE)
	if(!target || !telegraphs_melee)
		return HAI_TELEGRAPH_PROCEED_MELEE
	if(windup_timer_id) // we're in the middle of scrotiographing an attack, it'll handle it dont worry
		if(world.time >= blackboard.telegraphing_until + 1 SECOND)
			StopTelegraphingMelee(TRUE)
			return HAI_TELEGRAPH_PROCEED_MELEE
		else
			return HAI_TELEGRAPH_ABORT_MELEE
	blackboard.telegraphing_melee_until(melee_windup_time)
	/// also a cooldown, just in case something gets interrupted
	COOLDOWN_START(src, winding_up_melee, melee_windup_time*2) //Don't increase our retreating distance while winding up
	blackboard.force_rush() // RUSH B
	if(melee_windup_sound)
		playsound(src.loc, melee_windup_sound, 150, TRUE, distant_range = 4)	//Play the windup sound effect to warn that an attack is coming.
	INVOKE_ASYNC(src, /atom/.proc/do_windup, melee_windup_magnitude, melee_windup_time)	//Bouncing bitches.
	windup_timer_id = addtimer(CALLBACK(src, .proc/TelegraphSwingFinish, target), melee_windup_time) // see you in a bit!
	return TRUE

//Just a thing that whiffs if the target either doesnt exist or is out of range
/mob/living/simple_animal/hostile/proc/TelegraphSwingFinish(atom/my_target, hostile_flags = NONE)
	StopTelegraphingMelee(TRUE)
	UpdateBlackboard(my_target)
	blackboard.force_allowed_to_melee()
	if(!InitiateMeleeAttack(my_target, TRUE))
		return Whiff() // whiff!

//Does a whiff
/mob/living/simple_animal/hostile/proc/Whiff()
	var/turf/where_to_whiff = get_step(src, dir)
	if(!isturf(where_to_whiff))
		return FALSE
	do_attack_animation(where_to_whiff)
	playsound(where_to_whiff, 'sound/effects/eq_whiff.ogg')

/// stops telegraphing a melee attack
/mob/living/simple_animal/hostile/proc/StopTelegraphingMelee(complitely)
	if(windup_timer_id)
		deltimer(windup_timer_id)
		windup_timer_id = 0
	blackboard.finished_telegraphing_melee()
	if(complitely)
		blackboard.unforce_rush() // okay dont rush b

/// checks if we can attack the thing, then attacks the thing over and over
/mob/living/simple_animal/hostile/proc/MeleeAttackTargetLoop(atom/target, hostile_flags = NONE)
	if(!target)
		return FALSE
	if(!MeleeAttackChain(target, hostile_flags))
		return FALSE
	if(melee_attacks_per_tick > 1)
		blackboard.attack_until(delay_between_melee_attacks * (melee_attacks_per_tick - 1))
		var/datum/callback/cb = CALLBACK(src, .proc/MeleeAttackChain, target)
		var/delay = delay_between_melee_attacks
		var/attax = melee_attacks_per_tick - 1
		for(var/i in 1 to attax)
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
		/// hold on there, maybe they're inside something!

		return FALSE
	if(!blackboard.in_use)
		UpdateBlackboard(target, origin)
	if(!blackboard.allowed_to_melee_target)
		return FALSE
	if(!blackboard.is_adjacent_to_target)
		return FALSE
	in_melee = TRUE
	return TRUE

/mob/living/simple_animal/hostile/proc/MeleeAttackTarget(atom/my_target)
	SEND_SIGNAL(src, COMSIG_HOSTILE_ATTACKINGTARGET, my_target)
	if(alternate_attack_prob && prob(alternate_attack_prob) && AlternateAttackingTarget(my_target))
		return FALSE
	. = my_target.attack_animal(src)
	GainPatience()

/// Cleaning up after an attack has been made
/mob/living/simple_animal/hostile/proc/PostMeleeAttack(atom/target, hostile_flags)
	COOLDOWN_START(src, melee_cooldown, melee_attack_cooldown)
	ThinkMeleeAttackSuccess(target)


////////////////////////////////////////////////////////////////////
//// RANGED ATTACKING //////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
/////////////////////.............................................................////

/*
 * Initiate an automated ranged attack
 * */
/mob/living/simple_animal/hostile/proc/InitiateRangedAttack(atom/target, hostile_flags = NONE)
	if(!target)
		target = get_target()
		if(!target)
			return FALSE
	if(!ShouldRangedAttack(target, hostile_flags))
		return FALSE
	if(!COOLDOWN_FINISHED(src, sight_shoot_delay))
		if(!sight_shoot_timer_id) // we're not winding up, so we can shoot
			DelayedFirstBurst(target, hostile_flags) // it'll make em shoot in juuuuust a sec
		return FALSE
	PreRangedAttack(target, hostile_flags)
	if(!OpenFire(target, hostile_flags)) // open fire, gordan!
		return FALSE
	PostRangedAttack(target, hostile_flags)
	return TRUE

/// do a delayed first burst
/mob/living/simple_animal/hostile/proc/DelayedFirstBurst(atom/target, hostile_flags = NONE)
	if(sight_shoot_timer_id)
		return
	if(!target)
		target = get_target()
		if(!target)
			return FALSE
	sight_shoot_timer_id = addtimer(CALLBACK(src, .proc/InitiateRangedAttack, target), sight_shoot_delay + 1)

/// First check if we're authorized to do a shoot
/mob/living/simple_animal/hostile/proc/ShouldRangedAttack(atom/target, hostile_flags)
	if(!ranged)
		return FALSE
	if(!projectiletype && !casingtype)
		return FALSE
	if(!target)
		return FALSE
	if(sight_shoot_timer_id) // we're winding up, so we can't shoot yet
		return FALSE
	if(!COOLDOWN_FINISHED(src, ranged_cooldown))
		return FALSE
	if(!blackboard.in_use)
		UpdateBlackboard(target)
	if(!blackboard.allowed_to_shoot_target)
		return FALSE
	if(!blackboard.has_line_of_sight_to_target && !blindfires)
		return FALSE
	if((!blackboard.is_far_from_target || blackboard.is_adjacent_to_target) && !can_shoot_in_melee)
		return FALSE
	return TRUE


/// what to do before doing a full ranged attack thing
/mob/living/simple_animal/hostile/proc/PreRangedAttack(atom/target, hostile_flags)
	return TRUE // TODO: telegraphing ranged attacks

/// no longer really needed, cus bullet pass through friendly mobs, lol
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

/* 
 * Run the actual shooting stuff, does a complete ranged attack
 * Assumes we're able to actually do the attack
 */
/mob/living/simple_animal/hostile/proc/OpenFire(atom/A)
	// if(!ranged || (!projectiletype && !casingtype))
	// 	return FALSE
	// if(COOLDOWN_TIMELEFT(src, sight_shoot_delay))
	// 	return FALSE
	// if(CheckFriendlyFire(A))
	// 	return
	deltimer(sight_shoot_timer_id)
	visible_message(span_danger("<b>[src]</b> [islist(ranged_message) ? pick(ranged_message) : ranged_message] at [A]!"))
	var/shots_to_do = auto_fire_burst_count
	Shoot(A)
	if(shots_to_do--)
		for(var/i in 1 to shots_to_do)
			addtimer(CALLBACK(src, .proc/Shoot, A), i * auto_fire_delay)
	ThrowSomething(A)
	return TRUE

/mob/living/simple_animal/hostile/proc/PostRangedAttack(atom/target, hostile_flags)
	COOLDOWN_START(src, ranged_cooldown, ranged_cooldown_time)
	ThinkRangedAttackSuccess(target)
	if(sound_after_shooting)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, sound_after_shooting, 100, 0, 0), sound_after_shooting_delay, TIMER_STOPPABLE)
	if(projectiletype)
		if(LAZYLEN(variation_list[MOB_PROJECTILE]) >= 2) // Gotta have multiple different projectiles to cycle through
			projectiletype = vary_from_list(variation_list[MOB_PROJECTILE], TRUE)
	if(casingtype)
		if(LAZYLEN(variation_list[MOB_CASING]) >= 2) // Gotta have multiple different casings to cycle through
			casingtype = vary_from_list(variation_list[MOB_CASING], TRUE)

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

/*
 * Does one (1) shoot at a target
 * Assumes it is allowed and able to do so
 */
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


/*
 * Starts or updates some kind of movement action, if possible
 * A wonderfully multifunctional procm that handles all the stuff that tells the mob to go places
 * HOW IT WORK:______qdel_list_wrapper
 * Determine our current movement state, which should have already been set by something previous
 * The states boil down to twoish states: butt rushing the player, and moving to a set of coordinates
 * When buttrushing the player, we just use the default stock mob movement code, simple as
 * Otherwise, we're going to want a set of coordinates to move to, which we'll get from the blackboard
 * If there's no coordinates to move to, or we've tried too long to get there, or we're more or less *there*, we get new coordinates!
 * HAI_MOVEMODE_APPROACH and HAI_MOVEMODE_RETREAT try to find a turf at their minimum / retreat distances, respectively
 * HAI_MOVEMODE_FLEE tries to find a turf that's as far away from the target as possible
 * HAI_MOVEMODE_WANDER just does the default stock mob wander code
 * HAI_MOVEMODE_STAND just stands there, menacingly
 * Annoyingly enough, still uses BYOND's own moving and pathing code, some day we'll actually use our JPS
 * 
 * So, this proc. It does all that stuff above
 */

/mob/living/simple_animal/hostile/proc/InitiateMovement(atom/my_target, force_move_there)//Step 5, handle movement between us and our targette
	if(!my_target) // active movement needs some sort of targette to know where to run to
		LoseTarget() // KPAGU
		return FALSE
	if(!ShouldMove()) 
		return FALSE // just dont move
	
	// if(ContinueMoving()) // if we're already moving, keep moving
	// 	return TRUE

	var/atom/go_here = my_target // check if we have anywhere interesting to go
	var/orbit_distance = 0 // how far away we want to be from our targette
	// if(!go_here || !blackboard.should_retain_target(src))
	var/rush = blackboard.is_rushing()
	if(force_move_there)
		rush = FALSE
	else
		switch(blackboard.movement_style)
			if(HAI_MOVEMODE_RUSH)
				orbit_distance = GetAttackOrbitDistance(my_target)
				go_here = GetAttackTarget(my_target, orbit_distance)
			if(HAI_MOVEMODE_APPROACH)
				orbit_distance = GetApproachOrbitDistance(my_target)
				go_here = GetApproachTarget(my_target, orbit_distance)
			if(HAI_MOVEMODE_RETREAT)
				orbit_distance = GetRetreatOrbitDistance(my_target)
				go_here = GetRetreatTarget(my_target, orbit_distance)
			if(HAI_MOVEMODE_FLEE)
				orbit_distance = GetFleeOrbitDistance(my_target)
				go_here = GetFleeTarget(my_target, orbit_distance)
	if(!go_here)
		LoseTarget() // couldnt find anywhere to go, abort!
		return FALSE
	stop_automated_movement = 1
	if(rush)
		. = MaintainDistance(go_here, orbit_distance)
	else
		. = Goto(go_here, move_to_delay, approach_distance) // go to the place
	RandomizeMovement()

/// tries to keep me at a certain distance from my targette
/mob/living/simple_animal/hostile/proc/MaintainDistance(atom/my_target, orbit_distance)//Step 5, handle movement between us and our targette
	if(!CHECK_BITFIELD(mobility_flags, MOBILITY_MOVE))
		return FALSE
	set_glide_size(DELAY_TO_GLIDE_SIZE(move_to_delay))
	walk_away(src, my_target, orbit_distance, move_to_delay)
	return TRUE

/// makes me to there
/mob/living/simple_animal/hostile/proc/Goto(atom/targette)
	if(!CHECK_BITFIELD(mobility_flags, MOBILITY_MOVE))
		return
	set_glide_size(DELAY_TO_GLIDE_SIZE(move_to_delay))
	walk_to(src, targette, approach_distance, move_to_delay)
	return TRUE

/// randomizes my movement
/mob/living/simple_animal/hostile/proc/RandomizeMovement()
	if(!variation_list[MOB_RETREAT_DISTANCE_CHANCE] && LAZYLEN(variation_list[MOB_RETREAT_DISTANCE]) && prob(variation_list[MOB_RETREAT_DISTANCE_CHANCE]))
		retreat_distance = vary_from_list(variation_list[MOB_RETREAT_DISTANCE])
	if(variation_list[MOB_MINIMUM_DISTANCE_CHANCE] && LAZYLEN(variation_list[MOB_APPROACH_DISTANCE]) && prob(variation_list[MOB_MINIMUM_DISTANCE_CHANCE]))
		approach_distance = vary_from_list(variation_list[MOB_APPROACH_DISTANCE])
	if(variation_list[MOB_VARIED_SPEED_CHANCE] && LAZYLEN(variation_list[MOB_VARIED_SPEED]))
		if(prob(variation_list[MOB_VARIED_SPEED_CHANCE]))
			move_to_delay = vary_from_list(variation_list[MOB_VARIED_SPEED])
			set_varspeed(pick(variation_list[MOB_VARIED_SPEED]))

/mob/living/simple_animal/hostile/proc/ShouldMove(atom/my_target)//Step 5, handle movement between us and our targette
	if(!blackboard.allowed_to_move)
		return FALSE
	if(!CHECK_BITFIELD(mobility_flags, MOBILITY_MOVE))
		return FALSE
	if(blackboard.mad_at_target && !blackboard.can_chase_target)
		return FALSE
	if(blackboard.is_wandering())
		return FALSE // handled elsewhere
	if(blackboard.shot_was_performed && !can_move_and_shoot)
		return FALSE
	return TRUE

/// Are we still moving somewhere?
// /mob/living/simple_animal/hostile/proc/ContinueMoving()
// 	return TRUE // todo

/mob/living/simple_animal/hostile/proc/GetAttackTarget(atom/my_target)
	return FindHidden(my_target) // just attack the targette

/mob/living/simple_animal/hostile/proc/GetAttackOrbitDistance(atom/my_target)
	return 1 // get up in their face

/mob/living/simple_animal/hostile/proc/GetApproachTarget(atom/my_target)
	return FindHidden(my_target) // just attack the targette

/mob/living/simple_animal/hostile/proc/GetApproachOrbitDistance(atom/my_target)
	return approach_distance

/mob/living/simple_animal/hostile/proc/GetRetreatTarget(atom/my_target)
	return FindHidden(my_target) // just attack the targette

/mob/living/simple_animal/hostile/proc/GetRetreatOrbitDistance(atom/my_target)
	return retreat_distance

/mob/living/simple_animal/hostile/proc/GetFleeTarget(atom/my_target)
	return FindHidden(my_target) // just attack the targette

/mob/living/simple_animal/hostile/proc/GetFleeOrbitDistance(atom/my_target)
	return retreat_distance * 3

/// Checks if we're close enough to our targette to attempt pursuit // a feline fursuit
/mob/living/simple_animal/hostile/proc/CheckChaseDistance(atom/my_target)
	if(!istype(my_target))
		return FALSE
	var/turf/T = get_turf(src)
	if(my_target.z != T.z)
		return FALSE
	return (get_dist(get_turf(src), get_turf(my_target)) <= aggro_vision_range)

/mob/living/simple_animal/hostile/proc/HasLineOfSightTo(atom/my_target)
	if(!istype(my_target))
		return FALSE
	if(see_invisible < my_target.invisibility)//Target's invisible to us, forget it
		return FALSE
	var/turf/T_me = get_turf(src)
	if(my_target.z != T_me.z)
		return FALSE
	var/turf/T_target = get_turf(my_target) 
	var/list/turfline = getline(T_me, T_target)
	for(var/turf/T in turfline)
		if(!T)
			continue
		if(T == T_target)
			return TRUE
		if(T == T_me)
			continue
		if(T.opacity)
			return FALSE
	return TRUE

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

/mob/living/simple_animal/hostile/proc/LoseTarget(no_give)
	if(!no_give) // if not no give in these parts boy howdy
		GiveTarget(null)
	approaching_target = FALSE
	in_melee = FALSE
	stop_automated_movement = FALSE
	blackboard.target_lost()
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
			M.Goto(src,M.move_to_delay,M.approach_distance)

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
	var/atom/container = origin.loc
	if(!container)
		return
	if(!container.density)
		return
	if(!isturf(origin.loc) && origin.loc != null)//Did someone put us in something?
		var/atom/A = origin.loc
		A.attack_animal(src)//Bang on it till we get out
		return TRUE

/// Checks if our target is inside something, and return either the target or whatever they're in
/mob/living/simple_animal/hostile/proc/FindHidden(atom/my_target) // used to respect player GBJs
	if(!my_target)
		return FALSE
	var/atom/the_holder = my_target.loc
	if(!the_holder)
		return my_target // whatever
	if(isturf(the_holder))
		return my_target // standing on a turf, a-okay
	if(the_holder == src) // oh hey there vore, whatcha doing
		return my_target // punch em in your gut
	return the_holder // punch the thing they're in

/mob/living/simple_animal/hostile/RangedAttack(atom/A, params) //Player firing
	if(ranged && COOLDOWN_FINISHED(src, ranged_cooldown))
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
	if(!new_target)
		unset_target()
	var/datum/weakref/newtarget = WEAKREF(new_target)
	if(!newtarget || newtarget == target)
		blackboard.retained_target = TRUE
		return
	blackboard.retained_target = FALSE
	// target_ckey = extract_ckey(new_target) // todo: surprise rounds
	// if(target_ckey)
	// 	blackboard.remember_ckey(target_ckey)
	
	target = newtarget
	var/atom/nutarget = get_target()
	if(nutarget)
		RegisterSignal(nutarget, COMSIG_PARENT_QDELETING, .proc/handle_target_del, TRUE)
	return TRUE

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
	if(LAZYLEN(variation_list[MOB_APPROACH_DISTANCE]))
		approach_distance = vary_from_list(variation_list[MOB_APPROACH_DISTANCE])

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
	auto_fire_burst_count = rand(auto_fire_burst_count - 1, auto_fire_burst_count + 1)
	ranged_attack_cooldown = rand(ranged_attack_cooldown * 0.5, ranged_attack_cooldown * 2)
	retreat_distance = rand(0, 10)
	approach_distance = rand(0, 10)
	LoseTarget()
	visible_message(span_notice("[src] jerks around wildly and starts acting strange!"))

/obj/effect/debug_mob_ai

/obj/effect/debug_mob_ai/Initialize()
	. = ..()
	var/turf/here = get_turf(src)
	var/mobs_to_place = 4
	var/list/turfs = oview(7, here)
	for(var/i in 1 to mobs_to_place)
		var/turf/there = pick(turfs)
		new /mob/living/simple_animal/hostile/gecko(turfs)
		turfs -= there
	audible_message("DEBUG: Placed [mobs_to_place] mobs in [here]")

