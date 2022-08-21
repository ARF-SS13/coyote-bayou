//base nest and the procs
/obj/structure/nest
	name = "monster nest"
	desc = "A horrible nest full of monsters."
	icon = 'icons/mob/nest_new.dmi'
	icon_state = "hole"
	var/list/spawned_mobs = list()
	var/can_fire = TRUE
	var/mob_types = list(/mob/living/simple_animal/hostile/carp)
	//make spawn_time's multiples of 10. The SS runs on 10 seconds.
	var/spawn_time = 20 SECONDS
	var/coverable = TRUE
	/// spawner can be covered by dense things
	var/coverable_by_dense_things = TRUE
	var/covered = FALSE
	var/obj/covertype
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/spawn_text = "emerges from"
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	/// Is something covering us?
	var/datum/weakref/covering_object
	/// Range to check for other mobs to see if there's too many around
	var/overpopulation_range = 5
	/// max mobs that can be alive and nearby before it refuses to spawn more
	var/max_mobs = 3
	var/radius = 10
	var/spawnsound //specify an audio file to play when a mob emerges from the spawner
	var/spawn_once
	/// Needs a living, cliented player around to spawn stuff
	var/needs_player = TRUE
	var/infinite = FALSE
	var/mobs_to_spawn = 1 //number of mobs to spawn at once, for swarms
	/// The ID of our randomizer, so all spawners with this ID will spawn from the same list. Leave null to skip global randomization for this thing
	var/randomizer_tag
	/// Which spawner list to pick from
	var/randomizer_kind
	/// Which difficulties to pick from - its a bitfield!
	var/randomizer_difficulty
	COOLDOWN_DECLARE(spawner_cooldown)

/obj/structure/nest/Initialize()
	initialize_random_mob_spawners()
	if(randomizer_tag)
		setup_random_nest()
	. = ..()
	GLOB.mob_nests |= src

/obj/structure/nest/Destroy()
	GLOB.mob_nests -= src
	playsound(src, 'sound/effects/break_stone.ogg', 100, 1)
	visible_message("[src] collapses!")
	covering_object = null
	for(var/mob/living/simple_animal/our_spawned_mob in spawned_mobs)
		our_spawned_mob?.nest = null
		spawned_mobs -= our_spawned_mob
	. = ..()

/obj/structure/nest/process()
	if(!has_mobs_left())
		qdel(src)
		return FALSE
	if(!can_spawn_mob())
		return FALSE
	spawn_mob()
	
/// Do we have any mobs left?
/obj/structure/nest/proc/has_mobs_left()
	var/has_mobs_left
	for(var/mob_in_list in mob_types)
		if(mob_types[mob_in_list] >= 1)
			has_mobs_left = TRUE
			break
	if(!has_mobs_left)
		return FALSE
	return TRUE

/// Basic checks to see if we can spawn something
/obj/structure/nest/proc/can_spawn_mob()
	if(!can_fire)
		return FALSE
	if(COOLDOWN_TIMELEFT(src, spawner_cooldown))
		return FALSE
	if(covered)
		return FALSE
	if(coverable_by_dense_things)
		var/turf/our_turf = get_turf(src)
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
	if(max_mobs >= 1)
		var/mobs_in_range
		for(var/mob/living/living_mob in view(overpopulation_range, get_turf(src)))
			if(living_mob.stat != DEAD)
				if(mobs_in_range++ >= max_mobs)
					return FALSE
	if(needs_player)
		var/player_found = FALSE
		for(var/mob/living/carbon/human/humie in range(radius, get_turf(src)))
			if(humie?.client) // good enough
				player_found = TRUE
				break
		if(!player_found)
			return FALSE
	return TRUE

