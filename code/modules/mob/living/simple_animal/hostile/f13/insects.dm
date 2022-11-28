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
	emote_see = list("waggles its antenna", "clicks its mandibles", "picks up your scent", "goes on the hunt")
	attack_verb_simple = list ("rips", "tears", "stings")
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/stack/sheet/sinew = 1, /obj/item/reagent_containers/food/snacks/meat/slab/ant_meat = 2, /obj/effect/spawner/lootdrop/f13/deadantloot = 1)
	butcher_results = list(/obj/item/stack/sheet/animalhide/chitin = 1)
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
	maxHealth = 128
	health = 128
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 8
	melee_damage_upper = 25
	attack_verb_simple = "stings"
	attack_sound = 'sound/creatures/radroach_attack.ogg'
	speak_emote = list("skitters")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("ant")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM
	blood_volume = 0
	decompose = FALSE
	tastes = list("dirt" = 1, "sand" = 1, "metal?" = 1)

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
	butcher_results = list(/obj/item/stack/sheet/animalhide/chitin = 2)
	butcher_difficulty = 1.5
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	emote_taunt = list("chitters")
	emote_taunt_sound = 'sound/creatures/radroach_chitter.ogg'
	taunt_chance = 30
	speed = 1
	maxHealth = 112
	health = 112
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 10
	melee_damage_upper = 20
	attack_verb_simple = "stings"
	attack_sound = 'sound/creatures/radroach_attack.ogg'
	speak_emote = list("skitters")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("ant")
	gold_core_spawnable = HOSTILE_SPAWN
	decompose = FALSE
	a_intent = INTENT_HARM
	blood_volume = 0

/mob/living/simple_animal/hostile/fireant/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/fireant/Aggro()
	..()
	summon_backup(10)

/mob/living/simple_animal/hostile/fireant/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
		H.reagents.add_reagent(/datum/reagent/hellwater, 1)

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
	butcher_results = list(/obj/item/stack/sheet/animalhide/chitin = 6, /obj/item/reagent_containers/food/snacks/meat/slab/ant_meat = 3)
	butcher_difficulty = 1.5
	loot = list(/obj/item/reagent_containers/food/snacks/f13/giantantegg = 10)
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
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("ant")
	gold_core_spawnable = HOSTILE_SPAWN
	decompose = FALSE
	a_intent = INTENT_HARM
	var/max_mobs = 2
	var/mob_types = list(/mob/living/simple_animal/hostile/giantant)
	var/spawn_time = 30 SECONDS
	var/spawn_text = "hatches from"
	blood_volume = 0


/mob/living/simple_animal/hostile/giantantqueen/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner, mob_types, spawn_time, faction, spawn_text, max_mobs, _range = 7)

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
	melee_damage_upper = 35
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
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/radscorpion_meat = 2)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	a_intent = INTENT_HARM
	attack_verb_simple = "stings"
	attack_sound = 'sound/creatures/radscorpion_attack.ogg'
	speak_emote = list("hisses")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("radscorpion")
	gold_core_spawnable = HOSTILE_SPAWN
	var/scorpion_color = "radscorpion" //holder for icon set
	var/list/icon_sets = list("radscorpion", "radscorpion_blue", "radscorpion_black")
	blood_volume = 0
	emote_taunt = list("snips")

	emote_taunt_sound = list('sound/f13npc/scorpion/taunt1.ogg', 'sound/f13npc/scorpion/taunt2.ogg', 'sound/f13npc/scorpion/taunt3.ogg')
	aggrosound = list('sound/f13npc/scorpion/aggro.ogg', )
	idlesound = list('sound/creatures/radscorpion_snip.ogg', )
	death_sound = 'sound/f13npc/scorpion/death.ogg'


