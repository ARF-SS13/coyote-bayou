#define MULTIKEYFILE "[global.config.directory]/multikey_allowlist.txt"

GLOBAL_LIST(multikey_allowlist)
GLOBAL_PROTECT(multikey_allowlist)

/proc/load_multikey_allowlist()
	GLOB.multikey_allowlist = list()
	for(var/line in world.file2list(MULTIKEYFILE))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		GLOB.multikey_allowlist += ckey(line)

	if(!GLOB.multikey_allowlist.len)
		GLOB.multikey_allowlist = null

/proc/check_multikey_allowlist(ckey)
	if(!GLOB.multikey_allowlist)
		return FALSE
	. = (ckey in GLOB.multikey_allowlist)

#undef MULTIKEYFILE
