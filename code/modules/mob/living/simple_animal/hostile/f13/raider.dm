// IN THIS FILE: -All Raider Mobs

///////////////////
// BASIC RAIDERS //
///////////////////

// BASIC MELEE RAIDER
/mob/living/simple_animal/hostile/raider
	name = "Raider"
	desc = "Another murderer churned out by the wastes."
	icon = 'icons/fallout/mobs/humans/raider.dmi'
	icon_state = "raider_melee"
	icon_living = "raider_melee"
	icon_dead = "raider_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	turns_per_move = 5
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 80
	health = 80
	melee_damage_lower = 5
	melee_damage_upper = 14
	attack_verb_simple = "clobbers"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	a_intent = INTENT_HARM
	faction = list("raider")
	check_friendly_fire = TRUE
	status_flags = CANPUSH
	del_on_death = FALSE
	/// slots in a list of trash loot
	var/random_trash_loot = TRUE
	footstep_type = FOOTSTEP_MOB_SHOE
	rapid_melee = 2
	melee_queue_distance = 5
	move_to_delay = 3.1
	waddle_amount = 2
	waddle_up_time = 1
	waddle_side_time = 1
	retreat_distance = 0 //mob retreats 1 tile when in min distance
	minimum_distance = 0 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	variation_list = list(
		MOB_NAME_FROM_GLOBAL_LIST(\
			MOB_RANDOM_NAME(MOB_NAME_RANDOM_MALE, 1)\
		))
	retreat_health_percent = 0.1
	max_heal_amount = 0.9
	heal_per_life = 0.115
	tactical_retreat = 30
	loot = list(/obj/effect/spawner/lootdrop/f13/common)
	loot_drop_amount = 2
	loot_amount_random = TRUE

/mob/living/simple_animal/hostile/raider/Initialize() // I dont, but, you can
	. = ..()
	if(random_trash_loot)
		loot = GLOB.trash_ammo + GLOB.trash_chem + GLOB.trash_clothing + GLOB.trash_craft + GLOB.trash_gun + GLOB.trash_misc + GLOB.trash_money + GLOB.trash_mob + GLOB.trash_part + GLOB.trash_tool

/obj/effect/mob_spawn/human/corpse/raider
	name = "Raider"
	uniform = /obj/item/clothing/under/f13/rag
	suit = /obj/item/clothing/suit/armor/medium/raider/iconoclast
	shoes = /obj/item/clothing/shoes/f13/explorer
	gloves = /obj/item/clothing/gloves/f13/leather
	head = /obj/item/clothing/head/helmet/f13/firefighter

// THIEF RAIDER - nabs stuff and runs
/mob/living/simple_animal/hostile/raider/thief
	desc = "Another murderer churned out by the wastes. This one looks like they have sticky fingers..."

/mob/living/simple_animal/hostile/raider/thief/movement_delay()
	return -2