/obj/structure/nest/proc/spawn_mob()
	var/chosen_mob
	var/mob/living/simple_animal/output_mob
	for(var/i = 1 to mobs_to_spawn)
		if(infinite)
			chosen_mob = pickweight(mob_types)
		else
			chosen_mob = pickweight_n_reduce(mob_types)
		if(chosen_mob)
			output_mob = new chosen_mob(get_turf(src))
			output_mob.flags_1 |= (flags_1 & ADMIN_SPAWNED_1) //If we were admin spawned, lets have our children count as that as well.
			spawned_mobs += output_mob
			output_mob.nest = src
			visible_message(span_danger("[output_mob] [spawn_text] [src]."))
		else
			qdel(src)
			return
	if(spawnsound)
		playsound(src, spawnsound, 30, 1)
	COOLDOWN_START(src, spawner_cooldown, spawn_time)

/obj/structure/nest/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_CROWBAR)
		return try_unseal(FALSE, user, I)

	if(istype(I, /obj/item/stack/rods))
		return try_seal(user, I, I.type, "rods", 2 HOURS)
	if(istype(I, /obj/item/stack/sheet/mineral/wood))
		return try_seal(user, I, I.type, "planks", 30 MINUTES)

	if(covered) // allow you to interact only when it's sealed
		..()
	else
		if(user.a_intent == INTENT_HARM)
			to_chat(user, span_warning("You feel it is impossible to destroy this without covering it with something."))
			return

/obj/structure/nest/proc/try_seal(mob/user, obj/item/stack/S, itempath, cover_state, timer)
	if(!coverable)
		to_chat(user, span_warning("The hole is unable to be covered!"))
		return
	if(covered)
		to_chat(user, span_warning("The hole is already covered!"))
		return
	if(!istype(S))
		to_chat(user, span_warning("You cant cover this with that!"))
		return
	if(S.amount < 4)
		to_chat(user, span_warning("You need four of [S.name] in order to cover the hole!"))
		return
	if(!do_after(user, 5 SECONDS, FALSE, src))
		to_chat(user, span_warning("You must stand still to build the cover!"))
		return
	S.use(4)
	if(!covered)
		new /obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/low(src.loc)
		if(istype(user))
			to_chat(user, span_warning("You find something while covering the hole!"))
	do_seal(itempath, cover_state, timer)

/obj/structure/nest/proc/do_seal(itempath, cover_state, timer)
	can_fire = FALSE
	covered = TRUE
	covertype = itempath
	var/image/overlay_image = image(icon, icon_state = cover_state)
	add_overlay(overlay_image)
	addtimer(CALLBACK(src, .proc/do_unseal), timer)

/obj/structure/nest/proc/try_unseal(mob/user = null, obj/item/I = null)
	if(!istype(user))
		return
	if(!istype(I))
		return
	I.play_tool_sound(src, 50)
	if(!do_after(user, 5 SECONDS, FALSE, src))
		to_chat(user, span_warning("You must stand still to unseal the cover!"))
		return
	do_unseal()

/obj/structure/nest/proc/do_unseal()
	covered = initial(covered)
	covertype = initial(covertype)
	cut_overlays()
	can_fire = TRUE

/obj/structure/nest/proc/setup_random_nest()
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
/obj/structure/nest/proc/add_nest_to_global_list()
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
/obj/structure/nest/proc/apply_nest_from_global_list()
	mob_types = list()
	var/list/our_randomizer_index = GLOB.mob_spawner_random_index[randomizer_tag]
	var/datum/random_mob_spawner/our_spawner = GLOB.random_mob_nest_spawner_datums[our_randomizer_index[MOB_SPAWNER_GLOBAL_LIST_KIND]]
	if(!istype(our_spawner))
		message_admins(span_phobia("Hey! [src] was passed randomizer index [our_randomizer_index], which gave a null spawner datum! Tell Superlagg to fix his shit!"))
		return
	name = our_spawner.nest_name
	desc = our_spawner.nest_desc
	icon_state = our_spawner.nest_icon_state
	spawnsound = our_spawner.sound_to_play
	if(our_randomizer_index[MOB_SPAWNER_GLOBAL_LIST_DIFFICULTY] & MOB_SPAWNER_DIFFICULTY_EASY)
		mob_types |= our_spawner.mob_list_easy
		max_mobs = our_spawner.num_mobs_to_spawn_easy
		spawn_time = our_spawner.num_mobs_to_spawn_easy
	if(our_randomizer_index[MOB_SPAWNER_GLOBAL_LIST_DIFFICULTY] & MOB_SPAWNER_DIFFICULTY_MED)
		mob_types |= our_spawner.mob_list_medium
		max_mobs = our_spawner.num_mobs_to_spawn_medium
		spawn_time = our_spawner.num_mobs_to_spawn_medium
	if(our_randomizer_index[MOB_SPAWNER_GLOBAL_LIST_DIFFICULTY] & MOB_SPAWNER_DIFFICULTY_HARD)
		mob_types |= our_spawner.mob_list_hard
		max_mobs = our_spawner.num_mobs_to_spawn_hard
		spawn_time = our_spawner.num_mobs_to_spawn_hard

