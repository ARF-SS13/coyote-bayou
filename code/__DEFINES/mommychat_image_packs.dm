
/datum/horny_image_pack
	var/packname = "Cute Coderbussies"
	var/examine_host = "catbox.moe"
	var/examine_url = "12345.png"
	var/say_host
	var/say_url
	var/ask_host
	var/ask_url
	var/exclaim_host
	var/exclaim_url
	var/yell_host
	var/yell_url
	var/whisper_host
	var/whisper_url
	var/sing_host
	var/sing_url

/datum/horny_image_pack/proc/ListifyPack()
	var/list/pak = list(
		list(
			"mode" = MODE_SAY,
			"host" = say_host,
			"url" = say_url,
		),
		list(
			"mode" = MODE_ASK,
			"host" = ask_host,
			"url" = ask_url,
		),
		list(
			"mode" = MODE_SING,
			"host" = sing_host,
			"url" = sing_url,
		),
		list(
			"mode" = MODE_EXCLAIM,
			"host" = exclaim_host,
			"url" = exclaim_url,
		),
		list(
			"mode" = MODE_YELL,
			"host" = yell_host,
			"url" = yell_url,
		),
		list(
			"mode" = MODE_WHISPER,
			"host" = whisper_host,
			"url" = whisper_url,
		),
		list(
			"mode" = ":flirty:",
			"host" = "catbox.moe",
			"url" = "12345.png",
		),
	)
	return pak





