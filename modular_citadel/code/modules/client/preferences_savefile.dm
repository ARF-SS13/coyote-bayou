/datum/preferences/proc/cit_character_pref_load(savefile/S)
	//ipcs
	S["feature_ipc_screen"] >> features[MBP_SCREEN]
	S["feature_ipc_antenna"] >> features[MBP_ANTENNA_IPC]

	features[MBP_SCREEN] 	= sanitize_inlist(features[MBP_SCREEN], GLOB.ipc_screens_list)
	features[MBP_ANTENNA_IPC] 	= sanitize_inlist(features[MBP_ANTENNA_IPC], GLOB.ipc_antennas_list)
	//Citadel
	features["flavor_text"]		= sanitize_text(features["flavor_text"], initial(features["flavor_text"]))
	if(!features[MBP_COLOR2] || features[MBP_COLOR1] == "#000000")
		features[MBP_COLOR2] = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F")
	if(!features[MBP_COLOR3] || features[MBP_COLOR1] == "#000000")
		features[MBP_COLOR3] = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F")
	features[MBP_COLOR2]	= sanitize_hexcolor(features[MBP_COLOR2], 6, FALSE)
	features[MBP_COLOR3]	= sanitize_hexcolor(features[MBP_COLOR3], 6, FALSE)


/datum/preferences/proc/cit_character_pref_save(savefile/S)
	//ipcs
	WRITE_FILE(S["feature_ipc_screen"], features[MBP_SCREEN])
	WRITE_FILE(S["feature_ipc_antenna"], features[MBP_ANTENNA_IPC])
	//Citadel
	WRITE_FILE(S["feature_mcolor2"], features[MBP_COLOR2])
	WRITE_FILE(S["feature_mcolor3"], features[MBP_COLOR3])
	WRITE_FILE(S["feature_mam_body_markings"], safe_json_encode(features[MBP_MARKINGS_BODY]))
	WRITE_FILE(S["feature_mam_tail"], features[MBP_TAIL])
	WRITE_FILE(S["feature_mam_ears"], features[MBP_EARS])
	WRITE_FILE(S["feature_mam_tail_animated"], features["mam_tail_animated"])
	WRITE_FILE(S["feature_taur"], features[MBP_TAUR])
	WRITE_FILE(S["feature_mam_snouts"],	features[MBP_SNOUT])
	//Xeno features
	WRITE_FILE(S["feature_xeno_tail"], features[MBP_XENO_TAIL])
	WRITE_FILE(S["feature_xeno_dors"], features[MBP_XENO_DORSAL])
	WRITE_FILE(S["feature_xeno_head"], features[MBP_XENO_HEAD])
	//flavor text
	WRITE_FILE(S["feature_flavor_text"], features["flavor_text"])
	WRITE_FILE(S["silicon_feature_flavor_text"], features["silicon_flavor_text"])

