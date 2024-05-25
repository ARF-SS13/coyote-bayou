#define RTS_GHOUL_ALLOWED list(\
		/mob/living/simple_animal/hostile/ghoul,\
		/mob/living/simple_animal/hostile/ghoul/reaver,\
		/mob/living/simple_animal/hostile/ghoul/zombie/glowing)
#define RTS_SMALLCRITTER_ALLOWED list(\
		/mob/living/simple_animal/hostile/gecko,\
		/mob/living/simple_animal/hostile/gecko/legacy,\
		/mob/living/simple_animal/hostile/gecko/fire,\
		/mob/living/simple_animal/hostile/gecko/legacy/alpha,\
		/mob/living/simple_animal/hostile/gecko/big,\
		/mob/living/simple_animal/hostile/molerat,\
		/mob/living/simple_animal/hostile/bloatfly,\
		/mob/living/simple_animal/hostile/pillbug)
#define RTS_RATS_ALLOWED list(\
		/mob/living/simple_animal/hostile/rat,\
		/mob/living/simple_animal/hostile/rat/skitter,\
		/mob/living/simple_animal/hostile/rat/frien)
#define RTS_ROBOT_ALLOWED list(\
		/mob/living/simple_animal/hostile/handy,\
		/mob/living/simple_animal/hostile/handy/protectron,\
		/mob/living/simple_animal/hostile/eyebot)

// Separate defines for taming and control, else use above.
#define TAME_RATS_ALLOWED list(\
		/mob/living/simple_animal/hostile/rat,\
		/mob/living/simple_animal/hostile/rat/skitter,\
		/mob/living/simple_animal/hostile/molerat)

#define TAME_SMALLCRITTER_ALLOWED list(\
		/mob/living/simple_animal/hostile/stalker,\
		/mob/living/simple_animal/hostile/stalkeryoung,\
		/mob/living/simple_animal/hostile/gecko,\
		/mob/living/simple_animal/hostile/gecko/legacy,\
		/mob/living/simple_animal/hostile/gecko/fire,\
		/mob/living/simple_animal/hostile/molerat,\
		/mob/living/simple_animal/hostile/pillbug)

#define CONTROL_SMALLCRITTER_ALLOWED list(\
		/mob/living/simple_animal/hostile/gecko,\
		/mob/living/simple_animal/hostile/gecko,\
		/mob/living/simple_animal/hostile/gecko/legacy,\
		/mob/living/simple_animal/hostile/gecko/fire,\
		/mob/living/simple_animal/hostile/molerat,\
		/mob/living/simple_animal/hostile/pillbug)


/datum/action/innate/ghostify
	name = "Ghostize"
	desc = "Leave this creature and return to your ghostly state."

/datum/action/innate/ghostify/IsAvailable(silent = FALSE)
	if(..())
		return TRUE

/datum/action/innate/ghostify/Activate()
	if(!isliving(owner))
		return
	var/mob/living/liver = owner
	liver.ghost()
	return TRUE

/obj/effect/proc_holder/mob_common
	name = "Mob Common Ability"
	desc = "Direct nearby mobs to go to a tile."
	panel = "Player Mob"
	active = FALSE
	action = null
	action_icon = 'icons/mob/actions.dmi'
	action_icon_state = "Chevron_State_0"

	var/list/allowed_mobs = list()
	var/banned_from_lowpop = TRUE
	var/immune_to_lowpop = FALSE
	var/lowpop_is_now

/obj/effect/proc_holder/mob_common/Initialize()
	. = ..()
	action = new(src)

/obj/effect/proc_holder/mob_common/Trigger(mob/user)
	if(!istype(user))
		return FALSE
	if(banned_from_lowpop && is_lowpop())
		user.show_message(span_alert("There needs to be at least [MOB_POWER_FULL_MIN_PLAYERS] living players on to do this!"))
		return FALSE
	if(is_medpop() && !immune_to_lowpop)
		lowpop_is_now = TRUE
	else
		lowpop_is_now = FALSE
	if(!is_available(user))
		return FALSE
	activate(user)
	return TRUE

