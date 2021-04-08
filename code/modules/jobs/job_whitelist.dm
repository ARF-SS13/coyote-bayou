/proc/job_is_whitelist_locked(jobtitle)
	if(!CONFIG_GET(flag/use_role_whitelist) && (jobtitle in (GLOB.faction_whitelist_positions | GLOB.antagonist_whitelist_positions | GLOB.faction_player_positions | GLOB.command_positions | GLOB.ncr_ranger_positions | GLOB.ncr_rangervet_positions | GLOB.ncr_general_positions | GLOB.ncr_upper_command_positions | GLOB.ncr_lower_command_positions | GLOB.bos_paladin_positions | list("AI"))))
		return FALSE
	if(!CONFIG_GET(flag/use_role_whitelist) && !(jobtitle in (GLOB.faction_whitelist_positions | GLOB.antagonist_whitelist_positions | GLOB.faction_player_positions | GLOB.command_positions | GLOB.ncr_ranger_positions | GLOB.ncr_rangervet_positions | GLOB.ncr_general_positions | GLOB.ncr_upper_command_positions | GLOB.ncr_lower_command_positions | GLOB.bos_paladin_positions | list("AI"))))
		return FALSE
	return TRUE

/datum/job/proc/whitelist_locked(client/C, jobname)
	if((C.prefs.job_whitelists[jobname]) || (!CONFIG_GET(flag/use_role_whitelist)))
		return FALSE
	return TRUE


