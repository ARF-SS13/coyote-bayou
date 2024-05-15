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
	/// When rolling a middle map, this is the chance to instead roll an exit map. If 0, will always roll the max middle maps and an exit map.
	var/exit_chance = 50
	/// An associative list of map templates that have been spawned for this controller with their respective turf reservations.
	var/list/my_maps = list()
	///
	var/list/my_reservations = list()
	/// Controls dynamic loot and mob spawning behavior. Also determines what tier of rift stabilizer you need to open an instance of this dungeon.
	var/loot_abundance = LOOT_TIER_MID

/datum/dungeon_controller/New()
	//Sanitize the amount of maps we can make so that fenny can mess this up and it will still work.
	if(can_dupe_middle_maps == FALSE && min_middle_maps > LAZYLEN(middle_maps))
		min_middle_maps = LAZYLEN(middle_maps)
		max_middle_maps = max(min_middle_maps, max_middle_maps)
	exit_chance = clamp(exit_chance, 0, 100)
	
	MakeMapList()

/// Populates the my_maps list with the weighted list of maps to choose from
/datum/dungeon_controller/proc/MakeMapList()
	my_maps += pickweight(start_maps)
	var/mids = 0
	var/exited = FALSE
	for(var/i=0, i<max_middle_maps, i++)
		if(rand(1,100) <= exit_chance) 							// Rolled an exit map chunk
			if(mids < min_middle_maps) 							// We haven't rolled enough middle maps yet
				for(mids, mids < min_middle_maps, mids++) 		// Roll more middle maps until we have enough
					my_maps += pick(middle_maps)
					mids++
			if(mids >= min_middle_maps)							// We have enough middle maps, so we can roll an exit map
				my_maps += pick(exit_maps)
				exited = TRUE
				break
		else
			my_maps += pick(middle_maps)						// We rolled a middle map, so add it to the list
			mids++
	if(!exited)
		my_maps += pick(exit_maps)								// We didn't roll an exit map, so add one to the end
		exited = TRUE

	AssociateMapTemplates()

/// Takes the my_maps list and associates their paths with real map templates to instanciate
/datum/dungeon_controller/proc/AssociateMapTemplates()
	for(var/map in my_maps)
		if(!ispath(map))
			continue
		for(var/datum/map_template/dungeon/template in SSmapping.dungeon_templates)
			if(istype(template, map))
				map = template
			message_admins(span_adminnotice("DEBUG: Matched [map] for a map template."))
		if(ispath(map))
			message_admins(span_adminnotice("DEBUG: Failed to find dungeon map template for [map]. Report this as a bug!"))

/datum/dungeon_controller/proc/GenerateMap(map_index)
	var/datum/map_template/dungeon/map
	if(ispath(my_maps[map_index]))
		my_maps[map_index] = locate(my_maps[map_index]) in SSmapping.dungeon_templates
	var/datum/turf_reservation/dungeon/reservation = map.spawn_dungeon_map_chunk()
	if(!istype(reservation))
		message_admins(span_adminnotice("DEBUG:Failed to reserve space to spawn a dungeon.")) 											//We couldn't reserve a spot.
		return
	my_reservations[map_index] = reservation
	my_maps[map_index] = map
	return reservation




//dungeon controller
/////////////////////////////////////////////////////////////////////////////////////////////////
//map templates


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
	// How many uses this stabilizer has before it disintegrates. Set to 0 for infinite uses.
	var/uses = 1

/obj/item/rift_stabilizer/proc/ReduceUses(amount)
	if(uses > 0)
		uses -= amount
		if(uses <= 0)
			visible_message(span_warning("[src] disintegrates into dust."),
							span_warning("[src] disintegrates into dust."),
							span_warning("You hear electrical sparks flying and the sound of metal crumbling into dust."))
			qdel(src)

/obj/item/rift_stabilizer/advanced
	name = "advanced rift stabilizer"
	icon_state = "rift_stabilizer_2"
	dungeon_tier = LOOT_TIER_HIGHEST

/obj/item/rift_stabilizer/infinite
	name = "perfected rift stabilizer"
	desc = "A perfected version of the rift stabilizer that never runs out of uses. A practically mythical piece of tech within the Reclaimers."
	icon_state = "rift_stabilizer_2"
	light_range = 2
	light_color = "#aec314"
	dungeon_tier = LOOT_TIER_HIGHEST
	uses = 0

/obj/structure/dungeon
	name = "dungeon thing"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/// Click on this to enter a dungeon
/obj/structure/dungeon/entrance
	/// The typepath of the dungeon we use
	var/dungeon_type
	/// The tier of rift stabilizer needed to open this dungeon.
	var/dungeon_tier
	/// List of dungeon controllers created for this entrance. Lets several people run the same dungeon at once.
	var/list/instances = list()
	icon = 'modular_coyote/icons/objects/dungeon_obj.dmi'
	icon_state = "entrance_mapping"
	var/icon_stabilized = "entrance_stab"
	var/icon_unstabilized = "entrance"
	var/stabilized = FALSE
	light_range = 5
	light_color = "#00FFFF"

/obj/structure/dungeon/entrance/Initialize()
	. = ..()
	icon_state = stabilized ? icon_stabilized : icon_unstabilized

/obj/structure/dungeon/entrance/proc/TryMakeNewDungeon(mob/user, obj/item/rift_stabilizer/R)
	if(user && R)
		if(dungeon_tier && R.dungeon_tier < dungeon_tier)
			to_chat(user, span_warning("This particular rift is too powerful for [src] to stabilize it. A stronger one might work."))
			// Play a negative sound here
			return
	var/datum/dungeon_controller/DC = SSdungeons.CreateDungeonInstance(dungeon_type)
	if(!DC || isnull(DC))
		if(user)
			to_chat(user, span_warning("Failed to create a dungeon instance. Report this as a bug!"))
		return
	//play a positive sound here
	LAZYADD(instances, DC)
	R?.ReduceUses(1)
	DC.GenerateMap(1)//Generate the first map chunk so it can be used instantly
	return DC

/obj/structure/dungeon/entrance/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/rift_stabilizer))
		var/datum/dungeon_controller/DC = TryMakeNewDungeon(user, C)
		if(DC)
			visible_message(user, span_notice("The rift stabilizer hums and crackles with energy as it stabilizes the rift."),
							span_notice("The rift stabilizer hums and crackles with energy as it stabilizes the rift."),
							span_notice("You hear crackling and sparking before a stable hum eminates."))
			DC.GenerateMap(1)
	else
		. = ..()

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
