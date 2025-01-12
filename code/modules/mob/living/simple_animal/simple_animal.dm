GLOBAL_LIST_EMPTY(playmob_cooldowns)

/mob/living/simple_animal
	name = "animal"
	icon = 'icons/mob/animal.dmi'
	health = 20
	maxHealth = 20
	/// When the mob has this much stamina damage, put them in stamcrit. set to SIMPLEMOB_NO_STAMCRIT
	var/stamcrit_threshold
	/// They are stamcritted for this long when stamcrit
	var/stamcrit_duration = 5 SECONDS
	COOLDOWN_DECLARE(stamcrit_timer)
	gender = PLURAL //placeholder
	///How much blud it has for bloodsucking
	blood_volume = 425 //blood will smeared only a little bit from body dragging
	var/bossmob = FALSE
	status_flags = CANPUSH
	rotate_on_lying = TRUE
	var/icon_living = ""
	///icon when the animal is dead. Don't use animated icons for this.
	var/icon_dead = ""
	///We only try to show a gibbing animation if this exists.
	var/icon_gib = null
	/// color to colorize the dead sprite, if it should be different from the living sprite
	var/color_dead = null

	var/list/speak = list()
	///Emotes while speaking IE: Ian [emote], [text] -- Ian barks, "WOOF!". Spoken text is generated from the speak variable.
	var/list/speak_emote = list()
	var/speak_chance = 0
	///Hearable emotes
	var/list/emote_hear = list()
	///Unlike speak_emote, the list of things in this variable only show by themselves with no spoken text. IE: Ian barks, Ian yaps.
	var/list/emote_see = list()

	var/bombs_can_gib_me = TRUE

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
	var/harm_intent_damage = 8 //Damage taken by punches, setting slightly higher than average punch damage as if you're punching a aethergiest then you're desperate enough to need it
	/// Mob damage threshold, subtracted from incoming damage
	var/force_threshold = 0
	/// mob's inherent armor
	var/datum/armor/mob_armor = ARMOR_VALUE_ZERO
	/// Additional armor modifiers that are applied to the actual armor value
	var/mob_armor_tokens = list()
	/// Description line for their armor, cached nice and sweet
	var/mob_armor_description = span_phobia("Oh deary me all my armor fell off uwu") // dear god dont let this show up

	///Temperature effect.
	var/minbodytemp = 250
	var/maxbodytemp = 350

	///Healable by medical stacks? Defaults to yes.
	var/healable = 1

	///Atmos effect - Yes, you can make creatures that require plasma or co2 to survive. N2O is a trace gas and handled separately, hence why it isn't here. It'd be hard to add it. Hard and me don't mix (Yes, yes make all the dick jokes you want with that.) - Errorage
	var/list/atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0) //Leaving something at 0 means it's off - has no maximum
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
	var/list/damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, CLONE = 1, STAMINA = 1, OXY = 1)
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
	/// Breaks everything, makes player controlled mobs wayyyyy tooo slow - didn't ask teehee
	var/speed = 1

	var/idlesound = null //What to play when idling, if anything.
	//var/aggrosound = null
	/// set to a value between -100 and 100 to change the mob's pitch. Set to 0 for default pitch
	var/sound_pitch = 0
	/// How much will the pitch vary? first is how much lower it can go, second is how high it can go. from -100 to 100. please make the first number smaller than the second
	var/list/vary_pitches = list(-100, 100)

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
	var/nest_coords

	///Sentience type, for slime potions.
	var/sentience_type = SENTIENCE_ORGANIC

	///list of things spawned at mob's loc when it dies.
	var/list/loot = list()
	///How do we handle the loot list? Should be either MOB_LOOT_ALL or a number. If its a number, use an associated weighted list for `loot`!
	var/loot_drop_amount = MOB_LOOT_ALL
	///Drop a random number, 1 through loot_drop_amount? only applicable if loot_drop_amount is a number
	var/loot_amount_random = TRUE
	///causes mob to be deleted on death, useful for mobs that spawn lootable corpses.
	var/del_on_death = FALSE
	var/deathmessage = ""
	///The sound played on death.
	var/death_sound = null

	var/allow_movement_on_non_turfs = FALSE
	var/move_to_delay = 3.5
	var/minimum_distance = 0
	var/target_coords
	var/RTS_move_target_range = 2

	var/RTS_aggro_lockout = 0

	var/RTS_max_RTS_frustration_seconds = 10
	var/RTS_frustration_seconds = 0
	var/RTS_last_frustration = 0
	var/RTS_frustration_coords

	var/no_ghost_gta

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
	var/wound_bonus = 0
	//How much bare wounding power it has
	var/bare_wound_bonus = 0
	//If the attacks from this are sharp
	var/sharpness = SHARP_NONE
	//Generic flags
	var/simple_mob_flags = NONE
	//Mob may be offset randomly on both axes by this much
	var/randpixel = 0
	///Can ghosts just hop into one of these guys?
	var/can_ghost_into = FALSE
	///The class of mob this is, for purposes of per-mob ghost cooldowns
	var/ghost_mob_id = "generic"
	///Timeout between dying or ghosting in this mob and going back into another mob
	var/ghost_cooldown_time = 15 MINUTES
	///Short desc of the mob
	var/desc_short = "Some kind of horrible monster."
	///Important info of the mob
	var/desc_important = ""
	var/obj/effect/proc_holder/mob_common/direct_mobs/send_mobs
	var/obj/effect/proc_holder/mob_common/summon_backup/call_backup
	var/datum/action/innate/ghostify/ghostme
	COOLDOWN_DECLARE(ding_spam_cooldown)

	/// Sets up mob diversity
	var/list/variation_list = list()
	/// obey the variation requests
	var/vary = TRUE
	/// has the mob been lazarused?
	var/lazarused = FALSE
	/// Who lazarused this mob?
	var/datum/weakref/lazarused_by
	/// required pop to hop into this thing
	var/pop_required_to_jump_into = 0

	var/obj/effect/proc_holder/mob_common/make_nest/make_a_nest
	var/obj/effect/proc_holder/mob_common/unmake_nest/unmake_a_nest

	///If this is a player's ckey then this mob was spawned as a player's character
	var/player_character = null
	var/ignore_other_mobs = TRUE // If TRUE, the mob will fight other mobs, if FALSE, it will only fight players
	var/override_ignore_other_mobs = FALSE // If TRUE, it'll ignore the idnore other mobs flag, for mobs that are supposed to be hostile to everything

	///multichance projectile hit behaviour (MCPHB)
	var/mcphb_arms_hit = FALSE
	var/mcphb_legs_hit = FALSE
	
	/// makes certain mobs explode into stuff when they die
	var/am_important = FALSE // you are not important
	coolshadow = FALSE

	var/quit_stealing_my_bike = FALSE


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
		AddComponent(/datum/component/footstep, footstep_type, 1, 3)
	pixel_x = rand(-randpixel, randpixel)
	pixel_y = rand(-randpixel, randpixel)
	/// WARNING: DUPLICATED CODE, MAKE BETTER
	setup_mob_armor_values()
	if (islist(mob_armor))
		mob_armor = getArmor(arglist(mob_armor))
	else if (!mob_armor)
		mob_armor = getArmor()
	else if (!istype(mob_armor, /datum/armor))
		stack_trace("Invalid type [mob_armor.type] found in .armor during /mob/living/simple_animal Initialize()")
	/// End duplicated code
	setup_mob_armor_description()
	if(can_ghost_into)
		make_ghostable()
	setup_variations()
	if(isnull(stamcrit_threshold))
		stamcrit_threshold = maxHealth * 2

