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

// Mob definitions!!!
/mob/living/carbon/human
	var/profilePicture

/mob/living/carbon/human/verb/SetProfilePic()
	set name = "Set Profile Picture"
	set category = "OOC"

	if(!client)
		return
	
	var/input = stripped_input(usr,"Right click an image from discord (do not expand the image by clicking it) and click 'Copy Link' and paste it here. Must be a png")
	if(length(input))	
		if(!SanitizeDiscordLink(input))
			to_chat(usr, span_warning("Link is incorrect, make sure you just right click the image in discord and copy link, do NOT click it to expand the image. It must end in '.png'"))
			return

		profilePicture = StoreDiscordLink(input)
		client.prefs.profilePicture = profilePicture
		client.prefs.save_character()
	else
		if(profilePicture)
			var/deletePicture = alert(usr, "Do you wish to remove your profile picture?", "Remove PFP", "Yes", "No")
			if(deletePicture == "Yes")
				RemoveProfilePic()


/mob/living/carbon/human/proc/RemoveProfilePic()
	profilePicture = ""
	if(client)
		client.prefs.profilePicture = ""
		client.prefs.save_character()

// Preference code + saving! The rest of the code is located in preferences.dm where the UI is.
/datum/preferences
	var/profilePicture = ""


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
					var/input = stripped_input(usr,"Right click an image from discord (do not expand the image by clicking it) and click 'Copy Link' and paste it here. Must be a png")
					if(input)	
						if(SanitizeDiscordLink(input))
							profilePicture = StoreDiscordLink(input)
						else
							to_chat(usr, span_warning("Link is incorrect, make sure you just right click the image in discord and copy link, do NOT click it to expand the image. It must end in '.png'"))
					else
						var/deletePicture = alert(usr, "Do you wish to remove your profile picture?", "Remove PFP", "Yes", "No")
						if(deletePicture == "Yes")
							profilePicture = ""

	..()


/datum/preferences/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, initial_spawn = FALSE)
	..()
	character.profilePicture = profilePicture
