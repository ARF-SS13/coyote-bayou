/*IN THIS FILE:
-Handy
-Gutsy
-Protectrons
-Robobrains
-Assaultrons
*/

/mob/living/simple_animal/hostile/handy
	name = "mr. handy"
	desc = "A crazed pre-war household assistant robot, armed with a cutting saw."
	icon = 'icons/fallout/mobs/robots/wasterobots.dmi'
	icon_state = "handy"
	icon_living = "handy"
	icon_dead = "robot_dead"
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC|MOB_INORGANIC
	move_resist = MOVE_FORCE_OVERPOWERING // Can't be pulled
	health = 130 //7 shots of 9mm
	maxHealth = 130
	healable = FALSE
	stat_attack = UNCONSCIOUS
	melee_damage_lower = 28
	melee_damage_upper = 28
	robust_searching = TRUE
	attack_verb_simple = "saws"
	faction = list("wastebot")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	speak_emote = list("states")
	gold_core_spawnable = HOSTILE_SPAWN
	del_on_death = TRUE
	deathmessage = "blows apart!"
	taunt_chance = 30
	blood_volume = 0

	emote_taunt_sound = list('sound/f13npc/handy/taunt1.ogg', 'sound/f13npc/handy/taunt2.ogg')
	emote_taunt = list("raises a saw")

	aggrosound = list('sound/f13npc/handy/aggro1.ogg', 'sound/f13npc/handy/aggro2.ogg')
	idlesound = list('sound/f13npc/handy/idle1.wav', 'sound/f13npc/handy/idle2.ogg', 'sound/f13npc/handy/idle3.ogg')

	death_sound = 'sound/f13npc/handy/robo_death.ogg'
	attack_sound = 'sound/f13npc/handy/attack.wav'

	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/item/stack/crafting/electronicparts/three)

/mob/living/simple_animal/hostile/handy/playable
	health = 300
	maxHealth = 300
	attack_verb_simple = "shoots a burst of flame at"
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	wander = FALSE
	force_threshold = 10
	anchored = FALSE
	del_on_death = FALSE
	dextrous = TRUE
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)
	ranged = FALSE

/mob/living/simple_animal/hostile/handy/Initialize()
	. = ..()
	add_overlay("eyes-[initial(icon_state)]")

/mob/living/simple_animal/hostile/handy/nsb //NSB + Raider Bunker specific
	name = "mr.handy"
	aggro_vision_range = 15
	faction = list("raider")
	obj_damage = 300

/mob/living/simple_animal/hostile/handy/gutsy
	name = "mr. gutsy"
	desc = "A pre-war combat robot based off the Mr. Handy design, armed with plasma weaponry and a deadly close-range flamer."
	icon_state = "gutsy"
	icon_living = "gutsy"
	icon_dead = "robot_dead"
	health = 200
	maxHealth = 200
	melee_damage_lower = 72
	melee_damage_upper = 72
	attack_sound = 'sound/items/welder.ogg'
	attack_verb_simple = "shoots a burst of flame at"
	projectilesound = 'sound/weapons/laser.ogg'
	projectiletype = /obj/item/projectile/f13plasma/scatter
	extra_projectiles = 2
	ranged = TRUE
	retreat_distance = 2
	minimum_distance = 2
	check_friendly_fire = TRUE
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/item/stack/crafting/electronicparts/three, /obj/item/stock_parts/cell/ammo/mfc)

	emote_taunt_sound = list('sound/f13npc/gutsy/taunt1.ogg', 'sound/f13npc/gutsy/taunt2.ogg', 'sound/f13npc/gutsy/taunt3.ogg', 'sound/f13npc/gutsy/taunt4.ogg')
	emote_taunt = list("raises a flamer")

	aggrosound = list('sound/f13npc/gutsy/aggro1.ogg', 'sound/f13npc/gutsy/aggro2.ogg', 'sound/f13npc/gutsy/aggro3.ogg', 'sound/f13npc/gutsy/aggro4.ogg', 'sound/f13npc/gutsy/aggro5.ogg', 'sound/f13npc/gutsy/aggro6.ogg')
	idlesound = list('sound/f13npc/gutsy/idle1.ogg', 'sound/f13npc/gutsy/idle2.ogg', 'sound/f13npc/gutsy/idle3.ogg')

/mob/living/simple_animal/hostile/handy/gutsy/playable
	health = 340
	maxHealth = 340
	speed = 1
	attack_verb_simple = "shoots a burst of flame at"
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	environment_smash = 2 //can break lockers, but not walls
	wander = FALSE
	force_threshold = 10
	anchored = FALSE
	del_on_death = FALSE
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)
	dextrous = TRUE
	ranged = FALSE

/mob/living/simple_animal/hostile/handy/gutsy/nsb //NSB + Raider Bunker specific
	name = "mr. gutsy"
	aggro_vision_range = 15
	faction = list("raider")
	obj_damage = 300

