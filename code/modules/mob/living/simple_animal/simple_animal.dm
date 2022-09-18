/mob/living/simple_animal
	name = "animal"
	icon = 'icons/mob/animal.dmi'
	health = 20
	maxHealth = 20
	gender = PLURAL //placeholder
	///How much blud it has for bloodsucking
	blood_volume = 425 //blood will smeared only a little bit from body dragging

	status_flags = CANPUSH

	var/icon_living = ""
	///icon when the animal is dead. Don't use animated icons for this.
	var/icon_dead = ""
	///We only try to show a gibbing animation if this exists.
	var/icon_gib = null

	var/list/speak = list()
	///Emotes while speaking IE: Ian [emote], [text] -- Ian barks, "WOOF!". Spoken text is generated from the speak variable.
	var/list/speak_emote = list()
	var/speak_chance = 0
	///Hearable emotes
	var/list/emote_hear = list()
	///Unlike speak_emote, the list of things in this variable only show by themselves with no spoken text. IE: Ian barks, Ian yaps.
	var/list/emote_see = list()

	var/turns_per_move = 1
	var/turns_since_move = 0
	///Use this to temporarely stop random movement or to if you write special movement code for animals.
	var/stop_automated_movement = 0
	///Does the mob wander around when idle?
	var/wander = 1
	///When set to 1 this stops the animal from moving when someone is pulling it.
	var/stop_automated_movement_when_pulled = 1

	///When someone interacts with the simple animal.
	///Help-intent verb in present continuous tense.
	var/response_help_continuous = "pokes"
	///Help-intent verb in present simple tense.
	var/response_help_simple = "poke"
	///Disarm-intent verb in present continuous tense.
	var/response_disarm_continuous = "shoves"
	///Disarm-intent verb in present simple tense.
	var/response_disarm_simple = "shove"
	///Harm-intent verb in present continuous tense.
	var/response_harm_continuous = "hits"
	///Harm-intent verb in present simple tense.
	var/response_harm_simple = "hit"
	var/harm_intent_damage = 8 //Damage taken by punches, setting slightly higher than average punch damage as if you're punching a deathclaw then you're desperate enough to need it
	///Minimum force required to deal any damage.
	var/force_threshold = 0

	///Temperature effect.
	var/minbodytemp = 250
	var/maxbodytemp = 350

	///Healable by medical stacks? Defaults to yes.
	var/healable = 1

	///Atmos effect - Yes, you can make creatures that require plasma or co2 to survive. N2O is a trace gas and handled separately, hence why it isn't here. It'd be hard to add it. Hard and me don't mix (Yes, yes make all the dick jokes you want with that.) - Errorage
	var/list/atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0) //Leaving something at 0 means it's off - has no maximum
	///This damage is taken when atmos doesn't fit all the requirements above.
	var/unsuitable_atmos_damage = 2

	///LETTING SIMPLE ANIMALS ATTACK? WHAT COULD GO WRONG. Defaults to zero so Ian can still be cuddly.
	var/melee_damage_lower = 0
	var/melee_damage_upper = 0
	///How much damage this simple animal does to objects, if any.
	var/obj_damage = 0
	///How much armour they ignore, as a flat reduction from the targets armour value.
	var/armour_penetration = 0
	///Damage type of a simple mob's melee attack, should it do damage.
	var/melee_damage_type = BRUTE
	/// 1 for full damage , 0 for none , -1 for 1:1 heal from that source.
	var/list/damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 1)
	///Attacking verb in present continuous tense.
	var/attack_verb_continuous = "attacks"
	///Attacking verb in present simple tense.
	var/attack_verb_simple = "attack"
	var/attack_sound = null
	///Attacking, but without damage, verb in present continuous tense.
	var/friendly_verb_continuous = "nuzzles"
	///Attacking, but without damage, verb in present simple tense.
	var/friendly_verb_simple = "nuzzle"
	///Set to 1 to allow breaking of crates,lockers,racks,tables; 2 for walls; 3 for Rwalls.
	var/environment_smash = ENVIRONMENT_SMASH_NONE

	///LETS SEE IF I CAN SET SPEEDS FOR SIMPLE MOBS WITHOUT DESTROYING EVERYTHING. Higher speed is slower, negative speed is faster.
	/// Breaks everything, makes player controlled mobs wayyyyy tooo slow
	var/speed = 1

	var/idlesound = null //What to play when idling, if anything.
	var/aggrosound = null

	///Hot simple_animal baby making vars.
	var/list/childtype = null
	var/next_scan_time = 0
	///Sorry, no spider+corgi buttbabies.
	var/animal_species

	///Innate access uses an internal ID card.
	var/obj/item/card/id/access_card = null
	///In the event that you want to have a buffing effect on the mob, but don't want it to stack with other effects, any outside force that applies a buff to a simple mob should at least set this to TRUE, so we have something to check against.
	var/buffed = FALSE
	///If the mob can be spawned with a gold slime core. HOSTILE_SPAWN are spawned with plasma, FRIENDLY_SPAWN are spawned with blood.
	var/gold_core_spawnable = NO_SPAWN

	var/datum/weakref/nest

	///Sentience type, for slime potions.
	var/sentience_type = SENTIENCE_ORGANIC

	///list of things spawned at mob's loc when it dies.
	var/list/loot = list()
	///causes mob to be deleted on death, useful for mobs that spawn lootable corpses.
	var/del_on_death = FALSE
	var/deathmessage = ""
	///The sound played on death.
	var/death_sound = null

	var/allow_movement_on_non_turfs = FALSE

	///Played when someone punches the creature.
	var/attacked_sound = "punch"

	///If the creature has, and can use, hands.
	var/dextrous = FALSE
	var/dextrous_hud_type = /datum/hud/dextrous

	///The Status of our AI, can be set to AI_ON (On, usual processing), AI_IDLE (Will not process, but will return to AI_ON if an enemy comes near), AI_OFF (Off, Not processing ever), AI_Z_OFF (Temporarily off due to nonpresence of players).
	var/AIStatus = AI_ON
	///once we have become sentient, we can never go back.
	var/can_have_ai = TRUE

	///convenience var for forcibly waking up an idling AI on next check.
	var/shouldwakeup = FALSE

	///Domestication.
	var/tame = 0

	///I don't want to confuse this with client registered_z.
	var/my_z

	///What kind of footstep this mob should have. Null if it shouldn't have any.
	var/footstep_type

	//How much wounding power it has
	var/wound_bonus = CANT_WOUND
	//How much bare wounding power it has
	var/bare_wound_bonus = 0
	//If the attacks from this are sharp
	var/sharpness = SHARP_NONE
	//Generic flags
	var/simple_mob_flags = NONE
	//Mob may be offset randomly on both axes by this much
	var/randpixel = 0

	/// Sets up mob diversity
	var/list/variation_list = list()

