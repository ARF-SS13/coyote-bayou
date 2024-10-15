/* IN THIS FILE:
-Securitron
-Sentry Bot
*/

//Securitron  TV Head jackass
/mob/living/simple_animal/hostile/securitron
	name = "securitron"
	desc = "A Pre-Fall type of securitron.<br>Extremely dangerous machine."
	icon = 'icons/fallout/mobs/robots/wasterobots.dmi'
	icon_state = "securitron"
	icon_living = "securitron"
	icon_dead = "securitron_dead"
	mob_armor = ARMOR_VALUE_ROBOT_SECURITY
	maxHealth = 100
	health = 100
	stamcrit_threshold = SIMPLEMOB_NO_STAMCRIT
	emp_flags = list(
		MOB_EMP_STUN,
		MOB_EMP_BERSERK,
		MOB_EMP_DAMAGE,
		MOB_EMP_SCRAMBLE
		)
	speak_chance = 1
	turns_per_move = 5
	environment_smash = 0
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	robust_searching = TRUE
	blood_volume = 0
	bombs_can_gib_me = FALSE
	// del_on_death = TRUE
	healable = FALSE
	faction = list("wastebot")
	mob_biotypes = MOB_ROBOTIC|MOB_INORGANIC
	move_to_delay = 5.0
	// m2d 3 = standard, less is fast, more is slower.

	retreat_distance = 2
	//how far they pull back

	minimum_distance = 5
	// how close you can get before they try to pull back

	aggro_vision_range = 7
	//tiles within they start attacking, doesn't count the mobs tile

	vision_range = 8
	//tiles within they start making noise, does count the mobs tile

	emote_hear = list("Beeps.")
	//speak = list("Stop Right There Criminal.")
	harm_intent_damage = 8
	melee_damage_lower = 5
	melee_damage_upper = 10
	extra_projectiles = 1
	auto_fire_delay = GUN_AUTOFIRE_DELAY_SLOW
	ranged_ignores_vision = TRUE
	attack_verb_simple = "punches"
	attack_sound = "punch"
	a_intent = "harm"
	projectiletype = /obj/item/projectile/bullet/c9mm/simple
	projectilesound = 'sound/f13weapons/varmint_rifle.ogg'
	emote_taunt = list("readies its arm gun")
	check_friendly_fire = TRUE
	ranged = TRUE
	move_resist = MOVE_FORCE_OVERPOWERING
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_LIGHT_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_LIGHT_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_LIGHT_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_LIGHT_RANGE_DISTANT)
	)
	loot = list(/obj/effect/spawner/lootdrop/f13/common, /obj/effect/gibspawner/ipc/bodypartless)
	loot_drop_amount = 1
	loot_amount_random = TRUE
	var/explodes_on_death = FALSE
	var/ex_devastate = 1
	var/ex_heavy = 2
	var/ex_light = 4
	var/ex_flash = 4
	var/ex_flames = 6

/mob/living/simple_animal/hostile/securitron/nsb //NSB + Raider Bunker specific
	name = "Securitron"
	faction = list("raider")
	obj_damage = 300
	retreat_distance = 0 //perish, mortal

/mob/living/simple_animal/hostile/securitron/bullet_act(obj/item/projectile/Proj)
	if(!Proj)
		CRASH("[src] securitron invoked bullet_act() without a projectile")
	if(prob(5) && health > 1)
		var/flashbang_turf = get_turf(src)
		if(!flashbang_turf)
			return
		var/obj/item/grenade/S
		switch(rand(1,10))
			if(1)
				S = new /obj/item/grenade/flashbang/sentry(flashbang_turf)
			if(2)
				S = new /obj/item/grenade/stingbang(flashbang_turf)
			if(3 to 10)
				S = new /obj/item/grenade/smokebomb(flashbang_turf)
		visible_message(span_danger("\The [src] releases a defensive [S]!"))
		S.preprime(user = null)
	..()

