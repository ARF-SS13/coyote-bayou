/mob/living/simple_animal/hostile/vault
	name = "Vault Dweller"
	desc = "Just a Vault Dweller"
	icon_state = "vault_dweller"
	icon_living = "vault_dweller"
	icon_dead = "vault_dweller"
	icon_gib = "vault_dweller"
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
	del_on_death = 1
	speak_chance = 1

/obj/effect/mob_spawn/human/corpse/vault
	name = "Vault Dweller"
	uniform = /obj/item/clothing/under/f13/vault/v13
	//suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/sneakers/brown
	//gloves = /obj/item/clothing/gloves/combat
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	//head = /obj/item/clothing/head/head/swat
	//back = /obj/item/weapon/storage/backpack


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
	icon_gib = "vault_dweller1"

/mob/living/simple_animal/hostile/vault/dweller/dweller2
	icon_state = "vault_dweller2"
	icon_living = "vault_dweller2"
	icon_dead = "vault_dweller2"
	icon_gib = "vault_dweller2"

/mob/living/simple_animal/hostile/vault/dweller/dweller3
	icon_state = "vault_dweller3"
	icon_living = "vault_dweller3"
	icon_dead = "vault_dweller3"
	icon_gib = "vault_dweller3"

/mob/living/simple_animal/hostile/vault/dweller/dweller4
	icon_state = "vault_dweller4"
	icon_living = "vault_dweller4"
	icon_dead = "vault_dweller4"
	icon_gib = "vault_dweller4"

/mob/living/simple_animal/hostile/vault/dweller/dweller5
	icon_state = "vault_dweller5"
	icon_living = "vault_dweller5"
	icon_dead = "vault_dweller5"
	icon_gib = "vault_dweller5"

/mob/living/simple_animal/hostile/vault/security
	name = "Vault Security"
	desc = "Just a Vault Security"
	icon_state = "vault_dweller_sec"
	icon_living = "vault_dweller_sec"
	icon_dead = "vault_dweller_sec"
	icon_gib = "vault_dweller_sec"
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
	uniform = /obj/item/clothing/under/f13/vault/v13
	suit = /obj/item/clothing/suit/armor/bulletproof
	shoes = /obj/item/clothing/shoes/sneakers/brown
	//gloves = /obj/item/clothing/gloves/combat
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/riot
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/enclave
	name = "Enclave"
	desc = ""
	icon_state = "enclave_scientist"
	icon_living = "enclave_scientist"
	icon_dead = "enclave_scientist"
	icon_gib = "enclave_scientist"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 0
	stat_attack = 1
	robust_searching = 1
	maxHealth = 150
	health = 150
	harm_intent_damage = 8
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_simple = "thrusts"
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

/obj/effect/mob_spawn/human/corpse/enclavescientist
	name = "enclave scientist"
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/radiation
	shoes = /obj/item/clothing/shoes/f13/military
	gloves = /obj/item/clothing/gloves/f13/military
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/radiation
	//back = /obj/item/weapon/storage/backpack

/obj/effect/mob_spawn/human/corpse/enclave/soldier_ca
	name = "enclave soldier"
	uniform = /obj/item/clothing/under/syndicate/combat
	shoes = /obj/item/clothing/shoes/f13/military
	gloves = /obj/item/clothing/gloves/f13/military
	//radio = /obj/item/device/radio/headset
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/f13/combat/enclave
	//back = /obj/item/weapon/storage/backpack

/obj/effect/mob_spawn/human/corpse/enclave/soldier
	name = "nclave advanced soldier"
	uniform = /obj/item/clothing/under/syndicate/combat
	shoes = /obj/item/clothing/shoes/f13/military
	gloves = /obj/item/clothing/gloves/f13/military
	//radio = /obj/item/device/radio/headset
	mask = /obj/item/clothing/mask/gas
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/enclave/scientist
	name = "enclave scientist"
	desc = "An Enclave Scientist wearing an advanced radiation suit. While they may run from you, that does not exempt them from the evil they have committed."
	minimum_distance = 10
	retreat_distance = 10
	obj_damage = 0
	environment_smash = 0
	loot = list(/obj/effect/mob_spawn/human/corpse/enclavescientist)
	ranged = 1
	ranged_cooldown_time = 30
	projectiletype = /obj/item/projectile/energy/declone
	projectilesound = 'sound/weapons/wave.ogg'

