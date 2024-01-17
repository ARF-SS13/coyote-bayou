/// SAVE FOLDER FORMAT:
/// master folder: data/exp/
/// current folder: data/exp/current/
/// backup folder: data/exp/backup-<roundnum>/
/// Inside the current folder:
/// ckey folder: data/exp/current/<ckey>/
/// Inside the ckey folder:
/// uid folder: data/exp/current/<ckey>/<char_uid>/
/// Inside the uid folder:
/// exp file: data/exp/current/<ckey>/<char_uid>/exp-<key>.json
/// Inside the backup folder:
/// A copy of the current folder, but with the roundnum in the name

SUBSYSTEM_DEF(experience)
	name = "experience"
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 5 MINUTES
	priority = FIRE_PRIORITY_XP

	var/list/all_lvls = list()

	var/list/uids_associated_with_ckey = list()

	/// uids that need to be loaded, usually before the game started
	var/list/to_load = list()

	var/my_shark = "broken EXP system that's broken!!!"

	var/backup_sluut = 1 // your mom

	var/debug = TRUE

	var/load_wave_complete = FALSE
	var/filesystem_is_okay = FALSE
	var/testing_filesystem = FALSE

/datum/controller/subsystem/experience/proc/Initialize(timeofday)
	check_file_system()
	if(!filesystem_is_okay)
		return ..()
	load_wave(TRUE)
	. = ..()
	shark()
	to_chat(world, span_boldannounce("Loaded [LAZYLEN(all_lvls)] characters worth of experience data! (including yours!)"))
	to_chat(world, span_announce("\t(Beware the [my_shark]!)"))

/datum/controller/subsystem/experience/proc/fire(resumed)
	if(!filesystem_is_okay)
		check_file_system()
		if(filesystem_is_okay)
			load_wave(TRUE) // okay we're good to go now!
		return
	save_loaded_exp()

/datum/controller/subsystem/experience/proc/proceed_if_ready_or_testing(mykey)
	if(filesystem_is_okay)
		return TRUE // we're good to go!
	/// otherwise check if we should proceed anyway
	if(!testing_filesystem) // filesystem down and we arent testing? block!
		return FALSE
	if(mykey != _XP_DUMMY_CKEY) // not the dummy? block!
		return FALSE
	if(mykey == _XP_DUMMY_UID1)
		return TRUE // dummy 1? proceed!
	return TRUE // proceed!

/*
 * Runs the initial load of the EXP data for all players
 * So normally a player's EXP data is loaded when they log in
 * But if they log in before this subsystem is initialized, we can't guarantee that their EXP data will be loaded
 * So we just dont, lol
 * And then after we are initialized and its verified that, in fact, everything works, we load all the EXP data for all players
 * ezclap
 */
/datum/controller/subsystem/experience/proc/load_wave(forceit)
	if(load_wave_complete) // already loaded
		return
	if(!proceed_if_ready_or_testing())
		return // something went wrong with the filesystem, don't load
	var/list/failured = list()
	for(var/ck in GLOB.directory) // players
		if(!load_player(ck))
			failured |= ck
	if(LAZYLEN(failured))
		to_chat(world, span_userdanger("Something went wrong with loading [LAZYLEN(failured)] EXPs! Contact an admin with this error code: TRICKY-TROUBLE-BUSTER-TROUT"))
		message_admins("Something went wrong with loading [LAZYLEN(failured)] EXPs! Error code: TRICKY-TROUBLE-BUSTER-TROUT")
		CRASH("Failed to load EXP files for [LAZYLEN(failured)] players!!!!!!!!!!!! Error code: TRICKY-TROUBLE-BUSTER-TROUT")
	load_wave_success()
	return TRUE

/* 
 * Runs after the initial load of the EXP data for all players
 * Tells everyone everything is gonna be okay
 */
/datum/controller/subsystem/experience/proc/load_wave_success()
	load_wave_complete = TRUE
	to_chat(world, span_green("Character data successfully loaded! =3"))
	message_admins("Character data successfully loaded! =3")
	return TRUE

/// gets the EXP directory for the character, yeah uhhhh so theres player and character, player holds the various character files, which hold the actual exp data
/datum/controller/subsystem/experience/proc/get_character_directory(c_key, uid, backup) // yup
	if(!c_key)
		return
	if(!uid)
		return
	if(backup)
		if(backup == TRUE)
			backup = GLOB.round_id
		return "[_XP_ROOT_PATH]/[_XP_BACKUP_PATH]-[GLOB.round_id]/[c_key]/[uid]/"
	return "[_XP_ROOT_PATH]/[_XP_CURRENT_PATH]/[c_key]/[uid]/"

/// gets the EXP directory for the PLAYER
/datum/controller/subsystem/experience/proc/get_player_directory(c_key, backup) // yup
	if(!c_key)
		return
	if(backup)
		if(backup <= TRUE)
			backup = GLOB.round_id
		return "[_XP_ROOT_PATH]/[_XP_BACKUP_PATH]-[GLOB.round_id]/[c_key]/"
	return "[_XP_ROOT_PATH]/[_XP_CURRENT_PATH]/[c_key]/"

/datum/controller/subsystem/experience/proc/allowed_exps(datum/exp/pat, c_key)
	// if(!c_key)
	// 	return FALSE
	// if(!ispath(pat, /datum/exp))
	// 	return FALSE
	return TRUE