/mob/living/simple_animal/hostile/raider/thief/AttackingTarget()
	var/atom/my_target = get_target()
	if(!ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	if(H.stat < SOFT_CRIT)
		return ..()
	var/back_target = H.back
	if(back_target)
		H.dropItemToGround(back_target, TRUE)
		src.transferItemToLoc(back_target, src, TRUE)
	var/belt_target = H.belt
	if(belt_target)
		H.dropItemToGround(belt_target, TRUE)
		src.transferItemToLoc(belt_target, src, TRUE)
	var/shoe_target = H.shoes
	if(shoe_target)
		H.dropItemToGround(shoe_target, TRUE)
		src.transferItemToLoc(shoe_target, src, TRUE)
	retreat_distance = 50


/mob/living/simple_animal/hostile/raider/thief/death(gibbed)
	for(var/obj/I in contents)
		src.dropItemToGround(I)
	. = ..()

// BASIC RANGED RAIDER
/mob/living/simple_animal/hostile/raider/ranged
	icon_state = "raider_ranged"
	icon_living = "raider_ranged"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 80
	health = 80
	rapid_melee = 2
	melee_queue_distance = 5
	move_to_delay = 2.8 //faster than average, but not a lot
	retreat_distance = 1 //mob retreats 1 tile when in min distance
	minimum_distance = 1 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	speed = 4.5
	projectiletype = /obj/item/projectile/bullet/c9mm/simple
	projectilesound = 'sound/f13weapons/ninemil.ogg'
	loot = list(/obj/item/stack/f13Cash/random/med)
	loot_drop_amount = 3
	footstep_type = FOOTSTEP_MOB_SHOE
	variation_list = list(
		MOB_NAME_FROM_GLOBAL_LIST(\
			MOB_RANDOM_NAME(MOB_NAME_RANDOM_FEMALE, 1)\
		))
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
	speed = 10 // added to make his dumbass hold still - Jaeger

// LEGENDARY MELEE RAIDER
/mob/living/simple_animal/hostile/raider/legendary
	name = "Legendary Raider"
	desc = "Another murderer churned out by the wastes - this one seems a bit faster than the average..."
	color = "#FFFF00"
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 300
	health = 300
	speed = 2
	obj_damage = 300
	rapid_melee = 1
	loot = list(/obj/item/melee/onehanded/knife/survival, /obj/item/reagent_containers/food/snacks/kebab/human, /obj/item/stack/f13Cash/random/high)
	loot_drop_amount = MOB_LOOT_ALL
	loot_amount_random = FALSE
	random_trash_loot = FALSE
	footstep_type = FOOTSTEP_MOB_SHOE
	loot = list(/obj/effect/spawner/lootdrop/f13/common, /obj/effect/spawner/lootdrop/f13/uncommon)
	loot_drop_amount = 2
	loot_amount_random = TRUE

// LEGENDARY RANGED RAIDER
/mob/living/simple_animal/hostile/raider/ranged/legendary
	name = "Legendary Raider"
	desc = "Another murderer churned out by the wastes, wielding a decent pistol and looking very strong"
	color = "#FFFF00"
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 240
	health = 240
	retreat_distance = 1
	minimum_distance = 2
	rapid_melee = 1
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	sight_shoot_delay_time = 0 SECONDS
	speed = 3.5
	projectiletype = /obj/item/projectile/bullet/m44/simple
	projectilesound = 'sound/f13weapons/44mag.ogg'
	extra_projectiles = 1
	obj_damage = 300
	loot = list(/obj/item/gun/ballistic/revolver/m29, /obj/item/stack/f13Cash/random/high)
	loot_drop_amount = MOB_LOOT_ALL
	loot_amount_random = FALSE
	random_trash_loot = FALSE
	footstep_type = FOOTSTEP_MOB_SHOE
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
	retreat_health_percent = 0.5
	max_heal_amount = 0.9
	heal_per_life = 0.115
	tactical_retreat = 30
	loot = list(/obj/effect/spawner/lootdrop/f13/common, /obj/effect/spawner/lootdrop/f13/uncommon)
	loot_drop_amount = 3
	loot_amount_random = TRUE

// RAIDER BOSS
/mob/living/simple_animal/hostile/raider/ranged/boss
	name = "Machinegun Martha"
	gender = FEMALE
	icon_state = "raiderboss"
	icon_living = "raiderboss"
	icon_dead = "raiderboss_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 150
	health = 150
	extra_projectiles = 2
	rapid_melee = 1
	waddle_amount = 4
	waddle_up_time = 2
	waddle_side_time = 1
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_FAST
	speed = 3.5
	projectiletype = /obj/item/projectile/bullet/c10mm/improvised/simple
	loot = list(/obj/item/gun/ballistic/automatic/smg/smg10mm, /obj/item/clothing/head/helmet/f13/combat/mk2/raider, /obj/effect/spawner/lootdrop/f13/armor/randomraiderchest, /obj/item/clothing/under/f13/ravenharness, /obj/item/stack/f13Cash/random/high)
	loot_drop_amount = MOB_LOOT_ALL
	loot_amount_random = FALSE
	random_trash_loot = FALSE
	footstep_type = FOOTSTEP_MOB_SHOE
	move_to_delay = 4.0 //faster than average, but not a lot
	retreat_distance = 4 //mob retreats 1 tile when in min distance
	minimum_distance = 2 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	despawns_when_lonely = FALSE
	important = TRUE
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
	retreat_health_percent = 0.5
	max_heal_amount = 0.9
	heal_per_life = 0.115
	tactical_retreat = 30
	loot = list(/obj/effect/spawner/lootdrop/f13/common, /obj/effect/spawner/lootdrop/f13/uncommon)
	loot_drop_amount = 5
	loot_amount_random = TRUE
	variation_list = list(
		MOB_RETREAT_DISTANCE_LIST(0, 1, 3, 4),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
		MOB_MINIMUM_DISTANCE_LIST(0, 2, 4),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(40),
	)

/mob/living/simple_animal/hostile/raider/ranged/boss/Aggro()
	. = ..()
	if(.)
		return
	summon_backup(15)
	if(!ckey)
		say("KILL 'EM, FELLAS!", only_overhead = TRUE)

/mob/living/simple_animal/hostile/raider/ranged/boss/mangomatt
	name = "Mango Mathew and his Merry Meth Madlads"
	desc = "Hi, Mango Mathew and his Merry Meth Madlads."
	icon_state = "mango_matt"
	icon_living = "mango_matt"
	icon_dead = "mango_matt_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 165
	health = 165
	extra_projectiles = 2
	ranged_cooldown_time = 1 SECONDS
	sight_shoot_delay_time = 0 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_FAST
	speak_emote = list(
		"growls",
		"murrs",
		"purrs",
		"mrowls",
		"yowls",
		"prowls"
		)
	// emote_see = list(
	// 	"laughs",
	// 	"nyas",
	// 	""
	// 	)
	attack_verb_simple = list(
		"claws",
		"maims",
		"bites",
		"mauls",
		"slashes",
		"thrashes",
		"bashes",
		"glomps",
		"beats their greasegun against the face of"
		)
	variation_list = list() // so he keeps his stupid name

/mob/living/simple_animal/hostile/raider/ranged/boss/mangomatt/Aggro()
	..()
	summon_backup(15)
	say(pick(\
		"*nya",\
		"*mrowl",\
		"*lynx",\
		"*cougar",\
		"*growl",\
		"*come",\
		"Fuck em' up!"\
		), only_overhead = TRUE)
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon, /obj/effect/spawner/lootdrop/f13/rare)
	loot_drop_amount = 10
	loot_amount_random = TRUE

