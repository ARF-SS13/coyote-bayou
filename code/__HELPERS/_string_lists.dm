#define pick_list(FILE, KEY) (pick(strings(FILE, KEY)))
#define pick_list_weighted(FILE, KEY) (pickweight(strings(FILE, KEY)))
#define pick_list_replacements(FILE, KEY) (strings_replacement(FILE, KEY))
#define json_load(FILE) (json_decode(wrap_file2text(FILE)))

GLOBAL_LIST(string_cache)
GLOBAL_VAR(string_filename_current_key)


/proc/strings_replacement(filename, key, no_worries, custom_path)
	load_strings_file(filename, no_worries, custom_path)

	if(filename in GLOB.string_cache)
		var/response = pick(GLOB.string_cache[filename][key])
		var/regex/r = regex("@pick\\((\\D+?)\\)", "g")
		response = r.Replace(response, /proc/strings_subkey_lookup)
		return response
	else if(!no_worries)
		CRASH("strings list not found: strings/[filename], index=[key]")

/proc/strings(filename as text, key as text, no_worries, custom_path)
	load_strings_file(filename, no_worries, custom_path)
	if(filename in GLOB.string_cache)
		return GLOB.string_cache[filename][key]
	else if(!no_worries)
		CRASH("strings list not found: strings/[filename], index=[key]")

/proc/strings_subkey_lookup(match, group1)
	return pick_list(GLOB.string_filename_current_key, group1)

/proc/load_strings_file(filename, no_worries, custom_path)
	GLOB.string_filename_current_key = filename
	if(filename in GLOB.string_cache)
		return //no work to do

	if(!GLOB.string_cache)
		GLOB.string_cache = new

	if(fexists("strings/[filename]"))
		GLOB.string_cache[filename] = json_load("strings/[filename]")
	else if(custom_path && fexists(filename))
		GLOB.string_cache[filename] = json_load(filename)
	else if(!no_worries)
		CRASH("file not found: strings/[filename]")