/obj/effect/proc_holder/mob_common/proc/is_lowpop()
	return living_player_count() < MOB_POWER_FULL_MIN_PLAYERS

/obj/effect/proc_holder/mob_common/proc/is_medpop()
	return living_player_count() < MOB_POWER_SOME_MIN_PLAYERS

/// Toggles active and inactive
/obj/effect/proc_holder/mob_common/proc/activate(mob/living/user)
	return

/// Is it available?
/obj/effect/proc_holder/mob_common/proc/is_available(mob/living/user)
	if(user.stat != CONSCIOUS)
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/* 
 * Summons mobs to your side!
 */
/obj/effect/proc_holder/mob_common/summon_backup
	name = "Summon Backup"
	desc = "Draws friendly mobs nearby."
	action_icon = 'icons/mob/actions.dmi'
	action_icon_state = "velvet_chords"

/obj/effect/proc_holder/mob_common/summon_backup/ghoul
	allowed_mobs = RTS_GHOUL_ALLOWED
	banned_from_lowpop = TRUE

/obj/effect/proc_holder/mob_common/summon_backup/small_critter
	banned_from_lowpop = FALSE
	immune_to_lowpop = TRUE
	allowed_mobs = RTS_SMALLCRITTER_ALLOWED

/obj/effect/proc_holder/mob_common/summon_backup/rat
	banned_from_lowpop = FALSE
	immune_to_lowpop = TRUE
	allowed_mobs = RTS_RATS_ALLOWED

/obj/effect/proc_holder/mob_common/summon_backup/robot
	allowed_mobs = RTS_ROBOT_ALLOWED
	banned_from_lowpop = TRUE

// Beastmaster Edition
/obj/effect/proc_holder/mob_common/summon_backup/beastmaster
	name = "Gather"
	banned_from_lowpop = FALSE
	immune_to_lowpop = TRUE

/obj/effect/proc_holder/mob_common/summon_backup/beastmaster/rat
	name = "Gather - Rats"
	desc = "Draws rodents nearby."
	allowed_mobs = RTS_RATS_ALLOWED

/obj/effect/proc_holder/mob_common/summon_backup/beastmaster/small_critter
	name = "Gather - Small Critters"
	desc = "Draws small critters nearby."
	allowed_mobs = CONTROL_SMALLCRITTER_ALLOWED

/obj/effect/proc_holder/mob_common/summon_backup/activate(mob/user)
	if(!istype(user, /mob/living))
		return
	if(user.incapacitated())
		return
	var/mob/living/owner = user

	var/turf/the_turf = get_turf(owner)
	if(!the_turf)
		return

	//playsound(get_turf(owner), 'sound/machines/chime.ogg', 50, 1, -1)
	owner.do_alert_animation(owner)
	var/list/who_to_check = list()
	var/allmobs = FALSE
	if(!LAZYLEN(allowed_mobs))
		allmobs = TRUE
	else if(lowpop_is_now)
		who_to_check = list(owner.type)
	else
		who_to_check = allowed_mobs
	for(var/mob/living/simple_animal/hostile/M in orange(6, get_turf(owner)))
		if(allmobs || (M.type in who_to_check))
			if(M.AIStatus == AI_OFF || M.stat == DEAD || M.ckey)
				continue
			//M.Goto(user,M.move_to_delay,1)
			walk_to(M, user, 1, M.move_to_delay)
			M.do_alert_animation(M)
	return TRUE

/* 
 * Directs mobs to where you click!
 */
/obj/effect/proc_holder/mob_common/direct_mobs
	name = "Send Mobs"
	desc = "Direct nearby mobs to go to a tile."
	panel = "Player Mob"
	active = FALSE
	action = null
	action_icon = 'icons/mob/actions.dmi'
	action_icon_state = "Chevron_State_0"

/obj/effect/proc_holder/mob_common/direct_mobs/update_icon()
	action.button_icon_state = "Chevron_State_[active]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/mob_common/direct_mobs/ghoul
	allowed_mobs = RTS_GHOUL_ALLOWED
	banned_from_lowpop = TRUE