// /datum/controller/subsystem/experience/proc/init_player_xp(datum/preferences/P)
// 	if(!istype(P))
// 		P = extract_prefs(P)
// 	if(!P)
// 		CRASH("Failed to extract prefs from [P]!!!!!!!!!!!! Error code: HOT-SINGLE-MEGA-FLOUNDER") // yes
// 		return FALSE
// 	if(!P.parent)
// 		return FALSE // disconnected or something, clients be fickle
// 	var/myckey = P.parent.ckey // get it while its hot!!
// 	if(!P.prefs_uid) // hasnt been set yet
// 		give_new_uid(P)
// 		if(!P.prefs_uid)
// 			to_chat(P.parent, span_userdanger("Oh no! Something went wrong with your EXP data! Contact an admin with this error code: CURVY-JIGGLY-TURBO-EEL"))
// 			CRASH("Failed to generate a UID for [P.parent.ckey]!!!!!!!!!!!! Error code: CURVY-JIGGLY-TURBO-EEL")
// 	var/myuid = P.prefs_uid
// 	if(istype(LAZYACCESS(all_lvls, myuid), /datum/exp_holder))
// 		return TRUE // already there!
// 	var/datum/exp_holder/my_holder = new /datum/exp_holder(myckey, myuid)
// 	all_lvls[myuid] = my_holder // virginity will be set, awaiting the first load when we're good and ready
// 	to_chat(P.parent, span_notice("Loading character data for [P.real_name]..."))
// 	to_load |= myuid
// 	catalogue_uid(myckey, myuid)

/* 
 * Gets a player's active character's UID
 */
/datum/controller/subsystem/experience/proc/get_active_uid(mykey)
	if(!mykey)
		return
	var/datum/preferences/P = extract_prefs(mykey)
	if(!P || !P.parent)
		return
	var/the_uid = P.prefs_uid
	if(!the_uid) // character lacks a uid! panic!
		the_uid = give_new_uid(P, TRUE)
		if(!the_uid)
			message_admins("Something went wrong with generating a UID for [mykey]! Error code: LONG-TALL-HANDSOME-PURANA")
			CRASH("Failed to generate a UID for [mykey]!!!!!!!!!!!! Error code: LONG-TALL-HANDSOME-PURANA")
	return the_uid // or suffer my curse

/*
 * Deletes a player's loaded EXP data
 * Doesnt delete the actual files, just the loaded data
 */
/datum/controller/subsystem/experience/proc/delete_player(mykey)
	if(!mykey)
		return
	for(var/uid in all_lvls)
		var/datum/exp_holder/my_holder = LAZYACCESS(all_lvls, uid)
		if(my_holder.c_key == mykey)
			all_lvls -= uid
			qdel(my_holder)
			to_chat(ckey2client(mykey), span_notice("Local character data deleted! Your saved data has not been touched, and will be loaded again when you log in."))
	return TRUE

/////////////////////////////////////////////////////
/// LOADING BLOCK ///////////////////////////////////
/*
 * Loads the EXP data for a player
 * First is fed something with a prefs datum
 * If there no prefs_uid, they're a new chaaracter! Lets make a new folder for them!
 * init = TRUE means to load the player anyway, even if the filesystem isnt verified
 * its so we can load the test character!
 * */
/datum/controller/subsystem/experience/proc/load_player(mykey, defer, getbackup, only_active = TRUE)
	if(!mykey)
		return
	if(!proceed_if_ready_or_testing(mykey)) // likely just pregame, should be okay after init!
		return
	var/ckeydirectory = get_player_directory(mykey, getbackup)
	if(only_active) // just load the active character
		return load_character(mykey, get_active_uid(mykey), defer, getbackup)
	var/list/folders = flist(ckeydirectory)
	if(!LAZYLEN(folders)) // oh they're a new player? lets make a new folder for them!
		return load_character(mykey, null, defer, getbackup)
	/// should give us a list in this format:
	/// var/list/folders = list("dir_uid1/", "dir_uid2/", ...)
	var/list/failured = list()
	for(var/uid in folders) // characters
		if(!load_character(mykey, uid, defer, getbackup))
			failured |= uid
	if(LAZYLEN(failured))
		to_chat(ckey2client(mykey), span_userdanger("Something went wrong with loading [LAZYLEN(failured)] EXPs! Contact an admin with this error code: GRIM-GROWLY-SALMON-WHALE"))
		message_admins("Something went wrong with loading [LAZYLEN(failured)] EXPs for [mykey]! Error code: GRIM-GROWLY-SALMON-WHALE")
		CRASH("Failed to load EXP files for [LAZYLEN(failured)] for [mykey] characters!!!!!!!!!!!! Error code: GRIM-GROWLY-SALMON-WHALE")
	return TRUE
/*
 * Loads the EXP data for a character
 * Starts a long intricate game of hot potato with your mom
 * */
/datum/controller/subsystem/experience/proc/load_character(mykey, uid, defer, getbackup, init)
	if(!mykey)
		return TRUE // planned failure
	if(!proceed_if_ready_or_testing(mykey)) // likely just pregame, should be okay after init!
		return TRUE // also planned failure
	if(!uid) // no uid? try and get it
		uid = initialize_player_xp(mykey)
	if(!uid)
		return TRUE // planned failure
	to_chat(ckey2client(mykey), span_notice("Loading character data for [P.real_name]..."))
	var/datum/exp_holder/my_holder = LAZYACCESS(all_lvls, uid) // check if its there first
	if(my_holder)
		return my_holder.load_from_disk() // your turn with the potato
	my_holder = new /datum/exp_holder(mykey, uid, defer) // get potatatoed, dork
	all_lvls[uid] = my_holder
	return TRUE

