/datum/preferences/update_character(current_version, savefile/S)
	. = ..()
	if(current_version < 48.5)	//need to rewrite languages into a list, not being a list or null
		if(isnull(language))	//causes it to block preferences panel to be blocked and constant runtimes
			language = list()
		else
			var/tmp = language
			language = list(tmp)

/datum/preferences/update_preferences(current_version, savefile/S)
	// Citadel added a new bitfield to toggles, we need to push our prefs forward starting from the last bit
	if(current_version < 55)
		if(CHECK_BITFIELD(toggles, VERB_CONSENT))
			DISABLE_BITFIELD(toggles, VERB_CONSENT)
			ENABLE_BITFIELD(toggles, LEWD_VERB_SOUNDS)
		if(CHECK_BITFIELD(toggles, SOUND_BARK))
			DISABLE_BITFIELD(toggles, SOUND_BARK)
			ENABLE_BITFIELD(toggles, VERB_CONSENT)
	. = ..()
