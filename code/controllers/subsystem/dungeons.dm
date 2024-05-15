SUBSYSTEM_DEF(dungeons)
	name = "Dungeons"
	init_order = INIT_ORDER_DUNGEONS
	flags = SS_KEEP_TIMING
	wait = 30 SECONDS
	var/dungeon_stress_test = FALSE
	/// List of each unique dungeon instance's controller datum.
	var/list/dungeon_instances = list()
	/// Tally of how many dungeons have been made
	var/dungeon_tally = 0

/datum/controller/subsystem/dungeons/Initialize()
	return ..()

/datum/controller/subsystem/dungeons/fire(resumed)

/datum/controller/subsystem/dungeons/proc/CreateDungeonInstance(dungeon_type)
	if(isnull(dungeon_type))
		return
	var/datum/dungeon_controller/DC = new dungeon_type
	if(isnull(DC) || !istype(DC, /datum/dungeon_controller))
		return
	dungeon_tally++
	DC.dungeon_id = "[DC.dungeon_id] [dungeon_tally]"
	dungeon_instances[DC.dungeon_id] = DC
	return DC

//datum/controller/subsystem/dungeons/proc/connect_entrance(obj/structure/dungeon/entrance/E)
