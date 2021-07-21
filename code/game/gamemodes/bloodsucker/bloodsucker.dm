/obj/item/claymore/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 40, 105)
	AddElement(/datum/element/sword_point)

/obj/item/claymore/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is falling on [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return(BRUTELOSS)


/obj/item/claymore/highlander //ALL COMMENTS MADE REGARDING THIS SWORD MUST BE MADE IN ALL CAPS
	desc = "<b><i>THERE CAN BE ONLY ONE, AND IT WILL BE YOU!!!</i></b>\nActivate it in your hand to point to the nearest victim."
	flags_1 = CONDUCT_1
	item_flags = DROPDEL
	slot_flags = null
	block_chance = 0 //RNG WON'T HELP YOU NOW, PANSY
	light_system = MOVABLE_LIGHT
	light_range = 3
	attack_verb = list("brutalized", "eviscerated", "disemboweled", "hacked", "carved", "cleaved") //ONLY THE MOST VISCERAL ATTACK VERBS
	var/notches = 0 //HOW MANY PEOPLE HAVE BEEN SLAIN WITH THIS BLADE
	var/obj/item/disk/nuclear/nuke_disk //OUR STORED NUKE DISK

/obj/item/claymore/highlander/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HIGHLANDER)
	START_PROCESSING(SSobj, src)

/obj/item/claymore/highlander/Destroy()
	if(nuke_disk)
		nuke_disk.forceMove(get_turf(src))
		nuke_disk.visible_message("<span class='warning'>The nuke disk is vulnerable!</span>")
		nuke_disk = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/claymore/highlander/process()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		loc.layer = LARGE_MOB_LAYER //NO HIDING BEHIND PLANTS FOR YOU, DICKWEED (HA GET IT, BECAUSE WEEDS ARE PLANTS)
		H.bleedsuppress = TRUE //AND WE WON'T BLEED OUT LIKE COWARDS
		H.adjustStaminaLoss(-50) //CIT CHANGE - AND MAY HE NEVER SUCCUMB TO EXHAUSTION
	else
		if(!(flags_1 & ADMIN_SPAWNED_1))
			qdel(src)


/obj/item/claymore/highlander/pickup(mob/living/user)
	. = ..()
	to_chat(user, "<span class='notice'>The power of Scotland protects you! You are shielded from all stuns and knockdowns.</span>")
	user.add_stun_absorption("highlander", INFINITY, 1, " is protected by the power of Scotland!", "The power of Scotland absorbs the stun!", " is protected by the power of Scotland!")
	user.ignore_slowdown(HIGHLANDER)

/obj/item/claymore/highlander/dropped(mob/living/user)
	. = ..()
	user.unignore_slowdown(HIGHLANDER)
	if(!QDELETED(src))
		qdel(src) //If this ever happens, it's because you lost an arm

/obj/item/claymore/highlander/examine(mob/user)
	. = ..()
	. += "It has [!notches ? "nothing" : "[notches] notches"] scratched into the blade."
	if(nuke_disk)
		. += "<span class='boldwarning'>It's holding the nuke disk!</span>"

/obj/item/claymore/highlander/attack(mob/living/target, mob/living/user)
	. = ..()
	if(!QDELETED(target) && iscarbon(target) && target.stat == DEAD && target.mind && target.mind.special_role == "highlander")
		user.fully_heal() //STEAL THE LIFE OF OUR FALLEN FOES
		add_notch(user)
		target.visible_message("<span class='warning'>[target] crumbles to dust beneath [user]'s blows!</span>", "<span class='userdanger'>As you fall, your body crumbles to dust!</span>")
		target.dust()

/obj/item/claymore/highlander/attack_self(mob/living/user)
	var/closest_victim
	var/closest_distance = 255
	for(var/mob/living/carbon/human/H in GLOB.player_list - user)
		if(H.client && H.mind.special_role == "highlander" && (!closest_victim || get_dist(user, closest_victim) < closest_distance))
			closest_victim = H
	if(!closest_victim)
		to_chat(user, "<span class='warning'>[src] thrums for a moment and falls dark. Perhaps there's nobody nearby.</span>")
		return
	to_chat(user, "<span class='danger'>[src] thrums and points to the [dir2text(get_dir(user, closest_victim))].</span>")

/obj/item/claymore/highlander/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if((attack_type & ATTACK_TYPE_PROJECTILE) && is_energy_reflectable_projectile(object))
		return BLOCK_SUCCESS | BLOCK_SHOULD_REDIRECT | BLOCK_PHYSICAL_EXTERNAL | BLOCK_REDIRECTED
	return ..()

