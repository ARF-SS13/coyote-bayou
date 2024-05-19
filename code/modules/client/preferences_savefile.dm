//This is the lowest supported version, anything below this is completely obsolete and the entire savefile will be wiped.
#define SAVEFILE_VERSION_MIN	37

//This is the current version, anything below this will attempt to update (if it's not obsolete)
//	You do not need to raise this if you are adding new values that have sane defaults.
//	Only raise this value when changing the meaning/format/name/layout of an existing value
//	where you would want the updater procs below to run
#define SAVEFILE_VERSION_MAX	52

/*
SAVEFILE UPDATING/VERSIONING - 'Simplified', or rather, more coder-friendly ~Carn
	This proc checks if the current directory of the savefile S needs updating
	It is to be used by the load_character and load_preferences procs.
	(S.cd=="/" is preferences, S.cd=="/character[integer]" is a character slot, etc)

	if the current directory's version is below SAVEFILE_VERSION_MIN it will simply wipe everything in that directory
	(if we're at root "/" then it'll just wipe the entire savefile, for instance.)

	if its version is below SAVEFILE_VERSION_MAX but above the minimum, it will load data but later call the
	respective update_preferences() or update_character() proc.
	Those procs allow coders to specify format changes so users do not lose their setups and have to redo them again.

	Failing all that, the standard sanity checks are performed. They simply check the data is suitable, reverting to
	initial() values if necessary.

	Cool system, didnt read, gonna make my own. peace!
		- Lagg
*/
/datum/preferences/proc/savefile_needs_update(savefile/S)
	var/savefile_version
	S["version"] >> savefile_version

	if(savefile_version < SAVEFILE_VERSION_MIN)
		S.dir.Cut()
		return -2
	if(savefile_version < SAVEFILE_VERSION_MAX)
		return savefile_version
	return -1

/datum/preferences/proc/update_revision(savefile/S)
	if(S["current_revision"])
		current_revision = safe_json_decode(S["current_revision"])
	var/list/needs_updating = PREFERENCES_MASTER_REVISIONLIST
	for(var/clog in current_revision)
		needs_updating -= clog
	if(LAZYLEN(needs_updating))
		return update_current(needs_updating, S)

/// Updates things to do with your profile (stuff that goes in save_preferences)
/datum/preferences/proc/update_current(list/missing_updates, savefile/S)
	if(!LAZYLEN(missing_updates))
		current_revision = PREFERENCES_MASTER_REVISIONLIST
		return TRUE
	for(var/clog in missing_updates)
		switch(clog)
			if(PMR_ADDED_RADIO_BLURBLES) // i broke it =3
				S["chat_toggles"] >> chat_toggles
				chat_toggles |= CHAT_HEAR_RADIOBLURBLES
				chat_toggles = sanitize_integer(chat_toggles, 0, INFINITY, TOGGLES_DEFAULT_CHAT)
				current_revision |= PMR_ADDED_RADIO_BLURBLES
			if(PMR_ADDED_RADIO_STATIC) // i broke it =3
				S["chat_toggles"] >> chat_toggles
				chat_toggles |= CHAT_HEAR_RADIOSTATIC
				chat_toggles = sanitize_integer(chat_toggles, 0, INFINITY, TOGGLES_DEFAULT_CHAT)
				current_revision |= PMR_ADDED_RADIO_STATIC
			if(PMR_WHY_DOES_EVERYTHING_DEFAULT_TO_OFF) // i broke it =3
				S["admin_wire_tap"] >> admin_wire_tap
				admin_wire_tap = TRUE
				current_revision |= PMR_WHY_DOES_EVERYTHING_DEFAULT_TO_OFF
			if(PMR_DAN_MESSED_UP_CHATPREFS)
				chat_toggles = TOGGLES_DEFAULT_CHAT
				chat_toggles = sanitize_integer(chat_toggles, 0, INFINITY, TOGGLES_DEFAULT_CHAT)
				WRITE_FILE(S["chat_toggles"], chat_toggles)
				current_revision |= PMR_DAN_MESSED_UP_CHATPREFS
	current_revision = PREFERENCES_MASTER_REVISIONLIST
	WRITE_FILE(S["current_revision"], safe_json_encode(current_revision))
	return TRUE

/datum/preferences/proc/update_save(savefile/S)
	if(S["current_version"])
		current_version = safe_json_decode(S["current_version"])
	var/list/needs_updating = PREFERENCES_MASTER_CHANGELOG
	for(var/clog in current_version)
		needs_updating -= clog
	if(LAZYLEN(needs_updating))
		return update_file(needs_updating, S)

/// Updates things to do with your character (stuff that goes in save_character)
/datum/preferences/proc/update_file(list/missing_updates, savefile/S)
	if(!LAZYLEN(missing_updates))
		return
	for(var/clog in missing_updates)
		switch(clog)
			if(PMC_OOC_NOTES_UPDATE) // ooc notes now come with a cool template
				var/ooc_notes
				S["feature_ooc_notes"] >> ooc_notes
				if(ooc_notes) // close enough
					current_version |= PMC_OOC_NOTES_UPDATE
					continue
				ooc_notes += OOC_NOTE_TEMPLATE
				WRITE_FILE(S["feature_ooc_notes"], ooc_notes)
				current_version |= PMC_OOC_NOTES_UPDATE
			if(PMC_DAN_MESSED_UP_WHO_STUFF)
				// whoflags = DEFAULT_WHO_FLAGS
				// WRITE_FILE(S["whoflags"], whoflags)
				current_version |= PMC_DAN_MESSED_UP_WHO_STUFF // uncomment before release
			if(PMC_PORNHUD_WHITELIST_RELOCATION) // i moved the thing out of features
				// S["feature_genital_whitelist"] >> genital_whitelist
				// if(!islist(genital_whitelist))
				// 	current_version |= PMC_PORNHUD_WHITELIST_RELOCATION
				// 	continue
				// WRITE_FILE(S["genital_whitelist"], genital_whitelist)
				current_version |= PMC_PORNHUD_WHITELIST_RELOCATION
			if(PMC_UNBREAK_FAVORITE_PLAPS) // i broke it =3
				// S["faved_interactions"] >> faved_interactions
				// faved_interactions = list()
				// WRITE_FILE(S["faved_interactions"], faved_interactions)
				current_version |= PMC_UNBREAK_FAVORITE_PLAPS
			if(PMC_MY_PDA_FLIES_IN_FULL_COLOR) // i broke it =3
				pda_skin = "Random!"
				WRITE_FILE(S["pda_skin"], pda_skin)
				current_version |= PMC_MY_PDA_FLIES_IN_FULL_COLOR
			if(PMC_FENNY_FINISHED_124_QUESTS) // i broke it =3
				current_version |= PMC_FENNY_FINISHED_124_QUESTS
				var/list/huge_quest_list = list()
				S["saved_finished_quests"] >> huge_quest_list
				/// first/ back everything up
				saved_finished_quests_old = huge_quest_list
				WRITE_FILE(S["saved_finished_quests_old"], saved_finished_quests_old)
				huge_quest_list = safe_json_decode(huge_quest_list)
				if(!islist(huge_quest_list))
					huge_quest_list = list()
				// for(var/i in 1 to 124) // comment out before release
				// 	var/list/output = list()
				// 	output[QF_QUESTER_NAME]           = "Bungo"
				// 	output[QF_QUEST_TYPE]             = "nothing"
				// 	output[QF_QUEST_NAME]             = "quest_name"
				// 	output[QF_QUEST_DESCRIPTION]      = "bingus"
				// 	output[QF_QUEST_TIME_COMPLETED]   = 59
				// 	output[QF_QUEST_ROUND_ID]         = 59
				// 	output[QF_QUEST_DIFFICULTY]       = text2num(pick(QUEST_DIFFICULTY_EASY, QUEST_DIFFICULTY_MED, QUEST_DIFFICULTY_HARD, QUEST_DIFFICULTY_CBT))
				// 	output[QF_QUEST_REWARDED]         = text2num(rand(1, 1000))
				// 	output[QF_OBJECTIVES]             = list()
				// 	output["VALID"]                   = TRUE // everyone is valid under the toolbox
				// 	huge_quest_list += list(output)
				number_of_finished_quests = LAZYLEN(huge_quest_list)
				var/cashmoney = 0
				var/list/what2save = list()
				what2save["[QUEST_DIFFICULTY_EASY]"] = list()
				what2save["[QUEST_DIFFICULTY_MED]"] = list()
				what2save["[QUEST_DIFFICULTY_HARD]"] = list()
				what2save["[QUEST_DIFFICULTY_CBT]"] = list()
				WRITE_FILE(S["number_of_finished_quests"], number_of_finished_quests)
				for(var/list/fquest in huge_quest_list)
					if(!LAZYACCESS(fquest, "VALID"))
						stack_trace("fquest is not a valid list!!!!!!!!!!!!!!!!!!!!!!!!")
						continue
					var/qdiff = "[fquest[QF_QUEST_DIFFICULTY]]"
					/// now we want to keep only the 4 highest payout quests
					var/payout = text2num(fquest[QF_QUEST_REWARDED])
					cashmoney += payout
					if(LAZYLEN(what2save[qdiff]) < 4)
						what2save[qdiff] += list(fquest)
					else
						for(var/list/quest in what2save[qdiff])
							if(text2num(quest[QF_QUEST_REWARDED]) < payout)
								what2save[qdiff] -= quest
								what2save[qdiff] += list(fquest)
								break
				var/list/wat2save_flat = list()
				/// convert the arselist to a flat list
				for(var/difficulty in what2save)
					for(var/list/quest in what2save[difficulty])
						wat2save_flat += list(quest)
				saved_finished_quests = wat2save_flat.Copy()
				WRITE_FILE(S["saved_finished_quests"], safe_json_encode(saved_finished_quests))
				WRITE_FILE(S["historical_banked_points"], cashmoney)

	current_version = PREFERENCES_MASTER_CHANGELOG
	WRITE_FILE(S["current_version"], safe_json_encode(current_version))
	return TRUE

/datum/preferences/proc/load_path(ckey,filename="preferences.sav")
	if(!ckey)
		return
	path = "data/player_saves/[ckey[1]]/[ckey]/[filename]"
	vr_path = "data/player_saves/[ckey[1]]/[ckey]/vore"
	// TODO: Make bellies save/load to/from a human readable format
	// Shouldnt be too hard to convert the current savefile format to json or txt or something
	// Hopefully everyone's bellies dont get fucked when I do that!

