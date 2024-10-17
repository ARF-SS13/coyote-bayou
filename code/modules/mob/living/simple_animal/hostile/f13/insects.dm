// INSECTS - In this document: Giant ant, Radscorpion, Cazador, Radroach, Bloatfly, cazador venom


///////////////
// GIANT ANT //
///////////////

/mob/living/simple_animal/hostile/giantant
	name = "giant ant"
	desc = "A giant ant with twitching, darting antennae. Its outsides are a mixture of crusted, unrotting rock and chitin that bounce off bullets and melee weapons. Hardened insides compact once valueless sand and dirt to gemstones. Many a fool in their search for wealth have become part of the gemstones. Can be butchered down the thorax for minerals and shinies."
	icon = 'icons/fallout/mobs/animals/insects.dmi'
	icon_state = "GiantAnt"
	icon_living = "GiantAnt"
	icon_dead = "GiantAnt_dead"
	icon_gib = "GiantAnt_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mob_armor = ARMOR_VALUE_ANTS
	speak_chance = 0
	move_to_delay = 3
	// m2d 3 = standard, less is fast, more is slower.

	retreat_distance = 0
	//how far they pull back

	minimum_distance = 0
	// how close you can get before they try to pull back

	aggro_vision_range = 4 //due to ants poor eyesight
	//tiles within they start attacking, doesn't count the mobs tile

	vision_range = 5
	//tiles within they start making noise, does count the mobs tile

	speak_emote = list("clacks", "chitters", "snips", "snaps")
	// emote_see = list("waggles its antenna", "clicks its mandibles", "picks up your scent", "goes on the hunt")
	attack_verb_simple = list ("rips", "tears", "stings")
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/stack/sheet/sinew = 1, /obj/item/reagent_containers/food/snacks/meat/slab/ant_meat = 2, /obj/effect/spawner/lootdrop/f13/deadantloot = 1)
	butcher_difficulty = 1.5
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	emote_taunt = list("chitters")
	emote_taunt_sound = 'sound/creatures/radroach_chitter.ogg'
	taunt_chance = 30
	speed = 1
	waddle_amount = 2
	waddle_up_time = 1
	waddle_side_time = 1
	maxHealth = 80
	health = 80
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 6
	melee_damage_upper = 20
	attack_verb_simple = "stings"
	attack_sound = 'sound/creatures/radroach_attack.ogg'
	speak_emote = list("skitters")
	faction = list("ant")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM
	blood_volume = 0
	decompose = FALSE
	tastes = list("dirt" = 1, "sand" = 1, "metal?" = 1)
	loot = list(/obj/effect/spawner/lootdrop/f13/common, /obj/effect/gibspawner/larva)
	loot_drop_amount = 1
	loot_amount_random = TRUE

/mob/living/simple_animal/hostile/giantant/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/giantant/Aggro()
	..()
	summon_backup(10)

// FIREANT
/mob/living/simple_animal/hostile/fireant
	name = "fireant"
	desc = "A large reddish ant. The furnace it holds inside itself blasts intruders and the dirt it chews with flaming heat. Its insides contain more gemstones than its unremarkable kin, accessible by butchering them straight down the thorax."
	icon = 'icons/fallout/mobs/animals/insects.dmi'
	icon_state = "FireAnt"
	icon_living = "FireAnt"
	icon_dead = "FireAnt_dead"
	icon_gib = "FireAnt_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	waddle_amount = 2
	waddle_up_time = 1
	waddle_side_time = 1
	guaranteed_butcher_results = list(/obj/item/stack/sheet/sinew = 1, /obj/item/reagent_containers/food/snacks/meat/slab/fireant_meat = 2, /obj/item/reagent_containers/food/snacks/rawantbrain = 1, /obj/effect/spawner/lootdrop/f13/deadantloot = 2)
	butcher_difficulty = 1.5
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	emote_taunt = list("chitters")
	emote_taunt_sound = 'sound/creatures/radroach_chitter.ogg'
	taunt_chance = 30
	speed = 1
	maxHealth = 65
	health = 65
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 8
	melee_damage_upper = 16
	attack_verb_simple = "stings"
	attack_sound = 'sound/creatures/radroach_attack.ogg'
	speak_emote = list("skitters")
	faction = list("ant")
	gold_core_spawnable = HOSTILE_SPAWN
	decompose = FALSE
	a_intent = INTENT_HARM
	blood_volume = 0
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon, /obj/effect/gibspawner/larva)
	loot_drop_amount = 1
	loot_amount_random = TRUE
	extra_projectiles = 3
	ranged = TRUE
	projectiletype = /obj/item/projectile/magic/kelpmagic/magmaspray/weak
	projectilesound = 'sound/weapons/fire03.ogg'

