// In this document: Goat, Chicken, Brahmin, Radstag, Bighorner (also cow but extinct so basically brahmin)

//////////
// GOAT //
//////////

/mob/living/simple_animal/hostile/retaliate/goat
	name = "goat"
	desc = "Not known for their pleasant disposition."
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "goat"
	icon_living = "goat"
	icon_dead = "goat_dead"
	speak = list("EHEHEHEHEH","eh?")
	speak_emote = list("brays")
	emote_hear = list("brays.")
	emote_see = list("shakes its head.", "stamps a foot.", "glares around.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4)
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	faction = list("neutral")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	attack_same = 1
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	attack_sound = 'sound/weapons/punch1.ogg'
	health = 40
	maxHealth = 40
	melee_damage_lower = 1
	melee_damage_upper = 2
	environment_smash = ENVIRONMENT_SMASH_NONE
	stop_automated_movement_when_pulled = 1
	blood_volume = 480
	var/obj/item/udder/udder = null
	var/datum/reagent/milk_reagent = /datum/reagent/consumable/milk

	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/retaliate/goat/Initialize(/datum/reagent/milk_reagent)
	if(milk_reagent)
		src.milk_reagent = milk_reagent
	udder = new (src, src.milk_reagent)
	. = ..()

/mob/living/simple_animal/hostile/retaliate/goat/Destroy()
	QDEL_NULL(udder)
	return ..()

/mob/living/simple_animal/hostile/retaliate/goat/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	if(stat == CONSCIOUS)
		//chance to go crazy and start wacking stuff
		if(!enemies.len && prob(1))
			Retaliate()

		if(enemies.len && prob(10))
			enemies.Cut()
			LoseTarget()
			src.visible_message(span_notice("[src] calms down."))
		udder?.generateMilk(milk_reagent)
		eat_plants()
		if(!pulledby)
			for(var/direction in shuffle(list(1,2,4,8,5,6,9,10)))
				var/step = get_step(src, direction)
				if(step)
					if(locate(/obj/structure/spacevine) in step || locate(/obj/structure/glowshroom) in step)
						Move(step, get_dir(src, step))

/mob/living/simple_animal/hostile/retaliate/goat/Retaliate()
	..()
	src.visible_message(span_danger("[src] gets an evil-looking gleam in [p_their()] eye."))

/mob/living/simple_animal/hostile/retaliate/goat/Move()
	. = ..()
	if(!stat)
		eat_plants()

/mob/living/simple_animal/hostile/retaliate/goat/proc/eat_plants()
	var/eaten = FALSE
	var/obj/structure/spacevine/SV = locate(/obj/structure/spacevine) in loc
	if(SV)
		SV.eat(src)
		eaten = TRUE

	var/obj/structure/glowshroom/GS = locate(/obj/structure/glowshroom) in loc
	if(GS)
		qdel(GS)
		eaten = TRUE

	if(eaten && prob(10))
		say("Nom", only_overhead = TRUE)

/mob/living/simple_animal/hostile/retaliate/goat/attackby(obj/item/O, mob/user, params)
	if(stat == CONSCIOUS && istype(O, /obj/item/reagent_containers/glass))
		udder.milkAnimal(O, user)
		return 1
	else
		return ..()


/mob/living/simple_animal/hostile/retaliate/goat/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	if(!istype(H.dna.species, /datum/species/pod))
		return
	var/obj/item/bodypart/NB = pick(H.bodyparts)
	H.visible_message(span_warning("[src] takes a big chomp out of [H]!"), \
							span_userdanger("[src] takes a big chomp out of your [NB]!"))
	NB.dismember()
//cow
/mob/living/simple_animal/cow
	name = "cow"
	desc = "Known for their milk, just don't tip them over."
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "brahmin"
	icon_living = "brahmin"
	icon_dead = "brahmin_dead"
	icon_gib = "brahmin_gib"
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak = list("moo?","moo","MOOOOOO")
	speak_emote = list("moos","moos hauntingly")
	emote_hear = list("brays.")
	emote_see = list("shakes its head.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 6)
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	attack_sound = 'sound/weapons/punch1.ogg'
	health = 200
	maxHealth = 200
	var/list/ride_offsets = list(
		"1" = list(0, 8),
		"2" = list(0, 8),
		"4" = list(-2, 8),
		"8" = list(2, 8)
		)
	var/obj/item/udder/udder = null
	var/datum/reagent/milk_reagent = /datum/reagent/consumable/milk
	var/list/food_types = list(/obj/item/reagent_containers/food/snacks/grown/wheat, /obj/item/stack/sheet/hay)
	gold_core_spawnable = FRIENDLY_SPAWN
	var/is_calf = 0
	var/has_calf = 0
	var/young_type = null
	blood_volume = 480
	var/ride_move_delay = 2
	var/hunger = 1
	COOLDOWN_DECLARE(hunger_cooldown)

	footstep_type = FOOTSTEP_MOB_SHOE
///////////////////////
//Dave's Brahmin Bags//
///////////////////////


	var/mob/living/owner = null
	var/follow = FALSE

	var/bridle = FALSE
	var/bags = FALSE
	var/collar = FALSE
	var/saddle = FALSE
	var/brand = ""


/mob/living/simple_animal/cow/Initialize()
	udder = new(src, milk_reagent)
	. = ..()
	recenter_wide_sprite()

/mob/living/simple_animal/cow/Destroy()
	QDEL_NULL(udder)
	return ..()

/mob/living/simple_animal/cow/death(gibbed)
	. = ..()
	if(can_buckle)
		can_buckle = FALSE
	if(buckled_mobs)
		for(var/mob/living/M in buckled_mobs)
			unbuckle_mob(M)
	for(var/atom/movable/stuff_innit in contents)
		stuff_innit.forceMove(get_turf(src))
	if(collar)
		new /obj/item/brahmincollar(get_turf(src))
	if(bridle)
		new /obj/item/brahminbridle(get_turf(src))
	if(saddle)
		new /obj/item/brahminsaddle(get_turf(src))

/mob/living/simple_animal/cow/examine(mob/user)
	. = ..()
	if(collar)
		. += "<br>A collar with a tag etched '[name]' is hanging from its neck."
	if(brand)
		. += "<br>It has a brand reading '[brand]' on its backside."
	if(bridle)
		. += "<br>It has a bridle and reins attached to its head."
	if(bags)
		. += "<br>It has some bags attached."
	if(saddle)
		. += "<br>It has a saddle across its back."
	if(health <= 0 || stat != CONSCIOUS)
		return
	if(saddle || bridle)
		. += "<br>Feeding this beast will let it move quickly for longer! You'll need to remove their bridle and saddle to get them pregnant."
	else
		. += "<br>Feeding this beast will get it pregnant! You'll need to give them a bridle and/or a saddle to feed their hunger."
	switch(hunger)
		if(1)
			. += "<br>They look well fed."
		if(2)
			. += "<br>They look hungry."
		if(3)
			. += "<br>They look <i>really</i> hungry."
		else
			. += "<br>They look fuckin <i>famished</i>."

/mob/living/simple_animal/cow/attackby(obj/item/O, mob/user, params)
	if(stat == CONSCIOUS && istype(O, /obj/item/reagent_containers/glass))
		udder.milkAnimal(O, user)
		return TRUE
	if(stat == CONSCIOUS && is_type_in_list(O, food_types))
		feed_em(O, user)
		return
	/* if (istype(O,/obj/item/brahminbags))
		if(bags)
			to_chat(user, span_warning("The mount already has bags attached!"))
			return
		if(is_calf)
			to_chat(user, span_warning("The young animal cannot carry the bags!"))
			return
		to_chat(user, span_notice("You add [O] to [src]..."))
		bags = TRUE
		qdel(O)
		ComponentInitialize()
		return */

	if(istype(O,/obj/item/brahmincollar))
		if(user != owner)
			to_chat(user, span_warning("You need to claim the mount with a bridle before you can rename it!"))
			return

		name = input("Choose a new name for your mount!","Name", name)

		if(!name)
			return

		collar = TRUE
		to_chat(user, span_notice("You add [O] to [src]..."))
		message_admins(span_notice("[ADMIN_LOOKUPFLW(user)] renamed a mount to [name].")) //So people don't name their brahmin the N-Word without notice
		qdel(O)
		return

	if(istype(O,/obj/item/brahminbridle))
		if(bridle)
			to_chat(user, span_warning("This mount already has a bridle!"))
			return

		owner = user
		bridle = TRUE
		tame = TRUE
		to_chat(user, span_notice("You add [O] to [src], claiming it as yours."))
		qdel(O)
		return

	if(istype(O,/obj/item/brahminsaddle))
		if(saddle)
			to_chat(user, span_warning("This mount already has a saddle!"))
			return

		saddle = TRUE
		can_buckle = TRUE
		buckle_lying = FALSE
		var/datum/component/riding/D = LoadComponent(/datum/component/riding)
		D.set_riding_offsets(RIDING_OFFSET_ALL, ride_offsets)
		D.set_vehicle_dir_layer(SOUTH, ABOVE_MOB_LAYER)
		D.set_vehicle_dir_layer(NORTH, OBJ_LAYER)
		D.set_vehicle_dir_layer(EAST, OBJ_LAYER)
		D.set_vehicle_dir_layer(WEST, OBJ_LAYER)
		D.vehicle_move_delay = ride_move_delay
		D.drive_verb = "ride"
		to_chat(user, span_notice("You add [O] to [src]."))
		qdel(O)
		return

	if(istype(O,/obj/item/brahminbrand))
		if(brand)
			to_chat(user, span_warning("This mount already has a brand!"))
			return

		brand = input("What would you like to brand on your mount?","Brand", brand)

		if(!brand)
			return
	. = ..()

/mob/living/simple_animal/cow/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	if(stat == CONSCIOUS)
		handle_following()
		if((prob(3) && has_calf))
			has_calf++
		if(has_calf > 10)
			has_calf = 0
			visible_message(span_alertalien("[src] gives birth to a calf."))
			new young_type(get_turf(src))

		if(is_calf)
			if((prob(3)))
				is_calf = 0
				udder = new(src, milk_reagent)
				if (name == "brahmin calf")
					name = "brahmin"
				else
					name = "cow"
				visible_message(span_alertalien("[src] has fully grown."))
		else
			udder?.generateMilk(milk_reagent)
			if(COOLDOWN_FINISHED(src, hunger_cooldown))
				if(prob(5))
					become_hungry()
				COOLDOWN_START(src, hunger_cooldown, 5 MINUTES)
			else
				update_speed()

/mob/living/simple_animal/cow/proc/become_hungry()
	hunger++
	update_speed()

/mob/living/simple_animal/cow/proc/refuel_horse()
	hunger = 1
	update_speed()

/mob/living/simple_animal/cow/proc/update_speed()
	ride_move_delay = initial(ride_move_delay) + round(log(1.6,hunger), 0.2) // vOv
	if(saddle)
		var/datum/component/riding/D = LoadComponent(/datum/component/riding)
		D.vehicle_move_delay = ride_move_delay

/mob/living/simple_animal/cow/on_attack_hand(mob/living/carbon/M)
	if(!stat && M.a_intent == INTENT_DISARM && icon_state != icon_dead)
		M.visible_message(span_warning("[M] tips over [src]."),
			span_notice("You tip over [src]."))
		to_chat(src, span_userdanger("You are tipped over by [M]!"))
		DefaultCombatKnockdown(30, ignore_canknockdown = TRUE)
		icon_state = icon_dead

		spawn(rand(40, 60))
			if(!stat)
				icon = initial(icon)
				icon_state = icon_living
				density = initial(density)
				lying = FALSE
				set_resting(FALSE, silent = TRUE, updating = TRUE)
				setMovetype(initial(movement_type))

				if(M)
					var/external
					var/internal
					switch(pick(1,2,3,4))
						if(1,2,3)
							var/text = pick("imploringly.", "pleadingly.",
								"with a resigned expression.")
							external = "[src] looks at [M] [text]"
							internal = "You look at [M] [text]"
						if(4)
							external = "[src] seems resigned to its fate."
							internal = "You resign yourself to your fate."
					visible_message(span_notice("[external]"),
						span_revennotice("[internal]"))
	else
		..()

/* /mob/living/simple_animal/cow/ComponentInitialize()
	if(!bags)
		return
	AddComponent(/datum/component/storage/concrete/brahminbag)
	return */

/mob/living/simple_animal/cow/proc/feed_em(obj/item/I, mob/user)
	if(!I || !user)
		return
	var/obj/item/stack/stax
	if(istype(I, /obj/item/stack))
		stax = I
		if(!stax.tool_use_check(user, 2))
			return

	if(saddle || bridle)
		visible_message(span_alertalien("[src] consumes the [I]."))
		refuel_horse()
	else if(is_calf)
		visible_message(span_alertalien("[src] adorably chews the [I]."))
	else if(!has_calf)
		has_calf = 1
		visible_message(span_alertalien("[src] fertilely consumes the [I]."))
	else
		visible_message(span_alertalien("[src] absently munches the [I]."))

	if(stax)
		stax.use(2)
	else
		qdel(I)

/mob/living/simple_animal/cow/proc/handle_following()
	if(stat == DEAD)
		return
	if(health <= 0)
		return
	if(owner)
		if(!follow)
			return
		else if(CHECK_MOBILITY(src, MOBILITY_MOVE) && isturf(loc))
			step_to(src, owner)

/mob/living/simple_animal/cow/CtrlShiftClick(mob/user)
	if(get_dist(user, src) > 1)
		return

	if(bridle && user.a_intent == INTENT_DISARM)
		bridle = FALSE
		tame = FALSE
		owner = null
		to_chat(user, span_notice("You remove the bridle gear from [src], dropping it on the ground."))
		new /obj/item/brahminbridle(get_turf(user))

	if(collar && user.a_intent == INTENT_GRAB)
		collar = FALSE
		name = initial(name)
		to_chat(user, span_notice("You remove the collar from [src], dropping it on the ground."))
		new /obj/item/brahmincollar(get_turf(user))

	if(user == owner)
		if(bridle && user.a_intent == INTENT_HELP)
			if(stat == DEAD || health <= 0)
				to_chat(user, span_alert("[src] can't obey your commands anymore. It is dead."))
				return
			if(follow)
				to_chat(user, span_notice("You tug on the reins of [src], telling it to stay."))
				follow = FALSE
				return
			else if(!follow)
				to_chat(user, span_notice("You tug on the reins of [src], telling it to follow."))
				follow = TRUE
				return

///////////////////////////
//End Dave's Brahmin Bags//
///////////////////////////


//a cow that produces a random reagent in its udder
/mob/living/simple_animal/cow/random
	name = "strange cow"
	desc = "Something seems off about the milk this cow is producing."

/mob/living/simple_animal/cow/random/Initialize()
	milk_reagent = get_random_reagent_id() //this has a blacklist so don't worry about romerol cows, etc
	..()

//Wisdom cow, speaks and bestows great wisdoms
/mob/living/simple_animal/cow/wisdom
	name = "wisdom cow"
	desc = "Known for its wisdom, shares it with all"
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/wisdomcow = 1) //truly the best meat
	gold_core_spawnable = FALSE
	speak_chance = 10 //the cow is eager to share its wisdom! //but is wise enough to not lag  the server too bad
	milk_reagent = /datum/reagent/medicine/liquid_wisdom

/mob/living/simple_animal/cow/wisdom/Initialize()
	. = ..()
	speak = GLOB.wisdoms //Done here so it's setup properly


/////////////
// CHICKEN //
/////////////

/mob/living/simple_animal/chick
	name = "chick"
	desc = "Adorable! They make such a racket though."
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "chick"
	icon_living = "chick"
	icon_dead = "chick_dead"
	icon_gib = "chick_gib"
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak = list("Cherp.","Cherp?","Chirrup.","Cheep!")
	speak_emote = list("cheeps")
	emote_hear = list("cheeps.")
	emote_see = list("pecks at the ground.","flaps its tiny wings.")
	density = FALSE
	speak_chance = 2
	turns_per_move = 2
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/chicken = 1)
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	health = 3
	maxHealth = 3
	ventcrawler = VENTCRAWLER_ALWAYS
	var/amount_grown = 0
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	gold_core_spawnable = FRIENDLY_SPAWN

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/chick/Initialize()
	. = ..()
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)

