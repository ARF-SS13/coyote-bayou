/mob/living/simple_animal/hostile/regalrat
	name = "regal rat"
	desc = "An evolved rat, created through some strange science. It leads nearby rats with deadly efficiency to protect its kingdom. Not technically a king."
	icon_state = "regalrat"
	icon_living = "regalrat"
	icon_dead = "regalrat_dead"
	gender = NEUTER
	speak_chance = 0
	turns_per_move = 5
	maxHealth = 70
	health = 70
	see_in_dark = 5
	obj_damage = 10
	guaranteed_butcher_results = list(/obj/item/clothing/head/crown = 1,)
	response_help_continuous = "glares at"
	response_help_simple = "glare at"
	response_disarm_continuous = "skoffs at"
	response_disarm_simple = "skoff at"
	response_harm_continuous = "slashes"
	response_harm_simple = "slash"
	melee_damage_lower = 10
	melee_damage_upper = 12
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/punch1.ogg'
	ventcrawler = VENTCRAWLER_ALWAYS
	unique_name = TRUE
	faction = list("rat", "rat-friend")
	pass_flags = PASSTABLE | PASSMOB | PASSGRILLE
	var/datum/action/cooldown/coffer
	var/datum/action/cooldown/riot
	can_ghost_into = TRUE
	desc_short = "King of the squeaks!"
	///Number assigned to rats and mice, checked when determining infighting.

/mob/living/simple_animal/hostile/regalrat/Initialize()
	. = ..()
	coffer = new /datum/action/cooldown/coffer
	coffer.Grant(src)
	riot = new /datum/action/cooldown/riot
	riot.Grant(src)
	INVOKE_ASYNC(src,PROC_REF(get_player))

/mob/living/simple_animal/hostile/regalrat/proc/get_player()
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you want to play as the Royal Rat, cheesey be his crown?", ROLE_SENTIENCE, null, FALSE, 100, POLL_IGNORE_SENTIENCE_POTION)
	if(LAZYLEN(candidates) && !mind)
		var/mob/dead/observer/C = pick(candidates)
		key = C.key
		notify_ghosts("All rise for the rat king, ascendant to the throne in \the [get_area(src)].", source = src, action = NOTIFY_ORBIT, flashwindow = FALSE)

/mob/living/simple_animal/hostile/regalrat/handle_automated_action()
	if(prob(20))
		riot.Trigger()
	else if(prob(50))
		coffer.Trigger()
	return ..()

/mob/living/simple_animal/hostile/regalrat/CanAttack(atom/the_target)
	if(istype(the_target,/mob/living/simple_animal))
		var/mob/living/A = the_target
		if(istype(the_target, /mob/living/simple_animal/hostile/regalrat) && A.stat == CONSCIOUS)
			return TRUE
		if(istype(the_target, /mob/living/simple_animal/hostile/rat) && A.stat == CONSCIOUS)
			var/mob/living/simple_animal/hostile/rat/R = the_target
			if(R.faction_check_mob(src, TRUE))
				return FALSE
			else
				return TRUE
	return ..()

/mob/living/simple_animal/hostile/regalrat/examine(mob/user)
	. = ..()
	if(istype(user,/mob/living/simple_animal/hostile/rat))
		var/mob/living/simple_animal/hostile/rat/ratself = user
		if(ratself.faction_check_mob(src, TRUE))
			. += span_notice("This is your king. Long live his majesty!")
		else
			. += span_warning("This is a false king! Strike him down!")
	else if(istype(user,/mob/living/simple_animal/hostile/regalrat))
		. += span_warning("Who is this foolish false king? This will not stand!")

/**
 *This action creates trash, money, dirt, and cheese.
 */

/datum/action/cooldown/coffer
	name = "Fill Coffers"
	desc = "Your newly granted regality and poise let you scavenge for lost junk, but more importantly, cheese."
	icon_icon = 'icons/mob/actions/actions_animal.dmi'
	background_icon_state = "bg_clock"
	button_icon_state = "coffer"
	cooldown_time = 50

