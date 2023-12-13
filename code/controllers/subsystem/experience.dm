/// SAVE FOLDER FORMAT:
/// master folder: data/exp/
/// current folder: data/exp/current/
/// backup folder: data/exp/backup-<roundnum>/
/// Inside the current folder:
/// ckey folder: data/exp/current/<ckey>/
/// Inside the ckey folder:
/// uid folder: data/exp/current/<ckey>/<xp_directory_name>/
/// Inside the uid folder:
/// exp file: data/exp/current/<ckey>/<xp_directory_name>/exp-<key>.json
/// Inside the backup folder:
/// A copy of the current folder, but with the roundnum in the name

SUBSYSTEM_DEF(experience)
	name = "experience"
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 10 SECONDS
	priority = FIRE_PRIORITY_XP

	var/list/all_lvls = list()

	var/list/uids_associated_with_ckey = list()

	/// if something went wrong, try again at some point
	var/list/to_load = list()

	var/my_shark = "broken-ass EXP system that's broken!!!"

	var/backup_slut = 1 // your mom

/datum/controller/subsystem/experience/proc/Initialize(timeofday)
	. = ..()
	shark()
	to_chat(world, span_boldannounce("Loaded [LAZYLEN(all_lvls)] characters worth of experience data! (including yours!)"))
	to_chat(world, span_announce("\t(Beware the [my_shark]!)"))

/datum/controller/subsystem/experience/proc/fire(resumed)
	save_loaded_exp()

/// loads a player-level save file and loads in all the characters' datas
/datum/controller/subsystem/experience/proc/load_xp_data(critter)
	if(!critter)
		return
	var/datum/preferences/P = extract_prefs(critter)
	if(!P)
		return
	if(!P.prefs_uid || !P.xp_directory_name)
		generate_uid(critter)
	if(!P.prefs_uid || !P.xp_directory_name)
		CRASH("Failed to generate a UID for [P.parent.ckey]!!!!!!!!!!!!")
	var/ckeydirectory = "data/exp/current/[P.xp_directory_name]/"
	/// should give us a list in this format:
	/// var/list/folders = list("uid1/", "uid2/", ...)
	var/list/folders = flist(ckeydirectory)
	if(!LAZYLEN(folders))
		init_ckey_save(P)
		return .(critter) // try again!!!
	for(var/uid in folders) // characters
		var/datum/exp_holder/my_holder = new /datum/exp_holder(P.parent.ckey, uid)
		all_lvls[P.prefs_uid] = my_holder
		/// formt: var/list/idaho = list("exp-<key>.json", "exp-<key>.json", ...)
		var/list/idaho = flist("[ckeydirectory][uid]/")
		if(!LAZYLEN(idaho))
			continue
		for(var/expfile in idaho)
			if(!findtext(expfile, "exp-") || !findtext(expfile, ".json"))
				stack_trace("Invalid EXP file found! [expfile]!!!!!!!!!!")
			if(!my_holder.load_exp_file("[ckeydirectory][uid][expfile]"))
				stack_trace("Failed to load EXP file! [expfile]!!!!!!!!!!")

/// Saves a player-level save file and saves all the characters' datas
/datum/controller/subsystem/experience/proc/save_loaded_exp(critter)
	if(!critter)
		return
	var/datum/preferences/P = extract_prefs(critter)
	if(!P)
		return
	if(!P.prefs_uid || !P.xp_directory_name)
		generate_uid(critter)
	if(!P.prefs_uid || !P.xp_directory_name)
		CRASH("Failed to generate a UID for [P.parent.ckey]!!!!!!!!!!!!")
	/// Now find all the relephant save holders
	var/list/holders = list()
	if(!LAZYLEN(LAZYACCESS(uids_associated_with_ckey, P.parent.ckey)))
		for(var/holder in all_lvls)
			if(holder.ckey != P.parent.ckey)
				continue
			uids_associated_with_ckey |= holder.uid
	for(var/uid in LAZYACCESS(uids_associated_with_ckey, P.parent.ckey))
		var/datum/exp_holder/my_holder = LAZYACCESS(all_lvls, uid)
		if(!my_holder)
			continue
		holders |= my_holder
	/// Now save them!
	for(var/datum/exp_holder/holder in holders)
		if(!holder.ckey || !holder.uid)
			continue
		for(var/xp in holder.lvls)
			xp.save_to_disk()
	var/client/C = P.parent
	if(C)
		to_chat(C, span_good("Character data successfully saved! =3"))




