#define ASKER_ASKED 1 // the index of who asked who in the exploded list
#define ASKED_ASKER 2

SUBSYSTEM_DEF(interactions)
	name = "Interactions"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_INTERACTIONS
	var/list/interactions = list()
	var/list/all_categories = list()
	/// format: list("ckey1!ckey2" = ASKER_ASKED, "ckey2!ckey1" = ASKED_ASKER)
	var/list/consents = list()
	var/list/deliberating_consent = list()
	var/list/splorch_cd = 7 SECONDS // the 7 is for good luck
	var/list/squorch_cooldowns = list()
	var/list/guosh_cd = 1 SECONDS // the 7 is for good luck
	var/list/guorch_cooldowns = list()
	var/list/interactions_tgui = list()
	var/min_autoplap_interval = 3 SECONDS
	var/max_autoplap_interval = 15 SECONDS
	var/debug_store_plapper_weakref = FALSE

	VAR_PROTECTED/list/blacklisted_mobs = list(
		/mob/dead,
	)
	VAR_PROTECTED/initialized_blacklist


/datum/controller/subsystem/interactions/Initialize(timeofday)
	prepare_interactions()
	prepare_blacklisted_mobs()
	return ..()

/// Makes the interactions, they're also a global list because having it as a list and just hanging around there is stupid
/datum/controller/subsystem/interactions/proc/prepare_interactions()
	QDEL_NULL_LIST(interactions)
	interactions = list()
	for(var/itype in subtypesof(/datum/interaction))
		var/datum/interaction/I = itype
		if(initial(I.description) == "PLSNOINIT")
			continue
		I = new itype()
		interactions["[itype]"] = I
		all_categories |= I.categories
		interactions_tgui += list(I.format_for_tgui())

/// Blacklisting!
/datum/controller/subsystem/interactions/proc/prepare_blacklisted_mobs()
	blacklisted_mobs = typecacheof(blacklisted_mobs)
	initialized_blacklist = TRUE

/// consenting! add or remove consent!
/datum/controller/subsystem/interactions/proc/add_or_remove_consent(mob/asker, mob/asked)
	if(!asker || !asked)
		return FALSE
	var/keyname = keyify(asker, asked)
	if(!keyname)
		return
	if(LAZYACCESS(consents, keyname))
		request_remove_consent(asker, asked)
	else
		request_consent(asker, asked)

/// consenting! make a key
/datum/controller/subsystem/interactions/proc/keyify(mob/player1, mob/player2)
	if(!player1 || !player2)
		return FALSE
	var/key1 = extract_ckey(player1)
	var/key2 = extract_ckey(player2)
	if(!key1 || !key2)
		return FALSE
	if(sorttext(key1, key2))
		return "[key1]![key2]"
	else
		return "[key2]![key1]"

/// consenting! check if consenting
/datum/controller/subsystem/interactions/proc/check_consent(mob/player1, mob/player2)
	if(!player1 || !player2)
		return FALSE
	if(player1 == player2)
		return TRUE // you consent to yourself~
	var/keyname = keyify(player1, player2)
	if(!keyname)
		return FALSE
	return !!(LAZYACCESS(consents, keyname))

/// consenting! check if consenting
/datum/controller/subsystem/interactions/proc/who_asked_who(keyname)
	var/who_asked_who = LAZYACCESS(consents, keyname)
	var/list/whowho = splittext(keyname, "!")
	if(LAZYLEN(whowho) != 2)
		return "Ronnie Runtimes"
	if(who_asked_who == ASKER_ASKED)
		return whowho[1]
	else
		return whowho[2]

/// consenting! request consent
/datum/controller/subsystem/interactions/proc/request_consent(mob/requesting, mob/target)
	if(!requesting || !target)
		return FALSE
	if(!requesting.ckey || !target.ckey)
		return FALSE
	if(target.ckey in deliberating_consent)
		to_chat(requesting, span_alert("Hold on! [target] is still deciding something!"))
		return FALSE
	var/keyname = keyify(requesting, target)
	if(LAZYACCESS(consents, keyname))
		return
	deliberating_consent |= target.ckey
	var/consent_choice = alert(
		target,
		"Hey! [requesting] wants to engage in mechanical erotic roleplay adventures with you! Is this alright?",
		"Somebody likes you!",
		"Yes!",
		"No!",
		"No, and call an admin!",
	)
	deliberating_consent -= target.ckey
	switch(consent_choice)
		if("Yes!")
			add_consent(requesting, target)
			return
		if("No!")
			decline_consent(requesting, target)
			return
		if("No, and call an admin!")
			decline_consent(requesting, target, TRUE)
			return