/mob/living/simple_animal/hostile/raider/ranged/boss/blueberrybates
	name = "Blueberry Bates and his Bottom-Feeder Buys"
	desc = "Hello, Blueberry Bates and his Bottom-Feeder Buys. Has a shotgun with APDS incendiary slugs and is ready to fucking kill you."
	icon_state = "blueberry_bates"
	icon_living = "blueberry_bates"
	icon_dead = "blueberry_bates_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	move_to_delay = 4 //S L O W
	sight_shoot_delay_time = 0 SECONDS
	ranged_cooldown_time = 1 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/incendiary/shotgun
	projectilesound = 'sound/f13weapons/shotgun.ogg'
	maxHealth = 200 //bit beefier since his arena is significantly shittier for him and he's more of an annoyance
	health = 200
	extra_projectiles = 0
	retreat_distance = 3
	minimum_distance = 3
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon, /obj/effect/spawner/lootdrop/f13/rare)
	loot_drop_amount = 5
	loot_amount_random = TRUE
	speak_emote = list(
		"mutters",
		"counts his coins to himself",
		"yells at someone to pick up the pace",
		"barks",
		"grumbles",
		"grouches"
		)
	// emote_see = list(
	// 	"chitters",
	// 	"idly gnaws on a hat",
	// 	)
	attack_verb_simple = list(
		"bayonets",
		"smacks",
		"bites",
		"mauls",
		"slashes",
		"thrashes",
		"bashes",
		"glomps",
		"robusts on"
		)
	variation_list = list() // so he keeps his stupid name