/mob/living/simple_animal/hostile/fireant/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/fireant/Aggro()
	..()
	summon_backup(10)
/*
/mob/living/simple_animal/hostile/fireant/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	H.reagents.add_reagent(/datum/reagent/hellwater, 1)
*/
// ANT QUEEN
/mob/living/simple_animal/hostile/giantantqueen
	name = "giant ant queen"
	desc = "The queen of a giant ant colony. Butchering it seems like a good way to a pretty penny."
	icon = 'icons/fallout/mobs/animals/antqueen.dmi'
	icon_state = "antqueen"
	icon_living = "antqueen"
	icon_dead = "antqueen_dead"
	icon_gib = "GiantAnt_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/stack/sheet/sinew = 3, /obj/item/reagent_containers/food/snacks/meat/slab/ant_meat = 6, /obj/item/stack/sheet/animalhide/chitin = 6, /obj/item/reagent_containers/food/snacks/rawantbrain = 1, /obj/effect/spawner/lootdrop/f13/deadantloot = 5)
	butcher_difficulty = 1.5
	loot = list(/obj/item/reagent_containers/food/snacks/f13/giantantegg = 10, /obj/effect/gibspawner/larva)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	emote_taunt = list("chitters")
	emote_taunt_sound = 'sound/creatures/radroach_chitter.ogg'
	taunt_chance = 30
	speed = 5
	maxHealth = 560
	health = 560
	ranged = 1
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_simple = "stings"
	attack_sound = 'sound/creatures/radroach_attack.ogg'
	projectiletype = /obj/item/projectile/bile
	projectilesound = 'sound/f13npc/centaur/spit.ogg'
	extra_projectiles = 2
	speak_emote = list("skitters")
	retreat_distance = 5
	minimum_distance = 7
	faction = list("ant")
	gold_core_spawnable = HOSTILE_SPAWN
	decompose = FALSE
	a_intent = INTENT_HARM
	var/max_mobs = 2
	var/mob_types = list(/mob/living/simple_animal/hostile/giantant)
	var/spawn_time = 30 SECONDS
	//var/spawn_text = "hatches from"
	blood_volume = 0
	loot = list(/obj/effect/spawner/lootdrop/f13/rare, /obj/effect/gibspawner/larva)
	loot_drop_amount = 5
	loot_amount_random = TRUE


/mob/living/simple_animal/hostile/giantantqueen/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner, mob_types, spawn_time, faction, /*spawn_text,*/ max_mobs, _range = 7)

/mob/living/simple_animal/hostile/giantantqueen/death()
	RemoveComponentByType(/datum/component/spawner)
	. = ..()

/mob/living/simple_animal/hostile/giantantqueen/Destroy()
	RemoveComponentByType(/datum/component/spawner)
	. = ..()

/mob/living/simple_animal/hostile/giantantqueen/Aggro()
	..()
	summon_backup(10)

/obj/item/projectile/bile
	name = "spit"
	damage = 20
	icon_state = "toxin"

/////////////////
// RADSCORPION //
/////////////////

/mob/living/simple_animal/hostile/radscorpion
	name = "giant radscorpion"
	desc = "A mutated arthropod with an armored carapace and a powerful sting."
	icon = 'icons/fallout/mobs/animals/insects.dmi'
	icon_state = "radscorpion"
	icon_living = "radscorpion"
	icon_dead = "radscorpion_dead"

	speed = 1.25
	maxHealth = 120
	health = 120
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 15
	melee_damage_upper = 28
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 1
	move_to_delay = 3
	// m2d 3 = standard, less is fast, more is slower.

	retreat_distance = 0
	//how far they pull back

	minimum_distance = 0
	// how close you can get before they try to pull back

	aggro_vision_range = 4 //due to scorpions poor eyesight
	//tiles within they start attacking, doesn't count the mobs tile

	vision_range = 5
	//tiles within they start making noise, does count the mobs tile

	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/radscorpion_meat = 2)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	a_intent = INTENT_HARM
	attack_verb_simple = "stings"
	attack_sound = 'sound/creatures/radscorpion_attack.ogg'
	speak_emote = list("hisses")
	faction = list("radscorpion")
	gold_core_spawnable = HOSTILE_SPAWN
	var/scorpion_color = "radscorpion" //holder for icon set
	var/list/icon_sets = list("radscorpion", "radscorpion_blue", "radscorpion_black")
	blood_volume = 0
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon, /obj/effect/gibspawner/larva)
	loot_drop_amount = 1
	loot_amount_random = TRUE
	emote_taunt = list("snips")

	emote_taunt_sound = list('sound/f13npc/scorpion/taunt1.ogg', 'sound/f13npc/scorpion/taunt2.ogg', 'sound/f13npc/scorpion/taunt3.ogg')
	emote_taunt_sound = list('sound/f13npc/scorpion/aggro.ogg', )
	idlesound = list('sound/creatures/radscorpion_snip.ogg', )
	death_sound = 'sound/f13npc/scorpion/death.ogg'