/* 
 * Run after the preferences are loaded, and we have a character with both a ckey and a uid
 * Loads the EXP data for the character if needed
 */
/datum/controller/subsystem/experience/proc/preferences_loaded(datum/preferences/P)
	if(!proceed_if_ready_or_testing()) // likely just pregame, should be okay after init!
		return // itll be loaded with the first wave
	if(!istype(P, /datum/preferences))
		return
	if(!P.parent)
		return
	var/myckey = P.parent.ckey // get it while its hot!!
	var/myuid = P.prefs_uid
	return load_character(myckey, myuid, FALSE, FALSE)

/////////////////////////////////////////////////////
/// SAVING BLOCK ////////////////////////////////////

/// Saves All the EXP datas!
/datum/controller/subsystem/experience/proc/save_loaded_exp()
	if(!proceed_if_ready_or_testing()) // should never proceed if we're not ready
		return
	to_chat(world, span_notice("Saving..."))
	for(var/ooid in all_lvls)
		if(!save_character(ooid, TRUE))
			message_admins("Something went wrong with saving [ooid]'s EXP data! Error code: HIGH-PRICED-LAWYER-SQUIRT")
	to_chat(world, span_good("Save complete![prob(5) ? " =3" : ""]"))

/* 
 * Saves a player's EXP data
 */

/datum/controller/subsystem/experience/proc/save_player(mykey, soft = TRUE)
	if(!mykey)
		return
	if(!proceed_if_ready_or_testing(my_key)) // likely just pregame, should be okay after init!
		return
	var/ckeydirectory = get_player_directory(mykey)
	var/list/folders = flist(ckeydirectory)
	if(!LAZYLEN(folders)) // oh they're a new player? lets make a new folder for them!
		initialize_player_xp(mykey)
	/// should give us a list in this format:
	/// var/list/folders = list("dir_uid1/", "dir_uid2/", ...)
	var/list/failured = list()
	for(var/uid in folders) // characters
		if(!save_character(mykey, uid, soft))
			failured |= uid
	if(LAZYLEN(failured))
		to_chat(ckey2client(mykey), span_userdanger("Something went wrong with saving [LAZYLEN(failured)] EXPs! Contact an admin with this error code: SHOOBY-DOO-SEA-PONY"))
		message_admins("Something went wrong with saving [LAZYLEN(failured)] EXPs for [mykey]! Error code: SHOOBY-DOO-SEA-PONY")
		CRASH("Failed to save EXP files for [LAZYLEN(failured)] for [mykey] characters!!!!!!!!!!!! Error code: SHOOBY-DOO-SEA-PONY")
	return TRUE

/// Saves a character's EXP data
/datum/controller/subsystem/experience/proc/save_character(uid, soft = TRUE)
	if(!uid)
		return
	if(!proceed_if_ready_or_testing(uid)) // likely just pregame, should be okay after init!
		return
	var/datum/exp_holder/my_holder = LAZYACCESS(all_lvls, uid)
	if(!my_holder)
		return
	return my_holder.save_to_disk(soft)

/// vital
/datum/controller/subsystem/experience/proc/shark()
	var/list/adjs = GLOB.adjectives.Copy()
	var/firstadj = safepick(adjs) || "buggy"
	adjs -= firstadj
	var/secondadj = safepick(adjs) || "busted"
	adjs.Cut() // be kind, undefined
	var/firstshark = safepick(GLOB.megacarp_first_names) || "terror"
	var/lastshark = safepick(GLOB.megacarp_last_names) || "shark"
	var/my_shark = "[firstadj] [secondadj] [firstshark] [lastshark]"
	return TRUE

/datum/controller/subsystem/experience/proc/adjust_xp(mob/master, key, amount, list/data = list())
	if(!master)
		return
	if(!master.client)
		return
	var/ckey = master.client?.ckey
	var/datum/exp_holder/my_holder = LAZYACCESS(all_lvls, ckey)
	if(!my_holder)
		return
	my_holder.adjust_xp(key, amount, data)


//////////////////////////
/// mob UID management ///

/// The uid associated with the mob, assigned on login / inhabitting of mob
/mob/var/mob_uid = 0
/// theres a prefs uid in the prefs, its used to overwrite whatever the mob_uid is

/datum/controller/subsystem/experience/proc/assign_uid(mob/master, uid)
	if(!master)
		return
	if(!uid)
		return
	if(!master.client)
		return
	var/ckey = master.client?.ckey
	var/datum/exp_holder/my_holder = LAZYACCESS(all_lvls, ckey)
	if(!my_holder)
		return
	my_holder.uid = uid

/* 
 * Takes in a new player and gets them ready for the EXP system!
 * so theres a few ways this can go
 * If they have no player level kernal json, they're fully new to this wretched system, give em everything
 * If they have a player level kernal json, but no character level master exp json, they're a new character, but they've played before
 * If both, then, cool, we're done here!
 */
