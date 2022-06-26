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
	maxHealth = 140
	health = 140
	healable = 1
	speed = 1.2
	check_friendly_fire = 1
	stat_attack = 1
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
	loot = list(/obj/item/stack/f13Cash/random/med)

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
	maxHealth = 200
	health = 200
	healable = 1
	ranged = 1
	check_friendly_fire = 1
	retreat_distance = 6
	minimum_distance = 2
	extra_projectiles = 2
	ranged_cooldown_time = 10
	projectiletype = /obj/item/projectile/bullet/c10mm/simple
	projectilesound = 'sound/f13weapons/10mm_fire_01.ogg'
	loot = list(/obj/effect/spawner/bundle/f13/m1911)
	robust_searching = TRUE
	speak = list("Come get some!", "Fuck off!", "Landon's going to promote me after this!", "Bullets for days!", "Renegades represent!")
	speak_emote = list("says")
	speak_chance = 1

// LIGHT SHOTGUN VARIANT
/mob/living/simple_animal/hostile/renegade/engie
	name = "Renegade Engie"
	desc = "Demolitions and engineering expert of the Renegades."
	icon_state = "renegade_engie"
	icon_living = "renegade_engie"
	icon_dead = "renegade_engie-dead"
	maxHealth = 200
	health = 200
	healable = 1
	speed = 1.2
	ranged = 1
	check_friendly_fire = 1
	obj_damage = 200
	retreat_distance = 4
	minimum_distance = 1
	ranged_cooldown_time = 4
	projectiletype = /obj/item/projectile/bullet/pellet/shotgun_buckshot
	projectilesound = 'sound/f13weapons/shotgun.ogg'
	casingtype = /obj/item/ammo_casing/shotgun
	loot = list(/obj/item/stack/f13Cash/random/med, /obj/effect/spawner/lootdrop/f13/bomb/tier1, /obj/effect/spawner/lootdrop/f13/crafting)
	robust_searching = TRUE
	speak = list("Come get some!", "Going to blow some shit to kingdom come!", "I got the goods!", "Nades for days!", "Renegades represent!")
	speak_emote = list("says")
	speak_chance = 1

// MEDIUM RANGED VARIANT
/mob/living/simple_animal/hostile/renegade/soldier
	name = "Renegade Soldier"
	desc = "The beefier side of the Renegade's muscle; with combat experience to back it."
	icon_state = "renegade_soldier"
	icon_living = "renegade_soldier"
	icon_dead = "renegade_soldier-dead"
	ranged = TRUE
	maxHealth = 300
	health = 300
	healable = 1
	speed = 1.1
	ranged = 1
	check_friendly_fire = 1
	retreat_distance = 7
	minimum_distance = 3
	extra_projectiles = 2
	ranged_cooldown_time = 6
	projectiletype = /obj/item/projectile/bullet/c10mm/simple
	projectilesound = 'sound/f13weapons/combatrifle.ogg'
	loot = list(/obj/item/stack/f13Cash/random/med, /obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier2)
	robust_searching = TRUE
	speak = list("Come get some!", "I like my odds, c'mere!", "Gonna get a promotion after this!", "Bullets for days!", "Renegades represent!")
	speak_emote = list("says")
	speak_chance = 1

//MEDIUM MELEE VARIANT
/mob/living/simple_animal/hostile/renegade/defender
	name = "Renegade Defender"
	desc = "The Renegade member who's sole purpose is to withstand punishment with layers of advanced combat armor."
	icon_state = "renegade_defender"
	icon_living = "renegade_defender"
	icon_dead = "renegade_defender-dead"
	ranged = TRUE
	maxHealth = 750
	health = 750
	healable = 1
	speed = 0.1
	check_friendly_fire = 1
	melee_damage_lower = 30
	melee_damage_upper = 40
	attack_verb_simple = "bashes"
	attack_sound = 'sound/weapons/slam.ogg'
	a_intent = INTENT_HARM
	loot = list(/obj/effect/spawner/lootdrop/f13/weapon/melee/random, /obj/effect/spawner/lootdrop/f13/alcoholspawner, /obj/effect/spawner/lootdrop/f13/ncr_c_ration)
	emote_taunt = list("bashes their shield with the mace")
	robust_searching = TRUE
	speak = list("COME AND TRY ME, BITCH!", "I AM THE WALL!", "LAYERS ON LAYERS OF PLATES!", "I AM TITANIUM!", "RENEGADES REPRESENT!")
	speak_emote = list("says")
	speak_chance = 1

