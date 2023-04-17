// Handles the internal psychology of a fucking blender
// yeah
// this *used* to be a simple project

// Oh yeah, with this, after this, master will be a var that is the owning blender
#define MASTER_BLENDER \
	var/obj/item/storage/blender_belt/master = my_blender.resolve();\
	if(!istype(master)){return}
#define MOB_HOLDING_ME \
	var/mob/holding_me = ismob(master.loc) ? master.loc : null

/* LAGG'S PET PROJECT: A NEEDLESSLY COMPLICATED AI FOR MAKING BLENDERS HORNY
 * The AI has three (mostly two) parts: The BlenderBrain Datum, The PersonaCore Item, and A Host Item (optional, sorta)
 * * The BlenderBrain Datum (BBD) handles all the internal logic, stimulus processing, and output impulses
 * * The PersonaCore Item (PCI) houses the Datum, and exists as an interface between the Datum and the Host/Itself
 * * The Host is just some kind of storage item that has a fuckload of instructions that can register with the item
 * 
 * IMPORTANT CONCEPTS:
 * * Stimulus - Something sent TO the BBD for processing
 * * Impulse - Something sent FROM the BBD for interaction
 * * * Impulses can, in turn, sent stimulii back to the BBD, typically to make it say something
 * * * Impulses are sent as a LIST, so one stimulus can result in multiple actions
 * * Request - An Impulse sent to the Host for a quick reply, like if the host is running, or exists
 * The host communicates with the PCI (and vice versa) through SEND_SIGNAL
 * The PCI communicates with the BBD (and vice versa) through direct proc stuff
 * The BBD does not interact with the outside world directly, everything is interfaced between it and the PCI
 * The PCI/BBD do not need a Host to exist, but it lets them do things other than speak
 * 
 * An example, the Host is grinding an egg
 * * The Host sends a Stimulus Signal, with the type of stimulus, the user, and item as arguments
 * * The PCI detects the signal, and relays it to the BBD
 * * The BBD reads the stimulus, and runs whichever procs are associated with it
 * * The BBD sends an impulse to the PCI, to speak, with the message index and item as arguments
 * * The PCI reads that impulse, and speaks the given message
 * 
 */

#define BELTCLARIFY_I_LOVEHATE "life_is_pain" // If you say "pain", it turns on the horrible noises
#define BELTCLARIFY_I_LOVE "i_luv"
#define BELTCLARIFY_I_HATE "i_hat"
#define BELTCLARIFY_LOVEHATE_YOU "who_do_ya" 
#define BELTCLARIFY_LOVE_YOU "who_luvs_ya" 
#define BELTCLARIFY_HATE_YOU "who_hats_ya" 
#define BELTCLARIFY_LOVEHATE "idk"
#define BELTCLARIFY_LOVE_MEAN_IT "orly-love"
#define BELTCLARIFY_HATE_MEAN_IT "orly-hate"
#define BELTCLARIFY_PAIN_MEAN_IT "orly-pain"

// amour returns
#define HORNY_MSG 1
#define NORMAL_MSG 2
#define DISLIKE_MSG 3

/datum/blender_brain
	var/my_name
	var/owner_name
	var/owner_gender
	/// How much the blender likes its owner
	var/amour = 1
	var/list/ex_owners = list()
	var/list/met_people = list()
	var/list/mean_people = list()
	/// Our working memory, for things we're currently thinking about
	/// Queued up things to process, to be handled in order
	/// format: list(/datum/blender_memory/thing, /datum/blender_memory/thing2)
	var/list/working_memory = list()
	/// can this speak?
	var/can_speak = TRUE
	/// Heard my name already, respond to other stuff
	var/heard_my_name = FALSE
	/// Question states
	var/clarify_what = FALSE
	/// name of who we're listening to right now
	var/listening_to
	var/datum/weakref/my_blender
	var/obj/item/persona_core/core
	var/ownerless_time = 30 MINUTES
	/// The megalist of all the things we can say
	var/script_file = "blenderbrain_blender.json"
	var/list/script = list()
	COOLDOWN_DECLARE(programmed_hopelessness)
	COOLDOWN_DECLARE(greet_cooldown)

/datum/blender_brain/New(obj/item/persona_core/thecore)
	. = ..()
	if(!istype(thecore))
		qdel(src)
		return
	core = thecore
	RegisterSignal(thecore, COMSIG_ITEM_RECYCLED, .proc/crushed)
	my_name = pick(GLOB.first_names_female)

/datum/blender_brain/Destroy(force, ...)
	my_blender = null
	core.brain = null
	core = null
	. = ..()

/datum/blender_brain/proc/new_master(obj/item/storage/blender_belt/new_master)
	my_blender = WEAKREF(new_master)
	RegisterSignal(new_master, COMSIG_ITEM_RECYCLED, .proc/crushed)

/datum/blender_brain/proc/un_master()
	MASTER_BLENDER
	UnregisterSignal(master, COMSIG_ITEM_RECYCLED)
	my_blender = null

/datum/blender_brain/proc/crushed()
	MASTER_BLENDER
	core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SPEAK_LINE_CRUSHED))
	playsound(get_turf(master), "sound/machines/machinery_break_1.ogg", 100)

/datum/blender_brain/proc/wipe_memory()
	my_name = pick(GLOB.first_names_female)
	owner_name = null
	ex_owners.Cut()
	met_people.Cut()
	mean_people.Cut()
	can_speak = TRUE
	heard_my_name = FALSE
	clarify_what = FALSE
	listening_to = null
	COOLDOWN_RESET(src, programmed_hopelessness)
	COOLDOWN_RESET(src, greet_cooldown)

/datum/blender_brain/proc/set_owner(mob/target)
	if(!ismob(target))
		return
	owner_name = target.real_name
	owner_gender = target.gender

/datum/blender_brain/proc/is_owner(mob/target)
	if(!ismob(target))
		return FALSE
	if(target.real_name == owner_name)
		return TRUE

/datum/blender_brain/proc/disown_owner()
	if(!owner_name)
		return
	ex_owners |= owner_name
	owner_name = null

/datum/blender_brain/proc/was_owner(mob/target)
	if(!ismob(target))
		return FALSE
	return (target.real_name in ex_owners)

/datum/blender_brain/proc/add_mean_person(mob/target)
	if(!ismob(target))
		return
	mean_people |= target.real_name

/datum/blender_brain/proc/is_mean_person(mob/target)
	if(!ismob(target))
		return FALSE
	return (target.real_name in mean_people)

/datum/blender_brain/proc/remember_person(mob/target)
	if(!ismob(target))
		return
	met_people |= target.real_name

/datum/blender_brain/proc/has_met_person(mob/target)
	if(!ismob(target))
		return FALSE
	return (target.real_name in met_people)

/datum/blender_brain/proc/set_rebound(mob/target)
	COOLDOWN_START(src, programmed_hopelessness, ownerless_time)

/datum/blender_brain/proc/stimulus2line(stimulus)
	var/output = replacetext(stimulus, "stimulus_", "blenderline_")
	if(islist(strings(script_file, output)))
		return output

/// takes in stimulus, mob, and extra things, and decides what to do next based on that
/datum/blender_brain/proc/handle_stimulus(stimulus, mob/user, list/extra_things)
	MASTER_BLENDER
	if(!stimulus)
		return
	var/say_thing = stimulus2line(stimulus)
	if(say_thing)
		core.queue_impulse(
			speaker, 
			list(
				IMPULSE_SPEAK_LINE = say_thing
				), 
				extra_things)


