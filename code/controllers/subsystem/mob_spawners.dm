SUBSYSTEM_DEF(mobspawners)
	name = "Mob Spawners"
	wait = 10 SECONDS

/datum/controller/subsystem/mobspawners/fire(resumed = 0)
	for(var/obj/structure/nest/N in GLOB.mob_nests)
		N.spawn_mob()