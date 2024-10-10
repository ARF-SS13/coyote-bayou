////////////////////////////////////////////////////////////////////////////////////////////
//// THIS IS THE RIGHT FILE! EVERY OTHER FILE IS WRONG! THIS IS THE CORRECT FILE! //////////
////////////////////////////////////////////////////////////////////////////////////////////

GLOBAL_LIST_EMPTY(player_made_nests)

//base nest and the procs
/obj/structure/nest
	name = "monster nest"
	desc = "A horrible nest full of monsters."
	icon = 'icons/mob/nest_new.dmi'
	icon_state = "hole"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/list/mob_types = list(/mob/living/simple_animal/hostile/carp)
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
	//var/spawn_text = NULL //it makes a sound
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
	/// If a playermob spawns this, keep track of it
	var/spawned_by_ckey
	/// hold off on spawning, gotta set it up first
	var/delay_start = FALSE
	/// Some cool factions to override the default ones
	var/list/faction = list()
	/// hold off on making the component
	var/hold_component = FALSE
	var/ignore_faction = FALSE
	var/generation = 1

/obj/structure/nest/blank
	hold_component = TRUE

/obj/structure/nest/ComponentInitialize()
	. = ..()
	if(hold_component)
		return
	make_component()

/obj/structure/nest/proc/make_component()
	// null faction, so we don't overwrite it
	AddComponent(/datum/component/spawner,\
		_mob_types = mob_types,\
		_spawn_time = spawn_time,\
		_faction = faction,\
		/*_spawn_text = spawn_text,*/\
		_max_mobs = max_mobs,\
		_range = radius,\
		_overpopulation_range = overpopulation_range,\
		_spawn_sound = spawnsound,\
		_infinite = infinite,\
		_swarm_size = swarm_size,\
		_coverable_by_dense_things = coverable_by_dense_things,\
		_randomizer_tag = randomizer_tag,\
		_randomizer_kind = randomizer_kind,\
		_randomizer_difficulty = randomizer_difficulty,\
		_delay_start = delay_start,\
		_ignore_faction = ignore_faction,\
		_generation = generation,\
		)

/obj/structure/nest/Destroy()
	remove_nest()
	if(spawned_by_ckey)
		GLOB.player_made_nests[spawned_by_ckey][type] -= src
	. = ..()

/obj/structure/nest/proc/register_ckey(ckey)
	if(!ckey)
		return
	if(!islist(GLOB.player_made_nests[ckey]))
		GLOB.player_made_nests[ckey] = list()
	if(!islist(GLOB.player_made_nests[ckey][type]))
		GLOB.player_made_nests[ckey][type] = list()
	GLOB.player_made_nests[ckey][type] |= src
	spawned_by_ckey = ckey
	desc += " Looks recently dug!"

/obj/structure/nest/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_CROWBAR)
		return try_unseal(FALSE, user, I)

	if(istype(I, /obj/item/stack/rods))
		return try_seal(user, I, I.type, "rods", 0)
	if(istype(I, /obj/item/stack/sheet/mineral/wood))
		return try_seal(user, I, I.type, "planks", 1 HOURS)

	..()  //we can destroy them without covering the hole

	// if(covered) // allow you to interact only when it's sealed
	// 	..()
	// else
	// 	if(user.a_intent == INTENT_HARM)
	// 		to_chat(user, span_warning("You feel it is impossible to destroy this without covering it with something."))
	// 		return

/obj/structure/nest/proc/remove_nest()
	playsound(src, 'sound/effects/break_stone.ogg', 100, 1)
	visible_message("[src] collapses!")

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
		var/obj/effect/spawner/lootdrop/f13/common/junk = new(get_turf(src))
		if(junk && !QDELETED(junk))
			qdel(junk)
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
		addtimer(CALLBACK(src,PROC_REF(do_unseal)), timer)

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

/obj/structure/nest/lesserspider
	name = "spider nest"
	max_mobs = 2
	spawn_time = 10 SECONDS //creepy fast crawlies
	mob_types = list(/mob/living/simple_animal/hostile/poison/giant_spider/nurse = 5,
					/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 3,
					/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 3,
					/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 3)

// /obj/structure/nest/greaterspider
// 	name = "empress nest"
// 	max_mobs = 1
// 	spawn_time = 20 SECONDS
// 	mob_types = list(/mob/living/simple_animal/hostile/poison/giant_spider/queen = 2,
// 					/mob/living/simple_animal/hostile/poison/giant_spider/empress = 1)

