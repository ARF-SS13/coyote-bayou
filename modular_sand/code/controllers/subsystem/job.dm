/datum/controller/subsystem/job
	/// Stores an associative list of job name -> its "real" counterpart. Built to handle alt titles
	var/list/real_job_name

/datum/controller/subsystem/job/SetupOccupations(faction)
	. = ..()
	real_job_name = build_jobnames()

/datum/controller/subsystem/job/proc/build_jobnames()
	// No "base" job not in this list will be accepted
	var/list/valid_jobs = list()
	for(var/title in get_all_job_icons())
		valid_jobs[title] = TRUE

	// List of job name -> real "name" this system is fucking stupid
	// I'm taking well thought out solutions that do not include creating
	// icon states with each alt title or generally not having it automated
	var/list/titles = list()
	for(var/datum/job/job in occupations)
		var/real_title = job.title

		if(!valid_jobs[real_title])
			continue

		titles[real_title] = real_title
		for(var/alt_title in job.alt_titles)
			if(alt_title == job.title)
				continue
			titles[alt_title] = real_title

	// Centcom jobs are not in occupations, but we need to handle them anyway
	for(var/title in get_all_centcom_jobs())
		titles[title] = "Centcom" //Return with the NT logo if it is a CentCom job

	return titles
