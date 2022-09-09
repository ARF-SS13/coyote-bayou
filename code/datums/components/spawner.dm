/datum/component/spawner
	var/mob_types = list(/mob/living/simple_animal/hostile/carp)
	/// Time between spawns
	var/spawn_time = 30 SECONDS
	/// List of mobs that we spawned that currently exist
	var/list/spawned_mobs = list()
	/// How many mobs can be attached to this spawner at once
	var/max_mobs = 5
	/// verb for when the thing comes out of the thing
	var/spawn_text = "emerges from"
	/// sound to play when the thing spawns a thing
	var/spawn_sound
	/// The minimum distance to a client before we can start spawning mobs.
	var/range = 10
	/// Override the mob's faction with this!
	var/list/faction = list("mining")
	/// If not infinite, we delete our parent when we hit max_mobs.
	var/infinite = FALSE
	/// Range to check for other mobs to see if there's too many around
	var/overpopulation_range = 5
	/// Number of mobs to spawn at once, for swarms
	var/swarm_size = 1
	/// The ID of our randomizer, so all spawners with this ID will spawn from the same list. Leave null to skip global randomization for this thing
	var/randomizer_tag
	/// Which spawner list to pick from
	var/randomizer_kind
	/// Which difficulties to pick from - its a bitfield!
	var/randomizer_difficulty
	/// spawner can be covered by dense things
	var/coverable_by_dense_things = TRUE
	/// Is something covering us?
	var/datum/weakref/covering_object
	COOLDOWN_DECLARE(spawner_cooldown)

/datum/component/spawner/Initialize(
		_mob_types,
		_spawn_time,
		_faction,
		_spawn_text,
		_max_mobs,
		_range,
		_overpopulation_range,
		_spawn_sound,
		_infinite,
		_swarm_size,
		_coverable_by_dense_things,
		_coverable,
		_randomizer_tag,
		_randomizer_kind,
		_randomizer_difficulty
	)

	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	if(_spawn_time)
		spawn_time = _spawn_time
	if(_mob_types)
		mob_types = _mob_types
	if(_faction)
		faction = _faction
	if(_spawn_text)
		spawn_text = _spawn_text
	if(_max_mobs)
		max_mobs = _max_mobs
	if(_range)
		range = _range
	if(_overpopulation_range)
		overpopulation_range = _overpopulation_range
	if(_swarm_size)
		swarm_size = _swarm_size
	if(_coverable_by_dense_things)
		coverable_by_dense_things = density_check() ? FALSE : _coverable_by_dense_things
	if(_randomizer_tag)
		randomizer_tag = _randomizer_tag
	if(_randomizer_kind)
		randomizer_kind = _randomizer_kind
	if(_randomizer_difficulty)
		randomizer_difficulty = _randomizer_difficulty
	if(_spawn_sound)
		spawn_sound = _spawn_sound
	if(_infinite)
		infinite = _infinite
	initialize_random_mob_spawners()
	if(randomizer_tag)
		setup_random_nest()

	RegisterSignal(parent, COMSIG_PARENT_QDELETING, .proc/stop_spawning)
	RegisterSignal(parent, COMSIG_OBJ_ATTACK_GENERIC, .proc/on_attack_generic)
	RegisterSignal(parent, COMSIG_SPAWNER_COVERED, .proc/stop_spawning)
	RegisterSignal(parent, COMSIG_SPAWNER_UNCOVERED, .proc/start_spawning)
	start_spawning()

/datum/component/spawner/process()
	if(should_destroy_spawner())
		qdel(parent)
		return
	if(!can_spawn_mob())
		return
	spawn_mob()

/datum/component/spawner/proc/stop_spawning(datum/source, force, hint)
	STOP_PROCESSING(SSprocessing, src)
	for(var/datum/weakref/mob_ref as anything in spawned_mobs)
		var/mob/living/simple_animal/removed_animal = mob_ref.resolve()
		if(!removed_animal)
			continue
		if(removed_animal.nest == src)
			removed_animal.nest = null
	spawned_mobs = null

/// Something told us to restart spawning
/datum/component/spawner/proc/start_spawning()
	START_PROCESSING(SSprocessing, src)

