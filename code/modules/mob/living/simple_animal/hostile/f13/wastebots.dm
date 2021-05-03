/mob/living/simple_animal/hostile/handy
	name = "mr. handy"
	desc = "A crazed pre-war household assistant robot, armed with a cutting saw."
	icon = 'icons/mob/robots.dmi'
	icon_state = "handy"
	icon_living = "handy"
	icon_dead = "gib7"
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC|MOB_INORGANIC
	move_resist = MOVE_FORCE_OVERPOWERING //unpullable
	health = 160
	maxHealth = 160
	healable = 0
	speed = 1
	melee_damage_lower = 28 //halved this on req
	melee_damage_upper = 28 //as above
	robust_searching = 1
	attack_verb_simple = "saws"
	faction = list("wastebot")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	speak_emote = list("states")
	gold_core_spawnable = HOSTILE_SPAWN
	del_on_death = 1
	deathmessage = "blows apart!"
	var/isrobot = 1
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/item/stack/crafting/electronicparts/three)
	taunt_chance = 30
	blood_volume = 0

	emote_taunt_sound = list('sound/f13npc/handy/taunt1.ogg', 'sound/f13npc/handy/taunt2.ogg')
	emote_taunt = list("raises a saw")

	aggrosound = list('sound/f13npc/handy/aggro1.ogg', 'sound/f13npc/handy/aggro2.ogg')
	idlesound = list('sound/f13npc/handy/idle1.wav', 'sound/f13npc/handy/idle2.ogg', 'sound/f13npc/handy/idle3.ogg')

	death_sound = 'sound/f13npc/handy/robo_death.ogg'
	attack_sound = 'sound/f13npc/handy/attack.wav'

	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)

/mob/living/simple_animal/hostile/handy/playable
	ranged = FALSE
	health = 300
	maxHealth = 300
	attack_verb_simple = "shoots a burst of flame at"
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	environment_smash = 1
	wander = 0
	force_threshold = 10
	anchored = FALSE
	del_on_death = FALSE
	dextrous = TRUE
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)

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
	icon_dead = "gib7"
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
	ranged = FALSE
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
	wander = 0
	force_threshold = 10
	anchored = FALSE
	del_on_death = FALSE
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)
	dextrous = TRUE

/mob/living/simple_animal/hostile/handy/gutsy/AttackingTarget()
	. = ..()

/mob/living/simple_animal/hostile/handy/gutsy/nsb //NSB + Raider Bunker specific
	name = "mr. gutsy"
	aggro_vision_range = 15
	faction = list("raider")
	obj_damage = 300

/mob/living/simple_animal/hostile/handy/securitron
	name = "Securitron"
	desc = "A private security robot created and mass-produced by the H&H Tools Factory"
	icon_state = "Securitron"
	icon_living = "Securitron"
	icon_dead = "gib7"
	health = 250
	maxHealth = 250
	melee_damage_lower = 40
	melee_damage_upper = 50
	attack_sound = 'sound/weapons/punch1.ogg'
	attack_verb_simple = "violently punches"
	projectilesound = 'sound/f13weapons/varmint_rifle.ogg'
	projectiletype = /obj/item/projectile/bullet/a556/ap/simple
	extra_projectiles = 3
	ranged = TRUE
	retreat_distance = 2
	minimum_distance = 2
	check_friendly_fire = TRUE
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/item/stack/crafting/electronicparts/three, /obj/item/stock_parts/cell/ammo/mfc)
	emote_taunt_sound = null
	emote_taunt = list("readies its arm gun")
	aggrosound = null
	idlesound = null
	death_sound = null
	attack_sound = null

/mob/living/simple_animal/hostile/handy/securitron/AttackingTarget()
	. = ..()

/mob/living/simple_animal/hostile/handy/securitron/nsb //NSB + Raider Bunker specific
	name = "Securitron"
	aggro_vision_range = 15
	faction = list("raider")
	obj_damage = 300
	retreat_distance = 0 //perish, mortal

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

/mob/living/simple_animal/hostile/handy/liberator_yellow
	name = "liberator"
	desc = "A small pre-War droned used by the People's Liberation Army."
	icon_state = "liberator_y"
	icon_living = "leberator_y"
	icon_dead = "liberator_y_d"
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

/mob/living/simple_animal/hostile/handy/liberator_yellow/AttackingTarget()
	. = ..()

/mob/living/simple_animal/hostile/handy/robobrain
	name = "robobrain"
	desc = "A next-gen cybor developed by General Atomic International"
	icon_state = "robobrain"
	icon_living = "robobrain"
	icon_dead = "robobrain_d"
	health = 200
	maxHealth = 200
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
	icon_state = "protectron"
	icon_living = "protectron"
	icon_dead = "protectron_dead"
	health = 160
	maxHealth = 160
	speed = 4
	melee_damage_lower = 5 //severely reduced melee damage here because its silly to have a ranged mob also be a cqc master
	melee_damage_upper = 10
	extra_projectiles = 0 //removed extra projectiles to make these easier to deal with on super lowpop
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
	wander = 0
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
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "protectron"
	icon_living = "protectron"
	icon_dead = "protectron_d"
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

