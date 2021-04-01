/mob/living/simple_animal/hostile/cazador
	name = "cazador"
	desc = "A mutated insect known for its fast speed, deadly sting, and being huge bastards."
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "cazador"
	icon_living = "cazador"
	icon_dead = "cazador_dead1"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/cazador_meat = 2, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/animalhide/chitin = 3)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	emote_taunt = list("buzzes")
	emote_taunt_sound = list('sound/f13npc/cazador/cazador_alert.ogg')
	aggrosound = list('sound/f13npc/cazador/cazador_charge1.ogg', 'sound/f13npc/cazador/cazador_charge2.ogg', 'sound/f13npc/cazador/cazador_charge3.ogg')
	idlesound = list('sound/creatures/cazador_buzz.ogg')
	stat_attack = UNCONSCIOUS
	robust_searching = 1
	taunt_chance = 30
	speed = -0.5
	maxHealth = 40
	health = 40
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 20
	melee_damage_upper = 20
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

/mob/living/simple_animal/hostile/cazador/playable
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE

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
		visible_message("<span class='danger'>[src] dodges [Proj]!</span>")
		return 0

/mob/living/simple_animal/hostile/cazador/young
	name = "young cazador"
	desc = "A mutated insect known for its fast speed, deadly sting, and being huge bastards. This one's little."
	maxHealth = 40
	health = 40
	speed = 1
	melee_damage_lower = 5
	melee_damage_upper = 10
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/cazador_meat = 1, /obj/item/stack/sheet/animalhide/chitin = 1, /obj/item/stack/sheet/sinew = 1)

/mob/living/simple_animal/hostile/cazador/young/playable
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	health = 150
	maxHealth = 150
	melee_damage_lower = 15
	melee_damage_upper = 25
	speed = 0


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

/mob/living/simple_animal/hostile/radscorpion
	name = "giant radscorpion"
	desc = "A mutated arthropod with an armored carapace and a powerful sting."
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "radscorpion"
	icon_living = "radscorpion"
	icon_dead = "radscorpion_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/radscorpion_meat = 2)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"

	taunt_chance = 30
	speed = 1.25
	maxHealth = 150
	health = 150
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 35
	melee_damage_upper = 35
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

/mob/living/simple_animal/hostile/gecko
	name = "gecko"
	desc = "A large mutated reptile with sharp teeth."
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "gekkon"
	icon_living = "gekkon"
	icon_dead = "gekkon_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 2, /obj/item/stack/sheet/animalhide/gecko = 1)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = 1
	maxHealth = 40
	health = 40
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 10
	melee_damage_upper = 15
	attack_verb_simple = "claws"
	speak_emote = list("hisses")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("gecko")
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN

	emote_taunt = list("screeches")
	emote_taunt_sound = list('sound/f13npc/gecko/gecko_charge1.ogg', 'sound/f13npc/gecko/gecko_charge2.ogg', 'sound/f13npc/gecko/gecko_charge3.ogg',)
	aggrosound = list('sound/f13npc/gecko/gecko_alert.ogg', )
	death_sound = 'sound/f13npc/gecko/gecko_death.ogg'

/mob/living/simple_animal/hostile/gecko/playable
	health = 200
	maxHealth = 200
	speed = 0
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	melee_damage_lower = 20
	melee_damage_upper = 45

/mob/living/simple_animal/hostile/radroach
	name = "radroach"
	desc = "A large mutated insect that finds its way everywhere."
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "radroach"
	icon_living = "radroach"
	icon_dead = "radroach_dead"
	icon_gib = "radroach_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/radroach_meat = 2, /obj/item/stack/sheet/sinew = 1)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"

	speed = 1
	maxHealth = 40
	health = 40
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_simple = "nips"
	attack_sound = 'sound/creatures/radroach_attack.ogg'
	speak_emote = list("skitters")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("gecko")
	a_intent = INTENT_HARM
	gold_core_spawnable = HOSTILE_SPAWN

	aggrosound = list('sound/creatures/radroach_chitter.ogg',)
	idlesound = list('sound/f13npc/roach/idle1.ogg', 'sound/f13npc/roach/idle2.ogg', 'sound/f13npc/roach/idle3.ogg',)
	death_sound = 'sound/f13npc/roach/roach_death.ogg'