/datum/preferences/proc/load_preferences()
	if(!path)
		return FALSE
	if(world.time < loadprefcooldown)
		if(istype(parent))
			to_chat(parent, span_warning("You're attempting to load your preferences a little too fast. Wait half a second, then try again."))
		return FALSE
	loadprefcooldown = world.time + PREF_SAVELOAD_COOLDOWN
	if(!fexists(path))
		return FALSE

	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"

	var/needs_update = savefile_needs_update(S)
	if(needs_update == -2)		//fatal, can't load any data
		var/bacpath = "[path].updatebac" //todo: if the savefile version is higher then the server, check the backup, and give the player a prompt to load the backup
		if (fexists(bacpath))
			fdel(bacpath) //only keep 1 version of backup
		fcopy(S, bacpath) //byond helpfully lets you use a savefile for the first arg.
		return FALSE
	. = TRUE

	//general preferences
	S["ooccolor"]			>> ooccolor
	S["lastchangelog"]		>> lastchangelog
	S["input_mode_hotkey"]  >> input_mode_hotkey
	S["UI_style"]			>> UI_style
	S["hotkeys"]			>> hotkeys
	S["chat_on_map"]		>> chat_on_map
	S["max_chat_length"]	>> max_chat_length
	S["see_chat_non_mob"]	>> see_chat_non_mob
	READ_FILE(S["see_rc_emotes"] , see_rc_emotes)
	S["color_chat_log"] >> color_chat_log
	S["tgui_fancy"]			>> tgui_fancy
	S["tgui_lock"]			>> tgui_lock
	S["buttons_locked"]		>> buttons_locked
	S["windowflash"]		>> windowflashing
	S["be_special"] 		>> be_special


	S["default_slot"]		>> default_slot
	S["chat_toggles"]		>> chat_toggles
	S["cb_toggles"]			>> cb_toggles
	S["toggles"]			>> toggles
	S["ghost_form"]			>> ghost_form
	S["ghost_orbit"]		>> ghost_orbit
	S["ghost_accs"]			>> ghost_accs
	S["ghost_others"]		>> ghost_others
	S["preferred_map"]		>> preferred_map
	S["ignoring"]			>> ignoring
	S["ghost_hud"]			>> ghost_hud
	S["inquisitive_ghost"]	>> inquisitive_ghost
	S["uses_glasses_colour"]>> uses_glasses_colour
	S["clientfps"]			>> clientfps
	S["parallax"]			>> parallax
	S["ambientocclusion"]	>> ambientocclusion
	S["auto_fit_viewport"]	>> auto_fit_viewport
	S["hud_toggle_flash"]	>> hud_toggle_flash
	S["hud_toggle_color"]	>> hud_toggle_color
	S["menuoptions"]		>> menuoptions
	S["enable_tips"]		>> enable_tips
	S["tip_delay"]			>> tip_delay

	// Custom hotkeys
	S["key_bindings"]		>> key_bindings
	S["modless_key_bindings"]		>> modless_key_bindings

	//citadel code
	S["arousable"]			>> arousable
	S["screenshake"]		>> screenshake
	S["damagescreenshake"]	>> damagescreenshake
	S["widescreenpref"]		>> widescreenpref
	S["end_of_round_deathmatch"] >> end_of_round_deathmatch
	READ_FILE(S["matchmaking_prefs"], matchmaking_prefs)
	S["autostand"]			>> autostand
	S["cit_toggles"]		>> cit_toggles
	S["preferred_chaos"]	>> preferred_chaos
	S["auto_ooc"]			>> auto_ooc
	S["no_tetris_storage"]		>> no_tetris_storage
	S["aghost_squelches"]		>> aghost_squelches
	S["genital_whitelist"]		>> genital_whitelist

	S["lockouts"]	>> lockouts // my bans!
	S["admin_wire_tap"]	>> admin_wire_tap // my bans!


	chat_toggles |= CHAT_LOOC // the LOOC doesn't stop
	//try to fix any outdated data if necessary
	if(needs_update >= 0)
		var/bacpath = "[path].updatebac" //todo: if the savefile version is higher then the server, check the backup, and give the player a prompt to load the backup
		if (fexists(bacpath))
			fdel(bacpath) //only keep 1 version of backup
		fcopy(S, bacpath) //byond helpfully lets you use a savefile for the first arg.
		update_preferences(needs_update, S)		//needs_update = savefile_version if we need an update (positive integer)



	//Sanitize
	ooccolor		= sanitize_ooccolor(sanitize_hexcolor(ooccolor, 6, 1, initial(ooccolor)))
	lastchangelog	= sanitize_text(lastchangelog, initial(lastchangelog))
	genital_whitelist	= sanitize_text(genital_whitelist, initial(genital_whitelist))
	input_mode_hotkey	= sanitize_text(input_mode_hotkey, initial(input_mode_hotkey))
	UI_style		= sanitize_inlist(UI_style, GLOB.available_ui_styles, GLOB.available_ui_styles[1])
	hotkeys			= sanitize_integer(hotkeys, 0, 1, initial(hotkeys))
	chat_on_map		= sanitize_integer(chat_on_map, 0, 1, initial(chat_on_map))
	max_chat_length = sanitize_integer(max_chat_length, 1, CHAT_MESSAGE_MAX_LENGTH, initial(max_chat_length))
	see_chat_non_mob	= sanitize_integer(see_chat_non_mob, 0, 1, initial(see_chat_non_mob))
	see_rc_emotes = sanitize_integer(see_rc_emotes, FALSE, TRUE, initial(see_rc_emotes))
	color_chat_log = sanitize_integer(color_chat_log, FALSE, TRUE, initial(color_chat_log))
	tgui_fancy		= sanitize_integer(tgui_fancy, 0, 1, initial(tgui_fancy))
	tgui_lock		= sanitize_integer(tgui_lock, 0, 1, initial(tgui_lock))
	buttons_locked	= sanitize_integer(buttons_locked, 0, 1, initial(buttons_locked))
	windowflashing		= sanitize_integer(windowflashing, 0, 1, initial(windowflashing))
	default_slot	= sanitize_integer(default_slot, 1, max_save_slots, initial(default_slot))
	toggles			= sanitize_integer(toggles, 0, 16777215, initial(toggles))
	cb_toggles			= sanitize_integer(cb_toggles, 0, 16777215, initial(cb_toggles))
	clientfps		= sanitize_integer(clientfps, 0, 1000, 0)
	parallax		= sanitize_integer(parallax, PARALLAX_INSANE, PARALLAX_DISABLE, null)
	ambientocclusion	= sanitize_integer(ambientocclusion, 0, 1, initial(ambientocclusion))
	auto_fit_viewport	= sanitize_integer(auto_fit_viewport, 0, 1, initial(auto_fit_viewport))
	hud_toggle_flash = sanitize_integer(hud_toggle_flash, 0, 1, initial(hud_toggle_flash))
	hud_toggle_color = sanitize_hexcolor(hud_toggle_color, 6, 1, initial(hud_toggle_color))
	ghost_form		= sanitize_inlist(ghost_form, GLOB.ghost_forms, initial(ghost_form))
	ghost_orbit 	= sanitize_inlist(ghost_orbit, GLOB.ghost_orbits, initial(ghost_orbit))
	ghost_accs		= sanitize_inlist(ghost_accs, GLOB.ghost_accs_options, GHOST_ACCS_DEFAULT_OPTION)
	ghost_others	= sanitize_inlist(ghost_others, GLOB.ghost_others_options, GHOST_OTHERS_DEFAULT_OPTION)
	menuoptions		= SANITIZE_LIST(menuoptions)
	be_special		= SANITIZE_LIST(be_special)
	screenshake			= sanitize_integer(screenshake, 0, 800, initial(screenshake))
	damagescreenshake	= sanitize_integer(damagescreenshake, 0, 2, initial(damagescreenshake))
	widescreenpref		= sanitize_integer(widescreenpref, 0, 1, initial(widescreenpref))
	end_of_round_deathmatch = sanitize_integer(end_of_round_deathmatch, FALSE, TRUE, initial(end_of_round_deathmatch))
	autostand			= sanitize_integer(autostand, 0, 1, initial(autostand))
	cit_toggles			= sanitize_integer(cit_toggles, 0, 16777215, initial(cit_toggles))
	auto_ooc			= sanitize_integer(auto_ooc, 0, 1, initial(auto_ooc))
	lockouts			= sanitize_integer(lockouts, 0, 16777215, 0) // uncomment before release
	no_tetris_storage		= sanitize_integer(no_tetris_storage, 0, 1, initial(no_tetris_storage))
	key_bindings 			= sanitize_islist(key_bindings, list())
	modless_key_bindings 	= sanitize_islist(modless_key_bindings, list())
	aghost_squelches 		= sanitize_islist(aghost_squelches, list())
	admin_wire_tap 		= sanitize_integer(admin_wire_tap, TRUE)

	verify_keybindings_valid()		// one of these days this will runtime and you'll be glad that i put it in a different proc so no one gets their saves wiped

	if(needs_update >= 0) //save the updated version
		var/old_default_slot = default_slot
		var/old_max_save_slots = max_save_slots

		for (var/slot in S.dir) //but first, update all current character slots.
			if (copytext(slot, 1, 10) != "character")
				continue
			var/slotnum = text2num(copytext(slot, 10))
			if (!slotnum)
				continue
			max_save_slots = max(max_save_slots, slotnum) //so we can still update byond member slots after they lose memeber status
			default_slot = slotnum
			if (load_character()) // this updtates char slots
				save_character()
		default_slot = old_default_slot
		max_save_slots = old_max_save_slots
		save_preferences()

	if(update_revision(S))
		save_preferences()

	return TRUE

/datum/preferences/proc/verify_keybindings_valid()
	// Sanitize the actual keybinds to make sure they exist.
	for(var/key in key_bindings)
		if(!islist(key_bindings[key]))
			key_bindings -= key
		var/list/binds = key_bindings[key]
		for(var/bind in binds)
			if(!GLOB.keybindings_by_name[bind])
				binds -= bind
		if(!length(binds))
			key_bindings -= key
	// End
	// I hate copypaste but let's do it again but for modless ones
	for(var/key in modless_key_bindings)
		var/bindname = modless_key_bindings[key]
		if(!GLOB.keybindings_by_name[bindname])
			modless_key_bindings -= key

/datum/preferences/proc/save_preferences()
	if(!path)
		return 0
	if(world.time < saveprefcooldown)
		if(istype(parent))
			to_chat(parent, span_warning("You're attempting to save your preferences a little too fast. Wait half a second, then try again."))
		return 0
	saveprefcooldown = world.time + PREF_SAVELOAD_COOLDOWN
	var/savefile/S = new /savefile(path)
	if(!S)
		return 0
	S.cd = "/"

	WRITE_FILE(S["version"] , SAVEFILE_VERSION_MAX)		//updates (or failing that the sanity checks) will ensure data is not invalid at load. Assume up-to-date

	//general preferences
	WRITE_FILE(S["ooccolor"], ooccolor)
	WRITE_FILE(S["lastchangelog"], lastchangelog)
	WRITE_FILE(S["input_mode_hotkey"], input_mode_hotkey)
	WRITE_FILE(S["UI_style"], UI_style)
	WRITE_FILE(S["hotkeys"], hotkeys)
	WRITE_FILE(S["chat_on_map"], chat_on_map)
	WRITE_FILE(S["max_chat_length"], max_chat_length)
	WRITE_FILE(S["see_chat_non_mob"], see_chat_non_mob)
	WRITE_FILE(S["see_rc_emotes"], see_rc_emotes)
	WRITE_FILE(S["color_chat_log"], color_chat_log)
	WRITE_FILE(S["tgui_fancy"], tgui_fancy)
	WRITE_FILE(S["tgui_lock"], tgui_lock)
	WRITE_FILE(S["buttons_locked"], buttons_locked)
	WRITE_FILE(S["windowflash"], windowflashing)
	WRITE_FILE(S["be_special"], be_special)
	WRITE_FILE(S["default_slot"], default_slot)
	WRITE_FILE(S["toggles"], toggles)
	WRITE_FILE(S["cb_toggles"], cb_toggles)
	WRITE_FILE(S["chat_toggles"], chat_toggles)
	WRITE_FILE(S["ghost_form"], ghost_form)
	WRITE_FILE(S["ghost_orbit"], ghost_orbit)
	WRITE_FILE(S["ghost_accs"], ghost_accs)
	WRITE_FILE(S["ghost_others"], ghost_others)
	WRITE_FILE(S["preferred_map"], preferred_map)
	WRITE_FILE(S["ignoring"], ignoring)
	WRITE_FILE(S["ghost_hud"], ghost_hud)
	WRITE_FILE(S["inquisitive_ghost"], inquisitive_ghost)
	WRITE_FILE(S["uses_glasses_colour"], uses_glasses_colour)
	WRITE_FILE(S["clientfps"], clientfps)
	WRITE_FILE(S["parallax"], parallax)
	WRITE_FILE(S["ambientocclusion"], ambientocclusion)
	WRITE_FILE(S["auto_fit_viewport"], auto_fit_viewport)
	WRITE_FILE(S["hud_toggle_flash"], hud_toggle_flash)
	WRITE_FILE(S["hud_toggle_color"], hud_toggle_color)
	WRITE_FILE(S["menuoptions"], menuoptions)
	WRITE_FILE(S["enable_tips"], enable_tips)
	WRITE_FILE(S["tip_delay"], tip_delay)
	WRITE_FILE(S["pda_style"], pda_style)
	WRITE_FILE(S["pda_color"], pda_color)
	WRITE_FILE(S["pda_skin"], pda_skin)
	WRITE_FILE(S["pda_ringmessage"], pda_ringmessage)
	WRITE_FILE(S["key_bindings"], key_bindings)
	WRITE_FILE(S["modless_key_bindings"], modless_key_bindings)

	//citadel code
	WRITE_FILE(S["screenshake"], screenshake)
	WRITE_FILE(S["damagescreenshake"], damagescreenshake)
	WRITE_FILE(S["arousable"], arousable)
	WRITE_FILE(S["widescreenpref"], widescreenpref)
	WRITE_FILE(S["end_of_round_deathmatch"], end_of_round_deathmatch)
	WRITE_FILE(S["autostand"], autostand)
	WRITE_FILE(S["cit_toggles"], cit_toggles)
	WRITE_FILE(S["preferred_chaos"], preferred_chaos)
	WRITE_FILE(S["auto_ooc"], auto_ooc)
	WRITE_FILE(S["no_tetris_storage"], no_tetris_storage)
	WRITE_FILE(S["lockouts"], lockouts)
	WRITE_FILE(S["aghost_squelches"], aghost_squelches)
	WRITE_FILE(S["genital_whitelist"], genital_whitelist)
	WRITE_FILE(S["admin_wire_tap"], admin_wire_tap)

