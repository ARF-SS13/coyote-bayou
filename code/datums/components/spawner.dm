/datum/component/spawner
	var/list/mob_types = list(/mob/living/simple_animal/hostile/carp)
	/// List of 'special' mobs to spawn
	/// Format: list(special_mob_datum)
	var/list/special_mobs = list()
	/// Time between spawns
	var/spawn_time = 30 SECONDS
	/// List of mobs that we spawned that currently exist
	var/list/spawned_mobs = list()
	/// How many mobs can be attached to this spawner at once
	var/max_mobs = 5
	/// verb for when the thing comes out of the thing
	var/spawn_text = ""
	/// sound to play when the thing spawns a thing
	var/spawn_sound
	/// The minimum distance to a client before we can start spawning mobs.
	var/range = 16
	/// min radius that the nest will not spawn if a player is within
	var/min_range = 10
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
	/// Dont start spawning just yet
	var/delay_start = FALSE
	/// If we should make our mobs just ignore faction checks (from other mobs, they still attack players)
	var/ignore_faction = FALSE
	/// im special
	var/am_special = FALSE
	/// Is something covering us?
	var/datum/weakref/covering_object
	/// use the old spawner player-is-close check
	var/old_spawner_check = FALSE
	/// All our turfs that we're listening to
	// var/list/my_turfs = list() // its a list of coords
	// /// All our turfs that somehow got destroyed, and we need to reconnect with
	// var/list/disconnected = list() // its a list of coords
	var/active = FALSE
	/// When tripped, when do we stop trying to spawn things?
	COOLDOWN_DECLARE(spawn_until)
	COOLDOWN_DECLARE(spawner_cooldown)
	var/covered = FALSE
	var/datum/nest_box/my_ticket
	var/generation = 1

	var/rts_next_spawn_time
	var/rts_spawn_cd = 5 SECONDS

/datum/component/spawner/Initialize(
		_mob_types,
		_spawn_time,
		_faction,
		// _spawn_text,
		_max_mobs,
		_range,
		_min_range,
		_overpopulation_range,
		_spawn_sound,
		_infinite,
		_swarm_size,
		_coverable_by_dense_things,
		_coverable,
		_randomizer_tag,
		_randomizer_kind,
		_randomizer_difficulty,
		_delay_start,
		_ignore_faction,
		_generation,
	)

	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	if(_spawn_time)
		spawn_time = _spawn_time
	if(_mob_types)
		mob_types = _mob_types
	if(_faction)
		faction = _faction
	if(!LAZYLEN(faction) || ("UPDATEME" in _faction))
		for(var/mobpath in mob_types)
			var/mob/living/mobinit = mobpath
			var/list/fact = initial(mobinit.faction)
			if(LAZYLEN(fact))
				faction |= fact
	//if(_spawn_text)
		//spawn_text = _spawn_text
	if(_max_mobs)
		max_mobs = _max_mobs
	if(_range)
		range = _range
	if(_min_range)
		min_range = _min_range
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
	if(_delay_start)
		delay_start = _delay_start
	if(_ignore_faction)
		ignore_faction = _ignore_faction
	if(_generation)
		generation = _generation
	initialize_random_mob_spawners()
	if(randomizer_tag)
		setup_random_nest()
	RegisterSignal(parent, COMSIG_PARENT_QDELETING,   PROC_REF(nest_destroyed))
	RegisterSignal(parent, COMSIG_OBJ_ATTACK_GENERIC, PROC_REF(on_attack_generic))
	RegisterSignal(parent, COMSIG_SPAWNER_COVERED,    PROC_REF(coverme))
	RegisterSignal(parent, COMSIG_SPAWNER_UNCOVERED,  PROC_REF(uncoverme))
	RegisterSignal(parent, COMSIG_SPAWNER_ABSORB_MOB, PROC_REF(unbirth_mob))
	RegisterSignal(parent, COMSIG_ATOM_QUEST_SCANNED, PROC_REF(dump_questables))
	RegisterSignal(parent, COMSIG_ATOM_RTS_RIGHTCLICKED, PROC_REF(rts_spawn_mobs))
	RegisterSignal(parent, COMSIG_IS_IT_A_NEST, PROC_REF(yes_it_is))
	// RegisterSignal(parent, COMSIG_ATOM_RTS_KIND,      PROC_REF(can_rts))
	// RegisterSignal(parent, COMSIG_SPAWNER_EXISTS,PROC_REF(has_spawner))
	if(istype(parent, /obj/structure/nest))
		var/obj/structure/nest/nest = parent
		if(nest.spawned_by_ckey)
			am_special = TRUE
	if(istype(parent, /obj/structure/nest/special) || ismob(parent))
		am_special = TRUE
		RegisterSignal(parent, COMSIG_SPAWNER_SPAWN_NOW,PROC_REF(spawn_mob_special))
	if(!ismob(parent) && !am_special && !delay_start && LAZYLEN(mob_types))
		my_ticket = new /datum/nest_box(src)
	// if(SSspawners.use_turf_registration)
	// 	register_turfs()
	// else
	old_spawner_check = TRUE
	if(!delay_start && !am_special)
		start_spawning()

/datum/component/spawner/proc/yes_it_is()
	return TRUE // is this story based? yes it is

// /datum/component/spawner/proc/can_rts()
// 	return RTS_KIND_SPAWNER

