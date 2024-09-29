/* 
 * File:   datumrentals.dm
 * Date:   13/13/2013
 * License: rent to own
 * 
 * Purpose: A handy library system to hold all the wierd temporary data packets that would
 *          otherwise be sent as a dozen or so args and misc data lists
 *          As we all know, anything a frickhuge list or mass of args can do, a datum can do better.
 *          A proc can check out a datum, fill it with data, pass it around like the town bicycle, and then
 *          check it back in when it's done.
 *          They're generally intended to only be used for at most a second or two, otherwise you're not renting, you're buying.
 *          Which, fine, you can keep it, but really at that point you should just give it its own home.
 *          If we need a datum, but none are available, we can create a new one, but we should always check it back in.
 *          The checkin process is so that the datum can be recycled and reused, cus we're all about recycling here.
 *          Save the datums, nuke the whales.
 * */

SUBSYSTEM_DEF(rentaldatums)
	name = "RentalDatums"
	flags = SS_TICKER | SS_NO_FIRE
	wait = 1 MINUTES
	init_order = INIT_ORDER_RENTALS

	var/list/mommies = list()

	/// now for the rental mommies
	var/list/chat_datums = list()
	var/chat_uses_mommy = TRUE // my code my names

/datum/controller/subsystem/rentaldatums/Initialize(start_timeofday)
	init_datums()
	. = ..()

/datum/controller/subsystem/rentaldatums/proc/init_datums()
	chat_datums = list()
	chat_datums += new /datum/rental_mommy/chat()


/datum/controller/subsystem/rentaldatums/proc/CheckoutMommy(mom)
	var/list/mymom = LAZYACCESS(vars, mom)
	if(!mymom)
		return null
	for(var/datum/rental_mommy/chat/mommy in mymom)
		if(mommy.checkout())
			return mommy
	var/datum/rental_mommy/chat/mommy = LAZYACCESS(mymom, 1) // there will always be at least one mommy
	var/datum/rental_mommy/chat/mommy2 = new mommy.type()
	mymom += mommy2
	mommy2.checkout()
	return mommy2

/datum/controller/subsystem/rentaldatums/proc/CheckoutChatMommy()
	return CheckoutMommy("chat_datums")

/datum/rental_mommy // hey isnt that your mom?
	/// Is your mom available?
	var/available = TRUE
	/// The number of tally marks sharpied on your mom's butt that denotes how many times she's been "rented"
	var/uses = 0
	/// How long we've booked your mom for
	var/checked_out_until = 0

/datum/rental_mommy/proc/checkout()
	if(!available)
		if(world.time < checked_out_until)
			return
		checkin()
	available = FALSE
	uses += 1
	checked_out_until = (world.time + 5 MINUTES)
	return TRUE

/datum/rental_mommy/proc/checkin()
	wipe()
	available = TRUE
	checked_out_until = 0
	return TRUE

/datum/rental_mommy/proc/wipe()
	return

/datum/rental_mommy/proc/copy_mommy(datum/rental_mommy/chat/mommy)
	if(mommy.type != type)
		return
	return TRUE

/// Charlotte, chat's rental mommy
/// Holds a dynamic glob of chat data that can be easily manipulated and passed around
/// She loves it
/datum/rental_mommy/chat
	var/original_message = ""
	var/message = ""
	var/original_speakername = ""
	var/speakername = ""
	var/atom/source
	var/message_mode
	var/message_key
	var/list/spans = list()
	var/sanitize
	var/bubble_type = null
	var/datum/language/language
	var/language_key
	var/datum/saymode/saymode
	var/ignore_spam
	var/forced
	var/only_overhead
	var/is_radio
	var/radio_freq
	var/close_message_range = 7
	var/far_message_range = 15
	/// Stuff to put to the left of the inner body of the message
	var/list/msg_decor_left = list()
	/// Stuff to put to the right of the inner body of the message
	var/list/msg_decor_right = list()
	/// for ventriloquist dolls to prevent the player from saying whatever it is they're saying, 
	/// and for the doll to say it instead
	var/no_pass
	/// SHOULD THE MESSAGE BE RENDERED IN ALL CAPS???????????????
	var/ALL_CAPS
	var/runechat_mode
	var/mob/recipiant
	var/display_turf
	var/is_eavesdropping
	var/chat_color_base
	var/chat_color_sanitized
	var/furry_dating_sim
	var/namepart
	var/face_name
	var/list/data = list()
	var/outer_span_class
	var/outer_span
	var/name_span_class
	var/name_span
	var/freqpart
	var/message_langtreated_spanned
	var/message_langtreated_spanned_quotes
	var/message_saymod
	var/message_saymod_comma
	var/message_langtreated_quoteless
	var/message_langtreated_with_verb
	var/language_icon
	var/source_quid
	var/source_ckey
	var/datum/preferences/prefs_override
	var/dummy
	var/is_emote
	var/partial
	var/hide_name_n_verb
	var/direct_to_mob
	var/in_critical
	var/coloned_word
	var/is_quiet
	var/speech_range_set
	var/radio_no_pass
	var/verb_pretreated
	var/radio_returns
	var/mode_trimmed
	var/is_actually_radio

