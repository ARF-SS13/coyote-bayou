////////////////////
// RENEGADE MERCS //
////////////////////


// LIGHT MELEE VARIANT
/mob/living/simple_animal/hostile/renegade
	name = "Renegade Prospect"
	desc = "A raider recently inducted among the Renegades."
	icon = 'modular_sunset/icons/mob/renegades/renegade.dmi'
	icon_state = "renegade_prospect"
	icon_living = "renegade_prospect"
	icon_dead = "renegade_prospect-dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	turns_per_move = 5
	mob_armor = ARMOR_VALUE_RENEGADE_COMBAT_ARMOR
	maxHealth = 100
	health = 100
	healable = 1
	speed = 1.2
	obj_damage = 150
	melee_damage_lower = 25
	melee_damage_upper = 40
	attack_verb_simple = "smacks"
	attack_sound = 'sound/weapons/smash.ogg'
	a_intent = INTENT_HARM
	faction = list("raider")
	check_friendly_fire = TRUE
	status_flags = CANPUSH
	del_on_death = FALSE
	waddle_amount = 5
	waddle_up_time = 1
	waddle_side_time = 1
	retreat_health_percent = 0.5
	max_heal_amount = 0.9
	heal_per_life = 0.115
	tactical_retreat = 30
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon, /obj/effect/gibspawner/human)
	loot_drop_amount = 2
	loot_amount_random = TRUE

/mob/living/simple_animal/hostile/renegade/Aggro()
	..()
	summon_backup(10)
	say("Target spotted!")


// LIGHT RANGED VARIANT
/mob/living/simple_animal/hostile/renegade/grunt
	name = "Renegade Grunt"
	desc = "The standard issue muscle employed among the Renegades."
	icon_state = "renegade_grunt"
	icon_living = "renegade_grunt"
	icon_dead = "renegade_grunt-dead"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RENEGADE_COMBAT_ARMOR
	maxHealth = 100
	health = 100
	healable = 1
	check_friendly_fire = 1
	retreat_distance = 6
	minimum_distance = 2
	extra_projectiles = 2
	ranged_cooldown_time = 2 SECONDS
	sight_shoot_delay_time = 0.2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/c10mm/simple
	projectilesound = 'sound/f13weapons/10mm_fire_01.ogg'
	loot = list(/obj/item/gun/ballistic/automatic/pistol/m1911, /obj/effect/gibspawner/human)
	robust_searching = TRUE
	speak = list(
		"Come get some!",
		"Fuck off!",
		"Landon's going to promote me after this!",
		"Bullets for days!",
		"Renegades represent!"
		)
	speak_emote = list("says")
	speak_chance = 1
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_MEDIUM_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_MEDIUM_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_MEDIUM_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_MEDIUM_RANGE_DISTANT)
		speed = 10 // added to make his dumbass hold still - Jaeger
	)

// LIGHT RANGED EMP VARIANT
/mob/living/simple_animal/hostile/renegade/grunt/emp
	name = "Renegade Grunt"
	desc = "The standard issue muscle employed among the Renegades."
	icon_state = "renegade_emper"
	icon_living = "renegade_emper"
	icon_dead = "renegade_prospect-dead"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RENEGADE_COMBAT_ARMOR
	maxHealth = 100
	health = 100
	healable = 1
	check_friendly_fire = 1
	retreat_distance = 6
	minimum_distance = 3
	extra_projectiles = 0
	ranged_cooldown_time = 2 SECONDS
	sight_shoot_delay_time = 0.2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/ion/renegade
	projectilesound = 'sound/f13weapons/pulsepistolfire.ogg'
	robust_searching = TRUE
	speak = list(
		"Come get some!",
		"Fuck off!",
		"Landon's going to promote me after this!",
		"Bullets for days!",
		"Renegades represent!"
		)
	speak_emote = list("says")
	speak_chance = 1
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_MEDIUM_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_MEDIUM_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_MEDIUM_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_MEDIUM_RANGE_DISTANT)
	)
	speed = 10 // added to make his dumbass hold still - Jaeger