/datum/controller/subsystem/experience/proc/initialize_player_xp(mykey, uid)
	if(!mykey)
		return
	var/datum/preferences/P = extract_prefs(mykey)
	if(!P || !P.parent)
		return
	if(!uid) // okay try to get their active character's uid
		uid = get_active_uid(mykey) || give_new_uid(P, TRUE) // give them a new uid if they dont have one
		if(!uid) // aw
			to_chat(P.parent, span_userdanger("Oh no! Something went wrong with your EXP data! Contact an admin with this error code: RAGIN-SOCK-DRAWER-GUPPY"))
			message_admins("Something went wrong with generating a UID for [mykey]! Error code: RAGIN-SOCK-DRAWER-GUPPY")
			CRASH("Failed to generate a UID for [P.parent.ckey]!!!!!!!!!!!! Error code: RAGIN-SOCK-DRAWER-GUPPY")
	/// now, check if they have a player level kernal json
	var/playerpath = get_player_directory(mykey)
	if(!file("[playerpath][_XP_PLAYER_KERNAL]"))
		new_player(mykey, uid)
	return uid

/*
 * Creates a new player
 * */
/datum/controller/subsystem/experience/proc/new_player(mykey, uid)
	if(!mykey)
		return
	if(!uid)
		return
	var/datum/preferences/P = extract_prefs(mykey)
	if(!P || !P.parent)
		return
	var/playerpath = get_player_directory(mykey)
	var/list/newkernal = list()
	newkernal["ckey"] = mykey
	newkernal["first_uid"] = uid
	newkernal["created_on"] = "[time2text(world.realtime, "DDD MMM DD hh:mm YYYY", "PST")]" // im PST =3
	newkernal["round_created_on"] = GLOB.round_id
	newkernal["cute_shark"] = SSexperience.my_shark // uwu
	var/jsontext = safe_json_encode(newkernal)
	if(!jsontext)
		to_chat(P.parent, span_userdanger("Something went wrong with saving your EXP data! Contact an admin with this error code: CUTE-DOMMY-SPERM-MOMMY"))
		CRASH("Failed to encode EXP master file! [c_key], [uid], [masterpath]!!!!!!!!!! Error code: CUTE-DOMMY-SPERM-MOMMY")
	WRITE_FILE("[playerpath][_XP_PLAYER_KERNAL]", jsontext)
	if(!file("[playerpath][_XP_PLAYER_KERNAL]"))
		to_chat(P.parent, span_userdanger("Something went wrong with saving your EXP data! Contact an admin with this error code: CUTE-DOMMY-SPERM-MOMMY"))
		CRASH("Failed to create EXP master file! [c_key], [uid], [masterpath]!!!!!!!!!! Error code: CUTE-DOMMY-SPERM-MOMMY")
	return TRUE

/datum/controller/subsystem/experience/proc/give_new_uid(datum/preferences/P, force = FALSE)
	if(!P)
		return
	if(P.prefs_uid && !force)
		return FALSE
	var/cool_id = generate_uid()
	if(!cool_id)
		to_chat(P.parent, span_userdanger("something went horribly, horribly wrong! Error code: BIG-ANGRY-TERROR-SHARK"))
		CRASH("Failed to generate a UID for [P.parent.ckey]!!!!!!!!!!!! Error code: BIG-ANGRY-TERROR-SHARK")
	P.prefs_uid = cool_id
	P.save_character()
	P.save_preferences()
	to_chat(P.parent, span_greentext("Your unique ID for [P.real_name] is [cool_id]!"))
	return cool_id

/datum/controller/subsystem/experience/proc/generate_uid()
	/// doesnt check if theres a dupe cus the chances of that are astronomically low
	var/randonum = rand(1000000, 9999999)
	var/list/adjs = GLOB.adjectives.Copy()
	var/firstadj = safepick(adjs) || "buggy"
	adjs -= firstadj
	var/secondadj = safepick(adjs) || "busted"
	adjs.Cut() // be kind, undefined
	var/new_id = "" // plus it'd be funny if it happens
	new_id += "[ckey(firstadj)]-" // curvacious
	new_id += "[ckey(secondadj)]-" // sultry
	new_id += "[ckey(safepick(GLOB.megacarp_first_names))]-" // terror
	new_id += "[ckey(safepick(GLOB.megacarp_last_names))]-" // shark
	new_id += "[ckey(randonum)]" // 1234567
	return new_id

/* 
 * Checks the file system for errors
 * Its a multi-stage process! First it checks for a file I created, just to be sure that the file system is working
 * Then it loads a dummy player and checks if its values are correct
 * Then does a test write to the file system, and checks if it can be read back
 */
/datum/controller/subsystem/experience/proc/check_file_system()
	filesystem_is_okay = FALSE // not no more it aint
	testing_filesystem = TRUE
	if(!file("[_XP_ROOT_PATH]/[_XP_TEST_FILE]")) // check if the file system is working
		return file_system_failure()
	var/list/testboot = safe_json_decode(file2text("[_XP_ROOT_PATH]/[_XP_TEST_FILE]"))
	if(!LAZYLEN(testboot)) // check if the file system is working
		return file_system_failure()
	if(!LAZYACCESS(testboot, "TEST"))
		return file_system_failure()
	/// okay we can access our own hard disk, great job, we put pants on
	/// now, check if we can load a dummy player
	if(!testload_dummy())
		return file_system_failure()
	/// okay we can load a dummy player, shirt is offically on
	/// now, check if we can write to the file system
	if(!testwrite_dummy())
		return file_system_failure()
	return file_system_success() // sick

