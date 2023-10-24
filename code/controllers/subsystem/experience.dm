SUBSYSTEM_DEF(experience)
	name = "experience"
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 10 SECONDS

	var/list/all_lvls = list()

	var/my_shark = "broken-ass EXP system that's broken!!!"

	var/backup_slut = 1 // your mom

/datum/controller/subsystem/experience/proc/Initialize(timeofday)
	load_saved_exp()
	. = ..()
	to_chat(world, span_boldannounce("Loaded [LAZYLEN(all_lvls)] characters worth of experience data! (including yours!)"))
	to_chat(world, span_announce("\t(Beware the [my_shark]!)"))

/datum/controller/subsystem/experience/proc/fire(resumed)
	save_loaded_exp()

/datum/controller/subsystem/experience/proc/load_saved_exp()
	if(LAZYLEN(all_lvls))
		var/u_sure = alert(usr, "Are you sure you want to delete the saved EXPs? cus this'll delete em.", "Are you sure?", "YES, reload the EXPs from the most recent save", "No!!!!!")
		if(u_sure == "No!!!!!")
			return
		QDEL_LIST_ASSOC_VAL(all_lvls)
		message_admins("Current EXP list deleted! No guarantees it will be fixed!")
	/// format of the save json thing:
	/* 
		{
			"foregland" : true,
			"roundnum_saved" : 21939,
			"cute_shark" : "Terror shark"
		},
		{
			"ckey" : "superlagg",
			"saves" : {
				"uid1" : {
					"xp_key_1" : xpnum,
					"xp_key_2" : xpnum
				}
			}
		},
			...
		{
			"This saved correctly" : true
		}
	*/
	var/list/save_file = get_save_file()
	decode_save_file(save_file)
	shark()

/datum/controller/subsystem/experience/proc/get_save_file()
	if(!fexists("data/exp/current/master_experience.json"))
		message_admins("No EXP save file found! Creating a new one! =3")
		return make_master_save()
	var/json_save = file2text("data/exp/current/master_experience.json")
	var/list/save_file = json_decode(json_save)
	if(!LAZYLEN(save_file))
		message_admins("No EXP save file found! Creating a new one! =3")
		return make_master_save()
	var/list/banana = verify_save_file(save_file)
	if(LAZYLEN(banana))
		return banana
	return save_file

/datum/controller/subsystem/experience/proc/decode_save_file(list/save_file)
	if(!LAZYLEN(save_file))
		return
	for(var/i in 1 to LAZYLEN(save_file))
		var/list/save = LAZYACCESS(save_file, i)
		if(this_save["foregland"])
			continue
		if(this_save["This saved correctly"])
			continue
		if(!istext(this_save["ckey"]))
			continue
		if(!load_player_exp(this_save["saves"], this_save["ckey"]))
			message_admins("Failed to load EXP for [this_save["ckey"]]!")

/datum/controller/subsystem/experience/proc/load_player_exp(list/save, ckey)
	if(!LAZYLEN(save))
		return TRUE
	var/warned = FALSE
	for(var/uid in save)
		if(LAZYACCESS(all_lvls, uid))
			if(!warned)
				var/mob/player = ckey2mob(ckey)
				if(player)
					to_chat(player, span_alert("The EXP subsystem is trying to load your character data, but it's already loaded! This isnt a problem, just letting you know =3"))
					warned = TRUE
			var/datum/exp_holder/my_holder = LAZYACCESS(all_lvls, uid)
			my_holder.resolve_conflict(save[uid])
			continue
		var/list/xp_data = LAZYACCESS(save, uid)
		var/datum/exp_holder/my_holder = new /datum/exp_holder(ckey, uid, xp_data)
		all_lvls[uid] = my_holder
	var/mob/player = ckey2mob(ckey)
	if(player)
		to_chat(player, span_greentext("Character data successfully loaded!"))
	return TRUE

/// Checks if the contents of the save file are valid
/// okay it just checks if the first and last entries are valid
/// returns nothing if it's valid, returns a backup save file if it's not
/datum/controller/subsystem/experience/proc/verify_save_file(list/save_file)
	var/list/verification_can = LAZYACCESS(save_file, 1)
	var/list/verification_juice = LAZYACCESS(save_file, LAZYLEN(save_file))
	if(!LAZYACCESS(verification_can, "foregland") || !LAZYACCESS(verification_juice, "This saved correctly"))
		message_admins("WEEEOOOWEEEOO THE MASTER EXP FILE IS CORRUPTED! I'M LOADING A BACKUP! Feel free to tell the players their hard earned videogame numbers are GONE FOREVER!!!!")
		return get_backup_save_file()

/datum/controller/subsystem/experience/proc/shark()
	my_shark = "[pick(GLOB.megacarp_first_names)] [pick(GLOB.megacarp_last_names)]"

/datum/controller/subsystem/experience/proc/make_master_save()
	var/list/output = list()
	var/list/headthing = list()
	headthing["foregland"] = TRUE
	headthing["roundnum_saved"] = world.roundnum
	headthing["cute_shark"] = my_shark
	output += list(headthing)
	var/list/footthing = list()
	footthing["This saved correctly"] = TRUE
	output += list(footthing)
	var/json_save = json_encode(output)
	WRITE_FILE("data/exp/current/master_experience.json", json_save)
	message_admins("Okay, I made a new master exp file! =3")

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
/// Holder of EXP data ///
/datum/exp_holder
	var/uid
	var/ckey
	var/list/lvls = list()

/datum/exp_holder/New(ckey, uid, list/lvl_data = list())
	. = ..()
	src.ckey = ckey
	src.uid = uid
	for(var/xp in subtypesof(/datum/exp))
		var/datum/exp/my_xp = new xp(ckey, uid, lvl_data[initial(xp.key)])
		lvls[my_xp.key] = my_xp
	var/client/c = ckey2client(ckey)
	if(c)
		to_chat(c, span_greentext("Character data successfully loaded!"))

/datum/exp_holder/proc/adjust_xp(key, amount, list/data = list())
	var/datum/exp/my_xp = LAZYACCESS(lvls, key)
	if(!my_xp)
		return
	my_xp.adjust_xp(amount, data)

//////////////////////////
/// Individual XP data ///
/datum/exp
	var/name = "Githubber"
	var/verbing = "Calling 1-800-IMC-ODER"
	var/key = XP_DEFAULT
	var/lvl = 0
	var/total_xp = 0
	var/current_xp = 0
	var/next_level_xp = 0
	var/this_level_base_xp = 0
	var/max_level = 1000
	var/uid
	var/ckey

/datum/exp/New(ckey, uid, xp = 0)
	. = ..()
	if(!ckey)
		return
	if(!uid)
		return
	src.ckey = ckey
	src.uid = uid
	src.total_xp = xp
	check_level(FALSE)

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




