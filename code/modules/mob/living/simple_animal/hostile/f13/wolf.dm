//Fallout 13 wolf directory

/mob/living/simple_animal/hostile/wolf
	name = "feral dog"
	desc = "The dogs that survived the Great War are a larger, and tougher breed, size of a wolf.<br>This one seems to be severely malnourished and its eyes are bloody red."
	icon = 'icons/fallout/mobs/animal.dmi'
	icon_state = "dog_angry"
	icon_living = "dog_angry"
	icon_dead = "dog_dead"
	icon_gib = "gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	turns_per_move = 1
	response_help_simple = "pets"
	response_disarm_simple = "pushes aside"
	response_harm_simple = "kicks"
	maxHealth = 60
	health = 60
//	self_weight = 35

	faction = list("hostile", "wolf")

//	sound_speak_chance = 5
//	sound_speak = list('sound/f13npc/dog_charge1.ogg','sound/f13npc/dog_charge2.ogg','sound/f13npc/dog_charge3.ogg')

//	aggro_sound_chance = 50
//	aggro_sound = list('sound/f13npc/dog_alert1.ogg','sound/f13npc/dog_alert2.ogg','sound/f13npc/dog_alert3.ogg')

	environment_smash = 0
	butcher_results = list(/obj/item/stack/sheet/animalhide/wolf = 1, \
	/obj/item/reagent_containers/food/snacks/meat/slab/wolf = 1)
	melee_damage_lower = 20
	melee_damage_upper = 20
	aggro_vision_range = 15
//	idle_vision_range = 7
	attack_verb_simple = "bites"
	attack_sound = 'sound/weapons/bite.ogg'
	move_to_delay = 2

	emote_taunt_sound = list('sound/f13npc/dog/dog_charge1.ogg', 'sound/f13npc/dog/dog_charge2.ogg', 'sound/f13npc/dog/dog_charge3.ogg', 'sound/f13npc/dog/dog_charge4.ogg', 'sound/f13npc/dog/dog_charge5.ogg', 'sound/f13npc/dog/dog_charge6.ogg', 'sound/f13npc/dog/dog_charge7.ogg',)
	emote_taunt = list("growls", "barks", "snarls")
	taunt_chance = 30
	aggrosound = list('sound/f13npc/dog/dog_alert1.ogg', 'sound/f13npc/dog/dog_alert2.ogg', 'sound/f13npc/dog/dog_alert3.ogg')
	idlesound = list('sound/f13npc/dog/dog_bark1.ogg', 'sound/f13npc/dog/dog_bark2.ogg', 'sound/f13npc/dog/dog_bark3.ogg')
	death_sound = 'sound/f13npc/centaur/centaur_death.ogg'

/mob/living/simple_animal/hostile/wolf/playable
	health = 150
	maxHealth = 150
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)

/mob/living/simple_animal/hostile/wolf/alpha
	name = "alpha feral dog"
	desc = "The dogs that survived the Great War are a larger, and tougher breed, size of a wolf.<br>Wait... This one's a wolf!"
	icon_state = "wolf_angry"
	icon_living = "wolf_angry"
	icon_dead = "wolf_dead"
	icon_gib = "gib"
	maxHealth = 100
	health = 100
	melee_damage_lower = 25
	melee_damage_upper = 35

/mob/living/simple_animal/hostile/wolf/alpha/playable
	health = 150
	maxHealth = 150
	emote_taunt_sound = null
	emote_taunt = null
	aggrosound = null
	idlesound = null
	see_in_dark = 8
	wander = 0
	anchored = FALSE
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)

/mob/living/simple_animal/hostile/wolf/cold
	name = "cold feral dog"
	desc = "The dogs that survived the Great War are a larger, and tougher breed, size of a wolf.<br>Wait... This one's a wolf!"
	icon = 'icons/mob/wastemobs.dmi'
	icon_state = "cold_wolf"
	icon_living = "cold_wolf"
	icon_dead = "cold_wolf_dead"
	icon_gib = "gib"
	maxHealth = 100
	health = 100
	melee_damage_lower = 25
	melee_damage_upper = 35

//Unique Dogs - Guerilla for Khans is a Rottweiler, Brutus and Lupa german shepherds, Sniffs-the-Earth a sheepdog. 
//Feel free to move or add code for different behaviours like sleep, some unused sprites prepped for that sort of thing.

/mob/living/simple_animal/hostile/wolf/playable/rottweiler
	icon_state = "rottweiler"
	icon_living = "rottweiler"
	icon_dead = "rottweiler_dead"
	icon_gib = "gib"

/mob/living/simple_animal/hostile/wolf/playable/sheepdog
	icon_state = "tippen"
	icon_living = "tippen"
	icon_dead = "tippen_dead"
	icon_gib = "gib"

/mob/living/simple_animal/hostile/wolf/playable/shepherd
	icon_state = "shepherd"
	icon_living = "shepherd"
	icon_dead = "shepherd_dead"
	icon_gib = "gib"