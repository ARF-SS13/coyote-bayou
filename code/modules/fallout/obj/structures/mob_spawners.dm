//base nest and the procs
/obj/structure/nest
	name = "monster nest"
	desc = "A horrible nest full of monsters."
	icon = 'icons/mob/nest_new.dmi'
	icon_state = "hole"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/mob_types = list(/mob/living/simple_animal/hostile/carp)
	/// Time between spawns
	var/spawn_time = 40 SECONDS
	/// Can be boarded up
	var/coverable = TRUE
	/// spawner can be covered by dense things
	var/coverable_by_dense_things = TRUE
	/// Currently boarded up
	var/covered = FALSE
	/// Object boarding this thing up?
	var/obj/covertype
	/// Did this thing make loot? If so, dont drop more stuff
	var/made_loot = FALSE
	/// verb for when a mob comes out
	var/spawn_text = "emerges from"
	/// Range to check for other mobs to see if there's too many around
	var/overpopulation_range = 6
	/// max mobs that can be alive and nearby before it refuses to spawn more
	var/max_mobs = 1
	/// A player must be within this range for it to actually spawn
	var/radius = 10
	/// Sound to play when a thing spawns
	var/spawnsound
	/// Its infinite!
	var/infinite = FALSE
	/// Number of mobs to spawn per cycle, for swarms!
	var/swarm_size = 1
	/// The ID of our randomizer, so all spawners with this ID will spawn from the same list. Leave null to skip global randomization for this thing
	var/randomizer_tag
	/// Which spawner list to pick from
	var/randomizer_kind
	/// Which difficulties to pick from - its a bitfield!
	var/randomizer_difficulty

/obj/structure/nest/Initialize()
	. = ..()
	// null faction, so we don't overwrite it
	AddComponent(/datum/component/spawner,\
		_mob_types = mob_types,\
		_spawn_time = spawn_time,\
		_faction = list(),\
		_spawn_text = spawn_text,\
		_max_mobs = max_mobs,\
		_range = radius,\
		_overpopulation_range = overpopulation_range,\
		_spawn_sound = spawnsound,\
		_infinite = infinite,\
		_swarm_size = swarm_size,\
		_coverable_by_dense_things = coverable_by_dense_things,\
		_randomizer_tag = randomizer_tag,\
		_randomizer_kind = randomizer_kind,\
		_randomizer_difficulty = randomizer_difficulty\
		)

/obj/structure/nest/Destroy()
	playsound(src, 'sound/effects/break_stone.ogg', 100, 1)
	visible_message("[src] collapses!")
	. = ..()

/obj/structure/nest/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_CROWBAR)
		return try_unseal(FALSE, user, I)

	if(istype(I, /obj/item/stack/rods))
		return try_seal(user, I, I.type, "rods", 0)
	if(istype(I, /obj/item/stack/sheet/mineral/wood))
		return try_seal(user, I, I.type, "planks", 1 HOURS)

	if(covered) // allow you to interact only when it's sealed
		..()
	else
		if(user.a_intent == INTENT_HARM)
			to_chat(user, span_warning("You feel it is impossible to destroy this without covering it with something."))
			return

/obj/structure/nest/proc/try_seal(mob/user, obj/item/stack/S, itempath, cover_state, timer)
	if(!coverable)
		to_chat(user, span_warning("\The [src] is unable to be covered!"))
		return
	if(covered)
		to_chat(user, span_warning("\The [src] is already covered!"))
		return
	if(!istype(S))
		to_chat(user, span_warning("You cant cover \the [src] with that!"))
		return
	if(LAZYLEN(targeted_by)) // Don't let multiple people cover at the same time.
		to_chat(user, span_warning("Someone's already covering \the [src]!"))
		return
	if(S.amount < 4)
		to_chat(user, span_warning("You need four of [S.name] in order to cover \The [src]!"))
		return
	if(!do_after(user, 5 SECONDS, FALSE, src))
		to_chat(user, span_warning("You must stand still to build the cover!"))
		return
	S.use(4)
	if(!made_loot)
		made_loot = TRUE
		new /obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/garbagetomid(src.loc)
		if(istype(user))
			to_chat(user, span_warning("You find something while covering the hole!"))
	do_seal(itempath, cover_state, timer)

/obj/structure/nest/proc/do_seal(itempath, cover_state, timer)
	SEND_SIGNAL(src, COMSIG_SPAWNER_COVERED)
	covered = TRUE
	covertype = itempath
	var/image/overlay_image = image(icon, icon_state = cover_state)
	add_overlay(overlay_image)
	if(timer)
		addtimer(CALLBACK(src, .proc/do_unseal), timer)