/// consenting! add consent
/datum/controller/subsystem/interactions/proc/add_consent(mob/requesting, mob/target)
	if(!requesting || !target)
		return FALSE
	if(!requesting.ckey || !target.ckey)
		return FALSE
	var/keyname = keyify(requesting, target)
	var/list/whowho = splittext(keyname, "!")
	if(LAZYLEN(whowho) != 2)
		return FALSE
	if(LAZYACCESS(whowho, 1) == requesting.ckey)
		consents[keyname] = ASKER_ASKED
	else
		consents[keyname] = ASKED_ASKER
	if(target)
		to_chat(target, span_greentext("You have given [requesting] consent to do lewd things with you!"))
	if(requesting)
		to_chat(requesting, span_greentext("[target] has given you consent to do lewd things with them!"))

/// consenting! target declined consent
/datum/controller/subsystem/interactions/proc/decline_consent(mob/decliner, mob/denied, ahelp)
	if(!decliner || !denied)
		return FALSE

	to_chat(denied, span_userdanger("[decliner] has declined your request to do lewd things with them!"))
	to_chat(decliner, span_userdanger("You have declined [denied]'s request to do lewd things with you!"))
	log_ooc("[key_name_admin(decliner)] has declined [key_name_admin(denied)]'s request to do lewd things with them!")
	if(!ahelp)
		return
	log_ooc("[key_name_admin(decliner)] has also requested an admin regarding [key_name_admin(denied)]'s request to do lewd things with them!")
	to_chat(decliner, span_userdanger("An admin will be with you shortly!!!"))
	message_admins(span_userdanger("[ADMIN_TPMONTY(decliner)] has declined [ADMIN_TPMONTY(denied)]'s request to do lewd things with them, and is calling for an admin!!"))
	for(var/client/C in GLOB.admins)
		SEND_SOUND(C, sound('sound/effects/meow1.ogg')) // Someow's in troubmeow!
		SEND_SOUND(C, sound('sound/effects/adminhelp.ogg')) // Someow's in troubmeow!
		SEND_SOUND(C, sound('sound/effects/-adminhelp.ogg')) // Someow's in troubmeow!

/// consenting! ask to remove consent
/datum/controller/subsystem/interactions/proc/request_remove_consent(mob/requesting, mob/target)
	if(!requesting || !target)
		return FALSE
	if(!requesting.ckey || !target.ckey)
		return FALSE
	if(requesting.ckey in deliberating_consent)
		to_chat(requesting, span_alert("Hold on! You're still deciding something!"))
		return FALSE
	var/keyname = keyify(requesting, target)
	if(!LAZYACCESS(consents, keyname))
		return FALSE
	deliberating_consent |= requesting.ckey
	var/consent_choice = alert(
		requesting,
		"Hey! Want to remove consent for [target] to do lewd things with you?",
		"No means no!",
		"No!",
		"Yes!",
		"Yes, and call an admin!",
	)
	deliberating_consent -= target.ckey
	switch(consent_choice)
		if("Yes!")
			remove_consent(requesting, target)
			return
		if("No!")
			to_chat(requesting, span_notice("Never mind!"))
			return
		if("Yes, and call an admin!")
			remove_consent(requesting, target, TRUE)
			return

