SUBSYSTEM_DEF(personals)
	name = "Personals" //""""Personals""""
	wait = 10 SECONDS
	init_order = INIT_ORDER_STATPANELS
	priority = FIRE_PRIORITY_PERSONALS
	runlevels = RUNLEVELS_DEFAULT | RUNLEVEL_LOBBY
	var/thingname = "Personals"
	var/list/personals = list()
	var/list/personals_cache = list()
	var/list/readme = list()
	/// Format: list("adventure_notes" = "Notes", "adventure_i_am_a" = "I Am A...", etc)
	var/list/entry_labels = list()
	/// Format: list("Adventure" = list("Adventure Notes", "Adventure I Am A", etc), "RP" = list("RP Notes", "RP I Am A", etc), etc)
	var/list/entry_kinds = list()
	
/datum/controller/subsystem/personals/proc/Initialize(start_timeofday)
	thingname = pick(
		"Mango's List",
		"Wastr",
		"Plenty of Geckos",
		"Only Wasters",
		"Bluespace",
		"Meet'n'Greet",
		"Personals",
	)
	setup_readme()
	. = ..()

/datum/controller/subsystem/personals/proc/setup_readme()
	var/list/preadme = safe_json_decode(file2text("strings/personals_tooltips.json"))
	for(var/topica in readme) // the population of topica kansass is 126k
		var/list/inner_lines = list()
		for(var/line in preadme[topica])
			if(line.findtext("%LABEL:"))
				var/label = line.replacetext("%LABEL:", "")
				entry_labels[topica] = label
				continue
			if(line.findtext("%KIND:"))
				var/kind = line.replacetext("%KIND:", "")
				entry_kinds[kind] = topica
				continue
			line = replace(line, "%THINGNAME", thingname)
			inner_lines += line
		readme[topica] = inner_lines.Join("<br><br>") // EBRBRBRBRBRBRBRBR

/datum/controller/subsystem/personals/proc/update_all_personals()
	for(var/mob/living/r4r in GLOB.living_player_list)
		get_personal(r4r, FALSE)
	refresh_cache()

/datum/controller/subsystem/personals/proc/get_personal(mob/living/r4r, recache = TRUE, update = TRUE) // this time, it's personal
	if(!istype(r4r))
		return
	var/datum/personal_info/PI = LAZYACCESS(personals, r4r.real_name)
	if(!PI)
		PI = new()
	if(recache)
		refresh_cache()
	if(update)
		PI.import_data(r4r)
	PI.online = !!r4r.client
	return PI

/datum/controller/subsystem/personals/proc/logged_in(mob/living/r4r)
	if(!istype(r4r))
		return
	var/datum/personal_info/PI = get_personal(r4r)
	PI.online = TRUE
	refresh_cache()

/datum/controller/subsystem/personals/proc/logged_out(mob/living/r4r)
	if(!istype(r4r))
		return
	var/datum/personal_info/PI = get_personal(r4r)
	PI.online = FALSE
	refresh_cache()

/datum/controller/subsystem/personals/proc/update_entry(mob/living/r4r, entry, value)
	if(!istype(r4r))
		return
	var/datum/personal_info/PI = get_personal(r4r)
	PI.update_entry(entry, value)

/datum/controller/subsystem/personals/proc/update_visibility(mob/living/r4r, vis, yn)
	if(!istype(r4r))
		return
	var/datum/personal_info/PI = get_personal(r4r)
	PI.update_visibility(vis, yn)

/datum/controller/subsystem/personals/proc/refresh_cache()
	personals_cache = list()
	for(var/guy in personals)
		var/datum/personal_info/PI = get_personal(guy, FALSE, FALSE)
		var/list/person = PI.get_data()
		personals_cache += list(person)

/datum/controller/subsystem/personals/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "Personals", thingname)
		ui.open()

/datum/controller/subsystem/personals/ui_data(mob/user)
	refresh_cache()
	var/list/data = list()
	data["AllPersonals"] = personals_cache // private indeed ;)
	var/list/personal_user = personals_cache[user]
	if(user.client && check_rights_for(user.client, R_ADMIN))
		personal_user["IsAdmin"] = TRUE // admemes see ALL. and I mean all~ ;)
	else
		personal_user["IsAdmin"] = FALSE
	data["UserData"] = personal_user // private indeed ;)
	return data

