//basic gecko tribal. unarmed, and runs away if possible
/mob/living/simple_animal/hostile/gecko/tribal
	name = "gecko tribal"
	desc = "A large mutated reptile that has learned the basics of tool usage."
	icon = 'icons/fallout/mobs/animals/gecktribe.dmi'
	icon_state = "gekko_tribe_villager"
	icon_living = "gekko_tribe_villager"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 2,
		/obj/item/stack/sheet/animalhide/gecko = 1,
		/obj/item/clothing/under/f13/wayfarer = 1,
		/obj/item/stack/sheet/sinew = 1,)
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 0
	maxHealth = 35
	health = 35
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 4
	melee_damage_upper = 12
	move_to_delay = 1.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 8
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	pass_flags = PASSTABLE
	speak_emote = list(
		"squeaks",
		"cackles",
		"snickers",
		"shriek",
		"scream",
		"skrem",
		"scrambles",
		"warbles",
		"chirps",
		"cries",
		"kyaas",
		"chortles",
		"gecks"
		)
	//emote_see = list(
		// "screeches",
		// "licks its eyes",
		// "twitches",
		// "scratches its frills",
		// "gonks",
		// "honks",
		// "scronks",
		// "sniffs",
		// "gecks"
		// )
	attack_verb_simple = list(
		"bites",
		"claws",
		"tears at",
		"dabs",
		"scratches",
		"gnaws",
		"chews",
		"chomps",
		"lunges",
		"gecks"
		)
	faction = list("gecko", "critter-friend") // critter-friend is a flag for related beast friend/master quirk. Makes hostile mob passive for quirk holder.
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW
	idlesound = list(
		'sound/f13npc/gecko/geckocall1.ogg',
		'sound/f13npc/gecko/geckocall2.ogg',
		'sound/f13npc/gecko/geckocall3.ogg',
		'sound/f13npc/gecko/geckocall4.ogg',
		'sound/f13npc/gecko/geckocall5.ogg'
		)

	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = TRUE // not a bad idea at all
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"

	variation_list = list(
		MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255),
		MOB_SPEED_LIST(3, 3.2, 3.4, 3.6),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(30, 35, 40, 45),
		MOB_RETREAT_DISTANCE_LIST(3, 5, 7),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(2, 3, 4, 5, 6),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

//juvenile gecko tribal, to make you feel even worse about attacking the village
/mob/living/simple_animal/hostile/gecko/tribal/juvenile
	name = "gecko tribal juvenile"
	name = "gecko tribal juvenile"
	desc = "A small mutated reptile with sharp teeth."
	icon_state = "gekko_tribe_villager"
	icon_living = "gekko_tribe_villager"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 1,
		/obj/item/clothing/under/f13/wayfarer = 1,
		/obj/item/stack/sheet/bone = 1,
		/obj/item/stack/sheet/sinew = 1,)
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 0
	maxHealth = 15
	health = 15
	harm_intent_damage = 2
	obj_damage = 5
	melee_damage_lower = 1
	melee_damage_upper = 3
	move_to_delay = 1.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 4
	vision_range = 4


	faction = list("gecko", "critter-friend")
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW

	sound_pitch = 75
	vary_pitches = list(75, 100)
	emote_taunt = list("squeaks")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = FALSE
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"

	variation_list = list(
		MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255),
		MOB_SPEED_LIST(3, 3.2, 3.4, 3.6),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(10, 15, 20),
		MOB_RETREAT_DISTANCE_LIST(3, 5, 7),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(2, 3, 4, 5, 6),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
	)

/mob/living/simple_animal/hostile/gecko/tribal/juvenile/Initialize()
	.=..()
	resize = 0.5
	update_transform()