/datum/preferences/proc/load_character(slot)
	if(!path)
		return FALSE
	if(world.time < loadcharcooldown) //This is before the check to see if the filepath exists to ensure that BYOND can't get hung up on read attempts when the hard drive is a little slow
		if(istype(parent))
			to_chat(parent, span_warning("You're attempting to load your character a little too fast. Wait half a second, then try again."))
		return "SLOW THE FUCK DOWN" //the reason this isn't null is to make sure that people don't have their character slots overridden by random chars if they accidentally double-click a slot
	loadcharcooldown = world.time + PREF_SAVELOAD_COOLDOWN
	if(!fexists(path))
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	features = list(
		"mcolor" = "FFFFFF",
		"mcolor2" = "FFFFFF",
		"mcolor3" = "FFFFFF",
		"tail_lizard" = "Smooth",

		"tail_human" = "None",
		"snout" = "Round",
		"horns" = "None",
		"horns_color" = "85615a",
		"blood_color" = "",
		"ears" = "None",

		"wings" = "None",
		"wings_color" = "FFF",
		"frills" = "None",
		"deco_wings" = "None",
		"spines" = "None",
		"derg_body" = "None",
		"derg_belly" = "None",
		"derg_ears" = "None",
		"derg_mane" = "None",
		"derg_horns" = "None",
		"derg_eyes" = "None",

		"legs" = "Plantigrade",
		"insect_wings" = "Plain",
		"insect_fluff" = "None",
		"insect_markings" = "None",

		"arachnid_legs" = "Plain",
		"arachnid_spinneret" = "Plain",
		"arachnid_mandibles" = "Plain",

		"mam_body_markings" = list(),
		"mam_ears" = "None",
		"mam_snouts" = "None",
		"mam_tail" = "None",

		"mam_tail_animated" = "None",
		"xenodorsal" = "Standard",
		"xenohead" = "Standard",
		"xenotail" = "Xenomorph Tail",

		"taur" = "None",
		"genitals_use_skintone" = FALSE,
		"has_cock" = FALSE,
		"cock_shape" = DEF_COCK_SHAPE,

		"cock_size" = COCK_SIZE_DEF,
		"cock_diameter_ratio" = COCK_DIAMETER_RATIO_DEF,
		"cock_color" = "ffffff",

		"cock_taur" = FALSE,
		"has_balls" = FALSE,
		"balls_color" = "ffffff",
		"balls_shape" = DEF_BALLS_SHAPE,

		"balls_size" = BALLS_SIZE_DEF,
		"balls_cum_rate" = CUM_RATE,
		"balls_cum_mult" = CUM_RATE_MULT,

		"balls_efficiency" = CUM_EFFICIENCY,
		"has_breasts" = FALSE,
		"breasts_color" = "ffffff",

		"has_butt" = FALSE,
		"butt_color" = "ffffff",
		"butt_size" = BUTT_SIZE_DEF,

		"has_belly" = FALSE,
		"belly_color" = "ffffff",
		"belly_size" = BELLY_SIZE_DEF,
		"belly_shape" = DEF_BELLY_SHAPE,

		"breasts_size" = BREASTS_SIZE_DEF,
		"breasts_shape" = DEF_BREASTS_SHAPE,
		"breasts_producing" = FALSE,

		"has_vag" = FALSE,
		"vag_shape" = DEF_VAGINA_SHAPE,
		"vag_color" = "ffffff",
		"has_womb" = FALSE,

		"balls_visibility" = GEN_VISIBLE_NO_UNDIES,
		"breasts_visibility"= GEN_VISIBLE_NO_UNDIES,
		"butt_visibility"  = GEN_VISIBLE_NO_UNDIES,

		"cock_visibility" = GEN_VISIBLE_NO_UNDIES,
		"vag_visibility" = GEN_VISIBLE_NO_UNDIES,

		"balls_visibility_flags" = GEN_VIS_FLAG_DEFAULT,
		"breasts_visibility_flags"= GEN_VIS_FLAG_DEFAULT,
		"cock_visibility_flags" = GEN_VIS_FLAG_DEFAULT,
		"vag_visibility_flags" = GEN_VIS_FLAG_DEFAULT,
		"butt_visibility_flags" = GEN_VIS_FLAG_DEFAULT,
		"belly_visibility_flags" = GEN_VIS_FLAG_DEFAULT,
		"genital_visibility_flags" = GEN_VIS_OVERALL_FLAG_DEFAULT,
		"genital_order" = DEF_COCKSTRING,
		"genital_hide" = NONE,


		"ipc_screen" = "Sunburst",
		"ipc_antenna" = "None",
		"flavor_text" = "",
		"silicon_flavor_text" = "",

		"ooc_notes" = OOC_NOTE_TEMPLATE,
		"background_info_notes" = BACKGROUND_INFO_NOTE_TEMPLATE,
		"meat_type" = "Mammalian",
		"taste" = "something salty",
		"body_model" = MALE,
		"body_size" = RESIZE_DEFAULT_SIZE,
		"body_width" = RESIZE_DEFAULT_SIZE,
		"color_scheme" = OLD_CHARACTER_COLORING,
		"chat_color" = "whoopsie")

	S.cd = "/"
	if(!slot)
		slot = default_slot
	slot = sanitize_integer(slot, 1, max_save_slots, initial(default_slot))
	if(slot != default_slot)
		default_slot = slot
		WRITE_FILE(S["default_slot"] , slot)

	S.cd = "/character[slot]"
	var/needs_update = savefile_needs_update(S)
	if(needs_update == -2)		//fatal, can't load any data
		return FALSE

	. = TRUE

	//Species
	var/species_id
	S["species"]			>> species_id
	if(species_id) // for ass-backwards compatability
		switch(species_id)
			if("avian", "aquatic")
				species_id = "mammal"
			if("moth")
				species_id = "insect"
			if("synthanthro")
				species_id = "synthliz"

		var/newtype = GLOB.species_list[species_id]
		if(newtype)
			pref_species = new newtype


	scars_index = rand(1,5) // WHY

	//Character
	S["real_name"]				>> real_name
	S["custom_species"]			>> custom_species
	S["alt_appearance"]			>> alt_appearance
	S["name_is_always_random"]	>> be_random_name
	S["body_is_always_random"]	>> be_random_body
	S["gender"]					>> gender
	S["tbs"]					>> tbs
	S["kisser"]					>> kisser
	S["body_model"]				>> features["body_model"]
	S["body_size"]				>> features["body_size"]
	S["body_width"]				>> features["body_width"]
	
	//Fuzzy scaling
	S["feature_fuzzy"]          >> fuzzy
	
	S["age"]					>> age
	S["hair_color"]				>> hair_color
	S["facial_hair_color"]		>> facial_hair_color
	S["eye_over_hair"]			>> eye_over_hair
	S["eye_type"]				>> eye_type
	S["left_eye_color"]			>> left_eye_color
	S["right_eye_color"]		>> right_eye_color
	S["use_custom_skin_tone"]	>> use_custom_skin_tone
	S["skin_tone"]				>> skin_tone
	S["hair_style_name"]		>> hair_style
	S["facial_style_name"]		>> facial_hair_style
	S["underwear"]				>> underwear
	S["undie_color"]			>> undie_color
	S["undershirt"]				>> undershirt
	S["shirt_color"]			>> shirt_color
	S["socks"]					>> socks
	S["socks_color"]			>> socks_color
	S["backbag"]				>> backbag
	S["jumpsuit_style"]			>> jumpsuit_style
	S["uplink_loc"]				>> uplink_spawn_loc
	S["custom_speech_verb"]		>> custom_speech_verb
	S["custom_tongue"]			>> custom_tongue
	S["feature_mcolor"]					>> features["mcolor"]
	S["feature_lizard_tail"]			>> features["tail_lizard"]
	S["feature_lizard_snout"]			>> features["snout"]
	S["feature_lizard_horns"]			>> features["horns"]
	S["feature_lizard_frills"]			>> features["frills"]
	S["feature_lizard_spines"]			>> features["spines"]
	S["feature_lizard_legs"]			>> features["legs"]
	S["feature_human_tail"]				>> features["tail_human"]
	S["feature_human_ears"]				>> features["ears"]
	S["feature_deco_wings"]				>> features["deco_wings"]
	S["feature_insect_wings"]			>> features["insect_wings"]
	S["feature_insect_fluff"]			>> features["insect_fluff"]
	S["feature_insect_markings"]		>> features["insect_markings"]
	S["feature_horns_color"]			>> features["horns_color"]
	S["feature_blood_color"]			>> features["blood_color"]
	S["feature_wings_color"]			>> features["wings_color"]
	S["feature_color_scheme"]			>> features["color_scheme"]
	S["feature_chat_color"]				>> features["chat_color"]
	S["feature_derg_body"]				>> features["derg_body"]
	S["feature_derg_belly"]				>> features["derg_belly"]
	S["feature_derg_ears"]				>> features["derg_ears"]
	S["feature_derg_mane"]				>> features["derg_mane"]
	S["feature_derg_horns"]				>> features["derg_horns"]
	S["feature_derg_eyes"]				>> features["derg_eyes"]
	S["feature_custom_say"]				>> features["custom_say"]
	S["feature_custom_whisper"]			>> features["custom_whisper"]
	S["feature_custom_exclaim"]			>> features["custom_exclaim"]
	S["feature_custom_yell"]			>> features["custom_yell"]
	S["feature_custom_sing"]			>> features["custom_sing"]
	S["persistent_scars"] 				>> persistent_scars
	S["scars1"]							>> scars_list["1"]
	S["scars2"]							>> scars_list["2"]
	S["scars3"]							>> scars_list["3"]
	S["scars4"]							>> scars_list["4"]
	S["scars5"]							>> scars_list["5"]
	var/limbmodstr
	S["modified_limbs"] >> limbmodstr
	if(length(limbmodstr))
		modified_limbs = safe_json_decode(limbmodstr)
	else
		modified_limbs = list()
	S["chosen_limb_id"]					>> chosen_limb_id
	S["hide_ckey"]						>> hide_ckey //saved per-character

	//Creature character settings
	S["creature_species"]			>> creature_species
	S["creature_name"]				>> creature_name
	S["creature_flavor_text"]		>> creature_flavor_text
	S["creature_ooc"]				>> creature_ooc
	S["creature_profilepic"]		>> creature_profilepic
	S["creature_pfphost"]			>> creature_pfphost
	//Custom names
	for(var/custom_name_id in GLOB.preferences_custom_names)
		var/savefile_slot_name = custom_name_id + "_name" //TODO remove this
		S[savefile_slot_name] >> custom_names[custom_name_id]

	S["preferred_ai_core_display"]		>> preferred_ai_core_display
	S["prefered_security_department"]	>> prefered_security_department

	//Jobs
	S["joblessrole"]		>> joblessrole

	//Load prefs
	S["job_preferences"]	>> job_preferences

	//Quirks
	S["char_quirks"]			>> char_quirks // renamed so it doesnt destroy old saves in case this needs to be reverted
	S["all_quirks"]				>> all_quirks // untouched, used to migrate quirks

	//Records
	S["security_records"]			>>			security_records
	S["medical_records"]			>>			medical_records

	//Citadel code
	S["feature_mcolor2"]				>> features["mcolor2"]
	S["feature_mcolor3"]				>> features["mcolor3"]
	// note safe json decode will runtime the first time it migrates but this is fine and it solves itself don't worry about it if you see it error
	if (S["feature_mam_body_markings"])
		features["mam_body_markings"] = safe_json_decode(S["feature_mam_body_markings"])
	else
		features["mam_body_markings"] = list()
	S["feature_mam_tail"]				>> features["mam_tail"]
	S["feature_mam_ears"]				>> features["mam_ears"]
	S["feature_mam_tail_animated"]		>> features["mam_tail_animated"]
	S["feature_taur"]					>> features["taur"]
	S["feature_mam_snouts"]				>> features["mam_snouts"]
	S["feature_meat"]					>> features["meat_type"]
	//Xeno features
	S["feature_xeno_tail"]				>> features["xenotail"]
	S["feature_xeno_dors"]				>> features["xenodorsal"]
	S["feature_xeno_head"]				>> features["xenohead"]
	//cock features
	S["feature_has_cock"]				>> features["has_cock"]
	S["feature_cock_shape"]				>> features["cock_shape"]
	S["feature_cock_color"]				>> features["cock_color"]
	S["feature_cock_length"]			>> features["cock_size"] // blame citacode
	S["feature_cock_diameter"]			>> features["cock_diameter"]
	S["feature_cock_taur"]				>> features["cock_taur"]
	S["feature_cock_visibility"]		>> features["cock_visibility"]
	S["feature_cock_visibility_flags"]	>> features["cock_visibility_flags"]
	//balls features
	S["feature_has_balls"]				>> features["has_balls"]
	S["feature_balls_shape"]			>> features["balls_shape"]
	S["feature_balls_color"]			>> features["balls_color"]
	S["feature_balls_size"]				>> features["balls_size"]
	S["feature_balls_visibility"]		>> features["balls_visibility"]
	S["feature_balls_visibility_flags"]	>> features["balls_visibility_flags"]
	//breasts features
	S["feature_has_breasts"]			>> features["has_breasts"]
	S["feature_breasts_size"]			>> features["breasts_size"]
	S["feature_breasts_shape"]			>> features["breasts_shape"]
	S["feature_breasts_color"]			>> features["breasts_color"]
	S["feature_breasts_producing"]		>> features["breasts_producing"]
	S["feature_breasts_visibility"]		>> features["breasts_visibility"]
	S["feature_breasts_visibility_flags"] >> features["breasts_visibility_flags"]
	//butt features
	S["feature_has_butt"] 				>> features["has_butt"]
	S["feature_butt_color"] 			>> features["butt_color"]
	S["feature_butt_size"] 				>> features["butt_size"]
	S["feature_butt_visibility"] 		>> features["butt_visibility"]
	S["feature_butt_visibility_flags"] 		>> features["butt_visibility_flags"]
	//belly features
	S["feature_has_belly"] 				>> features["has_belly"]
	S["feature_belly_color"] 			>> features["belly_color"]
	S["feature_belly_shape"] 			>> features["belly_shape"]
	S["feature_belly_size"] 			>> features["belly_size"]
	S["feature_belly_visibility"] 		>> features["belly_visibility"]
	S["feature_belly_visibility_flags"] >> features["belly_visibility_flags"]
	//vagina features
	S["feature_has_vag"]				>> features["has_vag"]
	S["feature_vag_shape"]				>> features["vag_shape"]
	S["feature_vag_color"]				>> features["vag_color"]
	S["feature_vag_visibility"]			>> features["vag_visibility"]
	S["feature_vag_visibility_flags"]	>> features["vag_visibility_flags"]
	//womb features
	S["feature_has_womb"]				>> features["has_womb"]
	//cockstring
	S["feature_genital_order"]			>> features["genital_order"]
	S["feature_genital_hide"]			>> features["genital_hide"]
	S["feature_genital_visibility_flags"] >> features["genital_visibility_flags"]
	//taste
	S["feature_taste"]					>> features["taste"]

	//flavor text
	//Let's make our players NOT cry desperately as we wipe their savefiles of their special snowflake texts:
	if((S["flavor_text"] != "") && (S["flavor_text"] != null) && S["flavor_text"]) //If old text isn't null and isn't "" but still exists.
		S["flavor_text"]				>> features["flavor_text"] //Load old flavortext as current dna-based flavortext

		WRITE_FILE(S["feature_flavor_text"], features["flavor_text"]) //Save it in our new type of flavor-text
		WRITE_FILE(S["flavor_text"]	, "") //Remove old flavortext, completing the cut-and-paste into the new format.

	else //We have no old flavortext, default to new
		S["feature_flavor_text"]		>> features["flavor_text"]


	S["silicon_feature_flavor_text"]	>> features["silicon_flavor_text"]
	S["feature_ooc_notes"]				>> features["ooc_notes"]
	S["feature_background_info_notes"]	>> features["background_info_notes"]
	S["feature_flist"]					>> features["flist"]
	S["silicon_flavor_text"]			>> features["silicon_flavor_text"]

	//gear loadout
	if(S["loadout"])
		loadout_data = safe_json_decode(S["loadout"])
	else
		loadout_data = list()
	//special
	S["special_s"]			>> special_s
	S["special_p"]			>> special_p
	S["special_e"]			>> special_e
	S["special_c"]			>> special_c
	S["special_i"]			>> special_i
	S["special_a"]			>> special_a
	S["special_l"]			>> special_l
	
	S["custom_pixel_x"]		>> custom_pixel_x
	S["custom_pixel_y"]		>> custom_pixel_y

	S["waddle_amount"]		>> waddle_amount
	S["up_waddle_time"]		>> up_waddle_time
	S["side_waddle_time"]	>> side_waddle_time

	READ_FILE(S["matchmaking_prefs"], matchmaking_prefs)

	// !! COYOTE SAVE FILE STUFF !!
	S["profilePicture"] >> profilePicture // Profile picklies
	S["pfphost"] 		>> pfphost

	S["gradient_color"]		>> features_override["grad_color"] // Hair gradients!
	S["gradient_style"]		>> features_override["grad_style"] // Hair gradients electric boogaloo 2!!
	S["gradient_color_2"]	>> features_override["grad_color_2"] // Hair gradients!
	S["gradient_style_2"]	>> features_override["grad_style_2"] // Hair gradients electric boogaloo 2!!
	S["s_hair_color_2"]		>> features_override["hair_color_2"] // Hair color 2
	S["s_hair_style_2"]		>> features_override["hair_style_2"] // Hair style 2
	S["typing_indicator_sound"]					>> features_speech["typing_indicator_sound"] // Typing sounds!
	S["typing_indicator_sound_play"]			>> features_speech["typing_indicator_sound_play"] // Typing sounds electric- you know what I'm gonna stop its not funny anymore.
	S["typing_indicator_speed"]					>> features_speech["typing_indicator_speed"]
	S["typing_indicator_pitch"]					>> features_speech["typing_indicator_pitch"]
	S["typing_indicator_variance"]				>> features_speech["typing_indicator_variance"]
	S["typing_indicator_volume"]				>> features_speech["typing_indicator_volume"]
	S["typing_indicator_max_words_spoken"]		>> features_speech["typing_indicator_max_words_spoken"]
	S["underwear_overhands"]	>> underwear_overhands // Underwear over hands!
	S["undershirt_overclothes"]	>> undershirt_overclothes // Underwear over hands!
	S["undies_overclothes"]		>> undies_overclothes // Underwear over hands!
	S["socks_overclothes"]		>> socks_overclothes // Underwear over hands!

	S["whoflags"]	>> whoflags // WHo!

	/// Vore stuff!
	S["master_vore_toggle"]					>> master_vore_toggle
	S["vore_smell"]							>> vore_smell
	S["allow_dogborgs"]						>> allow_dogborgs
	S["allow_eating_sounds"]				>> allow_eating_sounds
	S["allow_digestion_sounds"]				>> allow_digestion_sounds
	S["allow_digestion_damage"]				>> allow_digestion_damage
	S["allow_digestion_death"]				>> allow_digestion_death
	S["allow_absorbtion"]					>> allow_absorbtion
	S["allow_healbelly_healing"]			>> allow_healbelly_healing
	S["allow_vore_messages"]				>> allow_vore_messages
	S["allow_death_messages"]				>> allow_death_messages
	S["allow_being_prey"]					>> allow_being_prey
	S["allow_being_fed_to_others"]			>> allow_being_fed_to_others
	S["allow_being_prey"]					>> allow_being_prey
	S["allow_seeing_belly_descriptions"]	>> allow_seeing_belly_descriptions
	S["allow_being_sniffed"]				>> allow_being_sniffed
	S["allow_trash_messages"]				>> allow_trash_messages
	if (S["belly_prefs"])
		belly_prefs = safe_json_decode(S["belly_prefs"])
	else
		belly_prefs = list()

	if (S["current_version"])
		current_version = safe_json_decode(S["current_version"])
	else
		current_version = list()

	//try to fix any outdated data if necessary
	//preference updating will handle saving the updated data for us.
	if(needs_update >= 0)
		update_character(needs_update, S)		//needs_update == savefile_version if we need an update (positive integer)

	//Character directory
	S["show_in_directory"]		>> show_in_directory
	S["directory_tag"]			>> directory_tag
	S["directory_erptag"]			>> directory_erptag
	S["directory_ad"]			>> directory_ad

	//Permanent Tattoos
	S["permanent_tattoos"]		>> permanent_tattoos
	S["dm_open"]		>> dm_open
	S["needs_a_friend"]		>> needs_a_friend
	S["pda_style"]			>> pda_style
	S["pda_color"]			>> pda_color
	S["pda_skin"]			>> pda_skin
	S["pda_ringmessage"]	>> pda_ringmessage

	S["last_quest_login"]	>> last_quest_login

	//Permanent Tattoos
	faved_interactions = safe_json_decode(S["faved_interactions"])
	blocked_from_dms = safe_json_decode(S["blocked_from_dms"])

	/// Test if they have a saved quid, if not, generate one.
	var/saved_quid
	S["quester_uid"] >> saved_quid
	if(!istext(saved_quid)) // no saved quid, generate one
		saved_quid = generate_quester_id()
		if(!istext(saved_quid)) // failed to generate a quid, just use a default
			message_admins("Failed to generate a quester id for [parent.ckey]!!!")
		WRITE_FILE(S["quester_uid"], saved_quid)
	S["quester_uid"] >> quester_uid
	S["saved_unclaimed_points"] >> saved_unclaimed_points
	var/helicopter_precum
	S["saved_finished_quests"] >> helicopter_precum
	saved_finished_quests = safe_json_decode(helicopter_precum)

	var/helicopter_postcum
	S["saved_active_quests"] >> helicopter_postcum
	saved_active_quests = safe_json_decode(helicopter_postcum)
	S["number_of_finished_quests"] >> number_of_finished_quests
	S["historical_banked_points"] >> historical_banked_points

	//sanitize data
	show_in_directory          = sanitize_integer(show_in_directory, 0, 1, initial(show_in_directory))
	directory_tag              = sanitize_inlist(directory_tag, GLOB.char_directory_vore_tags, initial(directory_tag))
	directory_erptag           = sanitize_inlist(directory_erptag, GLOB.char_directory_erptags, initial(directory_erptag))
	directory_ad               = strip_html_simple(directory_ad, MAX_FLAVOR_LEN)
	faved_interactions         = sanitize_islist(faved_interactions, list())
	saved_finished_quests      = sanitize_islist(saved_finished_quests, list())
	saved_active_quests        = sanitize_islist(saved_active_quests, list())
	dm_open                    = sanitize_integer(dm_open, TRUE)
	needs_a_friend             = sanitize_integer(needs_a_friend, TRUE)
	saved_unclaimed_points     = sanitize_integer(saved_unclaimed_points,    0, INFINITY, initial(saved_unclaimed_points))
	number_of_finished_quests  = sanitize_integer(number_of_finished_quests, 0, INFINITY, initial(number_of_finished_quests))
	historical_banked_points   = sanitize_integer(historical_banked_points,  0, INFINITY, initial(historical_banked_points))
	last_quest_login           = sanitize_integer(last_quest_login,          5, INFINITY, world.realtime)


	//Sanitize

	real_name	= reject_bad_name(real_name)
	gender		= sanitize_gender(gender, TRUE, TRUE)
	features["body_model"] = sanitize_gender(features["body_model"], FALSE, FALSE, gender == FEMALE ? FEMALE : MALE)
	if(!real_name)
		real_name	= random_unique_name(gender)
	custom_species	= reject_bad_name(custom_species)
	for(var/custom_name_id in GLOB.preferences_custom_names)
		var/namedata = GLOB.preferences_custom_names[custom_name_id]
		custom_names[custom_name_id] = reject_bad_name(custom_names[custom_name_id],namedata["allow_numbers"])
		if(!custom_names[custom_name_id])
			custom_names[custom_name_id] = get_default_name(custom_name_id)

	be_random_name	= sanitize_integer(be_random_name, 0, 1, initial(be_random_name))
	be_random_body	= sanitize_integer(be_random_body, 0, 1, initial(be_random_body))
	underwear_overhands	= sanitize_integer(underwear_overhands, 0, 1, initial(underwear_overhands))
	undershirt_overclothes	= sanitize_integer(undershirt_overclothes, UNDERWEAR_UNDER_CLOTHES, UNDERWEAR_OVER_EVERYTHING, initial(undershirt_overclothes))
	undies_overclothes	= sanitize_integer(undies_overclothes, UNDERWEAR_UNDER_CLOTHES, UNDERWEAR_OVER_EVERYTHING, initial(undies_overclothes))
	socks_overclothes	= sanitize_integer(socks_overclothes, UNDERWEAR_UNDER_CLOTHES, UNDERWEAR_OVER_EVERYTHING, initial(socks_overclothes))

	hair_style					= sanitize_inlist(hair_style, GLOB.hair_styles_list)
	facial_hair_style			= sanitize_inlist(facial_hair_style, GLOB.facial_hair_styles_list)
	underwear					= sanitize_inlist(underwear, GLOB.underwear_list)
	undershirt 					= sanitize_inlist(undershirt, GLOB.undershirt_list)
	undie_color						= sanitize_hexcolor(undie_color, 6, FALSE, initial(undie_color))
	shirt_color						= sanitize_hexcolor(shirt_color, 6, FALSE, initial(shirt_color))
	socks							= sanitize_inlist(socks, GLOB.socks_list)
	socks_color						= sanitize_hexcolor(socks_color, 6, FALSE, initial(socks_color))
	age								= sanitize_integer(age, AGE_MIN, AGE_MAX, initial(age))
	special_s		= sanitize_integer(special_s, 1, 10, initial(special_s))
	special_p		= sanitize_integer(special_p, 1, 10, initial(special_p))
	special_e		= sanitize_integer(special_e, 1, 10, initial(special_e))
	special_c		= sanitize_integer(special_c, 1, 10, initial(special_c))
	special_i		= sanitize_integer(special_i, 1, 10, initial(special_i))
	special_a		= sanitize_integer(special_a, 1, 10, initial(special_a))
	special_l		= sanitize_integer(special_l, 1, 10, initial(special_l))
	
	custom_pixel_x	= sanitize_integer(custom_pixel_x, PIXELSHIFT_MIN, PIXELSHIFT_MAX, 0)
	custom_pixel_y	= sanitize_integer(custom_pixel_y, PIXELSHIFT_MIN, PIXELSHIFT_MAX, 0)
	
	waddle_amount	= sanitize_num_clamp(waddle_amount, WADDLE_MIN, WADDLE_MAX, 0, 0.1)
	up_waddle_time	= sanitize_num_clamp(up_waddle_time, UP_WADDLE_MIN, UP_WADDLE_MAX, 0, 0.1)
	side_waddle_time = sanitize_num_clamp(side_waddle_time, SIDE_WADDLE_MIN, SIDE_WADDLE_MAX, 0, 0.1)

	hair_color			= sanitize_hexcolor(hair_color, 6, FALSE)
	facial_hair_color	= sanitize_hexcolor(facial_hair_color, 6, FALSE)
	eye_over_hair		= sanitize_integer(eye_over_hair, FALSE, TRUE, initial(eye_over_hair))
	eye_type			= sanitize_inlist(eye_type, GLOB.eye_types, DEFAULT_EYES_TYPE)
	left_eye_color		= sanitize_hexcolor(left_eye_color, 6, FALSE)
	right_eye_color		= sanitize_hexcolor(right_eye_color, 6, FALSE)
	whoflags			= sanitize_integer(whoflags, 0, 16777215, initial(whoflags))
	//whoflags = initial(whoflags) // comment out before release
	pda_style		= sanitize_inlist(pda_style, GLOB.pda_styles, initial(pda_style))
	pda_color		= sanitize_hexcolor(pda_color, 6, 1, initial(pda_color))
	pda_skin		= sanitize_inlist(pda_skin, GLOB.pda_skins, "Random!")
	pda_ringmessage		= sanitize_text(pda_ringmessage, initial(pda_ringmessage))

	var/static/allow_custom_skintones
	if(isnull(allow_custom_skintones))
		allow_custom_skintones = CONFIG_GET(flag/allow_custom_skintones)
	use_custom_skin_tone			= allow_custom_skintones ? sanitize_integer(use_custom_skin_tone, FALSE, TRUE, initial(use_custom_skin_tone)) : FALSE
	if(use_custom_skin_tone)
		skin_tone					= sanitize_hexcolor(skin_tone, 6, TRUE, "#FFFFFF")
	else
		skin_tone					= sanitize_inlist(skin_tone, GLOB.skin_tones - GLOB.nonstandard_skin_tones, initial(skin_tone))

	features["horns_color"]			= sanitize_hexcolor(features["horns_color"], 6, FALSE, "85615a")
	if(!isnull(features["blood_color"]) && features["blood_color"] != "")
		//if(features["blood_color"] == "rainbow")
		features["blood_color"]			= sanitize_hexcolor(features["blood_color"], 6, FALSE, "900000")
	features["wings_color"]			= sanitize_hexcolor(features["wings_color"], 6, FALSE, "FFFFFF")
	backbag							= sanitize_inlist(backbag, GLOB.backbaglist, initial(backbag))
	jumpsuit_style					= sanitize_inlist(jumpsuit_style, GLOB.jumpsuitlist, initial(jumpsuit_style))
	uplink_spawn_loc				= sanitize_inlist(uplink_spawn_loc, GLOB.uplink_spawn_loc_list, initial(uplink_spawn_loc))
	features["mcolor"]				= sanitize_hexcolor(features["mcolor"], 6, FALSE)
	features["tail_lizard"]			= sanitize_inlist(features["tail_lizard"], GLOB.tails_list_lizard)
	features["tail_human"]			= sanitize_inlist(features["tail_human"], GLOB.tails_list_human)
	features["snout"]				= sanitize_inlist(features["snout"], GLOB.snouts_list)
	features["horns"]				= sanitize_inlist(features["horns"], GLOB.horns_list)
	features["ears"]				= sanitize_inlist(features["ears"], GLOB.ears_list)
	features["frills"]				= sanitize_inlist(features["frills"], GLOB.frills_list)
	features["spines"]				= sanitize_inlist(features["spines"], GLOB.spines_list)
	features["legs"]				= sanitize_inlist(features["legs"], GLOB.legs_list, "Plantigrade")
	features["deco_wings"] 			= sanitize_inlist(features["deco_wings"], GLOB.deco_wings_list, "None")
	features["insect_fluff"]		= sanitize_inlist(features["insect_fluff"], GLOB.insect_fluffs_list)
	features["insect_markings"] 	= sanitize_inlist(features["insect_markings"], GLOB.insect_markings_list, "None")
	features["insect_wings"] 		= sanitize_inlist(features["insect_wings"], GLOB.insect_wings_list)
	features["derg_body"] 			= sanitize_inlist(features["derg_body"], GLOB.derg_body_list, "Smooth Dragon Body")
	features["derg_belly"] 			= sanitize_inlist(features["derg_belly"], GLOB.derg_belly_list, "Dragon Under Smooth")
	features["derg_horns"] 			= sanitize_inlist(features["derg_horns"], GLOB.derg_horn_list)
	features["derg_mane"] 			= sanitize_inlist(features["derg_mane"], GLOB.derg_mane_list)
	features["derg_ears"] 			= sanitize_inlist(features["derg_ears"], GLOB.derg_ear_list)
	features["derg_eyes"] 			= sanitize_inlist(features["derg_eyes"], GLOB.derg_ear_list)

	alt_appearance					= sanitize_inlist(alt_appearance, pref_species.alt_prefixes, "Default")

	var/static/size_min
	if(!size_min)
		size_min = CONFIG_GET(number/body_size_min)
	var/static/size_max
	if(!size_max)
		size_max = CONFIG_GET(number/body_size_max)
	features["body_size"]			= sanitize_num_clamp(features["body_size"], size_min, size_max, RESIZE_DEFAULT_SIZE, 0.01)

	var/static/width_min
	if(!width_min)
		width_min = CONFIG_GET(number/body_width_min)
	var/static/width_max
	if(!width_max)
		width_max = CONFIG_GET(number/body_width_max)
	features["body_width"]			= sanitize_num_clamp(features["body_width"], width_min, width_max, RESIZE_DEFAULT_SIZE, 0.01)

	fuzzy 							= sanitize_integer(fuzzy, 0, 1, initial(fuzzy))

	var/static/list/B_sizes
	if(!B_sizes)
		var/list/L = CONFIG_GET(keyed_list/breasts_cups_prefs)
		B_sizes = L.Copy()
	var/static/min_D
	if(!min_D)
		min_D = CONFIG_GET(number/penis_min_inches_prefs)
	var/static/max_D
	if(!max_D)
		max_D = CONFIG_GET(number/penis_max_inches_prefs)
	var/static/min_B
	if(!min_B)
		min_B = CONFIG_GET(number/butt_min_size_prefs)
	var/static/max_B
	if(!max_B)
		max_B = CONFIG_GET(number/butt_max_size_prefs)
	var/static/min_O
	if(!min_O)
		min_O = CONFIG_GET(number/belly_min_size_prefs)
	var/static/max_O
	if(!max_O)
		max_O = CONFIG_GET(number/belly_max_size_prefs)
	var/static/safe_visibilities
	if(!safe_visibilities)
		var/list/L = CONFIG_GET(keyed_list/safe_visibility_toggles)
		safe_visibilities = L.Copy()

	features["breasts_size"]		= sanitize_inlist(features["breasts_size"], B_sizes, BREASTS_SIZE_DEF)
	features["cock_size"]			= sanitize_integer(features["cock_size"], min_D, max_D, COCK_SIZE_DEF)
	features["butt_size"] 			= sanitize_integer(features["butt_size"], min_B, max_B, BUTT_SIZE_DEF)
	features["belly_size"] 			= sanitize_integer(features["belly_size"], min_O, max_O, BELLY_SIZE_DEF)
	features["breasts_shape"]		= sanitize_inlist(features["breasts_shape"], GLOB.breasts_shapes_list, DEF_BREASTS_SHAPE)
	features["belly_shape"]			= sanitize_inlist(features["belly_shape"], GLOB.belly_shapes_list, DEF_BELLY_SHAPE)
	features["cock_shape"]			= sanitize_inlist(features["cock_shape"], GLOB.cock_shapes_list, DEF_COCK_SHAPE)
	features["balls_shape"]			= sanitize_inlist(features["balls_shape"], GLOB.balls_shapes_list, DEF_BALLS_SHAPE)
	features["vag_shape"]			= sanitize_inlist(features["vag_shape"], GLOB.vagina_shapes_list, DEF_VAGINA_SHAPE)
	features["butt_color"]			= sanitize_hexcolor(features["butt_color"], 6, FALSE, "FFFFFF")
	features["belly_color"]			= sanitize_hexcolor(features["belly_color"], 6, FALSE, "FFFFFF")
	features["breasts_color"]		= sanitize_hexcolor(features["breasts_color"], 6, FALSE, "FFFFFF")
	features["cock_color"]			= sanitize_hexcolor(features["cock_color"], 6, FALSE, "FFFFFF")
	features["balls_color"]			= sanitize_hexcolor(features["balls_color"], 6, FALSE, "FFFFFF")
	features["vag_color"]			= sanitize_hexcolor(features["vag_color"], 6, FALSE, "FFFFFF")
	features["butt_visibility"] 	= sanitize_inlist(features["butt_visibility"], safe_visibilities, GEN_VISIBLE_NO_UNDIES)
	features["belly_visibility"]	= sanitize_inlist(features["breasts_visibility"], safe_visibilities, GEN_VISIBLE_NO_UNDIES)
	features["breasts_visibility"]	= sanitize_inlist(features["breasts_visibility"], safe_visibilities, GEN_VISIBLE_NO_UNDIES)
	features["cock_visibility"]		= sanitize_inlist(features["cock_visibility"], safe_visibilities, GEN_VISIBLE_NO_UNDIES)
	features["balls_visibility"]	= sanitize_inlist(features["balls_visibility"], safe_visibilities, GEN_VISIBLE_NO_UNDIES)
	features["vag_visibility"]		= sanitize_inlist(features["vag_visibility"], safe_visibilities, GEN_VISIBLE_NO_UNDIES)
	features["butt_visibility_flags"] 		= sanitize_integer(features["butt_visibility_flags"], GENITAL_FLAGS_MIN, GENITAL_FLAGS_MAX, GEN_VIS_FLAG_DEFAULT)
	features["belly_visibility_flags"]		= sanitize_integer(features["breasts_visibility_flags"], GENITAL_FLAGS_MIN, GENITAL_FLAGS_MAX, GEN_VIS_FLAG_DEFAULT)
	features["breasts_visibility_flags"]	= sanitize_integer(features["breasts_visibility_flags"], GENITAL_FLAGS_MIN, GENITAL_FLAGS_MAX, GEN_VIS_FLAG_DEFAULT)
	features["cock_visibility_flags"]		= sanitize_integer(features["cock_visibility_flags"], GENITAL_FLAGS_MIN, GENITAL_FLAGS_MAX, GEN_VIS_FLAG_DEFAULT)
	features["balls_visibility_flags"]		= sanitize_integer(features["balls_visibility_flags"], GENITAL_FLAGS_MIN, GENITAL_FLAGS_MAX, GEN_VIS_FLAG_DEFAULT)
	features["vag_visibility_flags"]		= sanitize_integer(features["vag_visibility_flags"], GENITAL_FLAGS_MIN, GENITAL_FLAGS_MAX, GEN_VIS_FLAG_DEFAULT)
	features["genital_visibility_flags"]	= sanitize_integer(features["genital_visibility_flags"], GENITAL_FLAGS_MIN, GENITAL_FLAGS_MAX, GEN_VIS_OVERALL_FLAG_DEFAULT)

	custom_speech_verb				= sanitize_inlist(custom_speech_verb, GLOB.speech_verbs, "default")
	custom_tongue					= sanitize_inlist(custom_tongue, GLOB.roundstart_tongues, "default")

	security_records				= copytext(security_records, 1, MAX_FLAVOR_LEN)
	medical_records					= copytext(medical_records, 1, MAX_FLAVOR_LEN)

	features["genital_order"]		= sanitize_text(features["genital_order"], DEF_COCKSTRING)
	features["genital_hide"]		= sanitize_integer(features["genital_hide"], 0, 4096, 0)
	features["taste"]				= copytext(features["taste"], 1, MAX_TASTE_LEN)
	features["flavor_text"]			= copytext(features["flavor_text"], 1, MAX_FLAVOR_LEN)
	features["silicon_flavor_text"]	= copytext(features["silicon_flavor_text"], 1, MAX_FLAVOR_LEN)
	features["ooc_notes"]			= copytext(features["ooc_notes"], 1, MAX_FLAVOR_LEN)
	if(features["ooc_notes"] == "")
		features["ooc_notes"] = OOC_NOTE_TEMPLATE
		WRITE_FILE(S["feature_ooc_notes"], features["ooc_notes"])

	features["background_info_notes"]			= copytext(features["background_info_notes"], 1, MAX_FLAVOR_LEN)
	if(features["background_info_notes"] == "")
		features["background_info_notes"] = BACKGROUND_INFO_NOTE_TEMPLATE
		WRITE_FILE(S["feature_background_info_notes"], features["background_info_notes"])

	/// VORE SANITIZATION - tab 4 or suffer
	vore_smell						= sanitize_integer(vore_smell, 						FALSE, TRUE, initial(vore_smell))
	master_vore_toggle				= sanitize_integer(master_vore_toggle, 				FALSE, TRUE, initial(master_vore_toggle))
	allow_dogborgs					= sanitize_integer(allow_dogborgs, 					FALSE, TRUE, initial(allow_dogborgs))
	allow_eating_sounds				= sanitize_integer(allow_eating_sounds, 			FALSE, TRUE, initial(allow_eating_sounds))
	allow_digestion_sounds			= sanitize_integer(allow_digestion_sounds, 			FALSE, TRUE, initial(allow_digestion_sounds))
	allow_digestion_damage			= sanitize_integer(allow_digestion_damage, 			FALSE, TRUE, initial(allow_digestion_damage))
	allow_digestion_death			= sanitize_integer(allow_digestion_death, 			FALSE, TRUE, initial(allow_digestion_death))
	allow_absorbtion				= sanitize_integer(allow_absorbtion, 				FALSE, TRUE, initial(allow_absorbtion))
	allow_healbelly_healing			= sanitize_integer(allow_healbelly_healing, 		FALSE, TRUE, initial(allow_healbelly_healing))
	allow_vore_messages				= sanitize_integer(allow_vore_messages, 			FALSE, TRUE, initial(allow_vore_messages))
	allow_death_messages			= sanitize_integer(allow_death_messages,			FALSE, TRUE, initial(allow_death_messages))
	allow_being_prey				= sanitize_integer(allow_being_prey, 				FALSE, TRUE, initial(allow_being_prey))
	allow_being_fed_to_others		= sanitize_integer(allow_being_fed_to_others, 		FALSE, TRUE, initial(allow_being_fed_to_others))
	allow_being_prey				= sanitize_integer(allow_being_prey, 				FALSE, TRUE, initial(allow_being_prey))
	allow_seeing_belly_descriptions	= sanitize_integer(allow_seeing_belly_descriptions, FALSE, TRUE, initial(allow_seeing_belly_descriptions))
	allow_being_sniffed				= sanitize_integer(allow_being_sniffed, 			FALSE, TRUE, initial(allow_being_sniffed))
	allow_trash_messages			= sanitize_integer(allow_trash_messages, 			FALSE, TRUE, initial(allow_trash_messages))

	//load every advanced coloring mode thing in one go
	//THIS MUST BE DONE AFTER ALL FEATURE SAVES OR IT WILL NOT WORK
	for(var/feature in features)
		var/feature_value = features[feature]
		if(feature_value)
			var/ref_list = GLOB.mutant_reference_list[feature]
			if(ref_list)
				var/datum/sprite_accessory/accessory = ref_list[feature_value]
				if(accessory)
					var/mutant_string = accessory.mutant_part_string
					if(!mutant_string)
						if(istype(accessory, /datum/sprite_accessory/mam_body_markings))
							mutant_string = "mam_body_markings"
					var/primary_string = "[mutant_string]_primary"
					var/secondary_string = "[mutant_string]_secondary"
					var/tertiary_string = "[mutant_string]_tertiary"
					if(accessory.color_src == MATRIXED && !accessory.matrixed_sections && feature_value != "None")
						message_admins("Sprite Accessory Failure (loading data): Accessory [accessory.type] is a matrixed item without any matrixed sections set!")
						continue
					if(S["feature_[primary_string]"])
						S["feature_[primary_string]"]		>> features[primary_string]
					if(S["feature_[secondary_string]"])
						S["feature_[secondary_string]"]		>> features[secondary_string]
					if(S["feature_[tertiary_string]"])
						S["feature_[tertiary_string]"]		>> features[tertiary_string]

	persistent_scars = sanitize_integer(persistent_scars)
	scars_list["1"] = sanitize_text(scars_list["1"])
	scars_list["2"] = sanitize_text(scars_list["2"])
	scars_list["3"] = sanitize_text(scars_list["3"])
	scars_list["4"] = sanitize_text(scars_list["4"])
	scars_list["5"] = sanitize_text(scars_list["5"])

	// !! COYOTE SANITISATION !!
	profilePicture 		= sanitize_text(profilePicture) // If we still have issues loading save files with this then comment this out, IT SHOULD BE A STRING REEEE
	pfphost 			= sanitize_inlist(pfphost, GLOB.pfp_filehosts, "")
	creature_profilepic = sanitize_text(creature_profilepic)
	creature_pfphost 	= sanitize_inlist(creature_pfphost, GLOB.pfp_filehosts, "")

	features_override["grad_color"]		= sanitize_hexcolor(features_override["grad_color"], 6, FALSE, default = COLOR_ALMOST_BLACK)
	features_override["grad_style"]		= sanitize_inlist(features_override["grad_style"], GLOB.hair_gradients, "none")

	features_override["grad_color_2"]		= sanitize_hexcolor(features_override["grad_color_2"], 6, FALSE, default = COLOR_ALMOST_BLACK)
	features_override["grad_style_2"]		= sanitize_inlist(features_override["grad_style_2"], GLOB.hair_gradients, "none")

	features_override["hair_color_2"]	= sanitize_hexcolor(features_override["hair_color_2"], 6, FALSE, default = COLOR_ALMOST_BLACK)
	features_override["hair_style_2"]	= sanitize_inlist(features_override["hair_style_2"], GLOB.hair_styles_list, "Bald")
	
	if(!LAZYLEN(GLOB.typing_sounds))
		SStypinginit.populate_typing_list()//This list is initialized late, so if a savefile is saved during initialization (they almost always are), they might lose their sound selection. Manually populate it early, in that case.
	features_speech["typing_indicator_sound"]				= sanitize_inlist(features_speech["typing_indicator_sound"], GLOB.typing_sounds, "Default")//
	features_speech["typing_indicator_sound_play"]			= sanitize_inlist(features_speech["typing_indicator_sound_play"], GLOB.play_methods, "No Sound")
	features_speech["typing_indicator_speed"]				= sanitize_inlist(features_speech["typing_indicator_speed"], GLOB.typing_indicator_speeds, "Speed: Average (2)")
	features_speech["typing_indicator_pitch"]				= sanitize_inlist(features_speech["typing_indicator_pitch"], GLOB.typing_indicator_pitches, "Pitch: Average (2)")
	features_speech["typing_indicator_variance"]			= sanitize_inlist(features_speech["typing_indicator_variance"], GLOB.typing_indicator_variances, "Tone: Varies a little (2)")
	features_speech["typing_indicator_volume"]				= sanitize_inlist(features_speech["typing_indicator_volume"], GLOB.typing_indicator_volumes, "Volume: Average (2)")
	features_speech["typing_indicator_max_words_spoken"]	= sanitize_inlist(features_speech["typing_indicator_max_words_spoken"], GLOB.typing_indicator_max_words_spoken_list, "Max words spoken: 4")

	joblessrole	= sanitize_integer(joblessrole, 1, 3, initial(joblessrole))
	//Validate job prefs
	for(var/j in job_preferences)
		if(job_preferences["[j]"] != JP_LOW && job_preferences["[j]"] != JP_MEDIUM && job_preferences["[j]"] != JP_HIGH)
			job_preferences -= j

	char_quirks = SANITIZE_LIST(char_quirks)
	if(SSquirks.debug_migration)
		current_version -= PMC_QUIRK_OVERHAUL_2K23
		var/list/debug_oldies = list(
			"Jack Penis", // to test how it handles bullshit quirks
			"/datum/quirk/furry", // to test how it handles key quirks
			"Straight Shooter", // gonna load in a shitload of positive quirks, to see if it'll reject bad values
			"Clawer - Razors",
			"Improved Innate Healing",
			"Minor Surgery",
			"Fists of Steel",
			"Health - Tough",
			"Health - Tough",
			"Health - Tough",
			"Health - Tough", // see if it handles multiple quirks of the same type
			"Brain Tumor",
			"Nearsighted - Trashed Vision",
			"Pacifist",
			"Phobia - Doctors",
			"Monophobia",
			"Mobility - Can not Run",
		)
		WRITE_FILE(S["all_quirks"], debug_oldies)
	
	WRITE_FILE(S["feature_fuzzy"], fuzzy)

	matchmaking_prefs = sanitize_matchmaking_prefs(matchmaking_prefs)

	cit_character_pref_load(S)

	// permanent tattoos
	permanent_tattoos = sanitize_text(permanent_tattoos)
	if(update_save(S))
		save_character()


	return 1