// /obj/structure/nest/omegaspider
// 	name = "emperor nest"
// 	max_mobs = 1
// 	spawn_time = 25 SECONDS
// 	mob_types = list(/mob/living/simple_animal/hostile/poison/giant_spider/emperor = 2)

/obj/structure/nest/mook
	name = "mook den"
	max_mobs = 2
	spawn_time = 10 SECONDS
	mob_types = list(/mob/living/simple_animal/hostile/jungle/mook = 2)

/obj/structure/nest/hivebot
	name = "hivebot datacreator"
	max_mobs = 3
	spawn_time = 5 SECONDS
	mob_types = list(/mob/living/simple_animal/hostile/hivebot = 3,
					/mob/living/simple_animal/hostile/hivebot/range = 3,
					/mob/living/simple_animal/hostile/hivebot/rapid = 3,
					/mob/living/simple_animal/hostile/hivebot/strong = 3)

/obj/structure/nest/pirate
	name = "pirate hideout"
	max_mobs = 2
	spawn_time = 10 SECONDS
	mob_types = list(/mob/living/simple_animal/hostile/raider/pirate/melee = 2,
					/mob/living/simple_animal/hostile/raider/pirate/ranged = 2)

/obj/structure/nest/russian
	name = "russian hideout"
	max_mobs = 2
	spawn_time = 10 SECONDS
	mob_types = list(/mob/living/simple_animal/hostile/russian/ranged = 2,
					/mob/living/simple_animal/hostile/russian/ranged/mosin = 2, 
					/mob/living/simple_animal/hostile/russian/ranged/trooper = 2,
					/mob/living/simple_animal/hostile/russian/ranged/officer = 2)

/obj/structure/nest/syndicate
	name = "syndicate hideout"
	max_mobs = 2
	spawn_time = 15 SECONDS
	mob_types = list(/mob/living/simple_animal/hostile/renegade/syndicate/melee/sword/space = 2,
					/mob/living/simple_animal/hostile/renegade/syndicate/melee/sword/space/stormtrooper = 2,
					/mob/living/simple_animal/hostile/renegade/syndicate/ranged/smg/space = 2,
					/mob/living/simple_animal/hostile/renegade/syndicate/ranged/smg/space/stormtrooper = 2,
					/mob/living/simple_animal/hostile/renegade/syndicate/ranged/shotgun/space,
					/mob/living/simple_animal/hostile/renegade/syndicate/ranged/shotgun/space/stormtrooper)

/obj/structure/nest/aethergiest
	name = "aethergiest nest"
	max_mobs = 1
	spawn_time = 60 SECONDS
	mob_types = list(/mob/living/simple_animal/hostile/aethergiest = 1)

/obj/structure/nest/aethergiest/mother
	name = "mother aethergiest nest"
	spawn_time = 120 SECONDS
	mob_types = list(/mob/living/simple_animal/hostile/aethergiest/mother = 1)

/obj/structure/nest/scorpion
	name = "scorpion nest"
	spawn_time = 40 SECONDS
	max_mobs = 1
	mob_types = list(/mob/living/simple_animal/hostile/radscorpion = 5,
					/mob/living/simple_animal/hostile/radscorpion/black = 5)

/obj/structure/nest/radroach
	name = "mutant pillbug nest"
	max_mobs = 3
	swarm_size = 3
	mob_types = list(/mob/living/simple_animal/hostile/pillbug = 10,
					/mob/living/simple_animal/hostile/pillbug/micro = 15,
					/mob/living/simple_animal/hostile/pillbug/leader = 5,
					/mob/living/simple_animal/hostile/pillbug/strongradroach = 10,
					/mob/living/simple_animal/hostile/bloatfly = 20
					)
	spawn_time = 30 SECONDS

/obj/structure/nest/fireant
	name = "fireant nest"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/fireant = 3,
					/mob/living/simple_animal/hostile/giantant = 6)
	spawn_time = 30 SECONDS

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
	max_mobs = 4
	mob_types = list(/mob/living/simple_animal/hostile/molerat = 20,
						/mob/living/simple_animal/hostile/molerat/micro = 10,
						/mob/living/simple_animal/hostile/molerat/leader = 1
	)
	spawn_time = 30 SECONDS //They just love tunnelin'.. And are pretty soft

