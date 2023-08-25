/*
/datum/round_event_control/carp_migration
	name = "Carp Migration"
	typepath = /datum/round_event/carp_migration/blowout
	weight = 15
	min_players = 4
	earliest_start = 10 MINUTES
	max_occurrences = 6

/datum/round_event/carp_migration/blowout
	announceWhen	= 3
	startWhen = 50
	var/hasAnnounced = FALSE

/datum/round_event/carp_migration/blowout/setup()
	startWhen = rand(40, 60)

/datum/round_event/carp_migration/announce(fake)
	if(prob(50))
		priority_announce("Unknown biological entities have been detected near [station_name()], please stand-by.", "Lifesign Alert")
	else
		print_command_report("Unknown biological entities have been detected near [station_name()], you may wish to break out arms.", "Biological entities")

/datum/round_event/carp_migration/start()
	var/mob/living/simple_animal/hostile/carp/fish
	for(var/obj/effect/landmark/carpspawn/C in GLOB.landmarks_list)
		if(prob(95))
			fish = new (C.loc)
		else
			fish = new /mob/living/simple_animal/hostile/carp/megacarp(C.loc)
			fishannounce(fish) //Prefer to announce the megacarps over the regular fishies
	fishannounce(fish)

/datum/round_event/carp_migration/proc/fishannounce(atom/fish)
	if (!hasAnnounced)
		announce_to_ghosts(fish) //Only anounce the first fish
		hasAnnounced = TRUE
*/

/datum/round_event_control/carp_migration/blowoutmobs
	name = "Mob Blowout"
	typepath = /datum/round_event/carp_migration
	weight = 15
	min_players = 2
	earliest_start = 180 MINUTES
	max_occurrences = 3

/datum/round_event/carp_migration
	announceWhen	= 3
	startWhen = 50
	var/hasAnnounced = FALSE

/datum/round_event/carp_migration/setup()
	startWhen = rand(40, 60)


/datum/round_event/carp_migration/blowout/announce(fake)
	if(prob(50))
		priority_announce("In the blink of an eye the landscape shifts like a bad cathode ray tube telivision hit by a magnet.  The world seems suddenly more dangerous and wild.")
	else
		print_command_report("In the blink of an eye the landscape shifts like a bad cathode ray tube telivision hit by a magnet.  The world seems suddenly more dangerous and wild.")

	var/mob/living/simple_animal/spawned
	for(var/obj/effect/landmark/carpspawn/blowout/C in GLOB.landmarks_list)
		var/turf/here = get_turf(C)
		if(!here)
			continue
		if(locate(/obj/structure/nest) in here)
			continue // already a nest here lol
		spawned = pickweight(GLOB.totally_not_carp)
		if(!spawned)
			stack_trace("Spawner thing broke!")
			continue
		spawned = new spawned(get_turf(C))
	if(isatom(spawned))
		fishannounce(spawned)

GLOBAL_LIST_INIT(totally_not_carp, list(
	/obj/structure/nest/ghoul = 8,
	/obj/structure/nest/deathclaw = 3,
	/obj/structure/nest/deathclaw/mother = 1,
	/obj/structure/nest/scorpion = 3,
	/obj/structure/nest/radroach = 5,
	/obj/structure/nest/fireant = 3,
	/obj/structure/nest/wanamingo = 2,
	/obj/structure/nest/rattle = 2,
	/obj/structure/nest/molerat = 8,
	/obj/structure/nest/mirelurk = 3,
	/obj/structure/nest/rat = 5,
	/obj/structure/nest/mouse = 3,
	/obj/structure/nest/raider = 4,
	/obj/structure/nest/raider/melee = 4,
	/obj/structure/nest/raider/ranged = 3,
	/obj/structure/nest/raider/boss = 2,
	/obj/structure/nest/protectron = 3,
	/obj/structure/nest/securitron = 3,
	/obj/structure/nest/assaultron = 2,
	/obj/structure/nest/cazador = 2,
	/obj/structure/nest/gecko = 9,
	/obj/structure/nest/gelcube = 1,
	/obj/structure/nest/wolf = 3,
	/obj/structure/nest/supermutant = 3,
	/obj/structure/nest/supermutant/melee = 3,
	/obj/structure/nest/supermutant/ranged = 3,
	/obj/structure/nest/supermutant/nightkin = 1,
	/obj/structure/nest/nightstalker = 3,
	/obj/structure/nest/zombieghoul = 3,
	/obj/structure/nest/tunneler = 2,
))

/datum/round_event/carp_migration/blowout/proc/fishannounce(atom/fish)
	if (!hasAnnounced)
		announce_to_ghosts(fish) //Only anounce the first fish
		hasAnnounced = TRUE