/datum/preferences/proc/save_character()
	if(!path)
		return 0
	if(world.time < savecharcooldown)
		//if(istype(parent))
			//to_chat(parent, span_warning("You're attempting to save your character a little too fast. Wait half a second, then try again."))
		return 0
	SSquirks.CheckAndVerifyPrefQuirks(src, FALSE)
	savecharcooldown = world.time + PREF_SAVELOAD_COOLDOWN
	var/savefile/S = new /savefile(path)
	if(!S)
		return 0
	S.cd = "/character[default_slot]"

	WRITE_FILE(S["version"]			, SAVEFILE_VERSION_MAX)	//load_character will sanitize any bad data, so assume up-to-date.)

	//Character
	WRITE_FILE(S["real_name"]				, real_name)
	WRITE_FILE(S["custom_species"]			, custom_species)
	WRITE_FILE(S["alt_appearance"]			, alt_appearance)
	WRITE_FILE(S["name_is_always_random"]	, be_random_name)
	WRITE_FILE(S["body_is_always_random"]	, be_random_body)
	WRITE_FILE(S["gender"]					, gender)
	WRITE_FILE(S["tbs"]						, tbs)
	WRITE_FILE(S["kisser"]					, kisser)
	WRITE_FILE(S["body_model"]				, features["body_model"])
	WRITE_FILE(S["body_size"]				, features["body_size"])
	WRITE_FILE(S["body_width"]				, features["body_width"])
	WRITE_FILE(S["age"]						, age)
	WRITE_FILE(S["hair_color"]				, hair_color)
	WRITE_FILE(S["facial_hair_color"]		, facial_hair_color)
	WRITE_FILE(S["eye_type"]				, eye_type)
	WRITE_FILE(S["eye_over_hair"]			, eye_over_hair)
	WRITE_FILE(S["left_eye_color"]			, left_eye_color)
	WRITE_FILE(S["right_eye_color"]			, right_eye_color)
	WRITE_FILE(S["use_custom_skin_tone"]	, use_custom_skin_tone)
	WRITE_FILE(S["skin_tone"]				, skin_tone)
	WRITE_FILE(S["hair_style_name"]			, hair_style)
	WRITE_FILE(S["facial_style_name"]		, facial_hair_style)
	WRITE_FILE(S["underwear"]				, underwear)
	WRITE_FILE(S["undie_color"]				, undie_color)
	WRITE_FILE(S["undershirt"]				, undershirt)
	WRITE_FILE(S["shirt_color"]				, shirt_color)
	WRITE_FILE(S["socks"]					, socks)
	WRITE_FILE(S["socks_color"]				, socks_color)
	WRITE_FILE(S["backbag"]					, backbag)
	WRITE_FILE(S["jumpsuit_style"]			, jumpsuit_style)
	WRITE_FILE(S["uplink_loc"]				, uplink_spawn_loc)
	WRITE_FILE(S["species"]					, pref_species.id)
	WRITE_FILE(S["custom_speech_verb"]		, custom_speech_verb)
	WRITE_FILE(S["custom_tongue"]			, custom_tongue)

	// records
	WRITE_FILE(S["security_records"]		, security_records)
	WRITE_FILE(S["medical_records"]			, medical_records)

	WRITE_FILE(S["feature_mcolor"]					, features["mcolor"])
	WRITE_FILE(S["feature_lizard_tail"]				, features["tail_lizard"])
	WRITE_FILE(S["feature_human_tail"]				, features["tail_human"])
	WRITE_FILE(S["feature_lizard_snout"]			, features["snout"])
	WRITE_FILE(S["feature_lizard_horns"]			, features["horns"])
	WRITE_FILE(S["feature_human_ears"]				, features["ears"])
	WRITE_FILE(S["feature_lizard_frills"]			, features["frills"])
	WRITE_FILE(S["feature_lizard_spines"]			, features["spines"])
	WRITE_FILE(S["feature_lizard_legs"]				, features["legs"])
	WRITE_FILE(S["feature_deco_wings"]				, features["deco_wings"])
	WRITE_FILE(S["feature_horns_color"]				, features["horns_color"])
	WRITE_FILE(S["feature_blood_color"]				, features["blood_color"])
	WRITE_FILE(S["feature_wings_color"]				, features["wings_color"])
	WRITE_FILE(S["feature_insect_wings"]			, features["insect_wings"])
	WRITE_FILE(S["feature_insect_fluff"]			, features["insect_fluff"])
	WRITE_FILE(S["feature_insect_markings"]			, features["insect_markings"])
	WRITE_FILE(S["feature_meat"]					, features["meat_type"])
	WRITE_FILE(S["feature_derg_body"]				, features["derg_body"])
	WRITE_FILE(S["feature_derg_belly"]				, features["derg_belly"])
	WRITE_FILE(S["feature_derg_ears"]				, features["derg_ears"])
	WRITE_FILE(S["feature_derg_mane"]				, features["derg_mane"])
	WRITE_FILE(S["feature_derg_horns"]				, features["derg_horns"])
	WRITE_FILE(S["feature_derg_eyes"]				, features["derg_eyes"])
	WRITE_FILE(S["feature_custom_say"]				, features["custom_say"])
	WRITE_FILE(S["feature_custom_whisper"]			, features["custom_whisper"])
	WRITE_FILE(S["feature_custom_exclaim"]			, features["custom_exclaim"])
	WRITE_FILE(S["feature_custom_yell"]				, features["custom_yell"])
	WRITE_FILE(S["feature_custom_sing"]				, features["custom_sing"])


	WRITE_FILE(S["feature_has_cock"], features["has_cock"])
	WRITE_FILE(S["feature_cock_shape"], features["cock_shape"])
	WRITE_FILE(S["feature_cock_color"], features["cock_color"])
	WRITE_FILE(S["feature_cock_length"], features["cock_size"])
	WRITE_FILE(S["feature_cock_taur"], features["cock_taur"])
	WRITE_FILE(S["feature_cock_visibility"], features["cock_visibility"])
	WRITE_FILE(S["feature_cock_visibility_flags"], features["cock_visibility_flags"])

	WRITE_FILE(S["feature_has_balls"], features["has_balls"])
	WRITE_FILE(S["feature_balls_shape"], features["balls_shape"])
	WRITE_FILE(S["feature_balls_color"], features["balls_color"])
	WRITE_FILE(S["feature_balls_size"], features["balls_size"])
	WRITE_FILE(S["feature_balls_visibility"], features["balls_visibility"])
	WRITE_FILE(S["feature_balls_visibility_flags"], features["balls_visibility_flags"])

	WRITE_FILE(S["feature_has_breasts"], features["has_breasts"])
	WRITE_FILE(S["feature_breasts_size"], features["breasts_size"])
	WRITE_FILE(S["feature_breasts_shape"], features["breasts_shape"])
	WRITE_FILE(S["feature_breasts_color"], features["breasts_color"])
	WRITE_FILE(S["feature_breasts_producing"], features["breasts_producing"])
	WRITE_FILE(S["feature_breasts_visibility"], features["breasts_visibility"])
	WRITE_FILE(S["feature_breasts_visibility_flags"], features["breasts_visibility_flags"])

	WRITE_FILE(S["feature_has_butt"], features["has_butt"])
	WRITE_FILE(S["feature_butt_color"], features["butt_color"])
	WRITE_FILE(S["feature_butt_size"], features["butt_size"])
	WRITE_FILE(S["feature_butt_visibility"], features["butt_visibility"])
	WRITE_FILE(S["feature_butt_visibility_flags"], features["butt_visibility_flags"])

	WRITE_FILE(S["feature_has_belly"], features["has_belly"])
	WRITE_FILE(S["feature_belly_color"], features["belly_color"])
	WRITE_FILE(S["feature_belly_size"], features["belly_size"])
	WRITE_FILE(S["feature_belly_shape"], features["belly_shape"])
	WRITE_FILE(S["feature_belly_visibility"], features["belly_visibility"])
	WRITE_FILE(S["feature_belly_visibility_flags"], features["belly_visibility_flags"])
	WRITE_FILE(S["feature_genital_order"], features["genital_order"])
	WRITE_FILE(S["feature_genital_hide"], features["genital_hide"])
	WRITE_FILE(S["feature_genital_visibility_flags"], features["genital_visibility_flags"])

	WRITE_FILE(S["feature_has_vag"], features["has_vag"])
	WRITE_FILE(S["feature_vag_shape"], features["vag_shape"])
	WRITE_FILE(S["feature_vag_color"], features["vag_color"])
	WRITE_FILE(S["feature_vag_visibility"], features["vag_visibility"])
	WRITE_FILE(S["feature_vag_visibility_flags"], features["vag_visibility_flags"])

	WRITE_FILE(S["feature_has_womb"], features["has_womb"])

	WRITE_FILE(S["feature_ooc_notes"], features["ooc_notes"])

	WRITE_FILE(S["feature_background_info_notes"], features["background_info_notes"])

	WRITE_FILE(S["feature_flist"], features["flist"])

	WRITE_FILE(S["feature_taste"], features["taste"])
	WRITE_FILE(S["dm_open"], dm_open)
	WRITE_FILE(S["needs_a_friend"], needs_a_friend)

	//special
	WRITE_FILE(S["special_s"]		,special_s)
	WRITE_FILE(S["special_p"]		,special_p)
	WRITE_FILE(S["special_e"]		,special_e)
	WRITE_FILE(S["special_c"]		,special_c)
	WRITE_FILE(S["special_i"]		,special_i)
	WRITE_FILE(S["special_a"]		,special_a)
	WRITE_FILE(S["special_l"]		,special_l)
	WRITE_FILE(S["feature_color_scheme"], features["color_scheme"])
	WRITE_FILE(S["feature_chat_color"], features["chat_color"])
	
	WRITE_FILE(S["custom_pixel_x"], custom_pixel_x)
	WRITE_FILE(S["custom_pixel_y"], custom_pixel_y)

	WRITE_FILE(S["waddle_amount"], waddle_amount)
	WRITE_FILE(S["up_waddle_time"], up_waddle_time)
	WRITE_FILE(S["side_waddle_time"], side_waddle_time)

	//save every advanced coloring mode thing in one go
	for(var/feature in features)
		var/feature_value = features[feature]
		if(feature_value)
			var/ref_list = GLOB.mutant_reference_list[feature]
			if(ref_list)
				var/datum/sprite_accessory/accessory = ref_list[feature_value]
				if(accessory)
					var/mutant_string = accessory.mutant_part_string
					if(!mutant_string)
						if(istype(accessory, /datum/sprite_accessory/mam_body_markings))
							mutant_string = "mam_body_markings"
					var/primary_string = "[mutant_string]_primary"
					var/secondary_string = "[mutant_string]_secondary"
					var/tertiary_string = "[mutant_string]_tertiary"
					if(accessory.color_src == MATRIXED && !accessory.matrixed_sections && feature_value != "None")
						message_admins("Sprite Accessory Failure (saving data): Accessory [accessory.type] is a matrixed item without any matrixed sections set!")
						continue
					if(features[primary_string])
						WRITE_FILE(S["feature_[primary_string]"], features[primary_string])
					if(features[secondary_string])
						WRITE_FILE(S["feature_[secondary_string]"], features[secondary_string])
					if(features[tertiary_string])
						WRITE_FILE(S["feature_[tertiary_string]"], features[tertiary_string])

	//Custom names
	for(var/custom_name_id in GLOB.preferences_custom_names)
		var/savefile_slot_name = custom_name_id + "_name" //TODO remove this
		WRITE_FILE(S[savefile_slot_name],custom_names[custom_name_id])

	WRITE_FILE(S["preferred_ai_core_display"]		,  preferred_ai_core_display)
	WRITE_FILE(S["prefered_security_department"]	, prefered_security_department)

	//Jobs
	WRITE_FILE(S["joblessrole"]		, joblessrole)
	//Write prefs
	WRITE_FILE(S["job_preferences"] , job_preferences)
	WRITE_FILE(S["hide_ckey"]		, hide_ckey)

	//Write creature character
	WRITE_FILE(S["creature_species"]			,creature_species)
	WRITE_FILE(S["creature_name"]				,creature_name)
	WRITE_FILE(S["creature_flavor_text"]		,creature_flavor_text)
	WRITE_FILE(S["creature_ooc"]				,creature_ooc)


	//Quirks
	WRITE_FILE(S["char_quirks"]			, char_quirks)

	WRITE_FILE(S["persistent_scars"]			, persistent_scars)
	WRITE_FILE(S["scars1"]						, scars_list["1"])
	WRITE_FILE(S["scars2"]						, scars_list["2"])
	WRITE_FILE(S["scars3"]						, scars_list["3"])
	WRITE_FILE(S["scars4"]						, scars_list["4"])
	WRITE_FILE(S["scars5"]						, scars_list["5"])
	if(islist(modified_limbs))
		WRITE_FILE(S["modified_limbs"]				, safe_json_encode(modified_limbs))
	WRITE_FILE(S["chosen_limb_id"],   chosen_limb_id)


	//gear loadout
	if(length(loadout_data))
		S["loadout"] << safe_json_encode(loadout_data)
	else
		S["loadout"] << safe_json_encode(list())

	WRITE_FILE(S["matchmaking_prefs"], matchmaking_prefs)

	// !! COYOTE SAVEFILE STUFF !!
	WRITE_FILE(S["profilePicture"],				profilePicture)
	WRITE_FILE(S["pfphost"],					pfphost)

	WRITE_FILE(S["creature_profilepic"],		creature_profilepic)
	WRITE_FILE(S["creature_pfphost"],			creature_pfphost)

	WRITE_FILE(S["gradient_color"]			, features_override["grad_color"])
	WRITE_FILE(S["gradient_style"]			, features_override["grad_style"])

	WRITE_FILE(S["gradient_color_2"]		, features_override["grad_color_2"])
	WRITE_FILE(S["gradient_style_2"]		, features_override["grad_style_2"])

	WRITE_FILE(S["s_hair_color_2"]			, features_override["hair_color_2"])
	WRITE_FILE(S["s_hair_style_2"]			, features_override["hair_style_2"])

	WRITE_FILE(S["typing_indicator_sound"]				, features_speech["typing_indicator_sound"])
	WRITE_FILE(S["typing_indicator_sound_play"]			, features_speech["typing_indicator_sound_play"])
	WRITE_FILE(S["typing_indicator_speed"]				, features_speech["typing_indicator_speed"])
	WRITE_FILE(S["typing_indicator_pitch"]				, features_speech["typing_indicator_pitch"])
	WRITE_FILE(S["typing_indicator_variance"]			, features_speech["typing_indicator_variance"])
	WRITE_FILE(S["typing_indicator_volume"]				, features_speech["typing_indicator_volume"])
	WRITE_FILE(S["typing_indicator_max_words_spoken"]	, features_speech["typing_indicator_max_words_spoken"])

	/// Save the vore!
	WRITE_FILE(S["vore_smell"]						, vore_smell)
	WRITE_FILE(S["master_vore_toggle"]				, master_vore_toggle)
	WRITE_FILE(S["allow_dogborgs"]					, allow_dogborgs)
	WRITE_FILE(S["allow_eating_sounds"]				, allow_eating_sounds)
	WRITE_FILE(S["allow_digestion_sounds"]			, allow_digestion_sounds)
	WRITE_FILE(S["allow_digestion_damage"]			, allow_digestion_damage)
	WRITE_FILE(S["allow_digestion_death"]			, allow_digestion_death)
	WRITE_FILE(S["allow_absorbtion"]				, allow_absorbtion)
	WRITE_FILE(S["allow_healbelly_healing"]			, allow_healbelly_healing)
	WRITE_FILE(S["allow_vore_messages"]				, allow_vore_messages)
	WRITE_FILE(S["allow_death_messages"]			, allow_death_messages)
	WRITE_FILE(S["allow_being_prey"]				, allow_being_prey)
	WRITE_FILE(S["allow_being_fed_to_others"]		, allow_being_fed_to_others)
	WRITE_FILE(S["allow_being_prey"]				, allow_being_prey)
	WRITE_FILE(S["allow_seeing_belly_descriptions"]	, allow_seeing_belly_descriptions)
	WRITE_FILE(S["allow_being_sniffed"]				, allow_being_sniffed)
	WRITE_FILE(S["belly_prefs"]						, safe_json_encode(belly_prefs))
	WRITE_FILE(S["current_version"]					, safe_json_encode(current_version))
	WRITE_FILE(S["allow_trash_messages"]			, safe_json_encode(allow_trash_messages))
	WRITE_FILE(S["underwear_overhands"]				, underwear_overhands) // not vore, dont worry its not eating anyones hands
	WRITE_FILE(S["undershirt_overclothes"]			, undershirt_overclothes) // not vore, dont worry its not eating anyones hands
	WRITE_FILE(S["undies_overclothes"]				, undies_overclothes) // not vore, dont worry its not eating anyones hands
	WRITE_FILE(S["socks_overclothes"]				, socks_overclothes) // not vore, dont worry its not eating anyones hands
	WRITE_FILE(S["whoflags"]						, whoflags) // might actually be vore

	//Character directory
	WRITE_FILE(S["show_in_directory"], show_in_directory)
	WRITE_FILE(S["directory_tag"], directory_tag)
	WRITE_FILE(S["directory_erptag"], directory_erptag)
	WRITE_FILE(S["directory_ad"], directory_ad)

	cit_character_pref_save(S)

	//permanent tattoos
	WRITE_FILE(S["permanent_tattoos"], permanent_tattoos)

	WRITE_FILE(S["blocked_from_dms"], safe_json_encode(blocked_from_dms))
	//permanent tattoos
	WRITE_FILE(S["faved_interactions"], safe_json_encode(faved_interactions))
	if(LAZYLEN(saved_finished_quests))
		WRITE_FILE(S["saved_finished_quests"], safe_json_encode(saved_finished_quests))
	WRITE_FILE(S["saved_active_quests"], safe_json_encode(saved_active_quests))
	WRITE_FILE(S["saved_unclaimed_points"], saved_unclaimed_points)
	WRITE_FILE(S["number_of_finished_quests"], number_of_finished_quests)
	WRITE_FILE(S["historical_banked_points"], historical_banked_points)

	WRITE_FILE(S["pda_style"], pda_style)
	WRITE_FILE(S["pda_color"], pda_color)
	WRITE_FILE(S["pda_skin"], pda_skin)
	WRITE_FILE(S["pda_ringmessage"], pda_ringmessage)

	WRITE_FILE(S["last_quest_login"], last_quest_login)

	return 1