/obj/item/claymore/highlander/proc/add_notch(mob/living/user) //DYNAMIC CLAYMORE PROGRESSION SYSTEM - THIS IS THE FUTURE
	notches++
	force++
	var/new_name = name
	switch(notches)
		if(1)
			to_chat(user, "<span class='notice'>Your first kill - hopefully one of many. You scratch a notch into [src]'s blade.</span>")
			to_chat(user, "<span class='warning'>You feel your fallen foe's soul entering your blade, restoring your wounds!</span>")
			new_name = "notched claymore"
		if(2)
			to_chat(user, "<span class='notice'>Another falls before you. Another soul fuses with your own. Another notch in the blade.</span>")
			new_name = "double-notched claymore"
			add_atom_colour(rgb(255, 235, 235), ADMIN_COLOUR_PRIORITY)
		if(3)
			to_chat(user, "<span class='notice'>You're beginning to</span> <span class='danger'><b>relish</b> the <b>thrill</b> of <b>battle.</b></span>")
			new_name = "triple-notched claymore"
			add_atom_colour(rgb(255, 215, 215), ADMIN_COLOUR_PRIORITY)
		if(4)
			to_chat(user, "<span class='notice'>You've lost count of</span> <span class='boldannounce'>how many you've killed.</span>")
			new_name = "many-notched claymore"
			add_atom_colour(rgb(255, 195, 195), ADMIN_COLOUR_PRIORITY)
		if(5)
			to_chat(user, "<span class='boldannounce'>Five voices now echo in your mind, cheering the slaughter.</span>")
			new_name = "battle-tested claymore"
			add_atom_colour(rgb(255, 175, 175), ADMIN_COLOUR_PRIORITY)
		if(6)
			to_chat(user, "<span class='boldannounce'>Is this what the vikings felt like? Visions of glory fill your head as you slay your sixth foe.</span>")
			new_name = "battle-scarred claymore"
			add_atom_colour(rgb(255, 155, 155), ADMIN_COLOUR_PRIORITY)
		if(7)
			to_chat(user, "<span class='boldannounce'>Kill. Butcher. <i>Conquer.</i></span>")
			new_name = "vicious claymore"
			add_atom_colour(rgb(255, 135, 135), ADMIN_COLOUR_PRIORITY)
		if(8)
			to_chat(user, "<span class='userdanger'>IT NEVER GETS OLD. THE <i>SCREAMING</i>. THE <i>BLOOD</i> AS IT <i>SPRAYS</i> ACROSS YOUR <i>FACE.</i></span>")
			new_name = "bloodthirsty claymore"
			add_atom_colour(rgb(255, 115, 115), ADMIN_COLOUR_PRIORITY)
		if(9)
			to_chat(user, "<span class='userdanger'>ANOTHER ONE FALLS TO YOUR BLOWS. ANOTHER WEAKLING UNFIT TO LIVE.</span>")
			new_name = "gore-stained claymore"
			add_atom_colour(rgb(255, 95, 95), ADMIN_COLOUR_PRIORITY)
		if(10)
			user.visible_message("<span class='warning'>[user]'s eyes light up with a vengeful fire!</span>", \
			"<span class='userdanger'>YOU FEEL THE POWER OF VALHALLA FLOWING THROUGH YOU! <i>THERE CAN BE ONLY ONE!!!</i></span>")
			user.update_icons()
			new_name = "GORE-DRENCHED CLAYMORE OF [pick("THE WHIMSICAL SLAUGHTER", "A THOUSAND SLAUGHTERED CATTLE", "GLORY AND VALHALLA", "ANNIHILATION", "OBLITERATION")]"
			icon_state = "claymore_valhalla"
			item_state = "cultblade"
			remove_atom_colour(ADMIN_COLOUR_PRIORITY)

	name = new_name
	playsound(user, 'sound/items/screwdriver2.ogg', 50, 1)