/mob/living/simple_animal/chick/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	if(!stat && !ckey)
		amount_grown += rand(1,2)
		if(amount_grown >= 100)
			new /mob/living/simple_animal/chicken(src.loc)
			qdel(src)

/mob/living/simple_animal/chick/holo/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	amount_grown = 0

/mob/living/simple_animal/chicken
	name = "chicken"
	desc = "Hopefully the eggs are good this season."
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "chicken_brown"
	icon_living = "chicken_brown"
	icon_dead = "chicken_brown_dead"
	is_monophobia_pet = TRUE
	speak = list("Cluck!","BWAAAAARK BWAK BWAK BWAK!","Bwaak bwak.")
	speak_emote = list("clucks","croons")
	emote_hear = list("clucks.")
	emote_see = list("pecks at the ground.","flaps its wings viciously.")
	density = FALSE
	speak_chance = 2
	turns_per_move = 3
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/chicken = 2)
	var/egg_type = /obj/item/reagent_containers/food/snacks/egg
	var/food_type = /obj/item/reagent_containers/food/snacks/grown/wheat
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	health = 15
	maxHealth = 15
	ventcrawler = VENTCRAWLER_ALWAYS
	var/eggsleft = 0
	var/eggsFertile = TRUE
	var/body_color
	var/icon_prefix = "chicken"
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	var/list/feedMessages = list("It clucks happily.","It clucks happily.")
	var/list/layMessage = EGG_LAYING_MESSAGES
	var/list/validColors = list("brown","black","white")
	gold_core_spawnable = FRIENDLY_SPAWN
	var/static/chicken_count = 0
	idlesound = list(
		'sound/creatures/chicken/chicken1.ogg',
		'sound/creatures/chicken/chicken2.ogg',
		'sound/creatures/chicken/chicken3.ogg',
		'sound/creatures/chicken/chicken4.ogg',
		)

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/chicken/Initialize()
	. = ..()
	if(!body_color)
		body_color = pick(validColors)
	icon_state = "[icon_prefix]_[body_color]"
	icon_living = "[icon_prefix]_[body_color]"
	icon_dead = "[icon_prefix]_[body_color]_dead"
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)
	++chicken_count

