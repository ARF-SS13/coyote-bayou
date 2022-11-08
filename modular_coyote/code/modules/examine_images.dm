// Config Entries! Check discordURL
/datum/config_entry/string/discordImage_p // Prefix, text going before the URL
	config_entry_value = "https://cdn.discordapp.com/attachments/"
/datum/config_entry/string/discordImage_s // Suffix, text going after the URL.
	config_entry_value = ".png"

/proc/DiscordLink(imageText)
	var/prefix = CONFIG_GET(string/discordImage_p)
	var/suffix = CONFIG_GET(string/discordImage_s)

	var/result = prefix + imageText + suffix
	return result

/proc/SanitizeDiscordLink(url)
	var/startURL = CONFIG_GET(string/discordImage_p)
	var/endURL = CONFIG_GET(string/discordImage_s)

	var/result = 1

	if(!findtext(url, startURL, 1, length(startURL)))
		result = 0

	var/offset = length(url) - length(endURL)
	if(!findtext(url, endURL, offset))
		result = 0
	
	return result



/proc/StoreDiscordLink(url)
	var/prefix = CONFIG_GET(string/discordImage_p)
	var/suffix = CONFIG_GET(string/discordImage_s)

	var/output = copytext(url, (length(prefix) + 1)) // Removes the beggining of the text.
	to_chat(world, output)
	output = copytext(url, (length(suffix) * -1) - 1) // Removes the end of the text.
	to_chat(world, output)
	return output


/mob/living/carbon/human
	var/profilePicture

/mob/living/carbon/human/verb/SetProfilePic()
	set name = "Set Profile Picture"
	set category = "OOC"

	if(!client)
		return
	
	var/input = stripped_input(usr,"Right click an image from discord (do not expand the image by clicking it) and click copy URL and paste it here.")
	if(length(input))	
		if(!SanitizeDiscordLink(input))
			to_chat(usr, span_warning("Link is incorrect, make sure you just right click the image in discord and copy url, do NOT click it to expand the image. It must end in '.png'"))
			return

		profilePicture = StoreDiscordLink(input)