// LIGHT SHOTGUN VARIANT
/mob/living/simple_animal/hostile/renegade/engie
	name = "Renegade Engie"
	desc = "Demolitions and engineering expert of the Renegades."
	icon_state = "renegade_engie"
	icon_living = "renegade_engie"
	icon_dead = "renegade_engie-dead"
	mob_armor = ARMOR_VALUE_RENEGADE_COMBAT_ARMOR
	maxHealth = 100
	health = 100
	healable = 1
	speed = 1.2
	ranged = 1
	check_friendly_fire = 1
	obj_damage = 200
	retreat_distance = 4
	minimum_distance = 1
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectilesound = 'sound/f13weapons/shotgun.ogg'
	casingtype = /obj/item/ammo_casing/shotgun
	robust_searching = TRUE
	speak = list(
		"Come get some!",
		"Going to blow some shit to kingdom come!",
		"I got the goods!",
		"Nades for days!",
		"Renegades represent!"
		)
	speak_emote = list("says")
	speak_chance = 1
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

// MEDIUM RANGED VARIANT
/mob/living/simple_animal/hostile/renegade/soldier
	name = "Renegade Soldier"
	desc = "The beefier side of the Renegade's muscle; with combat experience to back it."
	icon_state = "renegade_soldier"
	icon_living = "renegade_soldier"
	icon_dead = "renegade_soldier-dead"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RENEGADE_COMBAT_ARMOR_REINFORCED
	maxHealth = 100
	health = 100
	healable = 1
	speed = 1.1
	check_friendly_fire = 1
	retreat_distance = 7
	minimum_distance = 3
	extra_projectiles = 2
	sight_shoot_delay_time = 0.2 SECONDS
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/c10mm/simple
	projectilesound = 'sound/f13weapons/combatrifle.ogg'
	robust_searching = TRUE
	speak = list(
		"Come get some!",
		"I like my odds, c'mere!",
		"Gonna get a promotion after this!",
		"Bullets for days!",
		"Renegades represent!"
		)
	speak_emote = list("says")
	speak_chance = 1
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_MEDIUM_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_MEDIUM_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_MEDIUM_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_MEDIUM_RANGE_DISTANT)
	)
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon, /obj/effect/gibspawner/human)
	loot_drop_amount = 3
	loot_amount_random = TRUE
	speed = 10 // added to make his dumbass hold still - Jaeger

//MEDIUM MELEE VARIANT
/mob/living/simple_animal/hostile/renegade/defender
	name = "Renegade Defender"
	desc = "The Renegade member who's sole purpose is to withstand punishment with layers of advanced combat armor."
	icon_state = "renegade_defender"
	icon_living = "renegade_defender"
	icon_dead = "renegade_defender-dead"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RENEGADE_COMBAT_ARMOR_SUPER
	maxHealth = 130
	health = 130
	healable = 1
	speed = 1
	check_friendly_fire = 1
	melee_damage_lower = 30
	melee_damage_upper = 40
	attack_verb_simple = "bashes"
	attack_sound = 'sound/weapons/slam.ogg'
	a_intent = INTENT_HARM
	emote_taunt = list("bashes their shield with the mace")
	robust_searching = TRUE
	speak = list(
		"COME AND TRY ME, BITCH!",
		"I AM THE WALL!",
		"LAYERS ON LAYERS OF PLATES!",
		"I AM TITANIUM!",
		"RENEGADES REPRESENT!"
		)
	speak_emote = list("says")
	speak_chance = 1
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon, /obj/effect/gibspawner/human)
	loot_drop_amount = 3
	loot_amount_random = TRUE