/mob/living/simple_animal/hostile/handy/sentrybot
	name = "sentry bot"
	desc = "A pre-war military robot armed with a deadly gatling laser and covered in thick armor plating."
	icon_state = "sentrybot"
	icon_living = "sentrybot"
	icon_dead = "sentrybot"
	health = 280
	maxHealth = 280
	melee_damage_lower = 48
	melee_damage_upper = 72
	extra_projectiles = 4 //5 projectiles
	ranged_cooldown_time = 12 //brrrrrrrrrrrrt
	stat_attack = UNCONSCIOUS
	ranged = TRUE
	retreat_distance = 2
	minimum_distance = 2
	del_on_death = FALSE
	attack_verb_simple = "pulverizes"
	attack_sound = 'sound/weapons/punch1.ogg'
	projectilesound = 'sound/weapons/laser.ogg'
	projectiletype = /obj/item/projectile/beam/laser/pistol/ultraweak
	faction = list("wastebot")
	check_friendly_fire = TRUE
	loot = list(/obj/effect/decal/cleanable/robot_debris, /obj/item/stack/crafting/electronicparts/five, /obj/item/stock_parts/cell/ammo/mfc)
	var/warned = FALSE

	emote_taunt_sound = list('sound/f13npc/sentry/taunt1.ogg', 'sound/f13npc/sentry/taunt2.ogg', 'sound/f13npc/sentry/taunt3.ogg', 'sound/f13npc/sentry/taunt4.ogg', 'sound/f13npc/sentry/taunt5.ogg', 'sound/f13npc/sentry/taunt6.ogg')
	emote_taunt = list("spins its barrels")

	aggrosound = list('sound/f13npc/sentry/aggro1.ogg', 'sound/f13npc/sentry/aggro2.ogg', 'sound/f13npc/sentry/aggro3.ogg', 'sound/f13npc/sentry/aggro4.ogg', 'sound/f13npc/sentry/aggro5.ogg')
	idlesound = list('sound/f13npc/sentry/idle1.ogg', 'sound/f13npc/sentry/idle2.ogg', 'sound/f13npc/sentry/idle3.ogg', 'sound/f13npc/sentry/idle4.ogg')

/mob/living/simple_animal/hostile/handy/sentrybot/playable
	ranged = FALSE
	health = 750   //El Beef
	maxHealth = 750
	speed = 1
	attack_verb_simple = "clamps"
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	environment_smash = 2 //can smash walls
	wander = 0
	force_threshold = 15
	anchored = FALSE
	del_on_death = FALSE

/obj/item/projectile/beam/laser/pistol/ultraweak
	damage = 15 //quantity over quality

/mob/living/simple_animal/hostile/handy/sentrybot/bullet_act(obj/item/projectile/Proj)
	if(!Proj)
		CRASH("[src] sentrybot invoked bullet_act() without a projectile")
	if(prob(10) && health > 1)
		visible_message("<span class='danger'>\The [src] releases a defensive flashbang!</span>")
		var/flashbang_turf = get_turf(src)
		if(!flashbang_turf)
			return
		var/obj/item/grenade/flashbang/sentry/S = new /obj/item/grenade/flashbang/sentry(flashbang_turf)
		S.preprime(user = null)
	if(prob(75) || Proj.damage > 26) //prob(x) = chance for proj to actually do something, adjust depending on how OP you want sentrybots to be
		return ..()
	else
		visible_message("<span class='danger'>\The [Proj] bounces off \the [src]'s armor plating!</span>")
		return FALSE

/mob/living/simple_animal/hostile/handy/sentrybot/proc/do_death_beep()
	playsound(src, 'sound/machines/triple_beep.ogg', 75, TRUE)
	visible_message("<span class='warning'>You hear an ominous beep coming from [src]!</span>", "<span class='warning'>You hear an ominous beep!</span>")

/mob/living/simple_animal/hostile/handy/sentrybot/proc/self_destruct()
	explosion(src,1,2,4,4)
	qdel(src)

/mob/living/simple_animal/hostile/handy/sentrybot/Life()
	..()
	if (!warned)
		if (health <= 50)
			warned = TRUE
			playsound(src, 'sound/f13npc/sentry/systemfailure.ogg', 75, FALSE)

/mob/living/simple_animal/hostile/handy/sentrybot/death()
	do_sparks(3, TRUE, src)
	for(var/i in 1 to 3)
		addtimer(CALLBACK(src, .proc/do_death_beep), i * 1 SECONDS)
	addtimer(CALLBACK(src, .proc/self_destruct), 4 SECONDS)
	return ..()

/mob/living/simple_animal/hostile/handy/sentrybot/playable/death()
	return ..()

/mob/living/simple_animal/hostile/handy/sentrybot/chew
	name = "lil' chew-chew"
	desc = "A pre-war military robot armed with a deadly gatling laser and covered in thick, oddly blue armor plating, the name Lil' Chew-Chew scratched onto it's front armour."
	extra_projectiles = 6
	health = 1000
	maxHealth = 1000 //CHONK
	obj_damage = 300
	retreat_distance = 0
	environment_smash = 2 //wall-busts
	color = "#75FFE2"

/mob/living/simple_animal/hostile/handy/sentrybot/nsb //NSB + Raider Bunker specific.
	name = "sentry bot"
	aggro_vision_range = 15
	faction = list("raider")
	obj_damage = 300

/mob/living/simple_animal/hostile/handy/sentrybot/nsb/riot //NSB + Raider Bunker specific.
	name = "riot-control sentry bot"
	desc = "A pre-war military robot armed with a modified breacher shotgun and covered in thick armor plating."
	projectilesound = 'sound/f13weapons/riot_shotgun.ogg'
	projectiletype = /obj/item/projectile/bullet/shotgun_beanbag
	retreat_distance = 0
	environment_smash = 2 //wall-busts

/mob/living/simple_animal/hostile/handy/assaultron
	name = "assaultron"
	desc = "A deadly close combat robot developed by RobCo in a vaguely feminine, yet ominous chassis."
	icon_state = "assaultron"
	icon_living = "assaultron"
	gender = FEMALE //Pffffffffffffffffffffff
	icon_dead = "gib7"
	health = 450
	mob_biotypes = MOB_ROBOTIC|MOB_INORGANIC
	maxHealth = 450
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
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)
	dextrous = TRUE