//should these procs get fairly long
//just increase SAVEFILE_VERSION_MIN so it's not as far behind
//SAVEFILE_VERSION_MAX and then delete any obsolete if clauses
//from these procs.
//This only really meant to avoid annoying frequent players
//if your savefile is 3 months out of date, then 'tough shit'.


/datum/preferences/proc/update_preferences(current_version, savefile/S)
	if(current_version < 37)	//If you remove this, remove force_reset_keybindings() too.
		force_reset_keybindings_direct(TRUE)
		addtimer(CALLBACK(src,PROC_REF(force_reset_keybindings)), 30)	//No mob available when this is run, timer allows user choice.


/datum/preferences/proc/update_character(current_version, savefile/S)
	if(current_version < 38)
		UI_style = GLOB.available_ui_styles[1] // Force the Fallout UI once.

	if(current_version < 47) //loadout save gets changed to json
		var/text_to_load
		S["loadout"] >> text_to_load
		var/list/saved_loadout_paths = splittext(text_to_load, "|")
		//MAXIMUM_LOADOUT_SAVES save slots per loadout now
		for(var/i=1, i<= MAXIMUM_LOADOUT_SAVES, i++)
			loadout_data["SAVE_[i]"] = list()
		for(var/some_gear_item in saved_loadout_paths)
			if(!ispath(text2path(some_gear_item)))
				log_game("Failed to copy item [some_gear_item] to new loadout system when migrating from version [current_version] to 40, issue: item is not a path")
				continue
			var/datum/gear/gear_item = text2path(some_gear_item)
			if(!(initial(gear_item.loadout_flags)))	//removed the can color polychrom since it's not ported
				loadout_data["SAVE_1"] += list(list(LOADOUT_ITEM = some_gear_item)) //for the migration we put their old save into the first save slot, which is loaded by default!
			else
				//the same but we setup some new polychromic data (you can't get the initial value for a list so we have to do this horrible thing here)
				var/datum/gear/temporary_gear_item = new gear_item
				loadout_data["SAVE_1"] += list(list(LOADOUT_ITEM = some_gear_item))	//removed loadout color because not porting polychrom
				qdel(temporary_gear_item)
			//it's double packed into a list because += will union the two lists contents

		S["loadout"] = safe_json_encode(loadout_data)

	if(current_version < 43) //extreme changes to how things are coloured (the introduction of the advanced coloring system)
		features["color_scheme"] = OLD_CHARACTER_COLORING //disable advanced coloring system by default
		for(var/feature in features)
			var/feature_value = features[feature]
			if(feature_value)
				var/ref_list = GLOB.mutant_reference_list[feature]
				if(ref_list)
					var/datum/sprite_accessory/accessory = ref_list[feature_value]
					if(accessory)
						var/mutant_string = accessory.mutant_part_string
						if(!mutant_string)
							if(istype(accessory, /datum/sprite_accessory/mam_body_markings))
								mutant_string = "mam_body_markings"
						var/primary_string = "[mutant_string]_primary"
						var/secondary_string = "[mutant_string]_secondary"
						var/tertiary_string = "[mutant_string]_tertiary"
						if(accessory.color_src == MATRIXED && !accessory.matrixed_sections && feature_value != "None")
							message_admins("Sprite Accessory Failure (migration from [current_version] to 39): Accessory [accessory.type] is a matrixed item without any matrixed sections set!")
							continue
						var/primary_exists = features[primary_string]
						var/secondary_exists = features[secondary_string]
						var/tertiary_exists = features[tertiary_string]
						if(accessory.color_src == MATRIXED && !primary_exists && !secondary_exists && !tertiary_exists)
							features[primary_string] = features["mcolor"]
							features[secondary_string] = features["mcolor2"]
							features[tertiary_string] = features["mcolor3"]
						else if(accessory.color_src == MUTCOLORS && !primary_exists)
							features[primary_string] = features["mcolor"]
						else if(accessory.color_src == MUTCOLORS2 && !secondary_exists)
							features[secondary_string] = features["mcolor2"]
						else if(accessory.color_src == MUTCOLORS3 && !tertiary_exists)
							features[tertiary_string] = features["mcolor3"]

		features["color_scheme"] = OLD_CHARACTER_COLORING //advanced is off by default

	if(current_version < 37) //introduction of chooseable eye types/sprites
		if(S["species"] == "insect")
			left_eye_color = "#000000"
			right_eye_color = "#000000"
			if(chosen_limb_id == "moth" || chosen_limb_id == "moth_not_greyscale") //these actually have slightly different eyes!
				eye_type = "moth"
			else
				eye_type = "insect"

	if(current_version < 38) //further eye sprite changes
		if(S["species"] == "plasmaman")
			left_eye_color = "#FFC90E"
			right_eye_color = "#FFC90E"
		else
			if(S["species"] == "skeleton")
				left_eye_color = "#BAB99E"
				right_eye_color = "#BAB99E"

	if(current_version < 51) //humans can have digi legs now, make sure they dont default to them or human players will murder me in my sleep
		if(S["species"] == "human")
			features["legs"] = "Plantigrade"

	if(current_version < 52) // rp markings means markings are now stored as a list, lizard markings now mam like the rest
		var/marking_type
		var/species_id = S["species"]
		var/datum/species/actual_species = GLOB.species_list[species_id]

		// convert lizard markings to lizard markings
		if(species_id == "lizard" && S["feature_lizard_body_markings"])
			features["mam_body_markings"] = features["body_markings"]

		// convert mam body marking data to the new rp marking data
		if(actual_species.mutant_bodyparts["mam_body_markings"] && S["feature_mam_body_markings"]) marking_type = "feature_mam_body_markings"

		if(marking_type)
			var/old_marking_value = S[marking_type]
			var/list/color_list = list("#FFFFFF","#FFFFFF","#FFFFFF")

			if(S["feature_mcolor"]) color_list[1] = "#" + S["feature_mcolor"]
			if(S["feature_mcolor2"]) color_list[2] = "#" + S["feature_mcolor2"]
			if(S["feature_mcolor3"]) color_list[3] = "#" + S["feature_mcolor3"]

			var/list/marking_list = list()
			for(var/part in list(ARM_LEFT, ARM_RIGHT, LEG_LEFT, LEG_RIGHT, CHEST, HEAD))
				var/list/copied_color_list = color_list.Copy()
				var/datum/sprite_accessory/mam_body_markings/mam_marking = GLOB.mam_body_markings_list[old_marking_value]
				var/part_name = GLOB.bodypart_names[num2text(part)]
				if(length(mam_marking.covered_limbs) && mam_marking.covered_limbs[part_name])
					var/matrixed_sections = mam_marking.covered_limbs[part_name]
					// just trust me this is fine
					switch(matrixed_sections)
						if(MATRIX_GREEN)
							copied_color_list[1] = copied_color_list[2]
						if(MATRIX_BLUE)
							copied_color_list[1] = copied_color_list[3]
						if(MATRIX_RED_BLUE)
							copied_color_list[2] = copied_color_list[3]
						if(MATRIX_GREEN_BLUE)
							copied_color_list[1] = copied_color_list[2]
							copied_color_list[2] = copied_color_list[3]
				marking_list += list(list(part, old_marking_value, copied_color_list))
			features["mam_body_markings"] = marking_list



#undef SAVEFILE_VERSION_MAX
#undef SAVEFILE_VERSION_MIN

#ifdef TESTING
//DEBUG
//Some crude tools for testing savefiles
//path is the savefile path
/client/verb/savefile_export(path as text)
	var/savefile/S = new /savefile(path)
	S.ExportText("/",file("[path].txt"))
//path is the savefile path
/client/verb/savefile_import(path as text)
	var/savefile/S = new /savefile(path)
	S.ImportText("/",file("[path].txt"))




#endif
