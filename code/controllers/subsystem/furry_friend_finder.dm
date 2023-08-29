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
	for(var/topica in readme)
		var/list/inner_lines = list()
		for(var/line in readme[topica])
			readme[topica][line] = replace(readme[topica][line], "%THINGNAME", thingname)
			inner_lines += readme[topica][line]
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
		personals_cache[guy] = list()
		var/datum/personal_info/PI = get_personal(guy, FALSE, FALSE)
		for(var/entry in PI.vars)
			personals_cache[guy][entry] = PI.vars[entry]
		personals_cache[guy]["owner"] = guy

/datum/controller/subsystem/personals/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "Personals", thingname)
		ui.open()

/datum/controller/subsystem/personals/ui_data(mob/user)
	var/list/data = list()
	data["cache"] = personals_cache // private indeed ;)
	data["user_data"] = get_personal(user)
	return data

/datum/controller/subsystem/personals/ui_static_data(mob/user)
	var/list/data = list()
	data["tooltips"] = readme // aaurrughh??
	return data

/datum/controller/subsystem/personals/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(action == "update_entry")
		update_personal_entry(params[1], params[2], params[3])
	if(action == "update_visibility")
		update_personal_visibility(params[1], params[2], params[3])
	if(action == "readme")
		tgui_alert(usr, message = "Thank you for choosing [thingname], the coziest way to find new folk! \
			<br><br>This is a database of everyone currently active in the Wastes of Texarkana (that's right here!). \
			Below, you'll find a handy, sortable list of people who are looking to meet other lovely folk (like you!). \
			<br<br>You can customize your entry in this database using the controls just below. Anything changed will be saved and \
			posted to the database immediately. \
			<br><br>If you don't want certain parts (or the whole thing) to be listed, you can hide them using the visibility checkboxes. \
			<br><br>While this window itself is technically OOC, you're allowed to interpret any information you find here ICly. \
			You'll typically find a hint on how someone'll want to be approached, or how you might know these sorts of things, \
			such as maybe your character saw another character in the street, or heard about them from a friend, or even just saw \
			their entry in this 'dating app'! 'course, when in doubt, ask in LOOC!",
			title = "Welcome to [thingname]!",
			buttons = list("Neat!"))

/datum/controller/subsystem/personals/proc/get_tooltips() // Tips the Tooltip Tipper
	return readme // I'm sorry i thought this would be more than it is

/datum/personal_info
	var/ckey = "butt"
	var/name = "John Wasteland"
	var/list/visibility = list(
		PI_VIS_MASTER = TRUE,
		PI_VIS_NAME = TRUE,
		PI_VIS_SPECIES = TRUE,
		PI_VIS_FLAVOR_TEXT = TRUE,
		PI_VIS_OOC_TEXT = TRUE,
		PI_VIS_PERSONAL_AD = TRUE,
		PI_VIS_JOB = TRUE,
		PI_VIS_ADVENTURE_ROLE = TRUE,
		PI_VIS_IS_HEALER = TRUE,
		PI_VIS_LFG = TRUE,
		PI_VIS_PVP_PREF = TRUE,
		PI_VIS_RP_I_AM_A = TRUE,
		PI_VIS_RP_LOOKING_FOR = TRUE,
		PI_VIS_RP_LENGTH = TRUE,
		PI_VIS_RP_PREFERENCES = TRUE,
		PI_VIS_RP_NOTES = TRUE,
		PI_VIS_ERP_I_AM_A = TRUE,
		PI_VIS_ERP_LOOKING_FOR = TRUE,
		PI_VIS_ERP_LENGTH = TRUE,
		PI_VIS_ERP_TYPES = TRUE,
		PI_VIS_POSITION = TRUE,
	)
	var/online = FALSE
	var/species = "Human"
	var/flavor_text = "You see some kind of person of indistinct make and model. They look like they've seen better days."
	var/ooc_text = "Don't touch me, cus I'm probably asleep right now."
	/// stuff saved by this thing below here
	var/job = "Waster"
	var/adventure_notes = "I am an all around badass looking for cats to herd."
	var/adventure_i_am_a = "Wastemaster"
	var/adventure_looking_for = "Cats to herd"
	var/adventure_in_it_for = ADVENTURE_IN_IT_FOR_DEFAULT
	var/adventure_listing_kind = ADVENTURE_LISTING_KIND_DEFAULT
	var/adventure_is_healer = FALSE
	var/adventure_lfg = FALSE
	var/adventure_pvp_pref = PVP_PREF_DEFAULT
	var/rp_notes = "Please buy me a drink!"
	var/rp_i_am_a = "40 something catboy with a drinking problem"
	var/rp_looking_for = "succor from a tall, dark and handsome cyborg with big guns."
	var/rp_listing_kind = RP_LISTING_KIND_DEFAULT
	var/rp_approach_pref = APPROACH_PREF_DEFAULT
	var/rp_length = RP_LENGTH_DEFAULT
	var/rp_preferences = RP_PREF_DEFAULT
	var/erp_notes = "I like holding hands and curling up by various tire fires."
	var/erp_i_am_a = "hot single in your area"
	var/erp_looking_for = "hot mother of cats"
	var/erp_listing_kind = ERP_LISTING_KIND_DEFAULT
	var/erp_approach_pref = ERP_APPROACH_PREF_DEFAULT
	var/erp_length = ERP_LENGTH_DEFAULT
	var/erp_post_length = ERP_POST_LENGTH_DEFAULT
	var/erp_sexuality = ERP_SEXUALITY_DEFAULT
	var/erp_sex = PLURAL
	var/erp_gender = PLURAL
	var/erp_position = ERP_POSITION_DEFAULT
	var/erp_vore = ERP_VORE_DEFAULT

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
	job =                    personal_deets[PI_JOB]
	adventure_notes =        personal_deets[PI_ADVENTURE_NOTES]
	adventure_i_am_a =       personal_deets[PI_ADVENTURE_I_AM_A]
	adventure_looking_for =  personal_deets[PI_ADVENTURE_LOOKING_FOR]
	adventure_in_it_for =    personal_deets[PI_ADVENTURE_IN_IT_FOR]
	adventure_listing_kind = personal_deets[PI_ADVENTURE_LISTING_KIND]
	adventure_is_healer =    personal_deets[PI_ADVENTURE_IS_HEALER]
	adventure_lfg =          personal_deets[PI_ADVENTURE_LFG]
	adventure_pvp_pref =     personal_deets[PI_ADVENTURE_PVP_PREF]
	rp_notes =               personal_deets[PI_RP_NOTES]
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
	p_deets[PI_JOB]                    = job
	p_deets[PI_ADVENTURE_NOTES]        = adventure_notes
	p_deets[PI_ADVENTURE_I_AM_A]       = adventure_i_am_a
	p_deets[PI_ADVENTURE_LOOKING_FOR]  = adventure_looking_for
	p_deets[PI_ADVENTURE_IN_IT_FOR]    = adventure_in_it_for
	p_deets[PI_ADVENTURE_LISTING_KIND] = adventure_listing_kind
	p_deets[PI_ADVENTURE_IS_HEALER]    = adventure_is_healer
	p_deets[PI_ADVENTURE_LFG]          = adventure_lfg
	p_deets[PI_ADVENTURE_PVP_PREF]     = adventure_pvp_pref
	p_deets[PI_RP_NOTES]               = rp_notes
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

/client/verb/open_personals()
	set name = "View Personals"
	set category = "Private"

	SSpersonals.open_window(src)