/mob/living/simple_animal/Initialize()
	. = ..()
	GLOB.simple_animals[AIStatus] += src
	if(gender == PLURAL)
		gender = pick(MALE,FEMALE)
	if(!real_name)
		real_name = name
	if(!loc)
		stack_trace("Simple animal being instantiated in nullspace")
	update_simplemob_varspeed()
	if(dextrous)
		AddComponent(/datum/component/personal_crafting)
	if(footstep_type)
		AddComponent(/datum/component/footstep, footstep_type)
	pixel_x = rand(-randpixel, randpixel)
	pixel_y = rand(-randpixel, randpixel)
	setup_variations()


/mob/living/simple_animal/Destroy()
	GLOB.simple_animals[AIStatus] -= src
	if (SSnpcpool.state == SS_PAUSED && LAZYLEN(SSnpcpool.currentrun))
		SSnpcpool.currentrun -= src

	sever_link_to_nest()

	var/turf/T = get_turf(src)
	if (T && AIStatus == AI_Z_OFF)
		SSidlenpcpool.idle_mobs_by_zlevel[T.z] -= src
	
	QDEL_NULL(access_card)

	return ..()

/mob/living/simple_animal/updatehealth()
	..()
	health = clamp(health, 0, maxHealth)

/mob/living/simple_animal/update_stat()
	if(status_flags & GODMODE)
		return
	if(stat != DEAD)
		if(health <= 0)
			death()
		else
			set_stat(CONSCIOUS)
	med_hud_set_status()