/mob/living/simple_animal/hostile/raider/ranged/boss/blueberrybates/Aggro()
	..()
	summon_backup(15)
	say(pick(\
		"TO ME, BOYS!",\
		"KICK THEIR ASS!",\
		"Fuck 'em up!",\
		"*chitter",\
		"*kyaa",\
		"*come",\
		"YOU'RE ABOUT TO GET A DISCOUNT ON A GRAVE, BUDDY!",\
		), only_overhead = TRUE)

// RANGED RAIDER WITH ARMOR
/mob/living/simple_animal/hostile/raider/ranged/sulphiteranged
	icon_state = "metal_raider"
	icon_living = "metal_raider"
	icon_dead = "metal_raider_dead"
	mob_armor = ARMOR_VALUE_RAIDER_METAL_ARMOR
	maxHealth = 60
	health = 60
	rapid_melee = 1
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	speed = 4.5
	projectiletype = /obj/item/projectile/bullet/c45/simple
	projectilesound = 'sound/weapons/gunshot.ogg'
	loot = list(/obj/item/gun/ballistic/automatic/pistol/m1911/custom, /obj/item/clothing/suit/armor/heavy/metal/reinforced, /obj/item/clothing/head/helmet/f13/metalmask/mk2, /obj/item/stack/f13Cash/random/med)
	loot_drop_amount = 5
	footstep_type = FOOTSTEP_MOB_SHOE
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
	loot = list(/obj/effect/spawner/lootdrop/f13/common)
	loot_drop_amount = 2
	loot_amount_random = TRUE

// FIREFIGHTER RAIDER
/mob/living/simple_animal/hostile/raider/firefighter
	icon_state = "firefighter_raider"
	icon_living = "firefighter_raider"
	icon_dead = "firefighter_raider_dead"
	mob_armor = ARMOR_VALUE_RAIDER_ARMOR
	maxHealth = 80
	health = 80
	loot = list(/obj/item/twohanded/fireaxe, /obj/item/stack/f13Cash/random/med)
	loot_drop_amount = 3
	footstep_type = FOOTSTEP_MOB_SHOE
	rapid_melee = 1
	loot = list(/obj/effect/spawner/lootdrop/f13/common)
	loot_drop_amount = 2
	loot_amount_random = TRUE

// BIKER RAIDER
/mob/living/simple_animal/hostile/raider/ranged/biker
	icon_state = "biker_raider"
	icon_living = "biker_raider"
	icon_dead = "biker_raider_dead"
	melee_damage_lower = 10
	melee_damage_upper = 20
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 125
	health = 125
	rapid_melee = 1
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	speed = 4.5
	retreat_distance = 2 //retreat this far
	minimum_distance = 3 //if within this distance
	projectiletype = /obj/item/projectile/bullet/a308/improvised/simple
	projectilesound = 'sound/f13weapons/magnum_fire.ogg'
	loot = list(/obj/item/gun/ballistic/revolver/thatgun, /obj/item/clothing/suit/armor/medium/combat/rusted, /obj/item/clothing/head/helmet/f13/raidercombathelmet, /obj/item/stack/f13Cash/random/med)
	loot_drop_amount = 5
	footstep_type = FOOTSTEP_MOB_SHOE
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
	loot = list(/obj/effect/spawner/lootdrop/f13/common)
	loot_drop_amount = 2
	loot_amount_random = TRUE

/obj/effect/mob_spawn/human/corpse/raider/ranged/biker
	uniform = /obj/item/clothing/under/f13/ncrcf
	suit = /obj/item/clothing/suit/armor/medium/combat/rusted
	shoes = /obj/item/clothing/shoes/f13/explorer
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	head = /obj/item/clothing/head/helmet/f13/raidercombathelmet
	neck = /obj/item/clothing/neck/mantle/brown
	

// YANKEE RAIDER

/mob/living/simple_animal/hostile/raider/baseball
	icon_state = "baseball_raider"
	icon_living = "baseball_raider"
	icon_dead = "baseball_raider_dead"
	retreat_distance = 0
	minimum_distance = 0
	melee_damage_lower = 15
	melee_damage_upper = 33
	mob_armor = ARMOR_VALUE_RAIDER_ARMOR
	maxHealth = 125
	health = 125
	rapid_melee = 1
	loot = list(/obj/item/twohanded/baseball, /obj/item/stack/f13Cash/random/med)
	loot_drop_amount = 3
	footstep_type = FOOTSTEP_MOB_SHOE
	loot = list(/obj/effect/spawner/lootdrop/f13/common)
	loot_drop_amount = 2
	loot_amount_random = TRUE


