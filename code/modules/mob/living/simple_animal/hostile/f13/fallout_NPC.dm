///////////////
// VAULT NPC //
///////////////

/mob/living/simple_animal/hostile/vault
	name = "Vault Dweller"
	desc = "Just a Vault Dweller"
	icon = 'icons/fallout/mobs/humans/fallout_npc.dmi'
	icon_state = "vault_dweller"
	icon_living = "vault_dweller"
	icon_dead = "vault_dweller_dead"
	turns_per_move = 5
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	stat_attack = 1
	robust_searching = 1
	maxHealth = 100
	health = 100
	harm_intent_damage = 8
	melee_damage_lower = 5
	melee_damage_upper = 10
	attack_verb_simple = "punches"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	unsuitable_atmos_damage = 15
	faction = list("vault", "city")
	check_friendly_fire = 1
	status_flags = CANPUSH
	speak_chance = 1
	despawns_when_lonely = FALSE
	ignore_other_mobs = TRUE // we fight
	override_ignore_other_mobs = TRUE
	retreat_health_percent = 0.5
	max_heal_amount = 0.9
	heal_per_life = 0.115
	tactical_retreat = 10
	loot = list(/obj/effect/gibspawner/human)
	loot_drop_amount = 2
	loot_amount_random = TRUE
	bounty = 30


/obj/effect/mob_spawn/human/corpse/vault
	name = "Vault Dweller"
	gloves = /obj/item/pda
	uniform = /obj/item/clothing/under/f13/vault/v13
	shoes = /obj/item/clothing/shoes/jackboots

/mob/living/simple_animal/hostile/vault/dweller
	minimum_distance = 10
	retreat_distance = 10
	obj_damage = 0
	environment_smash = 0

/mob/living/simple_animal/hostile/vault/dweller/Aggro()
	..()
	summon_backup(15)
	say("HELP!!", only_overhead = TRUE)

/mob/living/simple_animal/hostile/vault/dweller/dweller1
	icon_state = "vault_dweller1"
	icon_living = "vault_dweller1"
	icon_dead = "vault_dweller1_dead"

/mob/living/simple_animal/hostile/vault/dweller/dweller2
	icon_state = "vault_dweller2"
	icon_living = "vault_dweller2"
	icon_dead = "vault_dweller2_dead"

/mob/living/simple_animal/hostile/vault/dweller/dweller3
	icon_state = "vault_dweller3"
	icon_living = "vault_dweller3"
	icon_dead = "vault_dweller3_dead"

/mob/living/simple_animal/hostile/vault/dweller/dweller4
	icon_state = "vault_dweller4"
	icon_living = "vault_dweller4"
	icon_dead = "vault_dweller4_dead"

/mob/living/simple_animal/hostile/vault/dweller/dweller5
	icon_state = "vault_dweller5"
	icon_living = "vault_dweller5"
	icon_dead = "vault_dweller5_dead"

/mob/living/simple_animal/hostile/vault/security
	name = "Vault Security"
	desc = "Just a Vault Security"
	icon_state = "vault_dweller_sec"
	icon_living = "vault_dweller_sec"
	icon_dead = "vault_dweller_sec_dead"
	maxHealth = 160
	health = 160
	retreat_distance = 5
	minimum_distance = 5
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/beam
	projectilesound = 'sound/weapons/resonator_fire.ogg'
	speak_chance = 1
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
	speed = 10 // added to make his dumbass hold still - Jaeger

/mob/living/simple_animal/hostile/vault/security/Aggro()
	..()
	summon_backup(15)

/obj/effect/mob_spawn/human/corpse/vault/security
	name = "Vault Security"
	gloves = /obj/item/pda
	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/f13/vault/v13
	suit = /obj/item/clothing/suit/armor/medium/vest
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/helmet/riot/vaultsec

/////////////////
// ENCLAVE NPC //
/////////////////

