/obj/item/radio
	icon = 'icons/obj/radio.dmi'
	name = "handheld transceiver"
	icon_state = "walkietalkie"
	item_state = "walkietalkie"
	desc = "A basic handheld radio that can both broadcast and recieve signals."
	dog_fashion = /datum/dog_fashion/back

	flags_1 = CONDUCT_1 | HEAR_1
	slot_flags = INV_SLOTBIT_BELT
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=75, /datum/material/glass=25)
	obj_flags = USES_TGUI

	var/on = TRUE
	var/frequency = FREQ_COMMON
	var/canhear_range = 3  // The range around the radio in which mobs can hear what it receives.

	var/broadcasting = FALSE  // Whether the radio will transmit dialogue it hears nearby.
	var/listening = TRUE  // Whether the radio is currently receiving.
	var/prison_radio = FALSE  // If true, the transmit wire starts cut.
	var/unscrewed = FALSE  // Whether wires are accessible. Toggleable by screwdrivering.
	var/freerange = FALSE  // If true, the radio has access to the full spectrum.
	var/subspace_transmission = FALSE  // If true, the radio transmits and receives on subspace exclusively.
	var/subspace_switchable = FALSE  // If true, subspace_transmission can be toggled at will.
	var/freqlock = FALSE  // Frequency lock to stop the user from untuning specialist radios.
	var/use_command = FALSE  // If true, broadcasts will be large and BOLD.
	var/command = FALSE  // If true, use_command can be toggled at will.
	var/commandspan = SPAN_COMMAND //allow us to set what the fuck we want for headsets

	var/suppress_blurbles = FALSE

	// Encryption key handling
	var/obj/item/encryptionkey/keyslot
	var/translate_binary = FALSE  // If true, can hear the special binary channel.
	var/independent = FALSE  // If true, can say/hear on the special CentCom channel.
	var/syndie = FALSE  // If true, hears all well-known channels automatically, and can say/hear on the Syndicate channel.
	var/list/channels = list()  // Map from name (see communications.dm) to on/off. First entry is current department (:h).
	var/list/secure_radio_connections

	var/const/FREQ_LISTENING = 1
	//FREQ_BROADCASTING = 2

	//fortuna addition start. radio management.
	var/kill_switched = FALSE // If true, the radio is essentially useless.
	var/factionized = FALSE
	var/linked_faction = FALSE // Which faction the radio is linked to.
	var/mob/living/carbon/linked_mob = null // Which mob the radio is checked out to.
	//fortuna addition end. radio management.

/obj/item/radio/proc/set_frequency(new_frequency)
	SEND_SIGNAL(src, COMSIG_RADIO_NEW_FREQUENCY, args)
	remove_radio(src, frequency)
	frequency = add_radio(src, new_frequency)

/obj/item/radio/proc/recalculateChannels()
	channels = list()
	translate_binary = FALSE
	syndie = FALSE
	independent = FALSE

	if(keyslot)
		for(var/ch_name in keyslot.channels)
			if(!(ch_name in channels))
				channels[ch_name] = keyslot.channels[ch_name]

		if(keyslot.translate_binary)
			translate_binary = TRUE
		if(keyslot.syndie)
			syndie = TRUE
		if(keyslot.independent)
			independent = TRUE

	for(var/ch_name in channels)
		secure_radio_connections[ch_name] = add_radio(src, GLOB.radiochannels[ch_name])

/obj/item/radio/proc/make_syndie() // Turns normal radios into Syndicate radios!
	qdel(keyslot)
	keyslot = new /obj/item/encryptionkey/syndicate
	syndie = 1
	recalculateChannels()

/obj/item/radio/Destroy()
	if(factionized) //fortuna addition. radio management.
		linked_mob = null
		LAZYREMOVE(GLOB.faction_radios, src)
		switch(linked_faction)
			if(FACTION_NCR)
				LAZYREMOVE(GLOB.ncr_radios, src)
			if(FACTION_LEGION)
				LAZYREMOVE(GLOB.legion_radios, src)
			if(FACTION_BROTHERHOOD)
				LAZYREMOVE(GLOB.bos_radios, src)
	remove_radio_all(src) //Just to be sure
	QDEL_NULL(wires)
	QDEL_NULL(keyslot)
	return ..()

