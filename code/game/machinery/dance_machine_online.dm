/obj/machinery/jukebox_online
	name = "Online Jukebox"
	desc = "A music player. This one has a massive selection."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "jukebox"
	verb_say = "intones"
	density = TRUE
	var/pendingsongurl = ""

/obj/machinery/jukebox_online/on_attack_hand(mob/living/user, act_intent, unarmed_attack_flags)
	var/songinput = input(user, "Enter URL (supported sites only, leave blank to stop playing)", "Online Jukebox") as text|null
	if(isnull(songinput) || !length(songinput))
		stop_online_song()
		return
	pendingsongurl = songinput
	var/adminmessage = "<span class=\"admin\">[user.name] wants to play <a href=\"[pendingsongurl]\">[pendingsongurl]</a><br/>You can <a href='byond://?src=\ref[src];action=allow;url=[pendingsongurl]'>Allow</a> or <a href='byond://?src=\ref[src];action=deny;url=[pendingsongurl]'>Deny</a>.</span>"
	for(var/admin in GLOB.admins.Copy())
		to_chat(admin, adminmessage, confidential = TRUE)

/obj/machinery/jukebox_online/Topic(href, href_list[])
	if(pendingsongurl == href_list["url"])
		if(href_list["action"] == "allow")
			var/toplay = pendingsongurl
			parse_url(toplay)
			message_admins("[usr] approved [href_list["url"]]")
			pendingsongurl = ""
			return
		if(href_list["action"] == "deny")
			pendingsongurl = ""
			message_admins("[usr] denied [href_list["url"]]")
			return
	else
		to_chat(usr, "Someone else must have responded already.")


/obj/machinery/jukebox_online/proc/parse_url(url)
	. = FALSE
	var/ytdl = CONFIG_GET(string/invoke_youtubedl)
	if(!ytdl)
		to_chat(src, span_boldwarning("yt-dlp was not configured, action unavailable")) //Check config.txt for the INVOKE_YOUTUBEDL value
		return
	if(length(url))
		url = trim(url)
		if(findtext(url, ":") && !findtext(url, GLOB.is_http_protocol))
			to_chat(src, span_boldwarning("Non-http(s) URIs are not allowed."))
			to_chat(src, span_warning("For yt-dlp shortcuts like ytsearch: please use the appropriate full url from the website."))
			return
		var/shell_scrubbed_input = shell_url_scrub(url)
		var/list/output = world.shelleo("[ytdl] --format \"bestaudio\[ext=mp3]/best\[ext=mp4]\[height<=360]/bestaudio\[ext=m4a]/bestaudio\[ext=aac]\" --dump-single-json --no-playlist -- \"[shell_scrubbed_input]\"")
		var/errorlevel = output[SHELLEO_ERRORLEVEL]
		var/stdout = output[SHELLEO_STDOUT]
		//var/stderr = output[SHELLEO_STDERR]
		if(!errorlevel)
			var/list/data
			try
				data = json_decode(stdout)
			catch(var/exception/e)
				to_chat(src, span_boldwarning("yt-dlp JSON parsing FAILED:"))
				to_chat(src, span_warning("[e]: [stdout]"))
				return

			if (data["url"])
				var/storeddata = list()
				storeddata["start"] = data["start_time"]
				storeddata["end"] = data["end_time"]
				storeddata["link"] = data["webpage_url"]
				storeddata["title"] = data["title"]
				play_online_song(data["url"], storeddata)
				. = TRUE

/obj/machinery/jukebox_online/proc/play_online_song(url, extradata)
	for(var/m in GLOB.player_list)
		var/mob/M = m
		var/client/C = M?.client
		if(C)
			if(C.prefs.toggles & SOUND_MIDI)
				C.tgui_panel?.play_music(url, extradata)

/obj/machinery/jukebox_online/proc/stop_online_song()
	for(var/m in GLOB.player_list)
		var/mob/M = m
		var/client/C = M?.client
		if(C)
			if(C.prefs.toggles & SOUND_MIDI)
				C.tgui_panel?.stop_music()