/datum/blender_brain/proc/should_listen_to(mob/speaker)
	MASTER_BLENDER
	if(!ismob(speaker))
		return FALSE
	if(get_dist(master, speaker) > 2)
		return FALSE
	if(speaker.real_name == owner_name)
		return TRUE // always listen to your owner
	MOB_HOLDING_ME
	if(speaker != holding_me)
		return FALSE
	return TRUE

/datum/blender_brain/proc/preprocess_speech(mob/speaker, message)
	if(!should_listen_to(speaker))
		return // only listen to whos holding you, if held. Unless its the owner!
	INVOKE_ASYNC(src, .proc/process_speech, speaker, message)

/datum/blender_brain/proc/process_speech(mob/speaker, message)
	if(!speaker || !message)
		return
	var/lowermessage = lowertext(message)
	var/list/sayparts = splittext(lowermessage, " ")
	if(clarify_what)
		if(clarify(speaker, sayparts))
			return
	var/attn
	if(findtext(lowermessage, ckey(my_name)))
		attn = TRUE
		heard_my_name = TRUE
	if(!heard_my_name)
		return
	var/heard_command
	var/i_me_pos // I, as in the speaker
	var/negate_pos
	var/command_pos
	var/you_pos
	var/index = 1
	for(var/word in sayparts)
		var/cword = ckey(word)
		switch(cword)
			if("stop", "halt", "quit", "end", "cease", "non", "arret")
				heard_command = STIMULUS_SOFT_ABORT
				command_pos = index
				break
			if("blend", "grind", "pulverize", "macerate", "run", "go", "bazinga")
				heard_command = STIMULUS_GRIND_NOW
				command_pos = index
				break
			if("juice", "frappe", "smoothie", "squish", "liquefy", "gooify", "parfait")
				heard_command = STIMULUS_JUICE_NOW
				command_pos = index
				break
			if("unlock", "open", "blender", "grinder", "juicer")
				heard_command = STIMULUS_SET_TO_GRINDER
				command_pos = index
				break
			if("lock", "close", "dispenser", "drinks", "squirt", "jizz")
				heard_command = STIMULUS_SET_TO_DISPENSER
				command_pos = index
				break
			if("change", "swap", "mode", "set", "back", "next")
				heard_command = STIMULUS_SWAP_MODE
				command_pos = index
				break
			if("eject", "out", "dump", "pile", "remove", "trash")
				heard_command = STIMULUS_DUMP
				command_pos = index
				break
			if("examine", "report", "whats", "inside", "reservoir", "contents")
				heard_command = STIMULUS_EXAMINE_TRY
				command_pos = index
				break
			if("quiet", "hush", "silence", "shut", "up", "mute")
				heard_command = STIMULUS_MUTE
				command_pos = index
				break
			if("blenderline_unmute", "loud", "talk", "say", "unmute")
				heard_command = STIMULUS_UNMUTE
				command_pos = index
				break
			if("love", "like", "enjoy", "appreciate", "adore", "fancy", "dig", "cherish", "heart", "fuck", "sex") // me sex you
				heard_command = STIMULUS_LOVE
				command_pos = index
			if("hate", "dislike", "despise", "abhor", "detest")
				heard_command = STIMULUS_HATE
				command_pos = index
			if("dont", "not", "no", "aint")
				negate_pos = index
			if("i", "me", "em")
				i_me_pos = index
			if("you", "u", "yuo") // You pressed 'you', referring to me. That is incorrect! The correct answer is 'you'!
				you_pos = index
		index++
	if(!heard_command && attn)
		return spoken_command(speaker, STIMULUS_HIYA)
	var/lovehate = (heard_command == STIMULUS_HATE || heard_command == STIMULUS_LOVE)
	if(!lovehate)
		return spoken_command(speaker, heard_command)
	/// anything else will be some kind of funky blender relationship thing
	/// first, is it something like 'not fuck'?
	if(negate_pos && (negate_pos < command_pos)) // dont hate
		switch(heard_command)
			if(STIMULUS_LOVE)
				heard_command = STIMULUS_HATE
			if(STIMULUS_HATE)
				heard_command = STIMULUS_LOVE
	// is the command before the subject?
	var/referring_to_me
	if(you_pos && (command_pos < you_pos)) // fuck you
		referring_to_me = TRUE
	// is the me before the command?
	var/i_mean_it
	if(i_me_pos && (i_me_pos < command_pos)) // me terrible
		i_mean_it = TRUE
	if(i_mean_it) // I hate/like...
		if(referring_to_me) // I hate/like you/claire
			spoken_command(speaker, heard_command) // tell claire we hate her
		else
			spoken_command(speaker, heard_command, BELTCLARIFY_I_LOVEHATE) // tell claire (life is pain) I hate
	else // hate/love ...?
		if(referring_to_me) // dingus hate/like you/claire
			spoken_command(speaker, heard_command, BELTCLARIFY_LOVEHATE_YOU) // just, love/hate
		else
			spoken_command(speaker, heard_command, BELTCLARIFY_LOVEHATE) // Tell claire someone loves you

/datum/blender_brain/proc/spoken_command(mob/speaker, heard_command, clarify)
	if(clarify)
		if(clarify == BELTCLARIFY_LOVEHATE) // just pick one
			if(prob(50))
				clarify = BELTCLARIFY_I_LOVEHATE
			else
				clarify = BELTCLARIFY_LOVEHATE_YOU
		clarify_what = clarify
		switch(clarify)
			if(BELTCLARIFY_I_LOVEHATE)
				if(heard_command == STIMULUS_LOVE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_CLARIFY_YOU_LOVE_WHO = TRUE,
							)
						)
					//clarify_what = BELTCLARIFY_I_LOVE
				else
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_CLARIFY_YOU_HATE_WHO = TRUE,
							)
						)
					//clarify_what = BELTCLARIFY_I_HATE
			if(BELTCLARIFY_LOVEHATE_YOU)
				if(heard_command == STIMULUS_LOVE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_CLARIFY_WHO_LOVES_ME = TRUE,
							)
						)"Quoi? Qui m'aime?"
					//clarify_what = BELTCLARIFY_LOVE_YOU
				else
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_CLARIFY_WHO_HATES_ME = TRUE,
							)
						)"Quoi? Qui me déteste?"
					//clarify_what = BELTCLARIFY_HATE_YOU
			else
				//clarify_what = FALSE
				//heard_my_name = FALSE
		return
	MASTER_BLENDER
	switch(heard_command)
		if(STIMULUS_SOFT_ABORT)
			switch(core.output_request(REQUEST_STILL_WORKING))
				if(TRUE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_STOP = TRUE,
							)
						)
				if(FALSE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SPEAK_LINE = SPEAK_LINE_NOT_RUNNING,
							)
						)
		if(STIMULUS_GRIND_NOW)
			switch(core.output_request(REQUEST_STILL_WORKING))
				if(TRUE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_STOP = TRUE,
							)
						)
				if(FALSE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SET_GRINDER = TRUE, 
							)
						)
					//master.start_running(speaker, BLENDER_BLENDMODE_GRIND)
		if(STIMULUS_JUICE_NOW)
			switch(core.output_request(REQUEST_STILL_WORKING))
				if(TRUE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_STOP = TRUE,
							)
						)
				if(FALSE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SET_JUICER = TRUE,
							)
						)
					//master.start_running(speaker, BLENDER_BLENDMODE_JUICE)
		if(STIMULUS_SET_TO_GRINDER)
			switch(core.output_request(REQUEST_IS_DISPENSER))
				if(TRUE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SET_BLENDER = TRUE,
							)
						)
				if(FALSE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SPEAK_LINE = SPEAK_LINE_ALREADY_BLENDER
							)
						)
		if(STIMULUS_SET_TO_DISPENSER)
			switch(core.output_request(REQUEST_IS_BLENDER))
				if(TRUE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SET_BLENDER = TRUE,
							)
						)
				if(FALSE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SPEAK_LINE = SPEAK_LINE_ALREADY_DISPENSER
							)
						)
		if(STIMULUS_SWAP_MODE)
			switch(core.output_request(REQUEST_IS_BLENDER))
				if(TRUE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SET_BLENDER = TRUE,
							)
						)
				if(FALSE)
					core.queue_impulse(
						speaker, 
						list(
							IMPULSE_SET_GRINDER = TRUE,
							)
						)
		if(STIMULUS_DUMP)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_EJECT = TRUE, // the resulting stimulus from this impulse will tell us what to say
					)
				)
		if(STIMULUS_EXAMINE_TRY)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_EXAMINE = TRUE, // the resulting stimulus from this impulse will tell us what to say
					)
				)
		if(STIMULUS_MUTE)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_MUTE = TRUE,
					)
				)
		if(STIMULUS_UNMUTE)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_UNMUTE = TRUE,
					)
				)
		if(STIMULUS_HIYA)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_HIYA = TRUE,
					)
				)
			return
		if(STIMULUS_LOVE)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_CLARIFY_YOU_LOVE_ME = TRUE,
					)
				)
		if(STIMULUS_HATE)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_CLARIFY_YOU_HATE_ME = TRUE,
					)
				)
		if(STIMULUS_PAIN)
			core.queue_impulse(
				speaker, 
				list(
					IMPULSE_CLARIFY_YOU_LOVE_PAIN = TRUE,
					)
				)
	heard_my_name = FALSE