// /datum/component/spawner/proc/register_turfs()
// 	var/atom/dad = parent
// 	if(!dad.loc)
// 		return
// 	var/debug_color = SSspawners.debug_spawner_turfs ? "#[random_color()]" : null
// 	for(var/turf/trip in range(range, dad.loc))
// 		connect_to_turf(trip, debug_color)

// /datum/component/spawner/proc/connect_to_turf(turf/trip, debug_color)
// 	my_turfs |= atom2coords(trip)
//	RegisterSignal(trip, COMSIG_ATOM_ENTERED,PROC_REF(turf_trip))
//	RegisterSignal(trip, COMSIG_TURF_CHANGE,PROC_REF(turf_changed))
// 	if(SSspawners.debug_spawner_turfs && debug_color)
// 		trip.add_atom_colour(debug_color, ADMIN_COLOUR_PRIORITY)

// /datum/component/spawner/proc/turf_changed(turf/changed)
// 	if(!isturf(changed))
// 		return
// 	disconnected |= atom2coords(changed)
// 	start_spawning()

// /datum/component/spawner/proc/unregister_turfs()
// 	for(var/coords in my_turfs)
// 		var/turf/trip = coords2turf(coords)
// 		if(!trip)
// 			continue
// 		trip.remove_atom_colour(ADMIN_COLOUR_PRIORITY)
// 		UnregisterSignal(trip, COMSIG_ATOM_ENTERED, COMSIG_TURF_CHANGE)
// 	my_turfs = list()
// 	disconnected = list()

// /datum/component/spawner/proc/reconnect()
// 	if(!LAZYLEN(disconnected))
// 		return
// 	var/debug_color = SSspawners.debug_spawner_turfs ? "#[randomColor()]" : null
// 	for(var/coord in disconnected)
// 		var/turf/trip = coords2turf(coord)
// 		if(!trip)
// 			continue
// 		connect_to_turf(trip, debug_color)

// /datum/component/spawner/proc/still_there()
// 	return TRUE // hi

/datum/component/spawner/process()
	old_spawn()
	// if(old_spawner_check)
	// 	old_spawn()
	// 	return
	// if(COOLDOWN_FINISHED(src, spawn_until))
	// 	stop_spawning(null, FALSE)
	// 	return
	// if(spawn_until && !COOLDOWN_FINISHED(src, spawn_until))
	// 	try_to_spawn()
	// else
	// 	reconnect()

/// something entered one of our turfs, check if we should spawn something
/datum/component/spawner/proc/turf_trip(datum/source, atom/movable/arrived)
	if(!check_mob(usr)) // could write a proc that searches everything for a mob, buuuuuuut........ dont wanna
		return
	if(!am_special && spawn_until && !COOLDOWN_FINISHED(src, spawn_until))
		COOLDOWN_START(src, spawn_until, SSspawners.active_duration)
		return
	if(am_special)
		spawn_mob_special()
		return
	COOLDOWN_START(src, spawn_until, SSspawners.active_duration)
	start_spawning()

/// Something told us to restart spawning
/datum/component/spawner/proc/uncoverme()
	covered = FALSE
	start_spawning()

/// Something told us to restart spawning
/datum/component/spawner/proc/coverme()
	covered = TRUE
	stop_spawning()

/// Something told us to restart spawning
/datum/component/spawner/proc/start_spawning()
	if(covered)
		return
	COOLDOWN_START(src, spawn_until, SSspawners.active_duration)
	active = TRUE
	START_PROCESSING(SSspawners, src)

/datum/component/spawner/proc/stop_spawning(datum/source, clear_spawned_mobs = TRUE)
	STOP_PROCESSING(SSspawners, src)
	COOLDOWN_RESET(src, spawn_until)
	if(!clear_spawned_mobs)
		return
	for(var/datum/weakref/mob_ref as anything in spawned_mobs)
		var/mob/living/simple_animal/removed_animal = mob_ref.resolve()
		if(!removed_animal)
			continue
		if(removed_animal.nest == src)
			removed_animal.nest = null
	spawned_mobs = null

/datum/component/spawner/proc/nest_destroyed(datum/source, force, hint)
	stop_spawning()
	if(my_ticket && !am_special && !ismob(parent)) // we'll be back, eventually
		my_ticket.globalize(src)
	qdel(src)

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

/// Should the spawner be destroyed?
/datum/component/spawner/proc/should_destroy_spawner()
	if(infinite)
		return FALSE
	if(has_mobs_left())
		return FALSE
	if(QDELETED(parent))
		qdel(src)
		return FALSE // nothing to delete
	if(ismob(parent))
		qdel(src)
		return FALSE // no more self-destructing ant queens
	return TRUE

/// Do we have any mobs left?
/datum/component/spawner/proc/has_mobs_left()
	return LAZYLEN(mob_types) || LAZYLEN(special_mobs)

/datum/component/spawner/proc/check_mob(mob/living/check)
	if(!isliving(check))
		return FALSE
	if(!check.client)
		return FALSE
	return TRUE

/// Basic checks to see if we can spawn something
/datum/component/spawner/proc/try_to_spawn()
	if(covered)
		return FALSE
	if(COOLDOWN_TIMELEFT(src, spawner_cooldown))
		return FALSE
	if(!check_spawned_mobs())
		return FALSE
	if(something_covering_us())
		return FALSE
	spawn_mob()
	COOLDOWN_START(src, spawner_cooldown, spawn_time)
	if(should_destroy_spawner())
		qdel(parent)
		return