/mob/living/simple_animal/hostile/handy/liberator
	name = "liberator"
	desc = "A small pre-War droned used by the People's Liberation Army."
	icon_state = "liberator"
	icon_living = "leberator"
	icon_dead = "liberator_d"
	icon_gib = "liberator_g"
	health = 80
	maxHealth = 80
	melee_damage_lower = 5
	melee_damage_upper = 10
	attack_verb_simple = "slaps"
	attack_sound = 'sound/weapons/punch1.ogg'
	projectilesound = 'sound/weapons/laser.ogg'
	projectiletype = /obj/item/projectile/beam/laser/pistol
	extra_projectiles = 1
	ranged = TRUE
	retreat_distance = 2
	minimum_distance = 2
	check_friendly_fire = TRUE
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/item/stack/crafting/electronicparts/three, /obj/item/stock_parts/cell/ammo/mfc)
	emote_taunt_sound = null
	emote_taunt = list("levels its laser")
	aggrosound = null
	idlesound = null
	death_sound = null
	attack_sound = null

/mob/living/simple_animal/hostile/handy/liberator/yellow
	name = "liberator"
	desc = "A small pre-War droned used by the People's Liberation Army."
	icon_state = "liberator_y"
	icon_living = "leberator_y"
	icon_dead = "liberator_y_d"

/mob/living/simple_animal/hostile/handy/robobrain
	name = "robobrain"
	desc = "A next-gen cybor developed by General Atomic International"
	icon = 'icons/fallout/mobs/robots/wasterobots.dmi'
	icon_state = "robobrain"
	icon_living = "robobrain"
	icon_dead = "robobrain_d"
	health = 180
	maxHealth = 180
	melee_damage_lower = 30
	melee_damage_upper = 45
	attack_verb_simple = "slaps"
	attack_sound = 'sound/weapons/punch1.ogg'
	projectilesound = 'sound/weapons/laser.ogg'
	projectiletype = /obj/item/projectile/beam/laser
	extra_projectiles = 1
	ranged = TRUE
	retreat_distance = 2
	minimum_distance = 2
	check_friendly_fire = TRUE
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/item/stack/crafting/electronicparts/three, /obj/item/stock_parts/cell/ammo/mfc)
	emote_taunt_sound = null
	emote_taunt = list("levels its laser")
	aggrosound = null
	idlesound = null
	death_sound = null
	attack_sound = null

/mob/living/simple_animal/hostile/handy/robobrain/AttackingTarget()
	. = ..()

/mob/living/simple_animal/hostile/handy/robobrain/nsb //NSB + Raider Bunker specific
	name = "robobrain"
	aggro_vision_range = 15
	faction = list("raider")
	obj_damage = 300
	health = 300
	maxHealth = 300

/mob/living/simple_animal/hostile/handy/protectron
	name = "protectron"
	desc = "A pre-war security robot armed with deadly lasers."
	icon = 'icons/fallout/mobs/robots/protectrons.dmi'
	icon_state = "protectron"
	icon_living = "protectron"
	icon_dead = "protectron_dead"
	health = 130
	maxHealth = 130
	speed = 4
	melee_damage_lower = 5 //severely reduced melee damage here because its silly to have a ranged mob also be a cqc master
	melee_damage_upper = 10
	extra_projectiles = 0 //removed extra projectiles to make these easier to deal with on super lowpop
	stat_attack = CONSCIOUS
	ranged = TRUE
	retreat_distance = 2
	minimum_distance = 2
	attack_verb_simple = "slaps"
	attack_sound = 'sound/weapons/punch1.ogg'
	projectilesound = 'sound/weapons/laser.ogg'
	projectiletype = /obj/item/projectile/beam/laser/pistol
	faction = list("wastebot")
	check_friendly_fire = TRUE
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/item/stack/crafting/electronicparts/five)

	emote_taunt_sound = list('sound/f13npc/protectron/taunt1.ogg', 'sound/f13npc/protectron/taunt2.ogg', 'sound/f13npc/protectron/taunt3.ogg')
	emote_taunt = list("raises a laser")

	aggrosound = list('sound/f13npc/protectron/aggro1.ogg', 'sound/f13npc/protectron/aggro2.ogg', 'sound/f13npc/protectron/aggro3.ogg', 'sound/f13npc/protectron/aggro4.ogg')
	idlesound = list('sound/f13npc/protectron/idle1.ogg', 'sound/f13npc/protectron/idle2.ogg', 'sound/f13npc/protectron/idle3.ogg', 'sound/f13npc/protectron/idle4.ogg',)

/mob/living/simple_animal/hostile/handy/protectron/playable
	ranged = FALSE
	melee_damage_lower = 35
	melee_damage_upper = 45
	health = 400
	maxHealth = 400
	speed = 2
	attack_verb_simple = "clamps"
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	environment_smash = 1 //can break lockers, but not walls
	wander = FALSE
	force_threshold = 10
	anchored = FALSE
	del_on_death = FALSE
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)

/mob/living/simple_animal/hostile/handy/protectron/nsb //NSB + Raider Bunker specific
	name = "protectron"
	aggro_vision_range = 15
	faction = list("raider")
	obj_damage = 300