/mob/living/simple_animal/hostile/giantant
	name = "fireant"
	desc = "A large mutated insect that finds its way everywhere."
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "GiantAnt"
	icon_living = "GiantAnt"
	icon_dead = "GiantAnt_dead"
	icon_gib = "GiantAnt_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/stack/sheet/sinew = 1, /obj/item/reagent_containers/food/snacks/meat/slab/ant_meat = 2)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	emote_taunt = list("chitters")
	emote_taunt_sound = 'sound/creatures/radroach_chitter.ogg'
	taunt_chance = 30
	speed = 1
	maxHealth = 160
	health = 160
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_simple = "stings"
	attack_sound = 'sound/creatures/radroach_attack.ogg'
	speak_emote = list("skitters")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("gecko")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM
	decompose = TRUE
	blood_volume = 0

/mob/living/simple_animal/hostile/giantant/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/giantant/Aggro()
	..()
	summon_backup(10)

/mob/living/simple_animal/hostile/fireant
	name = "fireant"
	desc = "A large mutated insect that finds its way everywhere."
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "FireAnt"
	icon_living = "FireAnt"
	icon_dead = "FireAnt_dead"
	icon_gib = "FireAnt_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/stack/sheet/sinew = 1, /obj/item/reagent_containers/food/snacks/meat/slab/ant_meat = 2, /obj/item/reagent_containers/food/snacks/rawantbrain = 1)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	emote_taunt = list("chitters")
	emote_taunt_sound = 'sound/creatures/radroach_chitter.ogg'
	taunt_chance = 30
	speed = 1
	maxHealth = 140
	health = 140
	harm_intent_damage = 8
	obj_damage = 20
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_simple = "stings"
	attack_sound = 'sound/creatures/radroach_attack.ogg'
	speak_emote = list("skitters")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("gecko")
	gold_core_spawnable = HOSTILE_SPAWN
	decompose = TRUE
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
		H.reagents.add_reagent(/datum/reagent/napalm, 0.1)

/mob/living/simple_animal/hostile/giantantqueen
	name = "giant ant queen"
	desc = "The queen of a giant ant colony."
	icon = 'icons/mob/wastemobslong.dmi'
	icon_state = "antqueen"
	icon_living = "antqueen"
	icon_dead = "antqueen_dead"
	icon_gib = "GiantAnt_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/stack/sheet/sinew = 1, /obj/item/reagent_containers/food/snacks/meat/slab/ant_meat = 2, /obj/item/reagent_containers/food/snacks/rawantbrain = 1)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	emote_taunt = list("chitters")
	emote_taunt_sound = 'sound/creatures/radroach_chitter.ogg'
	taunt_chance = 30
	speed = 1
	maxHealth = 700
	health = 700
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
	decompose = TRUE
	a_intent = INTENT_HARM
	var/list/spawned_mobs = list()
	var/max_mobs = 2
	var/mob_types = list(/mob/living/simple_animal/hostile/giantant)
	var/spawn_delay = 0
	var/spawn_time = 30 SECONDS
	var/spawn_text = "hatches from"
	blood_volume = 0


/mob/living/simple_animal/hostile/giantantqueen/Initialize()
	. = ..()
	GLOB.mob_nests += src

/mob/living/simple_animal/hostile/giantantqueen/death()
	GLOB.mob_nests -= src
	. = ..()

/mob/living/simple_animal/hostile/giantantqueen/Destroy()
	GLOB.mob_nests -= src
	. = ..()

/mob/living/simple_animal/hostile/giantantqueen/Aggro()
	..()
	summon_backup(10)

/obj/item/projectile/bile
	name = "spit"
	damage = 20
	icon_state = "toxin"

/mob/living/simple_animal/hostile/giantantqueen/proc/spawn_mob()
	if(world.time < spawn_delay)
		return 0
	spawn_delay = world.time + spawn_time
	if(spawned_mobs.len >= max_mobs)
		return FALSE
	var/chosen_mob_type = pickweight(mob_types)
	var/mob/living/simple_animal/L = new chosen_mob_type(get_turf(src))
	L.flags_1 |= (flags_1 & ADMIN_SPAWNED_1)	//If we were admin spawned, lets have our children count as that as well.
	spawned_mobs += L
	L.nest = src
	visible_message("<span class='danger'>[L] [spawn_text] [src].</span>")