/datum/action/cooldown/coffer/Trigger()
	. = ..()
	if(!.)
		return
	var/turf/T = get_turf(owner)
	var/loot = rand(1,100)
	switch(loot)
		if(1 to 5)
			to_chat(owner, span_notice("Score! You find some cheese!"))
			new /obj/item/reagent_containers/food/snacks/cheesewedge(T)
		if(6 to 10)
			var/pickedcoin = pick(GLOB.ratking_coins)
			to_chat(owner, span_notice("You find some leftover coins. More for the royal treasury!"))
			for(var/i = 1 to rand(1,3))
				new pickedcoin(T)
		if(11)
			to_chat(owner, span_notice("You find a... Hunh. This coin doesn't look right."))
			var/rarecoin = rand(1,2)
			if (rarecoin == 1)
				new /obj/item/coin/twoheaded(T)
			else
				new /obj/item/coin/antagtoken(T)
		if(12 to 40)
			var/pickedtrash = pick(GLOB.ratking_trash)
			to_chat(owner, span_notice("You just find more garbage and dirt. Lovely, but beneath you now."))
			new /obj/effect/decal/cleanable/dirt(T)
			new pickedtrash(T)
		if(41 to 100)
			to_chat(owner, span_notice("Drat. Nothing."))
			new /obj/effect/decal/cleanable/dirt(T)
	StartCooldown()

/**
 *This action checks all nearby mice, and converts them into hostile rats. If no mice are nearby, creates a new one.
 */

/datum/action/cooldown/riot
	name = "Raise Army"
	desc = "Raise an army out of the hordes of mice and pests crawling around the maintenance shafts."
	icon_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "riot"
	background_icon_state = "bg_clock"
	cooldown_time = 80
	///Checks to see if there are any nearby mice. Does not count Rats.

/datum/action/cooldown/riot/Trigger()
	. = ..()
	if(!.)
		return
	var/cap = CONFIG_GET(number/ratcap)
	var/something_from_nothing = FALSE
	for(var/mob/living/simple_animal/mouse/M in oview(owner, 5))
		var/mob/living/simple_animal/hostile/rat/new_rat = new(get_turf(M))
		something_from_nothing = TRUE
		if(M.mind && M.stat == CONSCIOUS)
			M.mind.transfer_to(new_rat)
		if(istype(owner,/mob/living/simple_animal/hostile/regalrat))
			var/mob/living/simple_animal/hostile/regalrat/giantrat = owner
			new_rat.faction = giantrat.faction
		qdel(M)
	if(!something_from_nothing)
		if(LAZYLEN(SSmobs.cheeserats) >= cap)
			to_chat(owner,span_warning("There's too many mice on this station to beckon a new one! Find them first!"))
			return
		new /mob/living/simple_animal/mouse(owner.loc)
		owner.visible_message(span_warning("[owner] commands a mouse to its side!"))
	else
		owner.visible_message(span_warning("[owner] commands its army to action, mutating them into rats!"))
	StartCooldown()

/mob/living/simple_animal/hostile/rat
	name = "rat"
	desc = "It's a nasty, ugly, evil, disease-ridden rodent with anger issues."
	icon_state = "mouse_gray"
	icon_living = "mouse_gray"
	icon_dead = "mouse_gray_dead"
	//speak = list("Skree!","SKREEE!","Squeak?")
	speak_emote = list("skrees")
	emote_hear = list("Hisses!")
	emote_see = list("charges around angrily.", "stands on its hind legs threateningly.")
	melee_damage_lower = 3
	melee_damage_upper = 5
	obj_damage = -10
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	maxHealth = 15
	health = 15
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 7
	vision_range = 8
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 1)
	density = FALSE
	ventcrawler = VENTCRAWLER_ALWAYS
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	randpixel = 6
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	faction = list("rat", "rat-friend")
	can_ghost_into = TRUE
	desc_short = "Squeak!"
	pop_required_to_jump_into = 0	
	var/is_smol = FALSE
	/// If not cheesy, don't add to the cheeserats list
	var/cheesy = FALSE

	variation_list = list(
		MOB_SPEED_LIST(1.5, 1.8, 2.0),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(5, 10, 15, 20, 24),
		MOB_RETREAT_DISTANCE_LIST(0, 1, 3),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(0, 0, 0, 1, 2),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(40),
	)