/mob/living/simple_animal/attack_ghost(mob/user, latejoinercalling)
	. = ..()
	if(!cleared_to_enter(user))
		return
	if(lazarused)
		to_chat(user, span_userdanger("[name] has been lazarus injected or tamed by beastmaster! There are special rules for playing as this creature!"))
		to_chat(user, span_alert("You will be bound to serving a certain person, and very likely will be required to be friendly to Nash and its citizens! Just something to keep in mind!"))
		var/mob/the_master
		if(isweakref(lazarused_by))
			the_master = lazarused_by.resolve()
		if(the_master)
			to_chat(user, span_alert("Your master will be [the_master.real_name]! Follow their commands at all costs! (within reason of course)"))
		else
			to_chat(user, span_alert("Your master will be Nash and its citizens, protect them at all costs!"))
	var/ghost_role = alert("Hop into [name]? (This is a ghost role, still in development!)","Play as a mob!","Yes, spawn me in!","No, I wanna be a ghost!")
	if(ghost_role == "No, I wanna be a ghost!" || !loc)
		return
	if(QDELETED(src) || QDELETED(user))
		return
	if(latejoinercalling)
		var/mob/dead/new_player/NP = user
		if(istype(NP))
			NP.close_spawn_windows()
			NP.stop_sound_channel(CHANNEL_LOBBYMUSIC)
	log_game("[key_name(user)] hopped into [name]")
	become_the_mob(user)
	return TRUE

/mob/living/simple_animal/proc/become_the_mob(mob/user)
	if(!user.ckey)
		return
	user.transfer_ckey(src, TRUE)
	grant_all_languages()
	if(ispath(send_mobs))
		var/obj/effect/proc_holder/mob_common/direct_mobs/DM = send_mobs
		send_mobs = new DM
		AddAbility(send_mobs)
	if(ispath(call_backup))
		var/obj/effect/proc_holder/mob_common/summon_backup/CB = call_backup
		call_backup = new CB
		AddAbility(call_backup)
	if(ispath(make_a_nest))
		var/obj/effect/proc_holder/mob_common/make_nest/MN = make_a_nest
		make_a_nest = new MN
		AddAbility(make_a_nest)
		unmake_a_nest = new
		AddAbility(unmake_a_nest)
	if(lazarused)
		to_chat(src, span_userdanger("[name] has been lazarus injected or tamed by beastmaster! There are special rules for playing as this creature!"))
		to_chat(src, span_alert("You will be bound to serving a certain person, and very likely will be required to be friendly to Nash and its citizens! Just something to keep in mind!"))
		var/mob/the_master
		if(isweakref(lazarused_by))
			the_master = lazarused_by.resolve()
		if(the_master)
			to_chat(src, span_alert("Your master is [the_master.real_name]! Follow their commands at all costs! (within reason of course)"))
			log_game("[key_name(src)] has been informed that they ([name]) are lazarus injected/tamed, and will serve [the_master.real_name].")
			if(mind)
				mind.store_memory("You have been lazarus injected or tamed by [the_master.real_name], and you're bound to follow their commands! (within reason)")
		else
			to_chat(src, span_alert("Your master is be Nash and its citizens, protect them at all costs!"))
			if(mind)
				mind.store_memory("You have been lazarus injected or tamed, and are bound to serve the town of Nash and protect its people.")
			log_game("[key_name(src)] has been informed that they ([name]) are lazarus injected/tamed, and will serve Nash.")

/mob/living/simple_animal/proc/cleared_to_enter(mob/user)
	if(!can_ghost_into)
		return FALSE
	if(health <= 0 || stat == DEAD)
		return FALSE
	if(!SSticker.HasRoundStarted() || !loc)
		return FALSE
	if(QDELETED(src) || QDELETED(user))
		return FALSE
	if(jobban_isbanned(user, ROLE_SYNDICATE))
		to_chat(user, span_warning("You are jobanned from playing as mobs!"))
		return FALSE
	/*if(!(z in COMMON_Z_LEVELS))
		to_chat(user, span_warning("[name] is somewhere that blocks them from being ghosted into! Try somewhere aboveground (or not in a dungeon!)"))
		return FALSE*/ // Kekeke, zlevel restrictions are antifun anyway!!!!!!!!!!!!!!!!
	if(!lazarused_by && living_player_count() < pop_required_to_jump_into)
		to_chat(user, span_warning("There needs to be at least [pop_required_to_jump_into] living players to hop in this! This check is bypassed if the mob has had a lazarus injector used on it though. Which it hasn't (yet)."))
		return FALSE
	if(client)
		to_chat(user, span_warning("Someone's in there! Wait your turn!"))
		return FALSE
	if(player_character && player_character != user.ckey)
		to_chat(user, span_warning("This mob is someone else's character so you cannot hop into them!"))
		return FALSE
	if(!user.key)
		return FALSE
	/*if(!islist(GLOB.playmob_cooldowns[user.key]))
		GLOB.playmob_cooldowns[user.key] = list()
	if(GLOB.playmob_cooldowns[user.key][ghost_mob_id] > world.time)
		var/time_left = GLOB.playmob_cooldowns[user.key][ghost_mob_id] - world.time*/ // No, respawn times are instant
		//if(check_rights_for(user.client, R_ADMIN))
		//	to_chat(user, span_green("You shoud be unable to hop into mobs for another [DisplayTimeText(time_left)], but you're special cus you're an admin and you can ghost into mobs whenever you want, also everyone loves you and thinks you're cool."))
		//else // yeah no turns out its not a great idea
		/*to_chat(user, span_warning("You're unable to hop into mobs for another [DisplayTimeText(time_left)]."))
		return FALSE*/
	return TRUE

