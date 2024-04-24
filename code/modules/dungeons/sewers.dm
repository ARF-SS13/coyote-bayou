/// Dungeon controller.
/datum/dungeon_controller/sewer
	dungeon_id = "sewer"
	wipe_after = 10 MINUTES

/datum/map_template/dungeon/sewer
	name = "Sewer Dungeon Map"
	description = "A random assortment of mappies."
	/// Used by dynamic mob spawnpoints to assign health, damage, etc
	difficulty
	loot_abundance = LOOT_TIER_LOW
	threat_type = "Geckos, Slimes, Rats, & Goons"
	transitions = list()

/datum/map_template/dungeon/sewer/start
	name = "Sewer Dungeon Start"
	description = "A random assortment of gross tunnels."
	difficulty
	loot_abundance
	threat_type
	transitions = list(/datum/map_template/dungeon/sewer_1 = 25, /datum/map_template/dungeon/sewer_2 = 25, /datum/map_template/dungeon/sewer_3 = 25)