/obj/structure/nest/proc/initialize_random_mob_spawners()
	if(!LAZYLEN(GLOB.random_mob_nest_spawner_datums))
		for(var/r_spawn in subtypesof(/datum/random_mob_spawner))
			var/datum/random_mob_spawner/r_spawn_datum = new r_spawn()
			GLOB.random_mob_nest_spawner_datums[r_spawn_datum.nest_tag] = r_spawn_datum
	if(!LAZYLEN(GLOB.random_mob_nest_spawner_groups))
		for(var/r_group in subtypesof(/datum/random_mob_spawner_group))
			var/datum/random_mob_spawner_group/r_group_datum = new r_group()
			GLOB.random_mob_nest_spawner_groups[r_group_datum.group_tag] = r_group_datum

//the nests themselves
/*
	var/list/cazadors 	= list(/mob/living/simple_animal/hostile/cazador = 5,
					/mob/living/simple_animal/hostile/cazador/young = 3,)

	var/list/ghouls 	= list(/mob/living/simple_animal/hostile/ghoul = 5,
					/mob/living/simple_animal/hostile/ghoul/reaver = 3,
					/mob/living/simple_animal/hostile/ghoul/glowing = 1)

	var/list/deathclaw 	= list(/mob/living/simple_animal/hostile/deathclaw = 19,
					/mob/living/simple_animal/hostile/deathclaw/mother = 1)

	var/list/scorpion	= list(/mob/living/simple_animal/hostile/radscorpion = 1,
					/mob/living/simple_animal/hostile/radscorpion/black = 1)

	var/list/radroach	= list(/mob/living/simple_animal/hostile/radroach = 1)

	var/list/fireant	= list(/mob/living/simple_animal/hostile/fireant = 1,
					/mob/living/simple_animal/hostile/giantant = 1)

	var/list/wanamingo 	= list(/mob/living/simple_animal/hostile/alien = 1)

	var/list/molerat	= list(/mob/living/simple_animal/hostile/molerat = 1)

	var/list/mirelurk	= list(/mob/living/simple_animal/hostile/mirelurk = 2,
					/mob/living/simple_animal/hostile/mirelurk/hunter = 1,
					/mob/living/simple_animal/hostile/mirelurk/baby = 5)

	var/list/raider		= list(/mob/living/simple_animal/hostile/raider = 5,
					/mob/living/simple_animal/hostile/raider/firefighter = 2,
					/mob/living/simple_animal/hostile/raider/baseball = 2,
					/mob/living/simple_animal/hostile/raider/ranged = 2,
					/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 1,
					/mob/living/simple_animal/hostile/raider/ranged/biker = 1,
					/mob/living/simple_animal/hostile/raider/ranged/boss = 1,
					/mob/living/simple_animal/hostile/raider/legendary = 1)

	var/list/protectron	= list(/mob/living/simple_animal/hostile/handy/protectron = 5,
					/mob/living/simple_animal/hostile/handy = 3)

	var/list/cazador	= list(/mob/living/simple_animal/hostile/cazador = 5,
					/mob/living/simple_animal/hostile/cazador/young = 3,)

*/
/obj/structure/nest/ghoul
	name = "ghoul nest"
	max_mobs = 3
	mob_types = list(/mob/living/simple_animal/hostile/ghoul = 5,
					/mob/living/simple_animal/hostile/ghoul/reaver = 3,
					/mob/living/simple_animal/hostile/ghoul/glowing = 1)