/datum/rental_mommy/chat/copy_mommy(datum/rental_mommy/chat/mommy)
	if(!..())
		CRASH("Tried to copy a mommy of a different type")
	original_message                   = mommy.original_message
	message                            = mommy.message
	original_speakername               = mommy.original_speakername
	speakername                        = mommy.speakername
	source                             = mommy.source
	message_mode                       = mommy.message_mode
	message_key                        = mommy.message_key
	spans                              = mommy.spans
	sanitize                           = mommy.sanitize
	bubble_type                        = mommy.bubble_type
	language                           = mommy.language
	language_key                       = mommy.language_key
	saymode                            = mommy.saymode
	ignore_spam                        = mommy.ignore_spam
	forced                             = mommy.forced
	only_overhead                      = mommy.only_overhead
	is_radio                           = mommy.is_radio
	radio_freq                         = mommy.radio_freq
	close_message_range                = mommy.close_message_range
	far_message_range                  = mommy.far_message_range
	msg_decor_left                     = mommy.msg_decor_left
	msg_decor_right                    = mommy.msg_decor_right
	no_pass                            = mommy.no_pass
	ALL_CAPS                           = mommy.ALL_CAPS
	runechat_mode                      = mommy.runechat_mode
	recipiant                          = mommy.recipiant
	display_turf                       = mommy.display_turf
	is_eavesdropping                   = mommy.is_eavesdropping
	chat_color_base                    = mommy.chat_color_base
	chat_color_sanitized               = mommy.chat_color_sanitized
	furry_dating_sim                   = mommy.furry_dating_sim
	namepart                           = mommy.namepart
	face_name                          = mommy.face_name
	data                               = mommy.data
	outer_span_class                   = mommy.outer_span_class
	outer_span                         = mommy.outer_span
	name_span_class                    = mommy.name_span_class
	name_span                          = mommy.name_span
	freqpart                           = mommy.freqpart
	message_langtreated_spanned        = mommy.message_langtreated_spanned
	message_langtreated_spanned_quotes = mommy.message_langtreated_spanned_quotes
	message_saymod                     = mommy.message_saymod
	message_saymod_comma               = mommy.message_saymod_comma
	message_langtreated_quoteless      = mommy.message_langtreated_quoteless
	message_langtreated_with_verb      = mommy.message_langtreated_with_verb
	language_icon                      = mommy.language_icon
	source_quid                        = mommy.source_quid
	source_ckey                        = mommy.source_ckey
	prefs_override                     = mommy.prefs_override
	dummy                              = mommy.dummy
	is_emote                           = mommy.is_emote
	partial                            = mommy.partial
	hide_name_n_verb                   = mommy.hide_name_n_verb
	direct_to_mob                      = mommy.direct_to_mob
	in_critical                        = mommy.in_critical
	coloned_word                       = mommy.coloned_word
	is_quiet                           = mommy.is_quiet
	speech_range_set                   = mommy.speech_range_set
	radio_no_pass                      = mommy.radio_no_pass
	verb_pretreated                    = mommy.verb_pretreated
	radio_returns                      = mommy.radio_returns
	mode_trimmed                       = mommy.mode_trimmed
	is_actually_radio                 = mommy.is_actually_radio

/datum/rental_mommy/chat/wipe()
	original_message                   = ""
	message                            = ""
	original_speakername               = ""
	speakername                        = ""
	source                             = null
	message_mode                       = null
	message_key                        = null
	spans                              = list()
	sanitize                           = null
	bubble_type                        = null
	language                           = null
	language_key                       = null
	saymode                            = null
	ignore_spam                        = null
	forced                             = null
	only_overhead                      = null
	is_radio                           = null
	radio_freq                         = null
	close_message_range                = 7
	far_message_range                  = 15
	msg_decor_left                     = list()
	msg_decor_right                    = list()
	no_pass                            = null
	ALL_CAPS                           = null
	runechat_mode                      = null
	recipiant                          = null
	display_turf                       = null
	is_eavesdropping                   = null
	chat_color_base                    = null
	chat_color_sanitized               = null
	furry_dating_sim                   = null
	namepart                           = null
	face_name                          = null
	data                               = list()
	outer_span_class                   = null
	outer_span                         = null
	name_span_class                    = null
	name_span                          = null
	freqpart                           = null
	message_langtreated_spanned        = null
	message_langtreated_spanned_quotes = null
	message_saymod                     = null
	message_saymod_comma               = null
	message_langtreated_quoteless      = null
	message_langtreated_with_verb      = null
	language_icon                      = null
	source_quid                        = null
	source_ckey                        = null
	prefs_override                     = null
	dummy                              = null
	is_emote                           = null
	partial                            = null
	hide_name_n_verb                   = null
	direct_to_mob                      = null
	in_critical                        = null
	coloned_word                       = null
	is_quiet                           = null
	speech_range_set                   = null
	radio_no_pass                      = null
	verb_pretreated                    = null
	radio_returns                      = null
	mode_trimmed                       = null
	is_actually_radio                  = null

// /// Know what, know what? screw it, I'm compiling all the chat procs into this datum
// /datum/rental_mommy/chat/proc/handle_say(
// 	atom/speaker,
// 	message,
// 	bubble_type,
// 	list/spans = list(),
// 	sanitize,
// 	language,
// 	ignore_spam,
// 	forced,
// 	only_overhead,
// 	direct_to_mob
// )

// 	src.original_message = message
// 	src.message = message
// 	src.source = speaker
// 	src.message_mode = MODE_SAY
// 	src.spans = spans.Copy()
// 	src.sanitize = sanitize
// 	src.bubble_type = bubble_type
// 	src.language = language
// 	src.only_overhead = only_overhead
// 	src.source_quid = extract_quid(src)
// 	src.source_ckey = ckey
// 	src.direct_to_mob = direct_to_mob
// 	src.ignore_spam = ignore_spam
// 	src.forced = forced

// 	if(ismob(source))
// 		compile_from_mob(speaker)

// 	var/talk_key = get_key(momchat.message)
// 	momchat.message_key = talk_key


// /mob/living/proc/get_key(message)
// 	var/key = message[1]
// 	if(key in GLOB.department_radio_prefixes)
// 		return lowertext(message[1 + length(key)])