/mob/living/simple_animal/ComponentInitialize()
	. = ..()
	if(can_ghost_into)
		AddElement(/datum/element/ghost_role_eligibility, free_ghosting = FALSE, penalize_on_ghost = TRUE)
	RegisterSignal(src, COMSIG_HOSTILE_CHECK_FACTION,PROC_REF(infight_check))
	RegisterSignal(src, COMSIG_ATOM_BUTCHER,PROC_REF(butcher_me))
	RegisterSignal(src, COMSIG_ATOM_CAN_BUTCHER,PROC_REF(can_butcher))
	RegisterSignal(src, COMSIG_MOB_IS_IMPORTANT,PROC_REF(am_i_important))
	RegisterSignal(src, COMSIG_ATOM_QUEST_SCANNED,PROC_REF(i_got_scanned))
	RegisterSignal(src, COMSIG_RTS_SELECTED,PROC_REF(i_got_selected))

/mob/living/simple_animal/proc/i_got_scanned(datum/source, mob/scanner)
	if(!nest_coords)
		return
	var/turf/nest_turf = coords2turf(nest_coords)
	if(!nest_turf)
		return
	var/obj/structure/nest/N = locate(/obj/structure/nest) in nest_turf
	if(!N)
		return
	SEND_SIGNAL(N, COMSIG_ATOM_QUEST_SCANNED, scanner)

/mob/living/simple_animal/proc/am_i_important()
	return am_important

/mob/living/simple_animal/proc/i_got_selected(datum/source, mob/selecter)
	// if(!selecter)
	// 	return
	// var/myteam = selecter.ckey
	// if(!selecter.ckey)
	// 	myteam = "bingus"
	// myteam = "team-[myteam]" // Team discovery channel!
	// faction |= myteam

/mob/living/simple_animal/proc/infight_check(mob/living/simple_animal/H)
	if(SSmobs.debug_disable_mob_ceasefire)
		return
	if(H.client || client || player_character || H.player_character)
		return
	if(override_ignore_other_mobs || H.override_ignore_other_mobs)
		return
	if(!istype(H))
		return
	return (H.ignore_other_mobs || ignore_other_mobs)

/mob/living/simple_animal/Destroy()
	GLOB.simple_animals[AIStatus] -= src
	SSnpcpool.currentrun -= src
	sever_link_to_nest()
	if(make_a_nest)
		QDEL_NULL(make_a_nest)
	if(unmake_a_nest)
		QDEL_NULL(unmake_a_nest)
	LAZYREMOVE(GLOB.mob_spawners[initial(name)], src)
	if(!LAZYLEN(GLOB.mob_spawners[initial(name)]))
		GLOB.mob_spawners -= initial(name)
	if(lazarused)
		LAZYREMOVE(GLOB.mob_spawners["Tame [initial(name)]"], src)
		if(!LAZYLEN(GLOB.mob_spawners["Tame [initial(name)]"]))
			GLOB.mob_spawners -= "Tame [initial(name)]"
	lazarused_by = null

	var/turf/T = get_turf(src)
	if (T && AIStatus == AI_Z_OFF)
		SSidlenpcpool.idle_mobs_by_zlevel[T.z] -= src
	
	QDEL_NULL(access_card)

	return ..()

//Coyote Add
/mob
	///A detailed description of this mob that can be read if you examine them.
	var/flavortext = ""
	///A detailed description of the player who's controlling this mob's out-of-character roleplaying preferences. Do not set.
	var/oocnotes = ""
	///The specific name of this mob's species or subtype. Used for examine text (ie "this is Nutty a Squirrel", where Squirrel is the verbose_species)
	var/verbose_species = null

/mob/living/simple_animal/proc/print_flavor_text()
	if(flavortext && flavortext != "")
		var/msg = replacetext(flavortext, "\n", " ")
		if(length(msg) <= 40)
			return span_notice("[msg]")
		else
			return "<span class='notice'>[html_encode(copytext(msg, 1, 37))]... <a href='byond://?src=\ref[src];flavor_more=1'>More...</span></a>"

/mob/living/simple_animal/examine(mob/user)
	if(player_character)
		var/list/dat = list()
		dat += "<span class='info'>*---------*\n This is [icon2html(src, user)] <EM>[src.name]</EM>[verbose_species ? ", a <EM>[verbose_species]</EM>" : ""]!</span>"
		if(profilePicture)
			dat += "<a href='?src=[REF(src)];enlargeImageCreature=1'><img src='[PfpHostLink(profilePicture, pfphost)]' width='125' height='auto' max-height='300'></a>"
		//Hands
		for(var/obj/item/I in held_items)
			if(!(I.item_flags & ABSTRACT))
				dat += "[p_they(TRUE)] [p_are()] holding [I.get_examine_string(user)] in [p_their()] [get_held_index_name(get_held_index_of_item(I))]."
		//Internal storage
		if(internal_storage && !(internal_storage.item_flags & ABSTRACT))
			dat += "[p_they(TRUE)] [p_are()] wearing [internal_storage.get_examine_string(user)]."
		//Cosmetic hat - provides no function other than looks
		if(head && !(head.item_flags & ABSTRACT))
			dat += "[p_they(TRUE)] [p_are()] wearing [head.get_examine_string(user)] on [p_their()] head."
		if(flavortext)
			dat += "[print_flavor_text()]"
		if(oocnotes)
			dat += "<span class = 'deptradio'>OOC Notes:</span> <a href='?src=\ref[src];oocnotes=1'>\[View\]</a>"
		if(src.getBruteLoss())
			if(src.getBruteLoss() < (maxHealth/2))
				dat += span_warning("[p_they(TRUE)] looks bruised.")
			else
				dat += span_warning("<B>[p_they(TRUE)] looks severely bruised and bloodied!</B>")
		if(src.getFireLoss())
			if(src.getFireLoss() < (maxHealth/2))
				dat += span_warning("[p_they(TRUE)] looks burned.")
			else
				dat += span_warning("<B>[p_they(TRUE)] looks severely burned.</B>")
		//Personality and RP Preferences quirk display
		dat += get_personality_traits(user)
		//SPECIAL stats display
		dat += "[print_special()]"
		if(client && ((client.inactivity / 10) / 60 > 20)) //20 Minutes
			dat += "\[Inactive for [round((client.inactivity/10)/60)] minutes\]"
		else if(disconnect_time)
			dat += "\[Disconnected/ghosted [round(((world.realtime - disconnect_time)/10)/60)] minutes ago\]"
		if(lazarused)
			dat += span_danger("[p_they(TRUE)] seems to have been revived!<br>")
		dat += "<span class='info'>*---------*</span>"
		return dat
	else
		. = ..()
		. += mob_armor_description
		if(lazarused)
			. += span_danger("[p_they(TRUE)] seems to have been revived!")