/mob/living/simple_animal/hostile/securitron/proc/do_death_beep()
	playsound(src, 'sound/machines/triple_beep.ogg', 75, FALSE)
	visible_message(span_warning("You hear an ominous beep coming from [src]!"), span_warning("You hear an ominous beep!"))

/mob/living/simple_animal/hostile/securitron/proc/self_destruct()
	explosion(
		get_turf(src),
		ex_devastate,
		ex_heavy,
		ex_light,
		ex_flash,
		flame_range = ex_flames
		)

/mob/living/simple_animal/hostile/securitron/ex_act(severity, target, origin)
	. = ..()
	

/mob/living/simple_animal/hostile/securitron/death()
	do_sparks(3, TRUE, src)
	if(explodes_on_death)
		for(var/i in 1 to 3)
			addtimer(CALLBACK(src,PROC_REF(do_death_beep)), i * 1 SECONDS)
		addtimer(CALLBACK(src,PROC_REF(self_destruct)), 4 SECONDS)
	return ..()

/mob/living/simple_animal/hostile/securitron/Aggro()
	. = ..()
	summon_backup(15)

//Sentry Bot
/mob/living/simple_animal/hostile/securitron/sentrybot
	name = "sentry bot"
	desc = "A Pre-Fall military robot armed with a deadly gatling laser and covered in thick armor plating."
	icon_state = "sentrybot"
	icon_living = "sentrybot"
	icon_dead = "sentrybot_dead"
	mob_armor = ARMOR_VALUE_ROBOT_SECURITY
	maxHealth = 150
	health = 150
	del_on_death = FALSE
	melee_damage_lower = 24
	melee_damage_upper = 55
	extra_projectiles = 2 
	ranged_cooldown_time = 40 //brrrrrrrrrrrrt
	retreat_distance = 5
	minimum_distance = 5 // SENTRY bot, not run up to your face and magdump you bot
	attack_verb_simple = "pulverizes"
	attack_sound = 'sound/weapons/punch1.ogg'
	projectilesound = 'sound/weapons/laser.ogg'
	projectiletype = /obj/item/projectile/beam/laser/pistol/wastebot
	emote_taunt_sound = list(
		'sound/f13npc/sentry/taunt1.ogg',
		'sound/f13npc/sentry/taunt2.ogg',
		'sound/f13npc/sentry/taunt3.ogg',
		'sound/f13npc/sentry/taunt4.ogg',
		'sound/f13npc/sentry/taunt5.ogg',
		'sound/f13npc/sentry/taunt6.ogg'
		)
	emote_taunt = list("spins its barrels")
	emote_taunt_sound = list(
		'sound/f13npc/sentry/aggro1.ogg',
		'sound/f13npc/sentry/aggro2.ogg',
		'sound/f13npc/sentry/aggro3.ogg',
		'sound/f13npc/sentry/aggro4.ogg',
		'sound/f13npc/sentry/aggro5.ogg'
		)
	idlesound = list(
		'sound/f13npc/sentry/idle1.ogg',
		'sound/f13npc/sentry/idle2.ogg',
		'sound/f13npc/sentry/idle3.ogg',
		'sound/f13npc/sentry/idle4.ogg'
		)
	var/warned = FALSE
	explodes_on_death = TRUE

	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(LASER_VOLUME),
		SP_VOLUME_SILENCED(LASER_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(LASER_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(LASER_DISTANT_SOUND),
		SP_DISTANT_RANGE(LASER_RANGE_DISTANT)
	)
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon,
		/obj/effect/decal/cleanable/robot_debris,
		/obj/item/stack/crafting/electronicparts/five,
		/obj/item/stock_parts/cell/ammo/mfc/recycled,
		/obj/effect/gibspawner/ipc/bodypartless)
	loot_drop_amount = 3
	loot_amount_random = TRUE

/mob/living/simple_animal/hostile/securitron/sentrybot/Life()
	..()
	if (!warned)
		if (health <= 50)
			warned = TRUE
			playsound(src, 'sound/f13npc/sentry/systemfailure.ogg', 75, FALSE)