// Enclave specialist, basic fighter
/mob/living/simple_animal/hostile/enclave
	name = "enclave specialist"
	desc = "A Enclave soldier with combat armor and a G-11 rifle."
	icon = 'icons/fallout/mobs/humans/fallout_npc.dmi'
	icon_state = "enclave_specialist"
	icon_living = "enclave_specialist"
	icon_dead = "enclave_specialist_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	retreat_distance = 6
	minimum_distance = 6
	speed = 4
	ranged_cooldown_time = 22
	extra_projectiles = 2
	stat_attack = 1
	ranged = TRUE
	robust_searching = TRUE
	healable = TRUE
	maxHealth = 200
	health = 200
	melee_damage_lower = 15
	melee_damage_upper = 35
	harm_intent_damage = 8
	loot = list(/obj/effect/gibspawner/human)
	loot_drop_amount = 2
	loot_amount_random = TRUE
	bounty = 30

	projectiletype = /obj/item/projectile/bullet/c46x30mm
	projectilesound = 'sound/weapons/gunshot_smg.ogg'
	attack_verb_simple = "pistol-whips"

	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	unsuitable_atmos_damage = 15
	faction = list("enclave")
	check_friendly_fire = 1
	status_flags = CANPUSH
	//speak = list("For the Enclave!", "Stars and Stripes!", "Liberty or death!")
	speak_emote = list("pulls out a weapon", "shouts")
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
	ignore_other_mobs = TRUE // we fight
	override_ignore_other_mobs = TRUE

// Enclave Scientist
/mob/living/simple_animal/hostile/enclave/scientist
	name = "enclave scientist"
	desc = "An Enclave Scientist wearing an advanced radiation suit. While they may run from you, that does not exempt them from the evil they have committed."
	icon_state = "enclave_scientist"
	icon_living = "enclave_scientist"
	icon_dead = "enclave_scientist_dead"
	maxHealth = 120
	health = 120
	minimum_distance = 10
	retreat_distance = 10
	obj_damage = 0
	environment_smash = 0
	melee_damage_lower = 5
	melee_damage_upper = 15
	ranged_cooldown_time = 30
	projectiletype = /obj/item/projectile/f13plasma/pistol/adam/simple
	projectilesound = 'sound/weapons/wave.ogg'
	extra_projectiles = 1
	attack_verb_simple = "thrusts"
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PLASMA_VOLUME),
		SP_VOLUME_SILENCED(PLASMA_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PLASMA_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PLASMA_DISTANT_SOUND),
		SP_DISTANT_RANGE(PLASMA_RANGE_DISTANT)
	)
	retreat_health_percent = 0.8
	max_heal_amount = 0.85
	heal_per_life = 0.115
	tactical_retreat = 10
	speed = 4 // added to make his dumbass hold still - Jaeger

/mob/living/simple_animal/hostile/enclave/scientist/Aggro()
	..()
	summon_backup(15)
	say("Intruder!!", only_overhead = TRUE) 

// Enclave Armored Infantry
/mob/living/simple_animal/hostile/enclave/soldier
	name = "enclave armored infantry"
	desc = "An Enclave Soldier wearing Advanced Power Armor and a plasma multi-caster. Play time's over, mutie."
	icon_state = "enclave_armored"
	icon_living = "enclave_armored"
	icon_dead = "enclave_armored_dead"
	maxHealth = 560
	health = 650
	melee_damage_lower = 20
	melee_damage_upper = 47
	extra_projectiles = 2
	retreat_distance = 3
	minimum_distance = 5
	ranged_cooldown_time = 12
	healable = 1
	attack_verb_simple = "power-fists"
	loot = list(/obj/effect/gibspawner/human)
	loot_drop_amount = 2
	loot_amount_random = TRUE
	projectiletype = /obj/item/projectile/f13plasma/scatter
	projectilesound = 'sound/f13weapons/plasmarifle.ogg'
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PLASMA_VOLUME),
		SP_VOLUME_SILENCED(PLASMA_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PLASMA_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PLASMA_DISTANT_SOUND),
		SP_DISTANT_RANGE(PLASMA_RANGE_DISTANT)
	)
	speed = 4 // added to make his dumbass hold still - Jaeger
	bounty = 50

