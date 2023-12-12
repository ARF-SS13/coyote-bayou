GLOBAL_VAR_INIT(debug_spawner_turfs, FALSE)
/datum/component/spawner
	var/mob_types = list(/mob/living/simple_animal/hostile/carp)
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
	/// Dont start spawning just yet
	var/delay_start = FALSE
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
		_randomizer_difficulty,
		_delay_start
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
	if(_delay_start)
		delay_start = _delay_start
	initialize_random_mob_spawners()
	if(randomizer_tag)
		setup_random_nest()
	var/coords = atom2coords(parent)
	GLOB.nest_spawn_points -= coords // im here! honest

	RegisterSignal(parent, COMSIG_PARENT_QDELETING, .proc/nest_destroyed)
	RegisterSignal(parent, COMSIG_OBJ_ATTACK_GENERIC, .proc/on_attack_generic)
	RegisterSignal(parent, COMSIG_SPAWNER_COVERED, .proc/coverme)
	RegisterSignal(parent, COMSIG_SPAWNER_UNCOVERED, .proc/uncoverme)
	RegisterSignal(parent, COMSIG_SPAWNER_ABSORB_MOB, .proc/unbirth_mob)
	// RegisterSignal(parent, COMSIG_SPAWNER_EXISTS, .proc/has_spawner)
	if(istype(parent, /obj/structure/nest))
		var/obj/structure/nest/nest = parent
		if(nest.spawned_by_ckey)
			am_special = TRUE
	if(istype(parent, /obj/structure/nest/special))
		am_special = TRUE
		RegisterSignal(parent, COMSIG_SPAWNER_SPAWN_NOW, .proc/spawn_mob_special)
	// if(SSspawners.use_turf_registration)
	// 	register_turfs()
	// else
	old_spawner_check = TRUE
	if(!delay_start)
		start_spawning()

// /datum/component/spawner/proc/register_turfs()
// 	var/atom/dad = parent
// 	if(!dad.loc)
// 		return
// 	var/debug_color = SSspawners.debug_spawner_turfs ? "#[random_color()]" : null
// 	for(var/turf/trip in range(range, dad.loc))
// 		connect_to_turf(trip, debug_color)

// /datum/component/spawner/proc/connect_to_turf(turf/trip, debug_color)
// 	my_turfs |= atom2coords(trip)
// 	RegisterSignal(trip, COMSIG_ATOM_ENTERED, .proc/turf_trip)
// 	RegisterSignal(trip, COMSIG_TURF_CHANGE, .proc/turf_changed)
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
	if(!am_special)
		GLOB.nest_spawn_points |= atom2coords(parent) // we'll be back, eventually
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
		if(get_dist(P, butt) <= range)
			return TRUE

/// first checks if anyone is in range, then if so, turns itself on for another 20ish seconds
/datum/component/spawner/proc/old_spawn()
	if(!COOLDOWN_FINISHED(src, spawner_cooldown))
		return
	if(COOLDOWN_FINISHED(src, spawn_until))
		deactivate()
	if(should_destroy_spawner())
		qdel(parent)
		return
	if(!active)
		if(!something_in_range())
			return
		activate()
	if(active)
		try_to_spawn()

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
/datum/component/spawner/proc/spawn_mob()
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