/// vital
/datum/controller/subsystem/experience/proc/shark()
	my_shark = "[pick(GLOB.megacarp_first_names)] [pick(GLOB.megacarp_last_names)]"


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

/datum/controller/subsystem/experience/proc/load_xp_data(critter)
	if(!critter)
		return
	var/datum/preferences/P = extract_prefs(critter)
	if(!P)
		return
	if(!P.prefs_uid)
		return
	var/datum/exp_holder/my_holder = LAZYACCESS(all_lvls, P.prefs_uid)
	if(!my_holder)
		return
	my_holder.resolve_conflict()
	

//////////////////////////
/// mob UID management ///

/// The uid associated with the mob, assigned on login / inhabitting of mob
/mob/var/mob_uid = 0
/// theres a prefs uid in the prefs, its used to overwrite whatever the mob_uid is

/datum/controller/subsystem/experience/proc/generate_uid(critterthing, force = FALSE)
	var/datum/preferences/P = extract_prefs(critterthing)
	if(!P)
		return
	if(P.prefs_uid && !force)
		return FALSE
	/// doesnt check if theres a dupe cus the chances of that are astronomically low
	var/randonum = rand(1000000, 9999999)
	var/randomum = "\Roman[rand(1, 100)]"
	var/new_id = "[P.parent.ckey]-" // plus it'd be funny if it happens
	new_id += "[P.real_name || "You"]-" // resolves to "You" if real_name is null, cos || resolves to the first thing it rsolvres
	new_id += "[randonum]-"
	new_id += "[randomum]-"
	new_id += "[ssticker.round_id]-"
	new_id += "[pick(GLOB.megacarp_first_names)]-[pick(GLOB.megacarp_last_names)]-"
	new_id += "[pick(GLOB.cow_names)]-"
	new_id += "the-[pick("PRO","EX","ULTRA","COOL")
	new_id += "ONE" // this generates an ID that's unique to the character, but not necessarily the player
	new_id = ckey(replacetext(new_id, " ", "_"))
	P.prefs_uid = new_id // this will be the key for our ingame data
	// I'll save a different thing as the save file name
	P.xp_directory_name = ckey("[P.real_name || "You"]-[randonum]-[randomum]-[ssticker.round_id]")
	return TRUE

/datum/controller/subsystem/experience/proc/apply_uid_to(me, mob/you)
	if(!me || !you)
		return
	var/datum/preferences/P = extract_prefs(me)
	if(!P)
		return
	if(!P.prefs_uid || !P.xp_directory_name)
		to_chat(you, span_userdanger("Generating a new user ID! If you're seeing this for the first time, cool! Otherwise if you already had one, contact an admin, cus this'll lock out any old data!"))
		if(!generate_uid(me))
			CRASH("Failed to generate a UID for [P.parent.ckey]!")
	you.mob_uid = P.prefs_uid
	load_xp_data(me)





//////////////////////////
/// Holder of EXP data ///
/datum/exp_holder
	var/uid_filename
	var/ckey
	var/list/lvls = list()

/datum/exp_holder/New(ckey, uid_filename)
	. = ..()
	src.ckey = ckey
	src.uid_filename = uid_filename
	for(var/xp in subtypesof(/datum/exp))
		var/datum/exp/my_xp = new xp(ckey, uid)
		lvls[my_xp.key] = my_xp
	var/client/c = ckey2client(ckey)
	if(c) // could be null, this loads every single character's data, whether they're online or not
		to_chat(c, span_greentext("Character data successfully loaded!"))

/datum/exp_holder/proc/adjust_xp(key, amount, list/data = list())
	var/datum/exp/my_xp = LAZYACCESS(lvls, key)
	if(!my_xp)
		return
	my_xp.adjust_xp(amount, data)

/datum/exp_holder/proc/save_to_disk()
	for(var/xp in lvls)
		xp.save_to_disk()

//////////////////////////
/// Individual XP data ///
/datum/exp
	var/name = "Githubber"
	var/verbing = "Calling 1-800-IMC-ODER"
	var/key = XP_DEFAULT
	var/lvl = 0
	var/total_xp = 0
	var/current_xp = 0
	var/highest_xp = 0
	var/next_level_xp = 0
	var/this_level_base_xp = 0
	var/max_level = 1000
	var/uid_filename
	var/ckey

	var/currentround = 0
	var/last_updated = 0
	var/last_saved = 0
	var/dont_save_me = FALSE

	var/today_year = 0
	var/today_month = 0
	var/today_day = 0