//gecko with a spear. will bravely defend its home
/mob/living/simple_animal/hostile/gecko/tribal/warrior
	name = "gecko warrior"
	desc = "A large mutated reptile that has learned the basics of tool usage. This one has a bone spear."
	icon_state = "gekko_tribe_warrior"
	icon_living = "gekko_tribe_warrior"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 2,
		/obj/item/stack/sheet/animalhide/gecko = 1,
		/obj/item/clothing/under/f13/wayfarer = 1,
		/obj/item/twohanded/spear/bonespear = 1,
		/obj/item/stack/sheet/bone = 1,
		/obj/item/stack/sheet/sinew = 1,)
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 0
	maxHealth = 35
	health = 35
	harm_intent_damage = 20
	obj_damage = 20
	melee_damage_lower = 16
	melee_damage_upper = 24
	move_to_delay = 1.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 8
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	pass_flags = PASSTABLE
	speak_emote = list(
		"squeaks",
		"cackles",
		"snickers",
		"shriek",
		"scream",
		"skrem",
		"scrambles",
		"warbles",
		"chirps",
		"cries",
		"kyaas",
		"chortles",
		"gecks"
		)
	//emote_see = list(
		// "screeches",
		// "licks its eyes",
		// "twitches",
		// "scratches its frills",
		// "gonks",
		// "honks",
		// "scronks",
		// "sniffs",
		// "gecks"
		// )
	attack_verb_simple = list(
		"bites",
		"claws",
		"tears at",
		"dabs",
		"scratches",
		"gnaws",
		"chews",
		"chomps",
		"lunges",
		"gecks"
		)
	faction = list("gecko", "critter-friend") // critter-friend is a flag for related beast friend/master quirk. Makes hostile mob passive for quirk holder.
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW
	idlesound = list(
		'sound/f13npc/gecko/geckocall1.ogg',
		'sound/f13npc/gecko/geckocall2.ogg',
		'sound/f13npc/gecko/geckocall3.ogg',
		'sound/f13npc/gecko/geckocall4.ogg',
		'sound/f13npc/gecko/geckocall5.ogg'
		)

	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = TRUE
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"

	variation_list = list(
		MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255),
		MOB_SPEED_LIST(3, 3.2, 3.4, 3.6),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(30, 35, 40, 45),
		MOB_RETREAT_DISTANCE_LIST(0, 1, 3, 5, 7, 9),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 4, 6),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

//gecko with a bow. will bravely defend its home
/mob/living/simple_animal/hostile/gecko/tribal/hunter // oh I love that game!
	name = "gecko hunter"
	desc = "A large mutated reptile that has learned the basics of tool usage. This one has a bone spear."
	icon_state = "gekko_tribe_bowman"
	icon_living = "gekko_tribe_bowman"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 2,
		/obj/item/stack/sheet/animalhide/gecko = 1,
		/obj/item/clothing/under/f13/wayfarer = 1,
		/obj/item/gun/ballistic/bow/shortbow = 1,
		/obj/item/storage/bag/tribe_quiver/light/full = 1,
		/obj/item/stack/sheet/bone = 1,
		/obj/item/stack/sheet/sinew = 1,)
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 0
	maxHealth = 35
	health = 35
	harm_intent_damage = 20
	obj_damage = 20
	melee_damage_lower = 16
	melee_damage_upper = 24
	move_to_delay = 1.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 8
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	pass_flags = PASSTABLE
	speak_emote = list(
		"squeaks",
		"cackles",
		"snickers",
		"shriek",
		"scream",
		"skrem",
		"scrambles",
		"warbles",
		"chirps",
		"cries",
		"kyaas",
		"chortles",
		"gecks"
		)
	//emote_see = list(
		// "screeches",
		// "licks its eyes",
		// "twitches",
		// "scratches its frills",
		// "gonks",
		// "honks",
		// "scronks",
		// "sniffs",
		// "gecks"
		// )
	attack_verb_simple = list(
		"bites",
		"claws",
		"tears at",
		"dabs",
		"scratches",
		"gnaws",
		"chews",
		"chomps",
		"lunges",
		"gecks"
		)
	faction = list("gecko", "critter-friend") // critter-friend is a flag for related beast friend/master quirk. Makes hostile mob passive for quirk holder.
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW
	ranged = TRUE
	check_friendly_fire = TRUE
	projectiletype = /obj/item/projectile/geckoarrow
	projectilesound = 'sound/weapons/bowfire.wav'
	idlesound = list(
		'sound/f13npc/gecko/geckocall1.ogg',
		'sound/f13npc/gecko/geckocall2.ogg',
		'sound/f13npc/gecko/geckocall3.ogg',
		'sound/f13npc/gecko/geckocall4.ogg',
		'sound/f13npc/gecko/geckocall5.ogg'
		)

	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = TRUE
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"

	variation_list = list(
		MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255),
		MOB_SPEED_LIST(3, 3.2, 3.4, 3.6),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(30, 35, 40, 45),
		MOB_RETREAT_DISTANCE_LIST(0, 1, 3, 5, 7, 9),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(80),
		MOB_MINIMUM_DISTANCE_LIST(2, 4, 6),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

