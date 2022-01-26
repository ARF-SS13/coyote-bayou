///////////
// GECKO //
///////////

/mob/living/simple_animal/hostile/gecko
	name = "gecko"
	desc = "A large mutated reptile with sharp teeth."
	icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_state = "gekko"
	icon_living = "gekko"
	icon_dead = "gekko_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 2, /obj/item/stack/sheet/animalhide/gecko = 1)
	butcher_results = list(/obj/item/stack/sheet/bone = 1)
	butcher_difficulty = 1
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


//////////////////////////
// NIGHTSTALKERS & PELT //
//////////////////////////

/mob/living/simple_animal/hostile/stalker
	name = "nightstalker"
	desc = "A crazed genetic hybrid of rattlesnake and coyote DNA."
	icon = 'icons/fallout/mobs/animals/nightstalker.dmi'
	icon_state = "nightstalker"
	icon_living = "nightstalker"
	icon_dead = "nightstalker-dead"
	icon_gib = null
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/bone = 2)
	butcher_results = list(/obj/item/clothing/head/f13/stalkerpelt = 1)
	butcher_difficulty = 3
	response_help_simple = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple = "bites"
	emote_taunt = list("growls")
	taunt_chance = 30
	speed = -1
	maxHealth = 180 //9 shots to kill with 9mm
	health = 180
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

// NIGHTSTALKER CUB
/mob/living/simple_animal/hostile/stalkeryoung
	name = "young nightstalker"
	desc = "A juvenile crazed genetic hybrid of rattlesnake and coyote DNA."
	icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_state = "nightstalker_cub"
	icon_living = "nightstalker_cub"
	icon_dead = "nightstalker_cub_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2, /obj/item/stack/sheet/sinew = 1, /obj/item/stack/sheet/bone = 1)
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

/obj/item/clothing/head/f13/stalkerpelt
	name = "nightstalker pelt"
	desc = "A hat made from nightstalker pelt which makes the wearer feel both comfortable and elegant."
	icon_state = "stalkerpelt"
	item_state = "stalkerpelt"

/obj/structure/stalkeregg
	name = "nightstalker egg"
	desc = "A shiny egg coming from a nightstalker."
	icon = 'icons/mob/wastemobsdrops.dmi'
	icon_state = "stalker-egg"
	density = 1
	anchored = 0


/////////////
// MOLERAT //
/////////////

/mob/living/simple_animal/hostile/molerat
	name = "molerat"
	desc = "A large mutated rat-mole hybrid that finds its way everywhere. Common in caves and underground areas."
	icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_state = "molerat"
	icon_living = "molerat"
	icon_dead = "molerat_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/molerat = 2, /obj/item/stack/sheet/sinew = 1,/obj/item/stack/sheet/animalhide/molerat = 1, /obj/item/stack/sheet/bone = 1)
	butcher_results = list(/obj/item/stack/sheet/bone = 1)
	butcher_difficulty = 1.5
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
	faction = list("hostile", "gecko")
	gold_core_spawnable = HOSTILE_SPAWN
	a_intent = INTENT_HARM

	emote_taunt_sound = list('sound/f13npc/molerat/taunt.ogg')
	emote_taunt = list("hisses")
	taunt_chance = 30
	aggrosound = list('sound/f13npc/molerat/aggro1.ogg', 'sound/f13npc/molerat/aggro2.ogg',)
	idlesound = list('sound/f13npc/molerat/idle.ogg')
	death_sound = 'sound/f13npc/molerat/death.ogg'