/obj/effect/mob_spawn/human/corpse/raider/baseball
	uniform = /obj/item/clothing/under/f13/mechanic
	suit = /obj/item/clothing/suit/armor/medium/raider/yankee
	shoes = /obj/item/clothing/shoes/f13/explorer
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	head = /obj/item/clothing/head/helmet/f13/raider/yankee

// TRIBAL RAIDER

/mob/living/simple_animal/hostile/raider/tribal
	icon_state = "tribal_raider"
	icon_living = "tribal_raider"
	icon_dead = "tribal_raider_dead"
	mob_armor = ARMOR_VALUE_RAIDER_ARMOR
	maxHealth = 125
	health = 125
	melee_damage_lower = 12
	melee_damage_upper = 37
	loot = list(/obj/item/twohanded/spear)
	loot_drop_amount = 3
	footstep_type = FOOTSTEP_MOB_SHOE
	rapid_melee = 1
	loot = list(/obj/effect/spawner/lootdrop/f13/common)
	loot_drop_amount = 2
	loot_amount_random = TRUE

/obj/effect/mob_spawn/human/corpse/raider/tribal
	uniform = /obj/item/clothing/under/f13/raiderrags
	suit = /obj/item/clothing/suit/armor/light/tribal
	shoes = /obj/item/clothing/shoes/f13/rag
	mask = /obj/item/clothing/mask/facewrap
	head = /obj/item/clothing/head/helmet/f13/fiend

//////////////
// SULPHITE //
//////////////

/mob/living/simple_animal/hostile/raider/sulphite
	name = "Sulphite Brawler"
	desc = "A raider with low military grade armor and a shishkebab"
	icon_state = "sulphite"
	icon_living = "sulphite"
	icon_dead= "sulphite_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 135
	health = 135
	rapid_melee = 1
	melee_damage_lower = 15
	melee_damage_upper = 37
	loot = list(/obj/item/stack/f13Cash/random/med)
	loot_drop_amount = 5
	footstep_type = FOOTSTEP_MOB_SHOE

/////////////
// JUNKERS //
/////////////

/mob/living/simple_animal/hostile/raider/junker
	name = "Junker"
	desc = "A raider from the Junker gang."
	faction = list("raider", "wastebot")
	icon_state = "junker_hijacker"
	icon_living = "junker_hijacker"
	icon_dead = "junker_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 150
	health = 150
	rapid_melee = 1
	melee_damage_lower = 18
	melee_damage_upper = 42
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/raider/ranged/boss/junker
	name = "Junker Footman"
	desc = "A Junker raider, outfitted in reinforced combat raider armor with extra metal plates."
	icon_state = "junker_scrapper"
	icon_living = "junker_scrapper"
	icon_dead = "junker_dead"
	faction = list("raider", "wastebot")
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 165
	health = 165
	damage_coeff = list(BRUTE = 1, BURN = 0.75, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	rapid_melee = 1
	melee_damage_lower = 20
	melee_damage_upper = 38
	footstep_type = FOOTSTEP_MOB_SHOE
	loot_drop_amount = 5

/mob/living/simple_animal/hostile/raider/junker/creator
	name = "Junker Field Creator"
	desc = "A Junker raider, specialized in spitting out eyebots on the fly with any scrap they can find."
	icon_state = "junker"
	icon_living = "junker"
	icon_dead = "junker_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 150
	health = 150
	ranged = TRUE
	retreat_distance = 6
	minimum_distance = 8
	rapid_melee = 1
	speed = 4.5
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/c45/improvised
	projectilesound = 'sound/weapons/gunshot.ogg'
	var/list/spawned_mobs = list()
	var/max_mobs = 3
	var/mob_types = list(/mob/living/simple_animal/hostile/eyebot/reinforced)
	var/spawn_time = 15 SECONDS
	//var/spawn_text = "flies from"
	footstep_type = FOOTSTEP_MOB_SHOE
	loot_drop_amount = 5


/mob/living/simple_animal/hostile/raider/junker/creator/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner, mob_types, spawn_time, faction, /*spawn_text,*/ max_mobs, _range = 7)