/datum/controller/subsystem/experience/proc/testload_dummy()
	load_player(GLOB.xp_dummy_data["ckey"], only_active = FALSE) // say hi to WallyWeaselDaSexKing, the error checking dummy!
	/// now, check the values
	for(var/uid in GLOB.xp_dummy_data["uids"])
		var/datum/exp_holder/my_holder = LAZYACCESS(all_lvls, uid)
		if(!my_holder)
			return FALSE
		var/my_ckey = my_holder.c_key
		if(my_ckey != _XP_DUMMY_CKEY)
			return FALSE
		var/my_uid = my_holder.uid
		if(my_uid != uid)
			return FALSE
		var/lvltocheck = GLOB.xp_dummy_data["uids"][uid]["testxp"]
		var/testvalue = GLOB.xp_dummy_data["uids"][uid]["xp"]
		var/valu = SSexperience.get_xp(my_ckey, my_uid, lvltocheck, XPVAL_TOTAL_XP)
		if(valu != testvalue)
			return FALSE
	/// okay we're good to go!
	return TRUE

/datum/controller/subsystem/experience/proc/testwrite_dummy()
	SSexperience.save_player(GLOB.xp_dummy_data["ckey"], FALSE)
	SSexperience.delete_player(GLOB.xp_dummy_data["ckey"], TRUE) // say bye to WallyWeaselDaSexKing, the error checking dummy!
	/// now, load the dummy player again
	return testload_dummy()

/datum/controller/subsystem/experience/proc/file_system_failure()
	filesystem_is_okay = FALSE
	testing_filesystem = FALSE
	to_chat(world, span_userdanger("Something went wrong with the EXP file system! EXP and all related things will be unavailable until this is fixed. Contact an admin with this error code: SUDSY-SOAPY-BATH-PIKE"))
	message_admins("Something went wrong with the EXP file system! EXP and all related things will be unavailable until this is fixed. Error code: SUDSY-SOAPY-BATH-PIKE")
	CRASH("Something went wrong with the EXP file system! EXP and all related things will be unavailable until this is fixed. Error code: SUDSY-SOAPY-BATH-PIKE")

/datum/controller/subsystem/experience/proc/file_system_success()
	filesystem_is_okay = TRUE
	testing_filesystem = FALSE
	to_chat(world, span_good("XP QC OK! =3"))
	message_admins("XP QC OK! =3")
	return TRUE

//////////////////////////
/// EXP data management ///
//////////////////////////
/// Holder of EXP data ///
/datum/exp_holder
	/// UID of the player this belongs to
	var/uid
	/// c_key of the player this belongs to
	var/c_key
	/// All the exp datums we have
	var/list/lvls = list()
	/// Whether or not we've received our first load of data
	var/virgin = TRUE

/datum/exp_holder/New(c_key, uid, defer)
	. = ..()
	if(defer)
		SSexperience.to_load |= uid
	/// initial loading of blank xp data
	for(var/xp in subtypesof(/datum/exp))
		var/datum/exp/my_xp = new xp(c_key, uid, defer) // your turn with the potato
		lvls[my_xp.kind] = my_xp
	/// loaded at the end cus error checking
	src.c_key = c_key
	src.uid = uid

/datum/exp_holder/proc/Destroy(force, ...)
	QDEL_LIST_ASSOC_VAL(lvls)
	. = ..()

/datum/exp_holder/proc/get_master_file(backup = FALSE)
	var/r00t = SSexperience.get_character_directory(c_key, uid, backup)
	return "[r00t][_XP_MASTER_FILENAME]" // /data/exp/current/<ckey>/<uid>/master.json

/datum/exp_holder/proc/adjust_xp(key, amount, list/data = list())
	var/datum/exp/my_xp = LAZYACCESS(lvls, key)
	if(!my_xp)
		return
	my_xp.adjust_xp(amount, data)

/////////////////////////////////////////
/// LOADING BLOCK for holder ////////////
/// Mostly used for defereffding load ///

/datum/exp_holder/proc/load_from_disk(force)
	if(!SSexperience.filesystem_is_okay) // likely just pregame, should be okay after init!
		return
	for(var/xp in lvls)
		var/datum/exp/my_xp = xp
		my_xp.load_from_disk(force)

/////////////////////////////////////////
/// SAVING BLOCK for holder /////////////

/datum/exp_holder/proc/save_to_disk(soft)
	if(!SSexperience.filesystem_is_okay) // likely just pregame, should be okay after init!
		return
	var/list/failed = list() // you know a proc is good when it starts with a list of failures (oh look you're at the top)
	for(var/xp in lvls)
		var/datum/exp/my_xp = xp
		if(!my_xp.save_to_disk(soft))
			failed |= xp
	if(LAZYLEN(failed))
		to_chat(ckey2client(c_key), span_userdanger("Something went wrong with saving your EXP data! [LAZYLEN(failed)] EXPs failed!!! Contact an admin with this error code: MEGA-MINI-FLAT-FLUKE"))
		message_admins("Something went wrong with saving [c_key]'s EXP data! [LAZYLEN(failed)] EXPs failed!!! Error code: MEGA-MINI-FLAT-FLUKE")
		CRASH("Failed to save EXP files for [c_key]!!!!!!!!!!!! [LAZYLEN(failed)] EXPs failed!!! Error code: MEGA-MINI-FLAT-FLUKE")
	to_chat(ckey2client(c_key), span_good("Character data successfully saved! =3"))
	return update_master_file()