/obj/item/radio/Initialize()
	wires = new /datum/wires/radio(src)
	if(prison_radio)
		wires.cut(WIRE_TX) // OH GOD WHY
	secure_radio_connections = new
	. = ..()
	frequency = sanitize_frequency(frequency, freerange)
	set_frequency(frequency)

	for(var/ch_name in channels)
		secure_radio_connections[ch_name] = add_radio(src, GLOB.radiochannels[ch_name])
	Factionize() //add our radio to the factionized list through a proc

//fortuna addition. radio management proc that allows us to re-add manageable radios after being killswitched or upon creation
/obj/item/radio/proc/Factionize()
	if(factionized)
		LAZYADD(GLOB.faction_radios, src)
		switch(linked_faction)
			if(FACTION_NCR)
				LAZYADD(GLOB.ncr_radios, src)
			if(FACTION_LEGION)
				LAZYADD(GLOB.legion_radios, src)
			if(FACTION_BROTHERHOOD)
				LAZYADD(GLOB.bos_radios, src)

/obj/item/radio/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_WIRES)

/obj/item/radio/interact(mob/user)
	if(unscrewed && !isAI(user))
		wires.interact(user)
		add_fingerprint(user)
	else
		..()

/obj/item/radio/ui_state(mob/user)
	return GLOB.inventory_state

/obj/item/radio/proc/kill_switch() //fortuna addition. radio management
	playsound(src, 'sound/machines/buzz-sigh.ogg', 100, 1)
	kill_switched = TRUE
	linked_mob = null

/obj/item/radio/ui_interact(mob/user, datum/tgui/ui, datum/ui_state/state)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Radio", name)
		if(state)
			ui.set_state(state)
		ui.open()

/obj/item/radio/ui_data(mob/user)
	var/list/data = list()

	data["broadcasting"] = broadcasting
	data["listening"] = listening
	data["frequency"] = frequency
	data["minFrequency"] = freerange ? MIN_FREE_FREQ : MIN_FREQ
	data["maxFrequency"] = freerange ? MAX_FREE_FREQ : MAX_FREQ
	data["freqlock"] = freqlock
	data["channels"] = list()
	for(var/channel in channels)
		data["channels"][channel] = channels[channel] & FREQ_LISTENING
	data["command"] = command
	data["useCommand"] = use_command
	data["subspace"] = subspace_transmission
	data["subspaceSwitchable"] = subspace_switchable
	data["headset"] = istype(src, /obj/item/radio/headset)
	data["suppressBlurbles"] = suppress_blurbles

	return data

/obj/item/radio/ui_act(action, params, datum/tgui/ui)
	if(..())
		return
	switch(action)
		if("frequency")
			if(freqlock)
				return
			var/tune = params["tune"]
			var/adjust = text2num(params["adjust"])
			if(tune == "input")
				var/min = format_frequency(freerange ? MIN_FREE_FREQ : MIN_FREQ)
				var/max = format_frequency(freerange ? MAX_FREE_FREQ : MAX_FREQ)
				tune = input("Tune frequency ([min]-[max]):", name, format_frequency(frequency)) as null|num
				if(!isnull(tune) && !..())
					if (tune < MIN_FREE_FREQ && tune <= MAX_FREE_FREQ / 10)
						// allow typing 144.7 to get 1447
						tune *= 10
					. = TRUE
			else if(adjust)
				tune = frequency + adjust * 10
				. = TRUE
			else if(text2num(tune) != null)
				tune = tune * 10
				. = TRUE
			if(.)
				set_frequency(sanitize_frequency(tune, freerange))
		if("listen")
			listening = !listening
			. = TRUE
		if("broadcast")
			broadcasting = !broadcasting
			if(broadcasting && on) //we dont need hearing sensitivity if we arent broadcasting, because talk_into doesnt care about hearing
				become_hearing_sensitive(INNATE_TRAIT)
			else if(!broadcasting)
				lose_hearing_sensitivity(INNATE_TRAIT)
			. = TRUE
		if("channel")
			var/channel = params["channel"]
			if(!(channel in channels))
				return
			if(channels[channel] & FREQ_LISTENING)
				channels[channel] &= ~FREQ_LISTENING
			else
				channels[channel] |= FREQ_LISTENING
			. = TRUE
		if("suppressBlurbles")
			TOGGLE_VAR(suppress_blurbles)
			. = TRUE
		if("command")
			use_command = !use_command
			. = TRUE
		if("subspace")
			if(subspace_switchable)
				subspace_transmission = !subspace_transmission
				if(!subspace_transmission)
					channels = list()
				else
					recalculateChannels()
				. = TRUE