/mob/living/simple_animal/hostile/radscorpion/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	H.reagents.add_reagent(/datum/reagent/toxin, 5)

/mob/living/simple_animal/hostile/radscorpion/Initialize()
	. = ..()
	scorpion_randomify()
	update_icons()

/mob/living/simple_animal/hostile/radscorpion/proc/scorpion_randomify()
	scorpion_color = pick(icon_sets)
	icon_state = "[scorpion_color]"
	icon_living = "[scorpion_color]"
	icon_dead = "[scorpion_color]_dead"

// BLACK RADSCORPION - a little tougher and slower
/mob/living/simple_animal/hostile/radscorpion/black
	name = "giant rad scorpion"
	desc = "A giant irradiated scorpion with a black exoskeleton. Its appearance makes you shudder in fear.<br>This one has giant pincers."
	icon_state = "radscorpion_black"
	icon_living = "radscorpion_black"
	icon_dead = "radscorpion_black_d"
	speed = 1.2
	maxHealth = 160
	health = 160
	melee_damage_lower = 10
	melee_damage_upper = 28
	move_to_delay = 4
	footstep_type = FOOTSTEP_MOB_CLAW


// BLUE RADSCORPION - a little weaker and faster
/mob/living/simple_animal/hostile/radscorpion/blue
	name = "giant rad scorpion"
	desc = "A giant irradiated scorpion with a bluish exoskeleton. Slighly smaller and faster than its reddish cousin."
	icon_state = "radscorpion_blue"
	icon_living = "radscorpion_blue"
	icon_dead = "radscorpion_blue_d"
	icon_gib = "radscorpion_blue_gib"
	speed = 1.35
	maxHealth = 110
	health = 110
	move_to_delay = 2
	footstep_type = FOOTSTEP_MOB_CLAW

/////////////
// CAZADOR //
/////////////

/mob/living/simple_animal/hostile/cazador
	name = "cazador"
	desc = "A mutated insect known for its fast speed, deadly sting, and being huge bastards."
	icon = 'icons/fallout/mobs/animals/insects.dmi'
	icon_state = "cazador"
	icon_living = "cazador"
	icon_dead = "cazador_dead1"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5

	move_to_delay = 3
	// m2d 3 = standard, less is fast, more is slower.

	retreat_distance = 3
	//how far they pull back

	minimum_distance = 1
	// how close you can get before they try to pull back

	aggro_vision_range = 7 //due to scorpions poor eyesight
	//tiles within they start attacking, doesn't count the mobs tile

	vision_range = 8
	//tiles within they start making noise, does count the mobs tile
	rapid_melee = 2

	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/cazador_meat = 2, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/animalhide/chitin = 2)
	butcher_difficulty = 1.5
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	emote_taunt = list("buzzes")
	emote_taunt_sound = list('sound/f13npc/cazador/cazador_alert.ogg')
	emote_taunt_sound = list('sound/f13npc/cazador/cazador_charge1.ogg', 'sound/f13npc/cazador/cazador_charge2.ogg', 'sound/f13npc/cazador/cazador_charge3.ogg')
	idlesound = list('sound/creatures/cazador_buzz.ogg')
	robust_searching = TRUE
	taunt_chance = 30
	speed = 1
	maxHealth = 24
	health = 24
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 5
	melee_damage_upper = 10
	attack_verb_simple = "stings"
	attack_sound = 'sound/creatures/cazador_attack.ogg'
	speak_emote = list("buzzes")
	faction = list("cazador")
	movement_type = FLYING
	a_intent = INTENT_HARM
	pass_flags = PASSTABLE | PASSMOB
	gold_core_spawnable = HOSTILE_SPAWN
	death_sound = 'sound/f13npc/cazador/cazador_death.ogg'
	blood_volume = 0
	loot = list(/obj/effect/spawner/lootdrop/f13/trash, /obj/effect/gibspawner/larva)
	loot_drop_amount = 1
	loot_amount_random = TRUE