/obj/item/projectile/geckoarrow
	name = "gecko hunter arrow"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "arrow"
	range = 6
	damage = BULLET_DAMAGE_PISTOL_22
	stamina = BULLET_STAMINA_PISTOL_22
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_22

	wound_bonus = BULLET_WOUND_PISTOL_22
	bare_wound_bonus = BULLET_WOUND_PISTOL_22_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	
	pixels_per_second = BULLET_SPEED_ARROW
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

//gecko priest. only fights in self defense, but drops meds when killed, and heals nearby geckos
/mob/living/simple_animal/hostile/gecko/tribal/shaman
	name = "gecko shaman"
	desc = "A large mutated reptile that has learned the basics of tool usage. This one has pouches of herbs"
	icon_state = "gekko_tribe_shaman"
	icon_living = "gekko_tribe_shaman"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 2,
		/obj/item/stack/sheet/animalhide/gecko = 1,
		/obj/item/clothing/under/f13/tribe_shaman = 1,
		/obj/effect/spawner/lootdrop/f13/trash_medicine = 3,
		/obj/item/stack/sheet/bone = 1,
		/obj/item/stack/sheet/sinew = 1,)
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	peaceful = TRUE
	taunt_chance = 30
	speed = 0
	maxHealth = 35
	health = 35
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 4
	melee_damage_upper = 12
	move_to_delay = 1.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 8
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	pass_flags = PASSTABLE
	speak_emote = list(
		"squeaks",
		"cackles",
		"snickers",
		"shriek",
		"scream",
		"skrem",
		"scrambles",
		"warbles",
		"chirps",
		"cries",
		"kyaas",
		"chortles",
		"gecks"
		)
	//emote_see = list(
		// "screeches",
		// "licks its eyes",
		// "twitches",
		// "scratches its frills",
		// "gonks",
		// "honks",
		// "scronks",
		// "sniffs",
		// "gecks"
		// )
	attack_verb_simple = list(
		"bites",
		"claws",
		"tears at",
		"dabs",
		"scratches",
		"gnaws",
		"chews",
		"chomps",
		"lunges",
		"gecks"
		)
	faction = list("gecko", "critter-friend") // critter-friend is a flag for related beast friend/master quirk. Makes hostile mob passive for quirk holder.
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW
	ranged = TRUE
	check_friendly_fire = TRUE
	projectiletype = /obj/item/projectile/geckofire
	projectilesound = 'sound/magic/fireball.ogg'
	idlesound = list(
		'sound/f13npc/gecko/geckocall1.ogg',
		'sound/f13npc/gecko/geckocall2.ogg',
		'sound/f13npc/gecko/geckocall3.ogg',
		'sound/f13npc/gecko/geckocall4.ogg',
		'sound/f13npc/gecko/geckocall5.ogg'
		)

	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = TRUE
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"

	variation_list = list(
		MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255),
		MOB_SPEED_LIST(3, 3.2, 3.4, 3.6),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(30, 35, 40, 45),
		MOB_RETREAT_DISTANCE_LIST(3, 5, 7),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(2, 3, 4, 5, 6),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

/mob/living/simple_animal/hostile/gecko/tribal/shaman/Initialize(mapload)
	. = ..()
	// we only heal BRUTELOSS because each type directly heals a simplemob's health
	// therefore setting it to BRUTELOSS | FIRELOSS | TOXLOSS | OXYLOSS would mean healing 4x as much
	// aka 40% of max life every tick, which is basically unkillable
	// TODO: refactor this if simple_animals ever get damage types
	AddComponent(/datum/component/glow_heal, chosen_targets = /mob/living/simple_animal/hostile/gecko, allow_revival = FALSE, restrict_faction = null, type_healing = BRUTELOSS)