/mob/living/simple_animal/chicken/Destroy()
	--chicken_count
	return ..()

/mob/living/simple_animal/chicken/attackby(obj/item/O, mob/user, params)
	if(istype(O, food_type)) //feedin' dem chickens
		if(!stat && eggsleft < 8)
			var/feedmsg = "[user] feeds [O] to [name]! [pick(feedMessages)]"
			user.visible_message(feedmsg)
			qdel(O)
			eggsleft += rand(1, 4)
		else
			to_chat(user, span_warning("[name] doesn't seem hungry!"))
	else
		..()

/mob/living/simple_animal/chicken/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	if((!stat && prob(3) && eggsleft > 0) && egg_type)
		visible_message(span_alertalien("[src] [pick(layMessage)]"))
		eggsleft--
		var/obj/item/E = new egg_type(get_turf(src))
		E.pixel_x = rand(-6,6)
		E.pixel_y = rand(-6,6)
		if(eggsFertile)
			if(chicken_count < MAX_CHICKENS && prob(25))
				START_PROCESSING(SSobj, E)

/obj/item/reagent_containers/food/snacks/egg/var/amount_grown = 0
/obj/item/reagent_containers/food/snacks/egg/process()
	if(isturf(loc))
		amount_grown += rand(1,2)
		if(amount_grown >= 100)
			visible_message("[src] hatches with a quiet cracking sound.")
			new /mob/living/simple_animal/chick(get_turf(src))
			STOP_PROCESSING(SSobj, src)
			qdel(src)
	else
		STOP_PROCESSING(SSobj, src)

///////////
// UDDER //
///////////

/obj/item/udder
	name = "udder"