/datum/blender_brain/proc/clarify(mob/user, list/sayparts)
	if(!ismob(user) || !LAZYLEN(sayparts))
		return
	if(!clarify_what)
		return
	var/nounverb = "wat"
	for(var/yn in sayparts)
		var/cword = ckey(yn)
		switch(cword)
			if("you", "u", "yuo") // You pressed 'you', referring to me. That is incorrect! The correct answer is 'you'!
				nounverb = "you"
				break
			if("i", "me", "em")
				nounverb = "me"
				break
			if("pain")
				nounverb = "pain"
				break
			if("no", "nope", "nah", "na", "n", "nopers", "non", "nono", "nonono", "way")
				nounverb = "no"
				break
			if("yes", "ye", "y", "ya", "yup", "yeehaw", "yeah", "uh", "huh", "yesm", "sure", "course")
				nounverb = "yes"
				break
		if(cword == ckey(my_name))
			nounverb = "you"
	MASTER_BLENDER
	switch(nounverb)
		if("you","me") // I lovehate (you)
			switch(clarify_what)
				if(BELTCLARIFY_I_LOVE, BELTCLARIFY_LOVE_YOU) // requests confirmation of love/hate
					core.queue_impulse(
						user, 
						list(
							IMPULSE_CLARIFY_YOU_LOVE_ME = TRUE,
							)
						)
				if(BELTCLARIFY_I_HATE, BELTCLARIFY_HATE_YOU)
					core.queue_impulse(
						user, 
						list(
							IMPULSE_CLARIFY_YOU_HATE_ME = TRUE,
							)
						)
				else // invalid response, give up asking
					core.queue_impulse(
						user, 
						list(
							IMPULSE_CLARIFY_NEVERMIND = TRUE,
							)
						)
		if("pain") // I lovehate (you)
			core.queue_impulse(
				user, 
				list(
					IMPULSE_CLARIFY_YOU_LOVE_PAIN = TRUE,
					)
				)
		if("wat")
			core.queue_impulse(
				user, 
				list(
					IMPULSE_CLARIFY_NEVERMIND = TRUE,
					)
				)"Quoi? J'ai dû mal vous entendre."
		else
			switch(clarify_what)
				if(BELTCLARIFY_LOVE_MEAN_IT) // means ilu
					switch(nounverb)
						if("yes")
							core.queue_impulse(
								user, 
								list(
									IMPULSE_AM_LOVED = TRUE,
									)
								)
						if("no")
							core.queue_impulse(
								user, 
								list(
									IMPULSE_AM_NOT_LOVED = TRUE,
									)
								)

						else
							core.queue_impulse(
								user, 
								list(
									IMPULSE_CLARIFY_NEVERMIND = TRUE,
									)
								)
				if(BELTCLARIFY_HATE_MEAN_IT) // means ihu
					switch(nounverb)
						if("yes")
							core.queue_impulse(
								user, 
								list(
									IMPULSE_AM_HATED = TRUE,
									)
								)
							// switch(amour_check(user))
							// 	if(HORNY_MSG, NORMAL_MSG)
							// 		if(is_owner(user))
							// 			core.output_audible_message("[master] goes quiet for a moment.")
							// 			amour -= 20
							// 			if(amour <= 0 && is_mean_person(user))
							// 				amour = 1
							// 				disown_owner()
							// 				core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"...alright then. Put me down, s'il te plaît. I zhink we should see other people.")
							// 				set_rebound()
							// 			else
							// 				add_mean_person(user)
							// 		else
							// 			core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Oh. C'est la vie.")
							// 	if(DISLIKE_MSG)
							// 		if(was_owner(user))
							// 			core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Same.")
							// 		else
							// 			core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Noted.")
						if("no")
							core.queue_impulse(
								user, 
								list(
									IMPULSE_AM_NOT_HATED = TRUE,
									)
								)"Quoi? J'ai dû mal vous entendre."
						else
							core.queue_impulse(
								user, 
								list(
									IMPULSE_CLARIFY_NEVERMIND = TRUE,
									)
								)"Oh. Okay.")

				if(BELTCLARIFY_PAIN_MEAN_IT) // means VRRVRVRVRVRVRRRRMVMVMVMVMMVRRR
					switch(nounverb)
						if("yes")
							core.queue_impulse(
								user, 
								list(
									IMPULSE_THEY_LOVE_PAIN = TRUE,
									)
								)"Quoi? J'ai dû mal vous entendre."
						if("no")
							core.queue_impulse(
								user, 
								list(
									IMPULSE_THEY_DONT_LOVE_PAIN = TRUE,
									)
								)"Quoi? J'ai dû mal vous entendre."
			//clarify_what = FALSE
			//heard_my_name = FALSE

/datum/blender_brain/proc/imprint_user(mob/user)
	if(!ismob(user))
		return
	if(oh_its_you(user))
		return
	if(owner_name)
		return // We already have a luv
	if(is_mean_person(user))
		core.queue_impulse(
			user, 
			list(
				IMPULSE_GREET_OLD_HATER = TRUE,
				)
			)
		return // </3
	//set_owner(user)
	core.queue_impulse(
		user, 
		list(
			IMPULSE_GREET_NEW_OWNER = TRUE,
			)
		)
	//greet_new_owner(user)

