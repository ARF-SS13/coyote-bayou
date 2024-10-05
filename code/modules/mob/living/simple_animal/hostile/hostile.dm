/mob/living/simple_animal/hostile
	faction = list("hostile")
	stop_automated_movement_when_pulled = 0
	obj_damage = 40
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES //Bitflags. Set to ENVIRONMENT_SMASH_STRUCTURES to break closets,tables,racks, etc; ENVIRONMENT_SMASH_WALLS for walls; ENVIRONMENT_SMASH_RWALLS for rwalls
	mob_size = MOB_SIZE_LARGE
	gold_core_spawnable = NO_SPAWN
	a_intent = INTENT_HARM // I LOVE PLAYING THE SCOOTER DANCE WITH PROTECTRONS
	var/datum/weakref/target
	var/ranged = FALSE
	var/rapid = 0 //How many shots per volley.
	var/rapid_fire_delay = 2 //Time between rapid fire shots

	var/dodging = FALSE
	var/approaching_target = FALSE //We should dodge now
	var/in_melee = FALSE	//We should sidestep now
	var/dodge_prob = 0
	var/sidestep_per_cycle = 0 //How many sidesteps per npcpool cycle when in melee

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
	var/move_to_delay = 3.5
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

	var/melee_attacks = TRUE
	/// Mobs will wind up their attacks for this long before checking if they're in range to hit you again.
	var/melee_windup_time = 0.3 SECONDS
	/// This plays when the mob's attack windup starts. It requires melee_windup_time to be set.
	var/melee_windup_sound = 'sound/effects/flip.ogg'
	/// How much to shrink and grow this mob when it's doing a windup attack.
	var/melee_windup_magnitude = 0.3
	/// TRUE while a mob is winding up a melee attack, otherwise FALSE.
	var/winding_up_melee = FALSE

	var/melee_attack_cooldown = 2 SECONDS
	COOLDOWN_DECLARE(melee_cooldown)

	var/sight_shoot_delay_time = 0.7 SECONDS
	COOLDOWN_DECLARE(sight_shoot_delay)

	/// The base random spread of the mob's ranged attacks.
	var/ranged_base_spread = 7
	/// The spread added to the base spread per shot for a burst.
	var/ranged_extra_spread_per_shot = 10
	/// the max spread this mob can accumulate
	var/ranged_max_spread = 45
	var/ranged_message = "fires" //Fluff text for ranged mobs
	var/ranged_cooldown = 0 //What the current cooldown on ranged attacks is, generally world.time + ranged_cooldown_time
	var/ranged_cooldown_time = 3 SECONDS //How long, in deciseconds, the cooldown of ranged attacks is
	var/ranged_ignores_vision = FALSE //if it'll fire ranged attacks even if it lacks vision on its target, only works with environment smash
	var/check_friendly_fire = 0 // Should the ranged mob check for friendlies when shooting
	var/should_factionize_shots = TRUE
	/// If our mob runs from players when they're too close, set in tile distance. By default, mobs do not retreat.
	var/retreat_distance = null
	/// Minimum approach distance, so ranged mobs chase targets down, but still keep their distance set in tiles to the target, set higher to make mobs keep distance
	var/minimum_distance = 1

	var/decompose = TRUE //Does this mob decompose over time when dead?
	//var/decomposition_time = 5 MINUTES
	//COOLDOWN_DECLARE(decomposition_schedule)