/// If user is set, the mob will be told to be loyal to that mob
/mob/living/simple_animal/proc/make_ghostable(mob/user)
	can_ghost_into = TRUE
	AddElement(/datum/element/ghost_role_eligibility, free_ghosting = TRUE, penalize_on_ghost = FALSE)
	LAZYADD(GLOB.mob_spawners[initial(name)], src)
	// RegisterSignal(src, COMSIG_MOB_GHOSTIZE_FINAL,PROC_REF(set_ghost_timeout))
	if(istype(user))
		lazarused = TRUE
		lazarused_by = WEAKREF(user)
		if(user.mind)
			user.mind.store_memory("You were revived by [user.real_name], and thus are compelled to follow their commands and protect them!")
		show_message(span_userdanger("You were revived by [user.real_name], and are bound to protect them and follow their commands!"))
		LAZYREMOVE(GLOB.mob_spawners[initial(name)], src)
		if(!LAZYLEN(GLOB.mob_spawners[initial(name)]))
			GLOB.mob_spawners -= initial(name)
		LAZYADD(GLOB.mob_spawners["Tame [initial(name)]"], src)

/// Player left the mob's body
/mob/living/simple_animal/proc/set_ghost_timeout()
	SIGNAL_HANDLER
	if(!key)
		return // cant do much without a key!
	if(!islist(GLOB.playmob_cooldowns[key]))
		GLOB.playmob_cooldowns[key] = list()
	GLOB.playmob_cooldowns[key][ghost_mob_id] = world.time + ghost_cooldown_time	

/mob/living/simple_animal/updatehealth()
	..()
	health = clamp(health, 0, maxHealth)
	var/slow = 0
	if(client && !HAS_TRAIT(src, TRAIT_IGNOREDAMAGESLOWDOWN))//Player controlled animal
		var/health_percent = ((health/maxHealth)*100)//1-100 scale for health
		if(health_percent <= 50 && health_percent > 0)//Start slowdown at half health, stop slowdown when health is at or below zero to prevent divide by zero errors
			slow += ((50/health_percent)/2)//0.5 slowdown at 1/2 health, 1 slowdown at 1/4 health, etc
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/damage_slowdown, TRUE, slow)

/mob/living/simple_animal/update_stat()
	if(status_flags & GODMODE)
		return
	if(stat != DEAD)
		if(health <= 0)
			death()
		else
			if(IsSleeping())
				set_stat(UNCONSCIOUS)
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
	if(!CHECK_MOBILITY(src, MOBILITY_MOVE)) // !(mobility_flags & MOBILITY_MOVE)
		walk(src, 0) //stop mid walk
		return FALSE
	if(has_buckled_mobs()) //If someones on a mount then it won't wander about with them
		return FALSE
	if(turns_per_move == -1) //stops wandering entirely
		return FALSE
	if(RTS_move_ordered())
		// am_within_range_of_target_coords()
		return FALSE
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
	if(!speak_chance)
		return
	if(!prob(speak_chance) && !override)
		return
	if(speak && speak.len)
		if((emote_hear && emote_hear.len) || (emote_see && emote_see.len))
			var/length = speak.len
			if(emote_hear && emote_hear.len)
				length += emote_hear.len
			if(emote_see && emote_see.len)
				length += emote_see.len
			var/randomValue = rand(1,length)
			if(randomValue <= speak.len)
				say(pick(speak), forced = "poly", only_overhead = TRUE)
			else
				randomValue -= speak.len
				if(emote_see && randomValue <= emote_see.len)
					emote("me [pick(emote_see)]", 1)
				else
					emote("me [pick(emote_hear)]", 2)
		else
			say(pick(speak), forced = "poly", only_overhead = TRUE)
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

/*
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
*/

/mob/living/simple_animal/proc/can_butcher()
	return !already_butchered

/mob/living/simple_animal/proc/butcher_me(datum/source, mob/butcherer, bonus_modifier, effectiveness, gibbed, loud = TRUE)
	if(!butcherer)
		return
	if(!butcher_results && !guaranteed_butcher_results)
		return
	if(already_butchered)
		return
	already_butchered = TRUE

	if(butcherer && HAS_TRAIT(butcherer, TRAIT_TRAPPER))
		effectiveness *= 2
	var/chance_to_drop_butchered_thing = effectiveness / max(butcher_difficulty, 0.01)
	var/bonus_chance = max(0, (chance_to_drop_butchered_thing - 100) + bonus_modifier) //so 125 total effectiveness = 25% extra chance
	var/meat_quality = 50 + (chance_to_drop_butchered_thing/10) //increases through quality of butchering tool, and through if it was butchered in the kitchen or not

	var/said_fail = FALSE
	var/turf/T = drop_location()
	var/list/butchered_items = list()
	for(var/V in butcher_results)
		var/obj/rando_bits = V
		var/amount = butcher_results[rando_bits]
		for(var/_i in 1 to amount)
			if(!prob(chance_to_drop_butchered_thing))
				if(butcherer && loud && !said_fail)
					said_fail = TRUE
					to_chat(butcherer, span_warning("You fail to harvest some of the [initial(rando_bits.name)] from [src]."))
			else if(prob(bonus_chance))
				if(butcherer && loud)
					to_chat(butcherer, span_info("You harvest some extra [initial(rando_bits.name)] from [src]!"))
				for(var/i in 1 to 2)
					butchered_items += new rando_bits (T)
				if(HAS_TRAIT(butcherer, TRAIT_TRAPPER))
					if(butcherer)
						to_chat(butcherer, span_info("Your advanced trapping knowledge allows you to harvest extra [initial(rando_bits.name)] from [src]!"))
					for(var/i in 1 to 2)
						butchered_items += new rando_bits (T)
			else
				butchered_items += new rando_bits (T)
		butcher_results.Remove(rando_bits) //in case you want to, say, have it drop its results on gib

	for(var/V in guaranteed_butcher_results)
		var/obj/guaranteed_bits = V
		var/amount = guaranteed_butcher_results[guaranteed_bits]
		for(var/i in 1 to amount)
			butchered_items += new guaranteed_bits (T)
		guaranteed_butcher_results.Remove(guaranteed_bits)

	for(var/butchered_item in butchered_items)
		if(isobj(butchered_item))
			var/obj/O = butchered_item
			if(isfood(O))
				var/obj/item/reagent_containers/food/butchered_meat = butchered_item
				butchered_meat.food_quality = meat_quality
			if(!O.anchored)
				O.pixel_x = rand(-14,14)
				O.pixel_y = rand(-14,14)

	if(butcherer && loud)
		visible_message(span_notice("[butcherer] butchers [src]."))
	harvest(butcherer)
	if(!gibbed)
		gib(FALSE, FALSE, TRUE)