// Lil chew-chew
/mob/living/simple_animal/hostile/securitron/sentrybot/chew
	name = "lil' chew-chew"
	desc = "An oddly scorched Pre-Fall military robot armed with a deadly gatling laser and covered in thick, oddly blue armor plating, the name Lil' Chew-Chew scratched onto it's front armour crudely, highlighted by small bits of white paint. There seems to be an odd pack on the monstrosity of a sentrie's back, a chute at the bottom of it - there's the most scorch-marks on the robot here, so it's safe to assume this robot is capable of explosions. Better watch out!"
	extra_projectiles = 6
	health = 1000
	maxHealth = 1000 //CHONK
	obj_damage = 300
	retreat_distance = 0
	environment_smash = ENVIRONMENT_SMASH_RWALLS //wall-obliterator. perish.
	color = "#75FFE2"
	aggro_vision_range = 15
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1 //cannot self-harm with it's explosion spam
	loot = list(/obj/effect/spawner/lootdrop/f13/rare, /obj/effect/gibspawner/ipc/bodypartless)
	loot_drop_amount = 10
	loot_amount_random = TRUE

/mob/living/simple_animal/hostile/securitron/sentrybot/chew/bullet_act(obj/item/projectile/Proj)
	if(!Proj)
		CRASH("[src] sentrybot invoked bullet_act() without a projectile")
	if(prob(10) && health > 1)
		visible_message(span_danger("\The [src] releases a defensive explosive!"))
		explosion(get_turf(src),-1,-1,2, flame_range = 4) //perish, mortal - explosion size identical to craftable IED
	..()

//Raider friendly Sentry bot
/mob/living/simple_animal/hostile/securitron/sentrybot/nsb
	name = "sentry bot"
	obj_damage = 300

//Raider friendly Sentry bot with non-lethals
/mob/living/simple_animal/hostile/securitron/sentrybot/nsb/riot //NSB + Raider Bunker specific.
	name = "riot-control sentry bot"
	desc = "A Pre-Fall military robot armed with a modified breacher shotgun and covered in thick armor plating."
	projectilesound = 'sound/f13weapons/riot_shotgun.ogg'
	projectiletype = /obj/item/projectile/bullet/shotgun_beanbag
	retreat_distance = 0
	extra_projectiles = 0
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(SHOTGUN_VOLUME),
		SP_VOLUME_SILENCED(SHOTGUN_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(SHOTGUN_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(SHOTGUN_DISTANT_SOUND),
		SP_DISTANT_RANGE(SHOTGUN_RANGE_DISTANT)
	)

//Playable Sentrybot
/mob/living/simple_animal/hostile/securitron/sentrybot/playable
	health = 50   //El Beef
	maxHealth = 50
	speed = 1
	attack_verb_simple = "clamps"
	emote_taunt_sound = null
	emote_taunt = null
	emote_taunt_sound = null
	idlesound = null
	ranged = FALSE
	see_in_dark = 8
	environment_smash = 2 //can smash walls
	wander = 0
	force_threshold = 15

/mob/living/simple_animal/hostile/securitron/sentrybot/playable/death()
	return ..()

//Junkers
/mob/living/simple_animal/hostile/securitron/sentrybot/self_destruct
	name = "explosive sentry bot"
	desc = "A Pre-Fall military robot armed with a deadly gatling laser and covered in thick armor plating. Don't get too close to this one, it looks like it's rigged to blow!"
	maxHealth = 160
	health = 160
	color = "#B85C00"
	retreat_distance = null
	minimum_distance = 1

/mob/living/simple_animal/hostile/securitron/sentrybot/self_destruct/AttackingTarget()
	addtimer(CALLBACK(src,PROC_REF(do_death_beep)), 1 SECONDS)
	addtimer(CALLBACK(src,PROC_REF(self_destruct)), 2 SECONDS)
