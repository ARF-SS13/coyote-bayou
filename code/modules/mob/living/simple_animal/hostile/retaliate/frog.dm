/mob/living/simple_animal/hostile/retaliate/frog
	name = "frog"
	desc = "It seems a little sad."
	icon_state = "frog"
	icon_living = "frog"
	icon_dead = "frog_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	//speak = list("ribbit","croak", "*frogcry")
	emote_see = list("hops in a circle.", "shakes.")
	speak_chance = 1
	turns_per_move = 5
	maxHealth = 15
	health = 15
	melee_damage_lower = 5
	melee_damage_upper = 5
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "pokes"
	response_disarm_simple = "poke"
	response_harm_continuous = "splats"
	response_harm_simple = "splat"
	density = FALSE
	ventcrawler = VENTCRAWLER_ALWAYS
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	faction = list("hostile", "neutral")
	attack_sound = 'sound/effects/reee.ogg'
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 1)
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	gold_core_spawnable = HOSTILE_SPAWN
	var/stepped_sound = 'sound/effects/huuu.ogg'
	idlesound = list(
		'sound/f13npc/frog/frog1.ogg',
		'sound/f13npc/frog/frog2.ogg',
		'sound/f13npc/frog/frog3.ogg',
		'sound/f13npc/frog/frog4.ogg',
		'sound/f13npc/frog/frog5.ogg',
		'sound/f13npc/frog/frog6.ogg',
		'sound/f13npc/frog/frog7.ogg',
		'sound/f13npc/frog/frog8.ogg',
		)

//aesthetic:
	randpixel = 8
	variation_list = list(
		MOB_COLOR_VARIATION(50, 50, 50, 255, 255, 255))

/mob/living/simple_animal/hostile/retaliate/frog/Initialize()
	.=..()
	resize = 0.5
	update_transform()

/mob/living/simple_animal/hostile/retaliate/frog/Initialize()
	. = ..()
	if(prob(1))
		name = "rare frog"
		desc = "It seems a little smug."
		icon_state = "rare_frog"
		icon_living = "rare_frog"
		icon_dead = "rare_frog_dead"
		guaranteed_butcher_results = list(/mob/living/simple_animal/hostile/retaliate/frog = 5)

/mob/living/simple_animal/hostile/retaliate/frog/on_entered(AM as mob|obj)
	..()
	if(!stat && isliving(AM))
		var/mob/living/L = AM
		if(L.mob_size > MOB_SIZE_TINY)
			playsound(src, stepped_sound, 50, 1)


/mob/living/simple_animal/hostile/retaliate/frog/red
	name = "red frog"
	desc = "It seems a little mad."
	icon_state = "frog2"
	icon_living = "frog2"
	icon_dead = "frog_dead2"