/datum/component/spawner/proc/something_in_range()
	if(!range)
		return TRUE
	var/atom/P = parent
	for(var/mob/living/butt in LAZYACCESS(SSmobs.clients_by_zlevel, P?.z)) // client-containing mobs, NOT clients
		var/mrange = (get_dist(P, butt))
		if(mrange <= range)
			if(am_special)
				return TRUE
			else if(mrange > min_range)
				return TRUE

/// first checks if anyone is in range, then if so, turns itself on for another 20ish seconds
/datum/component/spawner/proc/old_spawn()
	if(!COOLDOWN_FINISHED(src, spawner_cooldown))
		return
	// if(COOLDOWN_FINISHED(src, spawn_until))
	// 	deactivate()
	if(should_destroy_spawner())
		qdel(parent)
		return
	// if(!active)
	// 	if(!something_in_range())
	// 		return
	// 	activate()
	if(something_in_range())
		if(!am_special && blocked())
			return
		try_to_spawn()

/// checks if we're blocked by something
/datum/component/spawner/proc/blocked()
	var/atom/A = parent
	var/turf/here = get_turf(A)
	for(var/obj/structure/respawner_blocker/RB in SSmonster_spawner.spawn_blockers)
		if(here.z != RB.z)
			continue
		var/maxdist = RB.protection_radius
		if(maxdist <= 0)
			continue
		if(get_dist(RB, here) <= maxdist)
			RB.blocked_something()
			return TRUE

/// turns itself on for another 20ish seconds
/datum/component/spawner/proc/activate()
	active = TRUE
	COOLDOWN_START(src, spawn_until, SSspawners.active_duration)

/// turns itself off
/datum/component/spawner/proc/deactivate()
	active = FALSE
	COOLDOWN_RESET(src, spawn_until)

/// is something covering us?
/datum/component/spawner/proc/something_covering_us()
	if(!coverable_by_dense_things)
		return FALSE
	var/atom/P = parent
	var/turf/our_turf = get_turf(P)
	if(!our_turf) // mobs keep spawning in nullspace for some bizarre reason
		qdel(P) // and I aint dealing with that shit
		return
	/// Accounts for anything dense, which includes mobs, mechs, lockers, etc
	for(var/atom/movable/maybe_heavy_thing in our_turf.contents)
		if(maybe_heavy_thing.density)
			return TRUE

/// Check the spawned mob list, prune dead mobs, return TRUE if it isnt full
/datum/component/spawner/proc/check_spawned_mobs()
	if(LAZYLEN(spawned_mobs) < max_mobs)
		return TRUE
	for(var/datum/weakref/mob_ref in spawned_mobs)
		var/mob/living/simple_animal/removed_animal = mob_ref.resolve()
		if(!removed_animal)
			spawned_mobs -= mob_ref
		else if(removed_animal.health <= 0)
			spawned_mobs -= mob_ref
			removed_animal.nest = null
	if(LAZYLEN(spawned_mobs) < max_mobs)
		return TRUE

/// spawns a mob, then immediately tries to self-destruct
/datum/component/spawner/proc/spawn_mob_special()
	spawn_mob()
	if(should_destroy_spawner())
		qdel(parent)

/// spawn the mob(s)
/datum/component/spawner/proc/spawn_mob(list/overrides, no_sleep)
	var/atom/P = parent
	if(!islist(spawned_mobs))
		spawned_mobs = list()
	if(LAZYLEN(special_mobs))
		var/datum/special_mob_datum/spawner_special = pick(special_mobs)
		if(spawner_special)
			var/mob/living/simple_animal/hostile/mobbie = spawner_special.make_special_mob(src)
			spawned_mobs |= WEAKREF(mobbie)
			mobbie.nest = WEAKREF(P)
			qdel(spawner_special)
			return
	var/chosen_mob
	var/override_mob = LAZYACCESS(overrides, "which_mob")
	var/override_swarm = LAZYACCESS(overrides, "how_many")
	var/mob/living/simple_animal/L = override_mob
	var/how_many = override_swarm || swarm_size
	for(var/i in 1 to how_many)
		if(ispath(L) && mob_types[L] >= 1)
			chosen_mob = L
			mob_types[L]--
		if(!ispath(L))
			if(infinite) // dont decrement the spawnlist
				chosen_mob = pickweight(mob_types)
			else
				chosen_mob = pickweight_n_reduce(mob_types)
		if(!chosen_mob)
			if(istype(parent, /obj/structure/nest))
				qdel(P) // clearly, out of mobs. shouldnt get here
			return
		L = new chosen_mob(get_turf(P), "TOPHEAVY-KOBOLD")
		L.flags_1 |= (P.flags_1 & ADMIN_SPAWNED_1) //If we were admin spawned, lets have our children count as that as well.
		if(no_sleep)
			L.flags_2 |= MOB_NO_SLEEP
		spawned_mobs |= WEAKREF(L)
		L.link_to_nest(P)
		if(length(faction))
			L.faction = src.faction
		// if(ignore_faction)
		// 	L.ignore_faction = TRUE
	// P.visible_message(span_danger("[L] [spawn_text] [P]."))
	if(spawn_sound)
		playsound(P, spawn_sound, 30, 1)
	COOLDOWN_START(src, spawner_cooldown, spawn_time)

/datum/component/spawner/proc/remove_mob_from_nest(datum/source, mob/living/simple_animal/removed_animal)
	for(var/datum/weakref/maybe_them in spawned_mobs)
		if(GET_WEAKREF(maybe_them) == removed_animal)
			spawned_mobs -= maybe_them