/mob/living/simple_animal/hostile/raider/junker/creator/death()
	RemoveComponentByType(/datum/component/spawner)
	. = ..()

/mob/living/simple_animal/hostile/raider/junker/creator/Destroy()
	RemoveComponentByType(/datum/component/spawner)
	. = ..()

/mob/living/simple_animal/hostile/raider/junker/creator/Aggro()
	. = ..()
	if(.)
		return
	summon_backup(10)

/mob/living/simple_animal/hostile/raider/junker/boss
	name = "Junker Boss"
	desc = "A Junker boss, clad in hotrod power armor, and wielding a deadly rapid-fire shrapnel cannon."
	icon_state = "junker_boss"
	icon_living = "junker_boss"
	icon_dead = "junker_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 165
	health = 165
	ranged = TRUE
	rapid_melee = 1
	retreat_distance = 4
	minimum_distance = 6
	extra_projectiles = 2
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/shrapnel/simple
	projectilesound = 'sound/f13weapons/auto5.ogg'
	loot = list(/obj/item/stack/f13Cash/random/high)
	footstep_type = FOOTSTEP_MOB_SHOE
	loot_drop_amount = 10
	loot_amount_random = FALSE


// Cultist Stuff

/mob/living/simple_animal/hostile/raider/cultist/melee
	name = "Cultist Shredder"
	desc = "A nightmare in a robe. Now with 100% less conversion!"
	icon = 'icons/fallout/mobs/humans/raider.dmi'
	icon_state = "cult_axeghoul"
	icon_living = "cult_axeghoul"
	icon_dead = "cult_axeghoul_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	turns_per_move = 5
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 80
	health = 80
	melee_damage_lower = 10
	melee_damage_upper = 24
	attack_verb_simple = "clobbers"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	a_intent = INTENT_HARM
	faction = list("raider", "hostile")
	check_friendly_fire = TRUE
	status_flags = CANPUSH
	del_on_death = FALSE
	loot = list(/obj/item/melee/onehanded/knife/survival, /obj/item/stack/f13Cash/random/med)
	loot_drop_amount = 2
	footstep_type = FOOTSTEP_MOB_SHOE
	rapid_melee = 2
	melee_queue_distance = 5
	move_to_delay = 1.5
	waddle_amount = 2
	waddle_up_time = 1
	waddle_side_time = 1
	retreat_distance = 0 //mob retreats 1 tile when in min distance
	minimum_distance = 0 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.

/mob/living/simple_animal/hostile/raider/cultist/ranged
	name = "Cultist Gunner"
	desc = "A nightmare in a robe. Now with 100% less conversion!"
	icon = 'icons/fallout/mobs/humans/raider.dmi'
	icon_state = "cultist_pistol"
	icon_living = "cultist_pistol"
	icon_dead = "cultist_pistol_dead"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	faction = list("raider", "hostile")
	maxHealth = 85
	health = 85
	rapid_melee = 2
	melee_queue_distance = 5
	move_to_delay = 2.8 //faster than average, but not a lot
	retreat_distance = 4 //mob retreats 1 tile when in min distance
	minimum_distance = 2 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/c10mm/simple
	projectilesound = 'sound/f13weapons/ninemil.ogg'
	loot = list(/obj/item/gun/ballistic/automatic/pistol/n99, /obj/item/stack/f13Cash/random/med)
	loot_drop_amount = 3
	footstep_type = FOOTSTEP_MOB_SHOE
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