/datum/controller/subsystem/personals/ui_static_data(mob/user)
	var/list/data = list()
	var/static/list/sort_buttons = list(
		"Name" = "name",
		"Species" = "species",
		"Online" = "online",
		"LFG" = "adventure_lfg",
		"Healer" = "adventure_is_healer",
	)
	data["EntryTooltips"] = readme // aaurrughh??
	data["EntryLabels"] = entry_labels
	data["EntryKinds"] = entry_kinds
	data["SortButtons"] = sort_buttons
	return data

/datum/controller/subsystem/personals/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/playername = params["Player"] // 1 is always playername, always, always always,eat pant
	if(action == "update_entry")
		update_personal_entry(params[1], params[2], params[3])
	if(action == "update_visibility")
		update_personal_visibility(params[1], params[2], params[3])
	if(action == "SetTab")
		set_tab(
			params[1], // Player doing 
			params[2]
			)

/datum/controller/subsystem/personals/proc/get_tooltips() // Tips the Tooltip Tipper
	return readme // I'm sorry i thought this would be more than it is

/datum/personal_info
	var/ckey = "butt"
	var/name = "John Wasteland"
	var/id = "butt-JW-471983" // save file name, unique identifier for this character independent of their true name
	var/published = FALSE
	var/online = FALSE
	var/species = "Human"
	var/flavor_text = "You see some kind of person of indistinct make and model. They look like they've seen better days."
	var/ooc_text = "Don't touch me, cus I'm probably asleep right now."
	var/profile_pic = "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png"
	/// stuff saved by this thing below here
	var/adventure_notes = "I am an all around badass looking for cats to herd."
	var/adventure_i_am_a = "Wastemaster"
	var/adventure_looking_for = "Cats to herd"
	var/adventure_in_it_for = ADVENTURE_IN_IT_FOR_DEFAULT
	var/adventure_listing_kind = ADVENTURE_LISTING_KIND_DEFAULT
	var/adventure_is_healer = FALSE
	var/adventure_lfg = FALSE
	var/adventure_pvp_pref = PVP_PREF_DEFAULT
	var/rp_i_am_a = "40 something catboy with a drinking problem"
	var/rp_looking_for = "succor from a tall, dark and handsome cyborg with big guns."
	var/rp_likes = RP_PREF_DEFAULT
	var/rp_dislikes = RP_PREF_DEFAULT
	var/rp_notes = "Please buy me a drink!"
	var/rp_length = RP_LENGTH_DEFAULT
	var/rp_listing_kind = RP_LISTING_KIND_DEFAULT
	var/rp_approach_pref = APPROACH_PREF_DEFAULT
	var/erp_sex = PLURAL
	var/erp_gender = PLURAL
	var/erp_sexuality = ERP_SEXUALITY_DEFAULT
	var/erp_position = ERP_POSITION_DEFAULT
	var/erp_i_am_a = "hot single in your area"
	var/erp_looking_for = "hot mother of cats"
	var/erp_faves = "I love holding hands and curling up by various tire fires."
	var/erp_likes = "I like holding hands and curling up by various tire fires."
	var/erp_dislikes = "I dont like holding hands and curling up by various tire fires."
	var/erp_notes = "I like holding hands and curling up by various tire fires."
	var/erp_listing_kind = ERP_LISTING_KIND_DEFAULT
	var/erp_approach_pref = ERP_APPROACH_PREF_DEFAULT
	var/erp_length = ERP_LENGTH_DEFAULT
	var/erp_post_length = ERP_POST_LENGTH_DEFAULT
	var/erp_vore = ERP_VORE_DEFAULT
	var/list/visibility = list(
		PI_MASTER = TRUE,
		PI_CKEY = TRUE,
		PI_NAME = TRUE,
		PI_VISIBILITY = TRUE,
		PI_ONLINE = TRUE,
		PI_SPECIES = TRUE,
		PI_FLAVOR_TEXT = TRUE,
		PI_OOC_TEXT = TRUE,
		PI_ADVENTURE_NOTES = TRUE,
		PI_ADVENTURE_I_AM_A = TRUE,
		PI_ADVENTURE_LOOKING_FOR = TRUE,
		PI_ADVENTURE_IN_IT_FOR = TRUE,
		PI_ADVENTURE_LISTING_KIND = TRUE,
		PI_ADVENTURE_IS_HEALER = TRUE,
		PI_ADVENTURE_LFG = TRUE,
		PI_ADVENTURE_PVP_PREF = TRUE,
		PI_RP_NOTES = TRUE,
		PI_RP_JOB = TRUE,
		PI_RP_I_AM_A = TRUE,
		PI_RP_LOOKING_FOR = TRUE,
		PI_RP_LISTING_KIND = TRUE,
		PI_RP_APPROACH_PREF = TRUE,
		PI_RP_LENGTH = TRUE,
		PI_RP_PREFERENCES = TRUE,
		PI_ERP_NOTES = TRUE,
		PI_ERP_I_AM_A = TRUE,
		PI_ERP_LOOKING_FOR = TRUE,
		PI_ERP_LISTING_KIND = TRUE,
		PI_ERP_APPROACH_PREF = TRUE,
		PI_ERP_LENGTH = TRUE,
		PI_ERP_POST_LENGTH = TRUE,
		PI_ERP_SEXUALITY = TRUE,
		PI_ERP_SEX = TRUE,
		PI_ERP_GENDER = TRUE,
		PI_ERP_POSITION = TRUE,
		PI_ERP_VORE = TRUE,
	)

