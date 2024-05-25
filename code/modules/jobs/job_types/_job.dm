/datum/job
	//The name of the job , used for preferences, bans and more. Make sure you know what you're doing before changing this.
	var/title = "NOPE"

	//Job access. The use of minimal_access or access is determined by a config setting: config.jobs_have_minimal_access
	var/list/minimal_access = list()		//Useful for servers which prefer to only have access given to the places a job absolutely needs (Larger server population)
	var/list/access = list()				//Useful for servers which either have fewer players, so each person needs to fill more than one role, or servers which like to give more access, so players can't hide forever in their super secure departments (I'm looking at you, chemistry!)

	//Determines who can demote this position
	var/department_head = list()

	//Tells the given channels that the given mob is the new department head. See communications.dm for valid channels.
	var/list/head_announce = null

	//Bitflags for the job
	var/flag = NONE //Deprecated
	var/department_flag = NONE //Deprecated
//	var/auto_deadmin_role_flags = NONE

	//Players will be allowed to spawn in as jobs that are set to "Station"
	var/faction = "None"

	//How many players can be this job
	var/total_positions = 0

	//How many players can spawn in as this job
	var/spawn_positions = 0

	//How many players have this job
	var/current_positions = 0

	//Supervisors, who this person answers to directly
	var/supervisors = ""

	//Sellection screen color
	var/selection_color = "#ffffff"


	//If this is set to 1, a text is printed to the player when jobs are assigned, telling him that he should let admins know that he has to disconnect.
	var/req_admin_notify

	// This is for Citadel specific tweaks to job notices.
	var/custom_spawn_text

	//If you have the use_age_restriction_for_jobs config option enabled and the database set up, this option will add a requirement for players to be at least minimal_player_age days old. (meaning they first signed in at least that many days before.)
	var/minimal_player_age = 0

	var/outfit = null
	var/plasma_outfit = null //the outfit given to plasmamen

	var/exp_requirements = 0 //This is in... minutes?

	var/exp_type = EXP_TYPE_LIVING
	var/exp_type_department = ""

	//faction objective for the round
	var/objectives
	var/list/objectivesList

	//Special faction system
	var/social_faction = null


	//The amount of good boy points playing this role will earn you towards a higher chance to roll antagonist next round
	//can be overridden by antag_rep.txt config
	var/antag_rep = 10

	var/paycheck = PAYCHECK_MINIMAL
	var/paycheck_department = ACCOUNT_CIV

	var/list/mind_traits // Traits added to the mind of the mob assigned this job
	var/list/blacklisted_quirks		//list of quirk typepaths blacklisted.

/// Should this job be allowed to be picked for the bureaucratic error event?
	var/allow_bureaucratic_error = TRUE

	var/display_order = JOB_DISPLAY_ORDER_DEFAULT

	//If a job complies with dresscodes, loadout items will not be equipped instead of the job's outfit, instead placing the items into the player's backpack.
	var/dresscodecompliant = TRUE
	// How much threat this job is worth in dynamic. Is subtracted if the player's not an antag, added if they are.
	var/threat = 0

	/// Starting skill modifiers.
	var/list/starting_modifiers

	//Description, short text about the job
	var/description = ""

	//Against the faction rules, for imporant things that you SHOULDNT do.
	var/forbids = ""

	//For things that faction Enforces.
	var/enforces = ""
	//List of outfit datums that can be selected by this job - after spawning - as additional equipment.
	//This is ontop of the base job outfit
	var/list/datum/outfit/loadout_options

	/// Which kind of matchmaking this job allows, and with which departments. Associative list:  matchmaking_allowed[matchmaking datum typepath] -> list(job datum typepaths allowed)
	var/list/matchmaking_allowed

	/// Which kind of whitelist does this job use? for txt based whitelisting
	/// the value should be something like "strings/names/cow.txt"
	var/whitelist_path


/datum/job/proc/after_spawn(mob/living/spawner, mob/client_holder, latejoin = FALSE)
	SHOULD_CALL_PARENT(TRUE)

	for(var/trait in mind_traits)
		ADD_TRAIT(spawner.mind, trait, JOB_TRAIT)

	if(/datum/quirk/paraplegic in blacklisted_quirks)
		spawner.regenerate_limbs() //if you can't be a paraplegic, attempt to regenerate limbs to stop amputated limb selection
		spawner.set_resting(FALSE, TRUE) //they probably shouldn't be on the floor because they had no legs then suddenly had legs

	var/matchmaking_prefs = shuffle(client_holder.client?.prefs?.matchmaking_prefs)
	if(matchmaking_prefs)
		for(var/datum/matchmaking_pref/matching as anything in matchmaking_prefs)
			if(!(matching in matchmaking_allowed))
				continue
			var/number_of_matches = clamp(matchmaking_prefs[matching], 0, initial(matching.max_matches))
			if(!number_of_matches)
				continue
			var/datum/matchmaking_pref/match_instance = new matching(spawner, number_of_matches)
			if(latejoin)
				match_instance.try_finding_matches()



/datum/job/proc/announce(mob/living/carbon/human/H)
	if(head_announce)
		announce_head(H, head_announce)