/mob/living/simple_animal/pet/dog/protectron //Not an actual dog
	name = "Trading Protectron"
	desc = "A standard RobCo RX2 V1.16.4 \"Trade-o-Vend\", loaded with Trade protocols.<br>Looks like it was kept operational for an indefinite period of time. Its body is covered in cracks and dents of various sizes.<br>As it has been repaired countless times, it's amazing the machine is still functioning at all."
	icon = 'icons/fallout/mobs/robots/protectrons.dmi'
	icon_state = "protectron_trade"
	icon_living = "protectron_trade"
	icon_dead = "protectron_trade_dead"
	maxHealth = 200
	health = 200
	speak_chance = 5
	mob_biotypes = MOB_ROBOTIC|MOB_INORGANIC
	faction = list("neutral", "silicon", "dog", "hostile", "pirate", "wastebot", "wolf", "plants", "turret", "enclave", "ghoul", "cazador", "supermutant", "gecko", "slime", "radscorpion", "skeleton", "carp", "bs", "bighorner")
	speak = list("Howdy partner! How about you spend some of them there hard earned caps on some of this fine merchandise.", "Welcome back partner! Hoo-wee it's a good day to buy some personal protection!", "Stop, this is a robbery! At these prices you are robbing me.", "Legion? NCR? Raider? Hell we don't care, as long as you got the caps.", "What a fine day partner. A fine day indeed.", "Reminds me of what my grandpappy used to say, make a snap decision now and never question it. You look like you could use some product there partner.", "Lotta critters out there want to chew you up partner, you could use a little hand with that now couldn't you?")
	speak_emote = list()
	emote_hear = list()
	emote_see = list()
	response_help_simple  = "shakes its manipulator"
	response_disarm_simple = "pushes"
	response_harm_simple   = "punches"
	attack_sound = 'sound/voice/liveagain.ogg'
	butcher_results = list(/obj/effect/gibspawner/robot = 1)
	blood_volume = 0

/mob/living/simple_animal/hostile/handy/assaultron
	name = "assaultron"
	desc = "A deadly close combat robot developed by RobCo in a vaguely feminine, yet ominous chassis."
	icon_state = "assaultron"
	icon_living = "assaultron"
	gender = FEMALE //Pffffffffffffffffffffff
	icon_dead = "gib7"
	health = 200
	mob_biotypes = MOB_ROBOTIC|MOB_INORGANIC
	maxHealth = 200
	speed = 0
	melee_damage_lower = 55
	melee_damage_upper = 60
	environment_smash = 2 //can smash walls
	attack_verb_simple = "grinds their claws on"
	faction = list("wastebot")
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/item/stack/crafting/electronicparts/three, /obj/item/stock_parts/cell/ammo/mfc)

	emote_taunt_sound = FALSE
	emote_taunt = FALSE

	aggrosound = FALSE
	idlesound = FALSE

/mob/living/simple_animal/hostile/handy/assaultron/nsb //NSB + Raider Bunker specific.
	name = "assaultron"
	aggro_vision_range = 15
	faction = list("raider")
	obj_damage = 300

/mob/living/simple_animal/hostile/handy/assaultron/playable
	see_in_dark = 8
	force_threshold = 15
	wander = 0
	anchored = FALSE
	del_on_death = FALSE
	possible_a_intents = list(INTENT_HELP, INTENT_HARM, INTENT_GRAB, INTENT_DISARM)
	dextrous = TRUE
	deathmessage = "abruptly shuts down, falling to the ground!"

/mob/living/simple_animal/hostile/handy/assaultron/playable/medical
	name = "SA-S-E"
	desc = "An Assaultron modified for the Medical field, SA-S-E forgoes the weaponry and deadliness of her military countarparts to save lives. Painted white with blue highlights, and a blue cross on the front of her visor, this robot comes equipped with what looks like modified medical gear. Her head has no eye-laser, instead a gently pulsing blue eye that scans people the analyze their health, a defibrilator on her back, and articulated hands to be able to use the myriad medical tools strapped to parts of her body under protective cases all show this model is meant to save lives. She's stockier than other Assaultrons due to all the added gear, and her legs seem much thicker than normal due to reinforced servos and gears."
	icon_state = "assaultron_sase"
	icon_dead = "assaultron_sase_dead"

//Junkers
/mob/living/simple_animal/hostile/handy/gutsy/flamer
	name = "Mr. Burnsy"
	desc = "A modified mr. gutsy, equipped with a more precise flamer, ditching it's plasma weaponry."
	color = "#B85C00"
	projectilesound = 'sound/magic/fireball.ogg'
	projectiletype = /obj/item/projectile/bullet/incendiary/shotgun
	extra_projectiles = 1

/mob/living/simple_animal/hostile/handy/assaultron/laser
	name = "red eye assaultron"
	desc = "A modified assaultron. It's eye has been outfitted with a deadly laser."
	color = "#B85C00"
	ranged = TRUE
	retreat_distance = null
	minimum_distance = 1
	projectilesound = 'sound/weapons/laser.ogg'
	projectiletype = /obj/item/projectile/beam/laser/lasgun