/datum/personal_info/proc/import_data(mob/living/L)
	if(!istype(L))
		CRASH("Invalid mob passed to import_data!!!!!!!!!!!!!!!!!!!!")
	if(!L.client || !L.client.prefs)
		return // we'll get em next time!
	var/client/C = L.client
	var/datum/preferences/P = C.prefs
	ckey = C.ckey
	name = L.real_name
	species = L.pref_species
	custom_species = L.custom_species
	online = TRUE
	flavor_text = P.features["flavor_text"]
	ooc_text = P.features["ooc_notes"]
	/// these are saved by the system here
	var/list/personal_deets = safe_json_decode(P.personals)
	adventure_notes =        personal_deets[PI_ADVENTURE_NOTES]
	adventure_i_am_a =       personal_deets[PI_ADVENTURE_I_AM_A]
	adventure_looking_for =  personal_deets[PI_ADVENTURE_LOOKING_FOR]
	adventure_in_it_for =    personal_deets[PI_ADVENTURE_IN_IT_FOR]
	adventure_listing_kind = personal_deets[PI_ADVENTURE_LISTING_KIND]
	adventure_is_healer =    personal_deets[PI_ADVENTURE_IS_HEALER]
	adventure_lfg =          personal_deets[PI_ADVENTURE_LFG]
	adventure_pvp_pref =     personal_deets[PI_ADVENTURE_PVP_PREF]
	rp_notes =               personal_deets[PI_RP_NOTES]
	rp_job =                 personal_deets[PI_RP_JOB]
	rp_i_am_a =              personal_deets[PI_RP_I_AM_A]
	rp_looking_for =         personal_deets[PI_RP_LOOKING_FOR]
	rp_listing_kind =        personal_deets[PI_RP_LISTING_KIND]
	rp_approach_pref =       personal_deets[PI_RP_APPROACH_PREF]
	rp_length =              personal_deets[PI_RP_LENGTH]
	rp_preferences =         personal_deets[PI_RP_PREFERENCES]
	erp_notes =              personal_deets[PI_ERP_NOTES]
	erp_i_am_a =             personal_deets[PI_ERP_I_AM_A]
	erp_looking_for =        personal_deets[PI_ERP_LOOKING_FOR]
	erp_listing_kind =       personal_deets[PI_ERP_LISTING_KIND]
	erp_approach_pref =      personal_deets[PI_ERP_APPROACH_PREF]
	erp_length =             personal_deets[PI_ERP_LENGTH]
	erp_post_length =        personal_deets[PI_ERP_POST_LENGTH]
	erp_sexuality =          personal_deets[PI_ERP_SEXUALITY]
	erp_sex =                personal_deets[PI_ERP_SEX]
	erp_gender =             personal_deets[PI_ERP_GENDER]
	erp_position =           personal_deets[PI_ERP_POSITION]
	erp_vore =               personal_deets[PI_ERP_VORE]
	return TRUE