/datum/component/spawner/proc/rts_spawn_mobs(datum/source, mob/user)
	if(!user)
		return
	if(rts_next_spawn_time > world.time)
		to_chat(user, span_alert("The nest still has [(rts_next_spawn_time - world.time) / 10] seconds left before it can spawn again!"))
		return RTS_COMMAND_FAILED_COOLDOWN
	rts_next_spawn_time = world.time + rts_spawn_cd
	for(var/i in 1 to rand(1, 3))
		spawn_mob(no_sleep = TRUE)
	COOLDOWN_START(src, spawner_cooldown, spawn_time)
	if(should_destroy_spawner())
		qdel(parent)
	return RTS_COMMAND_SUCCESS

/datum/component/spawner/proc/dump_questables(datum/source, mob/user)
	if(!user)
		return
	var/datum/quest_book/QB = SSeconomy.get_quest_book(user)
	if(!QB)
		return
	if(!QB.scanning_mobs_makes_nests_dump_questable_mobs)
		return
	var/list/questable_typecache = QB.get_quest_paths()
	if(!LAZYLEN(questable_typecache))
		return
	var/list/squirts = list()
	for(var/mobpath in mob_types)
		if(questable_typecache[mobpath])
			squirts += mobpath
	if(!LAZYLEN(squirts))
		return
	var/squirts_left = 4
	var/squirts_per = round(squirts_left / LAZYLEN(squirts))
	for(var/mobpath in squirts)
		spawn_mob(list("which_mob" = mobpath, "how_many" = round(squirts_per)))
		squirts_left -= squirts_per
		if(squirts_left <= 0)
			break


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

/// A holder for all sorts of our spawner data, so wacky events can make em come back
/datum/nest_box
	var/spawn_time = 0
	var/max_mobs = 0
	var/spawn_text = "emerges from"
	var/spawn_sound = null
	var/list/faction = list()
	var/coverable_by_dense_things = TRUE
	var/coverable = TRUE
	var/randomizer_tag = null
	var/randomizer_kind = null
	var/randomizer_difficulty = 0
	var/delay_start = FALSE
	var/am_special = FALSE
	var/coords = null
	var/list/mob_types = list()
	var/infinite = FALSE
	var/overpopulation_range = 5
	var/swarm_size = 1
	var/radius = 10
	var/ignore_faction = FALSE
	/// and the stuff relating to the actual spawner next object thing
	var/nest_name
	var/nest_desc
	var/nest_icon
	var/nest_icon_state
	var/nest_resistance_flags
	var/nest_anchored
	var/nest_layer

	var/generation = 0

	var/time_i_died = 0
	var/delayed_by = 0
	var/datum/weakref/assigned_to

/datum/nest_box/New(datum/component/spawner/girlfriend)
	if(girlfriend.am_special)
		return
	spawn_time                = girlfriend.spawn_time
	max_mobs                  = girlfriend.max_mobs
	// spawn_text                = girlfriend.spawn_text
	spawn_sound               = girlfriend.spawn_sound
	faction                   = girlfriend.faction.Copy()
	if(!islist(faction))
		faction = list(faction)
	faction                  |= "UPDATEME"
	coverable_by_dense_things = girlfriend.coverable_by_dense_things
	randomizer_tag            = girlfriend.randomizer_tag
	randomizer_kind           = girlfriend.randomizer_kind
	randomizer_difficulty     = girlfriend.randomizer_difficulty
	delay_start               = girlfriend.delay_start
	am_special                = girlfriend.am_special
	coords                    = atom2coords(girlfriend.parent)
	mob_types                 = girlfriend.mob_types.Copy()
	infinite                  = girlfriend.infinite
	overpopulation_range      = girlfriend.overpopulation_range
	swarm_size                = girlfriend.swarm_size
	generation                = girlfriend.generation + 1
	var/obj/P = girlfriend.parent
	nest_name                 = P.name
	nest_desc                 = P.desc
	nest_icon                 = P.icon
	nest_icon_state           = P.icon_state
	nest_anchored             = P.anchored
	nest_layer                = P.layer

/datum/nest_box/Destroy(force, ...)
	var/mob/living/simple_animal/nest_spawn_hole_guy/NSHG = GET_WEAKREF(assigned_to)
	if(istype(NSHG))
		NSHG.nest_seed = null
	SSmonster_wave.unregister_nest_seed(src)
	. = ..()

/datum/nest_box/proc/globalize(datum/component/spawner/parent)
	parent?.my_ticket = null // one way or another, we're not coming back
	if(!parent)
		qdel(src)
		return FALSE
	if(!parent.parent || ismob(parent.parent)) // darn junker creators
		qdel(src)
		return FALSE
	var/obj/structure/nest/N = parent.parent // maybe if I keep writing these, mine'll get back together
	if(N.spawned_by_ckey || istype(N, /obj/structure/nest/special))
		return FALSE
	if(LAZYLEN(parent.mob_types) < 1)
		qdel(src)
		return FALSE
	var/turf/is_there = my_turf() || get_turf(parent?.parent)
	if(!is_there)
		qdel(src)
		return
	coords = atom2coords(is_there)
	time_i_died = world.time
	SSmonster_wave.register_nest_seed(src)

/datum/nest_box/proc/my_turf()
	return coords2turf(coords)