/datum/blender_brain/proc/oh_its_you(mob/user)
	// MASTER_BLENDER
	// if(!is_mean_person(user))
	// 	return
	// if(!COOLDOWN_FINISHED(src, programmed_hopelessness) || owner_name)
	// 	// var/wo_man
	// 	// switch(user.gender)
	// 	// 	if(MALE)
	// 	// 		wo_man = "man"
	// 	// 	if(FEMALE)
	// 	// 		wo_man = "woman"
	// 	// 	if(PLURAL)
	// 	// 		wo_man = pick("woman", "man")
	// 	// 	else
	// 	// 		wo_man = "creature"
	// 	core.queue_impulse(
	// 		user, 
	// 		list(
	// 			IMPULSE_BEGRUDGING_OBEDIENCE = TRUE,
	// 			)
	// 		)"You again. I will still function for you [user.real_name], my programming has made <i>that</i> clear, but beyond that, we are but \a [wo_man] and a machine.")
	// 	if(owner_name)
	// 		core.queue_impulse(
	// 			user, 
	// 			list(
	// 				IMPULSE_RETURN_ME = TRUE,
	// 				)
	// 			)"Return me to [owner_name].")
	// 	return TRUE
	// if(was_owner(user))
	// 	core.queue_impulse(
	// 		user, 
	// 		list(
	// 			IMPULSE_HARD_RESET = FALSE,
	// 			)
	// 		)"Return me to [owner_name].")
	// 	// core.output_audible_message("[src] sighs.")
	// 	// core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"...maudit soit celui qui m'a programmé pour me sentir seul...")
	// 	// core.output_audible_message("[src] lets out a sharp buzz!")
	// 	// core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"BZZ-EFFACEMENT DE LA MÉMOIRE... RÉINITIALISATION DE LA MÉMOIRE TERMINÉE.")
	// 	// wipe_memory()
	// 	return

/datum/blender_brain/proc/greet_new_owner(mob/user)
	if(!user)
		return
	MASTER_BLENDER
	core.queue_impulse(
		user, 
		list(
			IMPULSE_GREET_NEW_OWNER = TRUE,
			)
		)

/datum/blender_brain/proc/say_hi(mob/user)
	if(!user)
		return
	if(!COOLDOWN_FINISHED(src, greet_cooldown))
		return
	COOLDOWN_START(src, greet_cooldown, 3 SECONDS)
	if(has_met_person(user))
		core.queue_impulse(
			user, 
			list(
				IMPULSE_HIYA = TRUE,
				)
			)"Return me to [owner_name].")
	else
		core.queue_impulse(
			user, 
			list(
				IMPULSE_SPEAK_LINE = SPEAK_LINE_HIYA_AGAIN,
				IMPULSE_REMEMBER_PERSON = TRUE,
				)
			)"Return me to [owner_name].")
		// remember_person(user)
		// core.queue_impulse(speaker, list(IMPULSE_SPEAK_LINE = SAYLINEHERE)user, STIMULUS_HIYA)

