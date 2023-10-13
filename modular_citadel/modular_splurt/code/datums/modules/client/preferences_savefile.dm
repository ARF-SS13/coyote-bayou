/datum/preferences/proc/splurt_character_pref_load(savefile/S) //TODO: modularize our other savefile edits... maybe?
	//Character directory
	S["show_in_directory"]		>> show_in_directory
	S["directory_tag"]			>> directory_tag
	S["directory_erptag"]			>> directory_erptag
	S["directory_ad"]			>> directory_ad

	//sanitize data
	show_in_directory		= sanitize_integer(show_in_directory, 0, 1, initial(show_in_directory))
	directory_tag			= sanitize_inlist(directory_tag, GLOB.char_directory_tags, initial(directory_tag))
	directory_erptag		= sanitize_inlist(directory_erptag, GLOB.char_directory_erptags, initial(directory_erptag))
	directory_ad			= strip_html_simple(directory_ad, MAX_FLAVOR_LEN)

/datum/preferences/proc/splurt_character_pref_save(savefile/S) //TODO: modularize our other savefile edits... maybe?
	//Character directory
	WRITE_FILE(S["show_in_directory"], show_in_directory)
	WRITE_FILE(S["directory_tag"], directory_tag)
	WRITE_FILE(S["directory_erptag"], directory_erptag)
	WRITE_FILE(S["directory_ad"], directory_ad)