/*
 * Updates the master file
 * */
/datum/exp_holder/proc/update_master_file()
	/// individual xp files are saved, now save the master file
	/// now update the master file
	var/masterpath = get_master_file()
	var/list/currmaster = safe_json_decode(file2text(masterpath))
	if(!currmaster)
		CRASH("Failed to read EXP master file! [c_key], [uid], [masterpath]!!!!!!!!!! Error code: CUTE-SUBBY-SPERM-WHALE")
	var/list/rounds_saved = LAZYACCESS(currmaster, "rounds_saved")
	if(!LAZYLEN(rounds_saved))
		rounds_saved = list()
	rounds_saved |= GLOB.round_id
	currmaster["rounds_saved"] = rounds_saved
	var/jsontext = safe_json_encode(currmaster)
	if(!jsontext)
		CRASH("Failed to encode EXP master file! [c_key], [uid], [masterpath]!!!!!!!!!! Error code: CUTE-DOMMY-SPERM-MOMMY")
	fdel(masterpath)
	WRITE_FILE(masterpath, jsontext)

/// Creates a new player save file, mainly to designate that this charaacter is a new player
/datum/exp_holder/proc/init_master()
	var/masterpath = get_master_file()
	if(file(masterpath))
		return TRUE // already there!
	var/list/currmaster = list()
	currmaster["c_key"] = c_key
	currmaster["uid"] = uid
	currmaster["rounds_saved"] = list()
	currmaster["rounds_saved"] |= GLOB.round_id
	currmaster["created_on"] = "[time2text(world.realtime, "DDD MMM DD hh:mm YYYY", "PST")]" // im PST =3
	currmaster["round_created_on"] = GLOB.round_id
	currmaster["cute_shark"] = SSexperience.my_shark // uwu
	var/jsontext = safe_json_encode(currmaster)
	if(!jsontext)
		to_chat(ckey2client(c_key), span_userdanger("Something went wrong with saving your EXP data! Contact an admin with this error code: CUTE-DOMMY-SPERM-MOMMY"))
		CRASH("Failed to encode EXP master file! [c_key], [uid], [masterpath]!!!!!!!!!! Error code: CUTE-DOMMY-SPERM-MOMMY")
	WRITE_FILE(masterpath, jsontext)
	if(!file(masterpath))
		to_chat(ckey2client(c_key), span_userdanger("Something went wrong with saving your EXP data! Contact an admin with this error code: CUTE-DOMMY-SPERM-MOMMY"))
		CRASH("Failed to create EXP master file! [c_key], [uid], [masterpath]!!!!!!!!!! Error code: CUTE-DOMMY-SPERM-MOMMY")
	return TRUE

//////////////////////////
/// Individual XP data ///
/datum/exp
	var/name = "Githubber"
	var/verbing = "Calling 1-800-IMC-ODER"
	var/readme_file = "default_readme.txt"
	var/kind = XP_DEFAULT
	var/lvl = 0
	var/total_xp = 0
	var/current_xp = 0
	var/highest_xp = 0
	var/next_level_xp = 0
	var/this_level_base_xp = 0
	var/max_level = 1000
	var/uid
	var/c_key

	var/currentround = 0
	var/last_updated = 0
	var/last_saved = 0

	var/today_year = 0
	var/today_month = 0
	var/today_day = 0

	var/virginity = TRUE
	var/durty = FALSE
	var/dont_save_me = FALSE // daddy
	var/newplayer = FALSE

/datum/exp/New(c_key, uid, defer)
	. = ..()
	if(!c_key)
		return
	if(!uid)
		return
	src.c_key = c_key
	src.uid = uid
	today_year = text2num(time2text(world.timeofday, "YY"))
	today_month = text2num(time2text(world.timeofday, "MM"))
	today_day = text2num(time2text(world.timeofday, "DD"))
	currentround = GLOB.round_id
	if(defer)
		return
	load_from_disk()

/*
 * Gets the filepath for the EXP data
 */
/datum/exp/proc/get_filepath(backup = FALSE)
	var/r00t = SSexperience.get_character_directory(c_key, uid, FALSE)
	var/myfile = XP2FILE(kind)
	return "[r00t][myfile]" // data/exp/current/<ckey>/<uid>/<char_uid>/exp-<kind>.json

/////////////////////////////////////////////////////
/// LOADING BLOCK ///////////////////////////////////

/*
 * Loads the XP data from our file
 * */
/datum/exp/proc/load_from_disk(force)
	if(!virgin && !force)
		return TRUE // We're good for one load, then we're happy
	var/xppath = get_filepath()
	if(!file(xppath)) // likely a new character
		newplayer = TRUE
		return TRUE // nothing to load!
	var/list/xpdata = safe_json_decode(file2text(xppath))
	if(!xpdata)
		CRASH("Failed to read EXP file! [c_key], [uid], [xppath]!!!!!!!!!! Error code: LANKY-SPANKY-GORILLA-FLUKE")
	return load_from_json(xpdata, force)

/* 
 * Loads the XP data from json (jk its a list)
 * */