// Enclave corpses
/obj/effect/mob_spawn/human/corpse/enclavescientist
	name = "enclave scientist"
	uniform = /obj/item/clothing/under/f13/enclave/science
	suit = /obj/item/clothing/suit/bio_suit/enclave
	shoes = /obj/item/clothing/shoes/f13/enclave/serviceboots
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	head = /obj/item/clothing/head/helmet/f13/envirosuit

/obj/effect/mob_spawn/human/corpse/enclave
	name = "enclave specialist"
	uniform = /obj/item/clothing/under/f13/enclave/peacekeeper
	shoes = /obj/item/clothing/shoes/f13/enclave/serviceboots
	gloves = /obj/item/clothing/gloves/f13/military
	mask = /obj/item/clothing/mask/gas/enclave
	head = /obj/item/clothing/head/f13/enclave/peacekeeper

/obj/effect/mob_spawn/human/corpse/enclave/soldier
	name = "enclave armored infantry"
	uniform = /obj/item/clothing/under/f13/enclave/peacekeeper
	shoes = /obj/item/clothing/shoes/f13/enclave/serviceboots
	gloves = /obj/item/clothing/gloves/f13/military
	mask = /obj/item/clothing/mask/gas/enclave


/////////////////////
// BROTHERHOOD NPC //
/////////////////////

/mob/living/simple_animal/hostile/bs
	name = "Tech-Trooper"
	desc = "The something another never fails."
	icon = 'icons/fallout/mobs/humans/fallout_npc.dmi'
	icon_state = "bs_knight"
	icon_living = "bs_knight"
	icon_dead = "bs_knight_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	faction = list("BOS", "wastebots")
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 4
	stat_attack = 1
	robust_searching = 1
	maxHealth = 200
	health = 200
	harm_intent_damage = 8
	melee_damage_lower = 7
	melee_damage_upper = 15
	attack_verb_simple = "pistol-whips"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	unsuitable_atmos_damage = 15
	check_friendly_fire = 1
	status_flags = CANPUSH
	//speak = list("Semper Invicta!")
	speak_emote = list("rushes")
	speak_chance = 1
	ignore_other_mobs = TRUE // we fight
	override_ignore_other_mobs = TRUE
	loot = list(/obj/effect/gibspawner/human)
	loot_drop_amount = 2
	loot_amount_random = TRUE
	bounty = 30

/obj/effect/mob_spawn/human/corpse/bs
	name = "Tech-trooper"
	uniform = /obj/item/clothing/under/syndicate/brotherhood
	suit = /obj/item/clothing/suit/armor/medium/combat/brotherhood
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/combat
	belt = 	/obj/item/storage/belt/army/assault
	mask = /obj/item/clothing/mask/gas/sechailer
	head = /obj/item/clothing/head/helmet/f13/combat/brotherhood

/mob/living/simple_animal/hostile/bs/knight
	name = "Tech-trooper Leftenant"
	desc = "A loser wielding a laser pistol and older issue combat armor."
	icon_state = "bs_knight"
	icon_living = "bs_knight"
	icon_dead = "bs_knight_dead"
	retreat_distance = 5
	minimum_distance = 5
	healable = 1
	ranged = 1
	loot = list(/obj/effect/gibspawner/human)
	loot_drop_amount = 2
	loot_amount_random = TRUE
	projectiletype = /obj/item/projectile/beam/laser/pistol/hitscan
	projectilesound = 'sound/f13weapons/aep7fire.ogg'
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
	speed = 4 // added to make his dumbass hold still - Jaeger

/mob/living/simple_animal/hostile/bs/paladin
	name = "Tech-Trooper Commander"
	desc = "A dork equipped with an AER9 and T-51b power armor. The idiots have arrived."
	icon_state = "bs_paladin"
	icon_living = "bs_paladin"
	icon_dead = "bs_paladin_dead"
	retreat_distance = 5
	minimum_distance = 5
	maxHealth = 480
	health = 480
	healable = 1
	ranged = 1
	loot = list(/obj/effect/gibspawner/human)
	loot_drop_amount = 5
	loot_amount_random = TRUE
	projectiletype = /obj/item/projectile/beam/laser/lasgun/hitscan
	projectilesound = 'sound/f13weapons/aer9fire.ogg'
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
	speed = 4 // added to make his dumbass hold still - Jaeger

