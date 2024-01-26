SUBSYSTEM_DEF(validball)
	name = "Validball"
	init_order = INIT_ORDER_VALIDBALL
	flags = SS_NO_FIRE
	runlevels = RUNLEVEL_INIT
	var/tries_left = 5
	var/num_validballs_override // set this and run spawn_validballs to override how many validballs to spawn
	var/list/valid_balls = list() // for tracking the individual object
	var/list/valid_ball_spawners = list() // for making sure the spawners spawn the right amount of them
	var/list/valid_ball_spawner_coords = list() // for making sure the spawners spawn the right amount of them
	var/list/vb_reports = list() // holds a list of strings: the name of the ball, who held it last, and who else held it
	
/datum/controller/subsystem/validball/Initialize(timeofday)
	spawn_validballs()
	return ..()

/datum/controller/subsystem/validball/proc/spawn_validballs()
	var/num_to_spawn = CONFIG_GET(number/validball_count)
	if(num_validballs_override)
		num_to_spawn = num_validballs_override
	if(num_to_spawn < 1)
		message_admins("Config is set to not spawn any validballs! Validball is not go!")
		return
	if(!LAZYLEN(valid_ball_spawners))
		if(tries_left-- <= 0)
			message_admins("Validball failed to spawn after [initial(tries_left)] tries! Validball is not go!")
			return
		message_admins("Validball couldn't spawn, trying again in 1 second. [tries_left] tries left!")
		addtimer(CALLBACK(src,PROC_REF(spawn_validballs)), 1 SECONDS) // try again later
		return
	if(num_to_spawn > LAZYLEN(valid_ball_spawners))
		message_admins("Uh oh, config wants more validballs than there are available spawners! Validball is still go, but every validball spawner will spawn a validball. Have fun!")
		num_to_spawn = LAZYLEN(valid_ball_spawners)
	var/list/selected_validball_spawners = list()
	var/list/pile_of_indexes = list()
	for(var/indexie in 1 to LAZYLEN(valid_ball_spawners))
		pile_of_indexes += indexie
	for(var/i in 1 to num_to_spawn)
		var/vb_index = pick_n_take(pile_of_indexes)
		var/obj/effect/validball_spawner/the_spawner = valid_ball_spawners[vb_index]
		if(istype(the_spawner, /obj/effect/validball_spawner))
			selected_validball_spawners += the_spawner
			continue
		message_admins("Whoops! Found a non-validball spawner in the validball spawner list! Validball might still be go, but it'll have one less validball, and potentially none at all! Have fun!")
	if(!LAZYLEN(selected_validball_spawners))
		message_admins("Couldn't find any validballs to spawn!! Validball is not go!")
		return
	for(var/obj/effect/validball_spawner/vb_spawner in selected_validball_spawners)
		var/obj/item/validball/our_new_vb = vb_spawner.spawn_the_thing()
		if(istype(our_new_vb))
			var/turf/vb_spawnpoint = get_turf(our_new_vb)
			message_admins("Validball spawned at [ADMIN_VERBOSEJMP(vb_spawnpoint)]! Validball is go!!! C:")
		selected_validball_spawners -= vb_spawner
	//and clean up all the spawners
	for(var/obj/effect/validball_spawner/valid_spawner in valid_ball_spawners)
		valid_ball_spawner_coords += "[atom2coords(valid_spawner)]]" // imma keep track of these
		valid_ball_spawners -= valid_spawner
		var/turf/where_it_was = get_turf(valid_spawner)
		qdel(valid_spawner)
		new /obj/effect/spawner/lootdrop/f13/uncommon(where_it_was) // will also spawn loot under validballs, all the more reason to nab em
	if(LAZYLEN(valid_ball_spawners))
		message_admins("Validball spawner list still has stuff in it! Validball is still go probably, but there might be huge gross X-es left over. Point at them and laugh till they go away.")
	else
		message_admins("Validball spawning complete! Validball is go!")



