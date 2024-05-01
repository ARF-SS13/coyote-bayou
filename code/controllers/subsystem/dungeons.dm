SUBSYSTEM_DEF(dungeons)
	name = "Dungeons"
	init_order = INIT_ORDER_DUNGEONS
	flags = SS_KEEP_TIMING
	wait = 30 SECONDS
	var/dungeon_stress_test = FALSE
	/// List of each unique dungeon instance.
	var/list/dungeon_instances = list()
	/// Tally of how many dungeons have been made
	var/dungeon_tally = 0

/datum/controller/subsystem/dungeons/Initialize()
	return ..()

/// Creates the specified dungeon instance and adds it to the dungeon_instances list. Happens when a player interacts with the entrance to a dungeon and tries to enter it.
/datum/controller/subsystem/dungeons/proc/CreateDungeonInstance(datum/dungeon_controller/DC)
	if(isnull(DC) || !istype(DC, /datum/dungeon_controller))
		return
	dungeon_tally++
	DC.dungeon_id = "[DC.dungeon_id] [dungeon_tally]"
	dungeon_instances[DC.dungeon_id] = DC
	return DC

/datum/controller/subsystem/dungeons/proc/connect_entrance(obj/effect/landmark/dungeon_entrance/E)