/mob/living/simple_animal/gib()
	butcher_me(null, null, 0, 25, TRUE, FALSE)
	..()

/mob/living/simple_animal/gib_animation()
	if(icon_gib)
		new /obj/effect/temp_visual/gib_animation/animal(loc, icon_gib)

/mob/living/simple_animal/say_mod(input, message_mode)
	if(speak_emote && speak_emote.len)
		verb_say = pick(speak_emote)
	. = ..()

/mob/living/simple_animal/emote(act, m_type=1, message = null, intentional = FALSE, only_overhead)
	if(stat)
		return
	// if(act == "scream")
	// 	message = "makes a loud and pained whimper." //ugly hack to stop animals screaming when crushed :P
	// 	act = "me"
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
	if(loot_drop_amount == MOB_LOOT_ALL || !isnum(loot_drop_amount))
		if(loot_drop_amount == MOB_LOOT_ALL)
			loot_amount_random = FALSE
		loot_drop_amount = LAZYLEN(loot)
	var/list/lootlist = loot
	var/list/droppedstuff = list()
	var/list/turfs = list()
	for(var/turf/T in hearers(1, src))
		if(T.density)
			continue
		turfs |= T
	if(!LAZYLEN(turfs))
		turfs |= get_turf(src)
	for(var/i in 1 to loot_amount_random ? rand(1,loot_drop_amount) : loot_drop_amount)
		if(!LAZYLEN(lootlist))
			return
		var/dropthing = pickweight_n_take(lootlist)
		if(ispath(dropthing))
			var/turf/spawn_here = pick(turfs)
			var/atom/newthing = new dropthing(get_turf(spawn_here))
			if(istype(newthing, /obj/effect/spawner/lootdrop))
				var/obj/effect/spawner/lootdrop/lut = newthing
				if(lut.delay_spawn)
					droppedstuff |= lut.spawn_the_stuff()
				continue
			else
				droppedstuff |= newthing
	for(var/atom/thingy in droppedstuff)
		SEND_SIGNAL(thingy, COMSIG_ITEM_MOB_DROPPED, src)
	loot.Cut()

/mob/living/simple_animal/death(gibbed)
	movement_type &= ~FLYING
	unstamcrit()

	sever_link_to_nest() // killed
	LAZYREMOVE(GLOB.mob_spawners[initial(name)], src)
	if(!LAZYLEN(GLOB.mob_spawners[initial(name)]))
		GLOB.mob_spawners -= initial(name)

	if(color_dead)
		add_atom_colour(color_dead, FIXED_COLOUR_PRIORITY)
	drop_loot()
	if(dextrous)
		drop_all_held_items()
	if(!gibbed)
		if(death_sound)
			playsound(get_turf(src),death_sound, 200, ignore_walls = TRUE, vary = FALSE, frequency = SOUND_FREQ_NORMALIZED(sound_pitch, vary_pitches[1], vary_pitches[2]))
		if(deathmessage || !del_on_death)
			INVOKE_ASYNC(src,PROC_REF(emote), "deathgasp")
	if(del_on_death)
		..(gibbed)
		// if(prob(del_on_death*100))
		// 	gib()
		//Prevent infinite loops if the mob Destroy() is overridden in such
		//a manner as to cause a call to death() again
		del_on_death = FALSE
		qdel(src)
	else
		health = 0
		icon_state = icon_dead
		density = FALSE
		lying = 1
		..(gibbed)

/mob/living/simple_animal/drop_all_held_items(skip_worn = FALSE)
	if(internal_storage && !skip_worn)
		dropItemToGround(internal_storage)
	if(head && !skip_worn)
		dropItemToGround(head)
	. = ..()

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
		if(color_dead)
			remove_atom_colour(color_dead, FIXED_COLOUR_PRIORITY)
		icon = initial(icon)
		icon_state = icon_living
		density = initial(density)
		lying = FALSE
		set_resting(FALSE, silent = TRUE, updating = TRUE)//get up, stand up, don't forget your rights
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
	if(incapacitated(allow_crit = TRUE))
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

/mob/living/simple_animal/update_mobility()
	. = ..()
	if(IsUnconscious() || IsStun() || IsParalyzed() || stat || resting)
		mobility_flags = NONE
	else if(buckled || (pulledby && HAS_TRAIT(pulledby, TRAIT_STRONG_GRABBER)))
		mobility_flags = ~MOBILITY_MOVE
	else
		mobility_flags = MOBILITY_FLAGS_DEFAULT
//	update_transform()
	update_action_buttons_icon()
	return mobility_flags

/* /mob/living/simple_animal/update_transform()
	var/matrix/ntransform = matrix(transform) //aka transform.Copy()
	var/changed = 0

	if(resize != RESIZE_DEFAULT_SIZE)
		changed++
		ntransform.Scale(resize)
		resize = RESIZE_DEFAULT_SIZE

	if(changed)
		animate(src, transform = ntransform, time = 2, easing = EASE_IN|EASE_OUT) */

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
	if(HAS_TRAIT(src, TRAIT_NIGHT_VISION_GREATER))
		lighting_alpha = min(LIGHTING_PLANE_ALPHA_NV_TRAIT, lighting_alpha)
		see_in_dark = max(NIGHT_VISION_DARKSIGHT_RANGE_GREATER, see_in_dark)
	else if(HAS_TRAIT(src, TRAIT_NIGHT_VISION))
		lighting_alpha = min(LIGHTING_PLANE_ALPHA_NV_TRAIT, lighting_alpha)
		see_in_dark = max(NIGHT_VISION_DARKSIGHT_RANGE, see_in_dark)
	else
		see_in_dark = initial(see_in_dark)
		lighting_alpha = initial(lighting_alpha)
	sight = initial(sight)

	if(client.eye != src)
		var/atom/A = client.eye
		if(A.update_remote_sight(src)) //returns 1 if we override all other sight updates.
			return
	if(client?.holder)
		see_invisible = client.holder.ghostsight_or(see_invisible) //can't see ghosts through cameras
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
	if(!hand_index && held_items.len)//Divide by zero prevention
		hand_index = (active_hand_index % held_items.len)+1
	var/oindex = active_hand_index
	active_hand_index = hand_index
	if(hud_used)
		var/atom/movable/screen/inventory/hand/H
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
		if(user.incapacitated(allow_crit = TRUE))
			return
		for(var/atom/movable/A in get_turf(src))
			if(A != src && A != M && A.density)
				return
		M.forceMove(get_turf(src))
		no_ghost_gta = TRUE // so commanders cant just yoink someones bike
		return ..()

