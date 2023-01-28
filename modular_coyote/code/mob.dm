/mob/living/simple_animal/hostile/hellpig
	name = "hellpig"
	desc = "A mutated American boar, sporting razor sharp tucks and a nasty temper."
	icon = 'modular_coyote/icons/mob/hellpig.dmi'
	icon_state = "hellpig"
	icon_living = "hellpig"
	icon_dead = "hellpig_dead"
	maxHealth = 500
	health = 500
	melee_damage_lower = 20
	melee_damage_upper = 40
	footstep_type = FOOTSTEP_MOB_HEAVY
	wound_bonus = 5
	bare_wound_bonus = 25
	faction = list("yaoguai")
	emote_taunt_sound = list('sound/f13npc/deathclaw/taunt.ogg')
	aggrosound = list('sound/f13npc/deathclaw/aggro1.ogg', 'sound/f13npc/deathclaw/aggro2.ogg', )
	idlesound = list('sound/f13npc/deathclaw/idle.ogg',)
	death_sound = list('sound/f13npc/hellpig/hellpigdead.ogg',)
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 10, /obj/item/stack/sheet/bone = 6,)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/bone = 2,)
	butcher_difficulty = 1

//Cat slugs

/mob/living/simple_animal/pet/catslug
	name = "catslug"
	desc = "A noodley bodied creature with thin arms and legs, and gloomy dark eyes."
	icon_state = "catslug"
	icon_living = "catslug"
	icon_dead = "catslug_dead"
	icon = 'modular_coyote/icons/mob/slugcat.dmi'

	faction = list("catslug", "neutral")
	mob_armor = ARMOR_VALUE_MEDIUM
	maxHealth = 100
	health = 100
	healable = 1
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2)

	response_help_simple = "hugs"
	response_disarm_simple = "rudely paps"
	response_harm_simple = "punches"
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	harm_intent_damage = 2
	melee_damage_lower = 2
	melee_damage_upper = 5

	dextrous = TRUE
	held_items = list(null, null)
	see_in_dark = 8
	can_ghost_into = TRUE

/mob/living/simple_animal/pet/catslug/proc/catslug_color()
	set name = "Pick Color"
	set category = "IC"
	set desc = "You can set your color!"
	var/newcolor = input(usr, "Choose a color.", "", color) as color|null
	if(newcolor)
		color = newcolor
	update_icon()

/mob/living/simple_animal/pet/catslug/Initialize()
	. = ..()
	verbs += /mob/living/simple_animal/pet/catslug/proc/catslug_color
	add_verb(src, /mob/living/proc/lay_down)

/mob/living/simple_animal/pet/catslug/update_mobility()
	. = ..()
	if(client && stat != DEAD)
		if(!CHECK_MOBILITY(src, MOBILITY_STAND))
			icon_state = "[icon_living]_rest"
			collar_type = "[initial(collar_type)]_rest"
		else
			icon_state = "[icon_living]"
			collar_type = "[initial(collar_type)]"
	regenerate_icons()

//Pokemon!

/mob/living/simple_animal/pet/pokemon
	name = "eevee"
	desc = "It has the ability to alter the composition of its body to suit its surrounding environment."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "eevee"
	icon_living = "eevee"
	icon_dead = "eevee_d"
	unsuitable_atmos_damage = 0
	minbodytemp = TCMB
	maxbodytemp = T0C + 40
	health = 200
	maxHealth = 200
	healable = 1
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "bops"
	response_disarm_simple = "bop"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "nuzzles"
	attack_verb_simple = "nuzzle"

/mob/living/simple_animal/pet/pokemon/update_mobility()
	. = ..()
	if(client && stat != DEAD)
		if(!CHECK_MOBILITY(src, MOBILITY_STAND))
			icon_state = "[icon_living]_rest"
			collar_type = "[initial(collar_type)]_rest"
		else
			icon_state = "[icon_living]"
			collar_type = "[initial(collar_type)]"
	regenerate_icons()

/mob/living/simple_animal/pet/pokemon/eevee
	name = "Eevee"
	desc = "It has the ability to alter the composition of its body to suit its surrounding environment."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "eevee"
	icon_living = "eevee"
	icon_dead = "eevee_d"

/mob/living/simple_animal/pet/pokemon/vaporeon
	name = "Vaporeon"
	desc = "Lives close to water. Its long tail is ridged with a fin which is often mistaken for a mermaid's."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "vaporeon"
	icon_living = "vaporeon"
	icon_dead = "vaporeon_d"

/mob/living/simple_animal/pet/pokemon/glaceon
	name = "Glaceon"
	desc = "As a protective technique, it can completely freeze its fur to make its hairs stand like needles."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "glaceon"
	icon_living = "glaceon"
	icon_dead = "glaceon_d"

/mob/living/simple_animal/pet/pokemon/leafeon
	name = "Leafeon"
	desc = "Just like a plant, it uses photosynthesis. As a result, it is always enveloped in clear air."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "leafeon"
	icon_living = "leafeon"
	icon_dead = "leafeon_d"

/mob/living/simple_animal/pet/pokemon/flareon
	name = "Flareon"
	desc = "When storing thermal energy in its body, its temperature could soar to over 1600 degrees."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "flareon"
	icon_living = "flareon"
	icon_dead = "flareon_d"

/mob/living/simple_animal/pet/pokemon/jolteon
	name = "Jolteon"
	desc = "It accumulates negative ions in the atmosphere to blast out 10000-volt lightning bolts."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "jolteon"
	icon_living = "jolteon"
	icon_dead = "jolteon_d"

/mob/living/simple_animal/pet/pokemon/sylveon
	name = "Sylveon"
	desc = "It sends a soothing aura from its ribbonlike feelers to calm fights."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "sylveon"
	icon_living = "sylveon"
	icon_dead = "sylveon_d"

/mob/living/simple_animal/pet/pokemon/espeon
	name = "Espeon"
	desc = "It uses the fine hair that covers its body to sense air currents and predict its enemy's actions."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "espeon"
	icon_living = "espeon"
	icon_dead = "espeon_d"

/mob/living/simple_animal/pet/pokemon/umbreon
	name = "Umbreon"
	desc = "When agitated, this Pokémon protects itself by spraying poisonous sweat from its pores."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "umbreon"
	icon_living = "umbreon"
	icon_dead = "umbreon_d"

/mob/living/simple_animal/pet/pokemon/absol
	name = "Absol"
	desc = "Every time Absol appears before people, it is followed by a disaster such as an earthquake or a tidal wave. As a result, it came to be known as the disaster Pokémon."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "absol"
	icon_living = "absol"
	icon_dead = "absol_d"