/obj/effect/mob_spawn/human/corpse/bs/paladin
	name = "Brotherhood Paladin"
	uniform = /obj/item/clothing/under/f13/recon
	suit = /obj/item/clothing/suit/armor/power_armor/t51b/bos
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/combat
	belt = 	/obj/item/storage/belt/army/assault
	mask = /obj/item/clothing/mask/gas/sechailer
	head = /obj/item/clothing/head/helmet/f13/power_armor/t51b/bos


///////////////
// NCR = NPC //
///////////////

/mob/living/simple_animal/hostile/ncr
	name = "NCR"
	desc = "For the Republic!"
	icon = 'icons/fallout/mobs/humans/fallout_npc.dmi'
	icon_state = "ncr_trooper"
	icon_living = "ncr_trooper"
	icon_dead = "ncr_trooper_dead"
	faction = list("NCR")
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 4
	stat_attack = 1
	robust_searching = 1
	maxHealth = 120
	health = 120
	harm_intent_damage = 8
	melee_damage_lower = 8
	melee_damage_upper = 15
	attack_verb_simple = "áüåò"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = list()
	unsuitable_atmos_damage = 15
	check_friendly_fire = 1
	status_flags = CANPUSH
	//speak = list("Patrolling the Mojave almost makes you wish for a nuclear winter.", "When I got this assignment I was hoping there would be more gambling.", "It's been a long tour, all I can think about now is going back home.", "You know, if you were serving, you'd probably be halfway to general by now.", "You oughtta think about enlisting. We need you here.")
	speak_emote = list("says")
	speak_chance = 1
	ignore_other_mobs = TRUE // we fight
	override_ignore_other_mobs = TRUE

/obj/effect/mob_spawn/human/corpse/ncr
	name = "NCR Trooper"
	uniform = /obj/item/clothing/under/f13/ncr
	suit = /obj/item/clothing/suit/armor/ncrarmor
	belt = /obj/item/storage/belt/army/assault/ncr
	shoes = /obj/item/clothing/shoes/f13/military/ncr
	head = /obj/item/clothing/head/f13/ncr

/mob/living/simple_animal/hostile/ncr/trooper
	name = "NCR Trooper"
	desc = "A standard NCR Trooper wielding a service rifle and equipped with a patrol vest."
	icon_state = "ncr_trooper"
	icon_living = "ncr_trooper"
	icon_dead = "ncr_trooper_dead"
	retreat_distance = 5
	minimum_distance = 5
	loot = list()
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/a556/simple
	projectilesound = 'sound/f13weapons/varmint_rifle.ogg'
	casingtype = /obj/item/ammo_casing/a556
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

/mob/living/simple_animal/hostile/ncr/ranger
	name = "NCR Ranger"
	desc = "A Ranger of the NCRA, wielding a big iron on his hip and equipped with a ranger patrol vest."
	icon_state = "ncr_sergeant"
	icon_living = "ncr_sergeant"
	icon_dead = "ncr_sergeant_dead"
	retreat_distance = 5
	minimum_distance = 5
	loot = list()
	maxHealth = 160
	health = 160
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/m44/simple
	projectilesound = 'sound/f13weapons/44mag.ogg'
	casingtype = /obj/item/ammo_casing/m44
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
	speed = 4 // added to make his dumbass hold still - Jaeger

/obj/effect/mob_spawn/human/corpse/ncr/ranger
	name = "NCR Ranger"
	uniform = /obj/item/clothing/under/f13/ranger/patrol
	suit = /obj/item/clothing/suit/armor/medium/combat/desert_ranger/patrol
	shoes = /obj/item/clothing/shoes/f13/military/leather
	gloves = /obj/item/clothing/gloves/patrol
	head = /obj/item/clothing/head/f13/ranger

////////////////
// LEGION NPC //
////////////////