//Get this client's whitelists from the database, if any.
/client/proc/set_job_whitelist_from_db()
	if(!CONFIG_GET(flag/use_role_whitelist))
		return -1
	if(!SSdbcore.Connect())
		return -1
	var/datum/DBQuery/whitelist_read = SSdbcore.NewQuery(
		"SELECT whitelist FROM [format_table_name("role_whitelist")] WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	if(!whitelist_read.Execute())
		qdel(whitelist_read)
		return -1
	var/list/play_records = list()
	var/list/whitelists = list()
	while(whitelist_read.NextRow())
		whitelists[whitelist_read.item[1]] = whitelist_read.item[1]  // should create a whitelists["whitelist name"] for each whitelist held by the user

	for(var/rtype in SSjob.name_occupations)    //cycle through all of the jobs and add them to the full list
		play_records[rtype] = rtype

	qdel(whitelist_read)

	if(!whitelists["faction"])							// if they do not have faction whitelist, remove faction whitelist positions This whitelist is for all roles.
		for(var/rtypeWL in GLOB.faction_whitelist_positions)
			play_records[rtypeWL] = 0

	if(!whitelists["standard"])							// if they do not have standard whitelist, remove standard whitelist positions. This whitelist is for all faction non-leadership roles.
		for(var/rtypeWL in GLOB.faction_player_positions)
			play_records[rtypeWL] = 0

	if(!whitelists["leadership"])					// if they do not have leadership whitelist, remove leadership whitelist positions
		for(var/rtypeWL in GLOB.command_positions)
			play_records[rtypeWL] = 0

	if(!whitelists["ranger"])
		for(var/rtypeWL in GLOB.ncr_ranger_positions)	// if they do not have ranger whitelist, remove ranger whitelist positions
			play_records[rtypeWL] = 0

	if(!whitelists["vetranger"])
		for(var/rtypeWL in GLOB.ncr_rangervet_positions)	// if they do not have ranger whitelist, remove ranger whitelist positions
			play_records[rtypeWL] = 0

	if(!whitelists["ncrgeneral"])
		for(var/rtypeWL in GLOB.ncr_general_positions)		// if they do not have an NCR general whitelist, remove NCR general whitelist positions
			play_records[rtypeWL] = 0
	
	if(!whitelists["ncrlower"])
		for(var/rtypeWL in GLOB.ncr_lower_command_positions)	// if they do not have an NCR lower command whitelist, remove NCR lower command whitelist positions
			play_records[rtypeWL] = 0
	
	if(!whitelists["ncrupper"])
		for(var/rtypeWL in GLOB.ncr_upper_command_positions)	//if they do not have an NCR upper command whitelist, remove NCR upper command whitelist positions
			play_records[rtypeWL] = 0
	
	if(!whitelists["paladin"])
		for(var/rtypeWL in GLOB.bos_paladin_positions)
			play_records[rtypeWL] = 0							//if they do not have a BOS Paladin whitelist, remove BOS Paladin whitelist positions

	/*
	if(!whitelists["leadership_bos"])					// if they do not have leadership_bos whitelist, remove leadership_bos whitelist positions
		for(var/rtypeWL in GLOB.brotherhood_command_positions)
			play_records[rtypeWL] = 0

	if(!whitelists["faction_bos"])					// if they do not have faction_bos whitelist, remove faction_bos whitelist positions
		for(var/rtypeWL in GLOB.brotherhood_positions)
			play_records[rtypeWL] = 0

	if(!whitelists["leadership_oasis"])					// if they do not have leadership_oasis whitelist, remove leadership_oasis whitelist positions
		for(var/rtypeWL in GLOB.den_command_positions)
			play_records[rtypeWL] = 0

	if(!whitelists["faction_oasis"])					// if they do not have faction_oasis whitelist, remove leadership_oasis whitelist positions
		for(var/rtypeWL in GLOB.den_positions)
			play_records[rtypeWL] = 0

	if(!whitelists["leadership_legion"])					// if they do not have leadership_legion whitelist, remove leadership_legion whitelist positions
		for(var/rtypeWL in GLOB.legion_command_positions)
			play_records[rtypeWL] = 0

	if(!whitelists["faction_legion"])					// if they do not have faction_legion whitelist, remove faction_legion whitelist positions
		for(var/rtypeWL in GLOB.legion_positions)
			play_records[rtypeWL] = 0

	if(!whitelists["leadership_vault"])					// if they do not have leadership_vault whitelist, remove leadership_vault whitelist positions
		for(var/rtypeWL in GLOB.vault_command_positions)
			play_records[rtypeWL] = 0

	if(!whitelists["faction_vault"])					// if they do not have faction_vault whitelist, remove faction_vault whitelist positions
		for(var/rtypeWL in GLOB.vault_command_positions)
			play_records[rtypeWL] = 0

	if(!whitelists["faction_vault"])					// if they do not have faction_vault whitelist, remove faction_vault whitelist positions
		for(var/rtypeWL in GLOB.vault_positions)
			play_records[rtypeWL] = 0

	if(!whitelists["faction_vault"])					// if they do not have faction_vault whitelist, remove faction_vault whitelist positions
		for(var/rtypeWL in GLOB.vault_positions)
			play_records[rtypeWL] = 0
	*/

	if(!whitelists["antagonist"])						 // if they do not have antagonist whitelist, remove antagonist whitelist positions
		for(var/rtypeWL in GLOB.antagonist_whitelist_positions)
			play_records[rtypeWL] = 0

	if(whitelists["faction"])
		for(var/rtypeWL in GLOB.faction_whitelist_positions)
			play_records[rtypeWL] = rtypeWL

	if(whitelists["leadership"])
		for(var/rtypeWL in GLOB.command_positions)
			play_records[rtypeWL] = rtypeWL

	if(whitelists["standard"])
		for(var/rtypeWL in GLOB.faction_player_positions)
			play_records[rtypeWL] = rtypeWL

	if(whitelists["ranger"])
		for(var/rtypeWL in GLOB.ncr_ranger_positions)
			play_records[rtypeWL] = rtypeWL

	if(whitelists["vetranger"])
		for(var/rtypeWL in GLOB.ncr_rangervet_positions)
			play_records[rtypeWL] = rtypeWL
	
	if(whitelists["ncrgeneral"])
		for(var/rtypeWL in GLOB.ncr_general_positions)
			play_records[rtypeWL] = rtypeWL
	
	if(whitelists["ncrlower"])
		for(var/rtypeWL in GLOB.ncr_lower_command_positions)
			play_records[rtypeWL] = rtypeWL
	
	if(whitelists["ncrupper"])
		for(var/rtypeWL in GLOB.ncr_upper_command_positions)
			play_records[rtypeWL] = rtypeWL
	
	if(whitelist_read["paladin"])
		for(var/rtypeWL in GLOB.bos_paladin_positions)
			play_records[rtypeWL] = rtypeWL

	prefs.job_whitelists = play_records
