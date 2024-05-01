/// Dungeon controller.
/datum/dungeon_controller
	/// Unique ID that SSdungeons uses to keep track of this unique dungeon
	var/dungeon_id
	/// Turf reservations that this dungeon needs.
	var/list/reservations = list()
	/// A list of players inside the dungeon. If nobody's inside for a while, we wipe the reservation to save memory.
	var/list/players_inside = list()
	/// After everyone's left a dungeon, we should wait this long before wiping it.
	var/wipe_after = 10 MINUTES
	/// Weighted list of starting maps to choose from.
	var/list/start_maps = list()
	/// Weighted list of maps to choose from that aren't an entrance or exit. The meat of a dungeon.
	var/list/middle_maps = list()
	/// Weighted list of final maps to choose from. These always contain an exit for the dungeon.
	var/list/exit_maps = list()
	var/min_middle_maps = 0
	var/max_middle_maps = 0
	/// Can we roll into the same middle map more than once?
	var/can_dupe_middle_maps = FALSE
	/// When rolling a middle map, this is the chance to instead roll an exit map.
	var/exit_chance = 50
	/// An associative list of map templates that have been spawned for this controller with their respective turf reservations.
	var/list/my_maps = list()
	/// Controls dynamic loot and mob spawning behavior. Also determines what tier of rift stabilizer you need to open an instance of this dungeon.
	var/loot_abundance = LOOT_TIER_MID

/datum/dungeon_controller/New()
	//Sanitize the amount of maps we can make so that fenny can mess this up and it will still work.
	if(can_dupe_middle_maps == FALSE && min_middle_maps > LAZYLEN(middle_maps))
		min_middle_maps = LAZYLEN(middle_maps)
		max_middle_maps = max(min_middle_maps, max_middle_maps)
	exit_chance = clamp(exit_chance, 0, 100)

	// Generate the order of the dungeon's maps
	// We will associate the turf reservations for them later, when they're actually generated
	my_maps += pick(start_maps)
	var/mids = 0
	for(var/i=0, i<max_middle_maps, i++)
		if(rand(1,100) <= exit_chance) 							// Rolled an exit map chunk
			if(mids < min_middle_maps) 							// We haven't rolled enough middle maps yet
				for(mids, mids < min_middle_maps, mids++) 		// Roll more middle maps until we have enough
					my_maps += pick(middle_maps)
					mids++
			if(mids >= min_middle_maps)							// We have enough middle maps, so we can roll an exit map
				my_maps += pick(exit_maps)
				break
		else
			my_maps += pick(middle_maps)						// We rolled a middle map, so add it to the list
			mids++
	SSdungeons.CreateDungeonInstance(src)


/datum/dungeon_controller/proc/GenerateMap(map_index)
	var/datum/map_template/dungeon/map = my_maps[map_index]
	var/datum/turf_reservation/dungeon/reservation = SSmapping.RequestBlockReservation(map.width, map.height, type = /datum/turf_reservation/dungeon)
	if(!reservation)
		message_admins(span_adminnotice("DEBUG:Failed to reserve space to spawn a dungeon.")) 											//We couldn't reserve a spot.
		return
	var/turf/placement = locate(reservation.bottom_left_coords[1],reservation.bottom_left_coords[2],reservation.bottom_left_coords[3])
	map.load(placement)																														//Place the dungeon
	var/turf/center = locate(placement.x + round(map.width/2),placement.y + round(map.height/2),placement.z)									//Locate the center turf of the dungeon to spawn a dungeon controller / landmark thing
	new /obj/effect/landmark/dungeon_mark(center, src)
	message_admins(span_adminnotice("DEBUG:Dungeon chunk #[map_index] for \"[dungeon_id]\" placed at [ADMIN_COORDJMP(center)]"))
	my_maps[map_index] = reservation
	return reservation

/// An individual map chunk for a dungeon.
/datum/map_template/dungeon
	name = "Dungeon Template"
	var/description
	/// Used by dynamic mob spawnpoints to assign health, damage, etc
	var/difficulty
	/// Used by dynamic loot objects to assign a loot rarity to each container. See _lootable.dm
	var/loot_abundance
	/// What kinds of enemies spawn in this dungeon? examples: "Robots", "Geckos", "Super-advanced crab-people with quasar cannons"
	var/threat_type
	ztraits = list(ZTRAIT_RESERVED = TRUE, ZTRAIT_DUNGEON = TRUE)

/datum/map_template/dungeon/proc/spawn_dungeon_map_chunk()
	var/datum/turf_reservation/dungeon/reservation = SSmapping.RequestBlockReservation(width, height, type = /datum/turf_reservation/dungeon) 									//Reserve space to spawn our dungeon
	if(!reservation)
		message_admins(span_adminnotice("DEBUG:Failed to reserve space to spawn a dungeon.")) 											//We couldn't reserve a spot.
		return
	var/turf/placement = locate(reservation.bottom_left_coords[1],reservation.bottom_left_coords[2],reservation.bottom_left_coords[3])
	load(placement)																														//Place the dungeon
	loaded++																															//Increment the # of times this dungeon has spawned
	var/turf/center = locate(placement.x + round(width/2),placement.y + round(height/2),placement.z)									//Locate the center turf of the dungeon to spawn a dungeon controller / landmark thing
	new /obj/effect/landmark/dungeon_mark(center, src)
	message_admins(span_adminnotice("DEBUG:Dungeon ([name]) placed at [ADMIN_COORDJMP(center)]"))
	return reservation