/mob/living/simple_animal/hostile/cazador/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	H.reagents.add_reagent(/datum/reagent/toxin/cazador_venom, 5)

/mob/living/simple_animal/hostile/cazador/death(gibbed)
	icon_dead = "cazador_dead[rand(1,5)]"
	. = ..()

/mob/living/simple_animal/hostile/cazador/bullet_act(obj/item/projectile/Proj)
	if(!Proj)
		return
	if(prob(50))
		return ..()
	else
		//visible_message(span_danger("[src] dodges [Proj]!"))
		return 0


/mob/living/simple_animal/hostile/cazador/young
	name = "young cazador"
	desc = "A mutated insect known for its fast speed, deadly sting, and being huge bastards. This one's little."
	maxHealth = 20
	health = 20
	speed = 1
	melee_damage_lower = 5
	melee_damage_upper = 10
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/cazador_meat = 1, /obj/item/stack/sheet/animalhide/chitin = 1, /obj/item/stack/sheet/sinew = 1)
	butcher_difficulty = 1.5

/mob/living/simple_animal/hostile/cazador/young/Initialize()
	. = ..()
	resize = 0.8
	update_transform()

/datum/reagent/toxin/cazador_venom
	name = "cazador venom"
	description = "A painful but relatively harmless venom, originally synthesized by tarantula hawks."
	reagent_state = LIQUID
	color = "#801E28" // rgb: 128, 30, 40
	toxpwr = 0.5
	taste_description = "pain"
	taste_mult = 1.3

/datum/reagent/toxin/cazador_venom/on_mob_life(mob/living/carbon/M)
	M.adjustStaminaLoss(10, 0)
	var/concentration = M.reagents.get_reagent_amount(/datum/reagent/toxin/cazador_venom)
	M.damageoverlaytemp = concentration * 10
	M.update_damage_hud()
	if (M.eye_blurry < 5)
		M.adjust_blurriness(1)
	if (M.confused < 20)
		M.confused += 3
	if(prob(10))
		var/pain_message = pick("You feel horrible pain.", "It burns like a red hot iron", "You can hardly bear the agony")
		to_chat(M, span_warning("[pain_message]"))
	..()

/datum/reagent/toxin/cazador_venom/on_mob_life_synth(mob/living/M)
	M.adjustStaminaLoss(10, 0)
	if (M.eye_blurry < 5)
		M.adjust_blurriness(1)
	if (M.confused < 20)
		M.confused += 3
	if(prob(5))
		var/pain_message = pick("Your electronics can't handle the potent venom.", "Your pain sensors are overloaded.", "Invasive chemicals are making you short curcuit.")
		to_chat(M, span_notice("[pain_message]"))
	..()

//////////////
// BLOATFLY //
//////////////

/mob/living/simple_animal/hostile/bloatfly
	name = "bloatfly"
	desc = "A common mutated pest resembling an oversized blow-fly."
	icon = 'icons/fallout/mobs/animals/insects.dmi'
	icon_state = "bloatfly"
	icon_living = "bloatfly"
	icon_dead = "bloatfly_dead"
	icon_gib = null
	ranged = TRUE

	speed = 1
	maxHealth = 20
	health = 20
	harm_intent_damage = 8
	obj_damage = 15
	melee_damage_lower = 4
	melee_damage_upper = 7
	waddle_amount = 4
	waddle_up_time = 3
	waddle_side_time = 2
	can_ghost_into = TRUE
	retreat_distance = 3
	minimum_distance = 2

	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(
				/obj/item/reagent_containers/food/snacks/meat/slab/bloatfly_meat = 2,
				/obj/item/stack/sheet/sinew = 1)
	butcher_difficulty = 1.5
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "bites"
	emote_taunt = list("growls")
	taunt_chance = 30
	attack_verb_simple = "bites"
	attack_sound = 'sound/creatures/bloatfly_attack.ogg'
	speak_emote = list("chitters")

	faction = list("hostile", "gecko", "critter-friend")
	gold_core_spawnable = HOSTILE_SPAWN
	pass_flags = PASSTABLE | PASSMOB
	density = FALSE
	a_intent = INTENT_HARM
	idlesound = list('sound/f13npc/bloatfly/fly.ogg')
	blood_volume = 0
	casingtype = /obj/item/ammo_casing/shotgun/bloatfly
	projectiletype = null
	projectilesound = 'sound/f13npc/bloatfly/shoot2.ogg'
	//sound_after_shooting = 'sound/f13npc/bloatfly/afterfire1.ogg'
	//sound_after_shooting_delay = 1 SECONDS
	extra_projectiles = 1
	auto_fire_delay = GUN_BURSTFIRE_DELAY_NORMAL
	ranged_cooldown_time = 3 SECONDS
	variation_list = list(
		MOB_COLOR_VARIATION(200, 200, 200, 255, 255, 255),
		MOB_CASING_LIST(\
			MOB_CASING_ENTRY(/obj/item/ammo_casing/shotgun/bloatfly, 4),\
			MOB_CASING_ENTRY(/obj/item/ammo_casing/shotgun/bloatfly/two, 3),\
			MOB_CASING_ENTRY(/obj/item/ammo_casing/shotgun/bloatfly/three, 3)\
		)
	)
	desc_short = "A gigantic fly that's more disgusting than actually threatening. Tends to dodge bullets."
	pop_required_to_jump_into = BIG_MOB_MIN_PLAYERS
	loot = list(/obj/effect/spawner/lootdrop/f13/trash, /obj/effect/gibspawner/larva)
	loot_drop_amount = 1
	loot_amount_random = TRUE