/obj/effect/proc_holder/mob_common/direct_mobs/small_critter
	allowed_mobs = RTS_SMALLCRITTER_ALLOWED

/obj/effect/proc_holder/mob_common/direct_mobs/rat
	banned_from_lowpop = FALSE
	immune_to_lowpop = TRUE
	allowed_mobs = RTS_RATS_ALLOWED

/obj/effect/proc_holder/mob_common/direct_mobs/robot
	allowed_mobs = RTS_ROBOT_ALLOWED
	banned_from_lowpop = TRUE

// Beastmaster Edition
/obj/effect/proc_holder/mob_common/direct_mobs/beastmaster
	banned_from_lowpop = FALSE
	immune_to_lowpop = TRUE

/obj/effect/proc_holder/mob_common/direct_mobs/beastmaster/rat
	name = "Send Mobs - Rats"
	desc = "Direct nearby rodents to the tile."
	allowed_mobs = RTS_RATS_ALLOWED

/obj/effect/proc_holder/mob_common/direct_mobs/beastmaster/small_critter
	name = "Send Mobs - Small Critters"
	desc = "Direct nearby small critters to the tile."
	allowed_mobs = CONTROL_SMALLCRITTER_ALLOWED

/obj/effect/proc_holder/mob_common/direct_mobs/Trigger(mob/user)
	if(!..())
		return
	var/message
	if(active)
		user.show_message(span_notice("You decide not to direct any mobs."))
		remove_ranged_ability(message)
	else
		user.show_message(span_notice("You get ready to direct nearby mobs somewhere. <b>Click on a tile to send them!</b>"))
		add_ranged_ability(user, message, TRUE)
		return 1

/obj/effect/proc_holder/mob_common/direct_mobs/InterceptClickOn(mob/living/caller, params, atom/target)
	if(..())
		return
	if(ranged_ability_user.incapacitated())
		remove_ranged_ability()
		return

	var/mob/living/user = ranged_ability_user

	var/turf/the_turf = get_turf(target)
	if(!the_turf)
		remove_ranged_ability()
		return

	//playsound(get_turf(user), 'sound/machines/chime.ogg', 50, 1, -1)
	user.do_alert_animation(user)
	var/list/who_to_check = list()
	var/allmobs = FALSE
	if(!LAZYLEN(allowed_mobs))
		allmobs = TRUE
	else if(lowpop_is_now)
		who_to_check = list(user.type)
	else
		who_to_check = allowed_mobs
	for(var/mob/living/simple_animal/hostile/M in orange(6, get_turf(user)))
		if(allmobs || (M.type in who_to_check))
			if(M.AIStatus == AI_OFF || M.stat == DEAD || M.ckey)
				continue
			//M.Goto(target,M.move_to_delay,1)
			walk_to(M, target, 1, M.move_to_delay)
			M.do_alert_animation(M)
	remove_ranged_ability()
	return TRUE

/obj/effect/proc_holder/mob_common/direct_mobs/on_lose(mob/living/carbon/user)
	remove_ranged_ability()
	..()


/* 
 * Makes a nest!
 */
/obj/effect/proc_holder/mob_common/make_nest
	name = "Dig Nest"
	desc = "Dig down and tap into the endless underground resource that is monsters."
	var/obj/structure/nest/nest_to_spawn
	action_icon = 'icons/mob/nest_new.dmi'
	action_icon_state = "hole"
	var/doing_the_thing
	COOLDOWN_DECLARE(nest_cooldown)

/obj/effect/proc_holder/mob_common/make_nest/gecko
	nest_to_spawn = /obj/structure/nest/gecko

/obj/effect/proc_holder/mob_common/make_nest/molerat
	nest_to_spawn = /obj/structure/nest/molerat

/obj/effect/proc_holder/mob_common/make_nest/roach
	nest_to_spawn = /obj/structure/nest/radroach

/obj/effect/proc_holder/mob_common/make_nest/rat
	immune_to_lowpop = TRUE
	banned_from_lowpop = FALSE
	nest_to_spawn = /obj/structure/nest/rat