/**
 * Loads and spawns a dungeon instance for testing purposes.
 */
/client/proc/dungeon_test_load()
	set category = "Debug"
	set name = "spawn dungeon instance"

	var/datum/map_template/dungeon/template

	var/map = input(src, "Choose a dungeon to spawn","Spawn dungeon instance") as null|anything in SSmapping.dungeon_templates

	if(!map)
		return
	template = SSmapping.dungeon_templates[map]

	template.spawn_dungeon_map_chunk()

/**
 * This proc is used to perform a stress test on dungeons.
 * It toggles the `SSdungeons.dungeon_stress_test` variable to start or cancel the stress test.
 * During the stress test, it spawns multiple dungeons based on the available templates.
 * Each dungeon is spawned with a delay of 30 seconds.
 * The stress test can be canceled by toggling the `SSdungeons.dungeon_stress_test` variable again.
 */
/client/proc/dungeon_stress_test()
	set category = "Debug"
	set name = "stress test dungeons"

	SSdungeons.dungeon_stress_test = !SSdungeons.dungeon_stress_test

	if(SSdungeons.dungeon_stress_test)
		message_admins(span_adminnotice("STRESS TEST: Stress test started."))
		for(var/i=0, i<30, i++)
			if(!SSdungeons.dungeon_stress_test)
				break
			var/datum/map_template/dungeon/template
			var/map = pick(SSmapping.dungeon_templates)
			if(!map)
				message_admins(span_adminnotice("STRESS TEST: No maps found..."))
				continue
			template = SSmapping.dungeon_templates[map]
			message_admins(span_adminnotice("STRESS TEST: Spawning dungeon #[i+1]."))
			template.spawn_dungeon_map_chunk()
			sleep(30 SECONDS)
	else
		message_admins(span_adminnotice("STRESS TEST: Stress test canceled."))

// Players find these in normal loot and can then open a rift to a dungeon by clicking on the dungeon entrance with it.
/obj/item/rift_stabilizer
	name = "rift stabilizer"
	icon = 'modular_coyote/icons/items/items.dmi'
	icon_state = "rift_stabilizer"
	desc = "A one-time use device that temporarily stabilizes a rift into a usable portal into another dimension.\
			The Reclaimers have been known to use these to access hidden caches of advanced technology and resources."
	// Can open rifts of this tier and below. Compares against the dungeon's loot_abundance
	var/dungeon_tier = LOOT_TIER_MID

/obj/item/rift_stabilizer/advanced
	name = "advanced rift stabilizer"
	icon_state = "rift_stabilizer_2"
	dungeon_tier = LOOT_TIER_HIGHEST

/obj/structrue/dungeon
	name = "dungeon thing"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/// Click on this to enter a dungeon
/obj/structrue/dungeon/entrance
	/// The typepath of the dungeon we use
	var/dungeon_type
	/// List of dungeon controllers created for this entrance. Lets several people run the same dungeon at once.
	var/list/instances = list()


/obj/structrue/dungeon/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/rift_stabilizer))
		if(C.dungeon_tier < dungeon_type.loot_abundance)
			to_chat(user, span_warning("This rift is too powerful for [src] to stabilize it. A stronger one might work."),
			MESSAGE_TYPE_INFO)
			// Play a negative sound
			return
		var/datum/dungeon_controller/DC = new dungeon_type(src)
		LAZYADD(instances, DC)

	else
		return ..()

	
	

/obj/effect/landmark/dungeon_entrance/debug_1

/// Transition from one dungeon chunk to another without leaving the same dungeon.
/obj/effect/landmark/dungeon_transition

/// This takes you back to the "real" world
/obj/effect/landmark/dungeon_exit

/* These examples are too large to load in quick enough for reasonable gameplay.
/datum/map_template/dungeon/debug_1
	name = "Debug Dungeon 1"
	description = "I wanna be the very first."
	mappath = "_maps/templates/dungeons/debug_1.dmm"

/datum/map_template/dungeon/debug_2
	name = "Debug Dungeon 2"
	description = "I wanna be the very second."
	mappath = "_maps/templates/dungeons/debug_2.dmm"

/datum/map_template/dungeon/debug_3
	name = "Debug Dungeon 3"
	description = "I wanna be the very third."
	mappath = "_maps/templates/dungeons/debug_3.dmm"

/datum/map_template/dungeon/debug_4
	name = "Debug Dungeon 4"
	description = "I wanna be the very fourth."
	mappath = "_maps/templates/dungeons/debug_4.dmm"
*/