/mob/living/simple_animal/hostile/bloatfly/bullet_act(obj/item/projectile/Proj)
	if(!Proj)
		return
	if(prob(50))
		//visible_message(span_danger("[src] dodges [Proj]!"))
		return BULLET_ACT_FORCE_PIERCE
	else
		. = ..()

/mob/living/simple_animal/hostile/bloatfly/become_the_mob(mob/user)
	call_backup = /obj/effect/proc_holder/mob_common/summon_backup/small_critter
	send_mobs = /obj/effect/proc_holder/mob_common/direct_mobs/small_critter
	. = ..()

//////////////
// Pillbug //
//////////////

/mob/living/simple_animal/hostile/pillbug
	name = "mutant pillbug"
	desc = "A large mutated insect that finds its way everywhere."
	icon = 'modular_coyote/icons/mob/pillbug.dmi'
	icon_state = "pillbug"
	icon_living = "pillbug"
	icon_dead = "pillbug_dead"
	icon_gib = "radroach_gib"
	can_ghost_into = TRUE
	move_to_delay = 4
	waddle_amount = 1
	waddle_up_time = 1
	waddle_side_time = 1
	loot = list(/obj/effect/spawner/lootdrop/f13/trash, /obj/effect/gibspawner/larva)
	loot_drop_amount = 1
	loot_amount_random = TRUE
	speed = 1
	maxHealth = 20
	health = 20
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 4
	melee_damage_upper = 6

	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/radroach_meat = 2, /obj/item/stack/sheet/sinew = 1)
	butcher_difficulty = 1.5
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	attack_verb_simple = "nips"
	attack_sound = 'sound/creatures/radroach_attack.ogg'
	speak_emote = list("skitters")
	faction = list("gecko", "critter-friend")
	a_intent = INTENT_HARM
	pass_flags = PASSTABLE | PASSMOB
	density = FALSE
	gold_core_spawnable = HOSTILE_SPAWN
	randpixel = 12
	variation_list = list(
		MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255),
		MOB_SPEED_LIST(2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(100),
		MOB_HEALTH_LIST(10, 20, 1),
		MOB_RETREAT_DISTANCE_LIST(0, 2, 3),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(1, 2, 3), //teehee ~TK <3
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(30),
	)

	emote_taunt_sound = list('sound/creatures/radroach_chitter.ogg',)
	idlesound = list('sound/f13npc/roach/idle1.ogg', 'sound/f13npc/roach/idle2.ogg', 'sound/f13npc/roach/idle3.ogg',)
	death_sound = 'sound/f13npc/roach/roach_death.ogg'
	desc_short = "One of countless bugs that move in gross hordes."
	pop_required_to_jump_into = SMALL_MOB_MIN_PLAYERS
	retreat_health_percent = 0.99
	max_heal_amount = 0.9
	heal_per_life = 0.115 // just about!
	tactical_retreat = 9
	actual_retreat_message = "The %NAME skitters away from %TARGET like a lunatic!"
	healing_message = "The %NAME bandages itself!" // ye, oh easily, thats why I love procs~

/mob/living/simple_animal/hostile/pillbug/become_the_mob(mob/user)
	call_backup = /obj/effect/proc_holder/mob_common/summon_backup/small_critter
	send_mobs = /obj/effect/proc_holder/mob_common/direct_mobs/small_critter
	. = ..()