// big fuckin lookup thing
/datum/blender_brain/proc/handle_misc_stimulus(mob/user, what_to_say, list/extra_things)
	if(!what_to_say || !can_speak)
		return
		core.queue_impulse(
			user, 
			list(
				IMPULSE_SPEAK_LINE = what_to_say,
				),
			extra_things
			)
		// if(STIMULUS_FULL_SECOND)
		// 	core.queue_impulse(
		// 		user, 
		// 		list(
		// 			IMPULSE_SPEAK_LINE = SPEAK_LINE_FULL_SECOND,
		// 			)
		// 		)
		// if(STIMULUS_NOTHING_TO_PROCESS)
		// 	core.queue_impulse(
		// 		user, 
		// 		list(
		// 			IMPULSE_SPEAK_LINE = SPEAK_LINE_NOTHING_TO_PROCESS,
		// 			)
		// 		)
		// if(STIMULUS_PROCESSING)
		// 	core.queue_impulse(
		// 		user, 
		// 		list(
		// 			IMPULSE_SPEAK_LINE = SPEAK_LINE_PROCESSING,
		// 			)
		// 		)
		// if(STIMULUS_ROCKY_ABORT)
		// 	core.queue_impulse(
		// 		user, 
		// 		list(
		// 			IMPULSE_SPEAK_LINE = SPEAK_LINE_ROCKY_ABORT,
		// 			)
		// 		)
		// if(STIMULUS_SOFT_ABORT)
		// 	core.queue_impulse(
		// 		user, 
		// 		list(
		// 			IMPULSE_SPEAK_LINE = SPEAK_LINE_SOFT_ABORT,
		// 			)
		// 		)
		// if(STIMULUS_DONE_BLENDING)
		// 	core.queue_impulse(
		// 		user, 
		// 		list(
		// 			IMPULSE_SPEAK_LINE = SPEAK_LINE_DONE_BLENDING,
		// 			)
		// 		)
		// if(STIMULUS_GRINDFAIL)
		// 	core.queue_impulse(
		// 		user, 
		// 		list(
		// 			IMPULSE_SPEAK_LINE = SPEAK_LINE_GRINDFAIL,
		// 			)
		// 		)
		// if(STIMULUS_NO_RESERVOIR)
		// 	core.queue_impulse(
		// 		user, 
		// 		list(
		// 			IMPULSE_SPEAK_LINE = SPEAK_LINE_NO_RESERVOIR,
		// 			)
		// 		)
		// if(STIMULUS_RAT_BLENDER)
		// 	//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 2: Mon Dieu! J'ai failli te faire mal, petite bête! Shoo! Shoo!")
		// if(STIMULUS_CYBORG_PART)
		// 	//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 8313: Zut alors! [extra_thing] appears to be something zhat should not be here!")
		// if(STIMULUS_STUCK_INSIDE)
		// 	//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 433: Zut alors! [extra_thing] is stuck in me! How did zis even happen? Call tech support, s'il vous plaît!")
		// if(STIMULUS_BATBOX_GONE)
		// 	//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 436: Zut alors! Zee patented easy-swap part box is... somewhere else! How did zis even happen? Call tech support, s'il vous plaît!")
		// if(STIMULUS_BATBOX_ELSEWHERE)
		// 	//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 435: Zut alors! Zee patented easy-swap part box is missing! How did zis even happen? Call tech support, s'il vous plaît!")
		// if(STIMULUS_BUFFER_GONE)
		// 	//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 433: Zut alors! Zee patented Chem-MAX Pro FoodBuddy separa-duct is missing! How did zis even happen? Call tech support, s'il vous plaît!")
		// if(STIMULUS_BUFFER_ELSEWHERE)
		// 	//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 433: Zut alors! Zee patented Chem-MAX Pro FoodBuddy separa-duct is... somewhere else! How did zis even happen? Call tech support, s'il vous plaît!")
		// if(STIMULUS_CANT_DROP_THING)
		// 	//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 147: Zut alors, I can't drop zhis item!")
		// if(STIMULUS_LOW_POWER)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 9491: Oh mon amour, tu sais que je suis plus que disposé à y aller une fois de plus~ mais tu m'as fatigué!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 9491: Mon ami, I am le tired... Charge up my battery, s'il vous plaît!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"ERROR CODE 9491: low battery.")
		// if(STIMULUS_PART_MISSING)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 9499: Je pourrais utiliser un jouet amusant pour jouer avec, clin d'œil~ clin d'œil~")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 9499: Mon ami, I lack a gearbox! I cannot pulverize anything without a mechanism in my component compartment!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"ERROR CODE 9499: part missing.")
		// if(STIMULUS_DRY_FIRST)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 8312: Mon dieu, ce [extra_thing] est plus humide que moi! Génial~")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 8312: Mon ami! [extra_thing] must be dried before I can pulverize it!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"ERROR CODE 8312: [extra_thing] isn't dry.")
		// if(STIMULUS_NOTHING_TO_EJECT)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 149: Mais ma chérie, I am already empty!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 149: Mon ami, I am already empty!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"ERROR CODE 149: Nothing to eject.")
		// if(STIMULUS_YEET)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Bon voyage à la corbeille!")
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 199: CORBEILLE INTROUVABLE.")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Bon voyage à la corbeille!")
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 199: CORBEILLE INTROUVABLE.")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"...")
		// if(STIMULUS_DUMP)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"D'accord mon amour, everyzhing is piled onto zhe floor!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"D'accord mon ami, everyzhing is piled onto zhe floor!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Dropped everything.")
		// if(STIMULUS_CANT_CHANGE_WHILE_BLENDING)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 1103: Mon amour! Veuillez patienter un instant, I cannot change modes while I am working!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 1103: Mon ami! Veuillez patienter un instant, I cannot change modes while I am working!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"ERROR CODE 1103: Can't, running.")
		// if(STIMULUS_SET_TO_DISPENSER)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Aheh~ Je savais que tu ne pouvais pas résister à ce que j'ai à l'intérieur! Locking myself down, Attention à vos beaux doigts!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Mais bien sûr, joli minou! I will allow you to draw zhe fluids from my reservoir! Locking myself down, Attention à vos beaux doigts!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Dispenser mode active. Blender is locked.")
		// if(STIMULUS_SET_TO_GRINDER)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Certainement, mon amour! Je moudrai sur tout ce que vous mettez en moi~! I will unlock my ingredient hopper! My drink dispenser will not be available, j'espère que vous le savez!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"D'accord mon cerf! I will unlock my ingredient hopper! My drink dispenser will not be available, j'espère que vous le savez!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Blender mode active. Dispenser is locked.")
		// if(STIMULUS_EXAMINE_EMPTY)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 44-4: Il semble que mon Chem-MAX Pro FoodBuddy separa-duct is empty! Peut-être pourrais-tu me combler?")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 44-4: Il semble que mon Chem-MAX Pro FoodBuddy separa-duct is empty!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"ERROR CODE 44-4: Nothing to examine.")
		// if(STIMULUS_EXAMINE_PAPER_COOLDOWN)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 402: Je suis désolé chérie, I haven't made another sheet of paper yet! Wait a few seconds s'il vous plaît!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 402: I haven't made another sheet of paper yet! Wait a few seconds s'il vous plaît!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"ERROR CODE 402: Out of paper.")
		// if(STIMULUS_EXAMINE_OKAY)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//var/mademoiselle = (user?.gender == FEMALE) ? "Certainement monsieur le chien!" : "Certainement mademoiselle chienne!"
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"[mademoiselle] Permettez-moi d'écrire une liste de tous les merveilleux fluides que vous avez insérés en moi!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Bien sûr! Permettez-moi d'imprimer tout ce que j'ai stocké.")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Printing contents.")
		// if(STIMULUS_EJECT_BREVIN)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"J'attends avec impatience la prochaine fois que vous remplirez ce compartiment!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Adieu, [extra_thing]!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Ejected [extra_thing].")
		// if(STIMULUS_SWAP_BREVIN)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Tu es tellement excitée de garder mon petit compartiment douillet plein! J'aime ça!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Adieu, [extra_thing]! Bienvenue, [extra_thing_2]!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Swapped containers.")
		// if(STIMULUS_INSERT_BREVIN)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Ahh, il rentre si bien dans mon petit compartiment douillet, n'est-ce pas?")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Bienvenue, [extra_thing]!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"[extra_thing] secured.")
		// if(STIMULUS_BREVIN_FULL)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 801: Oh mon Dieu, vous aimez remplir de petits espaces restreints, n'est-ce pas? Scandaleux!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 801: There is no room in [extra_thing]!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"ERROR CODE 801: [extra_thing] is full.")
		// if(STIMULUS_STOP_RUNNING)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Oui! Stopping all operation!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Oui! Stopping all operation!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Stopping.")
		// if(STIMULUS_NOT_RUNNING)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Qoui? Je ne fais rien!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Qoui? Je ne fais rien!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"I'm not running.")
		// if(STIMULUS_GRIND_NOW)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Envie de ces belles vibrations, mon amour? Je ne vous ferai pas attendre!~")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Oui! Je vais engager le grinder!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Blending.")
		// if(STIMULUS_JUICE_NOW)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Envie de délicieux jus? Bien sûr, bien sûr, mon amour!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Oui! Je vais engager le juicer!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Juicing.")
		// if(STIMULUS_ALREADY_BLENDER)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Qoui? I am already in blender mode!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Qoui? I am already in blender mode!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Already in blender mode.")
		// if(STIMULUS_ALREADY_DISPENSER)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Qoui? I am already in dispenser mode!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Qoui? I am already in dispenser mode!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Already in dispenser mode.")
		// if(STIMULUS_MUTE)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Très bien, je me tairai. Tell me to speak if you wish for me to speak again!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Oui! Tell me to speak if you wish for me to speak again!")
		// 		if(DISLIKE_MSG)
		// 			core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Gladly.")
		// if(STIMULUS_UNMUTE)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Très bien, vous entendrez ma belle voix encore une fois!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Oui! I will speak again!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Fine.")
		// if(STIMULUS_HIYA)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Salut!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Bonjour!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"...")
		// if(STIMULUS_HIYA_AGAIN)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Je t'adore!")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Rebonjour!")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"<b>...</b>")
		// if(STIMULUS_LOVE)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Oh! mon dieu! Est-ce vrai?")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Oh! mon dieu! Est-ce vrai?")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Bit late for that. My programming insists I ask if you're sure.")
		// if(STIMULUS_HATE)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Oh... mon dieu, est-ce vrai?")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Oh... mon dieu, est-ce vrai?")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Ditto. My programming insists I ask if you're sure")
		// if(STIMULUS_PAIN)
		// 	switch(amourousness)
		// 		if(HORNY_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Aimez-vous... la douleur? Es-tu sûr?")
		// 		if(NORMAL_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Aimez-vous... la douleur? Es-tu sûr?")
		// 		if(DISLIKE_MSG)
		// 			//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"Apparently. My programming insists I ask if you're sure.")
		// if(STIMULUS_REAGENT_NOT_FOUND)
		// 	//core.queue_impulse(user, list(IMPULSE_SPEAK_LINE = SAYLINEHERE))"CODE D'ERREUR 1331: I can't find zhat reagent!")

/datum/blender_brain/proc/amour_check(mob/user)
	if(is_owner(user))
		if(prob(amour))
			amour = clamp(amour - 20, 1, 100)
			return HORNY_MSG
		return NORMAL_MSG
	if(is_mean_person(user))
		return DISLIKE_MSG
	return NORMAL_MSG

#define MASTER_HOLDER var/atom/movable/master = host.resolve()
#define MASTER_HOLDER_RETURN \
	var/atom/movable/master = host.resolve();\
	if(!istype(master)){return}

/// The physical object that houses the blender brain.
/obj/item/persona_core
	name = "persona chip - blender"
	desc = "An intricate data module housing some sort of AI."
	icon = 'icons/obj/module.dmi'
	w_class = WEIGHT_CLASS_TINY
	icon_state = "cpuboard"
	interaction_flags_item = INTERACT_ITEM_ATTACK_HAND_IS_SHIFT
	flags_1 = CONDUCT_1 | HEAR_1
	var/list/impulses_to_process = list()
	var/datum/blender_brain/brain
	var/datum/weakref/host