// Stopping clientless simple mobs' from indiscriminately bashing their own spawners due DestroySurroundings() et similars.
/datum/component/spawner/proc/on_attack_generic(datum/source, mob/user, damage_amount, damage_type, damage_flag, sound_effect, armor_penetration)
	if(!user.client && ((user.faction & faction) || (WEAKREF(user) in spawned_mobs)))
		return COMPONENT_STOP_GENERIC_ATTACK

/// If we're dense, or spawned on something dense, ignore density forever
/datum/component/spawner/proc/density_check()
	var/atom/P = parent
	if(P.density == TRUE)
		return TRUE
	var/turf/spawner_place = get_turf(P)
	if(isturf(spawner_place))
		for(var/atom/thingy in spawner_place.contents)
			if(thingy.density == TRUE)
				return TRUE

/// Do we have any mobs left?
/datum/component/spawner/proc/has_mobs_left()
	return counterlist_sum(mob_types)

/// Should the spawner be destroyed?
/datum/component/spawner/proc/should_destroy_spawner()
	if(infinite)
		return FALSE
	else if(has_mobs_left())
		return FALSE
	return TRUE

/// Check the spawned mob list, prune dead mobs, return TRUE if it isnt full
/datum/component/spawner/proc/check_spawned_mobs()
	if(LAZYLEN(spawned_mobs) < max_mobs)
		return TRUE
	for(var/datum/weakref/mob_ref as anything in spawned_mobs)
		var/mob/living/simple_animal/removed_animal = mob_ref.resolve()
		if(!removed_animal)
			spawned_mobs -= mob_ref
		else if(removed_animal.health <= 0)
			spawned_mobs -= mob_ref
			removed_animal.nest = null
	if(LAZYLEN(spawned_mobs) < max_mobs)
		return TRUE

/// Basic checks to see if we can spawn something
/datum/component/spawner/proc/can_spawn_mob()
	if(COOLDOWN_TIMELEFT(src, spawner_cooldown))
		return FALSE
	if(!check_spawned_mobs())
		return FALSE
	var/atom/P = parent
	if(coverable_by_dense_things)
		var/turf/our_turf = get_turf(P)
		var/atom/movable/previous_heavy_thing = covering_object?.resolve()
		if(previous_heavy_thing)
			if(get_turf(previous_heavy_thing) == our_turf)
				return FALSE
			else
				covering_object = null // mustve wandered off
		/// Accounts for anything dense, which includes mobs, mechs, lockers, etc
		for(var/atom/movable/maybe_heavy_thing in our_turf.contents)
			if(maybe_heavy_thing.density == TRUE)
				covering_object = WEAKREF(maybe_heavy_thing)
				return FALSE
	if(range)
		var/is_close_enough = FALSE
		for(var/mob/living as anything in SSmobs.clients_by_zlevel[P.z]) // client-containing mobs, NOT clients
			if(get_dist(P, living) <= range)
				is_close_enough = TRUE
				break
		if(!is_close_enough)
			return FALSE
	/* if(overpopulation_range)
		var/mobs_in_range
		for(var/mob/living/simple_animal/living_mob in range(overpopulation_range, get_turf(P)))
			if(mobs_in_range++ >= max_mobs)
				return FALSE */
	return TRUE

/// spawn the mob(s)
/datum/component/spawner/proc/spawn_mob()
	if(!islist(spawned_mobs))
		spawned_mobs = list()
	var/atom/P = parent
	var/chosen_mob
	var/mob/living/simple_animal/L
	for(var/i = 1 to swarm_size)
		if(infinite) // dont decrement the spawnlist
			chosen_mob = pickweight(mob_types)
		else
			chosen_mob = pickweight_n_reduce(mob_types)
		if(!chosen_mob)
			qdel(P) // clearly, out of mobs. shouldnt get here
			return
		L = new chosen_mob(get_turf(P))
		L.flags_1 |= (P.flags_1 & ADMIN_SPAWNED_1) //If we were admin spawned, lets have our children count as that as well.
		spawned_mobs |= WEAKREF(L)
		L.nest = WEAKREF(P) // Neither really own each other, its all purely for record keeping
		if(length(faction))
			L.faction = src.faction
	P.visible_message(span_danger("[L] [spawn_text] [P]."))
	if(spawn_sound)
		playsound(P, spawn_sound, 30, 1)
	COOLDOWN_START(src, spawner_cooldown, spawn_time)