//These vars are related to how mobs locate and target
	var/robust_searching = 1 //By default, mobs have a simple searching method, set this to 1 for the more scrutinous searching (stat_attack, stat_exclusive, etc), should be disabled on most mobs
	var/robuster_searching = FALSE //Makes mobs see through walls if theyve seen you before
	var/vision_range = 9 //How big of an area to search for targets in, a vision of 9 attempts to find targets as soon as they walk into screen view
	var/aggro_vision_range = 9 //If a mob is aggro, we search in this radius. Defaults to 9 to keep in line with original simple mob aggro radius
	var/search_objects = 0 //If we want to consider objects when searching around, set this to 1. If you want to search for objects while also ignoring mobs until hurt, set it to 2. To completely ignore mobs, even when attacked, set it to 3
	var/search_objects_timer_id //Timer for regaining our old search_objects value after being attacked
	var/search_objects_regain_time = 30 //the delay between being attacked and gaining our old search_objects value back
	var/list/wanted_objects = list() //A typecache of objects types that will be checked against to attack, should we have search_objects enabled
	var/attack_downed_players = TRUE // ignore stat attack, attack people in soft crit.... for a while
	var/attack_downed_until = HOSTILES_ATTACK_UNTIL_THIS_FAR_INTO_CRIT // Attack until they're this proportion between soft crit and hard crit
	var/stat_attack = SOFT_CRIT //Mobs with stat_attack to UNCONSCIOUS will attempt to attack things that are unconscious, Mobs with stat_attack set to DEAD will attempt to attack the dead.
	var/stat_exclusive = FALSE //Mobs with this set to TRUE will exclusively attack things defined by stat_attack, stat_attack DEAD means they will only attack corpses
	var/attack_same = 0 //Set us to 1 to allow us to attack our own faction
	var/datum/weakref/targetting_origin = null //all range/attack/etc. calculations should be done from this atom, defaults to the mob itself, useful for Vehicles and such
	var/attack_all_objects = FALSE //if true, equivalent to having a wanted_objects list containing ALL objects.

	var/lose_patience_timer_id //id for a timer to call LoseTarget(), used to stop mobs fixating on a target they can't reach
	var/lose_patience_timeout = 300 //30 seconds by default, so there's no major changes to AI behaviour, beyond actually bailing if stuck forever

	var/peaceful = FALSE //Determines if mob is actively looking to attack something, regardless if hostile by default to the target or not

	//Tactical Retreat Code//
	//tactical retreat and heal vars.  These exist to give mobs a breakpoint to cut and run from combat. 
	//Once they have disengaged they will heal up. While they can't return to combat at least they'll be prepped for the next player push.
	var/retreat_health_percent = 0 //.25 = 25% health remaining
	var/max_heal_amount = 0 //how much the mob heals up to when its triggered its low health tactical retreat
	var/heal_per_life = 0 //how much per life tick the mob heals, %. 0.25 is 25%.
	var/tactical_retreat = 0 //Distance in tiles the mob retreats in a panic
	var/retreat_message_said = FALSE 
	var/actual_retreat_message = "The %NAME tries to flee from %TARGET!"
	var/max_healing_ability = 0 //In decimal percent, 1 = 100%
	var/healing_message = "The %NAME is trying to heal itself!"
	var/healing_sound = 'sound/items/tendingwounds.ogg' // 
	var/healing_volume = 30


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

	/// Makes it so the mob tally doesnt count this thing as being deleted when its just sleeping
	var/went_to_sleep = FALSE

	speed = 3//The default hostile mob speed. If you ever speed the mob ss again please raise this to compensate.

/mob/living/simple_animal/hostile/Initialize(mapload, nest_spawned)
	. = ..()
	set_origin(src)
	wanted_objects = typecacheof(wanted_objects)
	if(nest_spawned != "TOPHEAVY-KOBOLD")
		SSmobs.mob_spawned(src)
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
	if(!went_to_sleep)
		SSmobs.mob_despawned(src)
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
		if(decompose && world.time > timeofdeath + 3 MINUTES)//give players enough time to finish their fights and butcher the real way
			visible_message(span_notice("\The dead body of the [src] decomposes!"))
			dust(TRUE, TRUE)
		return
	tacticalhealing() // just had to put the procs where they would be run yeh, should work now, should be it, probably ye
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
	if(AIStatus == AI_OFF)
		return 0

	var/list/possible_targets = ListTargets() //we look around for potential targets and make it a list for later use.

	if(environment_smash)
		EscapeConfinement()

	if(AICanContinue(possible_targets))
		var/atom/my_origin = get_origin()
		var/atom/my_target = get_target()
		if(my_target && !QDELETED(target) && my_origin && !my_origin.Adjacent(target))
			DestroyPathToTarget()
		if(!MoveToTarget(possible_targets))     //if we lose our target
			if(AIShouldSleep(possible_targets))	// we try to acquire a new one
				toggle_ai(AI_IDLE)			// otherwise we go idle
	consider_despawning()
	return 1