/obj/item/udder/Initialize(loc, milk_reagent)
	if(!milk_reagent)
		milk_reagent = /datum/reagent/consumable/milk
	create_reagents(50, NONE, NO_REAGENTS_VALUE)
	reagents.add_reagent(milk_reagent, 20)
	. = ..()

/obj/item/udder/proc/generateMilk(datum/reagent/milk_reagent)
	if(prob(5))
		reagents.add_reagent(milk_reagent, rand(5, 10))

/obj/item/udder/proc/milkAnimal(obj/O, mob/user)
	var/obj/item/reagent_containers/glass/G = O
	if(G.reagents.total_volume >= G.volume)
		to_chat(user, span_danger("[O] is full."))
		return
	var/transfered = reagents.trans_to(O, rand(5,10))
	if(transfered)
		user.visible_message("[user] milks [src] using \the [O].", span_notice("You milk [src] using \the [O]."))
	else
		to_chat(user, span_danger("The udder is dry. Wait a bit longer..."))

/////////////
// BRAHMIN //
/////////////

/mob/living/simple_animal/cow/brahmin
	name = "brahmin"
	desc = "Brahmin or brahma are mutated cattle with two heads and looking udderly ridiculous.<br>Known for their milk, just don't tip them over."
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "brahmin"
	icon_living = "brahmin"
	icon_dead = "brahmin_dead"
	icon_gib = "brahmin_gib"
	is_monophobia_pet = TRUE
	speak = list("moo?","moo","MOOOOOO")
	speak_emote = list("moos","moos hauntingly")
	emote_hear = list("brays.")
	emote_see = list("shakes its head.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	can_ghost_into = TRUE
	attack_sound = 'sound/weapons/punch1.ogg'
	idlesound = list(
		'sound/creatures/cow/cow1.ogg',
		'sound/creatures/cow/cow2.ogg',
		'sound/creatures/cow/cow3.ogg',
		'sound/creatures/cow/cow4.ogg',
		)
	young_type = /mob/living/simple_animal/cow/brahmin/calf
	var/obj/item/inventory_back
	footstep_type = FOOTSTEP_MOB_HOOF
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab = 4,
		/obj/item/reagent_containers/food/snacks/rawbrahminliver = 1,
		/obj/item/reagent_containers/food/snacks/rawbrahmintongue = 2,
		/obj/item/stack/sheet/animalhide/brahmin = 3,
		/obj/item/stack/sheet/bone = 2
		)
	butcher_difficulty = 1

/mob/living/simple_animal/cow/brahmin/molerat
	name = "tamed molerat"
	desc = "That's a big ol' molerat, seems to be able to take a saddle!"
	icon = 'modular_coyote/icons/mob/horse.dmi'
	icon_state = "molerat"
	icon_living = "molerat"
	icon_dead = "molerat_dead"
	icon_gib = "brahmin_gib"
	speak = list("*gnarl","*scrungy")
	speak_emote = list("grrrllgs","makes horrible molerat noises")
	emote_hear = list("chatters.")
	emote_see = list("shakes its head.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "bites"
	response_harm_simple = "bite"
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	waddle_amount = 4
	waddle_up_time = 1
	waddle_side_time = 2
	can_ghost_into = TRUE
	attack_sound = 'sound/weapons/punch1.ogg'
	idlesound = list()

	footstep_type = FOOTSTEP_MOB_HOOF
	ride_offsets = list(
		"1" = list(0, 8),
		"2" = list(0, 8),
		"4" = list(0, 8),
		"8" = list(0, 8)
		)
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab = 4,
		/obj/item/stack/sheet/bone = 2
		)
	butcher_difficulty = 1

/mob/living/simple_animal/cow/brahmin/molerat/trike
	name = "tamed triceratops"
	desc = "That's a big something! With three horns this beast looks quite intimadating. Apart from the saddle somehow strapped to it's back."
	icon = 'modular_coyote/icons/mob/dinosaurs68x45.dmi'
	icon_state = "triceratops_cow_ridable"
	icon_living = "triceratops_cow_ridable"
	icon_dead = "triceratops_cow_dead"
	speak = list("roars","bellows")
	speak_emote = list("bellows")
	emote_hear = list("roars.")
	emote_see = list("shakes its head.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "horns"
	response_harm_simple = "horn"
	attack_verb_continuous = "horns"
	attack_verb_simple = "horn"
	waddle_amount = 4
	waddle_up_time = 1
	waddle_side_time = 2
	can_ghost_into = TRUE
	attack_sound = 'sound/weapons/punch1.ogg'
	footstep_type = FOOTSTEP_MOB_HOOF
	ride_offsets = list(
		"1" = list(0, 15),
		"2" = list(0, 15),
		"4" = list(-2, 15),
		"8" = list(-2, 22)
		)
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab = 4,
		/obj/item/stack/sheet/bone = 2
		)
	butcher_difficulty = 1

/mob/living/simple_animal/cow/brahmin/horse/honse //wuzzle
	name = "honse"
	desc = "That's a honse, it's the morst but it sure is snorst." //Someone please set a better description later ~TK
	icon = 'modular_coyote/icons/mob/horse.dmi'
	icon_state = "honse"
	icon_living = "honse"
	icon_dead = "honse_KO"
	speak = list("*shiver", "*alert")
	speak_emote = list("wuzzles","winnies")
	emote_hear = list("does some sort of insane horse sound.")
	emote_see = list("perks its ears up.")
	speak_chance = 1
	turns_per_move = -1 //no random movement
	see_in_dark = 6
	health = 200
	maxHealth = 200
	ride_move_delay = 2.0
	can_ghost_into = TRUE
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	attack_sound = 'sound/weapons/punch1.ogg'
	idlesound = list()
	young_type = /mob/living/simple_animal/cow/brahmin/horse
	footstep_type = FOOTSTEP_MOB_HOOF
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab = 8,
		/obj/item/crafting/wonderglue = 3,
		/obj/item/stack/sheet/bone = 3
		)
	butcher_difficulty = 1

//https://media.tenor.com/JybpbLLsyX8AAAAC/fat-horse-wuzzle.gif
//Wuzzle


//Motorbike?