/mob/living/simple_animal/hostile/radscorpion/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
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
	melee_damage_upper = 30
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
	move_to_delay = 4
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

	move_to_delay = 2.0
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
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/cazador_meat = 1, /obj/item/stack/sheet/animalhide/chitin = 1)
	butcher_difficulty = 1.5
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	emote_taunt = list("buzzes")
	emote_taunt_sound = list('sound/f13npc/cazador/cazador_alert.ogg')
	aggrosound = list('sound/f13npc/cazador/cazador_charge1.ogg', 'sound/f13npc/cazador/cazador_charge2.ogg', 'sound/f13npc/cazador/cazador_charge3.ogg')
	idlesound = list('sound/creatures/cazador_buzz.ogg')
	stat_attack = CONSCIOUS
	robust_searching = TRUE
	taunt_chance = 30
	speed = -0.5
	maxHealth = 24
	health = 24
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 5
	melee_damage_upper = 12
	attack_verb_simple = "stings"
	attack_sound = 'sound/creatures/cazador_attack.ogg'
	speak_emote = list("buzzes")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("cazador")
	movement_type = FLYING
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN
	death_sound = 'sound/f13npc/cazador/cazador_death.ogg'
	blood_volume = 0

/mob/living/simple_animal/hostile/cazador/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
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
		visible_message(span_danger("[src] dodges [Proj]!"))
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
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/cazador_meat = 1, /obj/item/stack/sheet/animalhide/chitin = 1)
	butcher_difficulty = 1.5

/mob/living/simple_animal/hostile/cazador/young/Initialize()
	. = ..()
	resize = 0.8
	update_transform()

/datum/reagent/toxin/cazador_venom
	name = "Cazador venom"
	description = "A potent toxin resulting from cazador stings that quickly kills if too much remains in the body."
	color = "#801E28" // rgb: 128, 30, 40
	toxpwr = 1
	taste_description = "pain"
	taste_mult = 1.3

/datum/reagent/toxin/cazador_venom/on_mob_life(mob/living/M)
	if(volume >= 15)
		M.adjustToxLoss(5, 0)
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

	speed = -1
	maxHealth = 20
	health = 20
	harm_intent_damage = 8
	obj_damage = 15
	melee_damage_lower = 5
	melee_damage_upper = 8
	waddle_amount = 4
	waddle_up_time = 3
	waddle_side_time = 2

	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/bloatfly_meat = 2, /obj/item/stack/sheet/sinew = 1)
	butcher_results = list(/obj/item/stack/sheet/animalhide/chitin = 1)
	butcher_difficulty = 1.5
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "bites"
	emote_taunt = list("growls")
	taunt_chance = 30
	attack_verb_simple = "bites"
	attack_sound = 'sound/creatures/bloatfly_attack.ogg'
	speak_emote = list("chitters")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("hostile", "gecko")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM
	blood_volume = 0

/mob/living/simple_animal/hostile/bloatfly/bullet_act(obj/item/projectile/Proj)
	if(!Proj)
		return
	if(prob(50))
		return ..()
	else
		visible_message(span_danger("[src] dodges [Proj]!"))
		return 0

//////////////
// RADROACH //
//////////////

/mob/living/simple_animal/hostile/radroach
	name = "radroach"
	desc = "A large mutated insect that finds its way everywhere."
	icon = 'icons/fallout/mobs/animals/insects.dmi'
	icon_state = "radroach"
	icon_living = "radroach"
	icon_dead = "radroach_dead"
	icon_gib = "radroach_gib"
	waddle_amount = 1
	waddle_up_time = 1
	waddle_side_time = 1

	speed = 1
	maxHealth = 20
	health = 20
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 5
	melee_damage_upper = 8

	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/radroach_meat = 2, /obj/item/stack/sheet/sinew = 1)
	butcher_results = list(/obj/item/stack/sheet/animalhide/chitin = 1)
	butcher_difficulty = 1.5
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	attack_verb_simple = "nips"
	attack_sound = 'sound/creatures/radroach_attack.ogg'
	speak_emote = list("skitters")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("gecko")
	a_intent = INTENT_HARM
	pass_flags = PASSTABLE | PASSMOB
	density = FALSE
	gold_core_spawnable = HOSTILE_SPAWN
	randpixel = 12

	aggrosound = list('sound/creatures/radroach_chitter.ogg',)
	idlesound = list('sound/f13npc/roach/idle1.ogg', 'sound/f13npc/roach/idle2.ogg', 'sound/f13npc/roach/idle3.ogg',)
	death_sound = 'sound/f13npc/roach/roach_death.ogg'