/obj/effect/proc_holder/mob_common/make_nest/rat/tame
	nest_to_spawn = /obj/structure/nest/rat/tame

/obj/effect/proc_holder/mob_common/make_nest/mouse
	immune_to_lowpop = TRUE
	banned_from_lowpop = FALSE
	nest_to_spawn = /obj/structure/nest/mouse

/// Is it available?
/obj/effect/proc_holder/mob_common/make_nest/is_available(mob/living/user)
	if(!..())
		return FALSE
	if(doing_the_thing)
		user.show_message(span_alert("You're already doing that!"))
		return FALSE
	if(COOLDOWN_TIMELEFT(src, nest_cooldown))
		user.show_message(span_alert("You can't do this for another <u>[(nest_cooldown-world.time)*0.1] seconds</u>."))
		return FALSE
	if(!can_they_nest(user))
		return FALSE
	return TRUE

/obj/effect/proc_holder/mob_common/make_nest/Trigger(mob/user)
	if(!..())
		return

	if(!istype(user))
		return

	if(user.incapacitated())
		return

	var/mob/living/simple_animal/owner = user
	if(!owner.ckey)
		return

	var/turf/the_turf = get_turf(owner)
	if(!the_turf)
		return
	
	var/obj/structure/nest/herenest = locate(/obj/structure/nest) in the_turf
	if(herenest)
		owner.show_message(span_alert("There's a nest here!"))
		return

	doing_the_thing = TRUE
	playsound(the_turf, 'sound/effects/shovel_dig.ogg', 50, 1)
	owner.visible_message(span_alert("[owner] starts to dig a hole..."))
	if(!do_after(owner, 10 SECONDS, FALSE, owner))
		doing_the_thing = FALSE
		owner.show_message(span_alert("You were interrupted!"))
		return
	doing_the_thing = FALSE

	if(!can_they_nest(owner))
		return FALSE
	var/obj/structure/nest/makenest = new nest_to_spawn(the_turf)
	makenest.register_ckey(owner.ckey)
	owner.visible_message(span_alert("[owner] digs a gross hole in the ground!"))
	playsound(the_turf, 'sound/effects/shovel_dig.ogg', 50, 1)
	COOLDOWN_START(src, nest_cooldown, 30 SECONDS)
	return TRUE

/obj/effect/proc_holder/mob_common/make_nest/proc/can_they_nest(mob/living/user)
	if(!user.ckey)
		return FALSE
	if(!islist(GLOB.player_made_nests[user.ckey]))
		GLOB.player_made_nests[user.ckey] = list()
	if(!islist(GLOB.player_made_nests[user.ckey][nest_to_spawn]))
		GLOB.player_made_nests[user.ckey][nest_to_spawn] = list()
	if(LAZYLEN(GLOB.player_made_nests[user.ckey][nest_to_spawn]) >= 2)
		user.show_message(span_alert("You already have 2 active nests! Go remove some of them if you want more."))
		return FALSE
	return TRUE


/* 
 * Makes a nest!
 */
/obj/effect/proc_holder/mob_common/unmake_nest
	name = "Remove Nests"
	desc = "One of your nests disappear."
	action_icon = 'icons/mob/nest_new.dmi'
	action_icon_state = "hole"
	immune_to_lowpop = TRUE
	banned_from_lowpop = FALSE

/// Is it available?
/obj/effect/proc_holder/mob_common/unmake_nest/is_available(mob/living/user)
	if(!..())
		return FALSE
	return TRUE