/obj/item/radio/talk_into(atom/movable/M, message, channel, list/spans, datum/language/language, datum/rental_mommy/chat/momchat)
	if(!spans)
		spans = list(M.speech_span)
	if(!language)
		language = M.get_selected_language()
	var/datum/rental_mommy/chat/mom2
	if(momchat)
		mom2 = SSrentaldatums.CheckoutChatMommy()
		mom2.copy_mommy(momchat)
	INVOKE_ASYNC(src,PROC_REF(talk_into_impl), M, message, channel, spans.Copy(), language, mom2)
	return ITALICS | REDUCE_RANGE

#define RET_RAD_MOM momchat?.checkin(); return
/obj/item/radio/proc/talk_into_impl(atom/movable/M, message, channel, list/spans, datum/language/language, datum/rental_mommy/chat/momchat)
	if(!on)
		RET_RAD_MOM // the device has to be on
	//Fortuna edit start. Radio management
	if(kill_switched)
		RET_RAD_MOM
	if(factionized && !linked_mob)
		RET_RAD_MOM
	//Fortuna edit end. Radio management
	if(!M || !message)
		RET_RAD_MOM
	if(wires.is_cut(WIRE_TX))  // Permacell and otherwise tampered-with radios
		RET_RAD_MOM
	if(!M.IsVocal())
		RET_RAD_MOM
	if(language == /datum/language/signlanguage)
		RET_RAD_MOM

	if(use_command)
		spans |= commandspan
		momchat?.spans |= commandspan
	if(momchat)
		momchat?.spans |= spans

	/*
	Roughly speaking, radios attempt to make a subspace transmission (which
	is received, processed, and rebroadcast by the telecomms satellite) and
	if that fails, they send a mundane radio transmission.

	Headsets cannot send/receive mundane transmissions, only subspace.
	Syndicate radios can hear transmissions on all well-known frequencies.
	CentCom radios can hear the CentCom frequency no matter what.
	*/

	// From the channel, determine the frequency and get a reference to it.
	var/freq
	if(channel && channels && channels.len > 0)
		if(channel == MODE_DEPARTMENT)
			channel = channels[1]
		freq = secure_radio_connections[channel]
		if (!channels[channel]) // if the channel is turned off, don't broadcast
			RET_RAD_MOM
	else
		freq = frequency
		channel = null

	// Nearby active jammers severely gibberish the message
	var/turf/position = get_turf(src)
	for(var/obj/item/jammer/jammer in GLOB.active_jammers)
		var/turf/jammer_turf = get_turf(jammer)
		if(position.z == jammer_turf.z && (get_dist(position, jammer_turf) < jammer.range))
			message = Gibberish(message,100)
			momchat?.message = message
			break

	// Determine the identity information which will be attached to the signal.
	var/atom/movable/virtualspeaker/speaker = new(null, M, src)

	// Construct the signal
	var/datum/signal/subspace/vocal/signal = new(src, freq, speaker, language, message, spans, M)
	signal.data["is_radio"] = TRUE
	signal.data["suppress_blurbles"] = suppress_blurbles
	signal.data["momchat"] = momchat
	if(!suppress_blurbles)
		playsound(src, 'sound/effects/counter_terrorists_win.ogg', 20, TRUE, SOUND_DISTANCE(2), ignore_walls = TRUE)
	
	// Independent radios, on the CentCom frequency, reach all independent radios
	if (independent && (freq == FREQ_CENTCOM || freq == FREQ_CTF_RED || freq == FREQ_CTF_BLUE))
		signal.data["compression"] = 0
		signal.transmission_method = TRANSMISSION_SUPERSPACE
		signal.levels = list(0)  // reaches all Z-levels
		signal.broadcast()
		return

	// All radios make an attempt to use the subspace system first
	signal.send_to_receivers()

	// If the radio is subspace-only, that's all it can do
	if (subspace_transmission)
		return

	// Non-subspace radios will check in a couple of seconds, and if the signal
	// was never received, send a mundane broadcast (no headsets).
	addtimer(CALLBACK(src,PROC_REF(backup_transmission), signal), 20)