/// creates a whole new nest from our data, then CEASES TO EXIST!!!!!
/datum/nest_box/proc/pop_nest(right_here)
	SSmonster_wave.unregister_nest_seed(src)
	var/turf/here = coords2turf(right_here) || my_turf()
	if(!here)
		qdel(src)
		return
	var/obj/structure/nest/blank/nuhole = new(here)
	nuhole.name                      = nest_name
	nuhole.desc                      = nest_desc
	nuhole.icon                      = nest_icon
	nuhole.icon_state                = nest_icon_state
	nuhole.anchored                  = nest_anchored
	nuhole.layer                     = nest_layer
	nuhole.mob_types                 = mob_types
	nuhole.spawn_time                = spawn_time
	nuhole.coverable                 = coverable
	nuhole.coverable_by_dense_things = coverable_by_dense_things
	// nuhole.spawn_text                = spawn_text
	nuhole.overpopulation_range      = overpopulation_range
	nuhole.max_mobs                  = max_mobs
	nuhole.radius                    = radius
	nuhole.spawnsound                = spawn_sound
	nuhole.infinite                  = infinite
	nuhole.swarm_size                = swarm_size
	nuhole.faction                   = faction
	nuhole.randomizer_tag            = randomizer_tag
	nuhole.randomizer_kind           = randomizer_kind
	nuhole.randomizer_difficulty     = randomizer_difficulty
	nuhole.delay_start               = delay_start
	nuhole.ignore_faction            = ignore_faction
	nuhole.generation                = generation
	nuhole.make_component()
	SSmonster_wave.catalogue_me(src)
	qdel(src)