/datum/exp/proc/load_from_json(list/xpdata, force)
	if(!LAZYLEN(xpdata))
		return FALSE // nothing to load!
	if(!verify_save(xpdata))
		to_chat(ckey2client(c_key), span_userdanger("Your [name] EXP data is corrupted! Contact an admin with this error code: LICKY-STICKY-SPUNK-FLUKE"))
		CRASH("Failed to verify EXP data! [c_key], [uid], [filepath]!!!!!!!!!! Error code: LICKY-STICKY-SPUNK-FLUKE")
	if(!read_data(xpdata))
		to_chat(ckey2client(c_key), span_userdanger("Your [name] EXP data is corrupted! Contact an admin with this error code: LANKY-SPANKY-GORILLA-FLUKE"))
		CRASH("Failed to read EXP data! [c_key], [uid], [filepath]!!!!!!!!!! Error code: LANKY-SPANKY-GORILLA-FLUKE")
	post_load(xpdata)
	virginity = FALSE // thanks for that hot load, uwu
	return TRUE

/* 
 * COnverts a list of data into our data
 * If you do fancy stuff with the data, you should make polymorphically
 */
/datum/exp/proc/read_data(list/xpdata)
	total_xp = LAZYACCESS(xpdata, "total_xp")
	current_xp = LAZYACCESS(xpdata, "current_xp")
	highest_xp = LAZYACCESS(xpdata, "highest_xp")
	return TRUE

/*
 * Does things after loading the data
 * Like recaculating the level from the total XP
 */
/datum/exp/proc/post_load(list/xpdata, announce = TRUE)
	if(check_level(FALSE))
		to_chat(ckey2client(c_key), span_notice("Sucessfully loaded [name] EXP data! [prob(5) ? "=3" : ""]"))

/*
 * Verifies the save data
 * Checks a couple static values to make sure the file is legit
 */
/datum/exp/proc/verify_save(list/savedata)
	if(!LAZYLEN(savedata))
		return FALSE // nothing to load!
	var/verification_can =   (LAZYACCESS(savedata, _XPVERIFICATION_FGLAND_KEY) == _XPVERIFICATION_FGLAND_VAL)
	var/verification_juice = (LAZYACCESS(savedata, _XPVERIFICATION_BGLAND_KEY) == _XPVERIFICATION_BGLAND_VAL)
	if(!verification_can ||verification_juice)
		message_admins(span_userdanger(("WEEEOOOWEEEOO THE [c_key]'s [type] FILE IS CORRUPTED! IT BAD AND YOU NEED TO FIX IT OR GET DAN TO DO IT!!!!! Feel free to tell this player their hard earned videogame numbers are GONE FOREVER!!!!")))
		to_chat(ckey2client(c_key), span_userdanger("Your [name] EXP data is corrupted! Contact an admin! This set of XP will not change until it's fixed!"))
		dont_save_me = TRUE // Something went wrong with saving, lets stop saving until its fixed
		return FALSE
	return TRUE

/////////////////////////////////////////////////////
/// SAVING BLOCK ////////////////////////////////////

/// Saves the XP data to a file
/datum/exp/proc/save_to_disk(only_progress, soft)
	if(!SSexperience.filesystem_is_okay) // likely just pregame, should be okay after init!
		return
	var/filepath = get_filepath(FALSE)
	var/backup_filepath = get_filepath(TRUE)
	if(!should_save(filepath, only_progress, soft))
		return TRUE
	var/list/savedata = list()
	savedata["name"] = name
	savedata["c_key"] = c_key
	savedata["uid"] = uid
	savedata["kind"] = kind
	savedata["type"] = type
	savedata["total_xp"] = total_xp
	savedata["current_xp"] = current_xp
	savedata["highest_xp"] = highest_xp
	savedata["next_level_xp"] = next_level_xp
	savedata["this_level_base_xp"] = this_level_base_xp
	savedata["lvl"] = lvl
	savedata["currentround"] = currentround
	savedata["last_updated"] = last_updated
	savedata["last_saved"] = last_saved
	savedata["today_year"] = today_year
	savedata["today_month"] = today_month
	savedata["today_day"] = today_day
	savedata[_XPVERIFICATION_FGLAND_KEY] = _XPVERIFICATION_FGLAND_VAL
	savedata[_XPVERIFICATION_BGLAND_KEY] = _XPVERIFICATION_BGLAND_VAL
	var/jsontext = safe_json_encode(savedata)
	if(!jsontext)
		var/client/C = ckey2client(c_key)
		if(C)
			to_chat(C, span_userdanger("Something went wrong with saving your EXP data! Contact an admin with this error code: MEGA-MINI-FLAT-FLUKE"))
		CRASH("Failed to encode EXP data! [c_key], [uid], [filepath]!!!!!!!!!! Error code: MEGA-MINI-FLAT-FLUKE")
	fdel(filepath)
	WRITE_FILE(filepath, jsontext)
	last_saved = round(world.time, 1)
	dont_save_me = FALSE // we're good to save again!
	if(saved_successfully(filepath))
		fdel(backup_filepath)
		WRITE_FILE(backup_filepath, jsontext)
		var/client/C = ckey2client(c_key)
		if(C)
			to_chat(C, span_good("Character data successfully saved! =3"))
		return TRUE
	else
		dont_save_me = TRUE // Something went wrong with saving, lets stop saving until its fixed
		var/client/C = ckey2client(c_key)
		if(C)
			to_chat(C, span_userdanger("Something went wrong with saving your EXP data! Contact an admin with this error code: MEGA-MINI-FLAT-FLUKE"))
		CRASH("Failed to save EXP data! [c_key], [uid], [filepath]!!!!!!!!!! Error code: MEGA-MINI-FLAT-FLUKE")