/obj/structure/nest/mirelurk
	name = "mirelurk nest"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/mirelurk = 2,
					/mob/living/simple_animal/hostile/mirelurk/hunter = 1,
					/mob/living/simple_animal/hostile/mirelurk/baby = 8)
	spawn_time = 30 SECONDS

/obj/structure/nest/rat
	name = "rat nest"
	max_mobs = 6
	spawn_time = 30 SECONDS //squeak
	mob_types = list(/mob/living/simple_animal/hostile/rat = 30)

/obj/structure/nest/rat/tame
	name = "imprinted rat nest"
	desc = "An artifical-looking nest full of less-than-evil squeakers."
	color = "#91fdac"
	mob_types = list(
		/mob/living/simple_animal/hostile/rat/frien = 9,
		/mob/living/simple_animal/hostile/rat/skitter/curious = 1
	)

/obj/structure/nest/mouse
	name = "mouse nest"
	max_mobs = 6
	spawn_time = 30 SECONDS //squeak
	mob_types = list(/mob/living/simple_animal/hostile/rat/skitter = 30)

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
					/mob/living/simple_animal/hostile/raider/tribal = 1,
					/mob/living/simple_animal/hostile/renegade/grunt/emp = 2)

/obj/structure/nest/raider/melee
	mob_types = list(/mob/living/simple_animal/hostile/raider = 5,
					/mob/living/simple_animal/hostile/raider/firefighter = 2,
					/mob/living/simple_animal/hostile/raider/baseball = 5,
					/mob/living/simple_animal/hostile/raider/tribal = 1)
	spawn_time = 30 SECONDS

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
	spawn_time = 30 SECONDS


/obj/structure/nest/gecko
	name = "gecko eggs"
	icon = 'icons/fallout/mobs/nests.dmi'
	icon_state = "nest_gecko"
	desc = "A pile of gecko eggs on top of a clay mound."
	max_mobs = 3
	spawnsound = 'sound/misc/crack.ogg'
	mob_types = list(
		/mob/living/simple_animal/hostile/gecko              = 4,
		/mob/living/simple_animal/hostile/gecko/fire         = 1,
		/mob/living/simple_animal/hostile/gecko/legacy       = 3,
		/mob/living/simple_animal/hostile/gecko/legacy/alpha = 3,
		/mob/living/simple_animal/hostile/gecko/big          = 2,
		)
	spawn_time = 30 SECONDS

/obj/structure/nest/gecko/Initialize()
	if(prob(10))
		mob_types |= list(
			/mob/living/simple_animal/hostile/gecko/tribal          = 3,
			/mob/living/simple_animal/hostile/gecko/tribal/juvenile = 4,
			/mob/living/simple_animal/hostile/gecko/tribal/warrior  = 3,
			/mob/living/simple_animal/hostile/gecko/tribal/hunter   = 3,
		)
		if(prob(1))
			mob_types |= list(/mob/living/simple_animal/hostile/gecko/tribal/head_shaman/small_shaman = 1)
	. = ..()

/obj/structure/nest/gecko/boss
	name = "kobold eggs"
	icon = 'icons/fallout/mobs/nests.dmi'
	icon_state = "nest_gecko"
	desc = "Where theres a big sexy dragon couple, there are bound to be big sexy kobolds. Look at em now!"
	max_mobs = 3
	spawnsound = 'sound/misc/crack.ogg'
	mob_types = list(
		/mob/living/simple_animal/hostile/gecko = 4,
		/mob/living/simple_animal/hostile/gecko/tribal/warrior = 2,
		/mob/living/simple_animal/hostile/gecko/tribal/hunter = 2,
		/mob/living/simple_animal/hostile/gecko/fire = 1,
		/mob/living/simple_animal/hostile/gecko/legacy = 3,
		/mob/living/simple_animal/hostile/gecko/legacy/alpha = 3,
		/mob/living/simple_animal/hostile/gecko/big = 2,
		/mob/living/simple_animal/hostile/gecko/tribal/juvenile =  4,
		/mob/living/simple_animal/hostile/gecko/tribal/warrior =  3,
		/mob/living/simple_animal/hostile/gecko/tribal/hunter =  3,
		/mob/living/simple_animal/hostile/gecko/tribal/head_shaman/small_shaman =  2,
		)

