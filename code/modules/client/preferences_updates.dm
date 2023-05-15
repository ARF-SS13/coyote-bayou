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

/datum/preferences/proc/update_save(savefile/S)
	current_version = safe_json_decode(S["current_version"])
	var/list/needs_updating = list()
	needs_updating ^= PREFERENCES_MASTER_CHANGELOG
	if(LAZYLEN(needs_updating))
		update_file(needs_updating, S)

//should these procs get fairly long
//just increase SAVEFILE_VERSION_MIN so it's not as far behind
//SAVEFILE_VERSION_MAX and then delete any obsolete if clauses
//from these procs.
//This only really meant to avoid annoying frequent players
//if your savefile is 3 months out of date, then 'tough shit'.


/datum/preferences/proc/update_preferences(current_version, savefile/S)
	if(current_version < 37)	//If you remove this, remove force_reset_keybindings() too.
		force_reset_keybindings_direct(TRUE)
		addtimer(CALLBACK(src, .proc/force_reset_keybindings), 30)	//No mob available when this is run, timer allows user choice.


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
								mutant_string = MBP_MARKINGS_BODY
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
							features[primary_string] = features[MBP_COLOR1]
							features[secondary_string] = features[MBP_COLOR2]
							features[tertiary_string] = features[MBP_COLOR3]
						else if(accessory.color_src == MUTCOLOR1 && !primary_exists)
							features[primary_string] = features[MBP_COLOR1]
						else if(accessory.color_src == MUTCOLOR2 && !secondary_exists)
							features[secondary_string] = features[MBP_COLOR2]
						else if(accessory.color_src == MUTCOLOR3 && !tertiary_exists)
							features[tertiary_string] = features[MBP_COLOR3]

		features["color_scheme"] = OLD_CHARACTER_COLORING //advanced is off by default

	if(current_version < 37) //introduction of chooseable eye types/sprites
		if(S["species"] == SPECIES_INSECT)
			left_eye_color = "#000000"
			right_eye_color = "#000000"
			if(chosen_limb_id == BODYTYPE_MOTH || chosen_limb_id == BODYTYPE_MOTH_NOT_GREYSCALE) //these actually have slightly different eyes!
				eye_type = BODYTYPE_MOTH
			else
				eye_type = BODYTYPE_INSECT

	if(current_version < 38) //further eye sprite changes
		if(S["species"] == SPECIES_PLASMAMAN)
			left_eye_color = "#FFC90E"
			right_eye_color = "#FFC90E"
		else
			if(S["species"] == SPECIES_SKELETON)
				left_eye_color = "#BAB99E"
				right_eye_color = "#BAB99E"

	if(current_version < 51) //humans can have digi legs now, make sure they dont default to them or human players will murder me in my sleep
		if(S["species"] == SPECIES_HUMAN)
			features[MBP_LEGS] = LEGS_PLANTIGRADE

	if(current_version < 52) // rp markings means markings are now stored as a list, lizard markings now mam like the rest
		var/marking_type
		var/species_id = S["species"]
		var/datum/species/actual_species = GLOB.species_list[species_id]

		// convert lizard markings to lizard markings
		if(species_id == SPECIES_LIZARD && S["feature_lizard_body_markings"])
			features[MBP_MARKINGS_BODY] = features["body_markings"]

		// convert mam body marking data to the new rp marking data
		if(actual_species.mutant_bodyparts[MBP_MARKINGS_BODY] && S["feature_mam_body_markings"]) marking_type = "feature_mam_body_markings"

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
			features[MBP_MARKINGS_BODY] = marking_list

/datum/preferences/proc/update_file(list/missing_updates, savefile/S)
	if(!LAZYLEN(missing_updates))
		return
	for(var/clog in missing_updates)
		switch(clog)
			if(PMC_OOC_NOTES_UPDATE) // ooc notes now come with a cool template
				var/ooc_notes
				S["feature_ooc_notes"] >> ooc_notes
				ooc_notes += OOC_NOTE_TEMPLATE
				WRITE_FILE(S["feature_ooc_notes"], ooc_notes)
				current_version |= PMC_OOC_NOTES_UPDATE
			if(PMC_CONDENSE_PARTS)
				if(condense_parts(S))
					current_version |= PMC_CONDENSE_PARTS
	WRITE_FILE(S["current_version"], safe_json_encode(current_version))

/// Goes through all the Human/Lizard/mammal/whatever tails and condenses them down into a single tail
/datum/preferences/proc/condense_parts(savefile/S)
	to_chat(usr, span_userdanger("Condensing parts, this may take a while..."))
	var/lizard
	var/mammal
	var/human
	var/out
	S["feature_lizard_tail"] >> lizard
	S["feature_mam_tail"] >> mammal
	S["feature_human_tail"] >> human
	out = human || lizard || mammal
	WRITE_FILE(S[MBP_TAIL], out)

	S["feature_mam_tail_animated"] >> mammal
	WRITE_FILE(S[MBP_TAIL_ANIMATED], mammal)

	S["feature_human_ears"] >> human
	S["feature_lizard_ears"] >> lizard
	S["feature_mam_ears"] >> mammal
	out = human || lizard || mammal
	WRITE_FILE(S[MBP_EARS], out)

	S["feature_mam_snouts"] >> mammal
	S["feature_lizard_snout"] >> lizard
	out = lizard || mammal
	WRITE_FILE(S[MBP_SNOUT], out)

	S["feature_lizard_legs"] >> lizard
	WRITE_FILE(S[MBP_LEGS], lizard)

	S["feature_lizard_horns"] >> lizard
	WRITE_FILE(S[MBP_HORNS], lizard)

	to_chat(usr, span_greentext("Done!"))
	return TRUE





