GLOBAL_LIST_INIT(pfp_filehosts, list(
									"catbox.moe",
									"gyazo.com",
))
GLOBAL_LIST_INIT(pfp_filehost_prefix, list(
									"catbox.moe" 	= "https://files.catbox.moe/",
									"gyazo.com" 	= "https://i.gyazo.com/",
))
GLOBAL_LIST_INIT(pfp_filehost_safe_suffixes, list(
									".png",
									".jpg"
))
#define SUFFIX_LENGTH 4
#define LEGACY_PREFIX ".png"

// To future devs, don't bother trying to add Discord or Imgur to these lists as they don't allow external embeds


// Config Entries! Check discordURL
/datum/config_entry/string/discordImage_p // Prefix, text going before the URL
	config_entry_value = "https://cdn.discordapp.com/attachments/"
/datum/config_entry/string/discordImage_s // Suffix, text going after the URL.
	config_entry_value = ".png"

// Helper procs to help make sure the discord link is correct and to conver it with/without the url section.
/proc/SanitizeDiscordLink(url)
	var/startURL = CONFIG_GET(string/discordImage_p)
	var/endURL = CONFIG_GET(string/discordImage_s)

	var/result = 1

	if(!findtext(url, startURL, 1, length(startURL) + 1))
		result = 0

	var/offset = (length(url) + 1) - (length(endURL) + 2)
	if(!findtext(url, endURL, offset))
		result = 0
	
	return result

// Applies the prefix and suffix to the link, makes things a liiiiitttle safer in terms of security as we're forcing a specific website to be used.
/proc/DiscordLink(imageText)
	var/prefix = CONFIG_GET(string/discordImage_p)
	var/suffix = CONFIG_GET(string/discordImage_s)

	var/result = prefix + imageText + suffix
	return result

// Removes the prefix and suffix from the url, pretty much to make sure things are safe if things go bad, idk.
/proc/StoreDiscordLink(url)
	var/prefix = CONFIG_GET(string/discordImage_p)
	var/suffix = CONFIG_GET(string/discordImage_s)

	var/output = copytext(url, (length(prefix) + 1)) // Removes the beggining of the url.

	var/offset = length(output) - length(suffix)
	output = copytext(output, 1, offset + 1) // Removes the .png on the end.

	return output

//Dynamic PFP Procs//

/// Helper procs to help make sure the link is correct and to convert it with/without the url section.
/proc/SanitizePfpLink(url,host)
	if(!(host in GLOB.pfp_filehosts))//you dun guffed up bucko
		return 0
	var/startURL = GLOB.pfp_filehost_prefix[host]

	var/result = 1

	if(!findtext(url, startURL, 1, length(startURL) + 1))
		result = 0

	if(!(copytext(url, -SUFFIX_LENGTH) in GLOB.pfp_filehost_safe_suffixes))
		result = 0
	
	return result

/// Applies the prefix and suffix to the link, makes things a liiiiitttle safer in terms of security as we're forcing a specific list of websites to be used.
/proc/PfpHostLink(imageText, host)
	if(!(host in GLOB.pfp_filehosts))
		return ""
	var/prefix = GLOB.pfp_filehost_prefix[host]

	var/result = prefix + imageText
	if (!(copytext(result, -SUFFIX_LENGTH) in GLOB.pfp_filehost_safe_suffixes))
		result += LEGACY_PREFIX // Because Fenny is asking me to break legacy shit
	return result

/// Removes the prefix and suffix from the url, pretty much to make sure things are safe if things go bad, idk.
/proc/StorePfpLink(url, host)
	if(!(host in GLOB.pfp_filehosts))
		return ""
	var/prefix = GLOB.pfp_filehost_prefix[host]

	var/output = copytext(url, (length(prefix) + 1)) // Removes the beggining of the url.

	return output

// End Dynamic PFP Procs//


// Mob definitions!!!
/mob
	var/profilePicture
	var/pfphost

/mob/living/carbon/human/verb/SetProfilePic()
	set name = "Set Profile Picture"
	set category = "OOC"

	if(!client)
		return

	var/maybedeleteme = FALSE
	var/host_select = input(usr, "Select your image hosting site:", "PFP Image Host", pfphost != "" ? pfphost : GLOB.pfp_filehosts[1]) as null|anything in GLOB.pfp_filehosts
	if(!isnull(host_select) && (host_select in GLOB.pfp_filehosts))//You didn't press cancel
		pfphost = host_select
	else//you pressed Cancel
		maybedeleteme = TRUE
	if(pfphost && pfphost != "")
		var/input = stripped_input(usr,"Right click a .png image in your browser and select 'Copy Image Address'. It should look like this: 'https://\[file host website\]/\[unique image ID\].png'", i_will_sanitize_dont_worry = TRUE)
		if(input && pfphost != "" && !isnull(pfphost))
			if(SanitizePfpLink(input, pfphost))
				profilePicture = StorePfpLink(input, host_select)
				client.prefs.profilePicture = profilePicture
				client.prefs.pfphost = host_select
				client.prefs.save_character()
			else
				to_chat(usr, span_warning("Link is incorrect. Right click a .png image in your browser and select 'Copy Image Address'. It should look like this: 'https://\[file host website\]/\[unique image ID\].png'"))
		else
			maybedeleteme = TRUE
	if(maybedeleteme)
		var/deletePicture = alert(usr, "Do you wish to remove your profile picture?", "Remove PFP", "Yes", "No")
		if(deletePicture == "Yes")
			RemoveProfilePic()

