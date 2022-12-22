SUBSYSTEM_DEF(validball_spawn_randomizer)
	name = "Validball Spawner"
	init_order = INIT_ORDER_VALIDBALL
	flags = SS_NO_FIRE
	runlevels = RUNLEVEL_INIT
	var/tries_left = 5
	
/datum/controller/subsystem/validball_spawn_randomizer/Initialize(timeofday)
	spawn_validballs()
	return ..()

/datum/controller/subsystem/validball_spawn_randomizer/proc/spawn_validballs()
	if(!LAZYLEN(GLOB.valid_ball_spawners))
		if(tries_left-- <= 0)
			message_admins("Validball failed to spawn after [initial(tries_left)] tries!")
			return
		message_admins("Validball couldn't spawn, trying again in 1 second. [tries_left] tries left!")
		addtimer(CALLBACK(src, .proc/spawn_validballs), 1 SECONDS) // try again later
	var/vb_index = rand(1, LAZYLEN(GLOB.valid_ball_spawners))
	if(!vb_index)
		message_admins("Couldn't find any validballs to spawn!!")
		return
	for(var/index in 1 to LAZYLEN(GLOB.valid_ball_spawners))
		var/obj/effect/validball_spawner/the_spawner = GLOB.valid_ball_spawners[index]
		if(!the_spawner)
			message_admins("There was an empty entry in the validball spawner list! how the fuc")
			continue
		if(!istype(the_spawner, /obj/effect/validball_spawner))
			message_admins("Oh no, [the_spawner] somehow got into the validball list! how the fuck")
			continue
		if(index == vb_index)
			GLOB.valid_ball_spawners[index] = the_spawner.spawn_the_thing()
			if(istype(GLOB.valid_ball_spawners[index], /obj/item/validball))
				message_admins("Validball spawned!")
			break