//gecko boss fight. is peaceful till provoked, then summons and ressurects geckos to fight you
/mob/living/simple_animal/hostile/gecko/tribal/head_shaman
	name = "gecko head shaman"
	desc = "A large mutated reptile that has learned the basics of tool usage. This one is dressed regally and wields a staff."
	icon_state = "gekko_tribe_shaman"
	icon_living = "gekko_tribe_shaman"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 4,
		/obj/item/stack/sheet/animalhide/gecko = 3,
		/obj/item/clothing/under/f13/wayfarer/shamanblue = 1,
		/obj/effect/spawner/lootdrop/f13/trash_medicine = 8,
		/obj/item/gun/ballistic/bow/compoundbow = 1,
		/obj/item/toy/plush/lizardplushie/kobold = 1,
		/obj/effect/spawner/lootdrop/f13/rare_melee = 1,
		/obj/item/stack/sheet/bone = 2,
		/obj/item/stack/sheet/sinew = 1,)
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	peaceful = TRUE
	taunt_chance = 30
	speed = 0
	maxHealth = 200
	health = 200
	mob_armor = ARMOR_VALUE_DEATHCLAW_COMMON
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 4
	melee_damage_upper = 12
	move_to_delay = 1.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 8
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	robust_searching = TRUE
	bossmob = TRUE
	speak_emote = list(
		"squeaks",
		"cackles",
		"snickers",
		"shriek",
		"scream",
		"skrem",
		"scrambles",
		"warbles",
		"chirps",
		"cries",
		"kyaas",
		"chortles",
		"gecks"
		)
	//emote_see = list(
		// "screeches",
		// "licks its eyes",
		// "twitches",
		// "scratches its frills",
		// "gonks",
		// "honks",
		// "scronks",
		// "sniffs",
		// "gecks"
		// )
	attack_verb_simple = list(
		"bites",
		"claws",
		"tears at",
		"dabs",
		"scratches",
		"gnaws",
		"chews",
		"chomps",
		"lunges",
		"gecks"
		)
	faction = list("gecko")
	a_intent = INTENT_HARM
	gold_core_spawnable = FALSE
	footstep_type = FOOTSTEP_MOB_HEAVY
	ranged = TRUE
	check_friendly_fire = TRUE
	move_resist = MOVE_FORCE_OVERPOWERING
	projectiletype = /obj/item/projectile/geckosummon
	projectilesound = 'sound/magic/Staff_Healing.ogg'
	can_glow_revive = FALSE
	idlesound = list(
		'sound/f13npc/gecko/geckocall1.ogg',
		'sound/f13npc/gecko/geckocall2.ogg',
		'sound/f13npc/gecko/geckocall3.ogg',
		'sound/f13npc/gecko/geckocall4.ogg',
		'sound/f13npc/gecko/geckocall5.ogg'
		)

	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = FALSE
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"

	variation_list = list(
		//MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255),
		MOB_SPEED_LIST(3, 3.2, 3.4, 3.6),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(200),
		MOB_RETREAT_DISTANCE_LIST(3, 5, 7),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(2, 3, 4, 5, 6),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

/mob/living/simple_animal/hostile/gecko/tribal/head_shaman/Initialize(mapload)
	. = ..()
	resize = 1.5
	update_transform()
	AddComponent(/datum/component/glow_heal, chosen_targets = /mob/living/simple_animal/hostile/gecko, allow_revival = TRUE, restrict_faction = null, type_healing = BRUTELOSS)

/obj/item/projectile/geckosummon
	name = "gecko summoning"
	icon_state = "spark"
	range = 10
	light_range = LIGHT_RANGE_FIRE
	light_color = LIGHT_COLOR_FIRE
	damage = 0
	stamina = 20
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0
	
	pixels_per_second = BULLET_SPEED_BASE
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

/obj/item/projectile/geckosummon/on_hit(atom/target, blocked = FALSE)
	..()
	//var/num_nearby = 0
	//for(var/mob/living/simple_animal/hostile/gecko/summon/G in range(7, src))
	//	if(num_nearby++ <= 10) //should this be <= dan?
	spawn_and_random_walk(/mob/living/simple_animal/hostile/gecko/summon, target, 5, walk_chance = 100, max_walk = 10, admin_spawn = FALSE)
	//		break
	return BULLET_ACT_HIT

/mob/living/simple_animal/hostile/gecko/tribal/chieftain
	name = "gecko chieftan"
	desc = "A large mutated reptile that has learned the basics of tool usage. This one is dressed regally and looks fierce."
	icon_state = "gekko_tribe_leader"
	icon_living = "gekko_tribe_leader"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 4,
		/obj/item/stack/sheet/animalhide/gecko = 3,
		/obj/item/stack/sheet/sinew = 1,
		/obj/item/clothing/under/f13/tribe_chief = 1,
		/obj/item/restraints/legcuffs/bola = 3,
		/obj/item/twohanded/spearaxe = 1,
		/obj/item/toy/plush/lizardplushie = 1,
		/obj/effect/spawner/lootdrop/f13/rare_melee = 1,
		/obj/item/stack/sheet/bone = 1,
		/obj/item/stack/sheet/sinew = 1,)
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	peaceful = TRUE
	taunt_chance = 30
	speed = 0
	maxHealth = 150
	health = 150
	mob_armor = ARMOR_VALUE_DEATHCLAW_COMMON
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 30
	melee_damage_upper = 50
	reach = 2
	sharpness = SHARP_EDGED
	move_to_delay = 1.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 10
	vision_range = 10
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	robust_searching = TRUE
	bossmob = TRUE
	speak_emote = list(
		"squeaks",
		"cackles",
		"snickers",
		"shriek",
		"scream",
		"skrem",
		"scrambles",
		"warbles",
		"chirps",
		"cries",
		"kyaas",
		"chortles",
		"gecks"
		)
	//emote_see = list(
		// "screeches",
		// "licks its eyes",
		// "twitches",
		// "scratches its frills",
		// "gonks",
		// "honks",
		// "scronks",
		// "sniffs",
		// "gecks"
		// )
	attack_verb_simple = list(
		"bites",
		"claws",
		"tears at",
		"dabs",
		"scratches",
		"gnaws",
		"chews",
		"chomps",
		"lunges",
		"gecks"
		)
	faction = list("gecko")
	a_intent = INTENT_HARM
	gold_core_spawnable = FALSE
	footstep_type = FOOTSTEP_MOB_HEAVY
	ranged = TRUE
	check_friendly_fire = TRUE
	move_resist = MOVE_FORCE_OVERPOWERING
	projectiletype = /obj/item/projectile/bola/fragile
	projectilesound = 'sound/weapons/bolathrow.ogg'
	idlesound = list(
		'sound/f13npc/gecko/geckocall1.ogg',
		'sound/f13npc/gecko/geckocall2.ogg',
		'sound/f13npc/gecko/geckocall3.ogg',
		'sound/f13npc/gecko/geckocall4.ogg',
		'sound/f13npc/gecko/geckocall5.ogg'
		)

	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = FALSE
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"

	variation_list = list(
		//MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255),
		MOB_SPEED_LIST(3, 3.2, 3.4, 3.6),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(3000),
		MOB_RETREAT_DISTANCE_LIST(0, 0, 0, 3, 3),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(65),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 0, 1),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(30),
	)

