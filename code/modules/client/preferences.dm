#define MAX_FREE_PER_CAT	4
#define HANDS_SLOT_AMT		2
#define BACKPACK_SLOT_AMT	4

GLOBAL_LIST_EMPTY(preferences_datums)

/datum/preferences
	var/client/parent
	//doohickeys for savefiles
	var/path
	var/vr_path
	var/default_slot = 1				//Holder so it doesn't default to slot 1, rather the last one used
	var/max_save_slots = 30

	//non-preference stuff
	var/muted = 0
	var/last_ip
	var/last_id
	var/log_clicks = FALSE

	var/icon/custom_holoform_icon
	var/list/cached_holoform_icons
	var/last_custom_holoform = 0

	//Cooldowns for saving/loading. These are four are all separate due to loading code calling these one after another
	var/saveprefcooldown
	var/loadprefcooldown
	var/savecharcooldown
	var/loadcharcooldown

	//game-preferences
	var/lastchangelog = ""				//Saved changlog filesize to detect if there was a change
	var/ooccolor = "#c43b23"
	var/aooccolor = "#ce254f"
	var/enable_tips = TRUE
	var/tip_delay = 500 //tip delay in milliseconds

	//Antag preferences
	var/list/be_special = list()		//Special role selection
	var/tmp/old_be_special = 0			//Bitflag version of be_special, used to update old savefiles and nothing more
										//If it's 0, that's good, if it's anything but 0, the owner of this prefs file's antag choices were,
										//autocorrected this round, not that you'd need to check that.

	// VORE~
	// see: [code\modules\vore\eating\vore_prefs.dm]

	var/UI_style = null
	var/buttons_locked = FALSE
	var/hotkeys = FALSE
	var/chat_on_map = TRUE
	var/max_chat_length = CHAT_MESSAGE_MAX_LENGTH
	var/see_chat_non_mob = TRUE
	///Whether emotes will be displayed on runechat. Requires chat_on_map to have effect. Boolean.
	var/see_rc_emotes = TRUE
	///Whether to apply mobs' runechat color to the chat log as well
	var/color_chat_log = TRUE
	///Keeping track of chat bg color
	var/chatbgcolor = "#131313"

	var/list/aghost_squelches = list()

	/// Custom Keybindings
	var/list/key_bindings = list()
	/// List with a key string associated to a list of keybindings. Unlike key_bindings, this one operates on raw key, allowing for binding a key that triggers regardless of if a modifier is depressed as long as the raw key is sent.
	var/list/modless_key_bindings = list()

	var/tgui_fancy = TRUE
	var/tgui_lock = TRUE
	var/windowflashing = TRUE
	var/toggles = TOGGLES_DEFAULT
	var/db_flags
	var/chat_toggles = TOGGLES_DEFAULT_CHAT
	var/ghost_form = "ghost"
	var/ghost_orbit = GHOST_ORBIT_CIRCLE
	var/ghost_accs = GHOST_ACCS_DEFAULT_OPTION
	var/ghost_others = GHOST_OTHERS_DEFAULT_OPTION
	var/ghost_hud = 1
	var/inquisitive_ghost = 1
	var/allow_midround_antag = 1
	var/preferred_map = null
	var/preferred_chaos = null
	var/pda_style = MONO
	var/pda_color = "#808000"
	var/pda_skin = "Random!"
	var/pda_ringmessage = "beep-boop"

	var/my_shark = "Bingus Whale"

	var/genital_whitelist = ""
	var/whoflags = DEFAULT_WHO_FLAGS
	var/lockouts = NONE

	var/uses_glasses_colour = 0

	var/show_in_directory = TRUE
	var/directory_tag = "Unset"
	var/directory_erptag = "Unset"
	var/directory_ad = "Hi"

	//character preferences
	var/real_name						//our character's name
	var/be_random_name = 0				//whether we'll have a random name every round
	var/be_random_body = 0				//whether we'll have a random body every round
	var/gender = MALE					//gender of character (well duh)
	var/age = 30						//age of character
	//Sandstorm CHANGES BEGIN
	var/erppref = "Ask"
	var/nonconpref = "Ask"
	var/vorepref = "Ask"
	var/extremepref = "No" //This is for extreme shit, maybe even literal shit, better to keep it on no by default
	var/extremeharm = "No" //If "extreme content" is enabled, this option serves as a toggle for the related interactions to cause damage or not
	var/see_chat_emotes = TRUE
	var/view_pixelshift = FALSE
	var/enable_personal_chat_color = FALSE
	var/personal_chat_color = "#ffffff"
	var/list/alt_titles_preferences = list()
	var/lust_tolerance = 100
	var/sexual_potency = 15
	var/unholypref = "No" //Goin 2 hell fo dis one
	// cum
	var/list/faved_interactions = list() // list of stringed type paths
	var/list/saved_plappers = list() // to do: this
	//Sandstorm CHANGES END
	var/preview_hide_undies = FALSE
	var/undershirt_overclothes = UNDERWEAR_UNDER_CLOTHES
	var/undies_overclothes = UNDERWEAR_UNDER_CLOTHES
	var/socks_overclothes = UNDERWEAR_UNDER_CLOTHES
	var/underwear_overhands = FALSE		//whether we'll have underwear over our hands
	var/underwear = "Nude"				//underwear type
	var/undie_color = "FFFFFF"
	var/undershirt = "Nude"				//undershirt type
	var/shirt_color = "FFFFFF"
	var/socks = "Nude"					//socks type
	var/socks_color = "FFFFFF"
	var/backbag = DBACKPACK				//backpack type
	var/jumpsuit_style = PREF_SUIT		//suit/skirt
	var/hair_style = "Bald"				//Hair type
	var/hair_style_2 = "Bald"				//Hair type
	var/hair_color = "000000"				//Hair color
	var/facial_hair_style = "Shaved"	//Face hair type
	var/facial_hair_color = "000000"		//Facial hair color
	var/skin_tone = "caucasian1"		//Skin color
	var/use_custom_skin_tone = FALSE
	var/left_eye_color = "000000"		//Eye color
	var/right_eye_color = "000000"
	var/eye_type = DEFAULT_EYES_TYPE	//Eye type
	var/split_eye_colors = FALSE
	var/tbs = TBS_DEFAULT // turner broadcasting system
	var/kisser = KISS_DEFAULT // Kiss this (     Y     )
	/// which quester UID we're using
	var/quester_uid
	var/dm_open = TRUE
	var/needs_a_friend = FALSE // for the quest
	var/list/blocked_from_dms = list() // list of quids
	/// rough approximations of the character's finished quests
	var/list/saved_finished_quests_old = list() // deprecated, or something
	var/list/saved_finished_quests = list()
	var/number_of_finished_quests = 0
	var/historical_banked_points = 0
	/// tight list of the character's active quests
	var/list/saved_active_quests = list()
	var/saved_unclaimed_points = 0
	var/show_health_smilies = TRUE
	var/datum/species/pref_species = new /datum/species/mammal()	//Mutant race
	/// If our species supports it, this will override our appearance. See species.dm. "Default" will just use the base icon
	var/alt_appearance = "Default"
	var/admin_wire_tap = TRUE
	var/list/features = list(
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
		"derg_body" = "Smooth Dragon Body",
		"derg_belly" = "None",
		"derg_horns" = "None",
		"derg_mane" = "None",
		"derg_ears" = "None",
		"derg_eyes" = "None",
		"xenodorsal" = "Standard",
		"xenohead" = "Standard",
		"xenotail" = "Xenomorph Tail",
		"taur" = "None",
		"genitals_use_skintone" = FALSE,
		"has_cock" = FALSE,
		"cock_shape" = DEF_COCK_SHAPE,
		"cock_size" = COCK_SIZE_DEF, // didnt use the same naming convention, what a dick
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
		"breasts_size" = BREASTS_SIZE_DEF,
		"breasts_shape" = DEF_BREASTS_SHAPE,
		"breasts_producing" = FALSE,
		"has_butt" = FALSE,
		"butt_color" = "ffffff",
		"butt_size" = BUTT_SIZE_DEF,
		"has_belly" = FALSE,
		"belly_color" = "ffffff",
		"belly_size" = BELLY_SIZE_DEF,
		"belly_shape" = DEF_BELLY_SHAPE,
		"has_vag" = FALSE,
		"vag_shape" = DEF_VAGINA_SHAPE,
		"vag_color" = "ffffff",
		"has_womb" = FALSE,
		"balls_visibility" = GEN_VISIBLE_NO_UNDIES,
		"breasts_visibility"= GEN_VISIBLE_NO_UNDIES,
		"cock_visibility" = GEN_VISIBLE_NO_UNDIES,
		"vag_visibility" = GEN_VISIBLE_NO_UNDIES,
		"butt_visibility" = GEN_VISIBLE_NO_UNDIES,
		"belly_visibility" = GEN_VISIBLE_NO_UNDIES,
		"balls_visibility_flags" = GEN_VIS_FLAG_DEFAULT,
		"breasts_visibility_flags"= GEN_VIS_FLAG_DEFAULT,
		"cock_visibility_flags" = GEN_VIS_FLAG_DEFAULT,
		"vag_visibility_flags" = GEN_VIS_FLAG_DEFAULT,
		"butt_visibility_flags" = GEN_VIS_FLAG_DEFAULT,
		"belly_visibility_flags" = GEN_VIS_FLAG_DEFAULT,
		"genital_visibility_flags" = GEN_VIS_OVERALL_FLAG_DEFAULT,
		"genital_order" = DEF_COCKSTRING,
		"genital_hide" = NONE,
		"genital_whitelist" = "Sammt Bingus, fluntly, theBungus",
		"ipc_screen" = "Sunburst",
		"ipc_antenna" = "None",
		"flavor_text" = "",
		"silicon_flavor_text" = "",
		"ooc_notes" = "",
		"background_info_notes" = "",
		"flist" = "",
		"meat_type" = "Mammalian",
		"taste" = "something",
		"body_model" = MALE,
		"body_size" = RESIZE_DEFAULT_SIZE,
		"body_width" = RESIZE_DEFAULT_WIDTH,
		"color_scheme" = OLD_CHARACTER_COLORING,
		"chat_color" = "whoopsie"
		)

	var/custom_speech_verb = "default" //if your say_mod is to be something other than your races
	var/custom_tongue = "default" //if your tongue is to be something other than your races
	var/modified_limbs = list() //prosthetic/amputated limbs
	var/chosen_limb_id //body sprite selected to load for the users limbs, null means default, is sanitized when loaded

	/// Security record note section
	var/security_records
	/// Medical record note section
	var/medical_records

	var/list/custom_names = list()
	var/preferred_ai_core_display = "Blue"
	var/prefered_security_department = SEC_DEPT_RANDOM
	var/custom_species = null

	//Creature Preferences
	var/creature_species = 		"Eevee"
	var/creature_name = 		"Eevee"
	var/creature_flavor_text = 	null
	var/creature_ooc = 			null
	var/image/creature_image = null
	var/creature_profilepic = ""
	var/creature_pfphost = ""
	var/creature_body_size = 1
	var/creature_fuzzy = FALSE

	/// Quirk list
	/// okay lets compromise, we'll have type paths, but they're strings, happy?
	/// Format: list("/datum/quirk/aaa", "/datum/quirk/bbb", "/datum/quirk/ccc", etc)
	var/list/char_quirks = list()
	/// DONT USE THIS, ITS JUST FOR MIGRATION!!!!!!!
	var/list/all_quirks = list()

	//Quirk category currently selected
	var/quirk_category = QUIRK_POSITIVE 

	//Job preferences 2.0 - indexed by job title , no key or value implies never
	var/list/job_preferences = list()

	// Want randomjob if preferences already filled - Donkie
	var/joblessrole = RETURNTOLOBBY  //defaults to returning to lobby

	// 0 = character settings, 1 = game preferences
	var/current_tab = SETTINGS_TAB

	// If in the ERP tab, are we rearranging genitals
	var/erp_tab_page = ERP_TAB_HOME

	var/unlock_content = 0

	var/list/ignoring = list()

	var/clientfps = 0

	var/parallax

	var/ambientocclusion = TRUE
	var/auto_fit_viewport = TRUE

	var/uplink_spawn_loc = UPLINK_PDA

	var/hud_toggle_flash = TRUE
	var/hud_toggle_color = "#ffffff"

	var/list/exp = list()
	var/list/menuoptions

	var/list/job_whitelists = list()

	var/action_buttons_screen_locs = list()

	//bad stuff
	var/cit_toggles = TOGGLES_CITADEL

	//good stuff
	var/cb_toggles = AIM_CURSOR_ON

	//backgrounds
	var/mutable_appearance/character_background
	var/icon/bgstate = "steel"
	var/list/bgstate_options = list("000", "midgrey", "FFF", "white", "steel", "techmaint", "dark", "plating", "reinforced")

	var/show_mismatched_markings = FALSE //determines whether or not the markings lists should show markings that don't match the currently selected species. Intentionally left unsaved.

	var/no_tetris_storage = FALSE

	///loadout stuff
	var/gear_points = 12
	var/list/gear_categories
	var/list/chosen_gear = list()
	var/list/loadout_data = list()
	var/loadout_slot = 1 //goes from 1 to MAXIMUM_LOADOUT_SAVES
	var/gear_category
	var/gear_subcategory

	var/screenshake = 100
	var/damagescreenshake = 2
	var/arousable = TRUE
	var/widescreenpref = FALSE
	var/end_of_round_deathmatch = FALSE
	var/autostand = TRUE
	var/auto_ooc = FALSE

	/// should our eyes be uwu animu overhair, or normal eyes
	var/eye_over_hair = FALSE

	/// If we have persistent scars enabled
	var/persistent_scars = TRUE
	/// We have 5 slots for persistent scars, if enabled we pick a random one to load (empty by default) and scars at the end of the shift if we survived as our original person
	var/list/scars_list = list("1" = "", "2" = "", "3" = "", "4" = "", "5" = "")
	/// Which of the 5 persistent scar slots we randomly roll to load for this round, if enabled. Actually rolled in [/datum/preferences/proc/load_character(slot)]
	var/scars_index = 1

	var/hide_ckey = FALSE //pref for hiding if your ckey shows round-end or not

	var/special_s = 5
	var/special_p = 5
	var/special_e = 5
	var/special_c = 5
	var/special_i = 5
	var/special_a = 5
	var/special_l = 5

	var/custom_pixel_x = 0
	var/custom_pixel_y = 0

	var/permanent_tattoos = ""

	/// Associative list: matchmaking_prefs[/datum/matchmaking_pref subtype] -> number of desired matches
	var/list/matchmaking_prefs = list()

	/// Versioning hack! Versioning hack! Versioning hack!
	var/list/current_version = list()
	/// Game prefs-related stuff
	var/list/current_revision = list() // Have fun distinguishing between these two

	var/fuzzy = FALSE //Fuzzy scaling

	/// Upwards waddle amount. Side to side is always double this.
	var/waddle_amount = 0
	/// How fast the mob wobbles upwards.
	var/up_waddle_time = 1
	/// How fast the mob wobbles side to side.
	var/side_waddle_time = 2

	/// Button to switch from input bar to hotkey mode.
	var/input_mode_hotkey = "Ctrl+Tab"

/datum/preferences/New(client/C)
	parent = C

	if(LAZYLEN(GLOB.cow_names))
		my_shark = safepick(GLOB.cow_names + GLOB.carp_names + GLOB.megacarp_last_names)
	spawn(0)
		if(C)
			chatbgcolor = winget(C, "statbrowser", "background-color")
			if(chatbgcolor == "none")
				chatbgcolor = "#ffffff"

	for(var/custom_name_id in GLOB.preferences_custom_names)
		custom_names[custom_name_id] = get_default_name(custom_name_id)

	UI_style = GLOB.available_ui_styles[1]
	if(istype(C))
		if(!IsGuestKey(C.key))
			load_path(C.ckey)
			unlock_content = C.IsByondMember()
			if(unlock_content)
				max_save_slots = 30
	var/loaded_preferences_successfully = load_preferences()
	if(loaded_preferences_successfully)
		if(load_character())
			return
	//we couldn't load character data so just randomize the character appearance + name
	random_character()		//let's create a random character then - rather than a fat, bald and naked man.
	key_bindings = deepCopyList(GLOB.hotkey_keybinding_list_by_key) // give them default keybinds and update their movement keys
	C?.ensure_keys_set(src)
	real_name = pref_species.random_name(gender,1)
	if(!loaded_preferences_successfully)
		save_preferences()
	save_character()		//let's save this new random character so it doesn't keep generating new ones.
	menuoptions = list()
	return

#define APPEARANCE_CATEGORY_COLUMN "<td valign='top' width='17%'>"
#define ERP_CATEGORY_ROW "<tr valign='top' width='17%'>"
#define MAX_MUTANT_ROWS 5