/// nerfed rats for above-ground spawn
/// they run around like assholes and avoid player interaction at all costs
/mob/living/simple_animal/hostile/rat/skitter
	name = "radmouse"
	desc = "It's a scared lil rodent with anxiety issues."
	icon_state = "mouse_gray"
	icon_living = "mouse_gray"
	icon_dead = "mouse_gray_dead"
	//speak = list("Squeak!","Squeak!!","Squeak?")
	speak_emote = list("squeaks")
	emote_hear = list("Squeaks.")
	emote_see = list("dances around in a circle.", "stands on its hind legs.")
	melee_damage_lower = 2
	melee_damage_upper = 3
	obj_damage = -10
	speak_chance = 30
	turns_per_move = 0
	see_in_dark = 10
	maxHealth = 5
	health = 5
	retreat_distance = 7
	minimum_distance = 7
	aggro_vision_range = 7
	vision_range = 10
	is_smol = TRUE

	variation_list = list(
		MOB_SPEED_LIST(0.2, 1.5, 1.8, 2.0, 5.0),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(5, 10, 15, 20, 24),
		MOB_RETREAT_DISTANCE_LIST(3, 5, 7),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(2, 3, 4, 5, 6),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

/mob/living/simple_animal/hostile/rat/Initialize(mapload)
	. = ..()
	if(cheesy)
		SSmobs.cheeserats += src
	AddComponent(/datum/component/swarming)
	AddElement(/datum/element/mob_holder, "mouse_gray")
	if(!is_smol && !mapload)
		do_alert_animation(src)
		resize = 1.5
		update_transform()

/// nerfed rats for above-ground spawn
/// they like people
/mob/living/simple_animal/hostile/rat/skitter/curious
	name = "curious mouse"
	desc = "A rodent that seems more at ease around people."
	response_help_continuous = "pets"
	response_help_simple = "pet"
	icon_state = "mouse_gray"
	icon_living = "mouse_gray"
	icon_dead = "mouse_gray_dead"
	color = "#bfe0ff"
	//speak = list("Squeak!","Squeak!!","Squeak?")
	speak_emote = list("squeaks")
	emote_hear = list("Squeaks.")
	emote_see = list("dances around in a circle.", "stands on its hind legs.")
	melee_damage_lower = 15
	melee_damage_upper = 20
	obj_damage = 30
	speak_chance = 30
	turns_per_move = 0
	see_in_dark = 10
	maxHealth = 50
	health = 50
	retreat_distance = 7
	minimum_distance = 7
	aggro_vision_range = 7
	vision_range = 10
	faction = list("neutral")
	is_smol = TRUE

	variation_list = list(
		MOB_SPEED_LIST(0.2, 1.5, 1.8, 2.0, 5.0),
		MOB_SPEED_CHANGE_PER_TURN_CHANCE(50),
		MOB_HEALTH_LIST(30, 35, 40, 45, 50),
		MOB_RETREAT_DISTANCE_LIST(3, 5, 7),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
		MOB_MINIMUM_DISTANCE_LIST(2, 3, 4, 5, 6),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(100),
	)

/mob/living/simple_animal/hostile/rat/skitter/curious/Initialize()
	. = ..()
	emote("flip")
	emote("spin")
	emote("squeak")
	visible_message(span_notice("[src] sure looks friendly!"))

/mob/living/simple_animal/hostile/rat/become_the_mob(mob/user)
	call_backup = /obj/effect/proc_holder/mob_common/summon_backup/rat
	send_mobs = /obj/effect/proc_holder/mob_common/direct_mobs/rat
	make_a_nest = /obj/effect/proc_holder/mob_common/make_nest/rat
	. = ..()

/mob/living/simple_animal/hostile/rat/skitter/become_the_mob(mob/user)
	make_a_nest = /obj/effect/proc_holder/mob_common/make_nest/mouse
	. = ..()

/mob/living/simple_animal/hostile/rat/skitter/curious/become_the_mob(mob/user)
	call_backup = null
	send_mobs = null
	make_a_nest = null
	. = ..()

// Pied Piper of Texarkana
/mob/living/simple_animal/hostile/rat/frien
	name = "imprinted rat"
	desc = "It's a dubious rodent of unusual breed, rumored to be raised by some rat lords to be less evil... But still have anger issues from time to time."
	response_help_continuous = "pets"
	response_help_simple = "pet"
	//speak = list("Squeak!", "SQUUEEAAAAK!!", "Squeak?")
	speak_emote = list("squeaks")
	emote_hear = list("Squeaks.")
	emote_see = list("charges around in a circle.", "stands on its hind legs.")
	color = "#91fdac"
	desc_short = "Squeaky squeak!"
	faction = list("neutral")

/mob/living/simple_animal/hostile/rat/frien/become_the_mob(mob/user)
	make_a_nest = /obj/effect/proc_holder/mob_common/make_nest/rat/tame
	. = ..()

/mob/living/simple_animal/hostile/rat/Destroy()
	if(cheesy)
		SSmobs.cheeserats -= src
	return ..()

/mob/living/simple_animal/hostile/rat/examine(mob/user)
	. = ..()
	if(istype(user,/mob/living/simple_animal/hostile/rat))
		var/mob/living/simple_animal/hostile/rat/ratself = user
		if(ratself.faction_check_mob(src, TRUE))
			. += span_notice("You both serve the same king.")
		else
			. += span_warning("This fool serves a different king!")
	else if(istype(user,/mob/living/simple_animal/hostile/regalrat))
		var/mob/living/simple_animal/hostile/regalrat/ratking = user
		if(ratking.faction_check_mob(src, TRUE))
			. += span_notice("This rat serves under you.")
		else
			. += span_warning("This peasant serves a different king! Strike him down!")

/mob/living/simple_animal/hostile/rat/CanAttack(atom/the_target)
	if(istype(the_target,/mob/living/simple_animal))
		var/mob/living/A = the_target
		if(istype(the_target, /mob/living/simple_animal/hostile/regalrat) && A.stat == CONSCIOUS)
			var/mob/living/simple_animal/hostile/regalrat/ratking = the_target
			if(ratking.faction_check_mob(src, TRUE))
				return FALSE
			else
				return TRUE
		if(istype(the_target, /mob/living/simple_animal/hostile/rat) && A.stat == CONSCIOUS)
			var/mob/living/simple_animal/hostile/rat/R = the_target
			if(R.faction_check_mob(src, TRUE))
				return FALSE
			else
				return TRUE
	return ..()

/mob/living/simple_animal/hostile/rat/handle_automated_action()
	. = ..()
	if(prob(40))
		var/turf/open/floor/F = get_turf(src)
		if(istype(F) && !F.intact)
			var/obj/structure/cable/C = locate() in F
			if(C && prob(15))
				if(C.avail())
					visible_message(span_warning("[src] chews through the [C]. It's toast!"))
					playsound(src, 'sound/effects/sparks2.ogg', 100, TRUE)
					C.deconstruct()
					death()
			else if(C && C.avail())
				visible_message(span_warning("[src] chews through the [C]. It looks unharmed!"))
				playsound(src, 'sound/effects/sparks2.ogg', 100, TRUE)
				C.deconstruct()

/mob/living/simple_animal/hostile/rat/skitter/curious/frenly
	faction = list("neutral")


/mob/living/simple_animal/hostile/rat/skitter/curious/frenly/Initialize()
	. = ..()
	addtimer(CALLBACK(src,PROC_REF(death)), 50 SECONDS)
