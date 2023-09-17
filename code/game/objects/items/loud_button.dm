/// Format: list("freq" = list(buttons))
GLOBAL_LIST_EMPTY(freq2button)
/// Format: list("freq" = list(beepers))
GLOBAL_LIST_EMPTY(freq2beeper)
/// All the sounds that can be played
GLOBAL_LIST_INIT(beeper_sounds,list(
	"Default" = 'beep',
	"Another" = 'beep',
))

/obj/item/table_button
	name = "Electronic service button"
	desc = "Need a trader? Hammer on this thing!"
	icon = 'icons/effects/effects.dmi'
	icon_state = "nothing"
	w_class = WEIGHT_CLASS_TINY
	var/freq = "yayPants"
	var/password = "hunter2"
	var/requesting_password = FALSE
	var/locked = FALSE
	var/deployed = FALSE

/obj/item/table_button/Initialize(mapload)
	. = ..()
	freqify()

/obj/item/table_button/proc/freqify()
	set_freq(random_string(8, GLOB.alphabet))

/obj/item/table_button/proc/set_freq(freq)
	var/old_freq = freq
	var/new_freq = copytext(freq, 0, 8)
	LAZYINITLIST(GLOB.freq2button[old_freq])
	LAZYINITLIST(GLOB.freq2button[new_freq])
	GLOB.freq2button[old_freq] -= src
	GLOB.freq2button[new_freq] |= src
	freq = new_freq
	playsound(src, "beep")	

/obj/item/table_button/ui_interact(mob/user, datum/tgui/ui)
	if(deployed)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TraderSummonerButton", name)
		ui.open()

/obj/item/table_button/ui_data(mob/user)
	var/list/data = list()
	data["Name"] = name
	data["Freq"] = freq
	data["MaxFreqLength"] = 8
	data["Password"] = password
	data["Locked"] = locked
	data["Deployed"] = deployed
	data["AllBeepers"] = list()
	for(var/fq in GLOB.freq2beeper)
		var/list/payload = list()
		var/frequency = "[fq]"
		var/list/beeperNames = list()
		for(var/datum/weakref/W in GLOB.freq2beeper[fq])
			var/obj/item/beeper/B = GET_WEAKREF(W)
			if(!B)
				continue
			beeperNames += B.name
		payload["BeeperFreq"] = frequency
		payload["BeeperName"] = beeperNames
		data["AllBeepers"] += list(payload)
	return data

/obj/item/table_button/ui_act(action, params)
	switch(action)
		if("SetName")
			name = params["Name"]
			to_chat(usr, span_notice("Set [src]'s name to [params["Name"]]!"))
			. = TRUE
		if("SetFreq")
			set_freq(params["Freq"])
			to_chat(usr, span_notice("Set [src]'s freq to [params["Freq"]]!"))
			. = TRUE
		if("SetPassword")
			if(locked)
				to_chat(usr, span_alert("[src] is locked! Unlock it to set the password!"))
				return TRUE
			set_password(usr, params["Password"])
			. = TRUE
		if("ToggleLock") // TGUI will verify the password
			if(locked)
				unlock(usr, params["Password"])
			else
				lock(usr)
			. = TRUE
		if("ToggleDeploy")
			if(deployed)
				if(locked)
					to_chat(usr, span_alert("[src] is locked! Unlock it to undeploy it!"))
					return TRUE
				undeploy(usr)
			else
				deploy(usr)
				to_chat(usr, span_notice("Deployed [src]! The password is [password]!"))
			. = TRUE
	return ..()

/obj/item/table_button/proc/set_password(user, pass)
	if(locked)
		return
	password = pass
	to_chat(user, span_notice("Set [src]'s password to [pass]!"))

/obj/item/table_button/proc/lock(user)
	if(locked)
		return
	locked = TRUE
	to_chat(user, span_notice("Locked [src] with code [password]!"))

/obj/item/table_button/proc/unlock(user, code)
	if(!locked)
		return
	if(code != password)
		to_chat(user, span_alert("Incorrect code!"))
		return
	locked = FALSE
	to_chat(user, span_notice("Unlocked [src] with code [code]!"))

/obj/item/table_button/proc/deploy(mob/user)
	if(deployed)
		return
	var/obj/structure/table/T = locate(/obj/structure/table) in get_turf(src)
	if(!istype(T))
		to_chat(user, span_alert("[src] needs to be placed on a table first!"))
		return
	deployed = TRUE
	interaction_flags_item = 0
	RegisterSignal(src, COMSIG_ITEM_CLICKED, .proc/activate)
	anchored = TRUE
	visible_message(span_notice("[user] affixes a button to [T]!"))