/datum/job/proc/override_latejoin_spawn(mob/living/carbon/human/H)		//Return TRUE to force latejoining to not automatically place the person in latejoin shuttle/whatever.
	return FALSE

//Used for a special check of whether to allow a client to latejoin as this job.
/datum/job/proc/special_check_latejoin(client/C)
	return TRUE

/datum/job/proc/GetAntagRep()
	. = CONFIG_GET(keyed_list/antag_rep)[lowertext(title)]
	if(. == null)
		return antag_rep

/datum/job/proc/GetThreat()
	. = CONFIG_GET(keyed_list/job_threat)[lowertext(title)]
	if(. == null)
		return threat

//Don't override this unless the job transforms into a non-human (Silicons do this for example)
/datum/job/proc/equip(mob/living/carbon/human/H, visualsOnly = FALSE, announce = TRUE, latejoin = FALSE, datum/outfit/outfit_override = null, client/preference_source)
	if(!H)
		return FALSE
	if(!visualsOnly)
		var/datum/bank_account/bank_account = new(H.real_name, src)
		bank_account.account_holder = H.real_name
		bank_account.account_job = src
		bank_account.account_id = rand(111111,999999)
		bank_account.payday(STARTING_PAYCHECKS, TRUE)
		H.account_id = bank_account.account_id
	if(CONFIG_GET(flag/enforce_human_authority) && (title in GLOB.command_positions))
		if(H.dna.species.id != "human")
			H.set_species(/datum/species/human)
			H.apply_pref_name("human", preference_source)
	// F13 EDIT: GHOULS CANNOT BE LEGION, BROTHERHOOD, TRIBAL OR VAULT  //CB Edit: Eat a dick shitbags
	/*
	if((title in GLOB.legion_positions) || (title in GLOB.vault_positions) || (title in GLOB.brotherhood_positions) || (title in GLOB.tribal_positions))
		if(H.dna.species.id == "ghoul")
			H.set_species(/datum/species/human)
			H.apply_pref_name("human", H.client)
		*/

	//Equip the rest of the gear
	H.dna.species.before_equip_job(src, H, visualsOnly)

	var/datum/outfit/job/O = outfit_override || outfit
	if(O)
		H.equipOutfit(O, visualsOnly, preference_source) //mob doesn't have a client yet.

	//If we have any additional loadouts, notify the player
	if(!visualsOnly && LAZYLEN(loadout_options))
		H.enable_loadout_select()

	H.dna.species.after_equip_job(src, H, visualsOnly)

	if(!visualsOnly && announce)
		announce(H)

	//TGCLAW Change: Adds faction according to the job datum and is sanity checked because of nightmares from before -ma44
	if(faction)
		if(islist(faction))
			H.faction |= faction
		else
			H.faction += faction

	if(social_faction)
		H.social_faction = social_faction

/datum/job/proc/get_access()
	if(!config)	//Needed for robots.
		return src.minimal_access.Copy()

	. = list()

	if(CONFIG_GET(flag/jobs_have_minimal_access))
		. = src.minimal_access.Copy()
	else
		. = src.access.Copy()

	if(CONFIG_GET(flag/everyone_has_maint_access)) //Config has global maint access set
		. |= list(ACCESS_MAINT_TUNNELS)

/datum/job/proc/announce_head(mob/living/carbon/human/H, channels) //tells the given channel that the given mob is the new department head. See communications.dm for valid channels.
	if(H && GLOB.announcement_systems.len)
		//timer because these should come after the captain announcement
		SSticker.OnRoundstart(CALLBACK(usr, GLOBAL_PROC_REF(_addtimer), CALLBACK(pick(GLOB.announcement_systems), /obj/machinery/announcement_system/proc/announce, "NEWHEAD", H.real_name, H.job, channels), 1))

//If the configuration option is set to require players to be logged as old enough to play certain jobs, then this proc checks that they are, otherwise it just returns 1
/datum/job/proc/player_old_enough(client/C)
	if(available_in_days(C) == 0)
		return TRUE	//Available in 0 days = available right now = player is old enough to play.
	return FALSE

/datum/job/proc/available_in_days(client/C)
	if(!C)
		return 0
	if(!CONFIG_GET(flag/use_age_restriction_for_jobs))
		return 0
	if(!SSdbcore.Connect())
		return 0 //Without a database connection we can't get a player's age so we'll assume they're old enough for all jobs
	if(C.prefs.db_flags & DB_FLAG_EXEMPT)
		return 0
	if(!isnum(minimal_player_age))
		return 0

	return max(0, minimal_player_age - C.player_age)

/datum/job/proc/config_check()
	return TRUE

/datum/job/proc/map_check()
	return TRUE

/datum/job/proc/radio_help_message(mob/M)
	to_chat(M, "<b>Prefix your message with :h to speak on your department's radio. To see other prefixes, look closely at your headset.</b>")

/datum/job/proc/standard_assign_skills(datum/mind/M)
	if(!starting_modifiers)
		return
	for(var/mod in starting_modifiers)
		ADD_SINGLETON_SKILL_MODIFIER(M, mod, null)