/mob/living/simple_animal/hostile/handle_automated_movement()
	. = ..()
	if(!CHECK_BITFIELD(mobility_flags, MOBILITY_MOVE))
		return
	var/atom/my_target = get_target()
	if(dodging && my_target && in_melee && isturf(loc) && isturf(my_target.loc))
		var/datum/cb = CALLBACK(src,PROC_REF(sidestep))
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
		lonely_timer_id = addtimer(CALLBACK(src,PROC_REF(queue_unbirth)), 30 SECONDS, TIMER_STOPPABLE)
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

		var/static/hostile_machines = typecacheof(list(/obj/machinery/porta_turret, /obj/mecha, /obj/item/electronic_assembly))

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
			if(CanAttack(A))//Can we attack it?
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
		if(CanAttack(A))
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
/mob/living/simple_animal/hostile/CanAttack(atom/the_target)//Can we actually attack a possible targette?
	if(!the_target || the_target.type == /atom/movable/lighting_object || isturf(the_target)) // bail out on invalids
		return FALSE

	if(ismob(the_target)) //Target is in godmode, ignore it.
		var/mob/M = the_target
		if(M.ignore_faction)
			return FALSE
		if(M.status_flags & GODMODE)
			return FALSE
		if(!M.client)
			if(!SSmobs.debug_disable_mob_ceasefire)
				var/client_in_range = FALSE
				for(var/mob/living/L in SSmobs.clients_by_zlevel[z])
					if(get_dist(src, L) < SSmobs.distance_where_a_player_needs_to_be_in_for_npcs_to_fight_other_npcs)
						client_in_range = TRUE
						break
				if(!client_in_range)
					return FALSE

	if(see_invisible < the_target.invisibility)//Target's invisible to us, forget it
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
				if(attack_downed_players && L.stat == SOFT_CRIT && iscarbon(L))
					/// so fun fact, not all players go into crit at 0 HP
					/// some go into crit at, like, 50 HP, or at -40 HP
					/// so we have to offset the crit threshold by the amount of health they have
					if(!L.attackable_in_crit())
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
				if(CanAttack(M.occupant))
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

//What we do after closing in
/mob/living/simple_animal/hostile/proc/MeleeAction(patience = TRUE)
	if(rapid_melee > 1)
		var/datum/callback/cb = CALLBACK(src,PROC_REF(CheckAndAttack))
		var/delay = SSnpcpool.wait / rapid_melee
		for(var/i in 1 to rapid_melee)
			addtimer(cb, (i - 1)*delay)
	else
		AttackingTarget()
	if(patience)
		GainPatience()

/mob/living/simple_animal/hostile/proc/CheckAndAttack()
	var/atom/origin = get_origin()
	var/atom/my_target = get_target()
	if(my_target && origin && isturf(origin.loc) && my_target.Adjacent(origin) && !incapacitated())
		AttackingTarget()

/mob/living/simple_animal/hostile/proc/MoveToTarget(list/possible_targets)//Step 5, handle movement between us and our targette
	stop_automated_movement = 1
	if (peaceful == TRUE)
		LoseTarget()
		return 0
	var/atom/my_target = get_target()
	if(!my_target || !CanAttack(my_target))
		LoseTarget()
		return 0
	var/atom/origin = get_origin()
	if(my_target in possible_targets)
		var/turf/T = get_turf(src)
		if(my_target.z != T.z)
			LoseTarget()
			return 0
		if(winding_up_melee)
			return 0
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
		if(my_target)
			if(COOLDOWN_TIMELEFT(src, melee_cooldown))
				return TRUE
			COOLDOWN_START(src, melee_cooldown, melee_attack_cooldown)
			if(!winding_up_melee && origin && isturf(origin.loc) && my_target.Adjacent(origin)) //If they're next to us, attack
				MeleeAction()
			else
				if(!winding_up_melee && rapid_melee > 1 && target_distance <= melee_queue_distance)
					MeleeAction(FALSE)
				in_melee = FALSE //If we're just preparing to strike do not enter sidestep mode
			return 1
		return 0
	if(environment_smash && !winding_up_melee)
		if(my_target.loc != null && get_dist(origin, my_target.loc) <= vision_range) //We can't see our targette, but he's in our vision range still
			if(ranged_ignores_vision && ranged_cooldown <= world.time) //we can't see our targette... but we can fire at them!
				OpenFire(my_target)
			if((environment_smash & ENVIRONMENT_SMASH_WALLS) || (environment_smash & ENVIRONMENT_SMASH_RWALLS) || robuster_searching || SSmobs.debug_everyone_has_robuster_searching) //If we're capable of smashing through walls, forget about vision completely after finding our targette
				Goto(my_target,move_to_delay,minimum_distance)
				FindHidden()
				return 1
			else
				if(FindHidden())
					return 1
	LoseTarget()
	return 0

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
		if(amount > 0)
			tacticalretreat()
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