/datum/game_mode
	var/list/datum/mind/bloodsuckers = list() 		// List of minds belonging to this game mode.
	var/list/datum/mind/vassals = list() 			// List of minds that have been turned into Vassals.
	//var/list/datum/mind/vamphunters = list() 		// List of minds hunting vampires. Disabled at the moment
	var/obj/effect/sunlight/bloodsucker_sunlight	// Sunlight Timer. Created on first Bloodsucker assign. Destroyed on last removed Bloodsucker.

	// LISTS //
	var/list/vassal_allowed_antags = list(/datum/antagonist/brother, /datum/antagonist/traitor, /datum/antagonist/traitor/internal_affairs, /datum/antagonist/survivalist, \
										  /datum/antagonist/rev, /datum/antagonist/nukeop, /datum/antagonist/pirate, /datum/antagonist/cult, /datum/antagonist/abductee, /datum/antagonist/valentine, /datum/antagonist/heartbreaker,)
	// The antags you're allowed to be if turning Vassal.

/proc/AmBloodsucker(mob/living/M, falseIfInDisguise = FALSE)
	if(!M.mind)
		return FALSE
	// No Datum
	if(!M.mind.has_antag_datum(ANTAG_DATUM_BLOODSUCKER))
		return FALSE
	return TRUE

/datum/game_mode/bloodsucker
	name = "bloodsucker"
	config_tag = "bloodsucker"
	traitor_name = "Bloodsucker"
	antag_flag = ROLE_BLOODSUCKER
	false_report_weight = 1
	restricted_jobs = list("AI","Cyborg")
	protected_jobs = list("Chaplain", "Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Chief Medical Officer", "Research Director", "Quartermaster")
	required_players = 20
	required_enemies = 2
	recommended_enemies = 4
	reroll_friendly = FALSE
	enemy_minimum_age = 7
	round_ends_with_antag_death = FALSE


	announce_span = "danger"
	announce_text = "Filthy, bloodsucking vampires are crawling around disguised as crewmembers!\n\
	<span class='danger'>Bloodsuckers</span>: The crew are cattle, while you are both shepherd and slaughterhouse.\n\
	<span class='notice'>Crew</span>: Put an end to the undead infestation before the station is overcome!"

/datum/game_mode/bloodsucker/generate_report()
	return "Reports indicate that some of your crew may have toppled statues in the past week, angering the gods and becoming cursed with undeath and a desire for blood. Watch out for crewmembers that seem to shun the light or are found pale and delirious."

// Seems to be run by game ONCE, and finds all potential players to be antag.
/datum/game_mode/bloodsucker/pre_setup()

	// Set Restricted Jobs
	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		restricted_jobs += protected_jobs

	if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		restricted_jobs += "Assistant"

	// Set number of Vamps
	recommended_enemies = clamp(round(num_players()/10), 1, 6);

	// Select Antags
	for(var/i = 0, i < recommended_enemies, i++)
		if (!antag_candidates.len)
			break
		var/datum/mind/bloodsucker = pick(antag_candidates)
		// Can we even BE a bloodsucker?
		//if (can_make_bloodsucker(bloodsucker, display_warning=FALSE))
		bloodsuckers += bloodsucker
		bloodsucker.restricted_roles = restricted_jobs
		log_game("[bloodsucker.key] (ckey) has been selected as a Bloodsucker.")
		antag_candidates.Remove(bloodsucker) // Apparently you can also write antag_candidates -= bloodsucker

	//  Assign Hunters (as many as monsters, plus one)
	//assign_monster_hunters(bloodsuckers.len, TRUE, bloodsuckers)	// Disabled for now

	// Do we have enough vamps to continue?
	return bloodsuckers.len >= required_enemies


// Gamemode is all done being set up. We have all our Vamps. We now pick objectives and let them know what's happening.
/datum/game_mode/bloodsucker/post_setup()
	// Sunlight (Creating Bloodsuckers manually will check to create this, too)
	check_start_sunlight()
	// Vamps
	for(var/datum/mind/bloodsucker in bloodsuckers)
		if(!make_bloodsucker(bloodsucker))
			bloodsuckers -= bloodsucker
	return ..()

// Init Sunlight (called from datum_bloodsucker.on_gain(), in case game mode isn't even Bloodsucker
/datum/game_mode/proc/check_start_sunlight()
	// Already Sunlight (and not about to cancel)
	if(istype(bloodsucker_sunlight) && !bloodsucker_sunlight.cancel_me)
		return
	bloodsucker_sunlight = new ()

// End Sun (last bloodsucker removed)
/datum/game_mode/proc/check_cancel_sunlight()
	// No Sunlight
	if(!istype(bloodsucker_sunlight))
		return
	if(bloodsuckers.len <= 0)
		bloodsucker_sunlight.cancel_me = TRUE
		qdel(bloodsucker_sunlight)
		bloodsucker_sunlight = null