/// mutates our stored values to be a bit different!
/datum/nest_box/proc/mutate() // >:3c
	spawn_time = clamp(spawn_time + rand(-5 SECONDS, 5 SECONDS), 5 SECONDS, 60 SECONDS)
	// max_mobs = clamp(max_mobs + rand(-2, 3), 1, 10)
	overpopulation_range = clamp(overpopulation_range + rand(-2, 2), 1, 20)
	swarm_size = swarm_size > 1 ? clamp(swarm_size + rand(1, 3), 1, 10) : 1
	radius = clamp(radius + rand(-2, 2), 1, 20)
	var/list/new_paths = list()
	for(var/mobpath in mob_types)
		var/mob/living/simple_animal/hostile/baddie = mobpath
		if(ispath(baddie) && initial(baddie.bossmob) == TRUE)
			new_paths[mobpath] = mob_types[mobpath] // rolled a boss, honor tht
			continue
		if(prob(40) && LAZYLEN(mob_types) > 1)
			new_paths[mobpath] = mob_types[mobpath] // no change
			continue
		// ignore_faction = TRUE // cant guarantee they wont infight with the new guys, so lets guarantee it
		var/list/potentials = list()
		/// if its a robot, turn that robot into a different robot!
		if(ispath(mobpath, /mob/living/simple_animal/hostile/eyebot))
			potentials |= typesof(/mob/living/simple_animal/hostile/eyebot) - mobpath
			if(prob(50))
				potentials |= typesof(/mob/living/simple_animal/hostile/hivebot)
				potentials |= /mob/living/simple_animal/hostile/handy // just the root, most are rather rough
		else if(ispath(mobpath, /mob/living/simple_animal/hostile/handy)) // somehow encapsulates a heckton of horrible bots
			if(mobpath == /mob/living/simple_animal/hostile/handy) // base handies shouldnt mutate into anything horrifying
				potentials |= typesof(/mob/living/simple_animal/hostile/hivebot)
				potentials |= typesof(/mob/living/simple_animal/hostile/eyebot)
				if(prob(25)) // sike, lets mutate them into something else
					potentials |= typesof(/mob/living/simple_animal/hostile/handy)
					potentials |= typesof(/mob/living/simple_animal/hostile/securitron)
					potentials -= mobpath
			else if(ispath(mobpath, /mob/living/simple_animal/hostile/handy/protectron)) // protectrons
				potentials |= typesof(/mob/living/simple_animal/hostile/handy/protectron)
				if(prob(50))
					potentials |= typesof(/mob/living/simple_animal/hostile/hivebot)
					potentials |= typesof(/mob/living/simple_animal/hostile/handy) // cut loose, and fancy free
				potentials -= mobpath
			else if(ispath(mobpath, /mob/living/simple_animal/hostile/handy/assaultron)\
				|| ispath(mobpath, /mob/living/simple_animal/hostile/handy/robobrain)\
				|| ispath(mobpath, /mob/living/simple_animal/hostile/handy/gutsy)) // the big baddies
				potentials |= typesof(/mob/living/simple_animal/hostile/handy) // cut loose, and fancy free
				if(prob(50))
					potentials |= typesof(/mob/living/simple_animal/hostile/securitron) // branch off to a whole other tree!
				potentials -= /mob/living/simple_animal/hostile/handy 
				potentials -= mobpath
			else // some other wierd hendybot
				potentials |= typesof(/mob/living/simple_animal/hostile/handy) // cut loose, and fancy free
				potentials |= typesof(/mob/living/simple_animal/hostile/securitron) // branch off to a whole other tree!
				potentials -= mobpath
		else if(ispath(mobpath, /mob/living/simple_animal/hostile/securitron)) // they're all just outright better than handies
			potentials |= typesof(/mob/living/simple_animal/hostile/handy) // cut loose, and fancy free
			potentials |= typesof(/mob/living/simple_animal/hostile/securitron) // branch off to a whole other tree!
			potentials -= mobpath
		else if(ispath(mobpath, /mob/living/simple_animal/hostile/hivebot))
			potentials |= typesof(/mob/living/simple_animal/hostile/hivebot)
			potentials -= mobpath
			if(prob(50))
				potentials |= typesof(/mob/living/simple_animal/hostile/eyebot)
		/// return of the raiders
		else if(ispath(mobpath, /mob/living/simple_animal/hostile/raider))
			potentials |= typesof(/mob/living/simple_animal/hostile/raider)
			potentials -= typesof(/mob/living/simple_animal/hostile/raider/ranged/boss/mangomatt) // remove unique bosses
			potentials -= typesof(/mob/living/simple_animal/hostile/raider/ranged/boss/blueberrybates) // remove unique bosses
			if(prob(50))
				potentials |= typesof(/mob/living/simple_animal/hostile/renegade)
				if(prob(80))
					potentials -= typesof(/mob/living/simple_animal/hostile/renegade/meister)
					potentials -= typesof(/mob/living/simple_animal/hostile/renegade/traitor)
			if(prob(10))
				potentials |= typesof(/mob/living/simple_animal/hostile/skeleton) // SP00KY SCARY SKELETONS
			if(prob(25))
				potentials |= typesof(/mob/living/simple_animal/hostile/gorilla)
			potentials -= mobpath
		/// release the renegades
		else if(ispath(mobpath, /mob/living/simple_animal/hostile/renegade))
			potentials |= typesof(/mob/living/simple_animal/hostile/renegade)
			if(prob(80))
				potentials -= typesof(/mob/living/simple_animal/hostile/renegade/meister)
				potentials -= typesof(/mob/living/simple_animal/hostile/renegade/traitor)
				potentials -= typesof(/mob/living/simple_animal/hostile/renegade/syndicate/mecha_pilot)
			if(prob(25))
				potentials |= typesof(/mob/living/simple_animal/hostile/raider)
			if(prob(10))
				potentials |= typesof(/mob/living/simple_animal/hostile/skeleton) // SP00KY SCARY SKELETONS
			if(prob(25))
				potentials |= typesof(/mob/living/simple_animal/hostile/aethergiest)
			potentials -= mobpath
		/// shuffle the ghouls
		else if(ispath(mobpath, /mob/living/simple_animal/hostile/ghoul))
			potentials |= typesof(/mob/living/simple_animal/hostile/skeleton)
			potentials |= typesof(/mob/living/simple_animal/hostile/ghoul)
			if(prob(80))
				potentials -= typesof(/mob/living/simple_animal/hostile/ghoul/legendary)
			if(prob(95))
				potentials -= typesof(/mob/living/simple_animal/hostile/ghoul/wyomingghost)
		/// the bugs are back in town
		else if(ispath(mobpath, /mob/living/simple_animal/hostile/giantant)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/pillbug)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/fireant)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/radscorpion)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/poison/giant_spider)\
			|| prob(15))
			if(ispath(mobpath, /mob/living/simple_animal/hostile/pillbug) && prob(80))
				potentials |= typesof(/mob/living/simple_animal/hostile/pillbug)
				potentials -= /mob/living/simple_animal/hostile/pillbug
			else
				potentials |= typesof(/mob/living/simple_animal/hostile/fireant)
				potentials |= typesof(/mob/living/simple_animal/hostile/radscorpion)
				potentials |= typesof(/mob/living/simple_animal/hostile/poison/giant_spider)
				potentials |= typesof(/mob/living/simple_animal/hostile/giantant)
				potentials |= typesof(/mob/living/simple_animal/hostile/pillbug)
			potentials -= mobpath
		/// larger animals 
		else if(ispath(mobpath, /mob/living/simple_animal/hostile/gorilla)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/bear)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/wolf)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/alligator)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/mirelurk)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/aethergiest)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/hellpig)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/texas_rattler)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/stalker)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/jungle/mega_arachnid)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/dinosaur)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/kangaroo)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/bloodbird)\
			|| prob(15))
			potentials |= typesof(/mob/living/simple_animal/hostile/gorilla)
			potentials |= typesof(/mob/living/simple_animal/hostile/bear)
			potentials |= typesof(/mob/living/simple_animal/hostile/wolf)
			potentials |= typesof(/mob/living/simple_animal/hostile/alligator)
			potentials |= typesof(/mob/living/simple_animal/hostile/mirelurk)
			if((ispath(mobpath, /mob/living/simple_animal/hostile/aethergiest) && prob(50)) || prob(50))
				potentials |= typesof(/mob/living/simple_animal/hostile/aethergiest)
				if(prob(80))
					potentials -= typesof(/mob/living/simple_animal/hostile/aethergiest/power_armor)
					potentials -= typesof(/mob/living/simple_animal/hostile/aethergiest/legendary)
			if((ispath(mobpath, /mob/living/simple_animal/hostile/hellpig) && prob(50)) || prob(50))
				potentials |= typesof(/mob/living/simple_animal/hostile/hellpig)
			if(ispath(mobpath, /mob/living/simple_animal/hostile/texas_rattler) || prob(50))
				potentials |= typesof(/mob/living/simple_animal/hostile/texas_rattler)
			potentials |= typesof(/mob/living/simple_animal/hostile/stalker)
			potentials |= typesof(/mob/living/simple_animal/hostile/jungle/mega_arachnid)
			potentials |= typesof(/mob/living/simple_animal/hostile/dinosaur)
			potentials |= typesof(/mob/living/simple_animal/hostile/kangaroo)
			potentials |= typesof(/mob/living/simple_animal/hostile/bloodbird)
			if(prob(1))
				potentials |= typesof(/mob/living/simple_animal/hostile/gelcube)
			potentials -= mobpath
		/// skeleton clause
		else if(ispath(mobpath, /mob/living/simple_animal/hostile/skeleton))
			potentials |= typesof(/mob/living/simple_animal/hostile/ghoul)
			if(prob(50))
				potentials |= typesof(/mob/living/simple_animal/hostile/raider)
				if(prob(50))
					potentials |= typesof(/mob/living/simple_animal/hostile/renegade)
					if(prob(50))
						potentials -= typesof(/mob/living/simple_animal/hostile/renegade/meister)
						potentials -= typesof(/mob/living/simple_animal/hostile/renegade/traitor)
						potentials -= typesof(/mob/living/simple_animal/hostile/renegade/syndicate/mecha_pilot)
			potentials -= mobpath
			potentials -= typesof(/mob/living/simple_animal/hostile/ghoul/legendary)
			potentials -= typesof(/mob/living/simple_animal/hostile/ghoul/wyomingghost)
			potentials -= typesof(/mob/living/simple_animal/hostile/raider/ranged/boss)
		/// the rest of the animals
		else if(ispath(mobpath, /mob/living/simple_animal/hostile/gecko)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/rat)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/molerat)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/pillbug)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/cazador)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/lizard)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/lightgeist)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/stalkeryoung)\
			|| ispath(mobpath, /mob/living/simple_animal/hostile/carp)\
			|| prob(10))
			if(istype(mobpath, /mob/living/simple_animal/hostile/molerat) && prob(80))
				potentials |= typesof(/mob/living/simple_animal/hostile/molerat)
				potentials -= /mob/living/simple_animal/hostile/molerat
			else			
				potentials |= typesof(/mob/living/simple_animal/hostile/gecko)
				potentials -= typesof(/mob/living/simple_animal/hostile/gecko/debug)
				if(prob(30))
					potentials -= typesof(/mob/living/simple_animal/hostile/gecko/tribal/shaman)
				if(prob(90))
					potentials -= typesof(/mob/living/simple_animal/hostile/gecko/tribal/head_shaman)
				if(prob(30))
					potentials -= typesof(/mob/living/simple_animal/hostile/gecko/tribal/chieftain)
				potentials |= typesof(/mob/living/simple_animal/hostile/rat)
				potentials |= typesof(/mob/living/simple_animal/hostile/molerat)
				potentials |= typesof(/mob/living/simple_animal/hostile/pillbug)
				potentials |= typesof(/mob/living/simple_animal/hostile/carp)
				potentials -= typesof(/mob/living/simple_animal/hostile/carp/ranged) // no more literal deathray fish
				potentials |= typesof(/mob/living/simple_animal/hostile/cazador)
				potentials |= typesof(/mob/living/simple_animal/hostile/stalkeryoung)
				potentials |= typesof(/mob/living/simple_animal/hostile/lizard)
				potentials |= typesof(/mob/living/simple_animal/hostile/lightgeist)
			potentials -= mobpath
		/// misc wierdoes
		else if(istype(mobpath, /mob/living/simple_animal/hostile/trog)\
			|| istype(mobpath, /mob/living/simple_animal/hostile/centaur)\
			|| istype(mobpath, /mob/living/simple_animal/hostile/supermutant)\
			|| istype(mobpath, /mob/living/simple_animal/hostile/alien)\
			|| istype(mobpath, /mob/living/simple_animal/hostile/faithless)\
			|| istype(mobpath, /mob/living/simple_animal/hostile/gelcube)\
			|| istype(mobpath, /mob/living/simple_animal/hostile/jungle/leaper)\
			|| istype(mobpath, /mob/living/simple_animal/hostile/jungle/mega_arachnid)\
			|| istype(mobpath, /mob/living/simple_animal/hostile/jungle/seedling)\
			|| istype(mobpath, /mob/living/simple_animal/hostile/jungle/mook)\
			|| istype(mobpath, /mob/living/simple_animal/hostile/mimic)\
			|| istype(mobpath, /mob/living/simple_animal/hostile/shark)\
			|| istype(mobpath, /mob/living/simple_animal/hostile/killertomato)\
			|| prob(15))
			potentials |= typesof(/mob/living/simple_animal/hostile/trog)
			potentials |= typesof(/mob/living/simple_animal/hostile/centaur)
			potentials |= typesof(/mob/living/simple_animal/hostile/supermutant)
			if(prob(90))
				potentials |= typesof(/mob/living/simple_animal/hostile/supermutant/legendary)
			if(prob(75))
				potentials |= typesof(/mob/living/simple_animal/hostile/supermutant/nightkin)
			potentials |= typesof(/mob/living/simple_animal/hostile/alien)
			if(prob(90))
				potentials |= typesof(/mob/living/simple_animal/hostile/alien/queen)
			potentials |= typesof(/mob/living/simple_animal/hostile/faithless)
			potentials |= typesof(/mob/living/simple_animal/hostile/gelcube)
			potentials |= typesof(/mob/living/simple_animal/hostile/jungle/leaper)
			potentials |= typesof(/mob/living/simple_animal/hostile/jungle/mega_arachnid)
			potentials |= typesof(/mob/living/simple_animal/hostile/jungle/seedling)
			potentials |= typesof(/mob/living/simple_animal/hostile/jungle/mook)
			potentials |= typesof(/mob/living/simple_animal/hostile/mimic)
			potentials |= typesof(/mob/living/simple_animal/hostile/shark)
			potentials |= typesof(/mob/living/simple_animal/hostile/killertomato)
			potentials -= mobpath
		if(LAZYLEN(potentials))
			var/mob/living/simple_animal/my_choose = pick(potentials)
			new_paths[pick(potentials)] = (ispath(my_choose) && initial(my_choose.bossmob)) ? 1 : clamp(mob_types[mobpath] + rand(-1, -2), 1, 100)
			continue
		new_paths[mobpath] = clamp(mob_types[mobpath] + rand(-1, -2), 1, 100)
		continue
	nest_name = "Class \Roman[generation] ex-vivo delivery chamber"
	nest_desc = "A cool hole in the ground full of cool things. Stick your hand in and see! (Warning: Cool things are actually baddies)"
	if(prob(2))
		new_paths[/mob/living/simple_animal/hostile/amusing_duck] = 3 // quaCK
		nest_desc += " Disclaimer: Lay egg is true."
	if(prob(2))
		new_paths[/mob/living/simple_animal/hostile/goose] = 15 // cool
		nest_desc += " Also there's a lot of angry honking in there. Weird."
		swarm_size += 1
	mob_types = new_paths.Copy()
	return TRUE