/obj/item/radio/proc/backup_transmission(datum/signal/subspace/vocal/signal)
	var/turf/T = get_turf(src)
	if (signal.data["done"] && (T.z in signal.levels))
		return

	// Okay, the signal was never processed, send a mundane broadcast.
	signal.data["compression"] = 0
	signal.transmission_method = TRANSMISSION_RADIO
	signal.levels = list(T.z)
	signal.broadcast()

/obj/item/radio/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, atom/movable/source, only_overhead, list/data)
	. = ..()
	if(radio_freq || !broadcasting || get_dist(src, speaker) > (canhear_range)-2)
		return

	if(message_mode == MODE_WHISPER || message_mode == MODE_WHISPER_CRIT)
		// radios don't pick up whispers very well
		raw_message = dots(raw_message, 20, SSchat.base_radio_reduced_distance, SSchat.extended_radio_reduced_distance)
	else if(message_mode == MODE_L_HAND || message_mode == MODE_R_HAND)
		// try to avoid being heard double
		if (loc == speaker && ismob(speaker))
			var/mob/M = speaker
			var/idx = M.get_held_index_of_item(src)
			// left hands are odd slots
			if (idx && (idx % 2) == (message_mode == MODE_L_HAND))
				return
	var/datum/rental_mommy/chat/momchat = LAZYLEN(data) ? data["momchat"] : null
	talk_into(speaker, raw_message, , spans, message_language, momchat)

// Checks if this radio can receive on the given frequency.
/obj/item/radio/proc/can_receive(freq, level)
	// deny checks
	if (!on || !listening || wires.is_cut(WIRE_RX))
		return FALSE
	//Fortuna edit start. Radio management
	if(kill_switched)
		return FALSE
	if(factionized && !linked_mob)
		return
	//Fortuna edit end. Radio management
	if (freq == FREQ_SYNDICATE && !syndie)
		return FALSE
	if (freq == FREQ_CENTCOM)
		return independent  // hard-ignores the z-level check
	if (!(0 in level))
		var/turf/position = get_turf(src)
		if(!position || !(position.z in level))
			return FALSE

	// allow checks: are we listening on that frequency?
	if (freq == frequency)
		return TRUE
	for(var/ch_name in channels)
		if(channels[ch_name] & FREQ_LISTENING)
			//the GLOB.radiochannels list is located in communications.dm
			if(GLOB.radiochannels[ch_name] == text2num(freq) || syndie)
				return TRUE
	return FALSE


/obj/item/radio/examine(mob/user)
	. = ..()
	if (unscrewed)
		. += span_notice("It can be attached and modified.")
	else
		. += span_notice("It cannot be modified or attached.")
	//Fortuna edit start. Radio management
	if(kill_switched)
		. += span_warning("The radio has been disabled remotely and no longer functions!")
	if(linked_faction)
		. += span_notice("The radio is linked to [linked_faction]!")
	if(factionized && !linked_mob && !kill_switched)
		. += span_warning("This radio will not work without being checked-out at a radio terminal belonging to [linked_faction] first!")
	//Fortuna edit end. Radio management

/obj/item/radio/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)
	if(istype(W, /obj/item/screwdriver))
		unscrewed = !unscrewed
		if(unscrewed)
			to_chat(user, span_notice("The radio can now be attached and modified!"))
		else
			to_chat(user, span_notice("The radio can no longer be modified or attached!"))
	else
		return ..()