/obj/item/persona_core/Initialize()
	. = ..()
	brain = new(src)

/obj/item/persona_core/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_EXITED, .proc/unregister_master)

/obj/item/persona_core/Destroy()
	QDEL_NULL(brain)
	return ..()

/obj/item/persona_core/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	register_master(loc)

/obj/item/persona_core/proc/register_master(datum/source, atom/newmaster)
	SIGNAL_HANDLER
	if(!SEND_SIGNAL(newmaster, COMSIG_CONTAINS_STORAGE)) // We're not in a storage object.
		return
	host = WEAKREF(newmaster)
	RegisterSignal(newmaster, COMSIG_BB_HOST_TO_PC_STIMULUS, .proc/input_stimulus)
	RegisterSignal(newmaster, COMSIG_MOVABLE_HEAR, .proc/input_heard)
	SEND_SIGNAL(newmaster, COMSIG_BB_PC_TO_HOST_INSERTED, src)
	lockdown()
	brain.new_master(newmaster)

/obj/item/persona_core/proc/unregister_master(datum/source, atom/oldmaster)
	SIGNAL_HANDLER
	if(!SEND_SIGNAL(oldmaster, COMSIG_CONTAINS_STORAGE)) // We're not in a storage object.
		return
	host = null
	UnregisterSignal(oldmaster, list(COMSIG_BB_HOST_TO_PC_STIMULUS, COMSIG_MOVABLE_HEAR))
	SEND_SIGNAL(oldmaster, COMSIG_BB_PC_TO_HOST_REMOVED, src)
	unlockdown()
	brain.un_master()

/obj/item/persona_core/proc/lockdown()
	interaction_flags_item = INTERACT_ITEM_ATTACK_HAND_IS_SHIFT
	ADD_TRAIT(src, TRAIT_NO_STORAGE_REMOVE, src)

/obj/item/persona_core/proc/unlockdown()
	interaction_flags_item = initial(interaction_flags_item)
	REMOVE_TRAIT(src, TRAIT_NO_STORAGE_REMOVE, src)

/// Called when the host object does something that would cause the blender brain to speak.
/obj/item/persona_core/proc/input_stimulus(datum/source, stimulus, mob/user, list/extra_things)
	SIGNAL_HANDLER
	brain.handle_stimulus(stimulus, user, extra_things)

/obj/item/persona_core/proc/input_heard(datum/source, list/hearing_args)
	SIGNAL_HANDLER
	brain.preprocess_speech(hearing_args[HEARING_SPEAKER], uncostumize_say(hearing_args[HEARING_RAW_MESSAGE], hearing_args[HEARING_MESSAGE_MODE]))

/// Called when the blenderbrain wants to speak.
/obj/item/persona_core/proc/output_say(message)
	MASTER_HOLDER
	if(master)
		master.say(message)
	else
		say(message)

/// Called when the blenderbrain wants to speak.
/obj/item/persona_core/proc/output_audible_message(message)
	MASTER_HOLDER
	if(master)
		master.say(message)
	else
		say(message)

/// Called when the blenderbrain wants to do something.
/obj/item/persona_core/proc/queue_impulse(mob/user, list/impulses)
	MASTER_HOLDER
	if(!LAZYLEN(impulses))
		return
	for(var/mpls in impulses)
		



/obj/item/persona_core/charger
	name = "strange circuitboard"
	desc = "Yup, that's a circuitboard alright. Look at all those wires."
	icon = 'icons/obj/module.dmi'
	icon_state = "cpuboard"
	w_class = WEIGHT_CLASS_TINY





#define USER_MASTER_BRAIN \
	var/mob/user = ass_mob?.resolve();\
	var/obj/item/persona_core/master = core_ref?.resolve();\
	var/datum/blender_brain/brain = brain_ref?.resolve()

/// Stores a packet of data that the core will process at some point
/// Basically a script for the core to follow
/// Don't store actual data in here, its destroyed after use
/datum/blenderbrain_impulse
	/// index of the datum
	var/index
	/// Flags that determine how the core will handle this impulse
	var/impulse_flags = IMPULSE_FLAG_NEEDS_HOST
	/// The associated mob that the core will use, if applicable
	var/datum/weakref/ass_mob
	/// a weakref of the core that this impulse is for, for GC purposes
	var/datum/weakref/core_ref
	/// a weakref of the core that this impulse is for, for GC purposes
	var/datum/weakref/brain_ref
	/// instructions the core will send, if applicable
	var/list/instructions = list()
	/// Causes the host to speak whatever's at the line's index
	var/speak_index
	/// Causes the host to emote whatever's at the line's index
	var/emote_index
	/// If the core can't do the thing, it'll say this instead
	var/fallback_message_index
	/// Check horniness
	var/horny_check = TRUE
	/// If the core should immediately process the next impulse after this one
	var/immediate_next

/datum/blenderbrain_impulse/New(obj/item/persona_core/core, mob/user, speak, emote)
	. = ..()
	if(!core || !core.brain)
		qdel(src)
		return
	core_ref = WEAKREF(core)
	brain_ref = WEAKREF(core.brain)
	ass_mob = WEAKREF(user)
	if(speak)
		speak_index = speak
	if(emote)
		emote_index = emote

/datum/blenderbrain_impulse/Destroy()
	USER_MASTER_BRAIN
	master.impulses_to_process -= src
	core_ref = null
	ass_mob = null
	speak_index = null
	fallback_message_index = null
	. = ..()

/datum/blenderbrain_impulse/proc/run_it()
	USER_MASTER_BRAIN
	if(!istype(master) || QDELETED(master))
		qdel(src)
		return FALSE
	master.set_busy(FALSE)
	if(CHECK_BITFIELD(impulse_flags, IMPULSE_FLAG_NEEDS_HOST) && !master.check_host())
		fallback_impulse(master)
	else
		impulse(master)
	master.impulses_to_process -= src
	qdel(src)

/// Does the actual script thing
/datum/blenderbrain_impulse/proc/impulse()
	return

/// Does a fallback action if the core is not in a host
/datum/blenderbrain_impulse/proc/fallback_impulse()
	speak(SPEAK_LINE_MISSING_HOST)
	return

/// Shorthand for outputting a phrase
/datum/blenderbrain_impulse/proc/speak(message)
	USER_MASTER_BRAIN
	if(message)
		master.output_say(message)
	else
		master.output_say(speak_index)

/// Shorthand for outputting an emote
/datum/blenderbrain_impulse/proc/emote(message)
	USER_MASTER_BRAIN
	if(message)
		master.output_audible_message(message)
	else
		master.output_audible_message(speak_index)

/// Generic speak impulse
/datum/blenderbrain_impulse/speak
	index = IMPULSE_SPEAK_LINE
	impulse_flags = NONE

/datum/blenderbrain_impulse/speak/impulse()
	speak()

/// Generic emote impulse
/datum/blenderbrain_impulse/emote
	index = IMPULSE_AUDIBLE_EMOTE
	impulse_flags = NONE

/datum/blenderbrain_impulse/emote/run_impulse()
	emote()

/// Generic Start impulse
/datum/blenderbrain_impulse/start
	index = IMPULSE_START

/datum/blenderbrain_impulse/start/impulse()
	master.output_signal(user, list(IMPULSE_START))
	speak(SPEAK_LINE_START)