//HEAVY RANGED VARIANT
/mob/living/simple_animal/hostile/renegade/drifter
	name = "Renegade Drifter"
	desc = "A veteran of the Renegades, specializing in recon and long range engagements."
	icon_state = "renegade_drifter"
	icon_living = "renegade_drifter"
	icon_dead = "renegade_drifter-dead"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RENEGADE_SNIPER_ARMOR
	maxHealth = 100
	health = 100
	healable = 1
	speed = 1.3
	vision_range = 12
	aggro_vision_range = 15
	check_friendly_fire = 1
	retreat_distance = 10
	minimum_distance = 6
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/a308/improvised
	projectilesound = 'sound/f13weapons/bozar_fire.ogg'
	loot = list(
		/obj/item/stack/f13Cash/random/high,
		/obj/item/gun/ballistic/rifle/hunting,
		/obj/effect/spawner/lootdrop/f13/uncommon_armor,
		/obj/effect/gibspawner/human
		)
	robust_searching = TRUE
	speak = list(
		"Come get some!",
		"I am the shadow!",
		"One shot, one kill.",
		"Adjusting my scope.",
		"Renegades represent!"
		)
	speak_emote = list("says")
	speak_chance = 1
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(RIFLE_MEDIUM_VOLUME),
		SP_VOLUME_SILENCED(RIFLE_MEDIUM_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(RIFLE_MEDIUM_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(RIFLE_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(RIFLE_MEDIUM_RANGE_DISTANT)
	)
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon, /obj/effect/gibspawner/human)
	loot_drop_amount = 2
	loot_amount_random = TRUE
	speed = 10 // added to make his dumbass hold still - Jaeger

// HEAVY SHOTGUN VARIANT
/mob/living/simple_animal/hostile/renegade/guardian
	name = "Renegade Guardian"
	desc = "A veteran of the Renegades,specializing in close quarters and crowd control.. with an automatic shotgun."
	icon_state = "renegade_guardian"
	icon_living = "renegade_guardian"
	icon_dead = "renegade_guardian-dead"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RENEGADE_COMBAT_ARMOR_SUPER
	maxHealth = 150
	health = 150
	healable = 1
	speed = 1
	check_friendly_fire = 1
	minimum_distance = 2
	ranged_cooldown_time = 3
	projectiletype = null
	projectilesound = 'sound/f13weapons/auto5.ogg'
	casingtype = /obj/item/ammo_casing/shotgun/buckshot
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon, /obj/effect/gibspawner/human)
	loot_drop_amount = 5
	loot_amount_random = TRUE
	robust_searching = TRUE
	speak = list(
		"Come get some!",
		"ON THE GROUND!",
		"GOING TO SHOVE THIS WHERE THE SUN DON'T SHINE!",
		"C'MERE, I GOT LEAD!",
		"RENEGADES REPRESENT!"
		)
	speak_emote = list("says")
	speak_chance = 1
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
	speed = 10 // added to make his dumbass hold still - Jaeger

