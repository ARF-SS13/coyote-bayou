///////////////
// VAULT NPC //
///////////////

/mob/living/simple_animal/hostile/vault
	name = "Vault Dweller"
	desc = "Just a Vault Dweller"
	icon = 'icons/fallout/mobs/humans/fallout_npc.dmi'
	icon_state = "vault_dweller"
	icon_living = "vault_dweller"
	icon_dead = "vault_dweller"
	speak_chance = 0
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
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_simple = "punches"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = list(/obj/effect/mob_spawn/human/corpse/vault)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("vault", "city")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = TRUE
	speak_chance = 1

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
	say("HELP!!")

/mob/living/simple_animal/hostile/vault/dweller/dweller1
	icon_state = "vault_dweller1"
	icon_living = "vault_dweller1"
	icon_dead = "vault_dweller1"

/mob/living/simple_animal/hostile/vault/dweller/dweller2
	icon_state = "vault_dweller2"
	icon_living = "vault_dweller2"
	icon_dead = "vault_dweller2"

/mob/living/simple_animal/hostile/vault/dweller/dweller3
	icon_state = "vault_dweller3"
	icon_living = "vault_dweller3"
	icon_dead = "vault_dweller3"

/mob/living/simple_animal/hostile/vault/dweller/dweller4
	icon_state = "vault_dweller4"
	icon_living = "vault_dweller4"
	icon_dead = "vault_dweller4"

/mob/living/simple_animal/hostile/vault/dweller/dweller5
	icon_state = "vault_dweller5"
	icon_living = "vault_dweller5"
	icon_dead = "vault_dweller5"

/mob/living/simple_animal/hostile/vault/security
	name = "Vault Security"
	desc = "Just a Vault Security"
	icon_state = "vault_dweller_sec"
	icon_living = "vault_dweller_sec"
	icon_dead = "vault_dweller_sec"
	maxHealth = 200
	health = 200
	retreat_distance = 5
	minimum_distance = 5
	loot = list(/obj/effect/mob_spawn/human/corpse/vault/security)
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/beam
	projectilesound = 'sound/weapons/resonator_fire.ogg'
	speak_chance = 1


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
	del_on_death = TRUE
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	retreat_distance = 6
	minimum_distance = 6
	speed = 0
	ranged_cooldown_time = 22
	extra_projectiles = 2
	stat_attack = 1
	ranged = TRUE
	robust_searching = TRUE
	healable = TRUE
	maxHealth = 250
	health = 250
	melee_damage_lower = 35
	melee_damage_upper = 35
	harm_intent_damage = 8

	projectiletype = /obj/item/projectile/bullet/c46x30mm
	projectilesound = 'sound/weapons/gunshot_smg.ogg'
	attack_verb_simple = "pistol-whips"

	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("enclave")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	speak = list("For the Enclave!", "Stars and Stripes!", "Liberty or death!")
	speak_emote = list("pulls out a weapon", "shouts")
	speak_chance = 0

// Enclave Scientist
/mob/living/simple_animal/hostile/enclave/scientist
	name = "enclave scientist"
	desc = "An Enclave Scientist wearing an advanced radiation suit. While they may run from you, that does not exempt them from the evil they have committed."
	icon_state = "enclave_scientist"
	icon_living = "enclave_scientist"
	maxHealth = 150
	health = 150
	minimum_distance = 10
	retreat_distance = 10
	obj_damage = 0
	environment_smash = 0
	loot = list(/obj/effect/mob_spawn/human/corpse/enclavescientist)
	melee_damage_lower = 25
	melee_damage_upper = 25
	ranged_cooldown_time = 30
	projectiletype = /obj/item/projectile/energy/declone
	projectilesound = 'sound/weapons/wave.ogg'
	extra_projectiles = null
	attack_verb_simple = "thrusts"