/datum/outfit/job
	name = "Standard Gear"

	var/jobtype = null

	uniform = /obj/item/clothing/under/color/grey
	id = /obj/item/card/id
	ears = /obj/item/radio/headset
	belt = /obj/item/pda
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/sneakers/black
	box = /obj/item/storage/survivalkit
	box_two = /obj/item/storage/survivalkit/medical

	var/backpack = /obj/item/storage/backpack
	var/satchel  = /obj/item/storage/backpack/satchel
	var/duffelbag = /obj/item/storage/backpack/duffelbag

	var/pda_slot = SLOT_BELT

	var/chemwhiz = FALSE //F13 Chemwhiz, for chemistry machines
	var/pa_wear = FALSE //F13 pa_wear, ability to wear PA
	var/gunsmith_one = FALSE //F13 gunsmith perk, ability to craft Tier 2 guns and ammo
	var/gunsmith_two = FALSE //F13 gunsmith perk, ability to craft Tier 3 guns and ammo
	var/gunsmith_three = FALSE //F13 gunsmith perk, ability to craft Tier 4 guns and ammo
	var/gunsmith_four = FALSE //F13 gunsmith perk, ability to craft Tier 5 guns and ammo


/datum/outfit/job/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	var/preference_backpack = preference_source?.prefs.backbag

	if(preference_backpack)
		switch(preference_backpack)
			if(DBACKPACK)
				back = backpack //Department backpack
			if(DSATCHEL)
				back = satchel //Department satchel
			if(DDUFFELBAG)
				back = duffelbag //Department duffel bag
			else
				var/find_preference_backpack = GLOB.backbaglist[preference_backpack] //attempt to find non-department backpack
				if(find_preference_backpack)
					back = find_preference_backpack
				else //tried loading in a backpack that we don't allow as a loadout one
					back = backpack
	else //somehow doesn't have a preference set, should never reach this point but just-in-case
		back = backpack

	//converts the uniform string into the path we'll wear, whether it's the skirt or regular variant
	var/holder
	if(preference_source && preference_source.prefs.jumpsuit_style == PREF_SKIRT)
		holder = "[uniform]/skirt"
		if(!text2path(holder))
			holder = "[uniform]"
	else
		holder = "[uniform]"
	uniform = text2path(holder)

	if(box_two && isrobotic(H))
		box_two = /obj/item/storage/survivalkit/medical/synth

	if(chemwhiz == TRUE)
		ADD_TRAIT(H, TRAIT_CHEMWHIZ, "chemwhiz")

	if(pa_wear == TRUE)
		ADD_TRAIT(H, TRAIT_PA_WEAR, "pa_wear")

	if(gunsmith_one == TRUE)
		ADD_TRAIT(H, TRAIT_GUNSMITH_ONE, "gunsmith_one")

	if(gunsmith_two == TRUE)
		ADD_TRAIT(H, TRAIT_GUNSMITH_TWO, "gunsmith_two")

	if(gunsmith_three == TRUE)
		ADD_TRAIT(H, TRAIT_GUNSMITH_THREE, "gunsmith_three")

	if(gunsmith_four == TRUE)
		ADD_TRAIT(H, TRAIT_GUNSMITH_FOUR, "gunsmith_four")

/datum/outfit/job/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	if(visualsOnly)
		return

	var/datum/job/J = SSjob.GetJobType(jobtype)
	if(!J)
		J = SSjob.GetJob(H.job)

	var/obj/item/card/id/C = H.wear_id
	if(istype(C) && C.bank_support)
		C.access = J.get_access()
		shuffle_inplace(C.access) // Shuffle access list to make NTNet passkeys less predictable
		C.registered_name = H.real_name
		C.assignment = J.title
		C.update_label()
		for(var/A in SSeconomy.bank_accounts)
			var/datum/bank_account/B = A
			if(B.account_id == H.account_id)
				C.registered_account = B
				B.bank_cards += C
				break
		H.sec_hud_set_ID()

	var/obj/item/pda/PDA = H.get_item_by_slot(pda_slot)
	if(istype(PDA))
		PDA.owner = H.real_name
		PDA.ownjob = J.title
		PDA.update_label()
		if(preference_source && !PDA.equipped) //PDA's screen color, font style and look depend on client preferences.
			PDA.update_style(preference_source)

	if(chemwhiz == TRUE)
		ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)

	if(pa_wear == TRUE)
		ADD_TRAIT(H, TRAIT_PA_WEAR, src)

	//Fortuna edit start. radio management
	if(J.faction && ears)
		var/obj/item/radio/T = H.get_item_by_slot(SLOT_EARS)
		if(istype(T) && T.factionized)
			T.linked_mob = H
	//Fortuna edit end. radio management

/datum/outfit/job/get_chameleon_disguise_info()
	var/list/types = ..()
	types -= /obj/item/storage/backpack //otherwise this will override the actual backpacks
	types += backpack
	types += satchel
	types += duffelbag
	return types

//Warden and regular officers add this result to their get_access()
/datum/job/proc/check_config_for_sec_maint()
	if(CONFIG_GET(flag/security_has_maint_access))
		return list(ACCESS_MAINT_TUNNELS)
	return list()