/// consenting! attempting to remove consent
/datum/controller/subsystem/interactions/proc/remove_consent(mob/revoker, mob/revoked, ahelp)
	if(!revoker || !revoked)
		return FALSE
	var/keyname = keyify(revoker.ckey, revoked.ckey)
	if(!LAZYACCESS(consents, keyname))
		return FALSE
	
	var/original_approver = who_asked_who(keyname)
	consents -= keyname
	to_chat(revoked, span_userdanger("[revoker] has revoked consent for you to do lewd things with them!"))
	to_chat(revoker, span_userdanger("You have revoked consent from [revoked] to do lewd things with you!"))
	log_ooc("[key_name_admin(revoker)] has revoked [key_name_admin(revoked)]'s consent to do lewd things with them! (Original approver: [key_name_admin(original_approver)])")
	if(ahelp)
		log_ooc("[key_name_admin(revoker)] has also requested an admin regarding [key_name_admin(revoked)]'s consent to do lewd things with them!")
		to_chat(revoker, span_userdanger("An admin will be with you shortly!!!"))
		message_admins(span_userdanger("[ADMIN_TPMONTY(revoker)] has revoked [ADMIN_TPMONTY(revoked)]'s consent to do lewd things with them, and is calling for an admin!! (Original approver: [original_approver])"))
		for(var/client/C in GLOB.admins)
			SEND_SOUND(C, sound('sound/effects/meow1.ogg')) // Someow's in troubmeow!
			SEND_SOUND(C, sound('sound/effects/adminhelp.ogg')) // Someow's in troubmeow!
			SEND_SOUND(C, sound('sound/effects/-adminhelp.ogg')) // Someow's in troubmeow!


/*
 * Lewd interactions have a blacklist for certain mobs. When we evalute the user and target, both of
 * their requirements must be satisfied, and the mob must not be of a blacklisted type.
*/
/datum/controller/subsystem/interactions/proc/is_blacklisted(mob/living/creature)
	if(!creature || !initialized_blacklist)
		return TRUE
	if(is_type_in_typecache(creature, blacklisted_mobs))
		return TRUE

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * A cooldown for squorching, so you can't just spam it.
 * Only applies if the squorch has a sound associated with it, otherwise you get to see every lovely message
 */
/datum/controller/subsystem/interactions/proc/can_squorch_message(mob/living/squisher, datum/interaction/splut, do_cooldown = TRUE)
	if(!istype(squisher) || !squisher.ckey || !istype(splut))
		return FALSE
	if(!LAZYLEN(splut.help_sounds))
		return TRUE // You really need to know 
	if(!LAZYACCESS(squorch_cooldowns, squisher.ckey))
		set_cooldown_for_squorch(squisher)
		return TRUE // SQUISHERS ARE REALLY COOL
	if(world.time > LAZYACCESS(squorch_cooldowns, squisher.ckey))
		if(do_cooldown)
			set_cooldown_for_squorch(squisher)
		return TRUE // SQUISHERS ARE SO MUCH FUN
	return FALSE // SLIMY GOOEY ANIMALS GIRAFFES AND WOLVES AND SO MUCH MORE
	
/datum/controller/subsystem/interactions/proc/set_cooldown_for_squorch(mob/living/squisher)
	if(!istype(squisher) || !squisher.ckey)
		return FALSE
	LAZYSET(squorch_cooldowns, squisher.ckey, world.time + splorch_cd)
	return TRUE

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * A cooldown for guoshing, so you can't just spam it.
 */
/datum/controller/subsystem/interactions/proc/can_squorch_sound(mob/living/squisher, datum/interaction/splut, do_cooldown = TRUE)
	return TRUE // yeah you cant spam it turns out
	// if(!istype(squisher) || !squisher.ckey || !istype(splut))
	// 	return FALSE
	// if(!LAZYLEN(splut.help_sounds))
	// 	return FALSE // not that it matters
	// if(!LAZYACCESS(guorch_cooldowns, squisher.ckey))
	// 	set_cooldown_for_guorch(squisher)
	// 	return TRUE // SQUISHERS ARE REALLY COOL
	// if(world.time > LAZYACCESS(guorch_cooldowns, squisher.ckey))
	// 	if(do_cooldown)
	// 		set_cooldown_for_guorch(squisher)
	// 	return TRUE // SQUISHERS ARE SO MUCH FUN
	// return FALSE // SLIMY GOOEY ANIMALS GIRAFFES AND WOLVES AND SO MUCH MORE
	
/datum/controller/subsystem/interactions/proc/set_cooldown_for_guorch(mob/living/squisher)
	if(!istype(squisher) || !squisher.ckey)
		return FALSE
	LAZYSET(guorch_cooldowns, squisher.ckey, world.time + guosh_cd)
	return TRUE