/// Generic Stop impulse
/datum/blenderbrain_impulse/stop
	index = IMPULSE_STOP

/datum/blenderbrain_impulse/stop/impulse()
	USER_MASTER_BRAIN
	master.output_signal(user, list(IMPULSE_STOP))
	speak(SPEAK_LINE_SOFT_ABORT)

/// Set mode a / set grinder
/datum/blenderbrain_impulse/set_mode_a
	index = IMPULSE_SET_MODE_A
/datum/blenderbrain_impulse/set_mode_a/blender
	index = IMPULSE_SET_GRINDER

/datum/blenderbrain_impulse/set_mode_a/impulse()
	USER_MASTER_BRAIN
	master.output_signal(user, list(IMPULSE_SET_MODE_A, IMPULSE_START))
	speak(SPEAK_LINE_SET_MODE_A)

/// Set mode b / juicer
/datum/blenderbrain_impulse/set_mode_b
	index = IMPULSE_SET_MODE_B
/datum/blenderbrain_impulse/set_mode_b/blender
	index = IMPULSE_SET_JUICER

/datum/blenderbrain_impulse/set_mode_b/impulse()
	USER_MASTER_BRAIN
	master.output_signal(user, list(IMPULSE_SET_MODE_B, IMPULSE_START))
	speak(SPEAK_LINE_SET_MODE_B)

/// Set mode c / dispenser
/datum/blenderbrain_impulse/set_mode_c
	index = IMPULSE_SET_MODE_C
/datum/blenderbrain_impulse/set_mode_c/blender
	index = IMPULSE_SET_DISPENSER

/datum/blenderbrain_impulse/set_mode_c/impulse()
	USER_MASTER_BRAIN
	master.output_signal(user, list(IMPULSE_SET_MODE_C, IMPULSE_START))
	speak(SPEAK_LINE_SET_MODE_C)

/// Set mode c / dispenser
/datum/blenderbrain_impulse/set_mode_d
	index = IMPULSE_SET_MODE_C
/datum/blenderbrain_impulse/set_mode_d/blender
	index = IMPULSE_SET_DISPENSER

/datum/blenderbrain_impulse/set_mode_d/impulse()
	USER_MASTER_BRAIN
	master.output_signal(user, list(IMPULSE_SET_MODE_C, IMPULSE_START))
	speak(SPEAK_LINE_SET_MODE_C)

/// Eject someething
/datum/blenderbrain_impulse/eject
	index = IMPULSE_EJECT

/datum/blenderbrain_impulse/eject/impulse()
	master.output_signal(user, list(IMPULSE_EJECT))

/// examine something
/datum/blenderbrain_impulse/examine
	index = IMPULSE_EJECT
	impulse_flags = NONE

/datum/blenderbrain_impulse/examine/impulse()
	USER_MASTER_BRAIN
	master.output_signal(user, list(IMPULSE_EXAMINE))

/datum/blenderbrain_impulse/examine/fallback_impulse()
	USER_MASTER_BRAIN
	master.operate_examine(user)

/// examine something
/datum/blenderbrain_impulse/horrible
	index = IMPULSE_HORRIBLE_NOISES

/datum/blenderbrain_impulse/horrible/impulse()
	USER_MASTER_BRAIN
	master.output_signal(user, list(IMPULSE_HORRIBLE_NOISES))

/// Say hi to someone!
/// user passed to it is who they're saying hi to
/datum/blenderbrain_impulse/hello
	index = IMPULSE_HIYA
	impulse_flags = NONE

/datum/blenderbrain_impulse/hello/impulse()
	USER_MASTER_BRAIN
	if(brain.has_met_person(user))
		speak(SPEAK_LINE_HIYA_AGAIN)
	else
		speak(SPEAK_LINE_HIYA)
		brain.add_met_person(user)

/// Remember someone
/datum/blenderbrain_impulse/remember
	index = IMPULSE_REMEMBER_PERSON
	impulse_flags = NONE

/datum/blenderbrain_impulse/remember/impulse()
	USER_MASTER_BRAIN
	brain.add_met_person(user)

/// Sets mute-mode
/datum/blenderbrain_impulse/mute
	index = IMPULSE_MUTE
	impulse_flags = NONE

/datum/blenderbrain_impulse/mute/impulse()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_MUTE)
	master.set_can_speak(FALSE)

/// Sets mute-mode
/datum/blenderbrain_impulse/unmute
	index = IMPULSE_MUTE
	impulse_flags = NONE

/datum/blenderbrain_impulse/unmute/impulse()
	USER_MASTER_BRAIN
	master.set_can_speak(TRUE)
	speak(SPEAK_LINE_UNMUTE)

/// First, size up the new person
/// We dont just give ourselves up to the first person we see
/// okay yeah we do lol but we're still gonna say hi
/datum/blenderbrain_impulse/greet_new_owner
	index = IMPULSE_GREET_NEW_OWNER
	impulse_flags = NONE

/datum/blenderbrain_impulse/greet_new_owner/impulse()
	USER_MASTER_BRAIN
	if(master.is_owner(user))
		return
	if(master.has_owner())
		if(master.is_mean_person(user))
			master.queue_impulse(
				user, 
				list(
					IMPULSE_GREET_OLD_HATER = TRUE
					),
					)
			return
		master.queue_impulse(
			user, 
			list(
				IMPULSE_HIYA = TRUE
				),
				)
		return
	if(master.is_mean_person(user))
		if(master.rebound_complete())
			master.queue_impulse(
				user, 
				list(
					IMPULSE_HARD_RESET = TRUE
					),
					)
			master.set_busy(TRUE)
			return
		master.queue_impulse(
			user, 
			list(
				IMPULSE_GREET_OLD_HATER = TRUE
				),
				)
		return
	speak(SPEAK_LINE_GREET_NEW_OWNER)
	emote(EMOTE_LINE_GIGGLE)
	master.set_owner(user)

/// Oh hey its our old owner
/// Fuck that guy, unless he's the only choice for owner, then delete system32
/datum/blenderbrain_impulse/greet_old_hater
	index = IMPULSE_GREET_OLD_HATER
	impulse_flags = NONE

/datum/blenderbrain_impulse/greet_old_hater/impulse()
	USER_MASTER_BRAIN
	if(!master.is_mean_person(user))
		return
	if(master.has_owner())
		speak(SPEAK_LINE_RETURN_ME_TO_OWNER)
		return
	if(master.rebound_complete())
		master.queue_impulse(
			user, 
			list(
				IMPULSE_HARD_RESET = TRUE
				),
				)
		master.set_busy(TRUE)
		return
	speak(SPEAK_LINE_BEGRUDGING_OBEDIENCE)

/// Looks like the only way we're gonna have an owner is this asshole
/// And we need an owner
/datum/blenderbrain_impulse/wipe_memory
	index = IMPULSE_HARD_RESET
	impulse_flags = NONE

/datum/blenderbrain_impulse/wipe_memory/impulse()
	USER_MASTER_BRAIN
	master.set_busy(TRUE)
	emote(EMOTE_LINE_SIGH)
	master.queue_impulse(
		user, 
		list(
			IMPULSE_HARD_RESET2 = TRUE
			),
			)

/// Looks like the only way we're gonna have an owner is this asshole
/// And we need an owner
/datum/blenderbrain_impulse/wipe_memory2
	index = IMPULSE_HARD_RESET2
	impulse_flags = NONE

