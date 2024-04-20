SUBSYSTEM_DEF(dungeons)
	name = "Dungeons"
	init_order = INIT_ORDER_DUNGEONS
	flags = SS_KEEP_TIMING
	wait = 30 SECONDS
	var/dungeon_stress_test = FALSE
	/// List of each unique dungeon instance.
	var/list/dungeon_instances = list()

/datum/controller/subsystem/dungeons/Initialize()
	return ..()

/// Creates the specified dungeon instance and adds it to the dungeon_instances list.
/datum/controller/subsystem/dungeons/proc/CreateDungeonInstance(var/datum/dungeon_controller/DC)
	if(!DC)
		return FALSE
	dungeon = new dungeon()
	dungeon_instances[dungeon.dungeon_id] = dungeon
	return dungeon

/datum/controller/subsystem/dungeons/proc/connect_entrance(var/obj/effect/landmark/dungeon_entrance/E)