/mob/living/simple_animal/cow/brahmin/motorbike //fast as fuck boiii-- costs welding fuel
	name = "motorbike"
	desc = "Wow, a small, working motorcycle. How cool!" //I don't care. ~gob
	icon = 'modular_coyote/icons/mob/motorbike.dmi'
	icon_state = "motorcycle_4dir"
	icon_living = "motorcycle_4dir"
	icon_dead = "motorcycle_overlay_n"
	speak = list("*jump", "*beep")
	speak_emote = list("beeps","honks")
	emote_hear = list("The engine rumbles quietly.")
	emote_see = list("The engine purrs loudly.")
	speak_chance = 1
	turns_per_move = -1 //no random movement
	see_in_dark = 6
	health = 75
	maxHealth = 75 //Probably not the most durable piece of work. (equal in loss to the increase in speed)
	ride_move_delay = 1.2 //A bit faster than a horse.
	can_ghost_into = FALSE
	response_help_continuous  = "pets?"
	response_help_simple = "pets?"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	waddle_amount = 2
	waddle_up_time = 1
	waddle_side_time = 2
	attack_sound = 'sound/weapons/punch1.ogg'
	idlesound = list()
	food_types = list(/obj/item/reagent_containers/food/snacks/welding_fuel)
	young_type = /mob/living/simple_animal/cow/brahmin/motorbike
	milk_reagent = /datum/reagent/fuel
	footstep_type = FOOTSTEP_MOB_HOOF
	guaranteed_butcher_results = list(
		/obj/item/stack/sheet/metal/ten = 1,
		/obj/item/reagent_containers/glass/bottle/welding_fuel = 1,
		/obj/structure/tires/two = 1
		)
	butcher_difficulty = 5

/mob/living/simple_animal/cow/brahmin/motorbike/tractor //fast as fuck boiii-- costs welding fuel
	name = "tractor"
	desc = "A tractor! Is it a John Deer? Or a Kubota?" //I don't care. ~gob
	icon = 'modular_coyote/icons/mob/tractor.dmi'
	icon_state = "tractor"
	icon_living = "tractor"
	icon_dead = "tractor_dead"

//Horse

/mob/living/simple_animal/cow/brahmin/horse //faster than a brahmin, but much less tanky
	name = "horse"
	desc = "That's a horse, it's not the morst but it sure is snorst." //Someone please set a better description later ~TK
	icon = 'modular_coyote/icons/mob/horse.dmi'
	icon_state = "horse"
	icon_living = "horse"
	icon_dead = "KO"
	speak = list("*shiver", "*alert")
	speak_emote = list("wuzzles","winnies")
	emote_hear = list("does some sort of insane horse sound.")
	emote_see = list("perks its ears up.")
	speak_chance = 1
	turns_per_move = -1 //no random movement
	see_in_dark = 6
	health = 100
	maxHealth = 100
	ride_move_delay = 1.5
	can_ghost_into = TRUE
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	attack_sound = 'sound/weapons/punch1.ogg'
	idlesound = list()
	young_type = /mob/living/simple_animal/cow/brahmin/horse
	footstep_type = FOOTSTEP_MOB_HOOF
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab = 6,
		/obj/item/crafting/wonderglue = 1,
		/obj/item/stack/sheet/bone = 2
		)
	butcher_difficulty = 1


//Ridable Nightstalker
//not hormse
//smelly
/mob/living/simple_animal/cow/brahmin/nightstalker //faster than a brahmin, but slower than a horse, mid ground tanky
	name = "tamed nightstalker"
	desc = "A crazed genetic hybrid of rattlesnake and coyote DNA. This one seems a bit less crazed, at least."
	icon = 'icons/fallout/mobs/animals/nightstalker.dmi'
	icon_state = "nightstalker-legion"
	icon_living = "nightstalker-legion"
	icon_dead = "nightstalker-legion-dead"
	speak = list("*shiss","*gnarl","*bark")
	speak_emote = list("barks","hisses")
	emote_hear = list("perks its head up.")
	emote_see = list("stares.")
	speak_chance = 1
	turns_per_move = -1 //no random movement
	see_in_dark = 6
	health = 150
	maxHealth = 150
	ride_move_delay = 1.8
	can_ghost_into = TRUE
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "bites"
	response_harm_simple = "bites"
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	attack_sound = 'sound/weapons/punch1.ogg'
	idlesound = list()
	young_type = /mob/living/simple_animal/cow/brahmin/nightstalker
	food_types = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko,
		/obj/item/reagent_containers/food/snacks/f13/canned/dog
		)
	milk_reagent = /datum/reagent/toxin
	ride_offsets = list(
		"1" = list(1, 8),
		"2" = list(1, 8),
		"4" = list(1, 8),
		"8" = list(1, 8)
		)
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat = 2,
		/obj/item/clothing/head/f13/stalkerpelt = 1,
		/obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat = 1,
		/obj/item/stack/sheet/sinew = 2,
		/obj/item/stack/sheet/bone = 2
		)
	butcher_difficulty = 1


/mob/living/simple_animal/cow/brahmin/nightstalker/hunterspider
	name = "tamed spider"
	desc = "SOMEONE TAMED A FUCKING GIANT SPIDER?"
	icon = 'icons/fallout/mobs/animals/nightstalker.dmi'
	icon = 'modular_coyote/icons/mob/horse.dmi'
	icon_state = "hunter"
	icon_living = "hunter"
	icon_dead = "hunter_dead"
	speak = list("*chitter","*hiss")
	speak_emote = list("chitters","hisses")
	emote_hear = list("rubs it mandibles together.")
	emote_see = list("stares, with all 8 eyes.")
	speak_chance = 1
	turns_per_move = -1 //no random movement
	see_in_dark = 6
	health = 150
	maxHealth = 150
	ride_move_delay = 1.8
	can_ghost_into = TRUE
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "bites"
	response_harm_simple = "bites"
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	waddle_amount = 4
	waddle_up_time = 1
	waddle_side_time = 2
	attack_sound = 'sound/weapons/punch1.ogg'
	idlesound = list()
	young_type = /mob/living/simple_animal/cow/brahmin/nightstalker
	food_types = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko,
		/obj/item/reagent_containers/food/snacks/f13/canned/dog
		)
	milk_reagent = /datum/reagent/toxin
	ride_offsets = list(
		"1" = list(0, 9),
		"2" = list(0, 13),
		"4" = list(-2, 9),
		"8" = list(-2, 9)
		)
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat = 3,
		/obj/item/stack/sheet/sinew = 2,
		/obj/item/stack/sheet/bone = 2,
		/obj/item/clothing/head/f13/stalkerpelt = 1,

		)
	butcher_difficulty = 1
//Bear
/mob/living/simple_animal/cow/brahmin/nightstalker/yaoguai
	name = "tamed yaoguai"
	desc = "Is that...a yaoguai with a saddle on it's back?"
	icon = 'icons/fallout/mobs/animals/yaoguai.dmi'
	icon_state = "yaoguai_r"
	icon_living = "yaoguai_r"
	icon_dead = "yaoguai_r_dead"
	speak = list("roars","growls")
	speak_emote = list("snarls","growls")
	emote_hear = list("bares it's teeth and snarls.")
	emote_see = list("glares around.")
	speak_chance = 1
	turns_per_move = -1 //no random movement
	see_in_dark = 6
	health = 300 //More tanky mount
	maxHealth = 300
	ride_move_delay = 1.8
	can_ghost_into = TRUE
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "bites"
	response_harm_simple = "bites"
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	waddle_amount = 4
	waddle_up_time = 1
	waddle_side_time = 2
	attack_sound = 'sound/weapons/punch1.ogg'
	idlesound = list()
	young_type = /mob/living/simple_animal/cow/brahmin/nightstalker
	food_types = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko,
		/obj/item/reagent_containers/food/snacks/f13/canned/dog
		)