/mob/living/simple_animal/hostile/enclave/soldier
	name = "enclave advanced soldier"
	desc = "An Enclave Soldier wearing Advanced Power Armor and a plasma multi-caster. Play time's over, mutie."
	icon_state = "enclaverangedelite"
	icon_living = "eclaverangedelite"
	icon_dead = "enclave_soldier"
	icon_gib = "enclave_soldier"
	maxHealth = 750
	health = 750
	melee_damage_lower = 55
	melee_damage_upper = 55
	extra_projectiles = 5 //6 projectiles. oh lord.
	retreat_distance = 3
	minimum_distance = 5
	ranged_cooldown_time = 12
	loot = list(/obj/effect/mob_spawn/human/corpse/enclave/soldier)
	healable = 1
	ranged = 1
	attack_verb_simple = "power-fists"
	projectiletype = /obj/item/projectile/f13plasma/repeater
	projectilesound = 'sound/f13weapons/plasmarifle.ogg'

/mob/living/simple_animal/hostile/enclave/soldier_ca
	name = "Enclave Footsoldier"
	desc = "An Enclave soldier in Enclave Combat Armor, wielding an assault rifle."
	icon_state = "enclaveranged"
	icon_living = "enclaveranged"
	icon_dead = "enclaveranged"
	icon_gib = "enclave_soldier"
	maxHealth = 275
	health = 275
	melee_damage_lower = 40
	melee_damage_upper = 40
	retreat_distance = 6
	minimum_distance = 6
	extra_projectiles = 2
	ranged_cooldown_time = 22
	loot = list(/obj/effect/mob_spawn/human/corpse/enclave/soldier)
	healable = 1
	ranged = 1
	attack_verb_simple = "pistol-whips"
	projectiletype = /obj/item/projectile/bullet/c46x30mm
	projectilesound = 'sound/weapons/gunshot_smg.ogg'

/mob/living/simple_animal/hostile/bs
	name = "BS"
	desc = "the brotherhood never fails."
	icon_state = "bs_knight"
	icon_living = "bs_knight"
	icon_dead = "bs_knight"
	icon_gib = "bs_knight"
	speak_chance = 0
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	faction = list("bos")
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
	attack_verb_simple = "áüåò"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = list(/obj/effect/mob_spawn/human/corpse/bs)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("bs", "city", "vault")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	speak = list("Semper Invicta!")
	speak_emote = list("rushes")
	speak_chance = 1

/obj/effect/mob_spawn/human/corpse/bs
	name = "Brotherhood Knight"
	uniform = /obj/item/clothing/under/f13/bdu
	suit = /obj/item/clothing/suit/armor/f13/combat/brotherhood
	shoes = /obj/item/clothing/shoes/f13/military
	gloves = /obj/item/clothing/gloves/f13/military
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/f13/combat/brotherhood
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/bs/knight
	name = "Brotherhood Knight"
	desc = "A Brotherhood Knight wielding a laser pistol and older issue Brotherhood combat armor."
	icon_state = "bs_knight"
	icon_living = "bs_knight"
	icon_dead = "bs_knight"
	icon_gib = "bs_knight"
	retreat_distance = 5
	minimum_distance = 5
	loot = list(/obj/effect/mob_spawn/human/corpse/bs)
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/beam
	projectilesound = 'sound/weapons/resonator_fire.ogg'

/mob/living/simple_animal/hostile/bs/paladin
	name = "Brotherhood Paladin"
	desc = "A Paladin equipped with an AER9 and T-45d power armor. The Brotherhood has arrived."
	icon_state = "bs_paladin"
	icon_living = "bs_paladin"
	icon_dead = "bs_paladin"
	icon_gib = "bs_paladin"
	retreat_distance = 5
	minimum_distance = 5
	loot = list(/obj/effect/mob_spawn/human/corpse/bs/paladin)
	maxHealth = 600
	health = 600
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/beam
	projectilesound = 'sound/weapons/resonator_fire.ogg'

/obj/effect/mob_spawn/human/corpse/bs/paladin
	name = "Brotherhood Paladin"
	uniform = /obj/item/clothing/under/f13/bdu
	suit = /obj/item/clothing/suit/armor/f13/power_armor/t45d
	shoes = /obj/item/clothing/shoes/f13/military
	gloves = /obj/item/clothing/gloves/f13/military
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/f13/power_armor/t45d
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/ncr
	name = "NCR"
	desc = "Just an NCR."
	icon_state = "ncr_trooper"
	icon_living = "ncr_trooper"
	icon_dead = "ncr_trooper"
	icon_gib = "ncr_trooper"
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
	faction = list("ncr", "city", "followers", "vault")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	speak = list("Patrolling the Mojave almost makes you wish for a nuclear winter.", "When I got this assignment I was hoping there would be more gambling.", "It's been a long tour, all I can think about now is going back home.", "You know, if you were serving, you'd probably be halfway to general by now.", "You oughtta think about enlisting. We need you here.")
	speak_emote = list("says")
	speak_chance = 1