/mob/living/simple_animal/hostile/gecko/tribal/chieftain/Initialize()
	. = ..()
	resize = 1.5
	update_transform()

/obj/item/projectile/bola
	name = "flying cuffs"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "handcuff"
	range = 50
	stamina = 10
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0
	
	pixels_per_second = BULLET_SPEED_BASE
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

	/// volfemort has him bondage
	var/obj/item/restraints/legcuffs/bola/bondage = /obj/item/restraints/legcuffs/bola

/obj/item/projectile/bola/fragile
	bondage = /obj/item/restraints/legcuffs/bola/fragile

/obj/item/projectile/bola/on_hit(atom/target, blocked = FALSE)
	..()
	if(!ishuman(target))
		return BULLET_ACT_HIT
	var/mob/living/carbon/human/hit = target
	if(hit.legcuffed || hit.get_num_legs(FALSE) < 2)
		return BULLET_ACT_HIT
	var/obj/item/restraints/legcuffs/bola/gottem = new bondage(get_turf(hit))
	gottem.ensnare(hit)
	return BULLET_ACT_HIT


/mob/living/simple_animal/hostile/gecko/tribal/head_shaman/small_shaman
	name = "gecko tribe small shaman"
	desc = "A large mutated reptile that has learned the basics of tool usage. This one is dressed regally and wields a staff."
	icon_state = "gekko_tribe_shaman"
	icon_living = "gekko_tribe_shaman"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 4,
		/obj/item/stack/sheet/animalhide/gecko = 3,
		/obj/item/clothing/under/f13/wayfarer/shamanblue = 1,
		/obj/effect/spawner/lootdrop/f13/trash_medicine = 8,
		/obj/item/gun/ballistic/bow/compoundbow = 1,
		/obj/item/toy/plush/lizardplushie/kobold = 1,
		/obj/effect/spawner/lootdrop/f13/rare_melee = 1,
		/obj/item/stack/sheet/bone = 2,
		/obj/item/stack/sheet/sinew = 1,)
	butcher_difficulty = 1
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	peaceful = FALSE
	taunt_chance = 30
	speed = 0
	maxHealth = 75
	health = 75
	mob_armor = ARMOR_VALUE_LIGHT
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 4
	melee_damage_upper = 12
	move_to_delay = 1.5
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 8
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	robust_searching = TRUE
	bossmob = TRUE
	speak_emote = list(
		"squeaks",
		"cackles",
		"snickers",
		"shriek",
		"scream",
		"skrem",
		"scrambles",
		"warbles",
		"chirps",
		"cries",
		"kyaas",
		"chortles",
		"gecks"
		)
	//emote_see = list(
		// "screeches",
		// "licks its eyes",
		// "twitches",
		// "scratches its frills",
		// "gonks",
		// "honks",
		// "scronks",
		// "sniffs",
		// "gecks"
		// )
	attack_verb_simple = list(
		"bites",
		"claws",
		"tears at",
		"dabs",
		"scratches",
		"gnaws",
		"chews",
		"chomps",
		"lunges",
		"gecks"
		)
	faction = list("gecko")
	a_intent = INTENT_HARM
	gold_core_spawnable = FALSE
	footstep_type = FOOTSTEP_MOB_HEAVY
	ranged = TRUE
	check_friendly_fire = TRUE
	move_resist = MOVE_FORCE_OVERPOWERING
	idlesound = list(
		'sound/f13npc/gecko/geckocall1.ogg',
		'sound/f13npc/gecko/geckocall2.ogg',
		'sound/f13npc/gecko/geckocall3.ogg',
		'sound/f13npc/gecko/geckocall4.ogg',
		'sound/f13npc/gecko/geckocall5.ogg'
		)

	emote_taunt = list("screeches")
	emote_taunt_sound = list(
		'sound/f13npc/gecko/gecko_charge1.ogg',
		'sound/f13npc/gecko/gecko_charge2.ogg',
		'sound/f13npc/gecko/gecko_charge3.ogg'
		)
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_alert.ogg')
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'
	can_ghost_into = FALSE
	desc_short = "Short, angry, and as confused as they are tasty."
	desc_important = "Still in development! Report wierdness on the discord!"
	can_glow_revive = FALSE

	variation_list = list(
		//MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255),
		MOB_SPEED_LIST(3, 3.2, 3.4, 3.6),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(75),
		MOB_RETREAT_DISTANCE_LIST(3, 5, 7),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(2, 3, 4, 5, 6),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

/mob/living/simple_animal/hostile/gecko/tribal/head_shaman/small_shaman/Initialize(mapload)
	. = ..()
	// we only heal BRUTELOSS because each type directly heals a simplemob's health
	// therefore setting it to BRUTELOSS | FIRELOSS | TOXLOSS | OXYLOSS would mean healing 4x as much
	// aka 40% of max life every tick, which is basically unkillable
	// TODO: refactor this if simple_animals ever get damage types
	AddComponent(/datum/component/glow_heal, chosen_targets = /mob/living/simple_animal/hostile/gecko, allow_revival = FALSE, restrict_faction = null, type_healing = BRUTELOSS)