//Variants for Radroachers

/mob/living/simple_animal/hostile/pillbug/micro
	name = "Micro Pillbug"
	maxHealth = 20
	health = 20
	melee_damage_lower = 2
	melee_damage_upper = 6
	variation_list = list(
		MOB_COLOR_VARIATION(200, 200, 200, 250, 250, 250), //Rmin, Gmin, Bmin, Rmax, Gmax, Bmax
		MOB_SPEED_LIST(1.8, 2.0, 2.2),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(80),
		MOB_HEALTH_LIST(10, 13, 15),
		MOB_RETREAT_DISTANCE_LIST(0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
		MOB_MINIMUM_DISTANCE_LIST(1, 2),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
	) //same as a newt for how they attack

/mob/living/simple_animal/hostile/pillbug/micro/Initialize()
	.=..()
	resize = 0.75
	update_transform()

/mob/living/simple_animal/hostile/pillbug/micro/become_the_mob(mob/user)
	call_backup = /obj/effect/proc_holder/mob_common/summon_backup/small_critter
	send_mobs = /obj/effect/proc_holder/mob_common/direct_mobs/small_critter
	. = ..()

/mob/living/simple_animal/hostile/pillbug/strongradroach
	maxHealth = 140
	health = 140
	name = "Macro Pillbug"
	maxHealth = 40
	health = 40
	melee_damage_lower = 10
	melee_damage_upper = 20
	variation_list = list(
		MOB_COLOR_VARIATION(80, 80, 80, 125, 125, 125), //Rmin, Gmin, Bmin, Rmax, Gmax, Bmax
		MOB_SPEED_LIST(2.9, 3.3, 3.5),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(80),
		MOB_HEALTH_LIST(15, 20, 22),
		MOB_RETREAT_DISTANCE_LIST(0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
		MOB_MINIMUM_DISTANCE_LIST(1, 2),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
	) //same as a newt for how they attack

/mob/living/simple_animal/hostile/pillbug/strongradroach/become_the_mob(mob/user)
	call_backup = /obj/effect/proc_holder/mob_common/summon_backup/small_critter
	send_mobs = /obj/effect/proc_holder/mob_common/direct_mobs/small_critter
	. = ..()

/mob/living/simple_animal/hostile/pillbug/leader
	name = "Pillbug Leader"
	maxHealth = 40
	health = 40
	melee_damage_lower = 20
	melee_damage_upper = 30
	retreat_distance = 9
	minimum_distance = 7
	aggro_vision_range = 7
	vision_range = 9
	ranged = TRUE
	can_glow_revive = FALSE
	variation_list = list(
		MOB_COLOR_VARIATION(245, 215, 0, 255, 220, 5), //Rmin, Gmin, Bmin, Rmax, Gmax, Bmax
		MOB_SPEED_LIST(4, 4.2, 4.3),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(80),
		MOB_HEALTH_LIST(70, 75, 80),
		MOB_RETREAT_DISTANCE_LIST(0, 1),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
		MOB_MINIMUM_DISTANCE_LIST(1, 2),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
	) //same as a newt for how they attack

/mob/living/simple_animal/hostile/pillbug/leader/Initialize()
	.=..()
	resize = 2.0
	update_transform()

/mob/living/simple_animal/hostile/pillbug/leader/become_the_mob(mob/user)
	call_backup = /obj/effect/proc_holder/mob_common/summon_backup/small_critter
	send_mobs = /obj/effect/proc_holder/mob_common/direct_mobs/small_critter
	. = ..()

/obj/item/projectile/pillbugsummon
	name = "pillbug summoning"
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

/obj/item/projectile/pillbugsummon/on_hit(atom/target, blocked = FALSE)
	..()
	spawn_and_random_walk(/mob/living/simple_animal/hostile/pillbug/summon, target, 5, walk_chance = 100, max_walk = 10, admin_spawn = FALSE)
	//		break
	return BULLET_ACT_HIT

/mob/living/simple_animal/hostile/pillbug/summon //untameable
	faction = list("gecko")
	can_ghost_into = FALSE
	guaranteed_butcher_results = list()
	butcher_results = list()
	del_on_death = TRUE

/mob/living/simple_animal/hostile/pillbug/leader/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/glow_heal, chosen_targets = /mob/living/simple_animal/hostile/pillbug, allow_revival = TRUE, restrict_faction = null, type_healing = BRUTELOSS)