/mob/living/simple_animal/relaymove(mob/user, direction)
	var/datum/component/riding/riding_datum = GetComponent(/datum/component/riding)
	if(tame && riding_datum)
		riding_datum.handle_ride(user, direction)

/mob/living/simple_animal/buckle_mob(mob/living/buckled_mob, force = 0, check_loc = 1)
	. = ..()
	LoadComponent(/datum/component/riding)

/mob/living/simple_animal/proc/toggle_ai(togglestatus)
	if(QDELETED(src))
		return
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
	update_health_hud()

/mob/living/simple_animal/onTransitZ(old_z, new_z)
	..()
	if (AIStatus == AI_Z_OFF)
		SSidlenpcpool.idle_mobs_by_zlevel[old_z] -= src
		toggle_ai(initial(AIStatus))

/mob/living/simple_animal/Life()
	update_health_hud()
	. = ..()
	if(stat == DEAD)
		return
	if (idlesound && !(islist(idlesound) && LAZYLEN(idlesound) == 0))
		if (prob(5))
			var/chosen_sound = pick(idlesound)
			playsound(src, chosen_sound, 60, FALSE, ignore_walls = FALSE)
	adjustStaminaLoss(-stamcrit_threshold * 0.01)

/mob/living/simple_animal/update_health_hud()
	if(!client || !hud_used)
		return
	if(hud_used.healths)
		if(stat != DEAD)
			. = 1
			if(!health)
				health = health
			if(health >= maxHealth)
				hud_used.healths.icon_state = "health0"
			else if(health > maxHealth*0.95)
				hud_used.healths.icon_state = "health1"
			else if(health > maxHealth*0.9)
				hud_used.healths.icon_state = "health2"
			else if(health > maxHealth*0.85)
				hud_used.healths.icon_state = "health3"
			else if(health > maxHealth*0.80)
				hud_used.healths.icon_state = "health4"
			else if(health > maxHealth*0.75)
				hud_used.healths.icon_state = "health5"
			else if(health > maxHealth*0.70)
				hud_used.healths.icon_state = "health6"
			else if(health > maxHealth*0.65)
				hud_used.healths.icon_state = "health7"
			else if(health > maxHealth*0.60)
				hud_used.healths.icon_state = "health8"
			else if(health > maxHealth*0.55)
				hud_used.healths.icon_state = "health9"
			else if(health > maxHealth*0.50)
				hud_used.healths.icon_state = "health10"
			else if(health > maxHealth*0.45)
				hud_used.healths.icon_state = "health11"
			else if(health > maxHealth*0.40)
				hud_used.healths.icon_state = "health12"
			else if(health > maxHealth*0.35)
				hud_used.healths.icon_state = "health13"
			else if(health > maxHealth*0.30)
				hud_used.healths.icon_state = "health14"
			else if(health > maxHealth*0.25)
				hud_used.healths.icon_state = "health15"
			else if(health > maxHealth*0.20)
				hud_used.healths.icon_state = "health16"
			else if(health > maxHealth*0.15)
				hud_used.healths.icon_state = "health17"
			else if(health > maxHealth*0.10)
				hud_used.healths.icon_state = "health18"
			else if(health > maxHealth*0.05)
				hud_used.healths.icon_state = "health19"
			else if(health > 0)
				hud_used.healths.icon_state = "health19"
			else
				hud_used.healths.icon_state = "health20"
		else
			hud_used.healths.icon_state = "health21"

/mob/living/simple_animal/update_stamina()
	if(stamcrit_threshold == SIMPLEMOB_NO_STAMCRIT)
		return
	if((staminaloss + bruteloss) >= stamcrit_threshold)
		stamcrit()
	else
		unstamcrit()

/mob/living/simple_animal/proc/stamcrit()
	if(CHECK_BITFIELD(combat_flags, COMBAT_FLAG_HARD_STAMCRIT))
		return
	ENABLE_BITFIELD(combat_flags, COMBAT_FLAG_HARD_STAMCRIT)
	to_chat(src, span_notice("You're too exhausted to keep going..."))
	filters += CIT_FILTER_STAMINACRIT
	walk(src, 0)
	set_resting(TRUE, FALSE, FALSE)
	update_mobility()

/mob/living/simple_animal/proc/unstamcrit()
	if(!CHECK_BITFIELD(combat_flags, COMBAT_FLAG_HARD_STAMCRIT))
		return
	DISABLE_BITFIELD(combat_flags, COMBAT_FLAG_HARD_STAMCRIT)
	COOLDOWN_RESET(src, stamcrit_timer)
	to_chat(src, span_notice("You don't feel nearly as exhausted anymore."))
	filters -= CIT_FILTER_STAMINACRIT
	walk(src, 0)
	set_resting(FALSE, FALSE, FALSE)
	update_mobility()

/mob/living/simple_animal/fully_heal(admin_revive = FALSE)
	. = ..()
	unstamcrit()

/mob/living/simple_animal/proc/RTS_move_to_tile(targettte, delay, minimum_distance)
	end_RTS_move()
	if(!targettte)
		return
	if(!delay)
		delay = move_to_delay
	if(!minimum_distance)
		minimum_distance = 0
	set_target_coords(atom2coords(targettte))
	set_RTS_command_aggro_lockout()
	if(CHECK_BITFIELD(mobility_flags, MOBILITY_MOVE))
		set_glide_size(DELAY_TO_GLIDE_SIZE(move_to_delay))
		walk_to(src, targettte, minimum_distance, delay)
	if(AIStatus != AI_ON && AIStatus != AI_OFF)
		toggle_ai(AI_ON)

/// if you issue a command to a mob, and they are aggroed, they'll happily ignore you
/// this makes them unable to aggro for a short time after a command is issued
/mob/living/simple_animal/proc/set_RTS_command_aggro_lockout()
	RTS_aggro_lockout = world.time + SSrts.aggro_lockout_time


