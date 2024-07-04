GLOBAL_LIST_EMPTY(mobs_with_editable_flavor_text) //et tu, hacky code

/datum/element/flavor_text
	element_flags = ELEMENT_BESPOKE|ELEMENT_DETACH
	id_arg_index = 3
	var/flavor_name = "Flavor Text"
	var/list/texts_by_atom = list()
	var/addendum = ""
	var/always_show = FALSE
	var/attach_internet_link = FALSE
	var/max_len = MAX_FLAVOR_LEN
	var/can_edit = TRUE
	/// For preference/DNA saving/loading. Null to prevent. Prefs are only loaded from obviously if it exists in preferences.features.
	var/save_key
	/// Do not attempt to render a preview on examine. If this is on, it will display as \[flavor_name\]
	var/examine_no_preview = FALSE
	var/why_does_it_do_this = 0

/datum/element/flavor_text/Attach(datum/target, text = "", _name = "Flavor Text", _addendum, _max_len = MAX_FLAVOR_LEN, _always_show = FALSE, _edit = TRUE, _save_key, _examine_no_preview = FALSE, _attach_internet_link = FALSE)
	. = ..()

	if(. == ELEMENT_INCOMPATIBLE || !isatom(target)) //no reason why this shouldn't work on atoms too.
		return ELEMENT_INCOMPATIBLE

	if(_max_len)
		max_len = _max_len
	texts_by_atom[target] = copytext(text, 1, max_len)
	if(_name)
		flavor_name = _name
	if(!isnull(addendum))
		addendum = _addendum
	if(_attach_internet_link)
		attach_internet_link = _attach_internet_link
	always_show = _always_show
	can_edit = _edit
	save_key = _save_key
	examine_no_preview = _examine_no_preview

	RegisterSignal(target, COMSIG_PARENT_EXAMINE,PROC_REF(show_flavor))
	RegisterSignal(target, COMSIG_FLIST,PROC_REF(show_flist))

	if(can_edit && ismob(target)) //but only mobs receive the proc/verb for the time being
		var/mob/M = target
		LAZYOR(GLOB.mobs_with_editable_flavor_text[M], src)
		M.verbs |= /mob/proc/manage_flavor_tests

	if(save_key && ishuman(target))
		RegisterSignal(target, COMSIG_HUMAN_PREFS_COPIED_TO,PROC_REF(update_prefs_flavor_text))

/datum/element/flavor_text/Detach(atom/A)
	. = ..()
	UnregisterSignal(A, list(COMSIG_PARENT_EXAMINE, COMSIG_HUMAN_PREFS_COPIED_TO))
	texts_by_atom -= A
	if(can_edit && ismob(A))
		var/mob/M = A
		LAZYREMOVE(GLOB.mobs_with_editable_flavor_text[M], src)
		if(!GLOB.mobs_with_editable_flavor_text[M])
			GLOB.mobs_with_editable_flavor_text -= M
			remove_verb(M, /mob/proc/manage_flavor_tests)

/datum/element/flavor_text/proc/show_flavor(atom/target, mob/user, list/examine_list)
	if(!always_show && isliving(target) && !isobserver(user))
		var/mob/living/L = target
		var/unknown = L.get_visible_name() == "Unknown"
		if(!unknown && iscarbon(target))
			var/mob/living/carbon/C = L
			unknown = !HAS_TRAIT(C, TRAIT_NOHIDEFACE) && ((C.wear_mask && (C.wear_mask.flags_inv & HIDEFACE)) || (C.head && (C.head.flags_inv & HIDEFACE)))
		if(unknown)
			if(!("...?" in examine_list)) //can't think of anything better in case of multiple flavor texts.
				examine_list += "...?"
			return
	var/text = texts_by_atom[target]
	if(!text)
		return
	if(flavor_name == "Background Info Notes" && ishuman(target))  //I really hope nobody sees how I did this, because it's cursed as hell
		var/mob/living/carbon/human/H = target
		if(H.dna.features["background_info_notes"] == BACKGROUND_INFO_NOTE_TEMPLATE)
			return
	if(examine_no_preview)
		examine_list += span_notice("<a href='?src=[REF(src)];show_flavor=[REF(target)]'>\[[flavor_name]\]</a>")
		return
	var/msg = replacetext(text, "\n", " ")
	if(length_char(msg) <= 40)
		examine_list += span_notice("[msg]")
	else
		examine_list += "<span class='notice'>[copytext_char(msg, 1, 37)]... <a href='?src=[REF(src)];show_flavor=[REF(target)]'>More...</span></a>"

/datum/element/flavor_text/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(href_list["show_flavor"])
		var/atom/target = locate(href_list["show_flavor"])

		if(attach_internet_link)
			return show_flist(target, usr)

		var/mob/living/L = target
		var/text = texts_by_atom[target]
		if(text)
			usr << browse("<HTML><HEAD><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><TITLE>[isliving(target) ? L.get_visible_name() : target.name]</TITLE></HEAD><BODY><TT>[replacetext(texts_by_atom[target], "\n", "<BR>")]</TT></BODY></HTML>", "window=[isliving(target) ? L.get_visible_name() : target.name];size=500x200")
			onclose(usr, "[target.name]")
		return TRUE