/obj/structure/nest/gecko/tribal
	name = "gecko tribal campsite"
	icon = 'icons/fallout/objects/furniture/heating.dmi'
	icon_state = "campfire"
	desc = "A surprisingly well put together campsite for sleepy geckos."
	spawnsound = 'sound/f13npc/gecko/geckocall5.ogg'
	mob_types = list(
		/mob/living/simple_animal/hostile/gecko/tribal = 8,
		/mob/living/simple_animal/hostile/gecko/tribal/juvenile = 4,
		/mob/living/simple_animal/hostile/gecko/tribal/warrior = 2,
		/mob/living/simple_animal/hostile/gecko/tribal/hunter = 3,
		/mob/living/simple_animal/hostile/gecko/tribal/shaman = 1
	)

/obj/structure/nest/gecko/tribal/hunting
	name = "gecko hunting campsite"
	icon = 'icons/fallout/objects/furniture/heating.dmi'
	icon_state = "campfire"
	desc = "A surprisingly well put together campsite for sleepy geckos in the field."
	spawnsound = 'sound/f13npc/gecko/geckocall5.ogg'
	mob_types = list(
		/mob/living/simple_animal/hostile/gecko/tribal/warrior = 6,
		/mob/living/simple_animal/hostile/gecko/tribal/hunter = 12
	)
	spawn_time = 30 SECONDS

/obj/structure/nest/gecko/tribal/guard
	name = "gecko guard campsite"
	icon = 'icons/fallout/objects/furniture/heating.dmi'
	icon_state = "campfire"
	desc = "A surprisingly well put together campsite for sleepy geckos protecting their home."
	spawnsound = 'sound/f13npc/gecko/geckocall5.ogg'
	mob_types = list(
		/mob/living/simple_animal/hostile/gecko/tribal/warrior = 12,
		/mob/living/simple_animal/hostile/gecko/tribal/hunter = 6
	)
	spawn_time = 30 SECONDS

/obj/structure/nest/gelcube
	name = "slimy tunnel"
	desc = "A vent leading deep into some ill forgotten pit."
	spawn_time = 120 SECONDS
	max_mobs = 1
	icon_state = "ventblue"
	mob_types = list(/mob/living/simple_animal/hostile/gelcube = 10)

/obj/structure/nest/gelcube/debug
	name = "horrible debug hole"
	desc = "If you can see this, yell at Fenny. Or lagg. Or both. Or neither. Either way this is a debug nest."
	spawn_time = 2 SECONDS
	max_mobs = 1
	icon_state = "ventblue"
	mob_types = list(/mob/living/simple_animal/hostile/gelcube = 100)

/obj/structure/nest/wolf
	name = "wolf den"
	max_mobs = 2
	mob_types = list(/mob/living/simple_animal/hostile/wolf = 5)
	spawn_time = 30 SECONDS

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

// Nests for mobs that are special and/or dont have any nearby nests to unbirth into
/obj/structure/nest/special
	name = "special nest"
	max_mobs = 20
	delay_start = TRUE
	mob_types = list()

/obj/structure/nest/special/remove_nest()
	return
/obj/structure/nest/special/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration, atom/attacked_by)
	. = ..()
	if(.)
		SEND_SIGNAL(src, COMSIG_SPAWNER_SPAWN_NOW)
	return

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

//Fennis adding non-angi mob spawners//

/obj/structure/nest/frog
	name = "tadpoles"
	icon = 'icons/fallout/mobs/nests.dmi'
	icon_state = "frog"
	desc = "Are those tadpoles?"
	max_mobs = 2
	spawnsound = 'sound/f13effects/sunsetsounds/frogwarcry.ogg'
	mob_types = list(
		/mob/living/simple_animal/hostile/retaliate/frog = 10,
		/mob/living/simple_animal/hostile/retaliate/frog/red = 2
	)

/*
/obj/structure/nest/crows
	name = "crowsnest"
	icon = 'icons/fallout/mobs/nests.dmi'
	icon_state = "frog"
	desc = "Are those birds eggs?"
	max_mobs = 2
	spawn_text = "flies out of the nest!"
	spawnsound = list(
		'sound/f13ambience/crow_1.ogg',
		'sound/f13ambience/crow_2.ogg',
	)
	mob_types = list(
	/mob/living/simple_animal/bird/crow,
	/mob/living/simple_animal/bird/commonblackbird
	)
*/