/mob/living/simple_animal/hostile/raider/cultist/ranged/shotgun
	name = "Cultist Crowd Controller"
	desc = "A nightmare in a robe. Now with 100% less conversion!"
	icon = 'icons/fallout/mobs/humans/raider.dmi'
	icon_state = "cultist_shotgun"
	icon_living = "cultist_shotgun"
	icon_dead = "cultist_shotgun_dead"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 80
	health = 80
	rapid_melee = 2
	melee_queue_distance = 5
	move_to_delay = 2.8 //faster than average, but not a lot
	retreat_distance = 4 //mob retreats 1 tile when in min distance
	minimum_distance = 2 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	ranged_cooldown_time = 4 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_SLOW
	projectiletype = /obj/item/projectile/bullet/pellet/shotgun_buckshot
	projectilesound = 'sound/f13weapons/shotgun.ogg'
	sound_after_shooting = 'sound/weapons/shotguninsert.ogg'
	extra_projectiles = 1
	loot = list(/obj/item/gun/ballistic/shotgun/trench, /obj/item/stack/f13Cash/random/med)
	loot_drop_amount = 6
	footstep_type = FOOTSTEP_MOB_SHOE
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

/mob/living/simple_animal/hostile/raider/cultist/ranged/smg
	name = "Cultist Bulletmage"
	desc = "A nightmare in a robe. Now with 100% less conversion!"
	icon = 'icons/fallout/mobs/humans/raider.dmi'
	icon_state = "cultist2_smg"
	icon_living = "cultist2_smg"
	icon_dead = "cultist2_smg_dead"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 80
	health = 80
	rapid_melee = 2
	melee_queue_distance = 5
	move_to_delay = 2.8 //faster than average, but not a lot
	retreat_distance = 4 //mob retreats 1 tile when in min distance
	minimum_distance = 2 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	ranged_cooldown_time = 1 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_FAST
	projectiletype = /obj/item/projectile/bullet/c22
	projectilesound = 'sound/f13weapons/assaultrifle_fire.ogg'
	sound_after_shooting = 'sound/weapons/shotguninsert.ogg'
	extra_projectiles = 2
	loot = list(/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22, /obj/item/stack/f13Cash/random/med)
	loot_drop_amount = 8
	footstep_type = FOOTSTEP_MOB_SHOE
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

/mob/living/simple_animal/hostile/raider/cultist/ranged/tesla
	name = "Cultist Lasermage"
	desc = "A nightmare in a robe. Now with 100% less conversion!"
	icon = 'icons/fallout/mobs/humans/raider.dmi'
	icon_state = "cultist3_tesla"
	icon_living = "cultist3_tesla"
	icon_dead = "cultist3_tesla_dead"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 150
	health = 150
	rapid_melee = 2
	melee_queue_distance = 5
	move_to_delay = 2.8 //faster than average, but not a lot
	retreat_distance = 4 //mob retreats 1 tile when in min distance
	minimum_distance = 2 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_FAST
	projectiletype = /obj/item/projectile/energy/teslacannon/oasis
	projectilesound = 'sound/weapons/resonator_fire.ogg'
	sound_after_shooting = 'sound/f13weapons/rcwfire.ogg'
	extra_projectiles = 2
	loot = list(/obj/item/gun/energy/laser/auto/oasis, /obj/item/stack/f13Cash/random/high)
	loot_drop_amount = 8
	footstep_type = FOOTSTEP_MOB_SHOE
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

/mob/living/simple_animal/hostile/raider/cultist/ranged/radiation
	name = "Cultist Converter"
	desc = "A nightmare in a robe. Now with 69% more conversion!"
	icon = 'icons/fallout/mobs/humans/raider.dmi'
	icon_state = "cultist3_tesla"
	icon_living = "cultist3_tesla"
	icon_dead = "cultist3_tesla_dead"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 150
	health = 150
	rapid_melee = 2
	melee_queue_distance = 5
	move_to_delay = 2.8 //faster than average, but not a lot
	retreat_distance = 4 //mob retreats 1 tile when in min distance
	minimum_distance = 2 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_FAST
	projectiletype = /obj/item/projectile/energy/nuclear_particle/cultist
	projectilesound = 'sound/weapons/resonator_fire.ogg'
	sound_after_shooting = 'sound/f13weapons/rcwfire.ogg'
	extra_projectiles = 1
	loot = list(/obj/item/gun/energy/gammagun, /obj/item/stack/f13Cash/random/high)
	loot_drop_amount = 10
	footstep_type = FOOTSTEP_MOB_SHOE
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