/obj/effect/mob_spawn/human/corpse/ncr
	name = "NCR Trooper"
	uniform = /obj/item/clothing/under/f13/ncr
	suit = /obj/item/clothing/suit/armor/f13/ncrarmor/reinforced
	shoes = /obj/item/clothing/shoes/f13/military/ncr
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/f13/ncr
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/ncr/trooper
	name = "NCR Trooper"
	desc = "Just a NCR Trooper"
	icon_state = "ncr_trooper"
	icon_living = "ncr_trooper"
	icon_dead = "ncr_trooper"
	icon_gib = "ncr_trooper"
	retreat_distance = 5
	minimum_distance = 5
	loot = list(/obj/effect/mob_spawn/human/corpse/ncr)
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/a762
	projectilesound = 'sound/weapons/garandshot.ogg'
	casingtype = /obj/item/ammo_casing/a762

/mob/living/simple_animal/hostile/ncr/sergeant
	name = "NCR Sergeant"
	desc = "Just a NCR Sergeant"
	icon_state = "ncr_sergeant"
	icon_living = "ncr_sergeant"
	icon_dead = "ncr_sergeant"
	icon_gib = "ncr_sergeant"
	retreat_distance = 5
	minimum_distance = 5
	loot = list(/obj/effect/mob_spawn/human/corpse/ncr/sergeant)
	maxHealth = 200
	health = 200
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/a556/simple
	projectilesound = 'sound/f13weapons/assaultrifle_fire.ogg'
	casingtype = /obj/item/ammo_casing/a556

/obj/effect/mob_spawn/human/corpse/ncr/sergeant
	name = "NCR Sergeant"
	uniform = /obj/item/clothing/under/f13/ncr
	suit = /obj/item/clothing/suit/armor/f13/ncrarmor/reinforced
	shoes = /obj/item/clothing/shoes/f13/military/ncr
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/f13/ncr
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/legion
	name = "Legion"
	desc = "Just a Legion"
	icon_state = "legion_prime"
	icon_living = "legion_prime"
	icon_dead = "legion_prime"
	icon_gib = "legion_prime"
	faction = list("legion")
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
	faction = list("hostile")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	speak = list("Ave, true to Caesar.", "True to Caesar.", "Ave, Amicus.", "The new slave girls are quite beautiful.", "Give me cause, Profligate.", "Degenerates like you belong on a cross.")
	speak_emote = list("says")
	speak_chance = 1

/obj/effect/mob_spawn/human/corpse/legion
	name = "Legion Prime"
	uniform = /obj/item/clothing/under/f13/rag
	suit = /obj/item/clothing/suit/armor/f13/legion/recruit
	shoes = /obj/item/clothing/shoes/f13/military/leather
	//gloves = /obj/item/clothing/gloves/f13/ncr
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/f13/legion/prime
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/legion/prime
	name = "Legion Prime"
	desc = "Just a Legion Prime"
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
	projectilesound = 'sound/weapons/garandshot.ogg'
	casingtype = /obj/item/ammo_casing/a762

/mob/living/simple_animal/hostile/legion/decan
	name = "Legion Decan"
	desc = "Just a Legion Decan"
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
	projectilesound = 'sound/weapons/garandshot.ogg'
	casingtype = /obj/item/ammo_casing/a762

/obj/effect/mob_spawn/human/corpse/legion/decan
	name = "Legion Decan"
	uniform = /obj/item/clothing/under/f13/rag
	suit = /obj/item/clothing/suit/armor/f13/legion/vet
	shoes = /obj/item/clothing/shoes/f13/military/leather
	gloves = /obj/item/clothing/gloves/f13/doom
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/f13/legion/prime/decan
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/raider
	name = "raiding npc"
	desc = "this firefighter was once a man too."
	icon_state = "firefighter_raider"
	icon_living = "firefighter_raider"
	icon_dead = "firefighter_raider"
	icon_gib = "firefighter_raider"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
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
	melee_damage_lower = 20
	melee_damage_upper = 30
	attack_verb_simple = "attacks"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = list(/obj/effect/mob_spawn/human/corpse/raider)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("raiders")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	speak = "Yes!"
	speak_emote = list("rushes")
	speak_chance = 2