/datum/game_mode/proc/is_daylight()
	return istype(bloodsucker_sunlight) && bloodsucker_sunlight.amDay

//////////////////////////////////////////////////////////////////////////////


/datum/game_mode/proc/can_make_bloodsucker(datum/mind/bloodsucker, datum/mind/creator, display_warning=TRUE) // Creator is just here so we can display fail messages to whoever is turning us.
	// No Mind
	if(!bloodsucker || !bloodsucker.key) // KEY is client login?
		//if(creator) // REMOVED. You wouldn't see their name if there is no mind, so why say anything?
		//	to_chat(creator, "<span class='danger'>[bloodsucker] isn't self-aware enough to be raised as a Bloodsucker!</span>")
		return FALSE
	// Current body is invalid
	if(!ishuman(bloodsucker.current))// && !ismonkey(bloodsucker.current))
		if(display_warning && creator)
			to_chat(creator, "<span class='danger'>[bloodsucker] isn't evolved enough to be raised as a Bloodsucker!</span>")
		return FALSE
	// Species Must have a HEART (Sorry Plasmabois)
	var/mob/living/carbon/human/H = bloodsucker.current
	if(NOBLOOD in H.dna.species.species_traits)
		if(display_warning && creator)
			to_chat(creator, "<span class='danger'>[bloodsucker]'s DNA isn't compatible!</span>")
		return FALSE
	// Already a Non-Human Antag
	if(bloodsucker.has_antag_datum(/datum/antagonist/abductor) || bloodsucker.has_antag_datum(/datum/antagonist/devil) || bloodsucker.has_antag_datum(/datum/antagonist/changeling))
		return FALSE
	// Already a vamp
	if(bloodsucker.has_antag_datum(ANTAG_DATUM_BLOODSUCKER))
		if(display_warning && creator)
			to_chat(creator, "<span class='danger'>[bloodsucker] is already a Bloodsucker!</span>")
		return FALSE
	// Not High Enough
	if(creator)
		var/datum/antagonist/bloodsucker/creator_bloodsucker = creator.has_antag_datum(ANTAG_DATUM_BLOODSUCKER)
		if(!istype(creator_bloodsucker) || creator_bloodsucker.bloodsucker_level < BLOODSUCKER_LEVEL_TO_EMBRACE)
			to_chat(creator, "<span class='danger'>Your blood is too thin to turn this corpse!</span>")
			return FALSE
	return TRUE


/datum/game_mode/proc/make_bloodsucker(datum/mind/bloodsucker, datum/mind/creator = null) // NOTE: This is a game_mode/proc, NOT a game_mode/bloodsucker/proc! We need to access this function despite the game mode.
	if(!can_make_bloodsucker(bloodsucker))
		return FALSE
	// Create Datum: Fledgling
	var/datum/antagonist/bloodsucker/A

	// [FLEDGLING]
	if(creator)
		A = new (bloodsucker)
		A.creator = creator
		bloodsucker.add_antag_datum(A)
		// Log
		message_admins("[bloodsucker] has become a Bloodsucker, and was created by [creator].")
		log_admin("[bloodsucker] has become a Bloodsucker, and was created by [creator].")
	// [MASTER]
	else
		A = bloodsucker.add_antag_datum(ANTAG_DATUM_BLOODSUCKER)
	return TRUE

/datum/game_mode/proc/remove_bloodsucker(datum/mind/bloodsucker)
	bloodsucker.remove_antag_datum(ANTAG_DATUM_BLOODSUCKER)

/datum/game_mode/proc/clean_invalid_species(datum/mind/bloodsucker)
	// Only checking for Humans here
	if(!ishuman(bloodsucker.current) || !bloodsucker.current.client)
		return
	var/am_valid = TRUE
	var/mob/living/carbon/human/H = bloodsucker.current

	// Check if PLASMAMAN?
	if(NOBLOOD in H.dna.species.species_traits)
		am_valid = FALSE

	// PROBLEM:
	//
	// Setting species leaves clothes on. If you were a plasmaman, we need to reassign your entire outfit. Otherwise
	// everyone will wonder why you're a human with Plasma clothes (jk they'll know you're antag)

	// Convert to HUMAN (along with ID and PDA)
	if(!am_valid)
		H.set_species(/datum/species/human)
		H.real_name = H.client.prefs.custom_names["human"]
		var/obj/item/card/id/ID = H.wear_id?.GetID()
		if(ID)
			ID.registered_name = H.real_name
			ID.update_label()