/*
/obj/item/radio/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return
	if(prob(severity * 1.5))
		if(listening && ismob(loc))	// if the radio is turned on and on someone's person they notice
			to_chat(loc, span_warning("\The [src] shorts out!"))
		broadcasting = FALSE
		listening = FALSE
		for (var/ch_name in channels)
			channels[ch_name] = 0
		on = FALSE
*/
///////////////////////////////
//////////Borg Radios//////////
///////////////////////////////
//Giving borgs their own radio to have some more room to work with -Sieve

/obj/item/radio/borg
	name = "cyborg radio"
	subspace_switchable = TRUE
	dog_fashion = null

/obj/item/radio/borg/Initialize(mapload)
	. = ..()

/obj/item/radio/borg/syndicate
	syndie = 1
	keyslot = new /obj/item/encryptionkey/syndicate

/obj/item/radio/borg/syndicate/Initialize()
	. = ..()
	set_frequency(FREQ_SYNDICATE)

/obj/item/radio/borg/attackby(obj/item/W, mob/user, params)

	if(istype(W, /obj/item/screwdriver))
		if(keyslot)
			for(var/ch_name in channels)
				SSradio.remove_object(src, GLOB.radiochannels[ch_name])
				secure_radio_connections[ch_name] = null


			if(keyslot)
				var/turf/T = get_turf(user)
				if(T)
					keyslot.forceMove(T)
					keyslot = null

			recalculateChannels()
			to_chat(user, span_notice("You pop out the encryption key in the radio."))

		else
			to_chat(user, span_warning("This radio doesn't have any encryption keys!"))

	else if(istype(W, /obj/item/encryptionkey/))
		if(keyslot)
			to_chat(user, span_warning("The radio can't hold another key!"))
			return

		if(!keyslot)
			if(!user.transferItemToLoc(W, src))
				return
			keyslot = W

		recalculateChannels()


/obj/item/radio/off	// Station bounced radios, their only difference is spawning with the speakers off, this was made to help the lag.
	listening = 0			// And it's nice to have a subtype too for future features.
	dog_fashion = /datum/dog_fashion/back

/obj/item/radio/internal
	var/obj/item/implant/radio/implant

/obj/item/radio/internal/Initialize(mapload, obj/item/implant/radio/_implant)
	. = ..()
	implant = _implant

/obj/item/radio/internal/Destroy()
	if(implant?.imp_in)
		qdel(implant)
	else
		return ..()

/// Other Radios

/obj/item/radio/tribal
	name = "primitive radio"
	icon_state = "radio"
	item_state = "radio"
	desc = "a homemade radio transceiver made out of transistors and wire."
	canhear_range = 2
	w_class = WEIGHT_CLASS_SMALL

GLOBAL_VAR_INIT(redwater_frequency, null)
GLOBAL_LIST_INIT(banned_redwater_freqs, list(FREQ_COMMON, 1488))

/obj/item/radio/redwater
	name = "handheld transceiver"
	icon_state = "walkietalkie"
	item_state = "walkietalkie"
	desc = "A rugged radio used by even more rugged folk. If you aren't in with the wrong crowd, you probably shouldn't have one of these."
	canhear_range = 2
	w_class = WEIGHT_CLASS_TINY
	force = WEAPON_FORCE_BLUNT_LARGE // 15 Brute, enough to daze someone
	sharpness = SHARP_NONE



/obj/item/radio/redwater/Initialize()
	. = ..()
	setup_redwater_frequency()
	set_frequency(GLOB.redwater_frequency)
	color = "#5c5c5c"

/obj/item/radio/redwater/proc/setup_redwater_frequency(mob/user)
	if(GLOB.redwater_frequency > 1)
		return // already setup!
	var/frequency_ok = FALSE
	var/tries_left = 5
	while(!frequency_ok)
		GLOB.redwater_frequency = rand(MIN_FREQ, MAX_FREQ)
		if(GLOB.redwater_frequency in GLOB.banned_redwater_freqs)
			if(tries_left-- > 0)
				continue
		frequency_ok = TRUE

/obj/item/radio/redwater/examine(mob/user)
	. = ..()
	if(GLOB.redwater_frequency)
		. += "Scratched into the bottom is a note, \"Don't forget, we're tuned to <span class='boldnotice'>[GLOB.redwater_frequency * 0.1]</span>!\""