/// Is passed a mob via the signal, and will attempt to despawn the mob and store it in the spawner.
/datum/component/spawner/proc/unbirth_mob(datum/source, mob/living/simple_animal/despawn_me)
	if(QDELETED(parent))
		return
	if(!istype(despawn_me))
		return
	var/datum/special_mob_datum/sparkle = new()
	var/sparkle_tag = sparkle.record_special_vars(despawn_me)
	if(!sparkle_tag)
		qdel(sparkle) // no real point in keeping it if it's empty
		return
	var/be_special = istype(parent, /obj/structure/nest/special)
	special_mobs |= sparkle
	if(be_special)
		var/atom/sponer = parent
		sponer.name = despawn_me.name
		sponer.desc = despawn_me.desc
		sponer.icon = despawn_me.icon
		sponer.icon_state = despawn_me.icon_state
		sponer.color = despawn_me.color
		start_spawning()
		// nobody'll know the difference~
	qdel(despawn_me)
	return TRUE

/// If anything asks if we have a spawner, we say yes.
/datum/component/spawner/proc/has_spawner()
	return TRUE

/// a datum that holds on to a bunch of vars for special mobs
/datum/special_mob_datum // SPECIAL MOB DATUM!
	var/name
	var/desc
	var/icon
	var/icon_state
	var/mob_type
	var/maxHealth
	var/color
	var/faction
	var/AIStatus
	var/casingtype
	var/projectiletype
	var/projectilesound
	var/sound_after_shooting
	var/sound_after_shooting_delay
	var/projectile_sound_properties
	var/melee_damage_lower
	var/melee_damage_upper
	var/list/mob_armor
	var/mobtag