/mob/living/simple_animal/hostile/proc/AttackingTarget()
	if(!melee_attacks)
		return
	var/atom/my_target = get_target()
	SEND_SIGNAL(src, COMSIG_HOSTILE_ATTACKINGTARGET, my_target)
	in_melee = TRUE
	if(prob(alternate_attack_prob) && AlternateAttackingTarget(my_target))
		return FALSE
	if(melee_windup_time)
		var/m_rd = retreat_distance
		var/m_md = minimum_distance
		winding_up_melee = TRUE //Don't increase our retreating distance while winding up
		retreat_distance = null //Stop retreating
		minimum_distance = 1 //Stop moving away
		if(melee_windup_sound)
			playsound(src.loc, melee_windup_sound, 150, TRUE, distant_range = 4)	//Play the windup sound effect to warn that an attack is coming.
		INVOKE_ASYNC(src, TYPE_PROC_REF(/atom/,do_windup), melee_windup_magnitude, melee_windup_time)	//Bouncing bitches.
		if(do_after(user=src,delay=melee_windup_time,needhand=FALSE,progress=FALSE,required_mobility_flags=null,allow_movement=TRUE,stay_close=FALSE,public_progbar=FALSE))
			my_target = get_target() //Switch targets if we did during our windup.
			if(my_target && Adjacent(my_target)) //If we waited, check if we died or something before finishing the attack windup. If so, don't attack.
				retreat_distance = m_rd
				minimum_distance = m_md
				winding_up_melee = FALSE
				return my_target.attack_animal(src)
			else
				retreat_distance = m_rd
				minimum_distance = m_md
				winding_up_melee = FALSE
				return FALSE
		else
			retreat_distance = m_rd
			minimum_distance = m_md
			winding_up_melee = FALSE
			return FALSE
	else
		return 	my_target.attack_animal(src)

/// Does an extra *thing* when attacking. Return TRUE to not do the standard attack
/mob/living/simple_animal/hostile/proc/AlternateAttackingTarget(atom/the_target)
	return

/mob/living/simple_animal/hostile/proc/Aggro()
	if(ckey)
		return TRUE
	vision_range = aggro_vision_range
	var/atom/my_target = get_target()
	if(my_target && LAZYLEN(emote_taunt) && prob(taunt_chance))
		INVOKE_ASYNC(src,PROC_REF(emote), "me", EMOTE_VISIBLE, "[pick(emote_taunt)] at [my_target].")
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

/mob/living/simple_animal/hostile/proc/CheckFriendlyFire(atom/A)
	if(!check_friendly_fire || ckey || should_factionize_shots)
		return FALSE
	for(var/turf/T in getline(src,A)) // Not 100% reliable but this is faster than simulating actual trajectory
		for(var/mob/living/L in T)
			if(L == src || L == A)
				continue
			if(faction_check_mob(L) && !attack_same)
				return TRUE

/mob/living/simple_animal/hostile/proc/OpenFire(atom/A)
	if(COOLDOWN_TIMELEFT(src, sight_shoot_delay))
		return FALSE
	if(CheckFriendlyFire(A))
		return
	visible_message(span_danger("<b>[src]</b> [islist(ranged_message) ? pick(ranged_message) : ranged_message] at [A]!"))
	var/spreadgun = ranged_base_spread
	if(rapid > 1)
		for(var/i in 1 to rapid)
			addtimer(CALLBACK(src,PROC_REF(Shoot), A, spreadgun), (i - 1)*rapid_fire_delay)
			spreadgun += ranged_extra_spread_per_shot
	else
		Shoot(A, spreadgun)
		for(var/i in 1 to extra_projectiles)
			addtimer(CALLBACK(src,PROC_REF(Shoot), A, spreadgun), i * auto_fire_delay)
			spreadgun += ranged_extra_spread_per_shot
	ThrowSomething(A)
	ranged_cooldown = world.time + ranged_cooldown_time + rand(0,30)
	if(sound_after_shooting)
		addtimer(CALLBACK(usr, GLOBAL_PROC_REF(playsound), src, sound_after_shooting, 100, 0, 0), sound_after_shooting_delay, TIMER_STOPPABLE)
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

/mob/living/simple_animal/hostile/proc/Shoot(atom/targeted_atom, spread = 0)
	var/atom/origin = get_origin()
	if( !origin || QDELETED(targeted_atom) || targeted_atom == origin.loc || targeted_atom == origin )
		return
	var/turf/startloc = get_turf(origin)
	if(!spread)
		spread = ranged_base_spread
	var/true_spread = spread ? rand(-spread, spread) : 0
	true_spread = clamp(true_spread, -ranged_max_spread, ranged_max_spread)
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
		casing.fire_casing(targeted_atom, src, null, null, null, ran_zone(), true_spread, null, null, null, src)
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
		P.preparePixelProjectile(targeted_atom, src, spread = true_spread)
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