// Enclave Armored Infantry
/mob/living/simple_animal/hostile/enclave/soldier
	name = "enclave armored infantry"
	desc = "An Enclave Soldier wearing Advanced Power Armor and a plasma multi-caster. Play time's over, mutie."
	icon_state = "enclave_armored"
	icon_living = "enclave_armored"
	maxHealth = 700
	health = 700
	melee_damage_lower = 50
	melee_damage_upper = 50
	extra_projectiles = 5 //6 projectiles. oh lord.
	retreat_distance = 3
	minimum_distance = 5
	ranged_cooldown_time = 12
	loot = list(/obj/effect/mob_spawn/human/corpse/enclave/soldier)
	healable = 1
	attack_verb_simple = "power-fists"
	projectiletype = /obj/item/projectile/f13plasma/repeater
	projectilesound = 'sound/f13weapons/plasmarifle.ogg'

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
	name = "BS"
	desc = "The brotherhood never fails."
	icon = 'icons/fallout/mobs/humans/fallout_npc.dmi'
	icon_state = "bs_knight"
	icon_living = "bs_knight"
	icon_dead = "bs_knight"
	speak_chance = 0
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	faction = list("BOS")
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	stat_attack = 1
	robust_searching = 1
	maxHealth = 250
	health = 250
	harm_intent_damage = 8
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_simple = "pistol-whips"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = list(/obj/effect/mob_spawn/human/corpse/bs)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = TRUE
	speak = list("Semper Invicta!")
	speak_emote = list("rushes")
	speak_chance = 1

/obj/effect/mob_spawn/human/corpse/bs
	name = "Brotherhood Knight"
	uniform = /obj/item/clothing/under/syndicate/brotherhood
	suit = /obj/item/clothing/suit/armor/medium/combat/brotherhood
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/combat
	belt = 	/obj/item/storage/belt/military/assault
	mask = /obj/item/clothing/mask/gas/sechailer
	head = /obj/item/clothing/head/helmet/f13/combat/brotherhood

/mob/living/simple_animal/hostile/bs/knight
	name = "Brotherhood Knight"
	desc = "A Brotherhood Knight wielding a laser pistol and older issue Brotherhood combat armor."
	icon_state = "bs_knight"
	icon_living = "bs_knight"
	icon_dead = "bs_knight"
	retreat_distance = 5
	minimum_distance = 5
	loot = list(/obj/effect/mob_spawn/human/corpse/bs)
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/beam/laser/pistol/hitscan
	projectilesound = 'sound/f13weapons/aep7fire.ogg'

/mob/living/simple_animal/hostile/bs/paladin
	name = "Brotherhood Paladin"
	desc = "A Paladin equipped with an AER9 and T-51b power armor. The Brotherhood has arrived."
	icon_state = "bs_paladin"
	icon_living = "bs_paladin"
	icon_dead = "bs_paladin"
	retreat_distance = 5
	minimum_distance = 5
	loot = list(/obj/effect/mob_spawn/human/corpse/bs/paladin)
	maxHealth = 600
	health = 600
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/beam/laser/lasgun/hitscan
	projectilesound = 'sound/f13weapons/aer9fire.ogg'

/obj/effect/mob_spawn/human/corpse/bs/paladin
	name = "Brotherhood Paladin"
	uniform = /obj/item/clothing/under/f13/recon
	suit = /obj/item/clothing/suit/armor/power_armor/t51b/bos
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/combat
	belt = 	/obj/item/storage/belt/military/assault
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
	icon_dead = "ncr_trooper"
	faction = list("NCR")
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	stat_attack = 1
	robust_searching = 1
	maxHealth = 150
	health = 150
	harm_intent_damage = 8
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_simple = "áüåò"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = list(/obj/effect/mob_spawn/human/corpse/ncr)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = TRUE
	speak = list("Patrolling the Mojave almost makes you wish for a nuclear winter.", "When I got this assignment I was hoping there would be more gambling.", "It's been a long tour, all I can think about now is going back home.", "You know, if you were serving, you'd probably be halfway to general by now.", "You oughtta think about enlisting. We need you here.")
	speak_emote = list("says")
	speak_chance = 1