/obj/item/clothing/head/f13/stalkerpelt
	name = "nightstalker pelt"
	desc = "A hat made from nightstalker pelt which makes the wearer feel both comfortable and elegant."
	icon_state = "stalkerpelt"
	item_state = "fedora"

/obj/structure/stalkeregg
	name = "nightstalker egg"
	desc = "A shiny egg coming from a nightstalker."
	icon = 'icons/mob/wastemobsdrops.dmi'
	icon_state = "stalker-egg"
	density = 1
	anchored = 0

/obj/structure/mirelurkegg
	name = "mirelurk eggs"
	desc = "A fresh clutch of mirelurk eggs."
	icon = 'icons/mob/wastemobsdrops.dmi'
	icon_state = "mirelurkeggs"
	density = 1
	anchored = 0

/mob/living/simple_animal/hostile/stalkeryoung
	name = "young nightstalker"
	desc = "A juvenile crazed genetic hybrid of rattlesnake and coyote DNA."
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "nightstalker"
	icon_living = "nightstalker"
	icon_dead = "nightstalker_dead"
	icon_gib = null
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2, /obj/item/stack/sheet/sinew = 1)
	response_help_simple = "pets"
	response_disarm_simple = "pushes aside"
	response_harm_simple = "kicks"
	taunt_chance = 30
	speed = -1
	maxHealth = 50
	health = 100
	harm_intent_damage = 8
	obj_damage = 15
	melee_damage_lower = 5
	melee_damage_upper = 10
	attack_verb_simple = "bites"
	speak_emote = list("howls")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("gecko")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM

	emote_taunt_sound = list('sound/f13npc/nightstalker/taunt1.ogg', 'sound/f13npc/nightstalker/taunt2.ogg')
	emote_taunt = list("growls", "snarls")
	aggrosound = list('sound/f13npc/nightstalker/aggro1.ogg', 'sound/f13npc/nightstalker/aggro2.ogg', 'sound/f13npc/nightstalker/aggro3.ogg')
	idlesound = list('sound/f13npc/nightstalker/idle1.ogg')
	death_sound = 'sound/f13npc/nightstalker/death.ogg'
	attack_sound = 'sound/f13npc/nightstalker/attack1.ogg'

/mob/living/simple_animal/hostile/stalkeryoung/playable
	health = 250
	maxHealth = 250
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	melee_damage_lower = 20
	melee_damage_upper = 45

/mob/living/simple_animal/hostile/stalker/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
		H.reagents.add_reagent(/datum/reagent/toxin/cazador_venom, 2)

/datum/reagent/toxin/cazador_venom/on_mob_life(mob/living/M)
	if(volume >= 20)
		M.adjustToxLoss(5, 0)
	..()

/mob/living/simple_animal/hostile/stalker
	name = "nightstalker"
	desc = "A crazed genetic hybrid of rattlesnake and coyote DNA."
	icon = 'icons/mob/wastemobslong.dmi'
	icon_state = "nightstalker"
	icon_living = "nightstalker"
	icon_dead = "nightstalker-dead"
	icon_gib = null
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2, /obj/item/stack/sheet/sinew = 1, /obj/item/clothing/head/f13/stalkerpelt = 1)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "bites"
	emote_taunt = list("growls")
	taunt_chance = 30
	speed = -1
	maxHealth = 250
	health = 250
	harm_intent_damage = 8
	obj_damage = 15
	melee_damage_lower = 10
	melee_damage_upper = 20
	attack_verb_simple = "bites"
	attack_sound = 'sound/creatures/nightstalker_bite.ogg'
	speak_emote = list("growls")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("gecko")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM

/mob/living/simple_animal/hostile/stalker/playable
	health = 300
	maxHealth = 300
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	melee_damage_lower = 20
	melee_damage_upper = 45

/mob/living/simple_animal/hostile/stalker/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
		H.reagents.add_reagent(/datum/reagent/toxin/cazador_venom, 4)

/datum/reagent/toxin/cazador_venom/on_mob_life(mob/living/M)
	if(volume >= 16)
		M.adjustToxLoss(5, 0)
	..()