/mob/living/simple_animal/hostile/raider/sulphite
	name = "Sulphite Brawler"
	desc = "A raider with low military grade armor and a shishkebab"
	icon_state = "melee_sulphitemob"
	icon_living = "melee_sulphitemob"
	turns_per_move = 5
	response_help_simple = "pokes"
	response_disarm_simple = "shoves"
	response_harm_simple = "hits"
	speed = 1
	stat_attack = 1
	robust_searching = 1
	maxHealth = 220
	health = 220
	harm_intent_damage = 8
	melee_damage_lower = 40
	melee_damage_upper = 55
	attack_verb_simple = "attacks"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	loot = list(/obj/effect/mob_spawn/human/corpse/raider)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	loot = list(/obj/effect/mob_spawn/human/corpse/raidermelee, /obj/item/locked_box/misc/money/all/low)
	unsuitable_atmos_damage = 15
	faction = list("raiders")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	speak = "Yes!"
	speak_emote = list("rushes")
	speak_chance = 2

/obj/effect/mob_spawn/human/corpse/raider
	name = "Raider"
	uniform = /obj/item/clothing/under/f13/rag
	suit = /obj/item/clothing/suit/armor/f13/tribal
	shoes = /obj/item/clothing/shoes/f13/rag
	//gloves = /obj/item/clothing/gloves/f13/ncr
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/f13/firefighter
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/raider/Aggro()
	..()
	summon_backup(15)
	say("HURRY, HURRY, HURRY!!!")

/mob/living/simple_animal/hostile/raider/firefighter
	icon_state = "firefighter_raider"
	icon_living = "firefighter_raider"
	icon_dead = "firefighter_raider"
	icon_gib = "firefighter_raider"
	retreat_distance = 0
	minimum_distance = 0
	melee_damage_lower = 50
	melee_damage_upper = 50
	loot = list(/obj/effect/mob_spawn/human/corpse/raider)
	healable = 1
	ranged = 0

/mob/living/simple_animal/hostile/raider/tribal
	icon_state = "tribal_raider"
	icon_living = "tribal_raider"
	icon_dead = "tribal_raider"
	icon_gib = "tribal_raider"
	retreat_distance = 0
	minimum_distance = 0
	melee_damage_lower = 40
	melee_damage_upper = 40
	loot = list(/obj/effect/mob_spawn/human/corpse/raider/tribal)
	healable = 1
	ranged = 0

/obj/effect/mob_spawn/human/corpse/raider/tribal
	uniform = /obj/item/clothing/under/f13/rag
	suit = /obj/item/clothing/suit/armor/f13/raider/sadist
	shoes = /obj/item/clothing/shoes/f13/rag
	//gloves = /obj/item/clothing/gloves/f13/doom
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/f13/headscarf
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/raider/baseball
	icon_state = "baseball_raider"
	icon_living = "baseball_raider"
	icon_dead = "baseball_raider"
	icon_gib = "baseball_raider"
	retreat_distance = 1
	minimum_distance = 1
	melee_damage_lower = 40
	melee_damage_upper = 40
	maxHealth = 200
	health = 200
	loot = list(/obj/effect/mob_spawn/human/corpse/raider/baseball)
	healable = 1
	ranged = 0

/obj/effect/mob_spawn/human/corpse/raider/baseball
	uniform = /obj/item/clothing/under/f13/rag
	suit = /obj/item/clothing/suit/armor/f13/raider/yankee
	shoes = /obj/item/clothing/shoes/f13/rag
	//gloves = /obj/item/clothing/gloves/f13/doom
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/f13/raider/yankee
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/raider/biker
	icon_state = "biker_raider"
	icon_living = "biker_raider"
	icon_dead = "biker_raider"
	icon_gib = "biker_raider"
	retreat_distance = 4
	minimum_distance = 4
	melee_damage_lower = 20
	melee_damage_upper = 20
	maxHealth = 200
	health = 200
	loot = list(/obj/effect/mob_spawn/human/corpse/raider/biker)
	healable = 1
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/m44/simple
	projectilesound = 'sound/f13weapons/magnum_fire.ogg'
	casingtype = /obj/item/ammo_casing/m44

/obj/effect/mob_spawn/human/corpse/raider/biker
	uniform = /obj/item/clothing/under/f13/rag
	suit = /obj/item/clothing/suit/armor/f13/slam
	shoes = /obj/item/clothing/shoes/f13/rag
	//gloves = /obj/item/clothing/gloves/f13/doom
	//radio = /obj/item/device/radio/headset
	//mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/f13/motorcycle
	//back = /obj/item/weapon/storage/backpack