/mob/living/carbon/human/proc/RemoveProfilePic()
	profilePicture = ""
	pfphost = ""
	if(client)
		client.prefs.profilePicture = ""
		client.prefs.pfphost = ""
		client.prefs.save_character()

// Preference code + saving! The rest of the code is located in preferences.dm where the UI is.
/datum/preferences // gdi jon, we dont have to modularize (also screw your pascal case)
	var/profilePicture = ""
	var/pfphost = ""


// Moved this to preferences_savefile.dm as we're having issues with overriding the function I think.
// My speculation is that us trying to open the save file multiple times with multiple users is causing a memory overflow on the server end and refusing to open it
// Though surely it would alteast warn us?? IDK. There's no way to debug this live. That's atleast what I think is happening, as it's strange that it works locally, but not server side.

/*
/datum/preferences/load_character(slot)
	. = ..()
	if(!(. == 1))
		return . // There's an error!!

	var/savefile/S = new /savefile(path)
	S.cd = "/character[slot]"

	S["profilePicture"] >> profilePicture

	//profilePicture = sanitize_text(profilePicture) // Its treating it like the text is invalid and is outputting null, best just to remove it for now as it's already sanitised enough...ish. Don't you dare fucking break.

	return 1


/datum/preferences/save_character()
	. = ..()

	if(!(. == TRUE))
		return . // erroooooooooooorrrrrrrrrrr

	var/savefile/S = new /savefile(path)
	if(!S)
		return 0

	S.cd = "/character[default_slot]"

	//Character
	WRITE_FILE(S["profilePicture"], profilePicture)

	return 1
*/


/datum/preferences/process_link(mob/user, list/href_list)
	switch(href_list["task"])
		if("input")
			switch(href_list["preference"])
				if("ProfilePicture")
					var/maybedeleteme = FALSE
					var/host_select = input(usr, "Select your image hosting site:", "PFP Image Host", pfphost != "" ? pfphost : GLOB.pfp_filehosts[1]) as null|anything in GLOB.pfp_filehosts
					if(!isnull(host_select) && (host_select in GLOB.pfp_filehosts))//You didn't press cancel
						pfphost = host_select
					else//you pressed Cancel
						maybedeleteme = TRUE
					if(pfphost && pfphost != "")
						var/input = stripped_input(usr,"Right click a .png or .jpg image in your browser and select 'Copy Image Address'. It should look like this: 'https://\[file host website\]/\[unique image ID\].png'", i_will_sanitize_dont_worry = TRUE)
						if(input && pfphost != "" && !isnull(pfphost))
							if(SanitizePfpLink(input, pfphost))
								profilePicture = StorePfpLink(input, pfphost)
							else
								to_chat(usr, span_warning("Link is incorrect. Right click a .png or .jpg image in your browser and select 'Copy Image Address'. It should look like this: 'https://\[file host website\]/\[unique image ID\].png'"))
						else
							maybedeleteme = TRUE
					if(maybedeleteme)
						var/deletePicture = alert(usr, "Do you wish to remove your profile picture?", "Remove PFP", "Yes", "No")
						if(deletePicture == "Yes")
							profilePicture = ""
							pfphost = ""
				if("CreatureProfilePicture")
					var/maybedeleteme = FALSE
					var/host_select = input(usr, "Select your image hosting site:", "PFP Image Host", creature_pfphost != "" ? creature_pfphost : GLOB.pfp_filehosts[1]) as null|anything in GLOB.pfp_filehosts
					if(!isnull(host_select) && (host_select in GLOB.pfp_filehosts))//You didn't press cancel
						creature_pfphost = host_select
					else//you pressed Cancel
						creature_pfphost = ""
						maybedeleteme = TRUE
					if(creature_pfphost && creature_pfphost != "")
						var/input = stripped_input(usr,"Right click a .png or .jpg image in your browser and select 'Copy Image Address'. It should look like this: 'https://\[file host website\]/\[unique image ID\].png'", i_will_sanitize_dont_worry = TRUE)
						if(input && creature_pfphost != "" && !isnull(creature_pfphost))
							if(SanitizePfpLink(input, creature_pfphost))
								creature_profilepic = StorePfpLink(input, creature_pfphost)
							else
								to_chat(usr, span_warning("Link is incorrect. Right click a .png or .jpg image in your browser and select 'Copy Image Address'. It should look like this: 'https://\[file host website\]/\[unique image ID\].png'"))
						else
							maybedeleteme = TRUE
					if(maybedeleteme)
						var/deletePicture = alert(usr, "Do you wish to remove your profile picture?", "Remove PFP", "Yes", "No")
						if(deletePicture == "Yes")
							creature_profilepic = ""
							creature_pfphost = ""

	..()

/datum/preferences/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, initial_spawn = FALSE)
	..()
	character.profilePicture = profilePicture
	character.pfphost = pfphost