//	milk_reagent = /datum/reagent/toxin
	ride_offsets = list(
		"1" = list(0, 15),
		"2" = list(0, 13),
		"4" = list(5, 20),
		"8" = list(5, 20)
		)
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/nightstalker_meat = 2,
		/obj/item/stack/sheet/sinew = 2,
		/obj/item/stack/sheet/bone = 2,
		/obj/item/clothing/head/f13/stalkerpelt = 1,
		)
	butcher_difficulty = 1



//Ridable Fennec
/mob/living/simple_animal/cow/brahmin/horse/fennec //faster than a brahmin, but much less tanky
	name = "fennec"
	desc = "That's a fennec, screm."
	icon = 'modular_coyote/icons/mob/horse.dmi'
	icon_state = "fennec"
	icon_living = "fennec"
	icon_dead = "fennec_dead"
	speak = list(
	"*shiver",
	"*alert",
	"*fenbark"
	)
	speak_emote = list(
		"barks",
		"yips"
		)
	emote_hear = list(
		"screams like a fenenec"
		)
	emote_see = list(
		"perks its ears up."
		)
	speak_chance = 1
	turns_per_move = -1 //no random movement
	see_in_dark = 6
	health = 100
	maxHealth = 100
	ride_move_delay = 1.5
	can_ghost_into = TRUE
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	waddle_amount = 4
	waddle_up_time = 1
	waddle_side_time = 3
	attack_sound = 'sound/weapons/punch1.ogg'
	idlesound = list()
	young_type = /mob/living/simple_animal/cow/brahmin/horse
	footstep_type = FOOTSTEP_MOB_HOOF
	food_types = list(
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko,
		/obj/item/reagent_containers/food/snacks/f13/canned/dog
		)
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab = 5,
		/obj/item/stack/sheet/bone = 2
		)
	butcher_difficulty = 1
	ride_offsets = list(
		"1" = list(1, 6),
		"2" = list(1, 6),
		"4" = list(0, 6),
		"8" = list(3, 7)
		)


	/*
/obj/item/brahminbags
	name = "saddle bags"
	desc = "Attach these bags to a mount and leave the heavy lifting to them!"
	icon = 'icons/fallout/objects/storage.dmi'
	icon_state = "trekkerpack"
*/

//Thrumbo from Citadel RP

/mob/living/simple_animal/cow/brahmin/thrumbo
	name = "thrumbo"
	desc = "An intimidatingly large white-furred creature with a single massive horn on its forehead"
	icon = 'modular_coyote/icons/mob/thrumbo.dmi'
	icon_state = "thrumbo_ride"
	icon_living = "thrumbo_ride"
	icon_dead = "thrumbo_dead"
	speak = list("roars","bellows")
	speak_emote = list("bellows")
	emote_hear = list("roars.")
	emote_see = list("shakes its head.")
	speak_chance = 1
	ride_move_delay = 1.8
	health = 500
	maxHealth = 500
	turns_per_move = -1
	see_in_dark = 6
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "horns"
	response_harm_simple = "horn"
	attack_verb_continuous = "horns"
	attack_verb_simple = "horn"
	waddle_amount = 4
	waddle_up_time = 1
	waddle_side_time = 2
	can_ghost_into = FALSE
	attack_sound = 'sound/weapons/punch1.ogg'
	footstep_type = FOOTSTEP_MOB_HOOF
	ride_offsets = list(
		"1" = list(2, 22),
		"2" = list(2, 22),
		"4" = list(-4, 22),
		"8" = list(-3, 22)
		)
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab = 6,
		/obj/item/stack/sheet/bone = 2
		)
	butcher_difficulty = 1

/mob/living/simple_animal/cow/brahmin/horse/choco
	name = "yellow snipe"
	desc = "A very large chicken. Has a saddle!" //Someone please set a better description later ~TK
	icon = 'modular_coyote/icons/mob/raptor.dmi'
	icon_state = "raptoryellow"
	icon_living = "raptoryellow"
	icon_dead = "raptoryellow_dead"
	speak = list("*shiver", "*alert")
	speak_emote = list("chirps","squacks")
	emote_hear = list("makes a soft friendly chirp noise.")
	emote_see = list("scratches at the ground.")
	speak_chance = 1
	turns_per_move = -1 //no random movement
	see_in_dark = 6
	health = 200
	maxHealth = 200
	ride_move_delay = 1.5
	can_ghost_into = FALSE
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	waddle_amount = 4
	waddle_up_time = 1
	waddle_side_time = 2
	attack_sound = 'sound/weapons/punch1.ogg'
	idlesound = list()
	young_type = /mob/living/simple_animal/cow/brahmin/horse/choco
	footstep_type = FOOTSTEP_MOB_HOOF
	guaranteed_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/slab = 8,
		/obj/item/crafting/wonderglue = 1,
		/obj/item/stack/sheet/bone = 2
		)
	butcher_difficulty = 1
	ride_offsets = list(
		"1" = list(0, 8),
		"2" = list(0, 10),
		"4" = list(0, 8),
		"8" = list(0, 8)
		)


/mob/living/simple_animal/cow/brahmin/horse/choco/black
	name = "black snipe"
	desc = "A very large chicken. Has a saddle!" //Someone please set a better description later ~TK
	icon = 'modular_coyote/icons/mob/raptor.dmi'
	icon_state = "raptorblack"
	icon_living = "raptorblack"
	icon_dead = "raptorblack_dead"

/mob/living/simple_animal/cow/brahmin/horse/choco/blue
	name = "blue snipe"
	desc = "A very large chicken. Has a saddle!" //Someone please set a better description later ~TK
	icon = 'modular_coyote/icons/mob/raptor.dmi'
	icon_state = "raptorblue"
	icon_living = "raptorblue"
	icon_dead = "raptorblue_dead"

/mob/living/simple_animal/cow/brahmin/horse/choco/white
	name = "white snipe"
	desc = "A very large chicken. Has a saddle!" //Someone please set a better description later ~TK
	icon = 'modular_coyote/icons/mob/raptor.dmi'
	icon_state = "raptorwhite"
	icon_living = "raptorwhite"
	icon_dead = "raptorwhite_dead"

/mob/living/simple_animal/cow/brahmin/horse/choco/purple
	name = "purple snipe"
	desc = "A very large chicken. Has a saddle!" //Someone please set a better description later ~TK
	icon = 'modular_coyote/icons/mob/raptor.dmi'
	icon_state = "raptorpurple"
	icon_living = "raptorpurple"
	icon_dead = "raptorpurple_dead"