//HEAVY RANGED VARIANT
/mob/living/simple_animal/hostile/renegade/drifter
	name = "Renegade Drifter"
	desc = "A veteran of the Renegades, specializing in recon and long range engagements."
	icon_state = "renegade_drifter"
	icon_living = "renegade_drifter"
	icon_dead = "renegade_drifter-dead"
	ranged = TRUE
	maxHealth = 280
	health = 280
	healable = 1
	speed = 1.3
	ranged = 1
	vision_range = 12
	aggro_vision_range = 15
	check_friendly_fire = 1
	retreat_distance = 10
	minimum_distance = 6
	ranged_cooldown_time = 10
	projectiletype = /obj/item/projectile/bullet/a762/sport/simple
	projectilesound = 'sound/f13weapons/bozar_fire.ogg'
	loot = list(/obj/item/stack/f13Cash/random/high, /obj/effect/spawner/bundle/f13/remington, /obj/effect/spawner/lootdrop/f13/armor/random)
	robust_searching = TRUE
	speak = list("Come get some!", "I am the shadow!", "One shot, one kill.", "Adjusting my scope.", "Renegades represent!")
	speak_emote = list("says")
	speak_chance = 1

// HEAVY SHOTGUN VARIANT
/mob/living/simple_animal/hostile/renegade/guardian
	name = "Renegade Guardian"
	desc = "A veteran of the Renegades,specializing in close quarters and crowd control.. with an automatic shotgun."
	icon_state = "renegade_guardian"
	icon_living = "renegade_guardian"
	icon_dead = "renegade_guardian-dead"
	ranged = TRUE
	maxHealth = 420
	health = 420
	healable = 1
	speed = 0.9
	ranged = 1
	check_friendly_fire = 1
	minimum_distance = 2
	ranged_cooldown_time = 3
	projectiletype = /obj/item/projectile/bullet/pellet/shotgun_buckshot
	projectilesound = 'sound/f13weapons/auto5.ogg'
	casingtype = /obj/item/ammo_casing/shotgun
	loot = list(/obj/effect/spawner/bundle/f13/trenchshotgun, /obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier1, /obj/item/stack/f13Cash/random/low, /obj/item/clothing/suit/armor/medium/vest/breastplate/light)
	robust_searching = TRUE
	speak = list("Come get some!", "ON THE GROUND!", "GOING TO SHOVE THIS WHERE THE SUN DON'T SHINE!", "C'MERE, I GOT LEAD!", "RENEGADES REPRESENT!")
	speak_emote = list("says")
	speak_chance = 1

// POWER ARMOR VARIANT
/mob/living/simple_animal/hostile/renegade/meister
	name = "Renegade Meister"
	desc = "Is that a merc in power armor?!"
	icon_state = "renegade_meister"
	icon_living = "renegade_meister"
	icon_dead = "renegade_meister-dead"
	maxHealth = 1000
	health = 1000
	healable = 1
	melee_damage_lower = 50
	melee_damage_upper = 50
	retreat_distance = 3
	minimum_distance = 1
	ranged = 1
	attack_verb_simple = "power-fists"
	attack_sound = 'sound/weapons/slam.ogg'
	ranged_cooldown_time = 30
	attack_verb_simple = "power-fists"
	extra_projectiles = 5
	projectiletype = /obj/item/projectile/bullet/m5mm/simple
	projectilesound = 'sound/f13weapons/automaticrifle_BAR.ogg'
	loot = list(/obj/item/book/granter/trait/pa_wear, /obj/item/stack/f13Cash/random/high, /obj/item/advanced_crafting_components/alloys, /obj/item/stack/sheet/plasteel/five)
	speak = list("POWER TO THE ARMOR!", "I AM GOING TO BREAK YOU IN HALF!", "YEAH I COMPENSATE WITH BIG FUCKIN' GUNS", "DODGE THIS!", "PEAK RENEGADE PERFORMANCE!")
	speak_emote = list("says")
	speak_chance = 1

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
	maxHealth = 250
	health = 250
	healable = 1
	ranged = 1
	check_friendly_fire = 1
	retreat_distance = 6
	minimum_distance = 8
	ranged = 1
	projectiletype = /obj/item/projectile/bullet/m44/simple
	projectilesound = 'sound/f13weapons/44mag.ogg'
	casingtype = /obj/item/ammo_casing/m44
	robust_searching = TRUE
	speak = list("Running low on meds.", "Could do with extra combat chems.", "Where'd I put the Syringer?", "I GOT THE MED-BAG!", "Renegades represent and all that jazz.")
	speak_emote = list("says")
	speak_chance = 1
	loot = list(/obj/effect/spawner/lootdrop/f13/medical/vault/meds, /obj/effect/spawner/lootdrop/f13/weapon/revolver44variants, /obj/effect/spawner/lootdrop/f13/medical/surgical/blood)

/mob/living/simple_animal/hostile/renegade/doc/Initialize(mapload)
	. = ..()
	// we only heal BRUTELOSS because each type directly heals a simplemob's health
	// therefore setting it to BRUTELOSS | FIRELOSS | TOXLOSS | OXYLOSS would mean healing 4x as much
	// aka 40% of max life every tick, which is basically unkillable
	// TODO: refactor this if simple_animals ever get damage types
	AddComponent(/datum/component/glow_heal, chosen_targets = /mob/living/simple_animal/hostile/renegade, allow_revival = FALSE, restrict_faction = list("raider"), type_healing = BRUTELOSS)