/// gets everyone who creature consents to, and everyone who they consent to, and so on
/// A consents to B, B consents to C, D consents to A, B consents to E, E consents to F
/// would return A, B, C, D, E, F
/datum/controller/subsystem/interactions/proc/get_consent_chain(mob/living/creature, mobs_pls = TRUE)
	if(!istype(creature) || !creature.ckey)
		return FALSE
	var/list/keys_to_check = list(creature.ckey)
	var/list/consent_chain = list() // also is the keys we checked, so we dont check em again
	/// runs through the the master consent list
	while(LAZYLEN(keys_to_check))
		var/key_to_check = keys_to_check[1]
		keys_to_check -= key_to_check
		if(key_to_check in consent_chain) // constant pain
			continue
		consent_chain |= key_to_check
		/// runs through the master consent list again
		for(var/keyname in consents)
			var/list/whowho = splittext(keyname, "!")
			if(LAZYLEN(whowho) != 2)
				continue
			if(!(whowho[2] in consent_chain))
				keys_to_check |= whowho[2]
			if(!(whowho[1] in consent_chain))
				keys_to_check |= whowho[1]
	if(!mobs_pls)
		return consent_chain
	var/list/mob_consent_chain = list()
	for(var/key in consent_chain)
		var/mob/consent_mob = ckey2mob(key)
		if(consent_mob)
			mob_consent_chain |= consent_mob
	return mob_consent_chain

// Splurt defines, because I'm a lazy shitbag. ~TK

/*
 * # lewd_prefs_choices
 * Used for determining the possible choices for lewd prefs,
 * downstreams can modify this and i don't know,
 * remove "Ask"? or make a very confusing list of options which will make players hate you for it.
*/
GLOBAL_LIST_INIT(lewd_prefs_choices, list(
	"Yes",
	"Ask",
	"No"
	))

#define CUM_TARGET_MOUTH "mouth"
#define CUM_TARGET_THROAT "throat"
#define CUM_TARGET_VAGINA "vagina"
#define CUM_TARGET_ANUS "anus"
#define CUM_TARGET_HAND "hand"
#define CUM_TARGET_BREASTS "breasts"
#define CUM_TARGET_FEET "feet"
#define CUM_TARGET_PENIS "penis"
//Weird defines go here
#define CUM_TARGET_EARS "ears"
#define CUM_TARGET_EYES "eyes"
#define CUM_TARGET_NIPPLE "nipple"
#define CUM_TARGET_URETHRA "urethra"
#define CUM_TARGET_THIGHS "thighs"
#define CUM_TARGET_BELLY "belly"
#define CUM_TARGET_ARMPIT "armpit"

#define GRINDING_FACE_WITH_ANUS "faceanus"
#define GRINDING_FACE_WITH_FEET "facefeet"
#define GRINDING_MOUTH_WITH_FEET "mouthfeet"
#define THIGH_SMOTHERING "thigh_smother"
#define NUTS_TO_FACE "nut_face"

#define CRAZY_LUST 20
#define MORE_LUST 15
#define NORMAL_LUST 10
#define SOME_MORE_LUST 6
#define SOME_LUST 3
#define LOW_LUST 1

#define REQUIRE_NONE 0
#define REQUIRE_EXPOSED 1
#define REQUIRE_UNEXPOSED 2
#define REQUIRE_ANY 3

/*
 * From /mob/living/cum(): (mob/source, mob/living/partner, target_orifice)
 * This one may return TRUE to prevent cumming.
 *
*/
#define COMSIG_MOB_PRE_CAME "mob_pre_came"
/// From /mob/living/cum(): (mob/source, mob/living/partner, target_orifice)
#define COMSIG_MOB_POST_CAME "mob_post_came"


/*
 * # INIT_ORDER_INTERACTIONS
 * Used by the Interactions subsystems, used to set it's own position in the queue.
 * This puts this last on priority, very far from other subsystems,
 * if citadel ever manages to get this far, push it ever lower.
*/
#undef ASKER_ASKED
#undef ASKED_ASKER