/mob/living/simple_animal/cow/brahmin/horse/choco/red
	name = "red snipe"
	desc = "A very large chicken. Has a saddle!" //Someone please set a better description later ~TK
	icon = 'modular_coyote/icons/mob/raptor.dmi'
	icon_state = "raptorred"
	icon_living = "raptorred"
	icon_dead = "raptorred_dead"

/mob/living/simple_animal/cow/brahmin/horse/choco/green
	name = "green snipe"
	desc = "A very large chicken. Has a saddle!" //Someone please set a better description later ~TK
	icon = 'modular_coyote/icons/mob/raptor.dmi'
	icon_state = "raptorgreen"
	icon_living = "raptorgreen"
	icon_dead = "raptorgreen_dead"

/obj/item/brahmincollar
	name = "mount collar"
	desc = "A collar with a piece of etched metal serving as a tag. Use this on a mount you own to rename them."
	icon = 'icons/mob/pets.dmi'
	icon_state = "petcollar"

/obj/item/brahminbridle
	name = "mount bridle gear"
	desc = "A set of headgear used to control and claim a mount. Consists of a bit, reins, and leather straps stored in a satchel."
	icon = 'icons/fallout/objects/tools.dmi'
	icon_state = "brahminbridle"

/obj/item/brahminsaddle
	name = "mount saddle"
	desc = "A saddle fit for a mutant beast of burden."
	icon = 'icons/fallout/objects/tools.dmi'
	icon_state = "brahminsaddle"

/obj/item/brahminbrand
	name = "mount branding tool"
	desc = "Use this on a mount to claim it as yours!"
	icon = 'icons/fallout/objects/tools.dmi'
	icon_state = "brahminbrand"

/obj/item/storage/backpack/duffelbag/debug_brahmin_kit
	name = "Lets test brahmin!"

/obj/item/storage/backpack/duffelbag/debug_brahmin_kit/PopulateContents()
	. = ..()
	//new /obj/item/brahminbags(src)
	new /obj/item/brahmincollar(src)
	new /obj/item/brahminbridle(src)
	new /obj/item/brahminsaddle(src)
	new /obj/item/brahminbrand(src)
	new /obj/item/choice_beacon/pet(src)
	new /obj/item/gun/ballistic/rifle/mag/antimaterial(src)

/*
/datum/crafting_recipe/brahminbags
	name = "Saddle bags"
	result = /obj/item/brahminbags
	time = 60
	reqs = list(/obj/item/storage/backpack/duffelbag = 2,
				/obj/item/stack/sheet/cloth = 5)
	tools = list(TOOL_WORKBENCH)
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC
*/

/datum/crafting_recipe/brahmincollar
	name = "Mount collar"
	result = /obj/item/brahmincollar
	time = 60
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_WORKBENCH)
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/brahminbridle
	name = "Mount bridle gear"
	result = /obj/item/brahminbridle
	time = 60
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_WORKBENCH)
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/brahminsaddle
	name = "Mount saddle"
	result = /obj/item/brahminsaddle
	time = 60
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/sheet/leather = 4,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_WORKBENCH)
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/datum/crafting_recipe/brahminbrand
	name = "Mount branding tool"
	result = /obj/item/brahminbrand
	time = 60
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	tools = list(TOOL_WORKBENCH)
	subcategory = CAT_MISCELLANEOUS
	category = CAT_MISC

/*
/datum/component/storage/concrete/brahminbag
	max_w_class = WEIGHT_CLASS_HUGE //Allows the storage of shotguns and other two handed items.
	max_combined_w_class = 35
	max_items = 20
	drop_all_on_destroy = TRUE
	allow_big_nesting = TRUE
*/


/mob/living/simple_animal/cow/brahmin/calf
	name = "brahmin calf"
	is_calf = 1

/mob/living/simple_animal/cow/brahmin/calf/Initialize()
	. = ..()
	resize = 0.7
	update_transform()

/mob/living/simple_animal/cow/brahmin/sgtsillyhorn
	name = "Sergeant Sillyhorn"
	desc = "A distinguished war veteran alongside his junior enlisted sidekick, Corporal McCattle. The two of them wear a set of golden rings, smelted from captured Centurions."
	emote_see = list("shakes its head.","swishes its tail eagerly.")
	speak_chance = 2



/mob/living/simple_animal/cow/brahmin/proc/update_brahmin_fluff() //none of this should do anything for now, but it may be used for updating sprites later
	// First, change back to defaults
	name = real_name
	desc = initial(desc)
	// BYOND/DM doesn't support the use of initial on lists.
	speak = list("Moo?","Moo!","Mooo!","Moooo!","Moooo.")
	emote_hear = list("brays.")
	desc = initial(desc)




/////////////
// RADSTAG //
/////////////

/mob/living/simple_animal/radstag
	name = "deer"
	desc = "a deer that will run at the first sight of danger."
	icon = 'modular_coyote/icons/mob/deer.dmi'
	icon_state = "deer"
	icon_living = "deer"
	icon_dead = "deer_dead"
	icon_gib = "radstag_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	turns_per_move = 5
	see_in_dark = 6
	resize = 0.7
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/animalhide/radstag = 2, /obj/item/stack/sheet/bone = 2)
	butcher_difficulty = 1

	response_help_simple  = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple   = "kicks"
	attack_verb_simple = "kicks"
	attack_sound = 'sound/weapons/punch1.ogg'
	health = 50
	maxHealth = 50
	gold_core_spawnable = FRIENDLY_SPAWN
	blood_volume = BLOOD_VOLUME_NORMAL
	faction = list("neutral")

//Special Radstag
/mob/living/simple_animal/radstag/rudostag
	name = "Rudo the Rednosed Stag"
	desc = "An almost normal looking radstag. Apart from both of it's noses was a bright, glowing red."
	icon_state = "rudostag"
	icon_living = "rudostag"
	icon_dead = "rudostag_dead"

///////////////
// BIGHORNER //
///////////////