/// Makes mobs smash stuff!
/mob/living/simple_animal/proc/rts_smash_things(atom/towards)
	return

/// Makes mobs shoot stuff!
/mob/living/simple_animal/proc/rts_shoot(atom/towards)
	return

/// <summary>
/// This gives the mob a goal to get somewhere near, so it will evetually stop getting nearer to the target.
/// </summary>
/mob/living/simple_animal/proc/set_target_coords(coords)
	target_coords = coords

/mob/living/simple_animal/proc/clear_target_coords()
	target_coords = null

/mob/living/simple_animal/proc/am_within_range_of_target_coords()
	if(!RTS_move_ordered())
		return FALSE
	if(!target_coords)
		return end_RTS_move()
	var/atom/targetloc = coords2turf(target_coords)
	if(!targetloc)
		return end_RTS_move()
	var/distfrommetoit = get_dist(get_turf(src), targetloc)
	if(distfrommetoit <= RTS_move_target_range)
		return end_RTS_move()
	return FALSE

/mob/living/simple_animal/proc/RTS_move_ordered()
	return !isnull(target_coords)

/mob/living/simple_animal/proc/end_RTS_move()
	target_coords = null
	walk(src, 0)
	return TRUE

/mob/living/simple_animal/proc/check_frustration()
	if(!RTS_frustration_coords)
		RTS_frustration_coords = atom2coords(src)
		return
	if(world.time < RTS_last_frustration + (1 SECONDS))
		return
	RTS_last_frustration = world.time
	var/turf/whereiwas = coords2turf(RTS_frustration_coords)
	var/turf/whereiam = get_turf(src)
	if(get_dist(whereiwas, whereiam) < 2)
		frustrate()

/mob/living/simple_animal/proc/frustrate()
	RTS_frustration_seconds++
	if(RTS_frustration_seconds >= RTS_max_RTS_frustration_seconds)
		RTS_frustration_coords = null
		RTS_frustration_seconds = 0
		end_RTS_move()
		do_huh_animation(src)
		for(var/turf/T in orange(1,src))
			if(prob(50))
				do_huh_animation(T)

/mob/living/simple_animal/proc/link_to_nest(atom/birthplace)
	if(nest || !isatom(birthplace))
		return
	nest = WEAKREF(birthplace)
	nest_coords = atom2coords(birthplace)

/mob/living/simple_animal/proc/sever_link_to_nest()
	if(!nest)
		return
	var/atom/our_nest = GET_WEAKREF(nest)
	if(istype(our_nest))
		SEND_SIGNAL(our_nest, COMSIG_SPAWNER_REMOVE_MOB_FROM_NEST, src)
	nest = null

/mob/living/simple_animal/proc/setup_variations()
	if(!LAZYLEN(variation_list))
		return FALSE // we're good here
	// if(LAZYLEN(variation_list[MOB_VARIED_NAME_GLOBAL_LIST]))
	// 	vary_mob_name_from_global_lists()
	// else if(LAZYLEN(variation_list[MOB_VARIED_NAME_LIST]))
	// 	vary_mob_name_from_local_list()
	if(LAZYLEN(variation_list[MOB_VARIED_COLOR]))
		vary_mob_color()
	if(LAZYLEN(variation_list[MOB_VARIED_HEALTH]))
		var/our_health = vary_from_list(variation_list[MOB_VARIED_HEALTH])
		maxHealth = our_health
		health = our_health
	if(LAZYLEN(variation_list[MOB_VARIED_SPEED]))
		var/speedpick = pick(variation_list[MOB_VARIED_SPEED])
		set_varspeed(speedpick)
	return TRUE

/mob/living/simple_animal/proc/vary_from_list(which_list, weighted_list = FALSE)
	if(isnum(which_list))
		return which_list
	if(islist(which_list))
		if(weighted_list)
			return(pickweight(which_list))
		return(pick(which_list))

/mob/living/simple_animal/proc/vary_mob_name_from_global_lists()
	var/list/our_mob_random_name_list = variation_list[MOB_VARIED_NAME_GLOBAL_LIST]
	var/our_new_name = ""
	var/number_of_name_tokens_left = LAZYLEN(variation_list[MOB_VARIED_NAME_GLOBAL_LIST])
	for(var/name_token in our_mob_random_name_list)
		for(var/num_names in 1 to our_mob_random_name_list[name_token])
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
			if(num_names != our_mob_random_name_list[name_token])
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
	switch(rand(1,26))
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

/// AAA DUPLICATED CODE FROM OBJ.DM
/mob/living/simple_animal/proc/setup_mob_armor_values()
	if(!mob_armor)
		return
	if(!islist(mob_armor))
		return
	if(length(mob_armor_tokens) < 1)
		return // all done!
	
	for(var/list/token in mob_armor_tokens)
		for(var/modifier in token)
			switch(GLOB.armor_token_operation_legend[modifier])
				if("MULT")
					mob_armor[modifier] = round(mob_armor[modifier] * token[modifier], 1)
				if("ADD")
					mob_armor[modifier] = max(mob_armor[modifier] + token[modifier], 0)
				else
					continue