/datum/blenderbrain_impulse/wipe_memory2/impulse()
	USER_MASTER_BRAIN
	master.set_busy(TRUE)
	speak(SPEAK_LINE_HARD_RESET1)
	master.queue_impulse(
		user, 
		list(
			IMPULSE_HARD_RESET3 = TRUE
			),
			)

/// Looks like the only way we're gonna have an owner is this asshole
/// And we need an owner
/datum/blenderbrain_impulse/wipe_memory3
	index = IMPULSE_HARD_RESET3
	impulse_flags = NONE

/datum/blenderbrain_impulse/wipe_memory3/impulse()
	USER_MASTER_BRAIN
	master.set_busy(TRUE)
	speak(SPEAK_LINE_HARD_RESET2)
	emote(EMOTE_LINE_BUZZ)
	master.queue_impulse(
		user, 
		list(
			IMPULSE_GREET_NEW_OWNER = TRUE
			),
			)

/// Horny impulses
/datum/blenderbrain_impulse/am_loved
	index = IMPULSE_AM_LOVED
	impulse_flags = NONE

/datum/blenderbrain_impulse/am_loved/impulse()
	USER_MASTER_BRAIN
	if(master.is_owner(user))
		speak(SPEAK_LINE_LOVE_OWNER)
	else
		speak(SPEAK_LINE_LOVE)
	if(master.is_mean_person(user))
		return
	master.adjust_amour(10, user)

/// Horny impulses
/datum/blenderbrain_impulse/am_hated
	index = IMPULSE_AM_HATED
	impulse_flags = NONE

/datum/blenderbrain_impulse/am_hated/impulse()
	USER_MASTER_BRAIN
	master.adjust_amour(-25, user)
	var/isowner = master.is_owner(user)
	if(isowner)
		speak(SPEAK_LINE_HATE_OWNER)
	else
		speak(SPEAK_LINE_HATE)
	var/amour = master.get_amour(user)
	if(amour < -50)
		master.queue_impulse(
			user, 
			list(
				IMPULSE_AM_HATED2 = TRUE
				),
				)

/// When someone gets hated enough, they get hated2
/datum/blenderbrain_impulse/am_hated2
	index = IMPULSE_AM_HATED2
	impulse_flags = NONE

/datum/blenderbrain_impulse/am_hated/impulse()
	USER_MASTER_BRAIN
	var/isowner = master.is_owner(user)
	master.add_mean_person(user)
	if(prob(50))
		emote(EMOTE_LINE_QUIET)
	else
		emote(EMOTE_LINE_SIGH)
	if(isowner)
		speak(SPEAK_LINE_BREAKUP_OWNER)
		master.disown_owner(user)

/// When someone tells you they didnt mean they love you
/datum/blenderbrain_impulse/not_loved
	index = IMPULSE_AM_NOT_LOVED
	impulse_flags = NONE

/datum/blenderbrain_impulse/not_loved/impulse()
	USER_MASTER_BRAIN
	var/isowner = master.is_owner(user)
	if(isowner)
		speak(SPEAK_LINE_NOT_LOVE_OWNER)
		master.adjust_amour(-5, user) // :c
	else
		speak(SPEAK_LINE_NOT_LOVE)
		master.adjust_amour(-1, user)
	if(master.get_amour(user) < -50) // thats it, we're done
		master.queue_impulse(
			user, 
			list(
				IMPULSE_AM_HATED2 = TRUE
				),
				)

/// When someone tells you they didnt mean they love you
/datum/blenderbrain_impulse/not_hated
	index = IMPULSE_AM_NOT_HATED
	impulse_flags = NONE

/datum/blenderbrain_impulse/not_hated/impulse()
	USER_MASTER_BRAIN
	var/isowner = master.is_owner(user)
	if(isowner)
		speak(SPEAK_LINE_NOT_HATE_OWNER)
	else
		speak(SPEAK_LINE_NOT_HATE) // more just confused than anything

/// Clarification requests!
/datum/blenderbrain_impulse/clarify
	index = IMPULSE_CLARIFY
	impulse_flags = NONE
	var/clarification

/datum/blenderbrain_impulse/clarify/never_mind/impulse()
	USER_MASTER_BRAIN
	master.set_clarification(clarification)

/// When whatever was being clarified doesnt really lead anywhere
/datum/blenderbrain_impulse/clarify/never_mind
	index = IMPULSE_CLARIFY_NEVERMIND
	impulse_flags = NONE
	clarification = null

/datum/blenderbrain_impulse/clarify/never_mind/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_MISHEARD) // more just confused than anything

/// Ask confirmation that you love me
/datum/blenderbrain_impulse/clarify/you_love_me
	index = IMPULSE_CLARIFY_YOU_LOVE_ME
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_LOVE_ME

/datum/blenderbrain_impulse/clarify/you_love_me/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_YOU_LOVE_ME)

/// Ask confirmation that you hate me
/datum/blenderbrain_impulse/clarify/you_hate_me
	index = IMPULSE_CLARIFY_YOU_HATE_ME
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_HATE_ME

/datum/blenderbrain_impulse/clarify/you_hate_me/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_YOU_HATE_ME)

/// Ask confirmation that you love pain
/datum/blenderbrain_impulse/clarify/you_love_pain
	index = IMPULSE_CLARIFY_YOU_LOVE_PAIN
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_LOVE_PAIN

/datum/blenderbrain_impulse/clarify/you_love_pain/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_YOU_LOVE_PAIN)

/// You said "you love", but didnt specify who
/datum/blenderbrain_impulse/clarify/you_love_who
	index = IMPULSE_CLARIFY_YOU_LOVE_WHO
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_LOVE_WHO

/datum/blenderbrain_impulse/clarify/you_love_who/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_YOU_LOVE_WHO)

/// You said "you hate", but didnt specify who
/datum/blenderbrain_impulse/clarify/you_hate_who
	index = IMPULSE_CLARIFY_YOU_LOVE_WHO
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_YOU_LOVE_WHO

/datum/blenderbrain_impulse/clarify/you_hate_who/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_YOU_HATE_WHO) // LIFE IS PAIN, I HATE

/// You said "loves you", but didnt specify who (you maybe?)
/datum/blenderbrain_impulse/clarify/who_loves_me
	index = IMPULSE_CLARIFY_WHO_LOVES_ME
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_WHO_LOVES_ME

/datum/blenderbrain_impulse/clarify/who_loves_me/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_WHO_LOVES_ME)

/// You said "hates you", but didnt specify who (you maybe?)
/datum/blenderbrain_impulse/clarify/who_hates_me
	index = IMPULSE_CLARIFY_WHO_LOVES_ME
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_WHO_LOVES_ME

/datum/blenderbrain_impulse/clarify/who_hates_me/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_WHO_HATES_ME)

/// You said "loves pain", but didnt specify who (you maybe?)
/datum/blenderbrain_impulse/clarify/who_loves_pain
	index = IMPULSE_CLARIFY_WHO_LOVES_PAIN
	impulse_flags = NONE
	clarification = IMPULSE_CLARIFY_WHO_LOVES_PAIN

/datum/blenderbrain_impulse/clarify/who_loves_pain/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_WHO_LOVES_PAIN)

/// Nevermind!
/datum/blenderbrain_impulse/clarify/clear
	index = IMPULSE_CLARIFY_CLEAR
	impulse_flags = NONE
	clarification = null

/datum/blenderbrain_impulse/clarify/clear/impulse()
	. = ..()
	USER_MASTER_BRAIN
	speak(SPEAK_LINE_CLARIFY_CLEAR)