/mob/living/simple_animal/hostile/retaliate/goat/bighorn
	name = "bighorner"
	desc = "Mutated bighorn sheep that are often found in mountains, and are known for being foul-tempered even at the best of times."
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "bighorner"
	icon_living = "bighorner"
	icon_dead = "bighorner_dead"
	icon_gib = "bighorner_gib"
	speak = list("EHEHEHEHEH","eh?")
	speak_emote = list("brays")
	emote_hear = list("brays.")
	emote_see = list("shakes its head.", "stamps a foot.", "glares around.", "grunts.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 6, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/bone = 3)
	butcher_difficulty = 1
	response_help_simple  = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple   = "kicks"
	faction = list("bighorner")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	attack_verb_simple = "rams"
	attack_sound = 'sound/weapons/punch1.ogg'
	health = 120
	maxHealth = 120
	melee_damage_lower = 25
	melee_damage_upper = 20
	environment_smash = ENVIRONMENT_SMASH_NONE
	stop_automated_movement_when_pulled = 1
	var/is_calf = 0
	var/food_type = /obj/item/reagent_containers/food/snacks/grown/wheat
	var/has_calf = 0
	var/young_type = /mob/living/simple_animal/hostile/retaliate/goat/bighorn/calf

/mob/living/simple_animal/hostile/retaliate/goat/bighorn/attackby(obj/item/O, mob/user, params)
	if(stat == CONSCIOUS && istype(O, /obj/item/reagent_containers/glass)) // Should probably be bound into a proc at this point.
		udder.milkAnimal(O, user)
		return 1
	if(stat == CONSCIOUS && istype(O, food_type))
		if(is_calf)
			visible_message(span_alertalien("[src] adorably chews the [O]."))
			qdel(O)
		if(!has_calf && !is_calf)
			has_calf = 1
			visible_message(span_alertalien("[src] hungrily consumes the [O]."))
			qdel(O)
		else
			visible_message(span_alertalien("[src] absently munches the [O]."))
			qdel(O)
	else
		return ..()

/mob/living/simple_animal/hostile/retaliate/goat/bighorn/Life()
	. = ..()
	if(stat == CONSCIOUS)
		if((prob(3) && has_calf))
			has_calf++
		if(has_calf > 10)
			has_calf = 0
			visible_message(span_alertalien("[src] gives birth to a calf."))
			new young_type(get_turf(src))

		if(is_calf)
			if((prob(3)))
				is_calf = 0
				udder = new(src, milk_reagent)
				if(name == "bighorn lamb")
					name = "bighorn"
				else
					name = "bighorn"
				visible_message(span_alertalien("[src] has fully grown."))
		else
			udder?.generateMilk(milk_reagent)

// BIGHORNER CALF
/mob/living/simple_animal/hostile/retaliate/goat/bighorn/calf
	name = "bighoner calf"
	resize = 0.7

/mob/living/simple_animal/hostile/retaliate/goat/bighorn/calf/Initialize() //calfs should not be a separate critter, they should just be a normal whatever with these vars
	. = ..()
	resize = 0.7
	update_transform()

/mob/living/simple_animal/cow/brahmin/cow //return to bovine
	name = "Cow"
	desc = "A black and white cow!"
	icon = 'modular_coyote/icons/mob/cow.dmi'
	icon_state = "cow"
	icon_living = "cow"
	icon_dead = "cow_dead"
	icon_gib = "brahmin_gib"

/mob/living/simple_animal/cow/brahmin/cow/Initialize()
	.=..()
	resize = 0.7
	update_transform()

/mob/living/simple_animal/cow/brahmin/cow/tan
	name = "Tan Cow"
	desc = "A tan cow!"
	icon = 'modular_coyote/icons/mob/cow.dmi'
	icon_state = "cow_tan"
	icon_living = "cow_tan"
	icon_dead = "cow_tan_dead"
	icon_gib = "brahmin_gib"

/* Seems obsolete with Daves Brahmin packs, marked for death?
	if(inventory_back && inventory_back.brahmin_fashion)
		var/datum/brahmin_fashion/BF = new inventory_back.brahmin_fashion(src)
		BF.apply(src)
/mob/living/simple_animal/cow/brahmin/regenerate_icons()
	..()
	if(inventory_back)
		var/image/back_icon
		var/datum/brahmin_fashion/BF = new inventory_back.brahmin_fashion(src)
		if(!BF.obj_icon_state)
			BF.obj_icon_state = inventory_back.icon_state
		if(!BF.obj_alpha)
			BF.obj_alpha = inventory_back.alpha
		if(!BF.obj_color)
			BF.obj_color = inventory_back.color
		if(health <= 0)
			back_icon = BF.get_overlay(dir = EAST)
			back_icon.pixel_y = -11
			back_icon.transform = turn(back_icon.transform, 180)
		else
			back_icon = BF.get_overlay()
		add_overlay(back_icon)
	return
/mob/living/simple_animal/cow/brahmin/show_inv(mob/user)
	user.set_machine(src)
	if(user.stat)
		return
	var/dat = 	"<div align='center'><b>Inventory of [name]</b></div><p>"
	if(inventory_back)
		dat +=	"<br><b>Back:</b> [inventory_back] (<a href='?src=[REF(src)];remove_inv=back'>Remove</a>)"
	else
		dat +=	"<br><b>Back:</b> <a href='?src=[REF(src)];add_inv=back'>Nothing</a>"
	user << browse(dat, text("window=mob[];size=325x500", real_name))
	onclose(user, "mob[real_name]")
	return
mob/living/simple_animal/cow/brahmin/Topic(href, href_list)
	if(usr.stat)
		return
	//Removing from inventory
	if(href_list["remove_inv"])
		if(!Adjacent(usr) || !(ishuman(usr) || ismonkey(usr) || iscyborg(usr) ||  isalienadult(usr)))
			return
		var/remove_from = href_list["remove_inv"]
		switch(remove_from)
			if("back")
				if(inventory_back)
					inventory_back.forceMove(drop_location())
					inventory_back = null
					update_brahmin_fluff()
					regenerate_icons()
				else
					to_chat(usr, span_danger("There is nothing to remove from its [remove_from]."))
					return
		show_inv(usr)
	//Adding things to inventory
	else if(href_list["add_inv"])
		if(!Adjacent(usr) || !(ishuman(usr) || ismonkey(usr) || iscyborg(usr) ||  isalienadult(usr)))
			return
		var/add_to = href_list["add_inv"]
		switch(add_to)
			if("back")
				if(inventory_back)
					to_chat(usr, span_warning("It's already wearing something!"))
					return
				else
					var/obj/item/item_to_add = usr.get_active_held_item()
					if(!item_to_add)
						usr.visible_message("[usr] pets [src].",span_notice("You rest your hand on [src]'s back for a moment."))
						return
					if(!usr.temporarilyRemoveItemFromInventory(item_to_add))
						to_chat(usr, span_warning("\The [item_to_add] is stuck to your hand, you cannot put it on [src]'s back!"))
						return
					//The objects that brahmin can wear on their backs.
					var/allowed = FALSE
					if(ispath(item_to_add.brahmin_fashion, /datum/brahmin_fashion/back))
						allowed = TRUE
					if(!allowed)
						to_chat(usr, span_warning("You set [item_to_add] on [src]'s back, but it falls off!"))
						item_to_add.forceMove(drop_location())
						if(prob(25))
							step_rand(item_to_add)
						for(var/i in list(1,2,4,8,4,8,4,dir))
							setDir(i)
							sleep(1)
						return
					item_to_add.forceMove(src)
					src.inventory_back = item_to_add
					update_brahmin_fluff()
					regenerate_icons()
		show_inv(usr)
	else
		..()
*/