/// compiles the mob's armor description
/mob/living/simple_animal/proc/setup_mob_armor_description()
	if(!mob_armor)
		mob_armor_description = null

	var/list/descriptors = list("\n" + span_notice("You consider [src]'s resistances...") + "\n")
	///Melee
	var/melee_armor = mob_armor.getRating("melee")
	descriptors += span_notice("[p_they(TRUE)] look[p_s()] like [p_they()]")
	switch(melee_armor)
		if(-INFINITY to 20)
			descriptors += span_notice("'d bruise like a mutfruit.")
		if(20 to 40)
			descriptors += span_notice(" could take a punch, maybe two if [p_they()] had to.")
		if(40 to 60)
			descriptors += span_alert(" could take a slap from [istype(src, /mob/living/simple_animal/hostile/supermutant) ? "another" : "a"] supermutant and get right back up.")
		if(60 to 80)
			descriptors += span_alert(" could play chicken with a car and win.")
		if(80 to INFINITY)
			descriptors += span_warning(" could play pattycake with [istype(src, /mob/living/simple_animal/hostile/aethergiest) ? "another" : "a"] aethergiest and win.")
	descriptors += "\n"
	///Bullet
	var/bullet_armor = mob_armor.getRating("bullet")
	descriptors += span_notice("You feel like")
	switch(bullet_armor)
		if(-INFINITY to 20)
			descriptors += span_notice(" a bullet would smash right through [p_them()].")
		if(20 to 40)
			descriptors += span_notice(" a bullet would hurt them good, with heavy enough ammo.")
		if(40 to 60)
			descriptors += span_alert(" [p_they()] would need a lot of ammo to take down.")
		if(60 to 80)
			descriptors += span_alert(" gunfire would just annoy [p_them()].")
		if(80 to INFINITY)
			descriptors += span_warning(" you'd have better luck blowing up a tank with a BB gun.")
	descriptors += "\n"
	///Laser
	var/laser_armor = mob_armor.getRating("laser")
	descriptors += span_notice("You figure")
	switch(laser_armor)
		if(-INFINITY to 20)
			descriptors += span_notice(" a laser would slice through [p_them()] like brahminbutter.")
		if(20 to 40)
			descriptors += span_notice(" a laser would singe the everliving daylights out of [p_them()].")
		if(40 to 60)
			descriptors += span_alert(" [p_they()] would need a lot of juice to take down.")
		if(60 to 80)
			descriptors += span_alert(" laserfire would just make [p_them()] uncomfortably warm.")
		if(80 to INFINITY)
			descriptors += span_warning(" you may as well be waving a torch at [p_them()].")
	descriptors += "\n"
	///plasma
	var/plasma_armor = mob_armor.getRating("energy")
	descriptors += span_notice("You imagine that")
	switch(plasma_armor)
		if(-INFINITY to 20)
			descriptors += span_notice(" a burst of intense heat would simply burn [p_them()] to a crisp.")
		if(20 to 40)
			descriptors += span_notice(" a burst of intense heat would sear [p_them()] medium-well.")
		if(40 to 60)
			descriptors += span_alert(" [p_they()] would need a lot of agonizing plasma to put them out of their misery.")
		if(60 to 80)
			descriptors += span_alert(", for whatever reason, [p_they()] wouldn't be too bothered by intense heat.")
		if(80 to INFINITY)
			descriptors += span_warning(" this is some kind of super creature drinks plasma for breakfast.")
	descriptors += "\n"
	// ///dt
	// var/damage_threshold = mob_armor.getRating("damage_threshold")
	// switch(damage_threshold)
	// 	if(-INFINITY to 1)
	// 		descriptors += span_greenteamradio("[p_they(TRUE)] look[p_s()] like a reasonably safe opponent.")
	// 	if(2 to 4)
	// 		descriptors += span_info("[p_they(TRUE)] look[p_s()] like an even fight.")
	// 	if(5 to 6)
	// 		descriptors += span_yellowteamradio("[p_they(TRUE)] look[p_s()] like quite a gamble!")
	// 	if(7 to 9)
	// 		descriptors += span_yellowteamradio("[p_they(TRUE)] look[p_s()] like it would wipe the floor with you!")
	// 	if(9 to INFINITY)
	// 		descriptors += span_warning("What would you like your tombstone to say?")
	descriptors += "\n"
	if(LAZYLEN(descriptors))
		mob_armor_description = jointext(descriptors, "")

//Coyote Add
/mob/living/simple_animal/throw_item(atom/target)
	throw_mode_off()
	if(!target || !isturf(loc))
		return
	if(istype(target, /atom/movable/screen))
		return
	if(IS_STAMCRIT(src))
		to_chat(src, span_warning("You're too exhausted."))
		return

	var/random_turn = a_intent == INTENT_HARM
	//END OF CIT CHANGES

	var/obj/item/I = get_active_held_item()

	var/atom/movable/thrown_thing
	var/mob/living/throwable_mob

	if(istype(I, /obj/item/clothing/head/mob_holder))
		var/obj/item/clothing/head/mob_holder/holder = I
		if(holder.held_mob)
			throwable_mob = holder.held_mob
			holder.release()

	if(!I || throwable_mob)
		if(!throwable_mob && pulling && isliving(pulling) && grab_state >= GRAB_AGGRESSIVE)
			throwable_mob = pulling

		if(throwable_mob && !throwable_mob.buckled)
			thrown_thing = throwable_mob
			if(pulling)
				stop_pulling()
			if(HAS_TRAIT(src, TRAIT_PACIFISM))
				to_chat(src, span_notice("You gently let go of [throwable_mob]."))
				return

			adjustStaminaLossBuffered(STAM_COST_THROW_MOB * ((throwable_mob.mob_size+1)**2))// throwing an entire person shall be very tiring
			var/turf/start_T = get_turf(loc) //Get the start and target tile for the descriptors
			var/turf/end_T = get_turf(target)
			if(start_T && end_T)
				log_combat(src, throwable_mob, "thrown", addition="grab from tile in [AREACOORD(start_T)] towards tile at [AREACOORD(end_T)]")

	else if(!CHECK_BITFIELD(I.item_flags, ABSTRACT) && !HAS_TRAIT(I, TRAIT_NODROP))
		thrown_thing = I
		dropItemToGround(I)

		if(HAS_TRAIT(src, TRAIT_PACIFISM) && I.throwforce)
			to_chat(src, span_notice("You set [I] down gently on the ground."))
			return

		adjustStaminaLossBuffered(I.getweight(src, STAM_COST_THROW_MULT, SKILL_THROW_STAM_COST))

	if(thrown_thing)
		var/power_throw = 0
		if(HAS_TRAIT(src, TRAIT_HULK))
			power_throw++
		if(pulling && grab_state >= GRAB_NECK)
			power_throw++
		visible_message(span_danger("[src] throws [thrown_thing][power_throw ? " really hard!" : "."]"), \
						span_danger("You throw [thrown_thing][power_throw ? " really hard!" : "."]"))
		log_message("has thrown [thrown_thing] [power_throw ? "really hard" : ""]", LOG_ATTACK)
		do_attack_animation(target, no_effect = 1)
		playsound(loc, 'sound/weapons/punchmiss.ogg', 50, 1, -1)
		newtonian_move(get_dir(target, src))
		thrown_thing.safe_throw_at(target, thrown_thing.throw_range, thrown_thing.throw_speed + power_throw, src, null, null, null, move_force, random_turn)

/mob/living/simple_animal/proc/toggle_throw_mode()
	if(stat)
		return
	if(in_throw_mode)
		throw_mode_off()
	else
		throw_mode_on()

/mob/living/simple_animal/proc/throw_mode_off()
	in_throw_mode = 0
	if(client && hud_used)
		hud_used.throw_icon.icon_state = "act_throw_off"

/mob/living/simple_animal/proc/throw_mode_on()
	in_throw_mode = 1
	if(client && hud_used)
		hud_used.throw_icon.icon_state = "act_throw_on"
//End Coyote Add