/obj/effect/proc_holder/mob_common/unmake_nest/Trigger(mob/user)
	if(!..())
		return

	if(!istype(user))
		return

	if(user.incapacitated())
		return

	var/mob/living/simple_animal/owner = user
	if(!owner.ckey)
		return

	if(!LAZYLEN(GLOB.player_made_nests[owner.ckey]))
		user.show_message(span_alert("You don't have any nests!"))
		return FALSE
	
	var/list/nest_types = list()
	for(var/nestype in GLOB.player_made_nests[owner.ckey])
		if(ispath(nestype, /obj/structure/nest))
			if(!LAZYLEN(GLOB.player_made_nests[owner.ckey][nestype]))
				continue
			var/obj/structure/nest/thenest = nestype
			nest_types[initial(thenest.name)] = nestype
	if(!LAZYLEN(nest_types))
		user.show_message(span_alert("You don't have any nests!"))
		return FALSE
	var/nests_to_smash = input(owner, "Which type of nest do you want to destroy?", "Smash the nests!", null) as null|anything in nest_types
	if(!nests_to_smash)
		return FALSE
	nests_to_smash = nest_types[nests_to_smash]
	
	var/obj/structure/nest/smashit = pick(GLOB.player_made_nests[owner.ckey][nests_to_smash])
	if(!istype(smashit))
		return FALSE
	user.show_message(span_alert("Smashing [smashit]!"))
	qdel(smashit)
	return TRUE

/obj/effect/proc_holder/mob_common/on_lose(mob/living/user)
	..()

/*
 * Tame the mobs! (beastmaster)
 */
/obj/effect/proc_holder/mob_common/taming_mobs
	name = "Tame"
	desc = "Try to make hostile mobs docile. Melee range."
	action_icon = 'icons/effects/crayondecal.dmi'
	action_icon_state = "peace"
	banned_from_lowpop = FALSE
	immune_to_lowpop = TRUE
	COOLDOWN_DECLARE(taming_cooldown)

/obj/effect/proc_holder/mob_common/taming_mobs/rat
	name = "Tame - Rats"
	desc = "Try to make rats and mice docile. Melee range."
	allowed_mobs = TAME_RATS_ALLOWED

/obj/effect/proc_holder/mob_common/taming_mobs/small_critter
	name = "Tame - Small Critters"
	desc = "Try to make small critters docile. Melee range."
	allowed_mobs = TAME_SMALLCRITTER_ALLOWED

/obj/effect/proc_holder/mob_common/taming_mobs/is_available(mob/living/user)
	if(!..())
		return FALSE
	if(COOLDOWN_TIMELEFT(src, taming_cooldown))
		user.show_message(span_alert("You can't do this for another <u>[(taming_cooldown-world.time)*0.1] seconds</u>."))
		return FALSE
	return TRUE

// Alert animation behavior here is reversed: instead of the tamed, it is done by the ones who aren't (minus dead or already tamed).
/obj/effect/proc_holder/mob_common/taming_mobs/Trigger(mob/user)
	if(!..())
		return
	var/list/who_to_check = list()
	var/allmobs = FALSE
	if(!LAZYLEN(allowed_mobs))
		allmobs = TRUE
	else
		who_to_check = allowed_mobs
	for(var/mob/living/simple_animal/hostile/M in range(1, get_turf(user))) // Requires you to be close and personal for taming
		if(allmobs || (M.type in who_to_check))
			if(M.stat == DEAD) // hevy is ded
				continue
			if(M.AIStatus == AI_OFF || M.ckey) // The mob is being played
				M.do_alert_animation(M)
				user.show_message(span_notice("The <i><b>[M.name]</b></i> ain't that simple..."))
				continue
			if("neutral" in M.faction) // Mob is already tamed, or just don't need to be (e.g. curious mice)
				continue
			if(prob(35)) // Failure chance
				M.do_alert_animation(M)
				user.show_message(span_red("The <b>[M.name]</b> wasn't tamed."))
				COOLDOWN_START(src, taming_cooldown, 30 SECONDS)
				continue
			M.faction |= "neutral" // Kinda want to perserve some of F3/NV behavior of tamed not helping with other/same-faction animal
			user.show_message(span_green("The <b>[M.name]</b> is tamed!"))
			M.name = "tamed [initial(M.name)]"
			M.desc = "[initial(M.desc)] This one appears to be tame."
			M.response_help_continuous = "pets" // Let the people pet tamed creatures instead of poking them.
			M.response_help_simple = "pet"
			M.make_ghostable(user)
			M.make_a_nest = null // Unless is it possible to make nest dug by neutral/tamed mob also spawn neutrals without creating yet another nest type.
			COOLDOWN_START(src, taming_cooldown, 60 SECONDS)