/// Test-reads the XP data from a file and compares it to the current data, which should be the same
/datum/exp/proc/saved_successfully(filepath)
	if(!SSexperience.filesystem_is_okay) // likely just pregame, should be okay after init!
		return FALSE // cus it sisnt
	if(!file(filepath))
		return FALSE
	var/list/savedata = safe_json_decode(file2text(filepath))
	if(!savedata)
		return FALSE
	if(!verify_save(savedata))
		return FALSE
	if(total_xp != LAZYACCESS(xpdata, "total_xp"))
		return FALSE
	return TRUE

/// Checks if we should save the file
/// returns TRUE if we should, FALSE if we shouldn't
/datum/exp/proc/should_save(filepath, only_progress, soft)
	if(!fexists(filepath))
		return TRUE // no file, good to save!
	if(dont_save_me)
		return FALSE // something went wrong with saving, lets stop saving until its fixed
	if(soft && !durty)
		return FALSE // we're not dirty, no need to towel me off, daddy
	return TRUE
	// var/now_thisround = GLOB.round_id
	// var/now_roundtime = round(world.time, 1)
	// var/list/the_save = safe_json_decode(file2text(filepath))
	// var/then_thisround = LAZYACCESS(the_save, "currentround")
	// var/then_roundtime = LAZYACCESS(the_save, "last_updated")
	// if(!then_thisround || !then_roundtime)
	// 	return TRUE // something went wrong with saving, lets save again
	// if(then_thisround > now_thisround)
	// 	return FALSE // We're somehow in a previous round, don't save
	// if(then_roundtime > now_roundtime)
	// 	return FALSE // We're somehow in the past, don't save
	// if(only_progress)
	// 	if(total_xp <= LAZYACCESS(the_save, "total_xp"))
	// 		return FALSE // We haven't gained any XP, don't save

/// Takes the total XP we had saved, and figures out what level we are
/// Also sets the current XP to the amount we have left over
/// Assumes a base level of 0
/// Used only for loading from prefs
/datum/exp/proc/check_level(loud = TRUE)
	for(var/i in 0 to max_level)
		var/needed_xp = xp2lvl(i)
		if(needed_xp < total_xp)
			continue
		var/new_lvl = i - 1
		current_xp = total_xp - xp2lvl(new_lvl)
		next_level_xp = xp2lvl(lvl + 1)
		this_level_base_xp = needed_xp
		var/num_levels = new_lvl - lvl
		lvl = new_lvl
		if(num_levels > 0)
			on_lvl_up(new_lvl, num_levels, loud)
			alert_lvl_change(new_lvl, num_levels, loud)
		else if(num_levels < 0)
			on_lvl_down(new_lvl, num_levels, loud)
			alert_lvl_change(new_lvl, num_levels, loud)
		return

/// Override with your own xp -> level code
/// takes in a level, returns the minimum amount of xp needed to be that level
/datum/exp/proc/xp2lvl(lvl)
	lvl = clamp(lvl, 0, max_level)
	var/out = lvl * lvl * 100
	return out

/// functional things for levelling up
/datum/exp/proc/on_lvl_up(new_lvl, num_levels, loud = TRUE)
	// override me!

/// functional things for levelling down
/datum/exp/proc/on_lvl_down(new_lvl, num_levels, loud = TRUE)
	// override me!

/// Alerts the player that they have levelled up or down
/datum/exp/proc/alert_lvl_change(new_lvl, num_levels, loud = TRUE)
	if(!loud)
		return
	if(num_levels == 0)
		return
	if(!c_key)
		return
	var/mob/M = ckey2mob(c_key)
	if(!M)
		return
	if(!M.client)
		return
	if(num_levels > 0)
		if(num_levels == 1)
			to_chat(M, span_greentext("You have gained a level in [span_love(name)]! You are now a level [new_lvl]!"))
		else
			to_chat(M, span_greentext("You have gained [num_levels] levels in [span_love(name)]! You are now a level [new_lvl]!"))
	else if(num_levels < 0)
		if(num_levels == -1)
			to_chat(M, span_userdanger("You have lost a level in [span_love(name)]! You are now level [new_lvl]!"))
		else
			to_chat(M, span_userdanger("You have lost [num_levels] levels in [span_love(name)]! You are now level [new_lvl]!"))

/// Adjusts the current XP by the amount given
/// can make it negative to remove XP
/datum/exp/proc/adjust_xp(amount, list/data = list())
	if(amount == 0)
		return
	total_xp += amount
	current_xp = total_xp - this_level_base_xp
	if(amount > 0)
		on_gain_xp(amount, data)
	else
		on_lose_xp(amount, data)
	check_level()

/// Override with your own code to do something when you gain XP
/// amount is the amount of XP gained
/datum/exp/proc/on_gain_xp(amount, list/data = list())
	// override me!

/// Override with your own code to do something when you lose XP
/datum/exp/proc/on_lose_xp(amount, list/data = list())
	// override me!

/datum/exp/pve
	name = "PvE"
	verbing = "Assailing wildlife"
	readme_file = "pve_readme.txt"
	kind = XP_PVE
	max_level = 1000

/datum/exp/pvp
	name = "PvP"
	verbing = "Hurting people and their feelings"
	readme_file = "pvp_readme.txt"
	kind = XP_PVP
	max_level = 1000