/mob/living/simple_animal/handle_status_effects()
	..()
	if(stuttering)
		stuttering = 0

/mob/living/simple_animal/proc/handle_automated_action()
	set waitfor = FALSE
	return

/mob/living/simple_animal/proc/handle_automated_movement()
	set waitfor = FALSE
	if(stop_automated_movement || !wander)
		return
	if(!isturf(loc) && !allow_movement_on_non_turfs)
		return
	if(!(mobility_flags & MOBILITY_MOVE)) //This is so it only moves if it's not inside a closet, gentics machine, etc.
		return TRUE

	turns_since_move++
	if(turns_since_move < turns_per_move)
		return TRUE
	if(stop_automated_movement_when_pulled && pulledby) //Some animals don't move when pulled
		return TRUE
	var/anydir = pick(GLOB.cardinals)
	if(Process_Spacemove(anydir))
		Move(get_step(src, anydir), anydir)
		turns_since_move = 0
	return TRUE

/mob/living/simple_animal/proc/handle_automated_speech(override)
	set waitfor = FALSE
	if(speak_chance)
		if(prob(speak_chance) || override)
			if(speak && speak.len)
				if((emote_hear && emote_hear.len) || (emote_see && emote_see.len))
					var/length = speak.len
					if(emote_hear && emote_hear.len)
						length += emote_hear.len
					if(emote_see && emote_see.len)
						length += emote_see.len
					var/randomValue = rand(1,length)
					if(randomValue <= speak.len)
						say(pick(speak), forced = "poly")
					else
						randomValue -= speak.len
						if(emote_see && randomValue <= emote_see.len)
							emote("me [pick(emote_see)]", 1)
						else
							emote("me [pick(emote_hear)]", 2)
				else
					say(pick(speak), forced = "poly")
			else
				if(!(emote_hear && emote_hear.len) && (emote_see && emote_see.len))
					emote("me", EMOTE_VISIBLE, pick(emote_see))
				if((emote_hear && emote_hear.len) && !(emote_see && emote_see.len))
					emote("me", EMOTE_AUDIBLE, pick(emote_hear))
				if((emote_hear && emote_hear.len) && (emote_see && emote_see.len))
					var/length = emote_hear.len + emote_see.len
					var/pick = rand(1,length)
					if(pick <= emote_see.len)
						emote("me", EMOTE_VISIBLE, pick(emote_see))
					else
						emote("me", EMOTE_AUDIBLE, pick(emote_hear))


/mob/living/simple_animal/proc/environment_is_safe(datum/gas_mixture/environment, check_temp = FALSE)
	. = TRUE

	if(pulledby && pulledby.grab_state >= GRAB_KILL && atmos_requirements["min_oxy"])
		. = FALSE //getting choked

	if(isturf(src.loc) && isopenturf(src.loc))
		var/turf/open/ST = src.loc
		if(ST.air)

			var/tox = ST.air.get_moles(GAS_PLASMA)
			var/oxy = ST.air.get_moles(GAS_O2)
			var/n2  = ST.air.get_moles(GAS_N2)
			var/co2 = ST.air.get_moles(GAS_CO2)

			if(atmos_requirements["min_oxy"] && oxy < atmos_requirements["min_oxy"])
				. = FALSE
			else if(atmos_requirements["max_oxy"] && oxy > atmos_requirements["max_oxy"])
				. = FALSE
			else if(atmos_requirements["min_tox"] && tox < atmos_requirements["min_tox"])
				. = FALSE
			else if(atmos_requirements["max_tox"] && tox > atmos_requirements["max_tox"])
				. = FALSE
			else if(atmos_requirements["min_n2"] && n2 < atmos_requirements["min_n2"])
				. = FALSE
			else if(atmos_requirements["max_n2"] && n2 > atmos_requirements["max_n2"])
				. = FALSE
			else if(atmos_requirements["min_co2"] && co2 < atmos_requirements["min_co2"])
				. = FALSE
			else if(atmos_requirements["max_co2"] && co2 > atmos_requirements["max_co2"])
				. = FALSE
		else
			if(atmos_requirements["min_oxy"] || atmos_requirements["min_tox"] || atmos_requirements["min_n2"] || atmos_requirements["min_co2"])
				. = FALSE

	if(check_temp)
		var/areatemp = get_temperature(environment)
		if((areatemp < minbodytemp) || (areatemp > maxbodytemp))
			. = FALSE