/obj/structure/nest/proc/try_unseal(mob/user = null, obj/item/I = null)
	if(!istype(user))
		return
	if(!istype(I))
		return
	I.play_tool_sound(src, 50)
	if(!do_after(user, 5 SECONDS, FALSE, src))
		to_chat(user, span_warning("You must stand still to unseal the cover!"))
		return
	do_unseal()

/obj/structure/nest/proc/do_unseal()
	SEND_SIGNAL(src, COMSIG_SPAWNER_UNCOVERED)
	covered = FALSE
	covertype = null
	cut_overlays()

/obj/structure/nest/ghoul
	name = "ghoul nest"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/ghoul = 5,
					/mob/living/simple_animal/hostile/ghoul/reaver = 3,
					/mob/living/simple_animal/hostile/ghoul/glowing = 1)

/obj/structure/nest/deathclaw
	name = "deathclaw nest"
	max_mobs = 1
	spawn_time = 60 SECONDS
	mob_types = list(/mob/living/simple_animal/hostile/deathclaw = 1)

/obj/structure/nest/deathclaw/mother
	name = "mother deathclaw nest"
	spawn_time = 120 SECONDS
	mob_types = list(/mob/living/simple_animal/hostile/deathclaw/mother = 1)

/obj/structure/nest/scorpion
	name = "scorpion nest"
	spawn_time = 40 SECONDS
	max_mobs = 1
	mob_types = list(/mob/living/simple_animal/hostile/radscorpion = 5,
					/mob/living/simple_animal/hostile/radscorpion/black = 5)

/obj/structure/nest/radroach
	name = "radroach nest"
	max_mobs = 3
	swarm_size = 3
	mob_types = list(/mob/living/simple_animal/hostile/radroach = 15)

/obj/structure/nest/fireant
	name = "fireant nest"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/fireant = 3,
					/mob/living/simple_animal/hostile/giantant = 6)

/obj/structure/nest/wanamingo
	name = "wanamingo nest"
	spawn_time = 40 SECONDS
	max_mobs = 1
	mob_types = list(/mob/living/simple_animal/hostile/alien = 3)

/obj/structure/nest/rattle
	name = "rattling hole"
	spawn_time = 40 SECONDS
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/texas_rattler = 3)

/obj/structure/nest/molerat
	name = "molerat nest"
	max_mobs = 3
	mob_types = list(/mob/living/simple_animal/hostile/molerat = 20)
	spawn_time = 20 SECONDS //They just love tunnelin'.. And are pretty soft

/obj/structure/nest/mirelurk
	name = "mirelurk nest"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/mirelurk = 2,
					/mob/living/simple_animal/hostile/mirelurk/hunter = 1,
					/mob/living/simple_animal/hostile/mirelurk/baby = 8)

/obj/structure/nest/raider
	name = "narrow tunnel"
	desc = "A crude tunnel used by raiders to travel across the wasteland."
	max_mobs = 2
	icon_state = "ventblue"
	spawnsound = 'sound/effects/bin_close.ogg'
	mob_types = list(/mob/living/simple_animal/hostile/raider = 5,
					/mob/living/simple_animal/hostile/raider/firefighter = 2,
					/mob/living/simple_animal/hostile/raider/baseball = 5,
					/mob/living/simple_animal/hostile/raider/ranged = 2,
					/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 1,
					/mob/living/simple_animal/hostile/raider/ranged/biker = 1,
					/mob/living/simple_animal/hostile/raider/tribal = 1)

/obj/structure/nest/raider/melee
	mob_types = list(/mob/living/simple_animal/hostile/raider = 5,
					/mob/living/simple_animal/hostile/raider/firefighter = 2,
					/mob/living/simple_animal/hostile/raider/baseball = 5,
					/mob/living/simple_animal/hostile/raider/tribal = 1)

/obj/structure/nest/raider/ranged
	max_mobs = 1
	mob_types = list(/mob/living/simple_animal/hostile/raider/ranged = 4,
					/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged = 2,
					/mob/living/simple_animal/hostile/raider/ranged/biker = 2)

/obj/structure/nest/raider/boss
	max_mobs = 1
	mob_types = list(/mob/living/simple_animal/hostile/raider/ranged/boss = 1)

/obj/structure/nest/raider/legendary
	max_mobs = 1
	mob_types = list(/mob/living/simple_animal/hostile/raider/legendary = 1)

/obj/structure/nest/protectron
	name = "protectron pod"
	desc = "An old robot storage system. This one looks like it is connected to space underground."
	max_mobs = 2
	icon_state = "scanner_modified"
	mob_types = list(/mob/living/simple_animal/hostile/handy/protectron = 5)