/mob/living/simple_animal/hostile/legion
	name = "Legion"
	desc = "True to Caesar."
	icon = 'icons/fallout/mobs/humans/fallout_npc.dmi'
	icon_state = "legion_prime"
	icon_living = "legion_prime"
	icon_dead = "legion_prime_dead"
	faction = list("Legion")
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	stat_attack = 1
	robust_searching = 1
	maxHealth = 120
	health = 120
	harm_intent_damage = 8
	melee_damage_lower = 8
	melee_damage_upper = 15
	attack_verb_simple = "attacks"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = list()
	unsuitable_atmos_damage = 15
	check_friendly_fire = 1
	status_flags = CANPUSH
	//speak = list("Ave, true to Caesar.", "True to Caesar.", "Ave, Amicus.", "The new slave girls are quite beautiful.", "Give me cause, Profligate.", "Degenerates like you belong on a cross.")
	speak_emote = list("says")
	speak_chance = 1
	ignore_other_mobs = TRUE // we fight
	override_ignore_other_mobs = TRUE

/obj/effect/mob_spawn/human/corpse/legion
	name = "Legion Prime"
	uniform = /obj/item/clothing/under/f13/legskirt
	suit = /obj/item/clothing/suit/armor/legion/prime
	shoes = /obj/item/clothing/shoes/f13/military/legion
	head = /obj/item/clothing/head/helmet/f13/legion/prime

/mob/living/simple_animal/hostile/legion/prime
	name = "Legion Prime"
	desc = "A Prime Legionary, equipped with a hunting rifle."
	icon_state = "legion_prime"
	icon_living = "legion_prime"
	icon_dead = "legion_prime_dead"
	icon_gib = "legion_prime"
	retreat_distance = 5
	minimum_distance = 5
	loot = list()
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/a308/improvised/simple
	projectilesound = 'sound/f13weapons/hunting_rifle.ogg'
	casingtype = /obj/item/ammo_casing/a308
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
	speed = 4 // added to make his dumbass hold still - Jaeger

/mob/living/simple_animal/hostile/legion/decan
	name = "Legion Decanus"
	desc = "A Prime Decanus, equipped with a hunting rifle."
	icon_state = "legion_decan"
	icon_living = "legion_decan"
	icon_dead = "legion_decan_dead"
	icon_gib = "gib"
	retreat_distance = 5
	minimum_distance = 5
	maxHealth = 180
	health = 180
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/a308/improvised/simple
	projectilesound = 'sound/f13weapons/hunting_rifle.ogg'
	casingtype = /obj/item/ammo_casing/a308
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
	speed = 4 // added to make his dumbass hold still - Jaeger

/mob/living/simple_animal/hostile/legion/decan

/obj/effect/mob_spawn/human/corpse/legion/decan
	name = "Legion Decanus"
	uniform = /obj/item/clothing/under/f13/legskirt
	suit = /obj/item/clothing/suit/armor/legion/vet
	shoes = /obj/item/clothing/shoes/f13/military/legion
	gloves = /obj/item/clothing/gloves/legion
	head = /obj/item/clothing/head/helmet/f13/legion/prime/decan

////////////////
// TRIBAL NPC //
////////////////

/mob/living/simple_animal/hostile/tribe
	name = "Lost Ones Hunter"
	desc = "A Lost ones hunter, once part of the Sulphur Bottom tribe these lunatics have fallen to canibalism and baser instincts."
	icon = 'icons/fallout/mobs/humans/fallout_npc.dmi'
	icon_state = "tribal_raider"
	icon_living = "tribal_raider"
	icon_dead = "tribal_raider_dead"
	faction = list("Tribe")
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	stat_attack = 1
	robust_searching = 1
	maxHealth = 160
	health = 160
	harm_intent_damage = 8
	melee_damage_lower = 22
	melee_damage_upper = 47
	attack_verb_simple = "attacks"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	a_intent = INTENT_HARM
	unsuitable_atmos_damage = 15
	status_flags = CANPUSH
	//speak = list("Blood, blood, blood, blood!", "You'll make a fine stew!", "Perish interloper!")
	speak_emote = list("says")
	speak_chance = 1
	ignore_other_mobs = TRUE // we fight
	override_ignore_other_mobs = TRUE