/datum/personal_info/proc/export_data()
	var/client/C = GLOB.directory[ckey]
	if(!C)
		return // we'll get em next time!
	var/datum/preferences/P = C.prefs
	var/list/p_deets = list()
	p_deets[PI_ADVENTURE_NOTES]        = adventure_notes
	p_deets[PI_ADVENTURE_I_AM_A]       = adventure_i_am_a
	p_deets[PI_ADVENTURE_LOOKING_FOR]  = adventure_looking_for
	p_deets[PI_ADVENTURE_IN_IT_FOR]    = adventure_in_it_for
	p_deets[PI_ADVENTURE_LISTING_KIND] = adventure_listing_kind
	p_deets[PI_ADVENTURE_IS_HEALER]    = adventure_is_healer
	p_deets[PI_ADVENTURE_LFG]          = adventure_lfg
	p_deets[PI_ADVENTURE_PVP_PREF]     = adventure_pvp_pref
	p_deets[PI_RP_NOTES]               = rp_notes
	p_deets[PI_RP_JOB]                 = rp_job
	p_deets[PI_RP_I_AM_A]              = rp_i_am_a
	p_deets[PI_RP_LOOKING_FOR]         = rp_looking_for
	p_deets[PI_RP_LISTING_KIND]        = rp_listing_kind
	p_deets[PI_RP_APPROACH_PREF]       = rp_approach_pref
	p_deets[PI_RP_LENGTH]              = rp_length
	p_deets[PI_RP_PREFERENCES]         = rp_preferences
	p_deets[PI_ERP_NOTES]              = erp_notes
	p_deets[PI_ERP_I_AM_A]             = erp_i_am_a
	p_deets[PI_ERP_LOOKING_FOR]        = erp_looking_for
	p_deets[PI_ERP_LISTING_KIND]       = erp_listing_kind
	p_deets[PI_ERP_APPROACH_PREF]      = erp_approach_pref
	p_deets[PI_ERP_LENGTH]             = erp_length
	p_deets[PI_ERP_POST_LENGTH]        = erp_post_length
	p_deets[PI_ERP_SEXUALITY]          = erp_sexuality
	p_deets[PI_ERP_SEX]                = erp_sex
	p_deets[PI_ERP_GENDER]             = erp_gender
	p_deets[PI_ERP_POSITION]           = erp_position
	p_deets[PI_ERP_VORE]               = erp_vore
	P.personals = safe_json_encode(p_deets)
	if(P.save_character())
		to_chat(C, span_greenannounce("Your personals have been saved!"))
	else
		to_chat(C, span_phobia("Your personals were not saved!!!"))
	SSpersonals.refresh_cache()

/datum/personal_info/proc/update_entry(entry, value)
	if(!entry || !value)
		return
	if(!(entry in vars))
		CRASH("Invalid entry passed to update_entry!!!!!!!!!!!!!!!!!!!!")
	vars[entry] = value
	export_data()

/datum/personal_info/proc/get_data()
	var/list/vis = visibility.Copy()
	var/list/out = list(
		"ckey" =                   ckey,
		"name" =                   name,
		"published" =              published,
		"online" =                 online,
		"species" =                species,
		"flavor_text" =            flavor_text,
		"ooc_text" =               ooc_text,
		"profile_pic" =            profile_pic,
		"adventure_notes" =        adventure_notes,
		"adventure_i_am_a" =       adventure_i_am_a,
		"adventure_looking_for" =  adventure_looking_for,
		"adventure_in_it_for" =    adventure_in_it_for,
		"adventure_listing_kind" = adventure_listing_kind,
		"adventure_is_healer" =    adventure_is_healer,
		"adventure_lfg" =          adventure_lfg,
		"adventure_pvp_pref" =     adventure_pvp_pref,
		"rp_i_am_a" =              rp_i_am_a,
		"rp_looking_for" =         rp_looking_for,
		"rp_likes" =               rp_likes,
		"rp_dislikes" =            rp_dislikes,
		"rp_notes" =               rp_notes,
		"rp_length" =              rp_length,
		"rp_listing_kind" =        rp_listing_kind,
		"rp_approach_pref" =       rp_approach_pref,
		"erp_sex" =                erp_sex,
		"erp_gender" =             erp_gender,
		"erp_sexuality" =          erp_sexuality,
		"erp_position" =           erp_position,
		"erp_i_am_a" =             erp_i_am_a,
		"erp_looking_for" =        erp_looking_for,
		"erp_faves" =              erp_faves,
		"erp_likes" =              erp_likes,
		"erp_dislikes" =           erp_dislikes,
		"erp_notes" =              erp_notes,
		"erp_listing_kind" =       erp_listing_kind,
		"erp_approach_pref" =      erp_approach_pref,
		"erp_length" =             erp_length,
		"erp_post_length" =        erp_post_length,
		"erp_vore" =               erp_vore,
	)
	return list(
		"owner" = ckey,
		"visibility" = vis,
		"personal" = out,
	)





/client/verb/open_personals()
	set name = "View Personals"
	set category = "Private"

	SSpersonals.open_window(src)