/mob/living/simple_animal/handle_environment(datum/gas_mixture/environment)
	var/atom/A = src.loc
	if(isturf(A))
		var/areatemp = get_temperature(environment)
		if( abs(areatemp - bodytemperature) > 5)
			var/diff = areatemp - bodytemperature
			diff = diff / 5
			adjust_bodytemperature(diff)

	if(!environment_is_safe(environment))
		adjustHealth(unsuitable_atmos_damage)

	handle_temperature_damage()

/mob/living/simple_animal/proc/handle_temperature_damage()
	if((bodytemperature < minbodytemp) || (bodytemperature > maxbodytemp))
		adjustHealth(unsuitable_atmos_damage)

/mob/living/simple_animal/gib()
	if(butcher_results)
		var/atom/Tsec = drop_location()
		for(var/path in butcher_results)
			for(var/i in 1 to butcher_results[path])
				new path(Tsec)
	..()

/mob/living/simple_animal/gib_animation()
	if(icon_gib)
		new /obj/effect/temp_visual/gib_animation/animal(loc, icon_gib)

/mob/living/simple_animal/say_mod(input, message_mode)
	if(speak_emote && speak_emote.len)
		verb_say = pick(speak_emote)
	. = ..()

/mob/living/simple_animal/emote(act, m_type=1, message = null, intentional = FALSE)
	if(stat)
		return
	if(act == "scream")
		message = "makes a loud and pained whimper." //ugly hack to stop animals screaming when crushed :P
		act = "me"
	..(act, m_type, message)

/mob/living/simple_animal/proc/set_varspeed(var_value)
	speed = var_value
	update_simplemob_varspeed()

/mob/living/simple_animal/proc/update_simplemob_varspeed()
	if(speed == 0)
		remove_movespeed_modifier(/datum/movespeed_modifier/simplemob_varspeed)
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/simplemob_varspeed, multiplicative_slowdown = speed)

/mob/living/simple_animal/get_status_tab_items()
	. = ..()
	. += ""
	. += "Health: [round((health / maxHealth) * 100)]%"


/mob/living/simple_animal/proc/drop_loot()
	for(var/drop in loot)
		for(var/i in 1 to max(1, loot[drop]))
			new drop(drop_location())

/mob/living/simple_animal/death(gibbed)
	movement_type &= ~FLYING

	sever_link_to_nest()

	drop_loot()
	if(dextrous)
		drop_all_held_items()
	if(!gibbed)
		if(death_sound)
			playsound(get_turf(src),death_sound, 200, 1, ignore_walls = FALSE)
		if(deathmessage || !del_on_death)
			INVOKE_ASYNC(src, .proc/emote, "deathgasp")
	if(del_on_death)
		..()
		//Prevent infinite loops if the mob Destroy() is overridden in such
		//a manner as to cause a call to death() again
		del_on_death = FALSE
		qdel(src)
	else
		health = 0
		icon_state = icon_dead
		density = FALSE
		lying = 1
		..()

/mob/living/simple_animal/proc/CanAttack(atom/the_target)
	if(see_invisible < the_target.invisibility)
		return FALSE
	if(ismob(the_target))
		var/mob/M = the_target
		if(M.status_flags & GODMODE)
			return FALSE
	if (isliving(the_target))
		var/mob/living/L = the_target
		if(L.stat != CONSCIOUS)
			return FALSE
	if (ismecha(the_target))
		var/obj/mecha/M = the_target
		if (M.occupant)
			return FALSE
	return TRUE

/mob/living/simple_animal/handle_fire()
	return