/mob/living/simple_animal/hostile/bloatfly
	name = "bloatfly"
	desc = "A common mutated pest resembling an oversized blow-fly."
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "bloatfly"
	icon_living = "bloatfly"
	icon_dead = "bloatfly_dead"
	icon_gib = null
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2, /obj/item/stack/sheet/sinew = 1)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "bites"
	emote_taunt = list("growls")
	taunt_chance = 30
	speed = -1
	maxHealth = 40
	health = 40
	harm_intent_damage = 8
	obj_damage = 15
	melee_damage_lower = 5
	melee_damage_upper = 8
	attack_verb_simple = "bites"
	attack_sound = 'sound/creatures/bloatfly_attack.ogg'
	speak_emote = list("chitters")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("gecko")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM
	blood_volume = 0

/mob/living/simple_animal/hostile/bloatfly/bullet_act(obj/item/projectile/Proj)
	if(!Proj)
		return
	if(prob(50))
		return ..()
	else
		visible_message("<span class='danger'>[src] dodges [Proj]!</span>")
		return 0

/mob/living/simple_animal/hostile/molerat
	name = "molerat"
	desc = "A large mutated rat-mole hybrid that finds its way everywhere. Common in caves and underground areas."
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "mole_rat"
	icon_living = "mole_rat"
	icon_dead = "mole_rat_dead"
	icon_gib = null
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/molerat = 2, /obj/item/stack/sheet/sinew = 1)
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "hits"
	taunt_chance = 30
	speed = -1
	maxHealth = 25
	health = 25
	harm_intent_damage = 8
	obj_damage = 15
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_simple = "bites"
	attack_sound = 'sound/creatures/molerat_attack.ogg'
	speak_emote = list("chitters")
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	faction = list("gecko")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM

	emote_taunt_sound = list('sound/f13npc/molerat/taunt.ogg')
	emote_taunt = list("hisses")
	taunt_chance = 30
	aggrosound = list('sound/f13npc/molerat/aggro1.ogg', 'sound/f13npc/molerat/aggro2.ogg',)
	idlesound = list('sound/f13npc/molerat/idle.ogg')
	death_sound = 'sound/f13npc/molerat/death.ogg'

/mob/living/simple_animal/hostile/radscorpion/black
	name = "giant rad scorpion"
	desc = "A giant irradiated scorpion with a black exoskeleton. Its appearance makes you shudder in fear.<br>This one has giant pincers."
	icon_state = "radscorpion_black"
	icon_living = "radscorpion_black"
	icon_dead = "radscorpion_black_d"
	icon_gib = "gib"
	maxHealth = 150
	health = 150
	melee_damage_lower = 10
	melee_damage_upper = 30
	move_to_delay = 4
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/mirelurk
	name = "mirelurk"
	desc = "A giant mutated crustacean, with a hardened exo-skeleton."
	icon_state = "mirelurk"
	icon_living = "mirelurk"
	icon_dead = "mirelurk_d"
	speed = 1
	icon_gib = "gib"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 2, /obj/item/stack/sheet/sinew = 1)
	maxHealth = 150
	health = 150
	melee_damage_lower = 10
	melee_damage_upper = 20
	gold_core_spawnable = HOSTILE_SPAWN
	blood_volume = 0

/mob/living/simple_animal/hostile/fireant/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/fireant/Aggro()
	..()
	summon_backup(10)

/mob/living/simple_animal/hostile/mirelurk/hunter
	name = "mirelurk hunter"
	desc = "A giant mutated crustacean, with a hardened exoskeleton. Its appearance makes you shudder in fear. This one has giant, razor sharp claw pincers."
	icon_state = "mirelurkhunter"
	icon_living = "mirelurkhunter"
	speed = 1
	icon_dead = "mirelurkhunter_d"
	icon_gib = "gib"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 4, /obj/item/stack/sheet/sinew = 2)
	maxHealth = 250
	health = 250
	melee_damage_lower = 30
	melee_damage_upper = 45
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/fireant/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/fireant/Aggro()
	..()
	summon_backup(10)

/mob/living/simple_animal/hostile/mirelurk/baby
	name = "mirelurk baby"
	desc = "A neophyte mirelurk baby, mostly harmless."
	icon_state = "mirelurkbaby"
	icon_living = "mirelurkbaby"
	icon_dead = "mirelurkbaby_d"
	icon_gib = "gib"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 1)
	speed = 1
	maxHealth = 50
	health = 50
	melee_damage_lower = 5
	melee_damage_upper = 10
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/mirelurk/baby/Initialize()
	. = ..()

/mob/living/simple_animal/hostile/mirelurk/baby/Aggro()
	..()
	summon_backup(10)
