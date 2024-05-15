/// Dungeon controller.
/datum/dungeon_controller/sewer
	dungeon_id = "sewer"
	wipe_after = 10 MINUTES
	start_maps = list(/datum/map_template/dungeon/sewer/start = 25)
	middle_maps = list(
		/datum/map_template/dungeon/sewer/one = 25,
		/datum/map_template/dungeon/sewer/two = 25,
		/datum/map_template/dungeon/sewer/three = 25,
		)
	exit_maps = list(/datum/map_template/dungeon/sewer/exit = 25)
	min_middle_maps = 1
	max_middle_maps = 3
	/// Can we roll into the same middle map more than once?
	can_dupe_middle_maps = FALSE
	/// When rolling a middle map, this is the chance to instead roll an exit map.
	exit_chance = 25

/// Entrance
/obj/structure/dungeon/entrance/sewers
	dungeon_type = /datum/dungeon_controller/sewer

/obj/structure/dungeon/exit/sewers
	icon = 'icons/obj/structures.dmi'
	icon_state = "ladder10"

/datum/map_template/dungeon/sewer
	name = "Sewer Dungeon Map"
	description = "A random assortment of gross tunnels."
	difficulty = "Easy"
	loot_abundance = "Low"
	threat_type = "Geckos, Slimes, Rats, & Bandits"

/datum/map_template/dungeon/sewer/start
	name = "Sewer Dungeon Start"
	mappath = "_maps/templates/dungeons/sewers/start.dmm"

/datum/map_template/dungeon/sewer/one
	name = "Sewer Dungeon 1"
	description = "A section of the sewer dungeon."
	mappath = "_maps/templates/dungeons/sewers/one.dmm"

/datum/map_template/dungeon/sewer/two
	name = "Sewer Dungeon 2"
	description = "Another section of the sewer dungeon."
	mappath = "_maps/templates/dungeons/sewers/two.dmm"

/datum/map_template/dungeon/sewer/three
	name = "Sewer Dungeon 3"
	description = "The final section of the sewer dungeon."
	mappath = "_maps/templates/dungeons/sewers/three.dmm"

/datum/map_template/dungeon/sewer/exit
	name = "Sewer Dungeon Exit"
	description = "The exit of the sewer dungeon."
	mappath = "_maps/templates/dungeons/sewers/exit.dmm"