/datum/exp/New(ckey, uid_filename)
	. = ..()
	if(!ckey)
		return
	if(!uid_filename)
		return
	src.ckey = ckey
	src.uid_filename = uid_filename
	today_year = text2num(time2text(world.timeofday, "YY"))
	today_month = text2num(time2text(world.timeofday, "MM"))
	today_day = text2num(time2text(world.timeofday, "DD"))
	currentround = ssticker.round_id
	last_updated = round(world.time, 1)
	last_saved = round(world.time, 1)

/// Saves the XP data to a file
/datum/exp/proc/save_to_disk(only_progress)
	var/filepath = "data/exp/current/[ckey]/[uid_filename]/exp-[key].json"
	if(!should_save(filepath))
		return
	var/list/savedata = list()
	savedata["total_xp"] = total_xp
	sa
	savedata[_XPVERIFICATION_FGLAND_KEY] = _XPVERIFICATION_FGLAND_VAL
	savedata[_XPVERIFICATION_BGLAND_KEY] = _XPVERIFICATION_BGLAND_VAL
	var/jsontext = safe_json_encode(savedata)

/// Checks if we should save the file
/// returns TRUE if we should, FALSE if we shouldn't
/datum/exp/proc/should_save(filepath, only_progress)
	if(!fexists(filepack))
		return TRUE // no file, good to save!
	if(dont_save_me)
		return FALSE // something went wrong with saving, lets stop saving until its fixed
	var/now_thisround = ssticker.round_id
	var/now_roundtime = round(world.time, 1)
	var/list/the_save = safe_json_decode(file2text(filepath))
	var/then_thisround = LAZYACCESS(the_save, "currentround")
	var/then_roundtime = LAZYACCESS(the_save, "last_updated")
	if(!then_thisround || !then_roundtime)
		return TRUE // something went wrong with saving, lets save again
	if(then_thisround > now_thisround)
		return FALSE // We're somehow in a previous round, don't save
	if(then_roundtime > now_roundtime)
		return FALSE // We're somehow in the past, don't save
	return TRUE

/// Loads the XP data from a file
/datum/exp/proc/load_exp_file(file_path)
	if(!file_path)
		return
	if(!fexists(file_path))
		return
	if(!findtext(file_path, "exp-") || !findtext(file_path, ".json"))
		CRASH("Invalid EXP file found! [file_path]!!!!!!!!!!")
	var/jsontext = file2text(file_path)
	var/list/savedata = safe_json_decode(jsontext)
	if(!verify_save(savedata))
		CRASH("Empty EXP file found! [file_path]!!!!!!!!!!")
	total_xp = LAZYACCESS(savedata, "total_xp")
	check_level(FALSE)

/// Checks if the contents of the save file are valid
/// okay it just checks if the first and last entries are valid
/// returns nothing if it's valid, returns a backup save file if it's not
/datum/exp/proc/verify_save(list/savedata)
	var/list/verification_can = LAZYACCESS(savedata, _XPVERIFICATION_FGLAND_KEY)
	var/list/verification_juice = LAZYACCESS(savedata, _XPVERIFICATION_BGLAND_KEY)
	if(!LAZYACCESS(verification_can, _XPVERIFICATION_FGLAND_VAL) || !LAZYACCESS(verification_juice, _XPVERIFICATION_BGLAND_VAL))
		message_admins(span_userdanger(("WEEEOOOWEEEOO THE [ckey]'s [type] FILE IS CORRUPTED! IT BAD AND YOU NEED TO FIX IT OR GET DAN TO DO IT!!!!! Feel free to tell this player their hard earned videogame numbers are GONE FOREVER!!!!")))
		var/client/C = ckey2client(ckey)
		to_chat(C, span_userdanger("Your [name] EXP data is corrupted! Contact an admin! This set of XP will not change until it's fixed!"))
		dont_save_me = TRUE // Something went wrong with saving, lets stop saving until its fixed
		return FALSE
	return TRUE

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
	if(!ckey)
		return
	var/mob/M = ckey2mob(ckey)
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