/mob/living/simple_animal/IgniteMob()
	return FALSE

/mob/living/simple_animal/ExtinguishMob()
	return

/mob/living/simple_animal/revive(full_heal = 0, admin_revive = 0)
	if(..()) //successfully ressuscitated from death
		icon = initial(icon)
		icon_state = icon_living
		density = initial(density)
		lying = 0
		. = 1
		setMovetype(initial(movement_type))

/mob/living/simple_animal/proc/make_babies() // <3 <3 <3
	if(gender != FEMALE || stat || next_scan_time > world.time || !childtype || !animal_species || !SSticker.IsRoundInProgress())
		return
	next_scan_time = world.time + 400
	var/alone = 1
	var/mob/living/simple_animal/partner
	var/children = 0
	for(var/mob/M in view(7, src))
		if(M.stat != CONSCIOUS) //Check if it's conscious FIRST.
			continue
		else if(istype(M, childtype)) //Check for children SECOND.
			children++
		else if(istype(M, animal_species))
			if(M.ckey)
				continue
			else if(!istype(M, childtype) && M.gender == MALE) //Better safe than sorry ;_;
				partner = M

		else if(isliving(M) && !faction_check_mob(M)) //shyness check. we're not shy in front of things that share a faction with us.
			return //we never mate when not alone, so just abort early

	if(alone && partner && children < 3)
		var/childspawn = pickweight(childtype)
		var/turf/target = get_turf(loc)
		if(target)
			return new childspawn(target)

/mob/living/simple_animal/canUseTopic(atom/movable/M, be_close=FALSE, no_dextery=FALSE, no_tk=FALSE)
	if(incapacitated())
		to_chat(src, span_warning("You can't do that right now!"))
		return FALSE
	if(be_close && !in_range(M, src))
		to_chat(src, span_warning("You are too far away!"))
		return FALSE
	if(!(no_dextery || dextrous))
		to_chat(src, span_warning("You don't have the dexterity to do this!"))
		return FALSE
	return TRUE

/mob/living/simple_animal/stripPanelUnequip(obj/item/what, mob/who, where)
	if(!canUseTopic(who, BE_CLOSE))
		return
	else
		..()

/mob/living/simple_animal/stripPanelEquip(obj/item/what, mob/who, where)
	if(!canUseTopic(who, BE_CLOSE))
		return
	else
		..()

/mob/living/simple_animal/update_mobility(value_otherwise = MOBILITY_FLAGS_DEFAULT)
	if(IsUnconscious() || IsStun() || IsParalyzed() || stat || resting)
		drop_all_held_items()
		mobility_flags = NONE
	else if(buckled)
		mobility_flags = ~MOBILITY_MOVE
	else
		mobility_flags = MOBILITY_FLAGS_DEFAULT
	if(!CHECK_MOBILITY(src, MOBILITY_MOVE)) // !(mobility_flags & MOBILITY_MOVE)
		walk(src, 0) //stop mid walk
	update_transform()
	update_action_buttons_icon()
	return mobility_flags

/mob/living/simple_animal/update_transform()
	var/matrix/ntransform = matrix(transform) //aka transform.Copy()
	var/changed = 0

	if(resize != RESIZE_DEFAULT_SIZE)
		changed++
		ntransform.Scale(resize)
		resize = RESIZE_DEFAULT_SIZE

	if(changed)
		animate(src, transform = ntransform, time = 2, easing = EASE_IN|EASE_OUT)

/mob/living/simple_animal/proc/sentience_act() //Called when a simple animal gains sentience via gold slime potion
	toggle_ai(AI_OFF) // To prevent any weirdness.
	can_have_ai = FALSE

/mob/living/simple_animal/update_sight()
	if(!client)
		return
	if(stat == DEAD)
		sight = (SEE_TURFS|SEE_MOBS|SEE_OBJS)
		see_in_dark = 8
		see_invisible = SEE_INVISIBLE_OBSERVER
		return

	see_invisible = initial(see_invisible)
	see_in_dark = initial(see_in_dark)
	sight = initial(sight)

	if(client.eye != src)
		var/atom/A = client.eye
		if(A.update_remote_sight(src)) //returns 1 if we override all other sight updates.
			return
	sync_lighting_plane_alpha()