/datum/component/spawner/proc/setup_random_nest()
	if(!randomizer_tag)
		return FALSE
	if(!randomizer_kind)
		return FALSE
	if(!randomizer_difficulty)
		return FALSE
	/// Is our tag not in the global mob spawner thing?
	if(!(randomizer_tag in GLOB.mob_spawner_random_index))
		add_nest_to_global_list()
	apply_nest_from_global_list()
	return

/// Takes an entry from our global list and uses it to make our fancy nest!
/datum/component/spawner/proc/add_nest_to_global_list()
	if(!randomizer_tag)
		return FALSE
	if(!randomizer_kind)
		return FALSE
	if(!randomizer_difficulty)
		return FALSE
	var/datum/random_mob_spawner_group/our_group = GLOB.random_mob_nest_spawner_groups[randomizer_kind]
	var/mob_list_tag_to_use = pick(our_group.group_list)

	var/list/new_nest_thing = list(
		MOB_SPAWNER_GLOBAL_LIST_KIND = mob_list_tag_to_use,
		MOB_SPAWNER_GLOBAL_LIST_DIFFICULTY = randomizer_difficulty
		)
	GLOB.mob_spawner_random_index[randomizer_tag] = new_nest_thing

/// Takes an entry from our global list and uses it to make our fancy nest!
/datum/component/spawner/proc/apply_nest_from_global_list()
	mob_types = list()
	var/list/our_randomizer_index = GLOB.mob_spawner_random_index[randomizer_tag]
	var/datum/random_mob_spawner/our_spawner = GLOB.random_mob_nest_spawner_datums[our_randomizer_index[MOB_SPAWNER_GLOBAL_LIST_KIND]]
	if(!istype(our_spawner))
		message_admins(span_phobia("Hey! [src] was passed randomizer index [our_randomizer_index], which gave a null spawner datum! Tell Superlagg to fix his shit!"))
		return
	var/atom/P = parent
	P.name = our_spawner.nest_name
	P.desc = our_spawner.nest_desc
	P.icon_state = our_spawner.nest_icon_state
	spawn_sound = our_spawner.sound_to_play
	if(our_randomizer_index[MOB_SPAWNER_GLOBAL_LIST_DIFFICULTY] & MOB_SPAWNER_DIFFICULTY_EASY)
		counterlist_combine(mob_types, our_spawner.mob_list_easy)
		max_mobs = our_spawner.num_mobs_to_spawn_easy
		swarm_size = our_spawner.max_mob_swarm_easy
		spawn_time = our_spawner.mob_respawn_time_easy
	if(our_randomizer_index[MOB_SPAWNER_GLOBAL_LIST_DIFFICULTY] & MOB_SPAWNER_DIFFICULTY_MED)
		counterlist_combine(mob_types, our_spawner.mob_list_medium)
		max_mobs = our_spawner.num_mobs_to_spawn_medium
		swarm_size = our_spawner.max_mob_swarm_medium
		spawn_time = our_spawner.mob_respawn_time_medium
	if(our_randomizer_index[MOB_SPAWNER_GLOBAL_LIST_DIFFICULTY] & MOB_SPAWNER_DIFFICULTY_HARD)
		counterlist_combine(mob_types, our_spawner.mob_list_hard)
		max_mobs = our_spawner.num_mobs_to_spawn_hard
		swarm_size = our_spawner.max_mob_swarm_hard
		spawn_time = our_spawner.mob_respawn_time_hard

/datum/component/spawner/proc/initialize_random_mob_spawners()
	if(!LAZYLEN(GLOB.random_mob_nest_spawner_datums))
		for(var/r_spawn in subtypesof(/datum/random_mob_spawner))
			var/datum/random_mob_spawner/r_spawn_datum = new r_spawn()
			GLOB.random_mob_nest_spawner_datums[r_spawn_datum.nest_tag] = r_spawn_datum
	if(!LAZYLEN(GLOB.random_mob_nest_spawner_groups))
		for(var/r_group in subtypesof(/datum/random_mob_spawner_group))
			var/datum/random_mob_spawner_group/r_group_datum = new r_group()
			GLOB.random_mob_nest_spawner_groups[r_group_datum.group_tag] = r_group_datum