/obj/structure/nest/deathclaw
	name = "deathclaw nest"
	max_mobs = 1
	spawn_once = TRUE
	spawn_time = 60 SECONDS
	mob_types = list(/mob/living/simple_animal/hostile/deathclaw = 1)

/obj/structure/nest/deathclaw/mother
	name = "mother deathclaw nest"
	max_mobs = 1
	spawn_time = 120 SECONDS
	mob_types = list(/mob/living/simple_animal/hostile/deathclaw/mother = 1)

/obj/structure/nest/scorpion
	name = "scorpion nest"
	spawn_time = 40 SECONDS
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/radscorpion = 5,
					/mob/living/simple_animal/hostile/radscorpion/black = 5)

/obj/structure/nest/radroach
	name = "radroach nest"
	max_mobs = 15
	mobs_to_spawn = 3
	mob_types = list(/mob/living/simple_animal/hostile/radroach = 15)

/obj/structure/nest/fireant
	name = "fireant nest"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/fireant = 3,
					/mob/living/simple_animal/hostile/giantant = 6)

/obj/structure/nest/wanamingo
	name = "wanamingo nest"
	spawn_time = 40 SECONDS
	max_mobs = 1
	mob_types = list(/mob/living/simple_animal/hostile/alien = 3)

/obj/structure/nest/molerat
	name = "molerat nest"
	max_mobs = 5
	mob_types = list(/mob/living/simple_animal/hostile/molerat = 20)
	spawn_time = 10 SECONDS //They just love tunnelin'.. And are pretty soft

/obj/structure/nest/mirelurk
	name = "mirelurk nest"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/mirelurk = 2,
					/mob/living/simple_animal/hostile/mirelurk/hunter = 1,
					/mob/living/simple_animal/hostile/mirelurk/baby = 8)

/obj/structure/nest/raider
	name = "narrow tunnel"
	desc = "A crude tunnel used by raiders to travel across the wasteland."
	max_mobs = 2
	icon_state = "ventblue"
	spawnsound = 'sound/effects/bin_close.ogg'
	mob_types = list(/mob/living/simple_animal/hostile/raider = 5,
					/mob/living/simple_animal/hostile/raider/firefighter = 2,
					/mob/living/simple_animal/hostile/raider/baseball = 5,
					/mob/living/simple_animal/hostile/raider/ranged = 2,
					/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 1,
					/mob/living/simple_animal/hostile/raider/ranged/biker = 1,
					/mob/living/simple_animal/hostile/raider/tribal = 1)

/obj/structure/nest/raider/melee
	mob_types = list(/mob/living/simple_animal/hostile/raider = 5,
					/mob/living/simple_animal/hostile/raider/firefighter = 2,
					/mob/living/simple_animal/hostile/raider/baseball = 5,
					/mob/living/simple_animal/hostile/raider/tribal = 1)

/obj/structure/nest/raider/ranged
	max_mobs = 3
	mob_types = list(/mob/living/simple_animal/hostile/raider/ranged = 4,
					/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 2,
					/mob/living/simple_animal/hostile/raider/ranged/biker = 2)

/obj/structure/nest/raider/boss
	max_mobs = 1
	mob_types = list(/mob/living/simple_animal/hostile/raider/ranged/boss = 1)

/obj/structure/nest/raider/legendary
	max_mobs = 1
	mob_types = list(/mob/living/simple_animal/hostile/raider/legendary = 1)

/obj/structure/nest/protectron
	name = "protectron pod"
	desc = "An old robot storage system. This one looks like it is connected to space underground."
	max_mobs = 2
	icon_state = "scanner_modified"
	mob_types = list(/mob/living/simple_animal/hostile/handy/protectron = 5)

/obj/structure/nest/securitron
	name = "securitron pod"
	desc = "An old securitron containment pod system. This one looks like it is connected to a storage system underground."
	max_mobs = 3
	icon_state = "scanner_modified"
	mob_types = list(/mob/living/simple_animal/hostile/securitron = 5)