/obj/effect/mob_spawn/human/corpse/ncr
	name = "NCR Trooper"
	uniform = /obj/item/clothing/under/f13/ncr
	suit = /obj/item/clothing/suit/armor/ncrarmor
	belt = /obj/item/storage/belt/military/assault/ncr
	shoes = /obj/item/clothing/shoes/f13/military/ncr
	head = /obj/item/clothing/head/f13/ncr

/mob/living/simple_animal/hostile/ncr/trooper
	name = "NCR Trooper"
	desc = "A standard NCR Trooper wielding a service rifle and equipped with a patrol vest."
	icon_state = "ncr_trooper"
	icon_living = "ncr_trooper"
	icon_dead = "ncr_trooper"
	retreat_distance = 5
	minimum_distance = 5
	loot = list(/obj/effect/mob_spawn/human/corpse/ncr)
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/a556/simple
	projectilesound = 'sound/f13weapons/varmint_rifle.ogg'
	casingtype = /obj/item/ammo_casing/a556

/mob/living/simple_animal/hostile/ncr/ranger
	name = "NCR Ranger"
	desc = "A Ranger of the NCRA, wielding a big iron on his hip and equipped with a ranger patrol vest."
	icon_state = "ncr_sergeant"
	icon_living = "ncr_sergeant"
	icon_dead = "ncr_sergeant"
	retreat_distance = 5
	minimum_distance = 5
	loot = list(/obj/effect/mob_spawn/human/corpse/ncr/ranger)
	maxHealth = 200
	health = 200
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/m44/simple
	projectilesound = 'sound/f13weapons/44mag.ogg'
	casingtype = /obj/item/ammo_casing/m44

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
	icon_dead = "legion_prime"
	faction = list("Legion")
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	stat_attack = 1
	robust_searching = 1
	maxHealth = 150
	health = 150
	harm_intent_damage = 8
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_simple = "attacks"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = list(/obj/effect/mob_spawn/human/corpse/legion)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = TRUE
	speak = list("Ave, true to Caesar.", "True to Caesar.", "Ave, Amicus.", "The new slave girls are quite beautiful.", "Give me cause, Profligate.", "Degenerates like you belong on a cross.")
	speak_emote = list("says")
	speak_chance = 1

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
	icon_dead = "legion_prime"
	icon_gib = "legion_prime"
	retreat_distance = 5
	minimum_distance = 5
	loot = list(/obj/effect/mob_spawn/human/corpse/legion)
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/a762/sport/simple
	projectilesound = 'sound/f13weapons/hunting_rifle.ogg'
	casingtype = /obj/item/ammo_casing/a762/sport

/mob/living/simple_animal/hostile/legion/decan
	name = "Legion Decanus"
	desc = "A Prime Decanus, equipped with a hunting rifle."
	icon_state = "legion_decan"
	icon_living = "legion_decan"
	icon_dead = "legion_decan"
	icon_gib = "legion_decan"
	retreat_distance = 5
	minimum_distance = 5
	loot = list(/obj/effect/mob_spawn/human/corpse/legion/decan)
	maxHealth = 225
	health = 225
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/a762/sport/simple
	projectilesound = 'sound/f13weapons/hunting_rifle.ogg'
	casingtype = /obj/item/ammo_casing/a762/sport

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
	name = "Wayfarer Hunter"
	desc = "A hunter of the wayfarer tribe, wielding a glaive."
	icon = 'icons/fallout/mobs/humans/fallout_npc.dmi'
	icon_state = "tribal_raider"
	icon_living = "tribal_raider"
	icon_dead = "tribal_raider_dead"
	faction = list("Tribe")
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	stat_attack = 1
	robust_searching = 1
	maxHealth = 200
	health = 200
	harm_intent_damage = 8
	melee_damage_lower = 50
	melee_damage_upper = 50
	attack_verb_simple = "attacks"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	status_flags = CANPUSH
	speak = list("For our kin!", "This will be a good hunt.", "The gods look upon me today.")
	speak_emote = list("says")
	speak_chance = 1