/// A proc that takes a mob datum and records all the vars that are different from the initial vars, for later use.
/datum/special_mob_datum/proc/record_special_vars(mob/living/simple_animal/hostile/cool_mob)
	if(!istype(cool_mob))
		return FALSE
	mob_type = cool_mob.type
	name = cool_mob.name
	desc = cool_mob.desc
	icon = cool_mob.icon
	icon_state = cool_mob.icon_state
	maxHealth = cool_mob.maxHealth
	color = cool_mob.color
	faction = cool_mob.faction
	AIStatus = cool_mob.AIStatus
	projectiletype = cool_mob.projectiletype
	projectilesound = cool_mob.projectilesound
	sound_after_shooting = cool_mob.sound_after_shooting
	sound_after_shooting_delay = cool_mob.sound_after_shooting_delay
	projectile_sound_properties = cool_mob.projectile_sound_properties
	melee_damage_lower = cool_mob.melee_damage_lower
	melee_damage_upper = cool_mob.melee_damage_upper
	if(ispath(cool_mob.casingtype))
		casingtype = cool_mob.casingtype
	/// mob_armor is even specialer
	if(istype(cool_mob.mob_armor, /datum/armor))
		var/datum/armor/rmr = cool_mob.mob_armor
		mob_armor = rmr.getList() // its a datum! aaaand I dont want to save that one
	return src

/// A proc that spawns a mob from a special mob datum
/datum/special_mob_datum/proc/make_special_mob(datum/component/spawner/myspawner)
	if(!istype(myspawner))
		return
	if(!istype(myspawner.parent))
		return
	var/turf/putemhere = get_turf(myspawner.parent)
	var/mob/living/simple_animal/hostile/cool_mob = new mob_type(putemhere)
	if(cool_mob)
		cool_mob.name = name
		cool_mob.desc = desc
		cool_mob.icon = icon
		cool_mob.icon_state = icon_state
		cool_mob.maxHealth = maxHealth
		cool_mob.health = cool_mob.maxHealth
		cool_mob.color = color
		cool_mob.faction = faction
		cool_mob.toggle_ai(AI_ON) // Mob AI needs all the help it can get
		cool_mob.casingtype = casingtype
		cool_mob.projectiletype = projectiletype
		cool_mob.projectilesound = projectilesound
		cool_mob.sound_after_shooting = sound_after_shooting
		cool_mob.sound_after_shooting_delay = sound_after_shooting_delay
		cool_mob.projectile_sound_properties = projectile_sound_properties
		cool_mob.melee_damage_lower = melee_damage_lower
		cool_mob.melee_damage_upper = melee_damage_upper
		cool_mob.mob_armor = getArmor(arglist(mob_armor))
	myspawner.special_mobs -= src
	cool_mob.do_alert_animation(cool_mob)
	return cool_mob