/datum/preferences/proc/ShowChoices(mob/user)
	if(!user || !user.client)
		return

	if(CONFIG_GET(flag/use_role_whitelist))
		user.client.set_job_whitelist_from_db()

	update_preview_icon(current_tab)
	var/list/dat = list("<center>")

	dat += "<a href='?_src_=prefs;preference=tab;tab=[SETTINGS_TAB]' [current_tab == SETTINGS_TAB ? "class='linkOn'" : ""]>Character Settings</a>"
	dat += "<a href='?_src_=prefs;preference=tab;tab=[APPEARANCE_TAB]' [current_tab == APPEARANCE_TAB ? "class='linkOn'" : ""]>Character Appearance</a>"
	dat += "<a href='?_src_=prefs;preference=tab;tab=[CHAR_INFO_TAB]' [current_tab == CHAR_INFO_TAB ? "class='linkOn'" : ""]>Character Info</a>"
	dat += "<a href='?_src_=prefs;preference=tab;tab=[ERP_TAB]' [current_tab == ERP_TAB ? "class='linkOn'" : ""]>Underlying Appearance</a>"
	dat += "<a href='?_src_=prefs;preference=tab;tab=[LOADOUT_TAB]' [current_tab == LOADOUT_TAB ? "class='linkOn'" : ""]>Loadout</a>"
	dat += "<a href='?_src_=prefs;preference=tab;tab=[GAME_PREFERENCES_TAB]' [current_tab == GAME_PREFERENCES_TAB ? "class='linkOn'" : ""]>Game Preferences</a>"
	dat += "<a href='?_src_=prefs;preference=tab;tab=[CONTENT_PREFERENCES_TAB]' [current_tab == CONTENT_PREFERENCES_TAB ? "class='linkOn'" : ""]>Content Preferences</a>"
	dat += "<a href='?_src_=prefs;preference=tab;tab=[KEYBINDINGS_TAB]' [current_tab == KEYBINDINGS_TAB ? "class='linkOn'" : ""]>Keybindings</a>"

	if(!path)
		dat += "<div class='notice'>Please create an account to save your preferences</div>"

	dat += "</center>"

	dat += "<HR>"

	switch(current_tab)
		if(SETTINGS_TAB) // Character Settings#
			if(path)
				var/savefile/S = new /savefile(path)
				if(S)
					dat += "<center>"
					var/name
					var/unspaced_slots = 0
					for(var/i=1, i<=max_save_slots, i++)
						unspaced_slots++
						if(unspaced_slots > 8)
							dat += "<br>"
							unspaced_slots = 0
						S.cd = "/character[i]"
						S["real_name"] >> name
						if(!name)
							name = "Character[i]"
						dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=changeslot;num=[i];' [i == default_slot ? "class='linkOn'" : ""]>[name]</a> "
					dat += "</center>"

			dat += "<center><h2>Quest Board UID</h2>"
			dat += "[quester_uid]</center>"
			if(CONFIG_GET(flag/roundstart_traits))
				dat += "<center>"
				if(SSquirks.initialized && !(PMC_QUIRK_OVERHAUL_2K23 in current_version))
					dat += "<a href='?_src_=prefs;preference=quirk_migrate'>CLICK HERE to migrate your old quirks to the new system!</a>"
				dat += "<a href='?_src_=prefs;preference=quirkmenu'>"
				dat += "<h2>Configure Quirks</a></h2><br></center>"
				dat += "</a>"
				dat += "<center><b>Current Quirks:</b> [get_my_quirks()]</center>"
			dat += "<center><h2>S.P.E.C.I.A.L.</h2>"
			dat += "<a href='?_src_=prefs;preference=special;task=menu'>Allocate Points</a><br></center>"
			//Left Column
			dat += "<table><tr><td width='30%'valign='top'>"
			dat += "<h2>Identity</h2>"
			if(jobban_isbanned(user, "appearance"))
				dat += "<b>You are banned from using custom names and appearances. You can continue to adjust your characters, but you will be randomised once you join the game.</b><br>"

			dat += "<b>Name:</b> "
			dat += "<a href='?_src_=prefs;preference=name;task=input'>[real_name]</a><BR>"

			dat += "<b>Gender:</b> <a href='?_src_=prefs;preference=gender;task=input'>[gender == MALE ? "Male" : (gender == FEMALE ? "Female" : (gender == PLURAL ? "Non-binary" : "Object"))]</a><BR>"
			dat += "<b>Age:</b> <a style='display:block;width:30px' href='?_src_=prefs;preference=age;task=input'>[age]</a><BR>"
			dat += "<b>Top/Bottom/Switch:</b> <a href='?_src_=prefs;preference=tbs;task=input'>[tbs]</a><BR>"
			dat += "<b>Orientation:</b> <a href='?_src_=prefs;preference=kisser;task=input'>[kisser]</a><BR>"
			dat += "</td>"
			//Middle Column
			dat +="<td width='30%' valign='top'>"
			dat += "<h2>Matchmaking preferences:</h2>"
			if(SSmatchmaking.initialized)
				for(var/datum/matchmaking_pref/match_pref as anything in SSmatchmaking.all_match_types)
					var/max_matches = initial(match_pref.max_matches)
					if(!max_matches)
						continue // Disabled.
					var/current_value = clamp((matchmaking_prefs[match_pref] || 0), 0, max_matches)
					var/set_name = !current_value ? "Disabled" : (max_matches == 1 ? "Enabled" : "[current_value]")
					dat += "<b>[initial(match_pref.pref_text)]:</b> <a href='?_src_=prefs;preference=set_matchmaking_pref;matchmake_type=[match_pref]'>[set_name]</a><br>"
			else
				dat += "<b>Loading matchmaking preferences...</b><br>"
				dat += "<b>Refresh once the game has finished setting up...</b><br>"
			dat += "</td>"
			//Right column
			dat +="<td width='30%' valign='top'>"
			dat += "<h2>Profile Picture ([pfphost]):</h2><BR>"
			dat += "<b>Picture:</b> <a href='?_src_=prefs;preference=ProfilePicture;task=input'>[profilePicture ? "<img src=[PfpHostLink(profilePicture, pfphost)] width='125' height='auto' max-height='300'>" : "Upload a picture!"]</a><BR>"
			dat += "<h2>Simple Creature Profile Picture ([creature_pfphost]):</h2><BR>"
			dat += "<b>Picture:</b> <a href='?_src_=prefs;preference=CreatureProfilePicture;task=input'>[creature_profilepic ? "<img src=[PfpHostLink(creature_profilepic, creature_pfphost)] width='125' height='auto' max-height='300'>" : "Upload a picture!"]</a><BR>"
			dat += "</td>"
			/*
			dat += "<b>Special Names:</b><BR>"
			var/old_group
			for(var/custom_name_id in GLOB.preferences_custom_names)
				var/namedata = GLOB.preferences_custom_names[custom_name_id]
				if(!old_group)
					old_group = namedata["group"]
				else if(old_group != namedata["group"])
					old_group = namedata["group"]
					dat += "<br>"
				dat += "<a href ='?_src_=prefs;preference=[custom_name_id];task=input'><b>[namedata["pref_name"]]:</b> [custom_names[custom_name_id]]</a> "
			dat += "<br><br>"

			Records disabled until a use for them is found
			dat += "<b>Custom job preferences:</b><BR>"
			dat += "<a href='?_src_=prefs;preference=ai_core_icon;task=input'><b>Preferred AI Core Display:</b> [preferred_ai_core_display]</a><br>"
			dat += "<a href='?_src_=prefs;preference=sec_dept;task=input'><b>Preferred Security Department:</b> [prefered_security_department]</a><BR></td>"
			dat += "<br>Records</b><br>"
			dat += "<br><a href='?_src_=prefs;preference=security_records;task=input'><b>Security Records</b></a><br>"
			if(length_char(security_records) <= 40)
				if(!length(security_records))
					dat += "\[...\]"
				else
					dat += "[security_records]"
			else
				dat += "[TextPreview(security_records)]...<BR>"

			dat += "<br><a href='?_src_=prefs;preference=medical_records;task=input'><b>Medical Records</b></a><br>"
			if(length_char(medical_records) <= 40)
				if(!length(medical_records))
					dat += "\[...\]<br>"
				else
					dat += "[medical_records]"
			else
				dat += "[TextPreview(medical_records)]...<BR>"
			dat += "<br><b>Hide ckey: <a href='?_src_=prefs;preference=hide_ckey;task=input'>[hide_ckey ? "Enabled" : "Disabled"]</b></a><br>"
			*/
			dat += "</tr></table>"


		//Character Appearance
		if(APPEARANCE_TAB)
			if(path)
				var/savefile/S = new /savefile(path)
				if(S)
					dat += "<center>"
					var/name
					var/unspaced_slots = 0
					for(var/i=1, i<=max_save_slots, i++)
						unspaced_slots++
						if(unspaced_slots > 8)
							dat += "<br>"
							unspaced_slots = 0
						S.cd = "/character[i]"
						S["real_name"] >> name
						if(!name)
							name = "Character[i]"
						dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=changeslot;num=[i];' [i == default_slot ? "class='linkOn'" : ""]>[name]</a> "
					dat += "</center>"
			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			
			//	START COLUMN 1
			dat += APPEARANCE_CATEGORY_COLUMN

			dat += "<h3>Body</h3>"
			
			dat += "<b>Species:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=species;task=input'>[pref_species.name]</a><BR>"
			
			if(LAZYLEN(pref_species.alt_prefixes))
				dat += "<b>Alt Appearance:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=species_alt_prefix;task=input'>[alt_appearance ? alt_appearance : "Select"]</a><BR>"

			dat += "<b>Custom Species Name:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=custom_species;task=input'>[custom_species ? custom_species : "None"]</a><BR>"
			
			dat += "<b>Gender:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=gender;task=input'>[gender == MALE ? "Male" : (gender == FEMALE ? "Female" : (gender == PLURAL ? "Non-binary" : "Object"))]</a><br>"
			
			if(gender != NEUTER && pref_species.sexes)
				dat += "<b>Body Model:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=body_model'>[features["body_model"] == MALE ? "Masculine" : "Feminine"]</a><br>"
			
			if(length(pref_species.allowed_limb_ids))
				if(!chosen_limb_id || !(chosen_limb_id in pref_species.allowed_limb_ids))
					chosen_limb_id = pref_species.limbs_id || pref_species.id
				dat += "<b>Body Sprite:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=bodysprite;task=input'>[chosen_limb_id]</a><br>"
			dat += "</td>"
			dat += APPEARANCE_CATEGORY_COLUMN
			var/use_skintones = pref_species.use_skintones			
			var/mutant_colors
			if((MUTCOLORS in pref_species.species_traits) || (MUTCOLORS_PARTSONLY in pref_species.species_traits))
				if(!use_skintones)
					dat += "<b>Primary Color:</b><BR>"
					dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color;task=input'>Change</a><BR>"

					dat += "<b>Secondary Color:</b><BR>"
					dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color2;task=input'>Change</a><BR>"

					dat += "<b>Tertiary Color:</b><BR>"
					dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor3"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color3;task=input'>Change</a><BR>"
					mutant_colors = TRUE
			
			if(use_skintones)
				dat += "<h3>Skin Tone</h3>"
				dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=s_tone;task=input'>[use_custom_skin_tone ? "custom: <span style='border:1px solid #161616; background-color: [skin_tone];'>&nbsp;&nbsp;&nbsp;</span>" : skin_tone]</a><BR>"
			
			if (CONFIG_GET(number/body_size_min) != CONFIG_GET(number/body_size_max))
				dat += "<b>Sprite Size:</b> <a href='?_src_=prefs;preference=body_size;task=input'>[features["body_size"]*100]%</a><br>"
			if (CONFIG_GET(number/body_width_min) != CONFIG_GET(number/body_width_max))
				dat += "<b>Sprite Width:</b> <a href='?_src_=prefs;preference=body_width;task=input'>[features["body_width"]*100]%</a><br>"
			dat += "<b>Scaling:</b> <a href='?_src_=prefs;preference=toggle_fuzzy;task=input'>[fuzzy ? "Fuzzy" : "Sharp"]</a><br>"

			dat += "<b>Limb Modification:</b><br>"
			dat += "<a href='?_src_=prefs;preference=modify_limbs;task=input'>Modify Limbs</a><BR>"
			for(var/modification in modified_limbs)
				if(modified_limbs[modification][1] == LOADOUT_LIMB_PROSTHETIC)
					dat += "<b>[modification]: [modified_limbs[modification][2]]</b><BR>"
				else
					dat += "<b>[modification]: [modified_limbs[modification][1]]</b><BR>"

			dat += "</td>"
			//	END COLUMN 1
			//  START COLUMN 2
			dat += APPEARANCE_CATEGORY_COLUMN
			if(!(NOEYES in pref_species.species_traits))
				dat += "<h3>Eyes</h3>"
				dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=eye_type;task=input'>[eye_type]</a>"
				if((EYECOLOR in pref_species.species_traits))
					if(!use_skintones && !mutant_colors)
						dat += APPEARANCE_CATEGORY_COLUMN
					if(left_eye_color != right_eye_color)
						split_eye_colors = TRUE
					dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=toggle_eye_over_hair;task=input'>[eye_over_hair ? "Over Hair" : "Under Hair"]</a>"
					dat += "<b>Heterochromia</b><br>"
					dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=toggle_split_eyes;task=input'>[split_eye_colors ? "Enabled" : "Disabled"]</a>"
					if(!split_eye_colors)
						dat += "<b>Eye Color</b><br>"
						dat += "<span style='border: 1px solid #161616; background-color: #[left_eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=eyes;task=input'>Change</a><br>"
					else
						dat += "<b>Left Color</b><br>"
						dat += "<span style='border: 1px solid #161616; background-color: #[left_eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=eye_left;task=input'>Change</a><br>"
						dat += "<b>Right Color</b><br>"
						dat += "<span style='border: 1px solid #161616; background-color: #[right_eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=eye_right;task=input'>Change</a><br>"
			//  END COLUMN 2
			dat += APPEARANCE_CATEGORY_COLUMN
			if(HAIR in pref_species.species_traits)
				dat += "<h3>Hair</h3>"
				dat += "<b>Style Up:</b><br>"
				dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=hair_style;task=input'>[hair_style]<br>"
				dat += "<a href='?_src_=prefs;preference=previous_hair_style;task=input'>&lt;</a> <a href='?_src_=prefs;preference=next_hair_style;task=input'>&gt;</a><br>"
				dat += "<span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=hair;task=input'>Change</a><br><BR>"

				// Coyote ADD: Hair gradients
				dat += "<b>Gradient Up:</b><br>"
				dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=grad_style;task=input'>[features_override["grad_style"]]</a>"
				dat += "<span style='border:1px solid #161616; background-color: #[features_override["grad_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=grad_color;task=input'>Change</a><br><BR>"
				// Coyote ADD: End

				dat += "<b>Style Down:</b><br>"
				dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=hair_style_2;task=input'>[features_override["hair_style_2"]]</a>"
				dat += "<a href='?_src_=prefs;preference=previous_hair_style_2;task=input'>&lt;</a> <a href='?_src_=prefs;preference=next_hair_style_2;task=input'>&gt;</a><br>"
				dat += "<span style='border:1px solid #161616; background-color: #[features_override["hair_color_2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=hair_color_2;task=input'>Change</a><br><BR>"

				dat += "<b>Gradient Down:</b><br>"
				dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=grad_style_2;task=input'>[features_override["grad_style_2"]]</a>"
				dat += "<span style='border:1px solid #161616; background-color: #[features_override["grad_color_2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=grad_color_2;task=input'>Change</a><br><BR>"

				dat += "<b>Facial Style:</b><br>"
				dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=facial_hair_style;task=input'>[facial_hair_style]<br>"
				dat += "<a href='?_src_=prefs;preference=previous_facehair_style;task=input'>&lt;</a> <a href='?_src_=prefs;preference=next_facehair_style;task=input'>&gt;</a><br>"
				dat += "<span style='border: 1px solid #161616; background-color: #[facial_hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=facial;task=input'>Change</a><br><BR>"

			dat += "<b>Show/hide Undies:</b><br>"
			dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=toggle_undie_preview;task=input'>[preview_hide_undies ? "Hidden" : "Visible"]<br>"

			dat += "</td>"

			//end column 3 or something
			//start column 4
			dat += APPEARANCE_CATEGORY_COLUMN
			//Waddling
			dat += "<h3>Waddling</h3>"
			dat += "<b>Waddle Amount:</b><a href='?_src_=prefs;preference=waddle_amount;task=input'>[waddle_amount]</a><br>"
			if(waddle_amount > 0)
				dat += "</b><a href='?_src_=prefs;preference=up_waddle_time;task=input'>&harr; Speed:[up_waddle_time]</a><br>"
				dat += "</b><a href='?_src_=prefs;preference=side_waddle_time;task=input'>&#8597 Speed:[side_waddle_time]</a><br>"
			
			
			dat += "<h3>Misc</h3>"
			dat += "<b>Custom Taste:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=taste;task=input'>[features["taste"] ? features["taste"] : "something"]</a><br>"
			dat += "<b>Runechat Color:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=chat_color;task=input;background-color: #[features["chat_color"]]'>#[features["chat_color"]]</span></a><br>"
			dat += "<b>Blood Color:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=blood_color;task=input;background-color: #[features["blood_color"]]'>#[features["blood_color"]]</span></a><br>"
			dat += "<a href='?_src_=prefs;preference=reset_blood_color;task=input'>Reset Blood Color</A><BR>"
			dat += "<a href='?_src_=prefs;preference=rainbow_blood_color;task=input'>Rainbow Blood Color</A><BR>"
			dat += "<b>Background:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=cycle_bg;task=input'>[bgstate]</a><br>"
			dat += "<b>Pixel Offsets</b><br>"
			var/px = custom_pixel_x > 0 ? "+[custom_pixel_x]" : "[custom_pixel_x]"
			var/py = custom_pixel_y > 0 ? "+[custom_pixel_y]" : "[custom_pixel_y]"
			dat += "<a href='?_src_=prefs;preference=pixel_x;task=input'>&harr;[px]</a><br>"
			dat += "<a href='?_src_=prefs;preference=pixel_y;task=input'>&#8597;[py]</a><br>"
			
			dat += "</td>"
			//Mutant stuff
			var/mutant_category = 0
			mutant_category++
			if(mutant_category >= MAX_MUTANT_ROWS) //just in case someone sets the max rows to 1 or something dumb like that
				dat += "</td>"
				mutant_category = 0

			// rp marking selection
			// assume you can only have mam markings or regular markings or none, never both
			var/marking_type
			dat += APPEARANCE_CATEGORY_COLUMN
			dat += "<b>Advanced Coloring:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=color_scheme;task=input'>[(features["color_scheme"] == ADVANCED_CHARACTER_COLORING) ? "Enabled" : "Disabled"]</a>"
			dat += "<b>Mismatched Markings:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=mismatched_markings;task=input'>[show_mismatched_markings ? "Yes" : "No"]</a>"
			if(parent.can_have_part("mam_body_markings"))
				marking_type = "mam_body_markings"
			if(marking_type)
				dat += "<h3>[GLOB.all_mutant_parts[marking_type]]</h3>" // give it the appropriate title for the type of marking
				dat += "<a href='?_src_=prefs;preference=marking_add;marking_type=[marking_type];task=input'>Add marking</a>"
				// list out the current markings you have
				if(length(features[marking_type]))
					dat += "<table>"
					var/list/markings = features[marking_type]
					if(!islist(markings))
						// something went terribly wrong
						markings = list()
					var/list/reverse_markings = reverseList(markings)
					for(var/list/marking_list in reverse_markings)
						var/marking_index = markings.Find(marking_list) // consider changing loop to go through indexes over lists instead of using Find here
						var/limb_value = marking_list[1]
						var/actual_name = GLOB.bodypart_names[num2text(limb_value)] // get the actual name from the bitflag representing the part the marking is applied to
						var/color_marking_dat = ""
						var/number_colors = 1
						var/datum/sprite_accessory/mam_body_markings/S = GLOB.mam_body_markings_list[marking_list[2]]
						var/matrixed_sections = S.covered_limbs[actual_name]
						if(S && matrixed_sections)
							// if it has nothing initialize it to white
							if(length(marking_list) == 2)
								var/first = "#FFFFFF"
								var/second = "#FFFFFF"
								var/third = "#FFFFFF"
								if(features["mcolor"])
									first = "#[features["mcolor"]]"
								if(features["mcolor2"])
									second = "#[features["mcolor2"]]"
								if(features["mcolor3"])
									third = "#[features["mcolor3"]]"
								marking_list += list(list(first, second, third)) // just assume its 3 colours if it isnt it doesnt matter we just wont use the other values
							// index magic
							var/primary_index = 1
							var/secondary_index = 2
							var/tertiary_index = 3
							switch(matrixed_sections)
								if(MATRIX_GREEN)
									primary_index = 2
								if(MATRIX_BLUE)
									primary_index = 3
								if(MATRIX_RED_BLUE)
									secondary_index = 2
								if(MATRIX_GREEN_BLUE)
									primary_index = 2
									secondary_index = 3

							// we know it has one matrixed section at minimum
							color_marking_dat += "<span style='border: 1px solid #161616; background-color: [marking_list[3][primary_index]];'>&nbsp;&nbsp;&nbsp;</span>"
							// if it has a second section, add it
							if(matrixed_sections == MATRIX_RED_BLUE || matrixed_sections == MATRIX_GREEN_BLUE || matrixed_sections == MATRIX_RED_GREEN || matrixed_sections == MATRIX_ALL)
								color_marking_dat += "<span style='border: 1px solid #161616; background-color: [marking_list[3][secondary_index]];'>&nbsp;&nbsp;&nbsp;</span>"
								number_colors = 2
							// if it has a third section, add it
							if(matrixed_sections == MATRIX_ALL)
								color_marking_dat += "<span style='border: 1px solid #161616; background-color: [marking_list[3][tertiary_index]];'>&nbsp;&nbsp;&nbsp;</span>"
								number_colors = 3
							color_marking_dat += " <a href='?_src_=prefs;preference=marking_color;marking_index=[marking_index];marking_type=[marking_type];number_colors=[number_colors];task=input'>Change</a><BR>"
						dat += "<tr><td>[marking_list[2]] - [actual_name]</td> <td><a href='?_src_=prefs;preference=marking_down;task=input;marking_index=[marking_index];marking_type=[marking_type];'>&#708;</a> <a href='?_src_=prefs;preference=marking_up;task=input;marking_index=[marking_index];marking_type=[marking_type]'>&#709;</a> <a href='?_src_=prefs;preference=marking_remove;task=input;marking_index=[marking_index];marking_type=[marking_type]'>X</a> [color_marking_dat]</td></tr>"
					dat += "</table>"

			for(var/mutant_part in GLOB.all_mutant_parts)
				if(mutant_part == "mam_body_markings")
					continue
				if(parent.can_have_part(mutant_part))
					if(!mutant_category)
						dat += APPEARANCE_CATEGORY_COLUMN
					dat += "<h3>[GLOB.all_mutant_parts[mutant_part]]</h3>"
					dat += "<a style='display:block;width:100px' href='?_src_=prefs;preference=[mutant_part];task=input'>[features[mutant_part]]</a>"
					var/color_type = GLOB.colored_mutant_parts[mutant_part] //if it can be coloured, show the appropriate button
					if(color_type)
						dat += "<span style='border:1px solid #161616; background-color: #[features[color_type]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=[color_type];task=input'>Change</a><BR>"
					else
						if(features["color_scheme"] == ADVANCED_CHARACTER_COLORING) //advanced individual part colouring system
							//is it matrixed or does it have extra parts to be coloured?
							var/find_part = features[mutant_part] || pref_species.mutant_bodyparts[mutant_part]
							var/find_part_list = GLOB.mutant_reference_list[mutant_part]
							if(find_part && find_part != "None" && find_part_list)
								var/datum/sprite_accessory/accessory = find_part_list[find_part]
								if(accessory)
									if(accessory.color_src == MATRIXED || accessory.color_src == MUTCOLORS || accessory.color_src == MUTCOLORS2 || accessory.color_src == MUTCOLORS3) //mutcolors1-3 are deprecated now, please don't rely on these in the future
										var/mutant_string = accessory.mutant_part_string
										var/primary_feature = "[mutant_string]_primary"
										var/secondary_feature = "[mutant_string]_secondary"
										var/tertiary_feature = "[mutant_string]_tertiary"
										if(!features[primary_feature])
											features[primary_feature] = features["mcolor"]
										if(!features[secondary_feature])
											features[secondary_feature] = features["mcolor2"]
										if(!features[tertiary_feature])
											features[tertiary_feature] = features["mcolor3"]

										var/matrixed_sections = accessory.matrixed_sections
										if(accessory.color_src == MATRIXED && !matrixed_sections)
											message_admins("Sprite Accessory Failure (customization): Accessory [accessory.type] is a matrixed item without any matrixed sections set!")
											continue
										else if(accessory.color_src == MATRIXED)
											switch(matrixed_sections)
												if(MATRIX_GREEN) //only composed of a green section
													primary_feature = secondary_feature //swap primary for secondary, so it properly assigns the second colour, reserved for the green section
												if(MATRIX_BLUE)
													primary_feature = tertiary_feature //same as above, but the tertiary feature is for the blue section
												if(MATRIX_RED_BLUE) //composed of a red and blue section
													secondary_feature = tertiary_feature //swap secondary for tertiary, as blue should always be tertiary
												if(MATRIX_GREEN_BLUE) //composed of a green and blue section
													primary_feature = secondary_feature //swap primary for secondary, as first option is green, which is linked to the secondary
													secondary_feature = tertiary_feature //swap secondary for tertiary, as second option is blue, which is linked to the tertiary
										dat += "<b>Primary Color</b><BR>"
										dat += "<span style='border:1px solid #161616; background-color: #[features[primary_feature]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=[primary_feature];task=input'>Change</a><BR>"
										if((accessory.color_src == MATRIXED && (matrixed_sections == MATRIX_RED_BLUE || matrixed_sections == MATRIX_GREEN_BLUE || matrixed_sections == MATRIX_RED_GREEN || matrixed_sections == MATRIX_ALL)) || (accessory.extra && (accessory.extra_color_src == MUTCOLORS || accessory.extra_color_src == MUTCOLORS2 || accessory.extra_color_src == MUTCOLORS3)))
											dat += "<b>Secondary Color</b><BR>"
											dat += "<span style='border:1px solid #161616; background-color: #[features[secondary_feature]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=[secondary_feature];task=input'>Change</a><BR>"
											if((accessory.color_src == MATRIXED && matrixed_sections == MATRIX_ALL) || (accessory.extra2 && (accessory.extra2_color_src == MUTCOLORS || accessory.extra2_color_src == MUTCOLORS2 || accessory.extra2_color_src == MUTCOLORS3)))
												dat += "<b>Tertiary Color</b><BR>"
												dat += "<span style='border:1px solid #161616; background-color: #[features[tertiary_feature]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=[tertiary_feature];task=input'>Change</a><BR>"

					mutant_category++
					if(mutant_category >= MAX_MUTANT_ROWS)
						dat += "</td>"
						mutant_category = 0

			if(mutant_category)
				dat += "</td>"
				mutant_category = 0

			dat += "</tr></table>"

			dat += "</td>"

			dat += "</tr></table>"
			/*Uplink choice disabled since not implemented, pointless button
			dat += "<b>Uplink Location:</b><a style='display:block;width:100px' href ='?_src_=prefs;preference=uplink_loc;task=input'>[uplink_spawn_loc]</a>"
			dat += "</td>"*/

			/// HA HA! I HAVE DELETED YOUR PRECIOUS NAUGHTY PARTS, YOU HORNY ANIMALS! 
			/* dat +="<td width='220px' height='300px' valign='top'>" //
			if(NOGENITALS in pref_species.species_traits)
				dat += "<b>Your species ([pref_species.name]) does not support genitals!</b><br>"
			else
				dat += "<h3>Penis</h3>"
				dat += "<a style='display:block;width:50px' href='?_src_=prefs;preference=has_cock'>[features["has_cock"] == TRUE ? "Yes" : "No"]</a>"
				if(features["has_cock"])
					if(!pref_species.use_skintones)
						dat += "<b>Penis Color:</b></a><BR>"
						dat += "<span style='border: 1px solid #161616; background-color: #[features["cock_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=cock_color;task=input'>Change</a><br>"
					var/tauric_shape = FALSE
					if(features["cock_taur"])
						var/datum/sprite_accessory/penis/P = GLOB.cock_shapes_list[features["cock_shape"]]
						if(P.taur_icon && parent.can_have_part("taur"))
							var/datum/sprite_accessory/taur/T = GLOB.taur_list[features["taur"]]
							if(T.taur_mode & P.accepted_taurs)
								tauric_shape = TRUE
					dat += "<b>Penis Shape:</b> <a style='display:block;width:120px' href='?_src_=prefs;preference=cock_shape;task=input'>[features["cock_shape"]][tauric_shape ? " (Taur)" : ""]</a>"
					dat += "<b>Penis Length:</b> <a style='display:block;width:120px' href='?_src_=prefs;preference=cock_length;task=input'>[features["cock_length"]] inch(es)</a>"
					dat += "<b>Penis Visibility:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=cock_visibility;task=input'>[features["cock_visibility"]]</a>"
					dat += "<b>Has Testicles:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=has_balls'>[features["has_balls"] == TRUE ? "Yes" : "No"]</a>"
					if(features["has_balls"])
						if(!pref_species.use_skintones)
							dat += "<b>Testicles Type:</b> <a style='display:block;width:100px' href='?_src_=prefs;preference=balls_shape;task=input'>[features["balls_shape"]]</a>"
							dat += "<b>Testicles Color:</b></a><BR>"
							dat += "<span style='border: 1px solid #161616; background-color: #[features["balls_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=balls_color;task=input'>Change</a><br>"
						dat += "<b>Testicles Visibility:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=balls_visibility;task=input'>[features["balls_visibility"]]</a>"
				dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<h3>Vagina</h3>"
				dat += "<a style='display:block;width:50px' href='?_src_=prefs;preference=has_vag'>[features["has_vag"] == TRUE ? "Yes": "No" ]</a>"
				if(features["has_vag"])
					dat += "<b>Vagina Type:</b> <a style='display:block;width:100px' href='?_src_=prefs;preference=vag_shape;task=input'>[features["vag_shape"]]</a>"
					if(!pref_species.use_skintones)
						dat += "<b>Vagina Color:</b></a><BR>"
						dat += "<span style='border: 1px solid #161616; background-color: #[features["vag_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=vag_color;task=input'>Change</a><br>"
					dat += "<b>Vagina Visibility:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=vag_visibility;task=input'>[features["vag_visibility"]]</a>"
					dat += "<b>Has Womb:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=has_womb'>[features["has_womb"] == TRUE ? "Yes" : "No"]</a>"
				dat += "</td>"
				dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<h3>Breasts</h3>"
				dat += "<a style='display:block;width:50px' href='?_src_=prefs;preference=has_breasts'>[features["has_breasts"] == TRUE ? "Yes" : "No" ]</a>"
				if(features["has_breasts"])
					if(!pref_species.use_skintones)
						dat += "<b>Color:</b></a><BR>"
						dat += "<span style='border: 1px solid #161616; background-color: #[features["breasts_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=breasts_color;task=input'>Change</a><br>"
					dat += "<b>Cup Size:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=breasts_size;task=input'>[features["breasts_size"]]</a>"
					dat += "<b>Breasts Shape:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=breasts_shape;task=input'>[features["breasts_shape"]]</a>"
					dat += "<b>Breasts Visibility:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=breasts_visibility;task=input'>[features["breasts_visibility"]]</a>"
					dat += "<b>Lactates:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=breasts_producing'>[features["breasts_producing"] == TRUE ? "Yes" : "No"]</a>"
				dat += "</td>"
				dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<h3>Belly</h3>"
				dat += "<a style='display:block;width:50px' href='?_src_=prefs;preference=has_belly'>[features["has_belly"] == TRUE ? "Yes" : "No" ]</a>"
				if(features["has_belly"])
					if(!pref_species.use_skintones)
						dat += "<b>Color:</b></a><BR>"
						dat += "<span style='border: 1px solid #161616; background-color: #[features["belly_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=belly_color;task=input'>Change</a><br>"
					dat += "<b>Belly Size:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=belly_size;task=input'>[features["belly_size"]]</a>"
					dat += "<b>Belly Shape:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=belly_shape;task=input'>[features["belly_shape"]]</a>"
					dat += "<b>Belly Visibility:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=belly_visibility;task=input'>[features["belly_visibility"]]</a>"
				dat += "</td>"
				dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<h3>Butt</h3>"
				dat += "<a style='display:block;width:50px' href='?_src_=prefs;preference=has_butt'>[features["has_butt"] == TRUE ? "Yes" : "No"]</a>"
				if(features["has_butt"])
					if(!pref_species.use_skintones)
						dat += "<b>Color:</b></a><BR>"
						dat += "<span style='border: 1px solid #161616; background-color: #[features["butt_color"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=butt_color;task=input'>Change</a><br>"
					dat += "<b>Butt Size:</b><a style='display:block;width:50px' href='?_src_=prefs;preference=butt_size;task=input'>[features["butt_size"]]</a>"
					dat += "<b>Butt Visibility:</b><a style='display:block;width:100px' href='?_src_=prefs;preference=butt_visibility;task=input'>[features["butt_visibility"]]</a>"
				dat += "</td>"
			dat += "</td>"
			dat += "</tr></table>"*/

		if(CHAR_INFO_TAB)
			if(path)
				var/savefile/S = new /savefile(path)
				if(S)
					dat += "<center>"
					var/name
					var/unspaced_slots = 0
					for(var/i=1, i<=max_save_slots, i++)
						unspaced_slots++
						if(unspaced_slots > 8)
							dat += "<br>"
							unspaced_slots = 0
						S.cd = "/character[i]"
						S["real_name"] >> name
						if(!name)
							name = "Character[i]"
						dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=changeslot;num=[i];' [i == default_slot ? "class='linkOn'" : ""]>[name]</a> "
					dat += "</center>"
			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += APPEARANCE_CATEGORY_COLUMN
			dat += "<h3>Flavor Text</h3>"
			dat += "<a href='?_src_=prefs;preference=flavor_text;task=input'><b>Set Examine Text</b></a><br>"
			if(length(features["flavor_text"]) <= 40)
				if(!length(features["flavor_text"]))
					dat += "\[...\]"
				else
					dat += "[features["flavor_text"]]"
			else
				dat += "[TextPreview(features["flavor_text"])]...<BR>"
			dat += "<h3>Silicon Flavor Text</h3>"
			dat += "<a href='?_src_=prefs;preference=silicon_flavor_text;task=input'><b>Set Silicon Examine Text</b></a><br>"
			if(length(features["silicon_flavor_text"]) <= 40)
				if(!length(features["silicon_flavor_text"]))
					dat += "\[...\]"
				else
					dat += "[features["silicon_flavor_text"]]"
			else
				dat += "[TextPreview(features["silicon_flavor_text"])]...<BR>"
			dat += "<h3>OOC notes</h3>"
			dat += "<a href='?_src_=prefs;preference=ooc_notes;task=input'><b>Set OOC notes</b></a><br>"
			var/ooc_notes_len = length(features["ooc_notes"])
			if(ooc_notes_len <= 40)
				if(!ooc_notes_len)
					dat += "\[...\]<br>"
				else
					dat += "[features["ooc_notes"]]<br>"
			else
				dat += "[TextPreview(features["ooc_notes"])]...<br>"

			dat += "<a href='?_src_=prefs;preference=background_info_notes;task=input'><b>Set Background Info Notes</b></a><br>"
			var/background_info_notes_len = length(features["background_info_notes"])
			if(background_info_notes_len <= 40)
				if(!background_info_notes_len)
					dat += "\[...\]<br>"
				else
					dat += "[features["background_info_notes"]]<br>"
			else
				dat += "[TextPreview(features["background_info_notes"])]...<br>"

			//outside link stuff
			dat += "<h3>Outer hyper-links settings</h3>"
			dat += "<a href='?_src_=prefs;preference=flist;task=input'><b>Set F-list link</b></a><br>"
			var/flist_len = length(features["flist"])
			if(flist_len <= 40)
				if(!flist_len)
					dat += "\[...\]"
				else
					dat += "[features["flist"]]"
			else
				dat += "[TextPreview(features["flist"])]...<br>"

			dat += "</td>"
			dat += APPEARANCE_CATEGORY_COLUMN

			//Start Creature Character
			dat += "<h2>Simple Creature Character</h2>"
			dat += "<b>Creature Species</b><a style='display:block;width:100px' href='?_src_=prefs;preference=creature_species;task=input'>[creature_species ? creature_species : "Eevee"]</a><BR>"
			dat += "<b>Creature Name</b><a style='display:block;width:100px' href='?_src_=prefs;preference=creature_name;task=input'>[creature_name ? creature_name : "Eevee"]</a><BR>"
			/*
			if(CONFIG_GET(number/body_size_min) != CONFIG_GET(number/body_size_max))
				dat += "<b>Size:</b> <a href='?_src_=prefs;preference=creature_body_size;task=input'>[creature_body_size*100]%</a><br>"
			dat += "<b>Scaling:</b> <a href='?_src_=prefs;preference=creature_toggle_fuzzy;task=input'>[creature_fuzzy ? "Fuzzy" : "Sharp"]</a><br>"
			*/
			dat += "<a href='?_src_=prefs;preference=creature_flavor_text;task=input'><b>Set Creature Examine Text</b></a><br>"
			if(length(creature_flavor_text) <= 40)
				if(!length(creature_flavor_text))
					dat += "\[...\]<br>"
				else
					dat += "[creature_flavor_text]<br>"
			else
				dat += "[TextPreview(creature_flavor_text)]...<br>"
			dat += "<a href='?_src_=prefs;preference=creature_ooc;task=input'><b>Set Creature OOC Notes</b></a><br>"
			if(length(creature_ooc) <= 40)
				if(!length(creature_ooc))
					dat += "\[...\]<br>"
				else
					dat += "[creature_ooc]<br>"
			else
				dat += "[TextPreview(creature_ooc)]...<br>"
			if(creature_species)
				if(!LAZYLEN(GLOB.creature_selectable))
					generate_selectable_creatures()
				if(!(creature_species in GLOB.creature_selectable))
					creature_species = initial(creature_species)
				dat += "[icon2base64html(GLOB.creature_selectable_icons[creature_species])]<br>"
			// End creature Character

			dat += "</td>"
			dat += APPEARANCE_CATEGORY_COLUMN

			dat += "<h2>Voice</h2>"
			dat += "<b>Custom Tongue:</b><br>"
			dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=tongue;task=input'>[custom_tongue]</a><br>"

			// Coyote ADD: Blurbleblurhs
			dat += "<b>Voice Sound:</b></b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_sound;task=input'>[features_speech["typing_indicator_sound"]]</a><br>"
			dat += "<b>Voice When:</b></b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_sound_play;task=input'>[features_speech["typing_indicator_sound_play"]]</a><br>"			
			dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_speed;task=input'>[features_speech["typing_indicator_speed"]]</a><br>"
			dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_pitch;task=input'>[features_speech["typing_indicator_pitch"]]</a><br>"
			dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_variance;task=input'>[features_speech["typing_indicator_variance"]]</a><br>"
			dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_volume;task=input'>[features_speech["typing_indicator_volume"]]</a><br>"
			dat += "</b><a style='display:block;width:100px' href='?_src_=prefs;preference=typing_indicator_max_words_spoken;task=input'>[features_speech["typing_indicator_max_words_spoken"]]</a><br>"
			dat += "</td>"
			
			dat += APPEARANCE_CATEGORY_COLUMN
			dat += "<center><h2>Custom Say Verbs</h2></center>"
			dat += "<a href='?_src_=prefs;preference=custom_say;verbtype=custom_say;task=input'>Says</a>"
			dat += "<BR><a href='?_src_=prefs;preference=custom_say;verbtype=custom_whisper;task=input'>Whispers</a>"
			dat += "<BR><a href='?_src_=prefs;preference=custom_say;verbtype=custom_ask;task=input'>Asks</a>"
			dat += "<BR><a href='?_src_=prefs;preference=custom_say;verbtype=custom_exclaim;task=input'>Exclaims</a>"
			dat += "<BR><a href='?_src_=prefs;preference=custom_say;verbtype=custom_yell;task=input'>Yells</a>"
			dat += "<BR><a href='?_src_=prefs;preference=custom_say;verbtype=custom_sing;task=input'>Sings</a>"
			//dat += "<BR><a href='?_src_=prefs;preference=soundindicatorpreview'>Preview Sound Indicator</a><BR>"
			dat += "</td>"
			// Coyote ADD: End
		/// just kidding I moved it down here lol
		if(ERP_TAB) // hoo haw preferences
			if(path)
				var/savefile/S = new /savefile(path)
				if(S)
					dat += "<center>"
					var/name
					var/unspaced_slots = 0
					for(var/i=1, i<=max_save_slots, i++)
						unspaced_slots++
						if(unspaced_slots > 8)
							dat += "<br>"
							unspaced_slots = 0
						S.cd = "/character[i]"
						S["real_name"] >> name
						if(!name)
							name = "Character[i]"
						dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=changeslot;num=[i];' [i == default_slot ? "class='linkOn'" : ""]>[name]</a> "
					dat += "<hr><br>"
			if(!path)
				dat += "<div class='notice'>Please create an account to save your preferences</div>"
			if(NOGENITALS in pref_species.species_traits)
				dat += "<div class='gen_setting_name'>Your species ([pref_species.name]) does not support genitals! These won't apply to your species!</div><br><hr>"
			dat += {"<a 
						href='
							?_src_=prefs;
							preference=erp_tab;
							newtab=[ERP_TAB_REARRANGE]' 
							[current_tab == ERP_TAB_REARRANGE ? "class='linkOn'" : ""]>
								Layering and Visibility
					</a>"}
			dat += {"<a 
						href='
							?_src_=prefs;
							preference=erp_tab;
							newtab=[ERP_TAB_HOME]' 
							[current_tab == ERP_TAB_HOME ? "class='linkOn'" : ""]>
								Underwear and Socks
					</a>"}
			dat += "<br>"
			// here be gonads
			for(var/dic in PREFS_ALL_HAS_GENITALS)
				dat += {"<a 
							href='
								?_src_=prefs;
								preference=erp_tab;
								newtab=[dic];
								nonumber=yes' 
								[current_tab == dic ? "class='linkOn'" : ""]>
									[GLOB.hasgenital2genital[dic]]
						</a>"}
			dat += "</center>"
			dat += "<br>"

			switch(erp_tab_page)
				if(ERP_TAB_REARRANGE)
					var/list/all_genitals = decode_cockstring() // i made it i can call it whatever I want
					var/list/genitals_we_have = list()
					dat += "<table class='table_genital_list'>"
					dat += "<tr>"
					dat += "<td class='genital_name'></td>"
					dat += "<td colspan='2' class='genital_name'>Shift</td>"
					dat += "<td colspan='2' class='genital_name'>Hidden by...</td>"
					dat += "<td class='genital_name'>Override</td>"
					dat += "<td class='genital_name'>See on others?</td>"
					dat += "</tr>"

					for(var/nad in all_genitals)
						genitals_we_have += nad
					if(LAZYLEN(all_genitals))
						for(var/i in 1 to LAZYLEN(genitals_we_have))
							dat += add_genital_layer_piece(genitals_we_have[i], i, LAZYLEN(genitals_we_have))
					else
						dat += "You dont seem to have any movable genitals!"
					dat += "<tr>"
					dat += "<td colspan='4' class='genital_name'>Hide Undies In Preview</td>"
					/* var/genital_shirtlayer
					if(CHECK_BITFIELD(features["genital_visibility_flags"], GENITAL_ABOVE_UNDERWEAR))
						genital_shirtlayer = "Over Underwear"
					else if(CHECK_BITFIELD(features["genital_visibility_flags"], GENITAL_ABOVE_CLOTHING))
						genital_shirtlayer = "Over Clothes"
					else
						genital_shirtlayer = "Under Underwear" */
					dat += {"<td class='coverage_on'>
							<a 
								class='clicky' 
								href='
									?_src_=prefs;
									preference=toggle_undie_preview';
									task=input'>
										[preview_hide_undies ? "Hidden" : "Visible"]
							</a>
						</td>"}

					dat += {"<td colspan='1' class='coverage_on'>
							Over Clothes
							</td>"}
					dat += {"<td class='coverage_on'>
							<a 
								class='clicky_no_border'
								href='
									?_src_=prefs;
									preference=change_genital_whitelist'>
										Whitelisted Names
							</a>
							</td>"}
					dat += "</table>"
				if(ERP_TAB_HOME)/// UNDERWEAR GOES HERE
					dat += "<table class='undies_table'>"
					dat += "<tr class='undies_row'>"
					dat += "<td colspan='3'>"
					dat += "<h2 class='undies_header'>Clothing & Equipment</h2>"
					dat += "</td>"
					dat += "</tr>"
					dat += "<tr class='undies_row'>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>Topwear</div>"
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=undershirt;
									task=input'>
										[undershirt]
							</a>"}
					dat += {"<a 
								class='undies_link'
								style='
									background-color:#[shirt_color]' 
								href='
								?_src_=prefs;
								preference=shirt_color;
								task=input'>
									\t#[shirt_color]
							</a>"}
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=undershirt_overclothes;
									task=input'>
										[LAZYACCESS(GLOB.undie_position_strings, undershirt_overclothes + 1)]
							</a>"}
					dat += "</td>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>Bottomwear</div>"
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=underwear;
									task=input'>
										[underwear]
							</a>"}
					dat += {"<a 
								class='undies_link'
								style='
									background-color:#[undie_color]' 
								href='
								?_src_=prefs;
								preference=undie_color;
								task=input'>
									\t#[undie_color]
							</a>"}
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=undies_overclothes;
									task=input'>
										[LAZYACCESS(GLOB.undie_position_strings, undies_overclothes + 1)]
							</a>"}
					dat += "</td>"
					dat += {"<td class='undies_cell'>
								<div class='undies_label'>Legwear</div>
								<a 
									class='undies_link' 
									href='
										?_src_=prefs;
										preference=socks;
										task=input'>
											[socks]
								</a>"}
					dat += {"<a 
								class='undies_link'
								style='
									background-color:#[socks_color]' 
								href='
								?_src_=prefs;
								preference=socks_color;
								task=input'>
									\t#[socks_color]
							</a>"}
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=socks_overclothes;
									task=input'>
										[LAZYACCESS(GLOB.undie_position_strings, socks_overclothes + 1)]
							</a>"}
					dat += "</td>"
					dat += "</tr>"
					dat += "<tr class='undies_row'>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>Backpack</div>"
					dat += {"<a 
								class='undies_link' 
								href='
								?_src_=prefs;
								preference=bag;
								task=input'>
								[backbag]
							</a>"}
					dat += "<div class='undies_link'>-</div>"
					dat += "</td>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>Persistent Scars</div>"
					dat += {"<a 
									class='undies_link' 
									href='
										?_src_=prefs;
										preference=persistent_scars'>
											[persistent_scars ? "Enabled" : "Disabled"]
								</a>"}
					dat += {"<a 
									class='undies_link' 
									href='
										?_src_=prefs;
										preference=clear_scars'>
											\tClear them?
								</a>"}
					dat += "</td>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>Underwear Settings</div>"
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=underwear_hands'>
										Layered [underwear_overhands ? "OVER" : "UNDER"] hands
							</a>"}
					dat += {"<a 
								class='undies_link'>
									Cuteness: 100%
								</a>"}
					dat += "</td>"
					dat += "</tr>"
					dat += "<tr>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>Hide Undies In Preview</div>"
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=toggle_undie_preview'>
										[preview_hide_undies ? "Hidden" : "Visible"]
							</a>"}
					dat += "</td>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>PDA Style</div>"
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=choose_pda_skin'>
										[pda_skin]
							</a>"}
					dat += "</td>"
					dat += "<td class='undies_cell'>"
					dat += "<div class='undies_label'>PDA Ringmessage</div>"
					dat += {"<a 
								class='undies_link' 
								href='
									?_src_=prefs;
									preference=choose_pda_message'>
										[pda_ringmessage]
							</a>"}
					dat += "</td>"
					dat += "</tr>"
					dat += "</table>"
				if(PREFS_ALL_HAS_GENITALS_SET) // fuck it
					dat += build_genital_setup()


		if(GAME_PREFERENCES_TAB) // Game Preferences
			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += "<h2>General Settings</h2>"
			dat += "<b>Input Mode Hotkey:</b> <a href='?_src_=prefs;task=input;preference=input_mode_hotkey'>[input_mode_hotkey]</a><br>"
			dat += "<b>UI Style:</b> <a href='?_src_=prefs;task=input;preference=ui'>[UI_style]</a><br>"
			dat += "<b>tgui Monitors:</b> <a href='?_src_=prefs;preference=tgui_lock'>[(tgui_lock) ? "Primary" : "All"]</a><br>"
			dat += "<b>tgui Style:</b> <a href='?_src_=prefs;preference=tgui_fancy'>[(tgui_fancy) ? "Fancy" : "No Frills"]</a><br>"
			dat += "<b>Show Runechat Chat Bubbles:</b> <a href='?_src_=prefs;preference=chat_on_map'>[chat_on_map ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Runechat message char limit:</b> <a href='?_src_=prefs;preference=max_chat_length;task=input'>[max_chat_length]</a><br>"
			dat += "<b>See Runechat for non-mobs:</b> <a href='?_src_=prefs;preference=see_chat_non_mob'>[see_chat_non_mob ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>See Runechat emotes:</b> <a href='?_src_=prefs;preference=see_rc_emotes'>[see_rc_emotes ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Use Runechat color in chat log:</b> <a href='?_src_=prefs;preference=color_chat_log'>[color_chat_log ? "Enabled" : "Disabled"]</a><br>"
			dat += "<br>"
			dat += "<b>Action Buttons:</b> <a href='?_src_=prefs;preference=action_buttons'>[(buttons_locked) ? "Locked In Place" : "Unlocked"]</a><br>"
			dat += "<br>"
			dat += "<b>PDA Color:</b> <span style='border:1px solid #161616; background-color: [pda_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=pda_color;task=input'>Change</a><BR>"
			//dat += "<b>PDA Style:</b> <a href='?_src_=prefs;task=input;preference=pda_style'>[pda_style]</a><br>"
			//dat += "<b>PDA Reskin:</b> <a href='?_src_=prefs;task=input;preference=pda_skin'>[pda_skin]</a><br>"
			dat += "<br>"
			dat += "<b>Ghost Ears:</b> <a href='?_src_=prefs;preference=ghost_ears'>[(chat_toggles & CHAT_GHOSTEARS) ?  "All Speech":"Nearest Creatures"]</a><br>"
			dat += "<b>Ghost Radio:</b> <a href='?_src_=prefs;preference=ghost_radio'>[(chat_toggles & CHAT_GHOSTRADIO) ? "All Messages":"No Messages"]</a><br>"
			dat += "<b>Ghost Sight:</b> <a href='?_src_=prefs;preference=ghost_sight'>[(chat_toggles & CHAT_GHOSTSIGHT) ? "All Emotes":"Nearest Creatures" ]</a><br>"
			dat += "<b>Ghost Whispers:</b> <a href='?_src_=prefs;preference=ghost_whispers'>[(chat_toggles & CHAT_GHOSTWHISPER) ? "All Speech":"Nearest Creatures"]</a><br>"
			dat += "<b>Ghost PDA:</b> <a href='?_src_=prefs;preference=ghost_pda'>[(chat_toggles & CHAT_GHOSTPDA) ? "All Messages" : "Nearest Creatures"]</a><br>"
			//dat += "<b>Window Flashing:</b> <a href='?_src_=prefs;preference=winflash'>[(windowflashing) ? "Enabled":"Disabled"]</a><br>"
			dat += "<br>"
			dat += "<b>Play Hunting Horn Sounds:</b> <a href='?_src_=prefs;preference=hear_hunting_horns'>[(toggles & SOUND_HUNTINGHORN) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>Sprint Depletion Sound:</b> <a href='?_src_=prefs;preference=hear_sprint_buffer'>[(toggles & SOUND_SPRINTBUFFER) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>Play Admin MIDIs:</b> <a href='?_src_=prefs;preference=hear_midis'>[(toggles & SOUND_MIDI) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>Play Lobby Music:</b> <a href='?_src_=prefs;preference=lobby_music'>[(toggles & SOUND_LOBBY) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>See Pull Requests:</b> <a href='?_src_=prefs;preference=pull_requests'>[(chat_toggles & CHAT_PULLR) ? "Enabled":"Disabled"]</a><br>"
			dat += "<br>"
			if(user.client)
				if(unlock_content)
					dat += "<b>BYOND Membership Publicity:</b> <a href='?_src_=prefs;preference=publicity'>[(toggles & MEMBER_PUBLIC) ? "Public" : "Hidden"]</a><br>"
				if(unlock_content || check_rights_for(user.client, R_ADMIN))
					dat += "<b>OOC Color:</b> <span style='border: 1px solid #161616; background-color: [ooccolor ? ooccolor : GLOB.normal_ooc_colour];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=ooccolor;task=input'>Change</a><br>"
					dat += "<b>Antag OOC Color:</b> <span style='border: 1px solid #161616; background-color: [aooccolor ? aooccolor : GLOB.normal_aooc_colour];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=aooccolor;task=input'>Change</a><br>"

			dat += "</td>"
			if(user.client.holder)
				dat +="<td width='300px' height='300px' valign='top'>"
				dat += "<h2>Admin Settings</h2>"
				dat += "<b>Adminhelp Sounds:</b> <a href='?_src_=prefs;preference=hear_adminhelps'>[(toggles & SOUND_ADMINHELP)?"Enabled":"Disabled"]</a><br>"
				dat += "<b>Announce Login:</b> <a href='?_src_=prefs;preference=announce_login'>[(toggles & ANNOUNCE_LOGIN)?"Enabled":"Disabled"]</a><br>"
				dat += "<br>"
				dat += "<b>Combo HUD Lighting:</b> <a href = '?_src_=prefs;preference=combohud_lighting'>[(toggles & COMBOHUD_LIGHTING)?"Full-bright":"No Change"]</a><br>"
				dat += "<b>Split Admin Tabs:</b> <a href = '?_src_=prefs;preference=toggle_split_admin_tabs'>[(toggles & SPLIT_ADMIN_TABS)?"Enabled":"Disabled"]</a><br>"
				dat += "</td>"

			dat +="<td width='300px' height='300px' valign='top'>"
			dat += "<h2>Preferences</h2>" //Because fuck me if preferences can't be fucking modularized and expected to update in a reasonable timeframe.
			dat += "<b>End of round deathmatch:</b> <a href='?_src_=prefs;preference=end_of_round_deathmatch'>[end_of_round_deathmatch ? "Enabled" : "Disabled"]</a><br>"
			dat += "<h2>Citadel Preferences</h2>" //Because fuck me if preferences can't be fucking modularized and expected to update in a reasonable timeframe.
			dat += "<b>Widescreen:</b> <a href='?_src_=prefs;preference=widescreenpref'>[widescreenpref ? "Enabled ([CONFIG_GET(string/default_view)])" : "Disabled (15x15)"]</a><br>"
			dat += "<b>Auto stand:</b> <a href='?_src_=prefs;preference=autostand'>[autostand ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Auto OOC:</b> <a href='?_src_=prefs;preference=auto_ooc'>[auto_ooc ? "Disabled" : "Enabled" ]</a><br>"
			dat += "<b>Force Slot Storage HUD:</b> <a href='?_src_=prefs;preference=no_tetris_storage'>[no_tetris_storage ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Gun Cursor:</b> <a href='?_src_=prefs;preference=guncursor'>[(cb_toggles & AIM_CURSOR_ON) ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Screen Shake:</b> <a href='?_src_=prefs;preference=screenshake'>[(screenshake==100) ? "Full" : ((screenshake==0) ? "None" : "[screenshake]")]</a><br>"
			if (user && user.client && !user.client.prefs.screenshake==0)
				dat += "<b>Damage Screen Shake:</b> <a href='?_src_=prefs;preference=damagescreenshake'>[(damagescreenshake==1) ? "On" : ((damagescreenshake==0) ? "Off" : "Only when down")]</a><br>"

			dat += "<b>Show Health Smileys:</b> <a href='?_src_=prefs;preference=show_health_smilies;task=input'>[show_health_smilies ? "Enabled" : "Disabled"]</a><br>"
			dat += "<br>"
			dat += "</td>"
			dat += "</tr></table>"
			if(unlock_content)
				dat += "<b>Ghost Form:</b> <a href='?_src_=prefs;task=input;preference=ghostform'>[ghost_form]</a><br>"
				dat += "<B>Ghost Orbit: </B> <a href='?_src_=prefs;task=input;preference=ghostorbit'>[ghost_orbit]</a><br>"
			var/button_name = "If you see this something went wrong."
			switch(ghost_accs)
				if(GHOST_ACCS_FULL)
					button_name = GHOST_ACCS_FULL_NAME
				if(GHOST_ACCS_DIR)
					button_name = GHOST_ACCS_DIR_NAME
				if(GHOST_ACCS_NONE)
					button_name = GHOST_ACCS_NONE_NAME

			dat += "<b>Ghost Accessories:</b> <a href='?_src_=prefs;task=input;preference=ghostaccs'>[button_name]</a><br>"
			switch(ghost_others)
				if(GHOST_OTHERS_THEIR_SETTING)
					button_name = GHOST_OTHERS_THEIR_SETTING_NAME
				if(GHOST_OTHERS_DEFAULT_SPRITE)
					button_name = GHOST_OTHERS_DEFAULT_SPRITE_NAME
				if(GHOST_OTHERS_SIMPLE)
					button_name = GHOST_OTHERS_SIMPLE_NAME

			dat += "<b>Ghosts of Others:</b> <a href='?_src_=prefs;task=input;preference=ghostothers'>[button_name]</a><br>"
			dat += "<br>"

			dat += "<b>FPS:</b> <a href='?_src_=prefs;preference=clientfps;task=input'>[clientfps]</a><br>"

			dat += "<b>Income Updates:</b> <a href='?_src_=prefs;preference=income_pings'>[(chat_toggles & CHAT_BANKCARD) ? "Allowed" : "Muted"]</a><br>"
			dat += "<b>Hear Radio Static:</b> <a href='?_src_=prefs;preference=static_radio'>[(chat_toggles & CHAT_HEAR_RADIOSTATIC) ? "Allowed" : "Muted"]</a><br>"
			dat += "<b>Hear Radio Blurbles:</b> <a href='?_src_=prefs;preference=static_blurble'>[(chat_toggles & CHAT_HEAR_RADIOBLURBLES) ? "Allowed" : "Muted"]</a><br>"
			dat += "<br>"

			dat += "<b>Parallax (Fancy Space):</b> <a href='?_src_=prefs;preference=parallaxdown' oncontextmenu='window.location.href=\"?_src_=prefs;preference=parallaxup\";return false;'>"
			switch (parallax)
				if (PARALLAX_LOW)
					dat += "Low"
				if (PARALLAX_MED)
					dat += "Medium"
				if (PARALLAX_INSANE)
					dat += "Insane"
				if (PARALLAX_DISABLE)
					dat += "Disabled"
				else
					dat += "High"
			dat += "</a><br>"
			dat += "<b>Ambient Occlusion:</b> <a href='?_src_=prefs;preference=ambientocclusion'>[ambientocclusion ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Fit Viewport:</b> <a href='?_src_=prefs;preference=auto_fit_viewport'>[auto_fit_viewport ? "Auto" : "Manual"]</a><br>"
			dat += "<b>HUD Button Flashes:</b> <a href='?_src_=prefs;preference=hud_toggle_flash'>[hud_toggle_flash ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>HUD Button Flash Color:</b> <span style='border: 1px solid #161616; background-color: [hud_toggle_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=hud_toggle_color;task=input'>Change</a><br>"

			if (CONFIG_GET(flag/maprotation) && CONFIG_GET(flag/tgstyle_maprotation))
				var/p_map = preferred_map
				if (!p_map)
					p_map = "Default"
					if (config.defaultmap)
						p_map += " ([config.defaultmap.map_name])"
				else
					if (p_map in config.maplist)
						var/datum/map_config/VM = config.maplist[p_map]
						if (!VM)
							p_map += " (No longer exists)"
						else
							p_map = VM.map_name
					else
						p_map += " (No longer exists)"
				if(CONFIG_GET(flag/allow_map_voting))
					dat += "<b>Preferred Map:</b> <a href='?_src_=prefs;preference=preferred_map;task=input'>[p_map]</a><br>"

			dat += "</td><td width='300px' height='300px' valign='top'>"

			/*dat += "<h2>Special Role Settings</h2>"

			if(jobban_isbanned(user, ROLE_SYNDICATE))
				dat += "<font color=red><b>You are banned from antagonist roles.</b></font>"
				src.be_special = list()


			for (var/i in GLOB.special_roles)
				if(jobban_isbanned(user, i))
					dat += "<b>Be [capitalize(i)]:</b> <a href='?_src_=prefs;jobbancheck=[i]'>BANNED</a><br>"
				else
					var/days_remaining = null
					if(ispath(GLOB.special_roles[i]) && CONFIG_GET(flag/use_age_restriction_for_jobs)) //If it's a game mode antag, check if the player meets the minimum age
						var/mode_path = GLOB.special_roles[i]
						var/datum/game_mode/temp_mode = new mode_path
						days_remaining = temp_mode.get_remaining_days(user.client)

					if(days_remaining)
						dat += "<b>Be [capitalize(i)]:</b> <font color=red> \[IN [days_remaining] DAYS]</font><br>"
					else
						dat += "<b>Be [capitalize(i)]:</b> <a href='?_src_=prefs;preference=be_special;be_special_type=[i]'>[(i in be_special) ? "Enabled" : "Disabled"]</a><br>"
			dat += "<b>Midround Antagonist:</b> <a href='?_src_=prefs;preference=allow_midround_antag'>[(toggles & MIDROUND_ANTAG) ? "Enabled" : "Disabled"]</a><br>"

			dat += "<br>"
			*/
		if(LOADOUT_TAB)
			//calculate your gear points from the chosen item
			gear_points = CONFIG_GET(number/initial_gear_points)
			var/list/chosen_gear = loadout_data["SAVE_[loadout_slot]"]
			if(chosen_gear)
				for(var/loadout_item in chosen_gear)
					var/loadout_item_path = loadout_item[LOADOUT_ITEM]
					if(loadout_item_path)
						var/datum/gear/loadout_gear = text2path(loadout_item_path)
						if(loadout_gear)
							gear_points -= initial(loadout_gear.cost)
			else
				chosen_gear = list()

			dat += "<table align='center' width='100%'>"
			dat += "<tr><td colspan=4><center><b><font color='[gear_points == 0 ? "#E62100" : "#CCDDFF"]'>[gear_points]</font> loadout points remaining.</b> \[<a href='?_src_=prefs;preference=gear;clear_loadout=1'>Clear Loadout</a>\]</center></td></tr>"
			dat += "<tr><td colspan=4><center>You can choose up to [MAX_FREE_PER_CAT] free items per category.</center></td></tr>"
			dat += "<tr><td colspan=4><center><b>"

			if(!length(GLOB.loadout_items))
				dat += "<center>ERROR: No loadout categories - something is horribly wrong!"
			else
				if(!GLOB.loadout_categories[gear_category])
					gear_category = GLOB.loadout_categories[1]
				var/firstcat = TRUE
				for(var/category in GLOB.loadout_categories)
					if(firstcat)
						firstcat = FALSE
					else
						dat += " |"
					if(category == gear_category)
						dat += " <span class='linkOn'>[category]</span> "
					else
						dat += " <a href='?_src_=prefs;preference=gear;select_category=[html_encode(category)]'>[category]</a> "

				dat += "</b></center></td></tr>"
				dat += "<tr><td colspan=4><hr></td></tr>"

				dat += "<tr><td colspan=4><center><b>"

				if(!length(GLOB.loadout_categories[gear_category]))
					dat += "No subcategories detected. Something is horribly wrong!"
				else
					var/list/subcategories = GLOB.loadout_categories[gear_category]
					if(!subcategories.Find(gear_subcategory))
						gear_subcategory = subcategories[1]

					var/firstsubcat = TRUE
					for(var/subcategory in subcategories)
						if(firstsubcat)
							firstsubcat = FALSE
						else
							dat += " |"
						if(gear_subcategory == subcategory)
							dat += " <span class='linkOn'>[subcategory]</span> "
						else
							dat += " <a href='?_src_=prefs;preference=gear;select_subcategory=[html_encode(subcategory)]'>[subcategory]</a> "
					dat += "</b></center></td></tr>"

					dat += "<tr width=10% style='vertical-align:top;'><td width=15%><b>Name</b></td>"
					dat += "<td style='vertical-align:top'><b>Cost</b></td>"
					dat += "<td width=10%><font size=2><b>Restrictions</b></font></td>"
					dat += "<td width=80%><font size=2><b>Description</b></font></td></tr>"
					for(var/name in GLOB.loadout_items[gear_category][gear_subcategory])
						var/datum/gear/gear = GLOB.loadout_items[gear_category][gear_subcategory][name]
						var/donoritem = gear.donoritem
						if(donoritem && !gear.donator_ckey_check(user.ckey))
							continue
						var/class_link = ""
						var/list/loadout_item = has_loadout_gear(loadout_slot, "[gear.type]")
						var/extra_loadout_data = ""
						if(loadout_item)
							class_link = "style='white-space:normal;' class='linkOn' href='?_src_=prefs;preference=gear;toggle_gear_path=[html_encode(name)];toggle_gear=0'"
							if(gear.loadout_flags & LOADOUT_CAN_NAME)
								extra_loadout_data += "<BR><a href='?_src_=prefs;preference=gear;loadout_rename=1;loadout_gear_name=[html_encode(gear.name)];'>Name</a> [loadout_item[LOADOUT_CUSTOM_NAME] ? loadout_item[LOADOUT_CUSTOM_NAME] : "N/A"]"
							if(gear.loadout_flags & LOADOUT_CAN_DESCRIPTION)
								extra_loadout_data += "<BR><a href='?_src_=prefs;preference=gear;loadout_redescribe=1;loadout_gear_name=[html_encode(gear.name)];'>Description</a>"
						else if((gear_points - gear.cost) < 0)
							class_link = "style='white-space:normal;' class='linkOff'"
						else if(donoritem)
							class_link = "style='white-space:normal;background:#ebc42e;' href='?_src_=prefs;preference=gear;toggle_gear_path=[html_encode(name)];toggle_gear=1'"
						else
							class_link = "style='white-space:normal;' href='?_src_=prefs;preference=gear;toggle_gear_path=[html_encode(name)];toggle_gear=1'"
						dat += "<tr style='vertical-align:top;'><td width=15%><a [class_link]>[name]</a>[extra_loadout_data]</td>"
						dat += "<td width = 5% style='vertical-align:top'>[gear.cost]</td><td>"
						if(islist(gear.restricted_roles))
							if(gear.restricted_roles.len)
								if(gear.restricted_desc)
									dat += "<font size=2>"
									dat += gear.restricted_desc
									dat += "</font>"
								else
									dat += "<font size=2>"
									dat += gear.restricted_roles.Join(";")
									dat += "</font>"
						// the below line essentially means "if the loadout item is picked by the user and has a custom description, give it the custom description, otherwise give it the default description"
						//This would normally be part if an if else but because we dont have unlockable loadout items it's not
						dat += "</td><td><font size=2><i>[loadout_item ? (loadout_item[LOADOUT_CUSTOM_DESCRIPTION] ? loadout_item[LOADOUT_CUSTOM_DESCRIPTION] : gear.description) : gear.description]</i></font></td></tr>"

					dat += "</table>"
		if(CONTENT_PREFERENCES_TAB)
			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += "<h2>Adult content prefs</h2>"
			dat += "<b>Arousal:</b><a href='?_src_=prefs;preference=arousable'>[arousable == TRUE ? "Enabled" : "Disabled"]</a><BR>"
			dat += "<b>Genital examine text</b>:<a href='?_src_=prefs;preference=genital_examine'>[(cit_toggles & GENITAL_EXAMINE) ? "Enabled" : "Disabled"]</a><BR>"
			dat += "<b>Hypno:</b> <a href='?_src_=prefs;preference=never_hypno'>[(cit_toggles & NEVER_HYPNO) ? "Disallowed" : "Allowed"]</a><br>"
			dat += "<b>Ass Slapping:</b> <a href='?_src_=prefs;preference=ass_slap'>[(cit_toggles & NO_ASS_SLAP) ? "Disallowed" : "Allowed"]</a><br>"
			dat += "<b>Automatic Wagging:</b> <a href='?_src_=prefs;preference=auto_wag'>[(cit_toggles & NO_AUTO_WAG) ? "Disabled" : "Enabled"]</a><br>"
			dat += "<b>Forced Feminization:</b> <a href='?_src_=prefs;preference=feminization'>[(cit_toggles & FORCED_FEM) ? "Allowed" : "Disallowed"]</a><br>"
			dat += "<b>Forced Masculinization:</b> <a href='?_src_=prefs;preference=masculinization'>[(cit_toggles & FORCED_MASC) ? "Allowed" : "Disallowed"]</a><br>"
			dat += "<b>Lewd Hypno:</b> <a href='?_src_=prefs;preference=hypno'>[(cit_toggles & HYPNO) ? "Allowed" : "Disallowed"]</a><br>"
			dat += "<b>Bimbofication:</b> <a href='?_src_=prefs;preference=bimbo'>[(cit_toggles & BIMBOFICATION) ? "Allowed" : "Disallowed"]</a><br>"
			dat += "</td>"
			dat +="<td width='300px' height='300px' valign='top'>"
			dat += "<h2>Other content prefs</h2>"
			dat += "<b>Breast Enlargement:</b> <a href='?_src_=prefs;preference=breast_enlargement'>[(cit_toggles & BREAST_ENLARGEMENT) ? "Allowed" : "Disallowed"]</a><br>"
			dat += "<b>Penis Enlargement:</b> <a href='?_src_=prefs;preference=penis_enlargement'>[(cit_toggles & PENIS_ENLARGEMENT) ? "Allowed" : "Disallowed"]</a><br>"
			dat += "<b>Butt Enlargement:</b> <a href='?_src_=prefs;preference=butt_enlargement'>[(cit_toggles & BUTT_ENLARGEMENT) ? "Allowed" : "Disallowed"]</a><br>"
			dat += "<b>Belly Enlargement:</b> <a href='?_src_=prefs;preference=belly_enlargement'>[(cit_toggles & BELLY_ENLARGEMENT) ? "Allowed" : "Disallowed"]</a><br>"
			dat += "<h2>Vore prefs</h2>"
			dat += "<b>Master Vore Toggle:</b> <a href='?_src_=prefs;task=input;preference=master_vore_toggle'>[(master_vore_toggle) ? "Per Preferences" : "All Disabled"]</a><br>"
			if(master_vore_toggle)
				dat += "<b>Being Prey:</b> <a href='?_src_=prefs;task=input;preference=allow_being_prey'>[(allow_being_prey) ? "Allowed" : "Disallowed"]</a><br>"
				dat += "<b>Being Fed Prey:</b> <a href='?_src_=prefs;task=input;preference=allow_being_fed_prey'>[(allow_being_fed_prey) ? "Allowed" : "Disallowed"]</a><br>"
				dat += "<b>Digestion Damage:</b> <a href='?_src_=prefs;task=input;preference=allow_digestion_damage'>[(allow_digestion_damage) ? "Allowed" : "Disallowed"]</a><br>"
				dat += "<b>Digestion Death:</b> <a href='?_src_=prefs;task=input;preference=allow_digestion_death'>[(allow_digestion_death) ? "Allowed" : "Disallowed"]</a><br>"
				dat += "<b>Vore Messages:</b> <a href='?_src_=prefs;task=input;preference=allow_vore_messages'>[(allow_vore_messages) ? "Visible" : "Hidden"]</a><br>"
				dat += "<b>Vore Trash Messages:</b> <a href='?_src_=prefs;task=input;preference=allow_trash_messages'>[(allow_trash_messages) ? "Visible" : "Hidden"]</a><br>"
				dat += "<b>Vore Death Messages:</b> <a href='?_src_=prefs;task=input;preference=allow_death_messages'>[(allow_death_messages) ? "Visible" : "Hidden"]</a><br>"
				dat += "<b>Vore Eating Sounds:</b> <a href='?_src_=prefs;task=input;preference=allow_eating_sounds'>[(allow_eating_sounds) ? "Audible" : "Muted"]</a><br>"
				dat += "<b>Digestion Sounds:</b> <a href='?_src_=prefs;task=input;preference=allow_digestion_sounds'>[(allow_digestion_sounds) ? "Audible" : "Muted"]</a><br>"
			dat += "</tr></table>"
			dat += "<br>"

		if(KEYBINDINGS_TAB) // Custom keybindings
			dat += "<b>Keybindings:</b> <a href='?_src_=prefs;preference=hotkeys'>[(hotkeys) ? "Hotkeys" : "Input"]</a><br>"
			dat += "Keybindings mode controls how the game behaves with tab and map/input focus.<br>If it is on <b>Hotkeys</b>, the game will always attempt to force you to map focus, meaning keypresses are sent \
			directly to the map instead of the input. You will still be able to use the command bar, but you need to tab to do it every time you click on the game map.<br>\
			If it is on <b>Input</b>, the game will not force focus away from the input bar, and you can switch focus using TAB between these two modes: If the input bar is pink, that means that you are in non-hotkey mode, sending all keypresses of the normal \
			alphanumeric characters, punctuation, spacebar, backspace, enter, etc, typing keys into the input bar. If the input bar is white, you are in hotkey mode, meaning all keypresses go into the game's keybind handling system unless you \
			manually click on the input bar to shift focus there.<br>\
			Input mode is the closest thing to the old input system.<br>\
			<b>IMPORTANT:</b> While in input mode's non hotkey setting (tab toggled), Ctrl + KEY will send KEY to the keybind system as the key itself, not as Ctrl + KEY. This means Ctrl + T/W/A/S/D/all your familiar stuff still works, but you \
			won't be able to access any regular Ctrl binds.<br>"
			dat += "<br><b>Modifier-Independent binding</b> - This is a singular bind that works regardless of if Ctrl/Shift/Alt are held down. For example, if combat mode is bound to C in modifier-independent binds, it'll trigger regardless of if you are \
			holding down shift for sprint. <b>Each keybind can only have one independent binding, and each key can only have one keybind independently bound to it.</b>"
			// Create an inverted list of keybindings -> key
			var/list/user_binds = list()
			var/list/user_modless_binds = list()
			for (var/key in key_bindings)
				for(var/kb_name in key_bindings[key])
					user_binds[kb_name] += list(key)
			for (var/key in modless_key_bindings)
				user_modless_binds[modless_key_bindings[key]] = key

			var/list/kb_categories = list()
			// Group keybinds by category
			for (var/name in GLOB.keybindings_by_name)
				var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
				kb_categories[kb.category] += list(kb)

			dat += {"
			<style>
			span.bindname { display: inline-block; position: absolute; width: 20% ; left: 5px; padding: 5px; } \
			span.bindings { display: inline-block; position: relative; width: auto; left: 20%; width: auto; right: 20%; padding: 5px; } \
			span.independent { display: inline-block; position: absolute; width: 20%; right: 5px; padding: 5px; } \
			</style><body>
			"}

			for (var/category in kb_categories)
				dat += "<h3>[category]</h3>"
				for (var/i in kb_categories[category])
					var/datum/keybinding/kb = i
					var/current_independent_binding = user_modless_binds[kb.name] || "Unbound"
					if(!length(user_binds[kb.name]))
						dat += "<span class='bindname'>[kb.full_name]</span><span class='bindings'><a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=["Unbound"]'>Unbound</a>"
						var/list/default_keys = hotkeys ? kb.hotkey_keys : kb.classic_keys
						if(LAZYLEN(default_keys))
							dat += "| Default: [default_keys.Join(", ")]"
						dat += "</span>"
						if(!kb.special && !kb.clientside)
							dat += "<span class='independent'>Independent Binding: <a href='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[current_independent_binding];independent=1'>[current_independent_binding]</a></span>"
						dat += "<br>"
					else
						var/bound_key = user_binds[kb.name][1]
						dat += "<span class='bindname'l>[kb.full_name]</span><span class='bindings'><a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
						for(var/bound_key_index in 2 to length(user_binds[kb.name]))
							bound_key = user_binds[kb.name][bound_key_index]
							dat += " | <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
						if(length(user_binds[kb.name]) < MAX_KEYS_PER_KEYBIND)
							dat += "| <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name]'>Add Secondary</a>"
						var/list/default_keys = hotkeys ? kb.classic_keys : kb.hotkey_keys
						if(LAZYLEN(default_keys))
							dat += "| Default: [default_keys.Join(", ")]"
						dat += "</span>"
						if(!kb.special && !kb.clientside)
							dat += "<span class='independent'>Independent Binding: <a href='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[current_independent_binding];independent=1'>[current_independent_binding]</a></span>"
						dat += "<br>"

			dat += "<br><br>"
			dat += "<a href ='?_src_=prefs;preference=keybindings_reset'>\[Reset to default\]</a>"
			dat += "</body>"


	dat += "<hr><center>"

	if(!IsGuestKey(user.key))
		dat += "<a href='?_src_=prefs;preference=load'>Undo</a> "
		dat += "<a href='?_src_=prefs;preference=save'>Save Setup</a> "

	dat += "<a href='?_src_=prefs;preference=reset_all'>Reset Setup</a>"
	dat += "</center>"

	winset(user, "preferences_window", "is-visible=1;focus=0;")
	var/datum/browser/popup = new(user, "preferences_browser", "<div align='center'>Character Setup</div>", 640, 770)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(user, "preferences_window", src)

#undef APPEARANCE_CATEGORY_COLUMN
#undef MAX_MUTANT_ROWS

/// takes in whatever's at features["genital_order"] and spits out a list in order of what's present
/// reverses it cus its more intuitive that way (for everyone but me)
/datum/preferences/proc/decode_cockstring(reverse = TRUE)
	var/list/list_out = list()
	list_out = splittext(features["genital_order"], ":")
	list_out = reverseList(list_out)
	return list_out

/// takes in a list of nads and outputs a cockstring, then saves it
/// Also unreverses it, cus i crave the pain
/datum/preferences/proc/encode_cockstring(list/cockstring)
	var/list/default_cockstring = splittext(DEF_COCKSTRING, ":")
	cockstring = reverseList(cockstring)
	for(var/coc in cockstring) // just to make sure nothing wierd got in there
		if(!(coc in default_cockstring))
			cockstring -= coc
			continue
		default_cockstring -= coc
	if(LAZYLEN(default_cockstring)) // and to make sure it has *everything* oh yeah keep DEF_COCKSTRING up to date
		message_admins("Hey the cockstring wasn't empty, either Dan fucked up or something fucked up.")
	. = jointext(cockstring, ":")
	features["genital_order"] = .

/// takes in whatever's at features["genital_whitelist"] and spits out a list in order of what's present
/datum/preferences/proc/decode_cockwhitelist(reverse = TRUE)
	var/list/list_out = list()
	list_out = splittext(features["genital_whitelist"], ",") // would be a real dick move if the whitelist didnt accept whitespace
	return list_out

/// takes in a list of nads and outputs a cockstring, then saves it
/datum/preferences/proc/encode_cockwhitelist(list/cockstring)
	var/list/outlist = list()
	for(var/ckey in cockstring)
		outlist += ckey
	. = jointext(outlist, ",")
	features["genital_whitelist"] = .
	save_preferences()

/// Adds a link to a given genital
/datum/preferences/proc/build_genital_setup()
	if(!(erp_tab_page in PREFS_ALL_HAS_GENITALS))
		return "Uh oh this broke and Lagg's a dork! =3"

	/// the flags we're building the genital setup shit from
	var/setup_flags
	var/feature_key
	var/thing_name
	var/fuckin_taur_penis
	var/one_or_some
	var/size_flavor
	switch(erp_tab_page)
		if("has_butt")
			setup_flags = DEF_BUTT_FLAGS
			thing_name = "Butt"
			one_or_some = "one"
			size_flavor = "-XL"
			feature_key = "butt"
		if("has_vag")
			setup_flags = DEF_VAG_FLAGS
			thing_name = "Vagina"
			one_or_some = "one"
			feature_key = "vag"
		if("has_balls")
			setup_flags = DEF_BALLS_FLAGS
			thing_name = "Testicles"
			one_or_some = "some"
			size_flavor = " decigrundles"
			feature_key = "balls"
		if("has_cock")
			setup_flags = DEF_PENIS_FLAGS
			thing_name = "Penis"
			one_or_some = "one"
			size_flavor = " inch(es)"
			feature_key = "cock"
			if(features["cock_taur"]) // darn taurs
				var/datum/sprite_accessory/penis/P = GLOB.cock_shapes_list[features["cock_shape"]]
				if(P.taur_icon && parent.can_have_part("taur"))
					var/datum/sprite_accessory/taur/T = GLOB.taur_list[features["taur"]]
					if(T.taur_mode & P.accepted_taurs)
						fuckin_taur_penis = TRUE
		if("has_belly")
			setup_flags = DEF_BELLY_FLAGS
			thing_name = "Belly"
			one_or_some = "one"
			size_flavor = "-XL"
			feature_key = "belly"
		if("has_womb")
			setup_flags = DEF_WOMB_FLAGS
			one_or_some = "one"
			feature_key = "womb"
		if("has_breasts")
			setup_flags = DEF_BREASTS_FLAGS
			thing_name = "Breasts"
			one_or_some = "some"
			size_flavor = "-cup"
			feature_key = "breasts"

	// okay time to build it! *cracks penis*
	var/list/deet = list()
	deet += "<table class='table_genital_list'>"
	deet += "<tr class='talign'>"
	deet += "<td class='talign'>"
	deet += "<div class='gen_name'>[thing_name]</div>"
	deet += "</td></tr>"

	deet += "<tr class='talign'><td class='talign'>"
	deet += "<div class='gen_container'>"
	deet += "<div class='gen_setting_name'>Has [one_or_some]:</div>" // everyone can has_cheezburger
	/// yes I know it cursed, eat the dick this pref gave me
	deet += {"<a 
				class='clicky' 
				href='
					?_src_=prefs;
					preference=[erp_tab_page]'>
						[features[erp_tab_page] == TRUE ? "Yes" : "No"]
			</a>"}
	if(CHECK_BITFIELD(setup_flags, GENITAL_CAN_RECOLOR))
		deet += "<div class='gen_setting_name'>Color:</div>"
		if(pref_species.use_skintones)
			deet += "<div class='gen_setting_name'>Locked to skintone!</div>"
		else
			deet += {"<a 
						class='clicky'
						style='
							background-color:#[features["[feature_key]_color"]]' 
						href='
							?_src_=prefs;
							preference=[feature_key]_color;
							task=input'>
								#[features["[feature_key]_color"]]
					</a>"}
	if(CHECK_BITFIELD(setup_flags, GENITAL_CAN_RESHAPE))
		deet += "<div class='gen_setting_name'>Shape:</div>"
		deet += {"<a 
					class='clicky' 
					href='
						?_src_=prefs;
						preference=[feature_key]_shape;
						task=input'>
							[features["[feature_key]_shape"]][fuckin_taur_penis ? " (Taur)" : ""]
				</a>"}
	if(CHECK_BITFIELD(setup_flags, GENITAL_CAN_RESIZE))
		deet += "<div class='gen_setting_name'>Size:</div>"
		deet += {"<a 
					class='clicky' 
					href='
						?_src_=prefs;
						preference=[feature_key]_size;
						task=input'>
							[features["[feature_key]_size"]][size_flavor]
				</a>"}
	deet += "<div class='gen_setting_name'>Hide Undies In Preview</div>"
	deet += {"<a 
				class='clicky' 
				href='
					?_src_=prefs;
					task=input;
					preference=toggle_undie_preview'>
						[preview_hide_undies ? "Hidden" : "Visible"]
			</a>"}
	deet += "</div>"
	deet += "</td>"
	deet += "</tr>"
	deet += "</table>" // leaving this one out makes the save/undo line show up over the table, oddly enough!
	deet += "<br>"
	return deet.Join()

/// need: genital name, some kinda href shit
/// returns a hunk of html designed to fit into a table
/datum/preferences/proc/add_genital_layer_piece(has_name, index, max_index)
	var/magic_word
	var/flag_string
	var/override_string
	var/hide_nad_flag
	switch(has_name)
		if(CS_BUTT)
			magic_word = "Butt"
			flag_string = "butt_visibility_flags"
			override_string = "butt_visibility_override"
			hide_nad_flag = HIDE_BUTT
		if(CS_VAG)
			magic_word = "Vagina"
			flag_string = "vag_visibility_flags"
			override_string = "vag_visibility_override"
			hide_nad_flag = HIDE_VAG
		if(CS_BALLS)
			magic_word = "Testicles"
			flag_string = "balls_visibility_flags"
			override_string = "balls_visibility_override"
			hide_nad_flag = HIDE_BALLS
		if(CS_PENIS)
			magic_word = "Penis"
			flag_string = "cock_visibility_flags"
			override_string = "cock_visibility_override"
			hide_nad_flag = HIDE_PENIS
		if(CS_BELLY)
			magic_word = "Belly"
			flag_string = "belly_visibility_flags"
			override_string = "belly_visibility_override"
			hide_nad_flag = HIDE_BELLY
		if(CS_BOOB)
			magic_word = "Breasts"
			flag_string = "breasts_visibility_flags"
			override_string = "breasts_visibility_override"
			hide_nad_flag = HIDE_BOOBS
		if(CS_MISC) // idk some kind of broken genital
			magic_word = "Chunk"
			flag_string = "breasts_visibility_flags" // idk
			override_string = "breasts_visibility_override"
			hide_nad_flag = HIDE_MISC
	var/list/doot = list()
	doot += "<tr class='talign'>"
	// the nad's name and index
	doot += "<td class='genital_name'>[magic_word] - [index]</td>"
	if(index <= 1) // first one doesnt get an up-arrow
		doot += "<td class='genital_arrow_off'>&darr;</td>" // im gonna do a magic trick
	else // make an up arrow
		doot += {"<td class='genital_arrow_on'>
				<a 
					class='clicky_no_border'
					href='
						?_src_=prefs;
						preference=change_genital_order;
						direction=up;
						which=[has_name]'>
							&uarr;
				</a>
				</td>"}
	if(index >= max_index) // last one doesnt get a down-arrow
		doot += "<td class='genital_arrow_off'>&darr;</td>" // imma make these disappear!
	else // make a down arrow
		doot += {"<td class='genital_arrow_on'>
				<a 
					class='clicky_no_border' 
					href='
						?_src_=prefs;
						preference=change_genital_order;
						direction=down;
						which=[has_name]'>
							&darr;
				</a>
				</td>"}
	// and throw in the coverage buttons
	doot += {"<td class='[CHECK_BITFIELD(features[flag_string], GENITAL_RESPECT_CLOTHING)? "coverage_on" : "coverage_off"]'>
		<a 
			class='clicky_no_border' 
			href='
				?_src_=prefs;
				preference=[flag_string];
				genital_flag=[GENITAL_RESPECT_CLOTHING];
				task=input'>
					Clothes
		</a>
		</td>"}
	doot += {"<td class='[CHECK_BITFIELD(features[flag_string], GENITAL_RESPECT_UNDERWEAR)? "coverage_on" : "coverage_off"]'>
		<a 
			class='clicky_no_border' 
			href='
				?_src_=prefs;
				preference=[flag_string];
				genital_flag=[GENITAL_RESPECT_UNDERWEAR];
				task=input'>
					Underwear
		</a>
		</td>"}
	/// and the override
	var/peen_vis_override
	if(CHECK_BITFIELD(features[flag_string], GENITAL_ALWAYS_HIDDEN))
		peen_vis_override = "Always Hidden"
	else if(CHECK_BITFIELD(features[flag_string], GENITAL_ALWAYS_VISIBLE))
		peen_vis_override = "Always Visible"
	else
		peen_vis_override = "Check Coverage"
	doot += {"<td class='[CHECK_BITFIELD(features[flag_string], GENITAL_ALWAYS_HIDDEN|GENITAL_ALWAYS_VISIBLE)? "coverage_on" : "coverage_off"]'>
		<a 
			class='clicky_no_border' 
			href='
				?_src_=prefs;
				preference=[override_string];
				curr_vis=[peen_vis_override];
				task=input'>
					[peen_vis_override]
		</a>
		</td>"}
	/// and the hideflag
	var/i_dont_like_bellies = CHECK_BITFIELD(features["genital_hide"], hide_nad_flag)
	doot += {"<td class='[i_dont_like_bellies ? "coverage_off" : "coverage_on"]'>
		<a 
			class='clicky_no_border' 
			href='
				?_src_=prefs;
				preference=genital_hide;
				hideflag=[hide_nad_flag];
				task=input'>
					[i_dont_like_bellies ? "N" : "Y"]
		</a>
		</td>"}
	doot += "</tr>"
	return doot.Join()

/// takes our genital order, spreads it, and moves an entry up/down past the next valid entry, then zips it back into a cockstring
/datum/preferences/proc/shift_genital_order(which_one, move_up)
	if(!which_one)
		return
	var/list/our_genitals = decode_cockstring()
	if(!(which_one in our_genitals))
		return
	if(move_up) // reverse the list cus its easier to just search down the list
		our_genitals = reverseList(our_genitals) // after all, up is down upsidedown!
	var/genital_start
	var/genital_dest
	var/index = 1
	for(var/nad in our_genitals)
		if(genital_start && features[nad]) // found our nad up the list, keep checking for the next nad that exists
			genital_dest = index
			break
		if(!genital_start && nad == which_one)
			genital_start = index
		index++
	if(!genital_start || !genital_dest)
		return // nothing found!
	our_genitals.Swap(genital_start, genital_dest) // swap!
	if(move_up) // unreverse, 
		our_genitals = reverseList(our_genitals)
	encode_cockstring(our_genitals) // post it!	

/datum/preferences/proc/CaptureKeybinding(mob/user, datum/keybinding/kb, old_key, independent = FALSE, special = FALSE)
	var/HTML = {"
	<div id='focus' style="outline: 0;" tabindex=0>Keybinding: [kb.full_name]<br>[kb.description]<br><br><b>Press any key to change<br>Press ESC to clear</b></div>
	<script>
	var deedDone = false;
	document.onkeyup = function(e) {
		if(deedDone){ return; }
		var alt = e.altKey ? 1 : 0;
		var ctrl = e.ctrlKey ? 1 : 0;
		var shift = e.shiftKey ? 1 : 0;
		var numpad = (95 < e.keyCode && e.keyCode < 112) ? 1 : 0;
		var escPressed = e.keyCode == 27 ? 1 : 0;
		var url = 'byond://?_src_=prefs;preference=keybindings_set;keybinding=[kb.name];old_key=[old_key];[independent?"independent=1;":""][special?"special=1;":""]clear_key='+escPressed+';key='+e.key+';alt='+alt+';ctrl='+ctrl+';shift='+shift+';numpad='+numpad+';key_code='+e.keyCode;
		window.location=url;
		deedDone = true;
	}
	document.getElementById('focus').focus();
	</script>
	"}
	winshow(user, "capturekeypress", TRUE)
	var/datum/browser/popup = new(user, "capturekeypress", "<div align='center'>Keybindings</div>", 350, 300)
	popup.set_content(HTML)
	popup.open(FALSE)
	onclose(user, "capturekeypress", src)

/datum/preferences/proc/SetChoices(mob/user, limit = 17, list/splitJobs = list("Chief Engineer"), widthPerColumn = 295, height = 620)
	if(!SSjob)
		return

	//limit - The amount of jobs allowed per column. Defaults to 17 to make it look nice.
	//splitJobs - Allows you split the table by job. You can make different tables for each department by including their heads. Defaults to CE to make it look nice.
	//widthPerColumn - Screen's width for every column.
	//height - Screen's height.

	var/width = widthPerColumn

	var/HTML = "<center>"
	if(SSjob.occupations.len <= 0)
		HTML += "The job SSticker is not yet finished creating jobs, please try again later"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=close'>Done</a></center><br>" // Easier to press up here.

	else
		HTML += "<b>Choose occupation chances</b><br>"
		HTML += "<div align='center'>Left-click to raise an occupation preference, right-click to lower it.<br></div>"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=close'>Done</a></center><br>" // Easier to press up here.
		HTML += "<script type='text/javascript'>function setJobPrefRedirect(level, rank) { window.location.href='?_src_=prefs;preference=job;task=setJobLevel;level=' + level + ';text=' + encodeURIComponent(rank); return false; }</script>"
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'><tr><td width='20%'>" // Table within a table for alignment, also allows you to easily add more colomns.
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'>"
		var/index = -1

		//The job before the current job. I only use this to get the previous jobs color when I'm filling in blank rows.
		var/datum/job/lastJob

		for(var/datum/job/job in sortList(SSjob.occupations, GLOBAL_PROC_REF(cmp_job_display_asc)))
			if(job.total_positions == 0)
				continue

			if(job.faction == "None") //All jobs are now loaded into occupations so maps can just hide individual ones
				continue

			index += 1
			if((index >= limit) || (job.title in splitJobs))
				width += widthPerColumn
				if((index < limit) && (lastJob != null))
					//If the cells were broken up by a job in the splitJob list then it will fill in the rest of the cells with
					//the last job's selection color. Creating a rather nice effect.
					for(var/i = 0, i < (limit - index), i += 1)
						HTML += "<tr bgcolor='[lastJob.selection_color]'><td width='60%' align='right'>&nbsp</td><td>&nbsp</td></tr>"
				HTML += "</table></td><td width='20%'><table width='100%' cellpadding='1' cellspacing='0'>"
				index = 0

			HTML += "<tr bgcolor='[job.selection_color]'><td width='60%' align='right'>"
			var/rank = job.title
			lastJob = job
			if(jobban_isbanned(user, rank))
				HTML += "<font color=red>[rank]</font></td><td><a href='?_src_=prefs;bancheck=[rank]'> BANNED</a></td></tr>"
				continue
			var/required_playtime_remaining = job.required_playtime_remaining(user.client)
			if(required_playtime_remaining)
				HTML += "<font color=red>[rank]</font></td><td><font color=red> \[ [get_exp_format(required_playtime_remaining)] as [job.get_exp_req_type()] \] </font></td></tr>"
				continue
			if(!job.player_old_enough(user.client))
				var/available_in_days = job.available_in_days(user.client)
				HTML += "<font color=red>[rank]</font></td><td><font color=red> \[IN [(available_in_days)] DAYS\]</font></td></tr>"
				continue
			if(!user.client.prefs.pref_species.qualifies_for_rank(rank, user.client.prefs.features))
				if(user.client.prefs.pref_species.id == "human")
					HTML += "<font color=red>[rank]</font></td><td><font color=red><b> \[MUTANT\]</b></font></td></tr>"
				else
					HTML += "<font color=red>[rank]</font></td><td><font color=red><b> \[NON-HUMAN\]</b></font></td></tr>"
				continue
			if((job_preferences["[SSjob.overflow_role]"] == JP_LOW) && (rank != SSjob.overflow_role) && !jobban_isbanned(user, SSjob.overflow_role))
				HTML += "<font color=orange>[rank]</font></td><td></td></tr>"
				continue
			if((rank in GLOB.command_positions) || (rank == "AI"))//Bold head jobs
				HTML += "<b><span class='dark'>[rank]</span></b>"
			else
				HTML += "<span class='dark'>[rank]</span>"

			HTML += "</td><td width='40%'>"

			var/prefLevelLabel = "ERROR"
			var/prefLevelColor = "pink"
			var/prefUpperLevel = -1 // level to assign on left click
			var/prefLowerLevel = -1 // level to assign on right click

			switch(job_preferences["[job.title]"])
				if(JP_HIGH)
					prefLevelLabel = "High"
					prefLevelColor = "slateblue"
					prefUpperLevel = 4
					prefLowerLevel = 2
				if(JP_MEDIUM)
					prefLevelLabel = "Medium"
					prefLevelColor = "green"
					prefUpperLevel = 1
					prefLowerLevel = 3
				if(JP_LOW)
					prefLevelLabel = "Low"
					prefLevelColor = "orange"
					prefUpperLevel = 2
					prefLowerLevel = 4
				else
					prefLevelLabel = "NEVER"
					prefLevelColor = "red"
					prefUpperLevel = 3
					prefLowerLevel = 1

			HTML += "<a class='white' href='?_src_=prefs;preference=job;task=setJobLevel;level=[prefUpperLevel];text=[rank]' oncontextmenu='javascript:return setJobPrefRedirect([prefLowerLevel], \"[rank]\");'>"

			if(rank == SSjob.overflow_role)//Overflow is special
				if(job_preferences["[SSjob.overflow_role]"] == JP_LOW)
					HTML += "<font color=green>Yes</font>"
				else
					HTML += "<font color=red>No</font>"
				HTML += "</a></td></tr>"
				continue

			HTML += "<font color=[prefLevelColor]>[prefLevelLabel]</font>"
			HTML += "</a></td></tr>"

		for(var/i = 1, i < (limit - index), i += 1) // Finish the column so it is even
			HTML += "<tr bgcolor='[lastJob.selection_color]'><td width='60%' align='right'>&nbsp</td><td>&nbsp</td></tr>"

		HTML += "</td'></tr></table>"
		HTML += "</center></table>"

		var/message = "Be an [SSjob.overflow_role] if preferences unavailable"
		if(joblessrole == RETURNTOLOBBY)
			message = "Return to lobby if preferences unavailable"
		HTML += "<center><br><a href='?_src_=prefs;preference=job;task=random'>[message]</a></center>"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=reset'>Reset Preferences</a></center>"

	var/datum/browser/popup = new(user, "mob_occupation", "<div align='center'>Occupation Preferences</div>", width, height)
	popup.set_window_options("can_close=0")
	popup.set_content(HTML)
	popup.open(FALSE)

/datum/preferences/proc/SetJobPreferenceLevel(datum/job/job, level)
	if (!job)
		return FALSE

	if (level == JP_HIGH) // to high
		//Set all other high to medium
		for(var/j in job_preferences)
			if(job_preferences["[j]"] == JP_HIGH)
				job_preferences["[j]"] = JP_MEDIUM
				//technically break here

	job_preferences["[job.title]"] = level
	return TRUE

/datum/preferences/proc/UpdateJobPreference(mob/user, role, desiredLvl)
	if(!SSjob || SSjob.occupations.len <= 0)
		return
	var/datum/job/job = SSjob.GetJob(role)

	if(!job)
		user << browse(null, "window=mob_occupation")
		ShowChoices(user)
		return

	if (!isnum(desiredLvl))
		to_chat(user, span_danger("UpdateJobPreference - desired level was not a number. Please notify coders!"))
		ShowChoices(user)
		return

	var/jpval = null
	switch(desiredLvl)
		if(3)
			jpval = JP_LOW
		if(2)
			jpval = JP_MEDIUM
		if(1)
			jpval = JP_HIGH

	if(role == SSjob.overflow_role)
		if(job_preferences["[job.title]"] == JP_LOW)
			jpval = null
		else
			jpval = JP_LOW

	SetJobPreferenceLevel(job, jpval)
	SetChoices(user)

	return 1


/datum/preferences/proc/ResetJobs()
	job_preferences = list()

/datum/preferences/proc/SetQuirks(mob/user)
	if(!SSquirks)
		to_chat(user, span_danger("The quirk subsystem is still initializing! Try again in a minute."))
		return
	SSquirks.OpenWindow(user)

	/* RIP all taht shit
	var/list/dat = list()
	if(!SSquirks.quirks.len)
		dat += "The quirk subsystem hasn't finished initializing, please hold..."
		dat += "<center><a href='?_src_=prefs;preference=trait;task=close'>Done</a></center><br>"

	else
		dat += "<center><b>Choose quirk setup</b></center><br>"
		dat += "<div align='center'>Left-click to add or remove quirks. You need negative quirks to have positive ones.<br>\
		Quirks are applied at roundstart and cannot normally be removed.</div>"
		dat += "<center><a href='?_src_=prefs;preference=trait;task=close'>Done</a></center>"
		dat += "<hr>"
		dat += "<center><b>Current quirks:</b> [char_quirks.len ? char_quirks.Join(", ") : "None"]</center>"
		dat += "<center>[GetPositiveQuirkCount()] / [MAX_QUIRKS] max positive quirks<br>\
		<b>Quirk balance remaining:</b> [GetQuirkBalance()]<br>"
		dat += " <a href='?_src_=prefs;quirk_category=[QUIRK_POSITIVE]' [quirk_category == QUIRK_POSITIVE ? "class='linkOn'" : ""]>[QUIRK_POSITIVE]</a> "
		dat += " <a href='?_src_=prefs;quirk_category=[QUIRK_NEUTRAL]' [quirk_category == QUIRK_NEUTRAL ? "class='linkOn'" : ""]>[QUIRK_NEUTRAL]</a> "
		dat += " <a href='?_src_=prefs;quirk_category=[QUIRK_NEGATIVE]' [quirk_category == QUIRK_NEGATIVE ? "class='linkOn'" : ""]>[QUIRK_NEGATIVE]</a> "
		dat += "</center><br>"
		for(var/V in SSquirks.quirks)
			var/datum/quirk/T = SSquirks.quirks[V]
			var/value = initial(T.value)
			if(value > 0 && quirk_category != QUIRK_POSITIVE)
				continue
			if(value < 0 && quirk_category != QUIRK_NEGATIVE)
				continue
			if(value == 0 && quirk_category != QUIRK_NEUTRAL)
				continue

			var/quirk_name = initial(T.name)
			var/has_quirk
			var/quirk_cost = initial(T.value) * -1
			var/lock_reason = "This trait is unavailable."
			var/quirk_conflict = FALSE
			for(var/_V in char_quirks)
				if(_V == quirk_name)
					has_quirk = TRUE
			if(initial(T.mood_quirk) && CONFIG_GET(flag/disable_human_mood))
				lock_reason = "Mood is disabled."
				quirk_conflict = TRUE
			if(has_quirk)
				if(quirk_conflict)
					char_quirks -= quirk_name
					has_quirk = FALSE
				else
					quirk_cost *= -1 //invert it back, since we'd be regaining this amount
			if(quirk_cost > 0)
				quirk_cost = "+[quirk_cost]"
			var/font_color = "#AAAAFF"
			if(initial(T.value) != 0)
				font_color = value > 0 ? "#AAFFAA" : "#FFAAAA"
			if(quirk_conflict)
				dat += "<font color='[font_color]'>[quirk_name]</font> - [initial(T.desc)] \
				<font color='red'><b>LOCKED: [lock_reason]</b></font><br>"
			else
				if(has_quirk)
					dat += "<a href='?_src_=prefs;preference=trait;task=update;trait=[quirk_name]'>[has_quirk ? "Remove" : "Take"] ([quirk_cost] pts.)</a> \
					<b><font color='[font_color]'>[quirk_name]</font></b> - [initial(T.desc)]<br>"
				else
					dat += "<a href='?_src_=prefs;preference=trait;task=update;trait=[quirk_name]'>[has_quirk ? "Remove" : "Take"] ([quirk_cost] pts.)</a> \
					<font color='[font_color]'>[quirk_name]</font> - [initial(T.desc)]<br>"
		dat += "<br><center><a href='?_src_=prefs;preference=trait;task=reset'>Reset Quirks</a></center>"

	user << browse(null, "window=preferences")
	var/datum/browser/popup = new(user, "mob_occupation", "<div align='center'>SPECIAL</div>", 900, 600) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(0)
	return */



/datum/preferences/proc/SetSpecial(mob/user)
	var/list/dat = list()

	var/total = special_s + special_p + special_e + special_c + special_i + special_a + special_l

	dat += "<center><b>Allocate points</b></center>"
	dat += "<center>Note: SPECIAL is purely cosmetic. These points have no effect on gameplay.</center><br>"
	dat += "<center>[total] out of 40 possible</center><br>"
	dat += "<b>Strength	   :</b> <a href='?_src_=prefs;preference=special_s;task=input'>[special_s]</a><BR>"
	dat += "<b>Perception  :</b> <a href='?_src_=prefs;preference=special_p;task=input'>[special_p]</a><BR>"
	dat += "<b>Endurance   :</b> <a href='?_src_=prefs;preference=special_e;task=input'>[special_e]</a><BR>"
	dat += "<b>Charisma    :</b> <a href='?_src_=prefs;preference=special_c;task=input'>[special_c]</a><BR>"
	dat += "<b>Intelligence:</b> <a href='?_src_=prefs;preference=special_i;task=input'>[special_i]</a><BR>"
	dat += "<b>Agility     :</b> <a href='?_src_=prefs;preference=special_a;task=input'>[special_a]</a><BR>"
	dat += "<b>Luck        :</b> <a href='?_src_=prefs;preference=special_l;task=input'>[special_l]</a><BR>"
	if (total>40)
		dat += "<center>Maximum exceeded, please change until your total is at or below 40<center>"
	else
		dat += "<center><a href='?_src_=prefs;preference=special;task=close'>Done</a></center>"

	user << browse(null, "window=preferences")
	var/datum/browser/popup = new(user, "mob_occupation", "<div align='center'>S.P.E.C.I.A.L</div>", 300, 400) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(0)
	return

// /datum/preferences/proc/GetQuirkBalance()
// 	var/bal = 100
// 	for(var/V in char_quirks)
// 		var/datum/quirk/T = SSquirks.quirks[V]
// 		bal -= initial(T.value)
// 	for(var/modification in modified_limbs)
// 		if(modified_limbs[modification][1] == LOADOUT_LIMB_PROSTHETIC)
// 			return bal + 33 //max 33 point regardless of how many prosthetics
// 	return bal

/datum/preferences/proc/update_genital_whitelist()
	var/new_genital_whitelist = stripped_multiline_input_or_reflect(
		parent, 
		"Which people are you okay with seeing their genitals when exposed? If a humanlike mob has a name containing \
		any of the following, if their genitals are showing, you will be able to see them, regardless of your \
		content settings. Partial names are accepted, case is not important, please no punctuation (except ','). \
		Separate your entries with a comma!",
		"Genital Whitelist",
		genital_whitelist)
	if(isnull(new_genital_whitelist))
		to_chat(parent, "Never mind!!")
		return
	if(trim(new_genital_whitelist) == "" && trim(genital_whitelist) != "")
		var/whoa = alert(usr, "Are you sure you want to clear your genital whitelist?", "Clear Genital Whitelist", "Yes", "No")
		if(whoa == "No")
			to_chat(parent, "Never mind!!")
			return
	genital_whitelist = new_genital_whitelist
	to_chat(parent, span_notice("Updated your genital whitelist! It should kick in soon!"))
	save_preferences()

/datum/preferences/Topic(href, href_list, hsrc)			//yeah, gotta do this I guess..
	. = ..()
	if(href_list["close"])
		var/client/C = usr.client
		if(C)
			C.clear_character_previews()

/datum/preferences/proc/process_link(mob/user, list/href_list)
	if(href_list["jobbancheck"])
		var/datum/db_query/query_get_jobban = SSdbcore.NewQuery(
			"SELECT reason, bantime, duration, expiration_time, IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE [format_table_name("player")].ckey = [format_table_name("ban")].a_ckey), a_ckey) FROM [format_table_name("ban")] WHERE ckey = :ckey AND (bantype = 'JOB_PERMABAN'  OR (bantype = 'JOB_TEMPBAN' AND expiration_time > Now())) AND isnull(unbanned) AND job = :job",
			list("ckey" = user.ckey, "job" = href_list["jobbancheck"])
		)
		if(!query_get_jobban.warn_execute())
			qdel(query_get_jobban)
			return
		if(query_get_jobban.NextRow())
			var/reason = unsanitizeSQL(query_get_jobban.item[1])
			var/bantime = query_get_jobban.item[2]
			var/duration = query_get_jobban.item[3]
			var/expiration_time = query_get_jobban.item[4]
			var/admin_key = query_get_jobban.item[5]
			var/text
			text = "<span class='redtext'>You, or another user of this computer, ([user.key]) is banned from playing [href_list["jobbancheck"]]. The ban reason is:<br>[reason]<br>This ban was applied by [admin_key] on [bantime]"
			if(text2num(duration) > 0)
				text += ". The ban is for [duration] minutes and expires on [expiration_time] (server time)"
			text += ".</span>"
			to_chat(user, text)
		qdel(query_get_jobban)
		return

	if(href_list["preference"] == "quirk_migrate")
		SSquirks.ConvertOldQuirklistToNewQuirklist(src, )
	if(href_list["preference"] == "change_genital_order")
		shift_genital_order(href_list["which"], (href_list["direction"]=="up"))
	if(href_list["preference"] == "change_genital_whitelist")
		update_genital_whitelist()
	if(href_list["preference"] == "change_genital_clothing")
		var/list/genital_overrides = GENITAL_CLOTHING_FLAG_LIST
		var/new_visibility = input(user, "When your genitals are visible, how should they appear in relation to your clothes/underwear?", "Character Preference", href_list["nadflag"]) as null|anything in GENITAL_CLOTHING_FLAG_LIST
		if(new_visibility)
			var/new_bit = genital_overrides[new_visibility]
			for(var/nadlet in GENITAL_VIS_FLAGS_LIST)
				DISABLE_BITFIELD(features[nadlet], GENITAL_ABOVE_UNDERWEAR | GENITAL_ABOVE_CLOTHING)
				ENABLE_BITFIELD(features[nadlet], new_bit)
			features["genital_visibility_flags"] = new_bit
	if(href_list["preference"] == "toggle_undie_preview")
		TOGGLE_VAR(preview_hide_undies)

	if(href_list["preference"] == "choose_pda_skin")
		var/pickedPDASkin = input(user, "Choose your DataPal appearance. (You can change this in-game by ctrl-shift-clicking the DataPal!)", "Character Preference", pda_skin) as null|anything in GLOB.pda_skins
		if(pickedPDASkin)
			pda_skin = pickedPDASkin

	if(href_list["preference"] == "choose_pda_message")
		var/new_message = stripped_multiline_input_or_reflect(
			user, 
			"What message would you like to display when someone rings your DataPal? (Leave blank to disable)",
			"DataPal Ring Message",
			pda_ringmessage,
			30)
		if(!isnull(new_message))
			if(new_message)
				pda_ringmessage = new_message
			else
				pda_ringmessage = "beep-boop"

	if(href_list["preference"] == "genital_hide")
		var/hideit = text2num(href_list["hideflag"])
		TOGGLE_BITFIELD(features["genital_hide"], hideit)

	if(href_list["preference"] == "job")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=mob_occupation")
				ShowChoices(user)
			if("reset")
				ResetJobs()
				SetChoices(user)
			if("random")
				switch(joblessrole)
					if(RETURNTOLOBBY)
						if(jobban_isbanned(user, SSjob.overflow_role))
							joblessrole = BERANDOMJOB
						else
							joblessrole = BEOVERFLOW
					if(BEOVERFLOW)
						joblessrole = BERANDOMJOB
					if(BERANDOMJOB)
						joblessrole = RETURNTOLOBBY
				SetChoices(user)
			if("setJobLevel")
				UpdateJobPreference(user, href_list["text"], text2num(href_list["level"]))
			else
				SetChoices(user)
		return 1

	else if(href_list["preference"] == "quirkmenu")
		SSquirks.OpenWindow(user)
	// 		if("update")
	// 			var/quirk = href_list["trait"]
	// 			if(!SSquirks.quirks[quirk])
	// 				return
	// 			for(var/V in SSquirks.quirk_blacklist) //V is a list
	// 				var/list/L = V
	// 				for(var/Q in char_quirks)
	// 					if((quirk in L) && (Q in L) && !(Q == quirk)) //two quirks have lined up in the list of the list of quirks that conflict with each other, so return (see quirks.dm for more details)
	// 						to_chat(user, span_danger("[quirk] is incompatible with [Q]."))
	// 						return
	// 			var/value = SSquirks.quirk_points[quirk]
	// 			var/balance = GetQuirkBalance()
	// 			if(quirk in char_quirks)
	// 				if(balance + value < 0)
	// 					to_chat(user, span_warning("Refunding this would cause you to go below your balance!"))
	// 					return
	// 				char_quirks -= quirk
	// 			else
	// 				if(value != 0 && (GetPositiveQuirkCount() >= MAX_QUIRKS))
	// 					to_chat(user, span_warning("You can't have more than [MAX_QUIRKS] positive quirks!"))
	// 					return
	// 				if(balance - value < 0)
	// 					to_chat(user, span_warning("You don't have enough balance to gain this quirk!"))
	// 					return
	// 				char_quirks += quirk
	// 			SetQuirks(user)
	// 		if("reset")
	// 			char_quirks = list()
	// 			SetQuirks(user)
	// 		else
	// 			SetQuirks(user)
	// 	return TRUE

	// else if(href_list["quirk_category"])
	// 	var/temp_quirk_category = href_list["quirk_category"]
	// 	if(temp_quirk_category == QUIRK_POSITIVE || temp_quirk_category == QUIRK_NEUTRAL || temp_quirk_category == QUIRK_NEGATIVE)
	// 		quirk_category = temp_quirk_category
	// 		SetQuirks(user)

	else if(href_list["preference"] == "special")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=mob_occupation")
				ShowChoices(user)
			if("update")
			if("reset")
			else
				SetSpecial(user)
		return TRUE

	switch(href_list["task"])
		if("random")
			switch(href_list["preference"])
				if("name")
					real_name = pref_species.random_name(gender,1)
					if(isnewplayer(parent.mob)) // Update the player panel with the new name.
						var/mob/dead/new_player/player_mob = parent.mob
						player_mob.new_player_panel()
				if("age")
					age = rand(AGE_MIN, AGE_MAX)
				if("hair")
					hair_color = random_short_color()
				if("hair_style")
					hair_style = random_hair_style(gender)
				if("facial")
					facial_hair_color = random_short_color()
				if("facial_hair_style")
					facial_hair_style = random_facial_hair_style(gender)
				if("underwear")
					underwear = random_underwear(gender)
					undie_color = random_short_color()
				if("undershirt")
					undershirt = random_undershirt(gender)
					shirt_color = random_short_color()
				if("socks")
					socks = random_socks()
					socks_color = random_short_color()
				if(BODY_ZONE_PRECISE_EYES)
					var/random_eye_color = random_eye_color()
					left_eye_color = random_eye_color
					right_eye_color = random_eye_color
				if("s_tone")
					skin_tone = random_skin_tone()
					use_custom_skin_tone = null
				if("bag")
					backbag = pick(GLOB.backbaglist)
				if("suit")
					jumpsuit_style = pick(GLOB.jumpsuitlist)
				if("all")
					random_character()

		if("input")

			if(href_list["preference"] in GLOB.preferences_custom_names)
				ask_for_custom_name(user,href_list["preference"])
			switch(href_list["preference"])
				if("show_health_smilies")
					TOGGLE_VAR(show_health_smilies)
					return 1
				if("special_s")
					var/new_point = input(user, "Choose Amount(1-9)", "Strength") as num|null
					if(new_point)
						special_s = max(min(round(text2num(new_point)), 9),1)
					SetSpecial(user)
					return 1
				if("special_p")
					var/new_point = input(user, "Choose Amount(1-9)", "Perception") as num|null
					if(new_point)
						special_p = max(min(round(text2num(new_point)), 9),1)
					SetSpecial(user)
					return 1
				if("special_e")
					var/new_point = input(user, "Choose Amount(1-9)", "Endurance") as num|null
					if(new_point)
						special_e = max(min(round(text2num(new_point)), 9),1)
					SetSpecial(user)
					return 1
				if("special_c")
					var/new_point = input(user, "Choose Amount(1-9)", "Charisma") as num|null
					if(new_point)
						special_c = max(min(round(text2num(new_point)), 9),1)
					SetSpecial(user)
					return 1
				if("special_i")
					var/new_point = input(user, "Choose Amount(1-9)", "Intelligence") as num|null
					if(new_point)
						special_i = max(min(round(text2num(new_point)), 9),1)
					SetSpecial(user)
					return 1
				if("special_a")
					var/new_point = input(user, "Choose Amount(1-9)", "Agility") as num|null
					if(new_point)
						special_a = max(min(round(text2num(new_point)), 9),1)
					SetSpecial(user)
					return 1
				if("special_l")
					var/new_point = input(user, "Choose Amount(1-9)", "Luck") as num|null
					if(new_point)
						special_l = max(min(round(text2num(new_point)), 9),1)
					SetSpecial(user)
					return 1
				if("ghostform")
					if(unlock_content)
						var/new_form = input(user, "Thanks for supporting BYOND - Choose your ghostly form:","Thanks for supporting BYOND",null) as null|anything in GLOB.ghost_forms
						if(new_form)
							ghost_form = new_form
				if("ghostorbit")
					if(unlock_content)
						var/new_orbit = input(user, "Thanks for supporting BYOND - Choose your ghostly orbit:","Thanks for supporting BYOND", null) as null|anything in GLOB.ghost_orbits
						if(new_orbit)
							ghost_orbit = new_orbit

				if("ghostaccs")
					var/new_ghost_accs = alert("Do you want your ghost to show full accessories where possible, hide accessories but still use the directional sprites where possible, or also ignore the directions and stick to the default sprites?",,GHOST_ACCS_FULL_NAME, GHOST_ACCS_DIR_NAME, GHOST_ACCS_NONE_NAME)
					switch(new_ghost_accs)
						if(GHOST_ACCS_FULL_NAME)
							ghost_accs = GHOST_ACCS_FULL
						if(GHOST_ACCS_DIR_NAME)
							ghost_accs = GHOST_ACCS_DIR
						if(GHOST_ACCS_NONE_NAME)
							ghost_accs = GHOST_ACCS_NONE

				if("ghostothers")
					var/new_ghost_others = alert("Do you want the ghosts of others to show up as their own setting, as their default sprites or always as the default white ghost?",,GHOST_OTHERS_THEIR_SETTING_NAME, GHOST_OTHERS_DEFAULT_SPRITE_NAME, GHOST_OTHERS_SIMPLE_NAME)
					switch(new_ghost_others)
						if(GHOST_OTHERS_THEIR_SETTING_NAME)
							ghost_others = GHOST_OTHERS_THEIR_SETTING
						if(GHOST_OTHERS_DEFAULT_SPRITE_NAME)
							ghost_others = GHOST_OTHERS_DEFAULT_SPRITE
						if(GHOST_OTHERS_SIMPLE_NAME)
							ghost_others = GHOST_OTHERS_SIMPLE

				if("name")
					var/new_name = input(user, "Choose your character's name:", "Character Preference")  as text|null
					if(new_name)
						new_name = reject_bad_name(new_name)
						if(new_name)
							real_name = new_name
							if(isnewplayer(parent.mob)) // Update the player panel with the new name.
								var/mob/dead/new_player/player_mob = parent.mob
								player_mob.new_player_panel()
						else
							to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>")
				if("creature_name")
					var/new_name = input(user, "Choose your creature character's name:", "Character Preference")  as text|null
					if(new_name)
						new_name = reject_bad_name(new_name)
						if(new_name)
							creature_name = new_name
							if(isnewplayer(parent.mob)) // Update the player panel with the new name.
								var/mob/dead/new_player/player_mob = parent.mob
								player_mob.new_player_panel()
						else
							to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>")
				if("creature_species")
					if(!LAZYLEN(GLOB.creature_selectable))//Pokemon selection list is empty, so generate it.
						generate_selectable_creatures()
					if(!(creature_species in GLOB.creature_selectable))//Previously selected species which isn't supported anymore.
						creature_species = initial(creature_species)
					var/result = input(user, "Select a creature species", "Species Selection") as null|anything in GLOB.creature_selectable
					if(result)
						creature_species = result
						var/creature_type = GLOB.creature_selectable["[result]"]
						var/mob/living/M = new creature_type(user)
						if(creature_image)
							QDEL_NULL(creature_image)
						creature_image = image(icon=M.icon,icon_state=M.icon_state,dir=2)
						qdel(M)

				if("creature_flavor_text")
					var/msg = stripped_multiline_input(usr, "Set the flavor text in your 'examine' verb.", "Flavor Text", html_decode(creature_flavor_text), MAX_FLAVOR_LEN, TRUE)
					if(!isnull(msg))
						creature_flavor_text = msg
				if("creature_ooc")
					var/msg = stripped_multiline_input(usr, "Set out of character notes related to roleplaying content preferences. THIS IS NOT FOR CHARACTER DESCRIPTIONS!", "OOC notes", html_decode(creature_ooc), MAX_FLAVOR_LEN, TRUE)
					if(!isnull(msg))
						creature_ooc = msg

				if("tbs")
					var/new_tbs = input(user, "Are you a top, bottom, or switch? (or none of the above)", "Character Preference") as null|anything in TBS_LIST
					if(new_tbs)
						tbs = new_tbs
				if("kisser")
					var/newkiss = input(user, "What sort of person do you like to kisser?", "Character Preference") as null|anything in KISS_LIST
					if(newkiss)
						kisser = newkiss
				if("age")
					var/new_age = input(user, "Choose your character's age:\n([AGE_MIN]-[AGE_MAX])", "Character Preference") as num|null
					if(new_age)
						age = max(min( round(text2num(new_age)), AGE_MAX),AGE_MIN)
				if("pixel_x")
					var/newx = input(user, "A new left/right pixel offset:\n([PIXELSHIFT_MAX] - [PIXELSHIFT_MIN])", "Character Preference", custom_pixel_x) as num|null
					if(newx)
						custom_pixel_x = round(clamp(newx, PIXELSHIFT_MIN, PIXELSHIFT_MAX), 1)
					else
						custom_pixel_x = 0
				if("pixel_y")
					var/newy = input(user, "A new up/down pixel offset:\n([PIXELSHIFT_MAX] - [PIXELSHIFT_MIN])", "Character Preference", custom_pixel_y) as num|null
					if(newy)
						custom_pixel_y = round(clamp(newy, PIXELSHIFT_MIN, PIXELSHIFT_MAX), 1)
					else
						custom_pixel_y = 0
				if("custom_say")
					var/verb_type = href_list["verbtype"]
					var/lastvalue = ""
					if(length(features[verb_type]))
						lastvalue = jointext(features[verb_type],",")
					var/msg = input(usr, "Give a custom set of verbs for this character's [verb_type]. Separate them with a single comma and nothing else.", "Custom [verb_type]", lastvalue) as message|null
					if(!isnull(msg))
						features[verb_type] = splittext(msg,",")
				////////////////// VORE STUFF /
				if("master_vore_toggle")
					TOGGLE_VAR(master_vore_toggle)
				if("allow_being_prey")
					TOGGLE_VAR(allow_being_prey)
				if("allow_being_fed_prey")
					TOGGLE_VAR(allow_being_fed_prey)
				if("allow_digestion_damage")
					TOGGLE_VAR(allow_digestion_damage)
				if("allow_digestion_death")
					TOGGLE_VAR(allow_digestion_death)
				if("allow_trash_messages")
					TOGGLE_VAR(allow_trash_messages)
				if("allow_vore_messages")
					TOGGLE_VAR(allow_vore_messages)
				if("allow_death_messages")
					TOGGLE_VAR(allow_death_messages)
				if("allow_eating_sounds")
					TOGGLE_VAR(allow_eating_sounds)
				if("allow_digestion_sounds")
					TOGGLE_VAR(allow_digestion_sounds)
				if("flavor_text")
					var/msg = stripped_multiline_input(usr, "Set the flavor text in your 'examine' verb. This can also be used for OOC notes and preferences!", "Flavor Text", html_decode(features["flavor_text"]), MAX_FLAVOR_LEN, TRUE)
					if(!isnull(msg))
						features["flavor_text"] = msg

				if("silicon_flavor_text")
					var/msg = stripped_multiline_input(usr, "Set the silicon flavor text in your 'examine' verb. This can also be used for OOC notes and preferences!", "Silicon Flavor Text", html_decode(features["silicon_flavor_text"]), MAX_FLAVOR_LEN, TRUE)
					if(!isnull(msg))
						features["silicon_flavor_text"] = msg

				if("ooc_notes")
					var/msg = stripped_multiline_input(usr, "Set always-visible OOC notes related to content preferences. THIS IS NOT FOR CHARACTER DESCRIPTIONS!", "OOC notes", html_decode(features["ooc_notes"]), MAX_FLAVOR_LEN, TRUE)
					if(!isnull(msg))
						features["ooc_notes"] = msg
				
				if("background_info_notes")
					var/msg = stripped_multiline_input(usr, "Set always-visible character's background!", "Background Info Notes", html_decode(features["background_info_notes"]), MAX_FLAVOR_LEN, TRUE)
					if(!isnull(msg))
						features["background_info_notes"] = msg

				if("flist")
					var/link = input(usr, "Set always-visible F-list. Just copy and paste the link you want to use from the browser. Leave it blank to remove the previous link.", "F-list")
					if(!length(link))
						features["flist"] = ""
						to_chat(usr, span_alert("Removed the previous F-list link."))
					else if(findtext(link, "https://www.f-list.net"))  //we want to avoid malicious links, so let's check if it's actually a valid link first
						features["flist"] = link
					else
						features["flist"] = ""
						to_chat(usr, span_alert("This is not a correct F-list link!"))

				if("hide_ckey")
					hide_ckey = !hide_ckey
					if(user)
						user.mind?.hide_ckey = hide_ckey

				if("hair")
					var/new_hair = input(user, "Choose your character's hair colour:", "Character Preference","#"+hair_color) as color|null
					if(new_hair)
						hair_color = sanitize_hexcolor(new_hair, 6)

				if("hair_style")
					var/new_hair_style
					new_hair_style = input(user, "Choose your character's hair style:", "Character Preference")  as null|anything in GLOB.hair_styles_list
					if(new_hair_style)
						hair_style = new_hair_style

				if("next_hair_style")
					hair_style = next_list_item(hair_style, GLOB.hair_styles_list)

				if("previous_hair_style")
					hair_style = previous_list_item(hair_style, GLOB.hair_styles_list)

				if("facial")
					var/new_facial = input(user, "Choose your character's facial-hair colour:", "Character Preference","#"+facial_hair_color) as color|null
					if(new_facial)
						facial_hair_color = sanitize_hexcolor(new_facial, 6)

				if("facial_hair_style")
					var/new_facial_hair_style
					new_facial_hair_style = input(user, "Choose your character's facial-hair style:", "Character Preference")  as null|anything in GLOB.facial_hair_styles_list
					if(new_facial_hair_style)
						facial_hair_style = new_facial_hair_style

				if("next_facehair_style")
					facial_hair_style = next_list_item(facial_hair_style, GLOB.facial_hair_styles_list)

				if("previous_facehair_style")
					facial_hair_style = previous_list_item(facial_hair_style, GLOB.facial_hair_styles_list)

				if("cycle_bg")
					bgstate = next_list_item(bgstate, bgstate_options)

				if("modify_limbs")
					var/limb_type = input(user, "Choose the limb to modify:", "Character Preference") as null|anything in LOADOUT_ALLOWED_LIMB_TARGETS
					if(!limb_type)
						return
					var/modification_type = input(user, "Choose the modification to the limb:", "Character Preference") as null|anything in LOADOUT_LIMBS
					if(!modification_type)
						return
					if(modification_type == LOADOUT_LIMB_PROSTHETIC)
						var/prosthetic_type = input(user, "Choose the type of prosthetic", "Character Preference") as null|anything in (list("prosthetic") + GLOB.prosthetic_limb_types)
						if(!prosthetic_type)
							return
						var/number_of_prosthetics = 0
						for(var/modified_limb in modified_limbs)
							if(modified_limbs[modified_limb][1] == LOADOUT_LIMB_PROSTHETIC && modified_limb != limb_type)
								number_of_prosthetics += 1
						if(number_of_prosthetics > MAXIMUM_LOADOUT_PROSTHETICS)
							to_chat(user, span_danger("You can only have up to two prosthetic limbs!"))
						else
							//save the actual prosthetic data
							modified_limbs[limb_type] = list(modification_type, prosthetic_type)
					else
						if(modification_type == LOADOUT_LIMB_NORMAL)
							modified_limbs -= limb_type
						else
							modified_limbs[limb_type] = list(modification_type)

				if("underwear")
					var/new_underwear = input(user, "Choose your character's underwear:", "Character Preference")  as null|anything in GLOB.underwear_list
					if(new_underwear)
						underwear = new_underwear

				if("undie_color")
					var/n_undie_color = input(user, "Choose your underwear's color.", "Character Preference", "#[undie_color]") as color|null
					if(n_undie_color)
						undie_color = sanitize_hexcolor(n_undie_color, 6)

				if("undershirt")
					var/new_undershirt = input(user, "Choose your character's undershirt:", "Character Preference") as null|anything in GLOB.undershirt_list
					if(new_undershirt)
						undershirt = new_undershirt

				if("shirt_color")
					var/n_shirt_color = input(user, "Choose your undershirt's color.", "Character Preference", "#[shirt_color]") as color|null
					if(n_shirt_color)
						shirt_color = sanitize_hexcolor(n_shirt_color, 6)

				if("socks")
					var/new_socks = input(user, "Choose your character's socks:", "Character Preference") as null|anything in GLOB.socks_list
					if(new_socks)
						socks = new_socks

				if("socks_color")
					var/n_socks_color = input(user, "Choose your socks' color.", "Character Preference", "#[socks_color]") as color|null
					if(n_socks_color)
						socks_color = sanitize_hexcolor(n_socks_color, 6)

				if("undershirt_overclothes")
					undershirt_overclothes = undershirt_overclothes+1
					if(undershirt_overclothes > UNDERWEAR_OVER_EVERYTHING)
						undershirt_overclothes = UNDERWEAR_UNDER_CLOTHES

				if("undies_overclothes")
					undies_overclothes = undies_overclothes+1
					if(undies_overclothes > UNDERWEAR_OVER_EVERYTHING)
						undies_overclothes = UNDERWEAR_UNDER_CLOTHES

				if("socks_overclothes")
					socks_overclothes = socks_overclothes+1
					if(socks_overclothes > UNDERWEAR_OVER_EVERYTHING)
						socks_overclothes = UNDERWEAR_UNDER_CLOTHES

				if("eyes")
					var/new_eyes = input(user, "Choose your character's eye colour:", "Character Preference","#"+left_eye_color) as color|null
					if(new_eyes)
						left_eye_color = sanitize_hexcolor(new_eyes, 6)
						right_eye_color = sanitize_hexcolor(new_eyes, 6)

				if("eye_left")
					var/new_eyes = input(user, "Choose your character's left eye colour:", "Character Preference","#"+left_eye_color) as color|null
					if(new_eyes)
						left_eye_color = sanitize_hexcolor(new_eyes, 6)

				if("eye_right")
					var/new_eyes = input(user, "Choose your character's right eye colour:", "Character Preference","#"+right_eye_color) as color|null
					if(new_eyes)
						right_eye_color = sanitize_hexcolor(new_eyes, 6)

				if("eye_type")
					var/new_eye_type = input(user, "Choose your character's eye type.", "Character Preference") as null|anything in GLOB.eye_types
					if(new_eye_type)
						eye_type = new_eye_type

				if("toggle_split_eyes")
					split_eye_colors = !split_eye_colors
					right_eye_color = left_eye_color

				if("toggle_eye_over_hair")
					TOGGLE_VAR(eye_over_hair)

				if("species")
					var/result = input(user, "Select a species", "Species Selection") as null|anything in GLOB.roundstart_race_names
					if(result)
						var/newtype = GLOB.species_list[GLOB.roundstart_race_names[result]]
						pref_species = new newtype()
						//let's ensure that no weird shit happens on species swapping.
						custom_species = null
						if(!parent.can_have_part("mam_body_markings"))
							features["mam_body_markings"] = list()
						if(parent.can_have_part("mam_body_markings"))
							if(features["mam_body_markings"] == "None")
								features["mam_body_markings"] = list()
						if(parent.can_have_part("tail_lizard"))
							features["tail_lizard"] = "Smooth"
						if(pref_species.id == "felinid")
							features["mam_tail"] = "Cat"
							features["mam_ears"] = "Cat"

						//Now that we changed our species, we must verify that the mutant colour is still allowed.
						var/temp_hsv = RGBtoHSV(features["mcolor"])
						if(features["mcolor"] == "#000000" || (!(MUTCOLORS_PARTSONLY in pref_species.species_traits) && ReadHSV(temp_hsv)[3] < ReadHSV("#202020")[3]))
							features["mcolor"] = pref_species.default_color
						if(features["mcolor2"] == "#000000" || (!(MUTCOLORS_PARTSONLY in pref_species.species_traits) && ReadHSV(temp_hsv)[3] < ReadHSV("#202020")[3]))
							features["mcolor2"] = pref_species.default_color
						if(features["mcolor3"] == "#000000" || (!(MUTCOLORS_PARTSONLY in pref_species.species_traits) && ReadHSV(temp_hsv)[3] < ReadHSV("#202020")[3]))
							features["mcolor3"] = pref_species.default_color

						//switch to the type of eyes the species uses
						eye_type = pref_species.eye_type
				if("species_alt_prefix")
					if(LAZYLEN(pref_species.alt_prefixes))//if there are alt sprites to even pick from
						var/list/pickfrom = list("Default" = "")
						pickfrom |= pref_species.alt_prefixes
						var/result = input(user, "Select an alternate species appearance or press cancel to clear it.", "Alternate Appearance") as null|anything in pickfrom
						if(isnull(result) || result == "")
							alt_appearance = "Default"
						else
							alt_appearance = result
					else //this species has none so I'm not sure how you clicked this button but clear it anyway
						alt_appearance = "Default"
				if("custom_species")
					var/new_species = reject_bad_name(input(user, "Choose your species subtype, if unique. This will show up on examinations and health scans. Do not abuse this:", "Character Preference", custom_species) as null|text)
					if(new_species)
						custom_species = new_species
					else
						custom_species = null

				if("taste")
					var/new_taste = reject_bad_name(input(user, "What do you taste like?", "Character Preference", features["taste"]) as null|text)
					if(new_taste)
						features["taste"] = new_taste
					else
						features["taste"] = "something"

				if("chat_color")
					var/new_runecolor = input(user, "Choose your character's runechat color:", "Character Preference","#"+features["chat_color"]) as color|null
					if(new_runecolor)
						features["chat_color"] = sanitize_hexcolor(new_runecolor, 6)

				if("mutant_color")
					var/new_mutantcolor = input(user, "Choose your character's alien/mutant color:", "Character Preference","#"+features["mcolor"]) as color|null
					if(new_mutantcolor)
						var/temp_hsv = RGBtoHSV(new_mutantcolor)
						if(new_mutantcolor == "#000000")
							features["mcolor"] = pref_species.default_color
						else if((MUTCOLORS_PARTSONLY in pref_species.species_traits) || ReadHSV(temp_hsv)[3] >= ReadHSV(MINIMUM_MUTANT_COLOR)[3]) // mutantcolors must be bright, but only if they affect the skin
							features["mcolor"] = sanitize_hexcolor(new_mutantcolor, 6)
						else
							to_chat(user, span_danger("Invalid color. Your color is not bright enough."))

				if("mutant_color2")
					var/new_mutantcolor = input(user, "Choose your character's secondary alien/mutant color:", "Character Preference","#"+features["mcolor2"]) as color|null
					if(new_mutantcolor)
						var/temp_hsv = RGBtoHSV(new_mutantcolor)
						if(new_mutantcolor == "#000000")
							features["mcolor2"] = pref_species.default_color
						else if((MUTCOLORS_PARTSONLY in pref_species.species_traits) || ReadHSV(temp_hsv)[3] >= ReadHSV(MINIMUM_MUTANT_COLOR)[3]) // mutantcolors must be bright, but only if they affect the skin
							features["mcolor2"] = sanitize_hexcolor(new_mutantcolor, 6)
						else
							to_chat(user, span_danger("Invalid color. Your color is not bright enough."))

				if("mutant_color3")
					var/new_mutantcolor = input(user, "Choose your character's tertiary alien/mutant color:", "Character Preference","#"+features["mcolor3"]) as color|null
					if(new_mutantcolor)
						var/temp_hsv = RGBtoHSV(new_mutantcolor)
						if(new_mutantcolor == "#000000")
							features["mcolor3"] = pref_species.default_color
						else if((MUTCOLORS_PARTSONLY in pref_species.species_traits) || ReadHSV(temp_hsv)[3] >= ReadHSV(MINIMUM_MUTANT_COLOR)[3]) // mutantcolors must be bright, but only if they affect the skin
							features["mcolor3"] = sanitize_hexcolor(new_mutantcolor, 6)
						else
							to_chat(user, span_danger("Invalid color. Your color is not bright enough."))

				if("mismatched_markings")
					show_mismatched_markings = !show_mismatched_markings

				if("ipc_screen")
					var/new_ipc_screen
					new_ipc_screen = input(user, "Choose your character's screen:", "Character Preference") as null|anything in GLOB.ipc_screens_list
					if(new_ipc_screen)
						features["ipc_screen"] = new_ipc_screen

				if("ipc_antenna")
					var/list/snowflake_antenna_list = list()
					//Potential todo: turn all of THIS into a define to reduce copypasta.
					for(var/path in GLOB.ipc_antennas_list)
						var/datum/sprite_accessory/antenna/instance = GLOB.ipc_antennas_list[path]
						if(istype(instance, /datum/sprite_accessory))
							var/datum/sprite_accessory/S = instance
							if(!show_mismatched_markings && S.recommended_species && !S.recommended_species.Find(pref_species.id))
								continue
							if((!S.ckeys_allowed) || (S.ckeys_allowed.Find(user.client.ckey)))
								snowflake_antenna_list[S.name] = path
					var/new_ipc_antenna
					new_ipc_antenna = input(user, "Choose your character's antenna:", "Character Preference") as null|anything in snowflake_antenna_list
					if(new_ipc_antenna)
						features["ipc_antenna"] = new_ipc_antenna

				if("tail_lizard")
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.tails_list_lizard
					if(new_tail)
						features["tail_lizard"] = new_tail
						if(new_tail != "None")
							features["taur"] = "None"
							features["tail_human"] = "None"
							features["mam_tail"] = "None"

				if("tail_human")
					var/list/snowflake_tails_list = list()
					for(var/path in GLOB.tails_list_human)
						var/datum/sprite_accessory/tails/human/instance = GLOB.tails_list_human[path]
						if(istype(instance, /datum/sprite_accessory))
							var/datum/sprite_accessory/S = instance
							if(!show_mismatched_markings && S.recommended_species && !S.recommended_species.Find(pref_species.id))
								continue
							if((!S.ckeys_allowed) || (S.ckeys_allowed.Find(user.client.ckey)))
								snowflake_tails_list[S.name] = path
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in snowflake_tails_list
					if(new_tail)
						features["tail_human"] = new_tail
						if(new_tail != "None")
							features["taur"] = "None"
							features["tail_lizard"] = "None"
							features["mam_tail"] = "None"

				if("mam_tail")
					var/list/snowflake_tails_list = list()
					for(var/path in GLOB.mam_tails_list)
						var/datum/sprite_accessory/tails/mam_tails/instance = GLOB.mam_tails_list[path]
						if(istype(instance, /datum/sprite_accessory))
							var/datum/sprite_accessory/S = instance
							if(!show_mismatched_markings && S.recommended_species && !S.recommended_species.Find(pref_species.id))
								continue
							if((!S.ckeys_allowed) || (S.ckeys_allowed.Find(user.client.ckey)))
								snowflake_tails_list[S.name] = path
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in snowflake_tails_list
					if(new_tail)
						features["mam_tail"] = new_tail
						if(new_tail != "None")
							features["taur"] = "None"
							features["tail_human"] = "None"
							features["tail_lizard"] = "None"

				if("meat_type")
					var/new_meat
					new_meat = input(user, "Choose your character's meat type:", "Character Preference") as null|anything in GLOB.meat_types
					if(new_meat)
						features["meat_type"] = new_meat

				if("snout")
					var/list/snowflake_snouts_list = list()
					for(var/path in GLOB.snouts_list)
						var/datum/sprite_accessory/snouts/mam_snouts/instance = GLOB.snouts_list[path]
						if(istype(instance, /datum/sprite_accessory))
							var/datum/sprite_accessory/S = instance
							if(!show_mismatched_markings && S.recommended_species && !S.recommended_species.Find(pref_species.id))
								continue
							if((!S.ckeys_allowed) || (S.ckeys_allowed.Find(user.client.ckey)))
								snowflake_snouts_list[S.name] = path
					var/new_snout
					new_snout = input(user, "Choose your character's snout:", "Character Preference") as null|anything in snowflake_snouts_list
					if(new_snout)
						features["snout"] = new_snout
						features["mam_snouts"] = "None"


				if("mam_snouts")
					var/list/snowflake_mam_snouts_list = list()
					for(var/path in GLOB.mam_snouts_list)
						var/datum/sprite_accessory/snouts/mam_snouts/instance = GLOB.mam_snouts_list[path]
						if(istype(instance, /datum/sprite_accessory))
							var/datum/sprite_accessory/S = instance
							if(!show_mismatched_markings && S.recommended_species && !S.recommended_species.Find(pref_species.id))
								continue
							if((!S.ckeys_allowed) || (S.ckeys_allowed.Find(user.client.ckey)))
								snowflake_mam_snouts_list[S.name] = path
					var/new_mam_snouts
					new_mam_snouts = input(user, "Choose your character's snout:", "Character Preference") as null|anything in snowflake_mam_snouts_list
					if(new_mam_snouts)
						features["mam_snouts"] = new_mam_snouts
						features["snout"] = "None"

				if("horns")
					var/new_horns
					new_horns = input(user, "Choose your character's horns:", "Character Preference") as null|anything in GLOB.horns_list
					if(new_horns)
						features["horns"] = new_horns

				if("horns_color")
					var/new_horn_color = input(user, "Choose your character's horn colour:", "Character Preference","#"+features["horns_color"]) as color|null
					if(new_horn_color)
						if (new_horn_color == "#000000")
							features["horns_color"] = "85615A"
						else
							features["horns_color"] = sanitize_hexcolor(new_horn_color, 6)

				if("blood_color")
					var/new_color
					new_color = input(user, "Choose your character's blood color", "#"+features["blood_color"]) as color|null
					if(!isnull(new_color))
						features["blood_color"] = sanitize_hexcolor(new_color, 6)
					//else
						//var/rainbow = alert(user, "Do you want rainbow blood?", "Hi!", "Yes", "No")
						//if(rainbow == "Yes")
						//	features["blood_color"] = "rainbow"
				if("reset_blood_color")
					features["blood_color"] = ""
				if("rainbow_blood_color")
					features["blood_color"] = "rainbow"
				if("wings")
					var/new_wings
					new_wings = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.r_wings_list
					if(new_wings)
						features["wings"] = new_wings

				if("wings_color")
					var/new_wing_color = input(user, "Choose your character's wing colour:", "Character Preference","#"+features["wings_color"]) as color|null
					if(new_wing_color)
						if (new_wing_color == "#000000")
							features["wings_color"] = "#FFFFFF"
						else
							features["wings_color"] = sanitize_hexcolor(new_wing_color, 6)

				if("frills")
					var/new_frills
					new_frills = input(user, "Choose your character's frills:", "Character Preference") as null|anything in GLOB.frills_list
					if(new_frills)
						features["frills"] = new_frills

				if("spines")
					var/new_spines
					new_spines = input(user, "Choose your character's spines:", "Character Preference") as null|anything in GLOB.spines_list
					if(new_spines)
						features["spines"] = new_spines

				if("legs")
					var/new_legs
					new_legs = input(user, "Choose your character's legs:", "Character Preference") as null|anything in GLOB.legs_list
					if(new_legs)
						features["legs"] = new_legs

				if("insect_wings")
					var/new_insect_wings
					new_insect_wings = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.insect_wings_list
					if(new_insect_wings)
						features["insect_wings"] = new_insect_wings

				if("deco_wings")
					var/new_deco_wings
					new_deco_wings = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.deco_wings_list
					if(new_deco_wings)
						features["deco_wings"] = new_deco_wings

				if("insect_fluff")
					var/new_insect_fluff
					new_insect_fluff = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.insect_fluffs_list
					if(new_insect_fluff)
						features["insect_fluff"] = new_insect_fluff

				if("insect_markings")
					var/new_insect_markings
					new_insect_markings = input(user, "Choose your character's markings:", "Character Preference") as null|anything in GLOB.insect_markings_list
					if(new_insect_markings)
						features["insect_markings"] = new_insect_markings

				if("s_tone")
					var/list/choices = GLOB.skin_tones - GLOB.nonstandard_skin_tones
					if(CONFIG_GET(flag/allow_custom_skintones))
						choices += "custom"
					var/new_s_tone = input(user, "Choose your character's skin tone:", "Character Preference")  as null|anything in choices
					if(new_s_tone)
						if(new_s_tone == "custom")
							var/default = use_custom_skin_tone ? skin_tone : null
							var/custom_tone = input(user, "Choose your custom skin tone:", "Character Preference", default) as color|null
							if(custom_tone)
								var/temp_hsv = RGBtoHSV(custom_tone)
								if(ReadHSV(temp_hsv)[3] < ReadHSV("#333333")[3]) // rgb(50,50,50)
									to_chat(user,span_danger("Invalid color. Your color is not bright enough."))
								else
									use_custom_skin_tone = TRUE
									skin_tone = custom_tone
						else
							use_custom_skin_tone = FALSE
							skin_tone = new_s_tone

				if("taur")
					var/list/snowflake_taur_list = list()
					for(var/path in GLOB.taur_list)
						var/datum/sprite_accessory/taur/instance = GLOB.taur_list[path]
						if(istype(instance, /datum/sprite_accessory))
							var/datum/sprite_accessory/S = instance
							if(!show_mismatched_markings && S.recommended_species && !S.recommended_species.Find(pref_species.id))
								continue
							if((!S.ckeys_allowed) || (S.ckeys_allowed.Find(user.client.ckey)))
								snowflake_taur_list[S.name] = path
					var/new_taur
					new_taur = input(user, "Choose your character's tauric body:", "Character Preference") as null|anything in snowflake_taur_list
					if(new_taur)
						features["taur"] = new_taur
						if(new_taur != "None")
							features["mam_tail"] = "None"
							features["xenotail"] = "None"
							features["tail_human"] = "None"
							features["tail_lizard"] = "None"

				if("ears")
					var/list/snowflake_ears_list = list()
					for(var/path in GLOB.ears_list)
						var/datum/sprite_accessory/ears/instance = GLOB.ears_list[path]
						if(istype(instance, /datum/sprite_accessory))
							var/datum/sprite_accessory/S = instance
							if(!show_mismatched_markings && S.recommended_species && !S.recommended_species.Find(pref_species.id))
								continue
							if((!S.ckeys_allowed) || (S.ckeys_allowed.Find(user.client.ckey)))
								snowflake_ears_list[S.name] = path
					var/new_ears
					new_ears = input(user, "Choose your character's ears:", "Character Preference") as null|anything in snowflake_ears_list
					if(new_ears)
						features["ears"] = new_ears

				if("mam_ears")
					var/list/snowflake_ears_list = list()
					for(var/path in GLOB.mam_ears_list)
						var/datum/sprite_accessory/ears/mam_ears/instance = GLOB.mam_ears_list[path]
						if(istype(instance, /datum/sprite_accessory))
							var/datum/sprite_accessory/S = instance
							if(!show_mismatched_markings && S.recommended_species && !S.recommended_species.Find(pref_species.id))
								continue
							if((!S.ckeys_allowed) || (S.ckeys_allowed.Find(user.client.ckey)))
								snowflake_ears_list[S.name] = path
					var/new_ears
					new_ears = input(user, "Choose your character's ears:", "Character Preference") as null|anything in snowflake_ears_list
					if(new_ears)
						features["mam_ears"] = new_ears

				//Xeno Bodyparts
				if("xenohead")//Head or caste type
					var/new_head
					new_head = input(user, "Choose your character's caste:", "Character Preference") as null|anything in GLOB.xeno_head_list
					if(new_head)
						features["xenohead"] = new_head

				if("xenotail")//Currently one one type, more maybe later if someone sprites them. Might include animated variants in the future.
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.xeno_tail_list
					if(new_tail)
						features["xenotail"] = new_tail
						if(new_tail != "None")
							features["mam_tail"] = "None"
							features["taur"] = "None"
							features["tail_human"] = "None"
							features["tail_lizard"] = "None"

				if("xenodorsal")
					var/new_dors
					new_dors = input(user, "Choose your character's dorsal tube type:", "Character Preference") as null|anything in GLOB.xeno_dorsal_list
					if(new_dors)
						features["xenodorsal"] = new_dors

				//Dragon Bodyparts
				if("derg_body") //dragon main body
					var/new_body
					new_body = input(user, "Choose your character's body type:", "Character Preference") as null|anything in GLOB.derg_body_list
					if(new_body)
						features["derg_body"] = new_body

				if("derg_belly") //dragon underside
					var/new_belly
					new_belly = input(user, "Choose your character's belly type:", "Character Preference") as null|anything in GLOB.derg_belly_list
					if(new_belly)
						features["derg_belly"] = new_belly

				if("derg_horns")
					var/new_horn
					new_horn = input(user, "Choose your character's horn type:", "Character Preference") as null|anything in GLOB.derg_horn_list
					if(new_horn)
						features["derg_horns"] = new_horn

				if("derg_ears")
					var/new_ears
					new_ears = input(user, "Choose your character's ear type:", "Character Preference") as null|anything in GLOB.derg_ear_list
					if(new_ears)
						features["derg_ears"] = new_ears

				if("derg_mane")
					var/new_mane
					new_mane = input(user, "Choose your character's mane type:", "Character Preference") as null|anything in GLOB.derg_mane_list
					if(new_mane)
						features["derg_mane"] = new_mane

				if("derg_eyes")
					var/new_eye
					new_eye = input(user, "Choose your character's eye type:", "Character Preference") as null|anything in GLOB.derg_eye_list
					if(new_eye)
						features["derg_eyes"] = new_eye

				//every single primary/secondary/tertiary colouring done at once
				if(
				"derg_body_primary","derg_body_secondary","derg_body_tertiary",
				"derg_belly_primary","derg_belly_secondary","derg_belly_tertiary",
				"derg_horns_primary","derg_horns_secondary","derg_horns_tertiary",
				"derg_ears_primary","derg_ears_secondary","derg_ears_tertiary",
				"derg_mane_primary","derg_mane_secondary","derg_mane_tertiary",
				"derg_eyes_primary","derg_eyes_secondary","derg_eyes_tertiary",
				"xenodorsal_primary","xenodorsal_secondary","xenodorsal_tertiary",
				"xhead_primary","xhead_secondary","xhead_tertiary",
				"tail_primary","tail_secondary","tail_tertiary",
				"insect_markings_primary","insect_markings_secondary","insect_markings_tertiary",
				"insect_fluff_primary","insect_fluff_secondary","insect_fluff_tertiary",
				"ears_primary","ears_secondary","ears_tertiary",
				"frills_primary","frills_secondary","frills_tertiary",
				"ipc_antenna_primary","ipc_antenna_secondary","ipc_antenna_tertiary",
				"taur_primary","taur_secondary","taur_tertiary",
				"snout_primary","snout_secondary","snout_tertiary",
				"spines_primary","spines_secondary","spines_tertiary",
				"mam_body_markings_primary", "mam_body_markings_secondary", "mam_body_markings_tertiary")
					var/the_feature = features[href_list["preference"]]
					if(!the_feature)
						features[href_list["preference"]] = "FFFFFF"
						the_feature = "FFFFFF"
					var/new_feature_color = input(user, "Choose your character's mutant part colour:", "Character Preference","#"+features[href_list["preference"]]) as color|null
					if(new_feature_color)
						var/temp_hsv = RGBtoHSV(new_feature_color)
						if(new_feature_color == "#000000")
							features[href_list["preference"]] = pref_species.default_color
						else if(ReadHSV(temp_hsv)[3] >= ReadHSV(MINIMUM_MUTANT_COLOR)[3])
							features[href_list["preference"]] = sanitize_hexcolor(new_feature_color, 6)
						else
							to_chat(user,span_danger("Invalid color. Your color is not bright enough."))


				//advanced color mode toggle
				if("color_scheme")
					if(features["color_scheme"] == ADVANCED_CHARACTER_COLORING)
						features["color_scheme"] = OLD_CHARACTER_COLORING
					else
						features["color_scheme"] = ADVANCED_CHARACTER_COLORING

				//Genital code
				// visibility stuff~
				if(GENITAL_VIS_OVERRIDE_SET)
					var/list/genital_overrides = GENITAL_VIS_FLAG_LIST
					var/new_visibility = input(user, "Set a visibility override! If set, this part will always be visible/hidden, regardless of how covered it is.", "Character Preference", href_list["genital_flag"]) as null|anything in genital_overrides
					if(new_visibility)
						var/new_bit = genital_overrides[new_visibility]
						var/which_gunt = GENITAL_VIS_OVERRIDE2FLAGS_LIST[href_list["preference"]]
						DISABLE_BITFIELD(features[which_gunt], GENITAL_ALWAYS_HIDDEN | GENITAL_ALWAYS_VISIBLE)
						ENABLE_BITFIELD(features[which_gunt], new_bit)

				if(GENITAL_VIS_FLAGS_SET)
					var/which_gunt = href_list["preference"]
					var/dicflag = text2num(href_list["genital_flag"]) // it gets something like "2"
					TOGGLE_BITFIELD(features[which_gunt], dicflag)

				if("cock_color")
					var/new_cockcolor = input(user, "Penis color:", "Character Preference","#"+features["cock_color"]) as color|null
					if(new_cockcolor)
						var/temp_hsv = RGBtoHSV(new_cockcolor)
						if(new_cockcolor == "#000000")
							features["cock_color"] = pref_species.default_color
						else if(ReadHSV(temp_hsv)[3] >= ReadHSV(MINIMUM_MUTANT_COLOR)[3])
							features["cock_color"] = sanitize_hexcolor(new_cockcolor, 6)
						else
							to_chat(user,span_danger("Invalid color. Your color is not bright enough."))

				if("cock_size")
					var/min_D = CONFIG_GET(number/penis_min_inches_prefs)
					var/max_D = CONFIG_GET(number/penis_max_inches_prefs)
					var/new_length = input(user, "Penis length in inches:\n([min_D]-[max_D])", "Character Preference") as num|null
					if(new_length)
						features["cock_size"] = clamp(round(new_length), min_D, max_D)

				if("cock_shape")
					var/new_shape
					var/list/hockeys = list()
					if(parent.can_have_part("taur"))
						var/datum/sprite_accessory/taur/T = GLOB.taur_list[features["taur"]]
						for(var/A in GLOB.cock_shapes_list)
							var/datum/sprite_accessory/penis/P = GLOB.cock_shapes_list[A]
							if(P.taur_icon && T.taur_mode & P.accepted_taurs)
								LAZYSET(hockeys, "[A] (Taur)", A)
					new_shape = input(user, "Penis shape:", "Character Preference") as null|anything in (GLOB.cock_shapes_list + hockeys)
					if(new_shape)
						features["cock_taur"] = FALSE
						if(hockeys[new_shape])
							new_shape = hockeys[new_shape]
							features["cock_taur"] = TRUE
						features["cock_shape"] = new_shape

				if("cock_visibility")
					var/n_vis = input(user, "Penis Visibility", "Character Preference") as null|anything in CONFIG_GET(keyed_list/safe_visibility_toggles)
					if(n_vis)
						features["cock_visibility"] = n_vis

				if("balls_color")
					var/new_ballscolor = input(user, "Testicles Color:", "Character Preference","#"+features["balls_color"]) as color|null
					if(new_ballscolor)
						var/temp_hsv = RGBtoHSV(new_ballscolor)
						if(new_ballscolor == "#000000")
							features["balls_color"] = pref_species.default_color
						else if(ReadHSV(temp_hsv)[3] >= ReadHSV(MINIMUM_MUTANT_COLOR)[3])
							features["balls_color"] = sanitize_hexcolor(new_ballscolor, 6)
						else
							to_chat(user,span_danger("Invalid color. Your color is not bright enough."))

				if("balls_shape")
					var/new_shape
					new_shape = input(user, "Balls Shape", "Character Preference") as null|anything in GLOB.balls_shapes_list
					if(new_shape)
						features["balls_shape"] = new_shape

				if("balls_size")
					var/min_B = 1
					var/max_B = BALLS_SIZE_MAX
					var/new_length = input(user, "Testicle size in decigrundles:\n([min_B]-[max_B])", "Character Preference") as num|null
					if(new_length)
						features["balls_size"] = clamp(round(new_length), min_B, max_B)

				if("balls_visibility")
					var/n_vis = input(user, "Testicles Visibility", "Character Preference") as null|anything in CONFIG_GET(keyed_list/safe_visibility_toggles)
					if(n_vis)
						features["balls_visibility"] = n_vis

				if("breasts_size")
					var/new_size = input(user, "Breast Size", "Character Preference") as null|anything in CONFIG_GET(keyed_list/breasts_cups_prefs)
					if(new_size)
						features["breasts_size"] = new_size

				if("breasts_shape")
					var/new_shape
					new_shape = input(user, "Breast Shape", "Character Preference") as null|anything in GLOB.breasts_shapes_list
					if(new_shape)
						features["breasts_shape"] = new_shape

				if("breasts_color")
					var/new_breasts_color = input(user, "Breast Color:", "Character Preference","#"+features["breasts_color"]) as color|null
					if(new_breasts_color)
						var/temp_hsv = RGBtoHSV(new_breasts_color)
						if(new_breasts_color == "#000000")
							features["breasts_color"] = pref_species.default_color
						else if(ReadHSV(temp_hsv)[3] >= ReadHSV(MINIMUM_MUTANT_COLOR)[3])
							features["breasts_color"] = sanitize_hexcolor(new_breasts_color, 6)
						else
							to_chat(user,span_danger("Invalid color. Your color is not bright enough."))

				if("breasts_visibility")
					var/n_vis = input(user, "Breasts Visibility", "Character Preference") as null|anything in CONFIG_GET(keyed_list/safe_visibility_toggles)
					if(n_vis)
						features["breasts_visibility"] = n_vis

				if("belly_size")
					var/min_B = CONFIG_GET(number/belly_min_size_prefs)
					var/max_B = CONFIG_GET(number/belly_max_size_prefs)
					var/new_length = input(user, "Belly size:\n([min_B]-[max_B])", "Character Preference") as num|null
					if(new_length)
						features["belly_size"] = clamp(round(new_length), min_B, max_B)

				if("belly_shape")
					var/new_shape
					new_shape = input(user, "Belly Shape", "Character Preference") as null|anything in GLOB.belly_shapes_list
					if(new_shape)
						features["belly_shape"] = new_shape

				if("belly_color")
					var/new_belly_color = input(user, "Belly Color:", "Character Preference","#"+features["belly_color"]) as color|null
					if(new_belly_color)
						var/temp_hsv = RGBtoHSV(new_belly_color)
						if(new_belly_color == "#000000")
							features["belly_color"] = pref_species.default_color
						else if(ReadHSV(temp_hsv)[3] >= ReadHSV(MINIMUM_MUTANT_COLOR)[3])
							features["belly_color"] = sanitize_hexcolor(new_belly_color, 6)
						else
							to_chat(user,span_danger("Invalid color. Your color is not bright enough."))

				if("belly_visibility")
					var/n_vis = input(user, "Belly Visibility", "Character Preference") as null|anything in CONFIG_GET(keyed_list/safe_visibility_toggles)
					if(n_vis)
						features["belly_visibility"] = n_vis

				if("vag_shape")
					var/new_shape
					new_shape = input(user, "Vagina Type", "Character Preference") as null|anything in GLOB.vagina_shapes_list
					if(new_shape)
						features["vag_shape"] = new_shape

				if("vag_color")
					var/new_vagcolor = input(user, "Vagina color:", "Character Preference","#"+features["vag_color"]) as color|null
					if(new_vagcolor)
						var/temp_hsv = RGBtoHSV(new_vagcolor)
						if(new_vagcolor == "#000000")
							features["vag_color"] = pref_species.default_color
						else if(ReadHSV(temp_hsv)[3] >= ReadHSV(MINIMUM_MUTANT_COLOR)[3])
							features["vag_color"] = sanitize_hexcolor(new_vagcolor, 6)
						else
							to_chat(user,span_danger("Invalid color. Your color is not bright enough."))

				if("vag_visibility")
					var/n_vis = input(user, "Vagina Visibility", "Character Preference") as null|anything in CONFIG_GET(keyed_list/safe_visibility_toggles)
					if(n_vis)
						features["vag_visibility"] = n_vis

				if("butt_color")
					var/new_buttcolor = input(user, "Butt color:", "Character Preference","#"+features["butt_color"]) as color|null
					if(new_buttcolor)
						var/temp_hsv = RGBtoHSV(new_buttcolor)
						if(new_buttcolor == "#000000")
							features["butt_color"] = pref_species.default_color
						else if(ReadHSV(temp_hsv)[3] >= ReadHSV(MINIMUM_MUTANT_COLOR)[3])
							features["butt_color"] = sanitize_hexcolor(new_buttcolor, 6)
						else
							to_chat(user,span_danger("Invalid color. Your color is not bright enough."))

				if("butt_size")
					var/min_B = CONFIG_GET(number/butt_min_size_prefs)
					var/max_B = CONFIG_GET(number/butt_max_size_prefs)
					var/new_length = input(user, "Butt size:\n([min_B]-[max_B])", "Character Preference") as num|null
					if(new_length)
						features["butt_size"] = clamp(round(new_length), min_B, max_B)

				if("butt_visibility")
					var/n_vis = input(user, "Butt Visibility", "Character Preference") as null|anything in CONFIG_GET(keyed_list/safe_visibility_toggles)
					if(n_vis)
						features["butt_visibility"] = n_vis

				if("ooccolor")
					var/new_ooccolor = input(user, "Choose your OOC colour:", "Game Preference",ooccolor) as color|null
					if(new_ooccolor)
						ooccolor = new_ooccolor

				if("aooccolor")
					var/new_aooccolor = input(user, "Choose your Antag OOC colour:", "Game Preference",ooccolor) as color|null
					if(new_aooccolor)
						aooccolor = new_aooccolor

				if("bag")
					var/new_backbag = input(user, "Choose your character's style of bag:", "Character Preference")  as null|anything in GLOB.backbaglist
					if(new_backbag)
						backbag = new_backbag

				if("suit")
					if(jumpsuit_style == PREF_SUIT)
						jumpsuit_style = PREF_SKIRT
					else
						jumpsuit_style = PREF_SUIT

				if("sec_dept")
					var/department = input(user, "Choose your preferred security department:", "Security Departments") as null|anything in GLOB.security_depts_prefs
					if(department)
						prefered_security_department = department

				if ("preferred_map")
					var/maplist = list()
					var/default = "Default"
					if (config.defaultmap)
						default += " ([config.defaultmap.map_name])"
					for (var/M in config.maplist)
						var/datum/map_config/VM = config.maplist[M]
						var/friendlyname = "[VM.map_name] "
						if (VM.voteweight <= 0)
							friendlyname += " (disabled)"
						maplist[friendlyname] = VM.map_name
					maplist[default] = null
					var/pickedmap = input(user, "Choose your preferred map. This will be used to help weight random map selection.", "Character Preference")  as null|anything in maplist
					if (pickedmap)
						preferred_map = maplist[pickedmap]

				if ("preferred_chaos")
					var/pickedchaos = input(user, "Choose your preferred level of chaos. This will help with dynamic threat level ratings.", "Character Preference") as null|anything in list(CHAOS_NONE,CHAOS_LOW,CHAOS_MED,CHAOS_HIGH,CHAOS_MAX)
					preferred_chaos = pickedchaos
				if ("clientfps")
					var/desiredfps = input(user, "Choose your desired fps. (0 = synced with server tick rate (currently:[world.fps]))", "Character Preference", clientfps)  as null|num
					if (!isnull(desiredfps))
						clientfps = desiredfps
						parent.fps = desiredfps
				if("input_mode_hotkey")
					if(input_mode_hotkey == "Tab")
						input_mode_hotkey = "Ctrl+Tab"
					else
						input_mode_hotkey = "Tab"
					parent.change_input_toggle_key(input_mode_hotkey, send_chat = TRUE)
					
				if("ui")
					var/pickedui = input(user, "Choose your UI style.", "Character Preference", UI_style)  as null|anything in GLOB.available_ui_styles
					if(pickedui)
						UI_style = pickedui
						if (parent && parent.mob && parent.mob.hud_used)
							parent.mob.hud_used.update_ui_style(ui_style2icon(UI_style))
				if("pda_style")
					var/pickedPDAStyle = input(user, "Choose your PDA style.", "Character Preference", pda_style)  as null|anything in GLOB.pda_styles
					if(pickedPDAStyle)
						pda_style = pickedPDAStyle
				if("pda_color")
					var/pickedPDAColor = input(user, "Choose your PDA Interface color.", "Character Preference",pda_color) as color|null
					if(pickedPDAColor)
						pda_color = pickedPDAColor
				if ("max_chat_length")
					var/desiredlength = input(user, "Choose the max character length of shown Runechat messages. Valid range is 1 to [CHAT_MESSAGE_MAX_LENGTH] (default: [initial(max_chat_length)]))", "Character Preference", max_chat_length)  as null|num
					if (!isnull(desiredlength))
						max_chat_length = clamp(desiredlength, 1, CHAT_MESSAGE_MAX_LENGTH)

				if("hud_toggle_color")
					var/new_toggle_color = input(user, "Choose your HUD toggle flash color:", "Game Preference",hud_toggle_color) as color|null
					if(new_toggle_color)
						hud_toggle_color = new_toggle_color

				if("gender")
					var/chosengender = input(user, "Select your character's gender.", "Gender Selection", gender) as null|anything in list(MALE,FEMALE,"nonbinary","object")
					if(!chosengender)
						return
					switch(chosengender)
						if("nonbinary")
							chosengender = PLURAL
							features["body_model"] = pick(MALE, FEMALE)
						if("object")
							chosengender = NEUTER
							features["body_model"] = MALE
						else
							features["body_model"] = chosengender
					gender = chosengender

				if("body_size")
					var/min = CONFIG_GET(number/body_size_min)
					var/max = CONFIG_GET(number/body_size_max)
					var/danger = CONFIG_GET(number/threshold_body_size_slowdown)
					var/new_body_size = input(user, "Choose your desired sprite size: ([min*100]%-[max*100]%)\nWarning: This may make your character look distorted[danger > min ? "! Additionally, a proportional movement speed penalty will be applied to characters smaller than [danger*100]%." : "!"]", "Character Preference", features["body_size"]*100) as num|null
					if (new_body_size)
						new_body_size = clamp(new_body_size * 0.01, min, max)
						var/dorfy
						if((new_body_size + 0.01) < danger) // Adding 0.01 as a dumb fix to prevent the warning message from appearing when exactly at threshold... Not sure why that happens in the first place.
							dorfy = alert(user, "You have chosen a size below the slowdown threshold of [danger*100]%. For balancing purposes, the further you go below this percentage, the slower your character will be. Do you wish to keep this size?", "Speed Penalty Alert", "Yes", "Move it to the threshold", "No")
							if(dorfy == "Move it to the threshold")
								new_body_size = danger
							if(!dorfy) //Aborts if this var is somehow empty
								return
						if(dorfy != "No")
							features["body_size"] = new_body_size

				if("toggle_fuzzy")
					fuzzy = !fuzzy

				if("body_width")
					var/min = CONFIG_GET(number/body_width_min)
					var/max = CONFIG_GET(number/body_width_max)
					var/new_body_width = input(user, "Choose your desired sprite size: ([min*100]%-[max*100]%)\nWarning: This may make your character look distorted", "Character Preference", features["body_width"]*100) as num|null
					if (new_body_width)
						new_body_width = clamp(new_body_width * 0.01, min, max)
						features["body_width"] = new_body_width
				
				if("waddle_amount")
					var/new_waddle_amount = input(user, "Choose how many pixels you want to move when walking(4 Recommended): ([WADDLE_MIN]-[WADDLE_MAX])", "Character Preference", waddle_amount) as num|null
					if(isnum(new_waddle_amount))
						new_waddle_amount = round(clamp(new_waddle_amount, WADDLE_MIN, WADDLE_MAX), 0.1)
						waddle_amount = new_waddle_amount
				
				if("up_waddle_time")
					var/new_up_waddle_time = input(user, "Choose how fast you want to move up & down while walking(1 Recommended): ([UP_WADDLE_MIN]-[UP_WADDLE_MAX])", "Character Preference", up_waddle_time) as num|null
					if(isnum(new_up_waddle_time))
						new_up_waddle_time = round(clamp(new_up_waddle_time, UP_WADDLE_MIN, UP_WADDLE_MAX), 0.1)
						up_waddle_time = new_up_waddle_time
				
				if("side_waddle_time")
					var/new_side_waddle_time = input(user, "Choose how fast you want to move side to side while walking(2 Recommended): ([SIDE_WADDLE_MIN]-[SIDE_WADDLE_MAX])", "Character Preference", side_waddle_time) as num|null
					if(isnum(new_side_waddle_time))
						new_side_waddle_time = round(clamp(new_side_waddle_time, SIDE_WADDLE_MIN, SIDE_WADDLE_MAX), 0.1)
						side_waddle_time = new_side_waddle_time
				
				if("creature_body_size")
					var/min = CONFIG_GET(number/body_size_min)
					var/max = CONFIG_GET(number/body_size_max)
					var/danger = CONFIG_GET(number/threshold_body_size_slowdown)
					var/new_body_size = input(user, "Choose your desired sprite size: ([min*100]%-[max*100]%)\nWarning: This may make your character look distorted[danger > min ? "! Additionally, a proportional movement speed penalty may be applied to characters smaller than [danger*100]%." : "!"]", "Character Preference", creature_body_size*100) as num|null
					if (new_body_size)
						new_body_size = clamp(new_body_size * 0.01, min, max)
						creature_body_size = new_body_size

				if("creature_toggle_fuzzy")
					creature_fuzzy = !creature_fuzzy

				if("tongue")
					var/selected_custom_tongue = input(user, "Choose your desired tongue (none means your species tongue)", "Character Preference") as null|anything in GLOB.roundstart_tongues
					if(selected_custom_tongue)
						custom_tongue = selected_custom_tongue

				if("speech_verb")
					var/selected_custom_speech_verb = input(user, "Choose your desired speech verb (none means your species speech verb)", "Character Preference") as null|anything in GLOB.speech_verbs
					if(selected_custom_speech_verb)
						custom_speech_verb = selected_custom_speech_verb

				if("bodysprite")
					var/selected_body_sprite = input(user, "Choose your desired body sprite", "Character Preference") as null|anything in pref_species.allowed_limb_ids
					if(selected_body_sprite)
						chosen_limb_id = selected_body_sprite //this gets sanitized before loading

				if("marking_down")
					// move the specified marking down
					var/index = text2num(href_list["marking_index"])
					var/marking_type = href_list["marking_type"]
					if(index && marking_type && features[marking_type] && index != length(features[marking_type]))
						var/index_down = index + 1
						var/markings = features[marking_type]
						var/first_marking = markings[index]
						var/second_marking = markings[index_down]
						markings[index] = second_marking
						markings[index_down] = first_marking

				if("marking_up")
					// move the specified marking up
					var/index = text2num(href_list["marking_index"])
					var/marking_type = href_list["marking_type"]
					if(index && marking_type && features[marking_type] && index != 1)
						var/index_up = index - 1
						var/markings = features[marking_type]
						var/first_marking = markings[index]
						var/second_marking = markings[index_up]
						markings[index] = second_marking
						markings[index_up] = first_marking

				if("marking_remove")
					// move the specified marking up
					var/index = text2num(href_list["marking_index"])
					var/marking_type = href_list["marking_type"]
					if(index && marking_type && features[marking_type])
						// because linters are just absolutely awful:
						var/list/L = features[marking_type]
						L.Cut(index, index + 1)

				if("marking_add")
					// add a marking
					var/marking_type = href_list["marking_type"]
					if(marking_type && features[marking_type])
						var/selected_limb = input(user, "Choose the limb to apply to.", "Character Preference") as null|anything in list("Head", "Chest", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "All")
						if(selected_limb)
							var/list/marking_list = GLOB.mam_body_markings_list
							var/list/snowflake_markings_list = list()
							for(var/path in marking_list)
								var/datum/sprite_accessory/S = marking_list[path]
								if(istype(S))
									if(istype(S, /datum/sprite_accessory/mam_body_markings))
										var/datum/sprite_accessory/mam_body_markings/marking = S
										if(!(selected_limb in marking.covered_limbs) && selected_limb != "All")
											continue

									if((!S.ckeys_allowed) || (S.ckeys_allowed.Find(user.client.ckey)))
										snowflake_markings_list[S.name] = path

							var/selected_marking = input(user, "Select the marking to apply to the limb.") as null|anything in snowflake_markings_list
							if(selected_marking)
								if(selected_limb != "All")
									var/limb_value = text2num(GLOB.bodypart_values[selected_limb])
									features[marking_type] += list(list(limb_value, selected_marking))
								else
									var/datum/sprite_accessory/mam_body_markings/S = marking_list[selected_marking]
									for(var/limb in S.covered_limbs)
										var/limb_value = text2num(GLOB.bodypart_values[limb])
										features[marking_type] += list(list(limb_value, selected_marking))

				if("marking_color")
					var/index = text2num(href_list["marking_index"])
					var/marking_type = href_list["marking_type"]
					if(index && marking_type && features[marking_type])
						// work out the input options to show the user
						var/list/options = list("Primary")
						var/number_colors = text2num(href_list["number_colors"])
						var/color_number = 1 // 1-3 which color are we editing
						if(number_colors >= 2)
							options += "Secondary"
						if(number_colors == 3)
							options += "Tertiary"
						var/color_option = input(user, "Select the colour you wish to edit") as null|anything in options
						if(color_option)
							if(color_option == "Secondary") color_number = 2
							if(color_option == "Tertiary") color_number = 3
							// perform some magic on the color number
							var/list/marking_list = features[marking_type][index]
							var/datum/sprite_accessory/mam_body_markings/S = GLOB.mam_body_markings_list[marking_list[2]]
							var/matrixed_sections = S.covered_limbs[GLOB.bodypart_names[num2text(marking_list[1])]]
							if(color_number == 1)
								switch(matrixed_sections)
									if(MATRIX_GREEN)
										color_number = 2
									if(MATRIX_BLUE)
										color_number = 3
							else if(color_number == 2)
								switch(matrixed_sections)
									if(MATRIX_RED_BLUE)
										color_number = 3
									if(MATRIX_GREEN_BLUE)
										color_number = 3

							var/color_list = features[marking_type][index][3]
							var/new_marking_color = input(user, "Choose your character's marking color:", "Character Preference","#"+color_list[color_number]) as color|null
							if(new_marking_color)
								var/temp_hsv = RGBtoHSV(new_marking_color)
								if((MUTCOLORS_PARTSONLY in pref_species.species_traits) || ReadHSV(temp_hsv)[3] >= ReadHSV(MINIMUM_MUTANT_COLOR)[3]) // mutantcolors must be bright, but only if they affect the skin
									color_list[color_number] = "#[sanitize_hexcolor(new_marking_color, 6)]"
								else
									to_chat(user, span_danger("Invalid color. Your color is not bright enough."))
		else
			switch(href_list["preference"])
				//CITADEL PREFERENCES EDIT - I can't figure out how to modularize these, so they have to go here. :c -Pooj
				if("arousable")
					arousable = !arousable
				if("has_cock")
					features["has_cock"] = !features["has_cock"]
				if("has_balls")
					features["has_balls"] = !features["has_balls"]
				if("has_breasts")
					features["has_breasts"] = !features["has_breasts"]
					if(features["has_breasts"] == FALSE)
						features["breasts_producing"] = FALSE
				if("breasts_producing")
					features["breasts_producing"] = !features["breasts_producing"]
				if("has_vag")
					features["has_vag"] = !features["has_vag"]
				if("has_womb")
					features["has_womb"] = !features["has_womb"]
				if("has_butt")
					features["has_butt"] = !features["has_butt"]
				if("has_belly")
					features["has_belly"] = !features["has_belly"]
				if("widescreenpref")
					widescreenpref = !widescreenpref
					user.client.change_view(CONFIG_GET(string/default_view))
				if("end_of_round_deathmatch")
					end_of_round_deathmatch = !end_of_round_deathmatch
				if("set_matchmaking_pref")
					var/datum/matchmaking_pref/matchmake_type = text2path(href_list["matchmake_type"])
					if(matchmake_type in SSmatchmaking?.all_match_types)
						var/max_matches = initial(matchmake_type.max_matches)
						if(max_matches == 1)
							if(matchmaking_prefs[matchmake_type])
								matchmaking_prefs -= matchmake_type
							else
								matchmaking_prefs[matchmake_type] = TRUE
						else if(max_matches)
							var/current_value = clamp((matchmaking_prefs[matchmake_type] || 0), 0, max_matches)
							var/desired_matches = input(user, "Set the amount", "[initial(matchmake_type.pref_text)]", current_value)  as null|num
							if (!isnull(desired_matches))
								if(desired_matches == 0)
									matchmaking_prefs -= matchmake_type
								else
									matchmaking_prefs[matchmake_type] = clamp(desired_matches, 1, max_matches)
				if("autostand")
					autostand = !autostand
				if("auto_ooc")
					auto_ooc = !auto_ooc
				if("no_tetris_storage")
					no_tetris_storage = !no_tetris_storage
				if("guncursor")
					cb_toggles ^= AIM_CURSOR_ON
				if ("screenshake")
					var/desiredshake = input(user, "Set the amount of screenshake you want. \n(0 = disabled, 100 = full, 200 = maximum.)", "Character Preference", screenshake)  as null|num
					if (!isnull(desiredshake))
						screenshake = desiredshake
				if("damagescreenshake")
					switch(damagescreenshake)
						if(0)
							damagescreenshake = 1
						if(1)
							damagescreenshake = 2
						if(2)
							damagescreenshake = 0
						else
							damagescreenshake = 1
				//END CITADEL EDIT
				if("publicity")
					if(unlock_content)
						toggles ^= MEMBER_PUBLIC

				if("body_model")
					features["body_model"] = features["body_model"] == MALE ? FEMALE : MALE

				if("hotkeys")
					hotkeys = !hotkeys
					user.client.ensure_keys_set(src)

				if("keybindings_capture")
					var/datum/keybinding/kb = GLOB.keybindings_by_name[href_list["keybinding"]]
					CaptureKeybinding(user, kb, href_list["old_key"], text2num(href_list["independent"]), kb.special || kb.clientside)
					return

				if("keybindings_set")
					var/kb_name = href_list["keybinding"]
					if(!kb_name)
						user << browse(null, "window=capturekeypress")
						ShowChoices(user)
						return

					var/independent = href_list["independent"]

					var/clear_key = text2num(href_list["clear_key"])
					var/old_key = href_list["old_key"]
					if(clear_key)
						if(independent)
							modless_key_bindings -= old_key
						else
							if(key_bindings[old_key])
								key_bindings[old_key] -= kb_name
								LAZYADD(key_bindings["Unbound"], kb_name)
								if(!length(key_bindings[old_key]))
									key_bindings -= old_key
						user << browse(null, "window=capturekeypress")
						if(href_list["special"])		// special keys need a full reset
							user.client.ensure_keys_set(src)
						save_preferences()
						ShowChoices(user)
						return

					var/new_key = uppertext(href_list["key"])
					var/AltMod = text2num(href_list["alt"]) ? "Alt" : ""
					var/CtrlMod = text2num(href_list["ctrl"]) ? "Ctrl" : ""
					var/ShiftMod = text2num(href_list["shift"]) ? "Shift" : ""
					var/numpad = text2num(href_list["numpad"]) ? "Numpad" : ""
					// var/key_code = text2num(href_list["key_code"])

					if(GLOB._kbMap[new_key])
						new_key = GLOB._kbMap[new_key]

					var/full_key
					switch(new_key)
						if("Alt")
							full_key = "[new_key][CtrlMod][ShiftMod]"
						if("Ctrl")
							full_key = "[AltMod][new_key][ShiftMod]"
						if("Shift")
							full_key = "[AltMod][CtrlMod][new_key]"
						else
							full_key = "[AltMod][CtrlMod][ShiftMod][numpad][new_key]"
					if(independent)
						modless_key_bindings -= old_key
						modless_key_bindings[full_key] = kb_name
					else
						if(key_bindings[old_key])
							key_bindings[old_key] -= kb_name
							if(!length(key_bindings[old_key]))
								key_bindings -= old_key
						key_bindings[full_key] += list(kb_name)
						key_bindings[full_key] = sortList(key_bindings[full_key])
					if(href_list["special"])		// special keys need a full reset
						user.client.ensure_keys_set(src)
					user << browse(null, "window=capturekeypress")
					save_preferences()

				if("keybindings_reset")
					var/choice = tgalert(user, "Would you prefer 'hotkey' or 'classic' defaults?", "Setup keybindings", "Hotkey", "Classic", "Cancel")
					if(choice == "Cancel")
						ShowChoices(user)
						return
					hotkeys = (choice == "Hotkey")
					key_bindings = (hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)
					modless_key_bindings = list()
					user.client.ensure_keys_set(src)

				if("chat_on_map")
					chat_on_map = !chat_on_map
				if("see_chat_non_mob")
					see_chat_non_mob = !see_chat_non_mob
				if("see_rc_emotes")
					see_rc_emotes = !see_rc_emotes
				if("color_chat_log")
					color_chat_log = !color_chat_log

				if("action_buttons")
					buttons_locked = !buttons_locked
				if("tgui_fancy")
					tgui_fancy = !tgui_fancy
				if("tgui_lock")
					tgui_lock = !tgui_lock
				if("winflash")
					windowflashing = !windowflashing
				if("hear_adminhelps")
					toggles ^= SOUND_ADMINHELP
				if("announce_login")
					toggles ^= ANNOUNCE_LOGIN
				if("combohud_lighting")
					toggles ^= COMBOHUD_LIGHTING
				if("toggle_split_admin_tabs")
					toggles ^= SPLIT_ADMIN_TABS

				if("be_special")
					var/be_special_type = href_list["be_special_type"]
					if(be_special_type in be_special)
						be_special -= be_special_type
					else
						be_special += be_special_type

				if("name")
					be_random_name = !be_random_name
					if(isnewplayer(parent.mob)) // Update the player panel with the new name.
						var/mob/dead/new_player/player_mob = parent.mob
						player_mob.new_player_panel()

				if("all")
					be_random_body = !be_random_body

				if("hear_hunting_horns")
					toggles ^= SOUND_HUNTINGHORN
					
				if("hear_sprint_buffer")
					toggles ^= SOUND_SPRINTBUFFER
					
				if("hear_midis")
					toggles ^= SOUND_MIDI

				if("persistent_scars")
					persistent_scars = !persistent_scars

				if("underwear_hands")
					TOGGLE_VAR(underwear_overhands)

				if("clear_scars")
					to_chat(user, span_notice("All scar slots cleared. Please save character to confirm."))
					scars_list["1"] = ""
					scars_list["2"] = ""
					scars_list["3"] = ""
					scars_list["4"] = ""
					scars_list["5"] = ""

				if("lobby_music")
					toggles ^= SOUND_LOBBY
					if((toggles & SOUND_LOBBY) && user.client && isnewplayer(user))
						user.client.playtitlemusic()
					else
						user.stop_sound_channel(CHANNEL_LOBBYMUSIC)

				if("ghost_ears")
					chat_toggles ^= CHAT_GHOSTEARS

				if("ghost_sight")
					chat_toggles ^= CHAT_GHOSTSIGHT

				if("ghost_whispers")
					chat_toggles ^= CHAT_GHOSTWHISPER

				if("ghost_radio")
					chat_toggles ^= CHAT_GHOSTRADIO

				if("ghost_pda")
					chat_toggles ^= CHAT_GHOSTPDA

				if("income_pings")
					chat_toggles ^= CHAT_BANKCARD

				if("static_blurble")
					chat_toggles ^= CHAT_HEAR_RADIOBLURBLES

				if("static_radio")
					chat_toggles ^= CHAT_HEAR_RADIOSTATIC

				if("pull_requests")
					chat_toggles ^= CHAT_PULLR

				if("allow_midround_antag")
					toggles ^= MIDROUND_ANTAG

				if("parallaxup")
					parallax = WRAP(parallax + 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
					if (parent && parent.mob && parent.mob.hud_used)
						parent.mob.hud_used.update_parallax_pref(parent.mob)

				if("parallaxdown")
					parallax = WRAP(parallax - 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
					if (parent && parent.mob && parent.mob.hud_used)
						parent.mob.hud_used.update_parallax_pref(parent.mob)

				// Citadel edit - Prefs don't work outside of this. :c

				if("genital_examine")
					cit_toggles ^= GENITAL_EXAMINE

				if("breast_enlargement")
					cit_toggles ^= BREAST_ENLARGEMENT

				if("penis_enlargement")
					cit_toggles ^= PENIS_ENLARGEMENT

				if("butt_enlargement")
					cit_toggles ^= BUTT_ENLARGEMENT

				if("belly_enlargement")
					cit_toggles ^= BELLY_ENLARGEMENT

				if("feminization")
					cit_toggles ^= FORCED_FEM

				if("masculinization")
					cit_toggles ^= FORCED_MASC

				if("hypno")
					cit_toggles ^= HYPNO

				if("never_hypno")
					cit_toggles ^= NEVER_HYPNO

				if("aphro")
					cit_toggles ^= NO_APHRO

				if("ass_slap")
					cit_toggles ^= NO_ASS_SLAP

				if("bimbo")
					cit_toggles ^= BIMBOFICATION

				if("auto_wag")
					cit_toggles ^= NO_AUTO_WAG

				//END CITADEL EDIT

				if("ambientocclusion")
					ambientocclusion = !ambientocclusion
					if(parent && parent.screen && parent.screen.len)
						var/atom/movable/screen/plane_master/game_world/G = parent.mob.hud_used.plane_masters["[GAME_PLANE]"]
						var/atom/movable/screen/plane_master/objitem/OI = parent.mob.hud_used.plane_masters["[OBJITEM_PLANE]"]
						var/atom/movable/screen/plane_master/mob/M = parent.mob.hud_used.plane_masters["[MOB_PLANE]"]
						var/atom/movable/screen/plane_master/above_wall/A = parent.mob.hud_used.plane_masters["[ABOVE_WALL_PLANE]"]
						var/atom/movable/screen/plane_master/wall/W = parent.mob.hud_used.plane_masters["[WALL_PLANE]"]
						G.backdrop(parent.mob)
						OI.backdrop(parent.mob)
						M.backdrop(parent.mob)
						A.backdrop(parent.mob)
						W.backdrop(parent.mob)

				if("auto_fit_viewport")
					auto_fit_viewport = !auto_fit_viewport
					if(auto_fit_viewport && parent)
						parent.fit_viewport()

				if("hud_toggle_flash")
					hud_toggle_flash = !hud_toggle_flash

				if("save")
					save_preferences()
					save_character()

				if("load")
					load_preferences()
					load_character()

				if("changeslot")
					if(!load_character(text2num(href_list["num"])))
						random_character()
						real_name = random_unique_name(gender)
						save_character()
					if(isnewplayer(parent.mob)) // Update the player panel with the new name.
						var/mob/dead/new_player/player_mob = parent.mob
						player_mob.new_player_panel()

				if("tab")
					if(href_list["tab"])
						current_tab = text2num(href_list["tab"])
				if("erp_tab")
					if(href_list["newtab"])
						if(href_list["nonumber"])
							erp_tab_page = href_list["newtab"]
						else
							erp_tab_page = text2num(href_list["newtab"])

	chat_toggles |= CHAT_LOOC // the LOOC stays on during sex
	if(href_list["preference"] == "gear")
		if(href_list["clear_loadout"])
			loadout_data["SAVE_[loadout_slot]"] = list()

			save_preferences()
		if(href_list["select_category"])
			gear_category = html_decode(href_list["select_category"])
			gear_subcategory = GLOB.loadout_categories[gear_category][1]
		if(href_list["select_subcategory"])
			gear_subcategory = html_decode(href_list["select_subcategory"])
		if(href_list["toggle_gear_path"])
			var/name = html_decode(href_list["toggle_gear_path"])
			var/datum/gear/G = GLOB.loadout_items[gear_category][gear_subcategory][name]
			if(!G)
				return
			var/toggle = text2num(href_list["toggle_gear"])
			if(!toggle && has_loadout_gear(loadout_slot, "[G.type]"))//toggling off and the item effectively is in chosen gear)
				remove_gear_from_loadout(loadout_slot, "[G.type]")
			else if(toggle && !(has_loadout_gear(loadout_slot, "[G.type]")))
				
				if(!is_loadout_slot_available(G.category, G.cost))
					to_chat(user, span_danger("You can only take [MAX_FREE_PER_CAT] free items from this category!"))
					return
				
				if(G.donoritem && !G.donator_ckey_check(user.ckey))
					to_chat(user, span_danger("This is an item intended for donator use only. You are not authorized to use this item."))
					return
				if(gear_points >= initial(G.cost))
					var/list/new_loadout_data = list(LOADOUT_ITEM = "[G.type]")
					if(loadout_data["SAVE_[loadout_slot]"])
						loadout_data["SAVE_[loadout_slot]"] += list(new_loadout_data) //double packed because it does the union of the CONTENTS of the lists
					else
						loadout_data["SAVE_[loadout_slot]"] = list(new_loadout_data) //double packed because you somehow had no save slot in your loadout?

		if(href_list["loadout_color"] || href_list["loadout_rename"] || href_list["loadout_redescribe"])
		//if the gear doesn't exist, or they don't have it, ignore the request
			var/name = html_decode(href_list["loadout_gear_name"])
			var/datum/gear/G = GLOB.loadout_items[gear_category][gear_subcategory][name]
			if(!G)
				return
			var/user_gear = has_loadout_gear(loadout_slot, "[G.type]")
			if(!user_gear)
				return

			//possible requests: rename, redescribe (recolor/recolor polychrom not ported)
			//always make sure the gear allows said request before proceeding

			//both renaming and redescribing strip the input to stop html injection

			//renaming is only allowed if it has the flag for it
			if(href_list["loadout_rename"] && (G.loadout_flags & LOADOUT_CAN_NAME))
				var/new_name = stripped_input(user, "Enter new name for item. Maximum [MAX_NAME_LEN] characters.", "Loadout Item Naming", null, MAX_NAME_LEN)
				if(new_name)
					user_gear[LOADOUT_CUSTOM_NAME] = new_name

			//redescribing is only allowed if it has the flag for it
			if(href_list["loadout_redescribe"] && (G.loadout_flags & LOADOUT_CAN_DESCRIPTION)) //redescribe isnt a real word but i can't think of the right term to use
				var/new_description = stripped_input(user, "Enter new description for item. Maximum 500 characters.", "Loadout Item Redescribing", null, 500)
				if(new_description)
					user_gear[LOADOUT_CUSTOM_DESCRIPTION] = new_description

	ShowChoices(user)
	return 1

/datum/preferences/proc/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, initial_spawn = FALSE, sans_underpants)
	if(be_random_name)
		real_name = pref_species.random_name(gender)

	if(be_random_body)
		random_character(gender)

	if(roundstart_checks)
		if(CONFIG_GET(flag/humans_need_surnames) && (pref_species.id == "human"))
			var/firstspace = findtext(real_name, " ")
			var/name_length = length(real_name)
			if(!firstspace)	//we need a surname
				real_name += " [pick(GLOB.last_names)]"
			else if(firstspace == name_length)
				real_name += "[pick(GLOB.last_names)]"

	character.real_name = real_name
	character.name = character.real_name
	character.custom_species = custom_species

	character.gender = gender
	character.age = age
	//special stuff
	character.special_s = special_s
	character.special_p = special_p
	character.special_e = special_e
	character.special_c = special_c
	character.special_i = special_i
	character.special_a = special_a
	character.special_l = special_l
	character.fuzzy = fuzzy

	character.eye_over_hair = eye_over_hair
	character.left_eye_color = left_eye_color
	character.right_eye_color = right_eye_color
	var/obj/item/organ/eyes/organ_eyes = character.getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		if(!initial(organ_eyes.left_eye_color))
			organ_eyes.left_eye_color = left_eye_color
			organ_eyes.right_eye_color = right_eye_color
		organ_eyes.old_left_eye_color = left_eye_color
		organ_eyes.old_right_eye_color = right_eye_color
	character.hair_color = hair_color
	character.facial_hair_color = facial_hair_color
	character.skin_tone = skin_tone
	character.dna.skin_tone_override = use_custom_skin_tone ? skin_tone : null
	character.hair_style = hair_style
	character.facial_hair_style = facial_hair_style
	character.underwear = underwear

	character.hidden_undershirt = sans_underpants // hey its my favorite character, sans underpants
	character.hidden_underwear = sans_underpants
	character.hidden_socks = sans_underpants

	character.saved_underwear = underwear
	character.undershirt = undershirt
	character.saved_undershirt = undershirt
	character.socks = socks
	character.saved_socks = socks
	character.undie_color = undie_color
	character.shirt_color = shirt_color
	character.socks_color = socks_color
	character.underwear_oversuit = undies_overclothes
	character.undershirt_oversuit = undershirt_overclothes
	character.socks_oversuit = socks_overclothes

	var/datum/species/chosen_species
	if(!roundstart_checks || (pref_species.id in GLOB.roundstart_races))
		chosen_species = pref_species.type
	else
		chosen_species = /datum/species/human
		pref_species = new /datum/species/human
		save_character()

	var/old_size = character.dna.features["body_size"]
	var/old_width = character.dna.features["body_width"]

	character.dna.features = features.Copy()
	character.dna.alt_appearance = alt_appearance
	character.set_species(chosen_species, icon_update = FALSE, pref_load = TRUE)
	character.dna.species.eye_type = eye_type
	SSlistbank.catalogue_tastes(character, list(character.dna.features["taste"] = 1), TRUE) // unique and important
	if(chosen_limb_id && (chosen_limb_id in character.dna.species.allowed_limb_ids))
		character.dna.species.mutant_bodyparts["limbs_id"] = chosen_limb_id
	character.dna.real_name = character.real_name
	character.dna.custom_species = character.custom_species

	if((parent && parent.can_have_part("meat_type")) || pref_species.mutant_bodyparts["meat_type"])
		character.type_of_meat = GLOB.meat_types[features["meat_type"]]

	if(((parent && parent.can_have_part("legs")) || pref_species.mutant_bodyparts["legs"])  && (character.dna.features["legs"] == "Digitigrade" || character.dna.features["legs"] == "Avian"))
		pref_species.species_traits |= DIGITIGRADE
	else
		pref_species.species_traits -= DIGITIGRADE

	if(DIGITIGRADE in pref_species.species_traits)
		character.Digitigrade_Leg_Swap(FALSE)
	else
		character.Digitigrade_Leg_Swap(TRUE)

	character.give_genitals(TRUE) //character.update_genitals() is already called on genital.update_appearance()

	character.dna.update_body_size(old_size)
	character.dna.update_body_width(old_width)

	//speech stuff
	if(custom_tongue != "default")
		var/new_tongue = GLOB.roundstart_tongues[custom_tongue]
		if(new_tongue)
			character.dna.species.mutanttongue = new_tongue //this means we get our tongue when we clone
			var/obj/item/organ/tongue/T = character.getorganslot(ORGAN_SLOT_TONGUE)
			if(T)
				qdel(T)
			var/obj/item/organ/tongue/new_custom_tongue = new new_tongue
			new_custom_tongue.Insert(character)
	if(custom_speech_verb != "default")
		character.dna.species.say_mod = custom_speech_verb

	if(length(character.dna.features["custom_say"]))
		character.verb_say = character.dna.features["custom_say"]
	if(length(character.dna.features["custom_whisper"]))
		character.verb_whisper = character.dna.features["custom_whisper"]
	if(length(character.dna.features["custom_ask"]))
		character.verb_ask = character.dna.features["custom_ask"]
	if(length(character.dna.features["custom_exclaim"]))
		character.verb_exclaim = character.dna.features["custom_exclaim"]
	if(length(character.dna.features["custom_yell"]))
		character.verb_yell = character.dna.features["custom_yell"]
	if(length(character.dna.features["custom_sing"]))
		character.verb_sing = character.dna.features["custom_sing"]

	//limb stuff, only done when initially spawning in
	if(initial_spawn)
		//delete any existing prosthetic limbs to make sure no remnant prosthetics are left over - But DO NOT delete those that are species-related
		for(var/obj/item/bodypart/part in character.bodyparts)
			if(part.status == BODYPART_ROBOTIC && !part.render_like_organic)
				QDEL_NULL(part)
		character.regenerate_limbs() //regenerate limbs so now you only have normal limbs
		for(var/modified_limb in modified_limbs)
			var/modification = modified_limbs[modified_limb][1]
			var/obj/item/bodypart/old_part = character.get_bodypart(modified_limb)
			if(modification == LOADOUT_LIMB_PROSTHETIC)
				var/obj/item/bodypart/new_limb
				switch(modified_limb)
					if(BODY_ZONE_L_ARM)
						new_limb = new/obj/item/bodypart/l_arm/robot/surplus(character)
					if(BODY_ZONE_R_ARM)
						new_limb = new/obj/item/bodypart/r_arm/robot/surplus(character)
					if(BODY_ZONE_L_LEG)
						new_limb = new/obj/item/bodypart/l_leg/robot/surplus(character)
					if(BODY_ZONE_R_LEG)
						new_limb = new/obj/item/bodypart/r_leg/robot/surplus(character)
				var/prosthetic_type = modified_limbs[modified_limb][2]
				if(prosthetic_type != "prosthetic") //lets just leave the old sprites as they are
					new_limb.icon = wrap_file("icons/mob/augmentation/cosmetic_prosthetic/[prosthetic_type].dmi")
				new_limb.replace_limb(character)
			QDEL_NULL(old_part)

	SEND_SIGNAL(character, COMSIG_HUMAN_PREFS_COPIED_TO, src, icon_updates, roundstart_checks)

	//let's be sure the character updates
	if(icon_updates)
		character.update_body()
		character.update_hair()

/datum/preferences/proc/post_copy_to(mob/living/carbon/human/character)
	//if no legs, and not a paraplegic or a slime, give them a free wheelchair
	if(modified_limbs[BODY_ZONE_L_LEG] == LOADOUT_LIMB_AMPUTATED && modified_limbs[BODY_ZONE_R_LEG] == LOADOUT_LIMB_AMPUTATED && !character.has_quirk(/datum/quirk/paraplegic) && !isjellyperson(character))
		if(character.buckled)
			character.buckled.unbuckle_mob(character)
		var/turf/T = get_turf(character)
		var/obj/structure/chair/spawn_chair = locate() in T
		var/obj/vehicle/ridden/wheelchair/wheels = new(T)
		if(spawn_chair) // Makes spawning on the arrivals shuttle more consistent looking
			wheels.setDir(spawn_chair.dir)
		wheels.buckle_mob(character)

/datum/preferences/proc/get_default_name(name_id)
	switch(name_id)
		if("human")
			return random_unique_name()
//		if("ai")
//			return pick(GLOB.ai_names)
		if("cyborg")
			return DEFAULT_CYBORG_NAME
	return random_unique_name()

/datum/preferences/proc/ask_for_custom_name(mob/user,name_id)
	var/namedata = GLOB.preferences_custom_names[name_id]
	if(!namedata)
		return

	var/raw_name = input(user, "Choose your character's [namedata["qdesc"]]:","Character Preference") as text|null
	if(!raw_name)
		if(namedata["allow_null"])
			custom_names[name_id] = get_default_name(name_id)
		else
			return
	else
		var/sanitized_name = reject_bad_name(raw_name,namedata["allow_numbers"])
		if(!sanitized_name)
			to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z,[namedata["allow_numbers"] ? ",0-9," : ""] -, ' and .</font>")
			return
		else
			custom_names[name_id] = sanitized_name

/datum/preferences/proc/get_filtered_holoform(filter_type)
	if(!custom_holoform_icon)
		return
	LAZYINITLIST(cached_holoform_icons)
	if(!cached_holoform_icons[filter_type])
		cached_holoform_icons[filter_type] = process_holoform_icon_filter(custom_holoform_icon, filter_type)
	return cached_holoform_icons[filter_type]

//Resets the client's keybindings. Asks them for which
/datum/preferences/proc/force_reset_keybindings()
	var/choice = tgalert(parent.mob, "Your basic keybindings need to be reset, emotes will remain as before. Would you prefer 'hotkey' or 'classic' mode?", "Reset keybindings", "Hotkey", "Classic")
	hotkeys = (choice != "Classic")
	force_reset_keybindings_direct(hotkeys)

/// Does the actual reset
/datum/preferences/proc/force_reset_keybindings_direct(hotkeys = TRUE)
	var/list/oldkeys = key_bindings
	key_bindings = (hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)

	for(var/key in oldkeys)
		if(!key_bindings[key])
			key_bindings[key] = oldkeys[key]
	parent?.ensure_keys_set(src)

/datum/preferences/proc/is_loadout_slot_available(category, cost)
	if(cost)
		return TRUE
	var/list/L
	LAZYINITLIST(L)
	for(var/i in loadout_data["SAVE_[loadout_slot]"])
		var/loadie = i[LOADOUT_ITEM]
		var/datum/gear/G = text2path(loadie)
		if(initial(G.cost) > 0) // oh right, these are uninitialized, mb
			continue // non-free items are self limiting
		if(initial(G.category) != category)
			continue
		var/occupied_slots = L[initial(G.category)] ? L[initial(G.category)] + 1 : 1
		LAZYSET(L, initial(G.category), occupied_slots)
	for(var/things_got in L)
		if(L[things_got] > MAX_FREE_PER_CAT)
			return FALSE
	return TRUE
	/* switch(slot)
		if(SLOT_IN_BACKPACK)
			if(L[LOADOUT_CATEGORY_BACKPACK] < BACKPACK_SLOT_AMT)
				return TRUE
		if(SLOT_HANDS)
			if(L[LOADOUT_CATEGORY_HANDS] < HANDS_SLOT_AMT)
				return TRUE
		else
			if(L[slot] < MAX_FREE_PER_CAT)
				return TRUE */

/datum/preferences/proc/generate_quester_id()
	var/list/new_quid = list()
	if(parent)
		new_quid += ckey(parent.ckey)
	else
		new_quid += ckey(safepick(GLOB.ai_names) || "cranberry") //🤖 fixes integration tests
	new_quid += ckey(safepick(GLOB.ing_verbs) || "cranberry")
	new_quid += ckey(safepick(GLOB.adverbs) || "cranberry")
	new_quid += ckey("[rand(1000,9999)]")
	new_quid += ckey("[rand(1000,9999)]")
	return new_quid.Join("-")

/datum/preferences/proc/has_loadout_gear(save_slot, gear_type)
	var/list/gear_list = loadout_data["SAVE_[save_slot]"]
	for(var/loadout_gear in gear_list)
		if(loadout_gear[LOADOUT_ITEM] == gear_type)
			return loadout_gear
	return FALSE

/datum/preferences/proc/remove_gear_from_loadout(save_slot, gear_type)
	var/find_gear = has_loadout_gear(save_slot, gear_type)
	if(find_gear)
		loadout_data["SAVE_[save_slot]"] -= list(find_gear)

/datum/preferences/proc/get_my_quirks()
	if(!LAZYLEN(char_quirks))
		return "None!"
	var/list/quirk_dats = list()
	for(var/quirk in char_quirks)
		var/datum/quirk/Q = SSquirks.GetQuirk(quirk)
		quirk_dats += Q
	if(!LAZYLEN(quirk_dats))
		return "None?"
	var/list/dat = list()
	var/quirks_per_row = 5
	var/cells_left = 5
	dat += "<table class='undies_table'>"
	for(var/datum/quirk/Q in quirk_dats)
		var/qname = Q.name
		switch(Q.value)
			if(-INFINITY to -1)
				qname = "<font color='red'>[Q.name]</font>"
			if(1 to INFINITY)
				qname = "<font color='green'><b>[Q.name]</b></font>"
			else
				qname = "<font color='yellow'>[Q.name]</font>"
		if(cells_left == quirks_per_row)
			dat += "<tr>"
		dat += "<td>[qname]</td>"
		if(cells_left-- <= 0)
			dat += "</tr>"
			cells_left = quirks_per_row
	dat += "</table>"
	return dat.Join()

#undef MAX_FREE_PER_CAT
#undef HANDS_SLOT_AMT
#undef BACKPACK_SLOT_AMT