/mob/living/simple_animal/hostile/proc/DestroySurroundings() // for use with megafauna destroying everything around them
	if(environment_smash)
		EscapeConfinement()
		for(var/dir in GLOB.cardinals)
			DestroyObjectsInDirection(dir)


/mob/living/simple_animal/hostile/proc/EscapeConfinement()
	if(buckled)
		buckled.attack_animal(src)
	var/atom/origin = get_origin()
	if(!origin)
		return
	if(!isturf(origin.loc) && origin.loc != null)//Did someone put us in something?
		var/atom/A = origin.loc
		A.attack_animal(src)//Bang on it till we get out


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
	if(ranged && ranged_cooldown <= world.time)
		GiveTarget(A)
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
		lose_patience_timer_id = addtimer(CALLBACK(src,PROC_REF(LoseTarget)), lose_patience_timeout, TIMER_STOPPABLE)


/mob/living/simple_animal/hostile/proc/LosePatience()
	deltimer(lose_patience_timer_id)


//These two procs handle losing and regaining search_objects when attacked by a mob
/mob/living/simple_animal/hostile/proc/LoseSearchObjects()
	if(QDELETED(src))
		return

	search_objects = 0
	deltimer(search_objects_timer_id)
	search_objects_timer_id = addtimer(CALLBACK(src,PROC_REF(RegainSearchObjects)), search_objects_regain_time, TIMER_STOPPABLE)


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
	var/static/hostile_machines = typecacheof(list(/obj/machinery/porta_turret, /obj/mecha))
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
	unset_target()
	if(!new_target)
		return
	target = WEAKREF(new_target)
	RegisterSignal(target, COMSIG_PARENT_QDELETING,PROC_REF(handle_target_del), TRUE)

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
	went_to_sleep = TRUE
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
	addtimer(CALLBACK(src,PROC_REF(un_emp_stun)), min(intensity, 3 SECONDS))

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
	addtimer(CALLBACK(src,PROC_REF(un_emp_berserk), old_faction), intensity SECONDS * 0.5)

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
	ranged_cooldown_time = rand(ranged_cooldown_time * 0.5, ranged_cooldown_time * 2)
	retreat_distance = rand(0, 10)
	minimum_distance = rand(0, 10)
	LoseTarget()
	visible_message(span_notice("[src] jerks around wildly and starts acting strange!"))

// 

/mob/living/simple_animal/hostile/proc/tacticalretreat() 
	if(!tactical_retreat) // if we're not tactically retreating,
		return // dont!
	if(stat == DEAD || (health / maxHealth) < retreat_health_percent) // If I ain't dead, and my max health percent is less than my retreat health percent then...
		retreat_distance = initial(retreat_distance) // I look at my original mob retreat distance
		return //With that sniffed then I look to see if.
	var/atom/my_target = get_target() //Do I have a target?????
	if(!retreat_message_said && my_target) //If I haven't said my retreat message and I definitely don't have a target
		var/msg = actual_retreat_message // Then play my retreat message
		msg = replacetext(msg, "%NAME", name) //with my name
		msg = replacetext(msg, "%TARGET", my_target.name) // and the targets name
		visible_message(span_danger(msg)) // in it.
		retreat_message_said = TRUE //I've officially said my retreat message
	retreat_distance = tactical_retreat // then make my retreat distance my tactical retreat distance
	//Now I run like hell until my health is higher than my health/max health retreat percent.

//Tactical Healing Code
//                                                              V these can go too
/mob/living/simple_animal/hostile/proc/tacticalhealing() // Every life tick, my hostile ass is going to...
	if(!heal_per_life || health > max_healing_ability || get_target()) //Then I check my heal per life var to see if my health isn't greater than my max healing ability and I do NOT have a target then
		return // I do a lil dance and
	adjustHealth(-heal_per_life*maxHealth) //heal this much per life tick, negative is giving me health back. I guess you could make a mob bleed out by having it do positive adjust health?
	visible_message(span_danger(replacetext(healing_message, "%NAME", name))) // almost, take a look at how the retreatcode's message is handled
	playsound(get_turf(src), healing_sound, healing_volume, 1, ignore_walls = TRUE)
	retreat_message_said = FALSE