/datum/game_mode/proc/can_make_vassal(mob/living/target, datum/mind/creator, display_warning = TRUE)//, check_antag_or_loyal=FALSE)
	// Not Correct Type: Abort
	if(!iscarbon(target) || !creator)
		return FALSE
	if(target.stat > UNCONSCIOUS)
		return FALSE

				// Check Overdose: Am I even addicted to blood? Do I even have any in me?
				//if (!target.reagents.addiction_list || !target.reagents.reagent_list)
					//message_admins("DEBUG2: can_make_vassal() Abort: No reagents")
				//	return 0
				// Check Overdose: Did my current volume go over the Overdose threshold?
				//var/am_addicted = 0
				//for (var/datum/reagent/blood/vampblood/blood in target.reagents.addiction_list) // overdosed is tracked in reagent_list, not addiction_list.
					//message_admins("DEBUG3: can_make_vassal() Found Blood! [blood] [blood.overdose]")
					//if (blood.overdosed)
				//	am_addicted = 1 // Blood is present in addiction? That's all we need.
				//	break

				//if (!am_addicted)
					//message_admins("DEBUG4: can_make_vassal() Abort: No Blood")
				//	return 0
	// No Mind!
	if(!target.mind || !target.mind.key)
		if(display_warning)
			to_chat(creator, "<span class='danger'>[target] isn't self-aware enough to be made into a Vassal.</span>")
		return FALSE
	// Already MY Vassal
	var/datum/antagonist/vassal/V = target.mind.has_antag_datum(ANTAG_DATUM_VASSAL)
	if(istype(V) && V.master)
		if(V.master.owner == creator)
			if(display_warning)
				to_chat(creator, "<span class='danger'>[target] is already your loyal Vassal!</span>")
		else
			if(display_warning)
				to_chat(creator, "<span class='danger'>[target] is the loyal Vassal of another Bloodsucker!</span>")
		return FALSE
	// Already Antag or Loyal (Vamp Hunters count as antags)
	if(target.mind.enslaved_to || AmInvalidAntag(target.mind)) //!VassalCheckAntagValid(target.mind, check_antag_or_loyal)) // HAS_TRAIT(target, TRAIT_MINDSHIELD, "implant") ||
		if(display_warning)
			to_chat(creator, "<span class='danger'>[target] resists the power of your blood to dominate their mind!</span>")
		return FALSE
	return TRUE


/datum/game_mode/proc/AmValidAntag(datum/mind/M)
	// No List?
	if(!islist(M.antag_datums) || M.antag_datums.len == 0)
		return FALSE
	// Am I NOT an invalid Antag?    NOTE: We already excluded non-antags above. Don't worry about the "No List?" check in AmInvalidIntag()
	return !AmInvalidAntag(M)

/datum/game_mode/proc/AmInvalidAntag(datum/mind/M)
	// No List?
	if(!islist(M.antag_datums) || M.antag_datums.len == 0)
		return FALSE
	// Does even ONE antag appear in this mind that isn't in the list? Then FAIL!
	for(var/datum/antagonist/antag_datum in M.antag_datums)
		if(!(antag_datum.type in vassal_allowed_antags))  // vassal_allowed_antags is a list stored in the game mode, above.
			//message_admins("DEBUG VASSAL: Found Invalid: [antag_datum] // [antag_datum.type]")
			return TRUE
	//message_admins("DEBUG VASSAL: Valid Antags! (total of [M.antag_datums.len])")
	// WHEN YOU DELETE THE ABOVE: Remove the 3 second timer on converting the vassal too.
	return FALSE

/datum/game_mode/proc/make_vassal(mob/living/target, datum/mind/creator)
	if(!can_make_vassal(target, creator))
		return FALSE
	// Make Vassal
	var/datum/antagonist/vassal/V = new(target.mind)
	var/datum/antagonist/bloodsucker/B = creator.has_antag_datum(ANTAG_DATUM_BLOODSUCKER)
	V.master = B
	target.mind.add_antag_datum(V, V.master.get_team())
	// Update Bloodsucker Title (we're a daddy now)
	B.SelectTitle(am_fledgling = FALSE) // Only works if you have no title yet.
	// Log it
	message_admins("[target] has become a Vassal, and is enslaved to [creator].")
	log_admin("[target] has become a Vassal, and is enslaved to [creator].")
	return TRUE

/datum/game_mode/proc/remove_vassal(datum/mind/vassal)
	vassal.remove_antag_datum(ANTAG_DATUM_VASSAL)
