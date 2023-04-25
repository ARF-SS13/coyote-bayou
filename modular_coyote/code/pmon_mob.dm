//Pokemon!

/mob/living/simple_animal/pet/pokemon
	name = "eevee"
	desc = "It has the ability to alter the composition of its body to suit its surrounding environment."
	icon = 'modular_coyote/icons/mob/pokemon64.dmi'
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
	old_x = -16
	old_y = -16
	pixel_x = -16
	pixel_y = -16

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