/datum/element/flavor_text/proc/show_flist(mob/target, mob/reader)
	if(!ishuman(target))
		return
	if(!reader)
		return
	INVOKE_ASYNC(src, PROC_REF(actually_show_flist), target, reader)
	return TRUE

/datum/element/flavor_text/proc/actually_show_flist(mob/living/carbon/human/H, mob/reader)
	if(!H.dna.features["flist"])
		to_chat(reader, span_alert("They don't have an F-List link!"))
		return
	to_chat(reader, span_green("The fancy F-List dialog box is broken :( so just imagine there's a cool window here with a button!"))
	to_chat(reader, span_green("<b>Click here for F-List: <a href='[H.dna.features["flist"]]'>[H.dna.features["flist"]]</a></b>"))

	// var/show_it = alert(
	// 	reader,
	// 	"This will open the following link '[H.dna.features["flist"]]' in your browser. Are you sure?",
	// 	"Open external link",
	// 	"Yes",
	// 	"No"
	// )
	// if(show_it == "Yes")
	// 	if(prob(5))
	// 		to_chat(reader, span_alert("So be it."))
	// 	reader << link(H.dna.features["flist"])
	// 	return TRUE
	// else
	// 	return

/mob/proc/manage_flavor_tests()
	set name = "Manage Flavor Texts"
	set desc = "Used to manage your various flavor texts."
	set category = "IC"

	var/list/L = GLOB.mobs_with_editable_flavor_text[src]

	if(length(L) == 1)
		var/datum/element/flavor_text/F = L[1]
		F.set_flavor(src)
		return

	var/list/choices = list()

	for(var/i in L)
		var/datum/element/flavor_text/F = i
		choices[F.flavor_name] = F

	var/chosen = input(src, "Which flavor text would you like to modify?") as null|anything in choices
	if(!chosen)
		return
	var/datum/element/flavor_text/F = choices[chosen]
	F.set_flavor(src)

/datum/element/flavor_text/proc/set_flavor(mob/user)
	if(!(user in texts_by_atom))
		return FALSE

	var/lower_name = lowertext(flavor_name)
	var/new_text = stripped_multiline_input(user, "Set the [lower_name] displayed on 'examine'. [addendum]", flavor_name, html_decode(texts_by_atom[usr]), max_len, TRUE)
	if(!isnull(new_text) && (user in texts_by_atom))
		texts_by_atom[user] = new_text
		to_chat(src, "Your [lower_name] has been updated.")
		return TRUE
	return FALSE

/datum/element/flavor_text/proc/update_prefs_flavor_text(mob/living/carbon/human/H, datum/preferences/P, icon_updates = TRUE, roundstart_checks = TRUE)
	if(P.features.Find(save_key))
		texts_by_atom[H] = P.features[save_key]

//subtypes with additional hooks for DNA and preferences.
/datum/element/flavor_text/carbon
	//list of antagonists etcetera that should have nothing to do with people's snowflakes.
	var/static/list/i_dont_even_know_who_you_are = typecacheof(list(/datum/antagonist/abductor, /datum/antagonist/ert,
													/datum/antagonist/nukeop, /datum/antagonist/wizard))

/datum/element/flavor_text/carbon/Attach(datum/target, text = "", _name = "Flavor Text", _addendum, _max_len = MAX_FLAVOR_LEN, _always_show = FALSE, _edit = TRUE, _save_key = "flavor_text", _examine_no_preview = FALSE)
	if(!iscarbon(target))
		return ELEMENT_INCOMPATIBLE
	. = ..()
	if(. == ELEMENT_INCOMPATIBLE)
		return
	RegisterSignal(target, COMSIG_CARBON_IDENTITY_TRANSFERRED_TO,PROC_REF(update_dna_flavor_text))
	RegisterSignal(target, COMSIG_MOB_ANTAG_ON_GAIN,PROC_REF(on_antag_gain))
	if(ishuman(target))
		RegisterSignal(target, COMSIG_HUMAN_HARDSET_DNA,PROC_REF(update_dna_flavor_text))
		RegisterSignal(target, COMSIG_HUMAN_ON_RANDOMIZE,PROC_REF(unset_flavor))

/datum/element/flavor_text/carbon/Detach(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, list(COMSIG_CARBON_IDENTITY_TRANSFERRED_TO, COMSIG_MOB_ANTAG_ON_GAIN, COMSIG_HUMAN_PREFS_COPIED_TO, COMSIG_HUMAN_HARDSET_DNA, COMSIG_HUMAN_ON_RANDOMIZE))

/datum/element/flavor_text/carbon/proc/update_dna_flavor_text(mob/living/carbon/C)
	texts_by_atom[C] = C.dna.features[save_key]

/datum/element/flavor_text/carbon/set_flavor(mob/living/carbon/user)
	. = ..()
	if(. && user.dna)
		user.dna.features[save_key] = texts_by_atom[user]

/datum/element/flavor_text/carbon/proc/unset_flavor(mob/living/carbon/user)
	texts_by_atom[user] = ""

/datum/element/flavor_text/carbon/proc/on_antag_gain(mob/living/carbon/user, datum/antagonist/antag)
	if(is_type_in_typecache(antag, i_dont_even_know_who_you_are))
		texts_by_atom[user] = ""
		if(user.dna)
			user.dna.features[save_key] = ""