/mob/living/simple_animal/hostile/abomination
	name = "abomination"
	desc = "A horrible fusion of man, animal, and something entirely different. It quakes and shudders, looking to be in an immense amount of pain. Blood and other fluids ooze from various gashes and lacerations on its body, punctuated by mouths that gnash and scream."
	speak_emote = list("screams", "clicks", "chitters", "barks", "moans", "growls", "meows", "reverberates", "roars", "squeaks", "rattles", "exclaims", "yells", "remarks", "mumbles", "jabbers", "stutters", "seethes")
	icon_state = "abomination"
	icon_living = "abomination"
	icon_dead = "abomination_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	robust_searching = 1
	maxHealth = 1000
	health = 1000
	harm_intent_damage = 8
	melee_damage_lower = 75
	melee_damage_upper = 75
	attack_verb_simple = "eviscerates"
	attack_sound = 'sound/weapons/punch1.ogg'
	attack_verb_simple = "lacerates"
	speed = -0.5
	var/static/list/abom_sounds
	deathmessage = "wails as its form shudders and violently comes to a stop."
	death_sound = 'sound/voice/abomburning.ogg'

/mob/living/simple_animal/hostile/abomination/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
		var/choice = pick(1, 1, 1, 2, 3, 5)
		H.reagents.add_reagent(/datum/reagent/toxin/FEV_solution, choice)

/mob/living/simple_animal/hostile/abomination/Initialize()
	. = ..()
	abom_sounds = list('sound/voice/abomination1.ogg', 'sound/voice/abomscream.ogg', 'sound/voice/abommoan.ogg', 'sound/voice/abomscream2.ogg', 'sound/voice/abomscream3.ogg')

/mob/living/simple_animal/hostile/abomination/say(message, datum/language/language = null, list/spans = list(), language, sanitize, ignore_spam, forced = null)
	..()
	if(stat)
		return
	var/chosen_sound = pick(abom_sounds)
	playsound(src, chosen_sound, 50, TRUE)

/mob/living/simple_animal/hostile/abomination/Life()
	..()
	if(stat)
		return
	if(prob(10))
		var/chosen_sound = pick(abom_sounds)
		playsound(src, chosen_sound, 70, TRUE)

/mob/living/simple_animal/hostile/abomhorror
	name = "failed experiment"
	desc = "A terrible fusion of man, animal, and something else entirely. It looks to be in great pain."
	speak_emote = list("screams", "clicks", "chitters", "barks", "moans", "growls", "meows", "reverberates", "roars", "squeaks", "rattles", "exclaims", "yells", "remarks", "mumbles", "jabbers", "stutters", "seethes")
	icon_state = "horror"
	icon_living = "horror"
	icon_dead = "horror_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	robust_searching = 1
	maxHealth = 700
	health = 700
	harm_intent_damage = 8
	melee_damage_lower = 50
	melee_damage_upper = 50
	attack_verb_simple = "eviscerates"
	attack_sound = 'sound/weapons/punch1.ogg'
	attack_verb_simple = "lacerates"
	speed = -0.5
	var/static/list/abom_sounds
	deathmessage = "wails as its form shudders and violently comes to a stop."

/mob/living/simple_animal/hostile/abomhorror/nsb
	maxHealth = 1000
	health = 1000
	desc = "A terrible fusion of man, animal, and something else entirely. It looks to be in great pain, constantly shuddering violently and seeming relatively docile to the robots and raiders of the bunker. Huh."
	harm_intent_damage = 8
	melee_damage_lower = 60
	melee_damage_upper = 70
	obj_damage = 300
	faction = list("raider")
	wound_bonus = 20
	speed = -1
	deathmessage = "wails as its form shudders and violently comes to a stop."

/mob/living/simple_animal/hostile/abomhorror/nsb/Initialize()
	. = ..()
	abom_sounds = list('sound/voice/abomination1.ogg', 'sound/voice/abomscream.ogg', 'sound/voice/abommoan.ogg', 'sound/voice/abomscream2.ogg', 'sound/voice/abomscream3.ogg')

/mob/living/simple_animal/hostile/abomhorror/nsb/say(message, datum/language/language = null, list/spans = list(), language, sanitize, ignore_spam, forced = null)
	..()
	if(stat)
		return
	var/chosen_sound = pick(abom_sounds)
	playsound(src, chosen_sound, 50, TRUE)

/mob/living/simple_animal/hostile/abomhorror/nsb/Life()
	..()
	if(stat)
		return
	if(prob(10))
		var/chosen_sound = pick(abom_sounds)
		playsound(src, chosen_sound, 70, TRUE)