/mob/living/simple_animal/get_idcard(hand_first = TRUE)
	return ..() || access_card

/mob/living/simple_animal/can_hold_items()
	return dextrous

/mob/living/simple_animal/IsAdvancedToolUser()
	return dextrous

/mob/living/simple_animal/activate_hand(selhand)
	if(!dextrous)
		return ..()
	if(!selhand)
		selhand = (active_hand_index % held_items.len)+1
	if(istext(selhand))
		selhand = lowertext(selhand)
		if(selhand == "right" || selhand == "r")
			selhand = 2
		if(selhand == "left" || selhand == "l")
			selhand = 1
	if(selhand != active_hand_index)
		swap_hand(selhand)
	else
		mode()

/mob/living/simple_animal/swap_hand(hand_index)
	. = ..()
	if(!.)
		return
	if(!dextrous)
		return
	if(!hand_index)
		hand_index = (active_hand_index % held_items.len)+1
	var/oindex = active_hand_index
	active_hand_index = hand_index
	if(hud_used)
		var/obj/screen/inventory/hand/H
		H = hud_used.hand_slots["[hand_index]"]
		if(H)
			H.update_icon()
		H = hud_used.hand_slots["[oindex]"]
		if(H)
			H.update_icon()

/mob/living/simple_animal/put_in_hands(obj/item/I, del_on_fail = FALSE, merge_stacks = TRUE)
	. = ..(I, del_on_fail, merge_stacks)
	update_inv_hands()

/mob/living/simple_animal/update_inv_hands()
	if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
		var/obj/item/l_hand = get_item_for_held_index(1)
		var/obj/item/r_hand = get_item_for_held_index(2)
		if(r_hand)
			r_hand.layer = ABOVE_HUD_LAYER
			r_hand.plane = ABOVE_HUD_PLANE
			r_hand.screen_loc = ui_hand_position(get_held_index_of_item(r_hand))
			client.screen |= r_hand
		if(l_hand)
			l_hand.layer = ABOVE_HUD_LAYER
			l_hand.plane = ABOVE_HUD_PLANE
			l_hand.screen_loc = ui_hand_position(get_held_index_of_item(l_hand))
			client.screen |= l_hand

//ANIMAL RIDING

/mob/living/simple_animal/user_buckle_mob(mob/living/M, mob/user)
	var/datum/component/riding/riding_datum = GetComponent(/datum/component/riding)
	if(riding_datum)
		if(user.incapacitated())
			return
		for(var/atom/movable/A in get_turf(src))
			if(A != src && A != M && A.density)
				return
		M.forceMove(get_turf(src))
		return ..()

/mob/living/simple_animal/relaymove(mob/user, direction)
	var/datum/component/riding/riding_datum = GetComponent(/datum/component/riding)
	if(tame && riding_datum)
		riding_datum.handle_ride(user, direction)

/mob/living/simple_animal/buckle_mob(mob/living/buckled_mob, force = 0, check_loc = 1)
	. = ..()
	LoadComponent(/datum/component/riding)

/mob/living/simple_animal/proc/toggle_ai(togglestatus)
	if(!can_have_ai && (togglestatus != AI_OFF))
		return
	if (AIStatus != togglestatus)
		if (togglestatus > 0 && togglestatus < 5)
			if (togglestatus == AI_Z_OFF || AIStatus == AI_Z_OFF)
				var/turf/T = get_turf(src)
				if (AIStatus == AI_Z_OFF)
					SSidlenpcpool.idle_mobs_by_zlevel[T.z] -= src
				else
					SSidlenpcpool.idle_mobs_by_zlevel[T.z] += src
			GLOB.simple_animals[AIStatus] -= src
			GLOB.simple_animals[togglestatus] += src
			AIStatus = togglestatus
		else
			stack_trace("Something attempted to set simple animals AI to an invalid state: [togglestatus]")