/obj/item/table_button/proc/undeploy(mob/user)
	if(!deployed)
		return
	UnregisterSignal(src, COMSIG_ITEM_CLICKED)
	interaction_flags_item = initial(interaction_flags_item)
	anchored = FALSE
	deployed = FALSE
	visible_message(span_notice("[user] releases the clamps on [src]!"))

/obj/item/table_button/proc/activate(mob/user)
	make_something_beep(user)

/obj/item/table_button/AltClick(mob/user)
	ui_interact(user)

/obj/item/table_button/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/beeper))
		W.set_freq(freq)
		to_chat(user, span_notice("Set [W] to freq [freq]!"))


/obj/item/table_button/proc/make_something_beep(user)
	if(!LAZYACCESS(GLOB.freq2beeper, freq))
		playsound(src, "urrt")
		to_chat(user, span_alert("No beepers found for freq [freq]!"))
		return
	var/list/beepers = list()
	for(var/datum/weakref/W in LAZYACCESS(GLOB.freq2beeper, freq))
		var/obj/item/beeper/B = GET_WEAKREF(W)
		if(!B)
			continue
		beepers += B
		B.beep(user, src)
	if(LAZYLEN(beepers))
		playsound(src, "beep")
	else
		playsound(src, "urrt")
		to_chat(user, span_alert("No beepers found for freq [freq]!"))


/obj/item/beeper
	name = "Beeper"
	desc = "A beeper that beeps."
	icon = 'icons/obj/device.dmi'
	icon_state = "beeper"
	w_class = WEIGHT_CLASS_TINY
	var/current_sound = "beep"
	var/freq = 0
	var/active = TRUE

/obj/item/beeper/Initialize(mapload)
	. = ..()
	add_timer(CALLBACK(src, .proc/init_link), 1 SECONDS)

/obj/item/beeper/proc/init_link()
	if(!SEND_SIGNAL(loc, COMSIG_CONTAINS_STORAGE))
		set_freq(random_string(8, GLOB.alphabet))
		return
	for(var/obj/item/butt in loc.contents)
		if(istype(butt, /obj/item/table_button))
			set_freq(butt.freq)
			return

/obj/item/beeper/proc/set_freq(freq)
	var/old_freq = freq
	var/new_freq = copytext(freq, 0, 8)
	LAZYINITLIST(GLOB.freq2beeper[old_freq])
	LAZYINITLIST(GLOB.freq2beeper[new_freq])
	GLOB.freq2beeper[old_freq] -= src
	GLOB.freq2beeper[new_freq] |= src
	freq = new_freq
	playsound(src, "beep")

/obj/item/beeper/ui_interact(mob/user, datum/tgui/ui)
	if(deployed)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TraderSummonerbeeper", name)
		ui.open()

/obj/item/beeper/ui_data(mob/user)
	var/list/data = list()
	data["Name"] = name
	data["Freq"] = freq
	data["MaxFreqLength"] = 8
	data["Active"] = active
	data["AllButtons"] = list()
	for(var/fq in GLOB.freq2button)
		var/list/payload = list()
		var/frequency = "[fq]"
		var/list/buttonNames = list()
		for(var/datum/weakref/W in GLOB.freq2button[fq])
			var/obj/item/table_button/B = GET_WEAKREF(W)
			if(!B)
				continue
			buttonNames += B.name
		payload["ButtFreq"] = frequency
		payload["ButtNames"] = buttonNames
		data["AllButtons"] += list(payload)
	data["AllSounds"] = list()
	for(var/sname in GLOB.beeper_sounds)
		var/list/snobject = list()
		snobject["SoundName"] = sname
		snobject["SoundPath"] = GLOB.beeper_sounds[sname]
		data["AllSounds"] += list(snobject)
	data["CurrentSound"] = current_sound
	return data

/obj/item/table_button/ui_act(action, params)
	switch(action)
		if("SetName")
			name = params["Name"]
			to_chat(usr, span_notice("Set [src]'s name to [params["Name"]]!"))
			. = TRUE
		if("SetFreq")
			set_freq(params["Freq"])
			to_chat(usr, span_notice("Set [src]'s freq to [params["Freq"]]!"))
			. = TRUE
		if("ToggleActive")
			active = !active
			to_chat(usr, span_notice("You turned [src] [active?"on":"off"]!"))
			. = TRUE
		if("SetSound")
			var/soundname = params["Sound"]
			var/soundpath = GLOB.beeper_sounds[soundname]
			current_sound = soundpath
			to_chat(usr, span_notice("Set [src]'s sound to [soundname]!"))
			. = TRUE
	return ..()




