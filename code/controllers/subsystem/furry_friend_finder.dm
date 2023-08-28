SUBSYSTEM_DEF(personals)
	name = "Personals" //""""Personals""""
	wait = 10 SECONDS
	init_order = INIT_ORDER_STATPANELS
	priority = FIRE_PRIORITY_PERSONALS
	runlevels = RUNLEVELS_DEFAULT | RUNLEVEL_LOBBY
	var/thingname = "Personals"
	var/list/personals = list()
	var/list/personals_cache = list()

/datum/controller/subsystem/personals/proc/Initialize(start_timeofday)
	thingname = pick(
		"Mango's List",
		"Wastr",
		"Plenty of Geckos",
		"Only Wasters",
		"Bluespace",
	)
	. = ..()

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
	. = ..()
	var/list/data = list()
	data["cache"] = personals_cache // private indeed ;)
	data["user_data"] = get_personal(user)
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
	var/personal_ad = "I am a cat herder looking for a tall, dark and handsome cyborg with big guns."
	var/job = "Waster"
	var/adventure_role = "Wastemaster"
	var/is_healer = FALSE
	var/lfg = FALSE
	var/pvp_pref = PVP_PREF_DEFAULT
	var/listing_kind = LISTING_KIND_DEFAULT
	var/approach_pref = APPROACH_PREF_DEFAULT
	var/rp_i_am_a = "40 something catboy with a drinking problem"
	var/rp_looking_for = "succor from a tall, dark and handsome cyborg with big guns."
	var/rp_length = RP_LENGTH_DEFAULT
	var/rp_preferences = RP_PREF_DEFAULT
	var/rp_notes = ""
	var/erp_i_am_a = "hot single in your area"
	var/erp_looking_for = "hot mother of cats"
	var/erp_length = ERP_LENGTH_DEFAULT
	var/erp_types = ERP_TYPE_DEFAULT
	var/position = ERP_POSITION_DEFAULT

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
	job =             personal_deets[PI_JOB]
	listing_kind =    personal_deets[PI_LISTING_KIND]
	personal_ad =     personal_deets[PI_PERSONAL_AD]
	approach_pref =   personal_deets[PI_APPROACH_PREF]
	adventure_role =  personal_deets[PI_ADVENTURE_ROLE]
	is_healer =       personal_deets[PI_IS_HEALER]
	lfg =             personal_deets[PI_LFG]
	pvp_pref =        personal_deets[PI_PVP_PREF]
	rp_i_am_a =       personal_deets[PI_RP_I_AM_A]
	rp_looking_for =  personal_deets[PI_RP_LOOKING_FOR]
	rp_length =       personal_deets[PI_RP_LENGTH]
	rp_preferences =  personal_deets[PI_RP_PREFERENCES]
	rp_notes =        personal_deets[PI_RP_NOTES]
	erp_i_am_a =      personal_deets[PI_ERP_I_AM_A]
	erp_looking_for = personal_deets[PI_ERP_LOOKING_FOR]
	erp_length =      personal_deets[PI_ERP_LENGTH]
	erp_types =       personal_deets[PI_ERP_TYPES]
	position =        personal_deets[PI_POSITION]
	return TRUE

/datum/personal_info/proc/export_data()
	var/client/C = GLOB.directory[ckey]
	if(!C)
		return // we'll get em next time!
	var/datum/preferences/P = C.prefs
	var/list/p_deets = list()
	p_deets[PI_JOB]             = job
	p_deets[PI_LISTING_KIND]    = listing_kind
	p_deets[PI_PERSONAL_AD]     = personal_ad
	p_deets[PI_APPROACH_PREF]   = approach_pref
	p_deets[PI_ADVENTURE_ROLE]  = adventure_role
	p_deets[PI_IS_HEALER]       = is_healer
	p_deets[PI_LFG]             = lfg
	p_deets[PI_PVP_PREF]        = pvp_pref
	p_deets[PI_RP_I_AM_A]       = rp_i_am_a
	p_deets[PI_RP_LOOKING_FOR]  = rp_looking_for
	p_deets[PI_RP_LENGTH]       = rp_length
	p_deets[PI_RP_PREFERENCES]  = rp_preferences
	p_deets[PI_RP_NOTES]        = rp_notes
	p_deets[PI_ERP_I_AM_A]      = erp_i_am_a
	p_deets[PI_ERP_LOOKING_FOR] = erp_looking_for
	p_deets[PI_ERP_LENGTH]      = erp_length
	p_deets[PI_ERP_TYPES]       = erp_types
	p_deets[PI_POSITION]        = position
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