/mob/living/simple_animal/proc/consider_wakeup()
	if (pulledby || shouldwakeup)
		toggle_ai(AI_ON)

/mob/living/simple_animal/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(!ckey && !stat)//Not unconscious
		if(AIStatus == AI_IDLE)
			toggle_ai(AI_ON)


/mob/living/simple_animal/onTransitZ(old_z, new_z)
	..()
	if (AIStatus == AI_Z_OFF)
		SSidlenpcpool.idle_mobs_by_zlevel[old_z] -= src
		toggle_ai(initial(AIStatus))

/mob/living/simple_animal/Life()
	. = ..()
	if(stat)
		return
	if (idlesound)
		if (prob(5))
			var/chosen_sound = pick(idlesound)
			playsound(src, chosen_sound, 60, FALSE, ignore_walls = FALSE)

/mob/living/simple_animal/proc/sever_link_to_nest()
	if(nest)
		var/datum/component/spawner/our_nest = nest.resolve()
		if(istype(our_nest))
			for(var/datum/weakref/maybe_us in our_nest.spawned_mobs)
				if(nest.resolve(maybe_us) == src)
					our_nest.spawned_mobs -= maybe_us
	nest = null

/mob/living/simple_animal/proc/setup_variations()
	if(!LAZYLEN(variation_list))
		return FALSE // we're good here
	if(LAZYLEN(variation_list[MOB_VARIED_NAME_GLOBAL_LIST]))
		vary_mob_name_from_global_lists()
	else if(LAZYLEN(variation_list[MOB_VARIED_NAME_LIST]))
		vary_mob_name_from_local_list()
	if(LAZYLEN(variation_list[MOB_VARIED_COLOR]))
		vary_mob_color()
	if(LAZYLEN(variation_list[MOB_VARIED_HEALTH]))
		var/our_health = vary_from_list(variation_list[MOB_VARIED_HEALTH])
		maxHealth = our_health
		health = our_health
	return TRUE

/mob/living/simple_animal/proc/vary_from_list(which_list)
	if(isnum(which_list))
		return which_list
	if(islist(which_list))
		return(pick(which_list))

/mob/living/simple_animal/proc/vary_mob_name_from_global_lists()
	var/list/our_mob_random_name_list = variation_list[MOB_VARIED_NAME_GLOBAL_LIST]
	var/our_new_name = ""
	var/number_of_name_tokens_left = LAZYLEN(variation_list[MOB_VARIED_NAME_GLOBAL_LIST])
	for(var/name_token in our_mob_random_name_list)
		for(var/num_names in 1 to LAZYLEN(our_mob_random_name_list[name_token]) ? our_mob_random_name_list[name_token] : 1)
			switch(name_token)
				if(MOB_NAME_RANDOM_MALE)
					our_new_name += capitalize(pick(GLOB.first_names_male)) + " " + capitalize(pick(GLOB.last_names))
				if(MOB_NAME_RANDOM_FEMALE)
					our_new_name += capitalize(pick(GLOB.first_names_female)) + " " + capitalize(pick(GLOB.last_names))
				if(MOB_NAME_RANDOM_LIZARD_MALE)
					our_new_name += capitalize(lizard_name(MALE))
				if(MOB_NAME_RANDOM_LIZARD_FEMALE)
					our_new_name += capitalize(lizard_name(FEMALE))
				if(MOB_NAME_RANDOM_PLASMAMAN)
					our_new_name += capitalize(plasmaman_name())
				if(MOB_NAME_RANDOM_ETHERIAL)
					our_new_name += capitalize(ethereal_name())
				if(MOB_NAME_RANDOM_MOTH)
					our_new_name += capitalize(pick(GLOB.moth_first)) + " " + capitalize(pick(GLOB.moth_last))
				if(MOB_NAME_RANDOM_ALL_OF_THEM)
					our_new_name += get_random_random_name()
			if(num_names < our_mob_random_name_list[name_token])
				our_new_name += " "
		if(number_of_name_tokens_left-- > 0)
			our_new_name += " "
	if(our_new_name != "")
		name = our_new_name