/obj/structure/nest/assaultron
	name = "assaultron pod"
	desc = "An old assaultron containment pod system. This one looks like it is connected to a storage system underground."
	spawn_time = 40 SECONDS
	max_mobs = 2
	icon_state = "scanner_modified"
	mob_types = list(/mob/living/simple_animal/hostile/handy/assaultron = 5)

/obj/structure/nest/cazador
	name = "cazador nest"
	max_mobs = 4
	mob_types = list(/mob/living/simple_animal/hostile/cazador = 5,
					/mob/living/simple_animal/hostile/cazador/young = 3,)

/obj/structure/nest/gecko
	name = "gecko nest"
	max_mobs = 5
	mob_types = list(/mob/living/simple_animal/hostile/gecko = 10)

/obj/structure/nest/wolf
	name = "wolf den"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/wolf = 5)

/obj/structure/nest/supermutant
	name = "supermutant den"
	spawn_time = 30 SECONDS
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/supermutant/meleemutant = 5,
					/mob/living/simple_animal/hostile/supermutant/rangedmutant = 2)

/obj/structure/nest/supermutant/melee
	mob_types = list(/mob/living/simple_animal/hostile/supermutant/meleemutant = 5)

/obj/structure/nest/supermutant/ranged
	mob_types = list(/mob/living/simple_animal/hostile/supermutant/rangedmutant = 5)

/obj/structure/nest/supermutant/nightkin
	mob_types = list(/mob/living/simple_animal/hostile/supermutant/nightkin = 5,
					/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant = 2,
					/mob/living/simple_animal/hostile/supermutant/nightkin/elitemutant = 1)

/obj/structure/nest/nightstalker
	name = "nightstalker nest"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/stalker = 5,
					/mob/living/simple_animal/hostile/stalkeryoung = 5)

//Event Nests
/obj/structure/nest/zombieghoul
	name = "ravenous ghoul nest"
	max_mobs = 5
	mob_types = list(/mob/living/simple_animal/hostile/ghoul/zombie = 5,
					/mob/living/simple_animal/hostile/ghoul/zombie/reaver = 3,
					/mob/living/simple_animal/hostile/ghoul/zombie/glowing = 1)

/obj/structure/nest/tunneler
	name = "tunneler tunnel"
	desc = "A tunnel which leads to an underground network of even more tunnels, made by the dangerous tunnelers."
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/trog/tunneler = 10)
	spawn_time = 20 SECONDS

/obj/structure/nest/randomized
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"

/obj/structure/nest/randomized/test1
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"
	randomizer_tag = "Pisscock 1"
	randomizer_kind = MOB_SPAWNER_KIND_DEATH
	randomizer_difficulty = MOB_SPAWNER_DIFFICULTY_EASY | MOB_SPAWNER_DIFFICULTY_MED | MOB_SPAWNER_DIFFICULTY_HARD

/obj/structure/nest/randomized/test2
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"
	randomizer_tag = "Pisscock 2"
	randomizer_kind = MOB_SPAWNER_KIND_ALL
	randomizer_difficulty = MOB_SPAWNER_DIFFICULTY_EASY | MOB_SPAWNER_DIFFICULTY_HARD

/obj/structure/nest/randomized/test3
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"
	randomizer_tag = "Pisscock 3"
	randomizer_kind = MOB_SPAWNER_KIND_ROBOT_HIGH
	randomizer_difficulty = MOB_SPAWNER_DIFFICULTY_HARD

/obj/structure/nest/randomized/test4
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"
	randomizer_tag = "Pisscock 4"
	randomizer_kind = MOB_SPAWNER_KIND_RAIDER_LOW
	randomizer_difficulty = MOB_SPAWNER_DIFFICULTY_EASY

/obj/structure/nest/randomized/test5
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"
	randomizer_tag = "Pisscock 1"
	randomizer_kind = MOB_SPAWNER_KIND_RAIDER_LOW
	randomizer_difficulty = MOB_SPAWNER_DIFFICULTY_EASY