/obj/structure/nest/securitron
	name = "securitron pod"
	desc = "An old securitron containment pod system. This one looks like it is connected to a storage system underground."
	max_mobs = 1
	icon_state = "scanner_modified"
	mob_types = list(/mob/living/simple_animal/hostile/securitron = 2)

/obj/structure/nest/assaultron
	name = "assaultron pod"
	desc = "An old assaultron containment pod system. This one looks like it is connected to a storage system underground."
	spawn_time = 40 SECONDS
	max_mobs = 1
	icon_state = "scanner_modified"
	mob_types = list(/mob/living/simple_animal/hostile/handy/assaultron = 2)

/obj/structure/nest/cazador
	name = "cazador nest"
	max_mobs = 1
	mob_types = list(/mob/living/simple_animal/hostile/cazador = 5,
					/mob/living/simple_animal/hostile/cazador/young = 3)

/obj/structure/nest/gecko
	name = "gecko nest"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/gecko = 10)

/obj/structure/nest/wolf
	name = "wolf den"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/wolf = 5)

/obj/structure/nest/supermutant
	name = "supermutant den"
	spawn_time = 30 SECONDS
	max_mobs = 1
	mob_types = list(/mob/living/simple_animal/hostile/supermutant/meleemutant = 5,
					/mob/living/simple_animal/hostile/supermutant/rangedmutant = 2)

/obj/structure/nest/supermutant/melee
	mob_types = list(/mob/living/simple_animal/hostile/supermutant/meleemutant = 5)

/obj/structure/nest/supermutant/ranged
	mob_types = list(/mob/living/simple_animal/hostile/supermutant/rangedmutant = 5)

/obj/structure/nest/supermutant/nightkin
	mob_types = list(/mob/living/simple_animal/hostile/supermutant/nightkin = 5,
					/mob/living/simple_animal/hostile/supermutant/nightkin/rangedmutant = 2,
					/mob/living/simple_animal/hostile/supermutant/nightkin/elitemutant = 1)

/obj/structure/nest/nightstalker
	name = "nightstalker nest"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/stalker = 5,
					/mob/living/simple_animal/hostile/stalkeryoung = 5)

//Event Nests
/obj/structure/nest/zombieghoul
	name = "ravenous ghoul nest"
	max_mobs = 5
	mob_types = list(/mob/living/simple_animal/hostile/ghoul/zombie = 5,
					/mob/living/simple_animal/hostile/ghoul/zombie/reaver = 3,
					/mob/living/simple_animal/hostile/ghoul/zombie/glowing = 1)

/obj/structure/nest/tunneler
	name = "tunneler tunnel"
	desc = "A tunnel which leads to an underground network of even more tunnels, made by the dangerous tunnelers."
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/trog/tunneler = 10)
	spawn_time = 20 SECONDS

/obj/structure/nest/randomized
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"

/obj/structure/nest/randomized/test1
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"
	randomizer_tag = "Pisscock 1"
	randomizer_kind = MOB_SPAWNER_KIND_DEATH
	randomizer_difficulty = MOB_SPAWNER_DIFFICULTY_EASY | MOB_SPAWNER_DIFFICULTY_MED | MOB_SPAWNER_DIFFICULTY_HARD

/obj/structure/nest/randomized/test2
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"
	randomizer_tag = "Pisscock 2"
	randomizer_kind = MOB_SPAWNER_KIND_ALL
	randomizer_difficulty = MOB_SPAWNER_DIFFICULTY_EASY | MOB_SPAWNER_DIFFICULTY_HARD

/obj/structure/nest/randomized/test3
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"
	randomizer_tag = "Pisscock 3"
	randomizer_kind = MOB_SPAWNER_KIND_ROBOT_HIGH
	randomizer_difficulty = MOB_SPAWNER_DIFFICULTY_HARD

/obj/structure/nest/randomized/test4
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"
	randomizer_tag = "Pisscock 4"
	randomizer_kind = MOB_SPAWNER_KIND_RAIDER_LOW
	randomizer_difficulty = MOB_SPAWNER_DIFFICULTY_EASY

/obj/structure/nest/randomized/test5
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"
	randomizer_tag = "Pisscock 1"
	randomizer_kind = MOB_SPAWNER_KIND_RAIDER_LOW
	randomizer_difficulty = MOB_SPAWNER_DIFFICULTY_EASY

/obj/structure/nest/randomized/test6
	name = "Gross uninitialized carp spawner thing"
	desc = "Shouldnt see this! probably a bug~"
	randomizer_tag = "Pisscock 1"
	randomizer_kind = MOB_SPAWNER_KIND_DEBUG
	randomizer_difficulty = MOB_SPAWNER_DIFFICULTY_EASY