// POWER ARMOR VARIANT
/mob/living/simple_animal/hostile/renegade/meister
	name = "Renegade Meister"
	desc = "Is that a merc in power armor?!"
	icon_state = "renegade_meister"
	icon_living = "renegade_meister"
	icon_dead = "renegade_meister-dead"
	mob_armor = ARMOR_VALUE_RENEGADE_POWER_ARMOR
	vision_range = 12
	aggro_vision_range = 12
	maxHealth = 150
	health = 150
	bossmob = TRUE
	healable = 1
	melee_damage_lower = 50
	melee_damage_upper = 50
	retreat_distance = 3
	minimum_distance = 1
	ranged = 1
	sentience_type = SENTIENCE_BOSS
	attack_verb_simple = "power-fists"
	attack_sound = 'sound/weapons/slam.ogg'
	extra_projectiles = 5
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	sight_shoot_delay_time = 0 SECONDS // he's a boss after all
	projectiletype = /obj/item/projectile/bullet/m5mm/simple
	projectilesound = 'sound/f13weapons/automaticrifle_BAR.ogg'
	loot = list(/obj/effect/spawner/lootdrop/f13/rare, /obj/effect/gibspawner/human)
	loot_drop_amount = 8
	loot_amount_random = TRUE
	speak = list(
		"POWER TO THE ARMOR!",
		"I AM GOING TO BREAK YOU IN HALF!",
		"YEAH I COMPENSATE WITH BIG FUCKIN' GUNS",
		"DODGE THIS!",
		"PEAK RENEGADE PERFORMANCE!"
		)
	speak_emote = list("says")
	speak_chance = 1
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(RIFLE_LIGHT_VOLUME),
		SP_VOLUME_SILENCED(RIFLE_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(RIFLE_LIGHT_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(RIFLE_LIGHT_DISTANT_SOUND),
		SP_DISTANT_RANGE(RIFLE_LIGHT_RANGE_DISTANT)
	)
	speed = 10 // added to make his dumbass hold still - Jaeger

/mob/living/simple_animal/hostile/renegade/meister/movement_delay()
	return 6

// POWER ARMOR VARIANT 2.0
/mob/living/simple_animal/hostile/renegade/traitor //while good intentions were there for this mob, it's op. Nerfed it. - Blue
	name = "Brotherhood of Steel Traitor"
	desc = "A former Brotherhood of Steel Paladin, now turn coat for the Renegades. You imagine this is who is responsible for the siege."
	icon = 'icons/fallout/mobs/humans/ghouls.dmi'
	icon_state = "rebound_chosen"
	icon_living = "rebound_chosen"
	icon_dead = "mercenary_ghoul_dead"
	mob_armor = ARMOR_VALUE_RENEGADE_POWER_ARMOR
	maxHealth = 250
	health = 250
	healable = 1
	melee_damage_lower = 55
	melee_damage_upper = 60
	retreat_distance = 4
	minimum_distance = 2
	ranged = 1
	bossmob = TRUE
	sentience_type = SENTIENCE_BOSS
	attack_verb_simple = "power-fists"
	attack_sound = 'sound/weapons/slam.ogg'
	extra_projectiles = 3
	ranged_cooldown_time = 3 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	sight_shoot_delay_time = 0 SECONDS // he's a boss after all
	projectiletype = /obj/item/projectile/beam/laser/laer/hitscan
	projectilesound = 'sound/f13weapons/laerfire.ogg'
	loot = list(/obj/effect/spawner/lootdrop/f13/rare, /obj/effect/gibspawner/human)
	loot_drop_amount = 15
	loot_amount_random = TRUE
	speak = list(
		"Death to the Brotherhood!",
		"Loyalty doesn't feed my family's bellies!",
		"My benefactors send their regards!",
		"Let's see how fast you can really go!",
		"Leave, before you get hurt!"
		)
	speak_emote = list("says")
	speak_chance = 1
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(RIFLE_LIGHT_VOLUME),
		SP_VOLUME_SILENCED(RIFLE_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(RIFLE_LIGHT_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(RIFLE_LIGHT_DISTANT_SOUND),
		SP_DISTANT_RANGE(RIFLE_LIGHT_RANGE_DISTANT)
	)
	speed = 10 // added to make his dumbass hold still - Jaeger

/mob/living/simple_animal/hostile/renegade/meister/movement_delay()
	return 6

// HEALER VARIANT
/mob/living/simple_animal/hostile/renegade/doc
	name = "Renegade Doc"
	desc = "A veteran of the Renegades, this one specializing in field first aid."
	icon_state = "renegade_doc"
	icon_living = "renegade_doc"
	icon_dead = "renegade_doc-dead"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RENEGADE_COMBAT_ARMOR
	maxHealth = 150
	health = 150
	healable = 1
	check_friendly_fire = 1
	retreat_distance = 6
	minimum_distance = 8
	sight_shoot_delay_time = 0.2 SECONDS
	ranged_cooldown_time = 1 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/m44/simple
	projectilesound = 'sound/f13weapons/44mag.ogg'
	robust_searching = TRUE
	speak = list(
		"Running low on meds.",
		"Could do with extra combat chems.",
		"Where'd I put the Syringer?",
		"I GOT THE MED-BAG!",
		"Renegades represent and all that jazz."
		)
	speak_emote = list("says")
	speak_chance = 1
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon, /obj/effect/gibspawner/human)
	loot_drop_amount = 3
	loot_amount_random = TRUE
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_HEAVY_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_HEAVY_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_HEAVY_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_HEAVY_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_HEAVY_RANGE_DISTANT)
	)
	speed = 10 // added to make his dumbass hold still - Jaeger

/mob/living/simple_animal/hostile/renegade/doc/Initialize(mapload)
	. = ..()
	// we only heal BRUTELOSS because each type directly heals a simplemob's health
	// therefore setting it to BRUTELOSS | FIRELOSS | TOXLOSS | OXYLOSS would mean healing 4x as much
	// aka 40% of max life every tick, which is basically unkillable
	// TODO: refactor this if simple_animals ever get damage types
	AddComponent(/datum/component/glow_heal, chosen_targets = /mob/living/simple_animal/hostile/renegade, allow_revival = FALSE, restrict_faction = list("raider"), type_healing = BRUTELOSS)