/mob/living/simple_animal/proc/vary_mob_name_from_local_list()
	name = pick(variation_list[MOB_VARIED_NAME_LIST])

/mob/living/simple_animal/proc/vary_mob_color()
	if(LAZYLEN(variation_list[MOB_VARIED_COLOR][MOB_VARIED_COLOR_MIN]) != 3)
		return
	if(LAZYLEN(variation_list[MOB_VARIED_COLOR][MOB_VARIED_COLOR_MAX]) != 3)
		return

	var/list/our_mob_random_color_list = variation_list[MOB_VARIED_COLOR]
	var/list/colors = list()

	if(our_mob_random_color_list[MOB_VARIED_COLOR_MIN][1] < 1 && our_mob_random_color_list[MOB_VARIED_COLOR_MAX][1] < 1)
		colors["red"] = 255
	else
		var/list/red_numbers = put_numbers_in_order(our_mob_random_color_list[MOB_VARIED_COLOR_MIN][1], our_mob_random_color_list[MOB_VARIED_COLOR_MAX][1])
		colors["red"] = rand(red_numbers[1], red_numbers[2])

	if(our_mob_random_color_list[MOB_VARIED_COLOR_MIN][2] < 1 && our_mob_random_color_list[MOB_VARIED_COLOR_MAX][2] < 1)
		colors["green"] = 255
	else
		var/list/green_numbers = put_numbers_in_order(our_mob_random_color_list[MOB_VARIED_COLOR_MIN][2], our_mob_random_color_list[MOB_VARIED_COLOR_MAX][2])
		colors["green"] = rand(green_numbers[1], green_numbers[2])

	if(our_mob_random_color_list[MOB_VARIED_COLOR_MIN][3] < 1 && our_mob_random_color_list[MOB_VARIED_COLOR_MAX][3] < 1)
		colors["blue"] = 255
	else
		var/list/blue_numbers = put_numbers_in_order(our_mob_random_color_list[MOB_VARIED_COLOR_MIN][3], our_mob_random_color_list[MOB_VARIED_COLOR_MAX][3])
		colors["blue"] = rand(blue_numbers[1], blue_numbers[2])
	color = rgb(clamp(colors["red"], 0, 255), clamp(colors["green"], 0, 255), clamp(colors["blue"], 0, 255))

/mob/living/simple_animal/proc/put_numbers_in_order(num_1, num_2)
	if(num_1 < num_2)
		return list(num_1, num_2)
	return list(num_2, num_1)


/mob/living/simple_animal/proc/get_random_random_name()
	switch(rand(1,27))
		if(1)
			return pick(GLOB.ai_names)
		if(2)
			return pick(GLOB.wizard_first)
		if(3)
			return pick(GLOB.wizard_second)
		if(4)
			return pick(GLOB.ninja_titles)
		if(5)
			return pick(GLOB.ninja_names)
		if(6)
			return pick(GLOB.commando_names)
		if(7)
			return pick(GLOB.first_names)
		if(8)
			return pick(GLOB.first_names_male)
		if(9)
			return pick(GLOB.first_names_female)
		if(10)
			return pick(GLOB.last_names)
		if(11)
			return pick(GLOB.lizard_names_male)
		if(12)
			return pick(GLOB.lizard_names_female)
		if(13)
			return pick(GLOB.carp_names)
		if(14)
			return pick(GLOB.golem_names)
		if(15)
			return pick(GLOB.moth_first)
		if(16)
			return pick(GLOB.moth_last)
		if(17)
			return pick(GLOB.plasmaman_names)
		if(18)
			return pick(GLOB.ethereal_names)
		if(19)
			return pick(GLOB.posibrain_names)
		if(20)
			return pick(GLOB.nightmare_names)
		if(21)
			return pick(GLOB.megacarp_first_names)
		if(22)
			return pick(GLOB.megacarp_last_names)
		if(23)
			return pick(GLOB.verbs)
		if(24)
			return pick(GLOB.ing_verbs)
		if(25)
			return pick(GLOB.adverbs)
		if(26)
			return pick(GLOB.adjectives)
		if(27)
			return pick(GLOB.dream_strings)


