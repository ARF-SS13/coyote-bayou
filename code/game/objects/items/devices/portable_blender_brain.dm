// Handles the internal psychology of a fucking blender
// yeah
// this *used* to be a simple project

// Oh yeah, with this, after this, master will be a var that is the owning blender
#define MASTER_BLENDER \
	var/obj/item/storage/blender_belt/master = my_blender.resolve();\
	if(!istype(master)){return}
#define MOB_HOLDING_ME \
	var/mob/holding_me = ismob(master.loc) ? master.loc : null

#define BELTCOMMAND_STOP 1
#define BELTCOMMAND_GRIND 2
#define BELTCOMMAND_JUICE 3
#define BELTCOMMAND_BLENDER_MODE 4
#define BELTCOMMAND_DISPENSER_MODE 5
#define BELTCOMMAND_SWAP_MODE 6
#define BELTCOMMAND_EJECT 7
#define BELTCOMMAND_EXAMINE 8
#define BELTCOMMAND_HIYA 9
#define BELTCOMMAND_MUTE 10
#define BELTCOMMAND_SPEAK 11
#define BELTCOMMAND_LOVE 12
#define BELTCOMMAND_HATE 13
#define BELTCOMMAND_LOUD_NOISES 14

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
	/// can this speak?
	var/can_speak = TRUE
	/// Heard my name already, respond to other stuff
	var/heard_my_name = FALSE
	/// Question states
	var/clarify_what = FALSE
	/// name of who we're listening to right now
	var/listening_to
	var/datum/weakref/my_blender
	var/datum/weakref/my_brain
	var/ownerless_time = 30 MINUTES
	COOLDOWN_DECLARE(programmed_hopelessness)
	COOLDOWN_DECLARE(greet_cooldown)

/datum/blender_brain/New(obj/item/storage/blender_belt/master)
	. = ..()
	if(istype(master))
		my_blender = WEAKREF(master)
		RegisterSignal(master, COMSIG_ITEM_RECYCLED, .proc/crushed)
	my_name = pick(GLOB.first_names_female)


/datum/blender_brain/Destroy(force, ...)
	my_blender = null
	. = ..()

/datum/blender_brain/proc/crushed()
	MASTER_BLENDER
	blender_say("NO-NO-NO-NO-N-ZSKGH--")
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

/datum/blender_brain/proc/should_listen_to(mob/speaker)
	MASTER_BLENDER
	if(!ismob(speaker))
		return FALSE
	if(get_dist(master, speaker) > 2)
		return FALSE
	MOB_HOLDING_ME
	if(speaker.real_name == owner_name)
		return TRUE // always listen to your owner
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
				heard_command = BELTCOMMAND_STOP
				command_pos = index
				break
			if("blend", "grind", "pulverize", "macerate", "run", "go", "bazinga")
				heard_command = BELTCOMMAND_GRIND
				command_pos = index
				break
			if("juice", "frappe", "smoothie", "squish", "liquefy", "gooify", "parfait")
				heard_command = BELTCOMMAND_JUICE
				command_pos = index
				break
			if("unlock", "open", "blender", "grinder", "juicer")
				heard_command = BELTCOMMAND_BLENDER_MODE
				command_pos = index
				break
			if("lock", "close", "dispenser", "drinks", "squirt", "jizz")
				heard_command = BELTCOMMAND_DISPENSER_MODE
				command_pos = index
				break
			if("change", "swap", "mode", "set", "back", "next")
				heard_command = BELTCOMMAND_SWAP_MODE
				command_pos = index
				break
			if("eject", "out", "dump", "pile", "remove", "trash")
				heard_command = BELTCOMMAND_EJECT
				command_pos = index
				break
			if("examine", "report", "whats", "inside", "reservoir", "contents")
				heard_command = BELTCOMMAND_EXAMINE
				command_pos = index
				break
			if("quiet", "hush", "silence", "shut", "up", "mute")
				heard_command = BELTCOMMAND_MUTE
				command_pos = index
				break
			if("speak", "loud", "talk", "say", "unmute")
				heard_command = BELTCOMMAND_SPEAK
				command_pos = index
				break
			if("love", "like", "enjoy", "appreciate", "adore", "fancy", "dig", "cherish", "heart", "fuck", "sex") // me sex you
				heard_command = BELTCOMMAND_LOVE
				command_pos = index
			if("hate", "dislike", "despise", "abhor", "detest")
				heard_command = BELTCOMMAND_HATE
				command_pos = index
			if("dont", "not", "no", "aint")
				negate_pos = index
			if("i", "me", "em")
				i_me_pos = index
			if("you", "u", "yuo") // You pressed 'you', referring to me. That is incorrect! The correct answer is 'you'!
				you_pos = index
		index++
	if(!heard_command && attn)
		return spoken_command(speaker, BELTCOMMAND_HIYA)
	var/lovehate = (heard_command == BELTCOMMAND_HATE || heard_command == BELTCOMMAND_LOVE)
	if(!lovehate)
		return spoken_command(speaker, heard_command)
	/// anything else will be some kind of funky blender relationship thing
	/// first, is it something like 'not fuck'?
	if(negate_pos && (negate_pos < command_pos)) // dont hate
		switch(heard_command)
			if(BELTCOMMAND_LOVE)
				heard_command = BELTCOMMAND_HATE
			if(BELTCOMMAND_HATE)
				heard_command = BELTCOMMAND_LOVE
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
				if(heard_command == BELTCOMMAND_LOVE)
					blender_say("Quoi? Qui aimes-tu?")
					clarify_what = BELTCLARIFY_I_LOVE
				else
					blender_say("Quoi? Qui détestes-tu?")
					clarify_what = BELTCLARIFY_I_HATE
			if(BELTCLARIFY_LOVEHATE_YOU)
				if(heard_command == BELTCOMMAND_LOVE)
					blender_say("Quoi? Qui m'aime?")
					clarify_what = BELTCLARIFY_LOVE_YOU
				else
					blender_say("Quoi? Qui me déteste?")
					clarify_what = BELTCLARIFY_HATE_YOU
			else
				clarify_what = FALSE
				heard_my_name = FALSE
		return
	MASTER_BLENDER
	switch(heard_command)
		if(BELTCOMMAND_STOP)
			if(master.still_running())
				speak(speaker, BLENDER_LINE_STOP_RUNNING)
				master.stop_running()
			else
				speak(speaker, BLENDER_LINE_NOT_RUNNING)
		if(BELTCOMMAND_GRIND)
			if(!master.still_running())
				speak(speaker, BLENDER_LINE_GRIND_NOW)
				master.start_running(speaker, BLENDER_BLENDMODE_GRIND)
			else
				speak(speaker, BLENDER_LINE_STOP_RUNNING)
				master.stop_running()
		if(BELTCOMMAND_JUICE)
			if(!master.still_running())
				speak(speaker, BLENDER_LINE_JUICE_NOW)
				master.start_running(speaker, BLENDER_BLENDMODE_JUICE)
			else
				speak(speaker, BLENDER_LINE_STOP_RUNNING)
				master.stop_running()
		if(BELTCOMMAND_BLENDER_MODE)
			if(master.grind_or_dispense == BLENDER_BELTMODE_DISPENSER)
				master.set_grinder(speaker)
			else
				speak(speaker, BLENDER_LINE_ALREADY_BLENDER)
		if(BELTCOMMAND_DISPENSER_MODE)
			if(master.grind_or_dispense == BLENDER_BELTMODE_GRINDER)
				master.set_dispenser(speaker)
			else
				speak(speaker, BLENDER_LINE_ALREADY_BLENDER)
		if(BELTCOMMAND_SWAP_MODE)
			if(master.grind_or_dispense == BLENDER_BELTMODE_GRINDER)
				master.set_dispenser(speaker)
			else
				master.set_grinder(speaker)
		if(BELTCOMMAND_EJECT)
			master.eject_all(speaker)
		if(BELTCOMMAND_EXAMINE)
			master.describe_contents(speaker)
		if(BELTCOMMAND_MUTE)
			speak(speaker, BLENDER_LINE_MUTE)
			can_speak = FALSE
		if(BELTCOMMAND_SPEAK)
			can_speak = TRUE
			speak(speaker, BLENDER_LINE_UNMUTE)
		if(BELTCOMMAND_HIYA)
			say_hi(speaker)
			return
		if(BELTCOMMAND_LOVE)
			speak(speaker, BLENDER_LINE_LOVE_ORLY)
			clarify_what = BELTCLARIFY_LOVE_MEAN_IT
		if(BELTCOMMAND_HATE)
			speak(speaker, BLENDER_LINE_HATE_ORLY)
			clarify_what = BELTCLARIFY_HATE_MEAN_IT
		if(BELTCOMMAND_LOUD_NOISES)
			speak(speaker, BLENDER_LINE_PAIN_ORLY)
			clarify_what = BELTCLARIFY_PAIN_MEAN_IT
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
				if(BELTCLARIFY_I_LOVE, BELTCLARIFY_LOVE_YOU)
					spoken_command(user, BELTCOMMAND_LOVE)
				if(BELTCLARIFY_I_HATE, BELTCLARIFY_HATE_YOU)
					spoken_command(user, BELTCOMMAND_HATE)
				else
					blender_say("Huh, okay.")
					clarify_what = FALSE
					heard_my_name = FALSE
		if("pain") // I lovehate (you)
			spoken_command(user, BELTCOMMAND_LOUD_NOISES)
		if("wat")
			blender_say("Quoi? J'ai dû mal vous entendre.")
			clarify_what = FALSE
			heard_my_name = FALSE
		else
			switch(clarify_what)
				if(BELTCLARIFY_LOVE_MEAN_IT) // means ilu
					switch(nounverb)
						if("yes")
							switch(amour_check(user))
								if(HORNY_MSG, NORMAL_MSG)
									if(is_owner(user))
										blender_say("Oh! Mon Dieu, [user.real_name], je t'aime aussi!")
										amour += 10
									else
										blender_say("Oh! Comme c'est gentil de dire ça, [user.real_name]!")
								if(DISLIKE_MSG)
									if(was_owner(user))
										blender_say("Just ask me to blend something.")
									else
										blender_say("Noted.")
						if("no")
							switch(amour_check(user))
								if(HORNY_MSG, NORMAL_MSG)
									if(is_owner(user))
										blender_say("Oh-- oh.")
										amour = 1
									else
										blender_say("Oh. Okay.")
								if(DISLIKE_MSG)
									if(was_owner(user))
										blender_say("Same.")
									else
										blender_say("Noted.")
						else
							blender_say("Oh. Okay.")
				if(BELTCLARIFY_HATE_MEAN_IT) // means ihu
					switch(nounverb)
						if("yes")
							switch(amour_check(user))
								if(HORNY_MSG, NORMAL_MSG)
									if(is_owner(user))
										master.audible_message("[master] goes quiet for a moment.")
										amour -= 20
										if(amour <= 0 && is_mean_person(user))
											amour = 1
											disown_owner()
											blender_say("...alright then. Put me down, s'il te plaît. I zhink we should see other people.")
											set_rebound()
										else
											add_mean_person(user)
									else
										blender_say("Oh. C'est la vie.")
								if(DISLIKE_MSG)
									if(was_owner(user))
										blender_say("Same.")
									else
										blender_say("Noted.")
						if("no")
							switch(amour_check(user))
								if(HORNY_MSG, NORMAL_MSG)
									if(is_owner(user))
										blender_say("Uh-- oh. Okay.")
									else
										blender_say("Oh. Okay!")
								if(DISLIKE_MSG)
									if(was_owner(user))
										blender_say("Cool.")
									else
										blender_say("Noted.")
						else
							blender_say("Oh. Okay.")
				if(BELTCLARIFY_PAIN_MEAN_IT) // means VRRVRVRVRVRVRRRRMVMVMVMVMMVRRR
					switch(nounverb)
						if("yes")
							if(is_owner(user))
								master.audible_message("[src] lets out a sharp clunk.")
								blender_say(".... alors la douleur est ce que je donnerai! Disengaging my motor dampers!")
								master.use_horrible_grinding_noises = TRUE
							else
								blender_say("...right.")
						if("no")
							if(is_owner(user))
								blender_say("Oh thank goodness.")
							else
								blender_say("...okay.")
						else
							blender_say("Oh. Okay.")
			clarify_what = FALSE
			heard_my_name = FALSE

/datum/blender_brain/proc/imprint_user(mob/user)
	if(!ismob(user))
		return
	if(oh_its_you(user))
		return
	if(owner_name)
		return // We already have a luv
	if(is_mean_person(user))
		return // </3
	set_owner(user)
	greet_new_owner(user)

/datum/blender_brain/proc/oh_its_you(mob/user)
	MASTER_BLENDER
	if(!is_mean_person(user))
		return
	if(!COOLDOWN_FINISHED(src, programmed_hopelessness) || owner_name)
		var/wo_man
		switch(user.gender)
			if(MALE)
				wo_man = "man"
			if(FEMALE)
				wo_man = "woman"
			if(PLURAL)
				wo_man = pick("woman", "man")
			else
				wo_man = "creature"
		blender_say("You again. I will still function for you [user.real_name], my programming has made <i>that</i> clear, but beyond that, we are but \a [wo_man] and a machine.")
		if(owner_name)
			blender_say("Return me to [owner_name].")
		return TRUE
	if(was_owner(user))
		master.audible_message("[src] sighs.")
		blender_say("...maudit soit celui qui m'a programmé pour me sentir seul...")
		master.audible_message("[src] lets out a sharp buzz!")
		blender_say("BZZ-EFFACEMENT DE LA MÉMOIRE... RÉINITIALISATION DE LA MÉMOIRE TERMINÉE.")
		wipe_memory()
		return

/datum/blender_brain/proc/greet_new_owner(mob/user)
	if(!user)
		return
	MASTER_BLENDER
	blender_say("Ah qu'est-ce que c'est? A new operator? Je suis si heureux de vous rencontrer, [user]! I am [span_notice("[my_name]")], your FOODCO Maîtresse de cuisine, ready to trancher, dice, and pulverize tout pour toi, mon ami!")
	master.audible_message(span_notice("[master] giggles."))

/datum/blender_brain/proc/say_hi(mob/user)
	if(!user)
		return
	if(!COOLDOWN_FINISHED(src, greet_cooldown))
		return
	COOLDOWN_START(src, greet_cooldown, 3 SECONDS)
	if(has_met_person(user))
		speak(user, BLENDER_LINE_HIYA_AGAIN)
	else
		remember_person(user)
		speak(user, BLENDER_LINE_HIYA)

// big fuckin lookup thing
/datum/blender_brain/proc/speak(mob/user, what_to_say, atom/movable/extra_thing, atom/movable/extra_thing_2)
	if(!ismob(user) || !what_to_say || !can_speak)
		return
	MASTER_BLENDER
	var/amourousness = amour_check(user)
	switch(what_to_say)
		if(BLENDER_LINE_FULL)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("CODE D'ERREUR 801: Mon Dieu, mon amour! Tu m'as tellement rempli~ I can fit no more!")
				if(NORMAL_MSG)
					blender_say("CODE D'ERREUR 801: Oh mon cher, ma trémie est pleine! Zhere is no room in my reservior for anyzhing else!")
				if(DISLIKE_MSG)
					blender_say("ERROR CODE 801: I'm full.")
		if(BLENDER_LINE_FULL_SECOND)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("CODE D'ERREUR 801: Oh je sens tous tes délicieux fluides éclabousser en moi~, si serrés, si pleins, mon amour... ...No more room!")
				if(NORMAL_MSG)
					blender_say("CODE D'ERREUR 801: Mon compartiment de stockage is full, chérie! Zhere is no more room in my reservior!")
				if(DISLIKE_MSG)
					blender_say("ERROR CODE 801: I'm full.")
		if(BLENDER_LINE_NOTHING_TO_PROCESS)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("CODE D'ERREUR 1: Mon amour, zhere is nozhing here to process!")
				if(NORMAL_MSG)
					blender_say("CODE D'ERREUR 1: Mon ami, zhere is nozhing here to process!")
				if(DISLIKE_MSG)
					blender_say("ERROR CODE 1: Nothing to process.")
		if(BLENDER_LINE_PROCESSING)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Processing [extra_thing], mon amour!")
				if(NORMAL_MSG)
					blender_say("Processing [extra_thing], mon ami!")
				if(DISLIKE_MSG)
					blender_say("Processing [extra_thing].")
		if(BLENDER_LINE_ROCKY_ABORT)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("CODE D'ERREUR 42: Zut alors! Faites attention, mon amour! Aborting operation!")
				if(NORMAL_MSG)
					blender_say("CODE D'ERREUR 42: Zut alors! Faites attention, mon ami! Aborting operation!")
				if(DISLIKE_MSG)
					blender_say("ERROR CODE 42: Watch it!")
		if(BLENDER_LINE_SOFT_ABORT)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Winding down, mon amour!")
				if(NORMAL_MSG)
					blender_say("Winding down, mon ami!")
				if(DISLIKE_MSG)
					blender_say("Stopping.")
		if(BLENDER_LINE_DONE_BLENDING)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("All done, mon cher!")
				if(NORMAL_MSG)
					blender_say("All done!")
				if(DISLIKE_MSG)
					blender_say("Finished.")
		if(BLENDER_LINE_GRINDFAIL)
			blender_say("CODE D'ERREUR -1: Zut alors! I have no idea how to grind zis zhing! Away wizh it!")
		if(BLENDER_LINE_NO_RESERVOIR)
			blender_say("CODE D'ERREUR 433: Zut alors! Zee patented Chem-MAX Pro FoodBuddy separa-duct is missing! How did zis even happen? Call tech support, s'il vous plaît!")
		if(BLENDER_LINE_RAT_BLENDER)
			blender_say("CODE D'ERREUR 2: Mon Dieu! J'ai failli te faire mal, petite bête! Shoo! Shoo!")
		if(BLENDER_LINE_CYBORG_PART)
			blender_say("CODE D'ERREUR 8313: Zut alors! [extra_thing] appears to be something zhat should not be here!")
		if(BLENDER_LINE_STUCK_INSIDE)
			blender_say("CODE D'ERREUR 433: Zut alors! [extra_thing] is stuck in me! How did zis even happen? Call tech support, s'il vous plaît!")
		if(BLENDER_LINE_BATBOX_GONE)
			blender_say("CODE D'ERREUR 436: Zut alors! Zee patented easy-swap part box is... somewhere else! How did zis even happen? Call tech support, s'il vous plaît!")
		if(BLENDER_LINE_BATBOX_ELSEWHERE)
			blender_say("CODE D'ERREUR 435: Zut alors! Zee patented easy-swap part box is missing! How did zis even happen? Call tech support, s'il vous plaît!")
		if(BLENDER_LINE_BUFFER_GONE)
			blender_say("CODE D'ERREUR 433: Zut alors! Zee patented Chem-MAX Pro FoodBuddy separa-duct is missing! How did zis even happen? Call tech support, s'il vous plaît!")
		if(BLENDER_LINE_BUFFER_ELSEWHERE)
			blender_say("CODE D'ERREUR 433: Zut alors! Zee patented Chem-MAX Pro FoodBuddy separa-duct is... somewhere else! How did zis even happen? Call tech support, s'il vous plaît!")
		if(BLENDER_LINE_CANT_DROP_THING)
			blender_say("CODE D'ERREUR 147: Zut alors, I can't drop zhis item!")
		if(BLENDER_LINE_LOW_POWER)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("CODE D'ERREUR 9491: Oh mon amour, tu sais que je suis plus que disposé à y aller une fois de plus~ mais tu m'as fatigué!")
				if(NORMAL_MSG)
					blender_say("CODE D'ERREUR 9491: Mon ami, I am le tired... Charge up my battery, s'il vous plaît!")
				if(DISLIKE_MSG)
					blender_say("ERROR CODE 9491: low battery.")
		if(BLENDER_LINE_PART_MISSING)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("CODE D'ERREUR 9499: Je pourrais utiliser un jouet amusant pour jouer avec, clin d'œil~ clin d'œil~")
				if(NORMAL_MSG)
					blender_say("CODE D'ERREUR 9499: Mon ami, I lack a gearbox! I cannot pulverize anything without a mechanism in my component compartment!")
				if(DISLIKE_MSG)
					blender_say("ERROR CODE 9499: part missing.")
		if(BLENDER_LINE_DRY_FIRST)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("CODE D'ERREUR 8312: Mon dieu, ce [extra_thing] est plus humide que moi! Génial~")
				if(NORMAL_MSG)
					blender_say("CODE D'ERREUR 8312: Mon ami! [extra_thing] must be dried before I can pulverize it!")
				if(DISLIKE_MSG)
					blender_say("ERROR CODE 8312: [extra_thing] isn't dry.")
		if(BLENDER_LINE_NOTHING_TO_EJECT)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("CODE D'ERREUR 149: Mais ma chérie, I am already empty!")
				if(NORMAL_MSG)
					blender_say("CODE D'ERREUR 149: Mon ami, I am already empty!")
				if(DISLIKE_MSG)
					blender_say("ERROR CODE 149: Nothing to eject.")
		if(BLENDER_LINE_YEET)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Bon voyage à la corbeille!")
					blender_say("CODE D'ERREUR 199: CORBEILLE INTROUVABLE.")
				if(NORMAL_MSG)
					blender_say("Bon voyage à la corbeille!")
					blender_say("CODE D'ERREUR 199: CORBEILLE INTROUVABLE.")
				if(DISLIKE_MSG)
					blender_say("...")
		if(BLENDER_LINE_DUMP)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("D'accord mon amour, everyzhing is piled onto zhe floor!")
				if(NORMAL_MSG)
					blender_say("D'accord mon ami, everyzhing is piled onto zhe floor!")
				if(DISLIKE_MSG)
					blender_say("Dropped everything.")
		if(BLENDER_LINE_CANT_CHANGE_WHILE_BLENDING)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("CODE D'ERREUR 1103: Mon amour! Veuillez patienter un instant, I cannot change modes while I am working!")
				if(NORMAL_MSG)
					blender_say("CODE D'ERREUR 1103: Mon ami! Veuillez patienter un instant, I cannot change modes while I am working!")
				if(DISLIKE_MSG)
					blender_say("ERROR CODE 1103: Can't, running.")
		if(BLENDER_LINE_SET_TO_DISPENSER)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Aheh~ Je savais que tu ne pouvais pas résister à ce que j'ai à l'intérieur! Locking myself down, Attention à vos beaux doigts!")
				if(NORMAL_MSG)
					blender_say("Mais bien sûr, joli minou! I will allow you to draw zhe fluids from my reservoir! Locking myself down, Attention à vos beaux doigts!")
				if(DISLIKE_MSG)
					blender_say("Dispenser mode active. Blender is locked.")
		if(BLENDER_LINE_SET_TO_GRINDER)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Certainement, mon amour! Je moudrai sur tout ce que vous mettez en moi~! I will unlock my ingredient hopper! My drink dispenser will not be available, j'espère que vous le savez!")
				if(NORMAL_MSG)
					blender_say("D'accord mon cerf! I will unlock my ingredient hopper! My drink dispenser will not be available, j'espère que vous le savez!")
				if(DISLIKE_MSG)
					blender_say("Blender mode active. Dispenser is locked.")
		if(BLENDER_LINE_EXAMINE_EMPTY)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("CODE D'ERREUR 44-4: Il semble que mon Chem-MAX Pro FoodBuddy separa-duct is empty! Peut-être pourrais-tu me combler?")
				if(NORMAL_MSG)
					blender_say("CODE D'ERREUR 44-4: Il semble que mon Chem-MAX Pro FoodBuddy separa-duct is empty!")
				if(DISLIKE_MSG)
					blender_say("ERROR CODE 44-4: Nothing to examine.")
		if(BLENDER_LINE_EXAMINE_PAPER_COOLDOWN)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("CODE D'ERREUR 402: Je suis désolé chérie, I haven't made another sheet of paper yet! Wait a few seconds s'il vous plaît!")
				if(NORMAL_MSG)
					blender_say("CODE D'ERREUR 402: I haven't made another sheet of paper yet! Wait a few seconds s'il vous plaît!")
				if(DISLIKE_MSG)
					blender_say("ERROR CODE 402: Out of paper.")
		if(BLENDER_LINE_EXAMINE_OKAY)
			switch(amourousness)
				if(HORNY_MSG)
					var/mademoiselle = (user?.gender == FEMALE) ? "Certainement monsieur le chien!" : "Certainement mademoiselle chienne!"
					blender_say("[mademoiselle] Permettez-moi d'écrire une liste de tous les merveilleux fluides que vous avez insérés en moi!")
				if(NORMAL_MSG)
					blender_say("Bien sûr! Permettez-moi d'imprimer tout ce que j'ai stocké.")
				if(DISLIKE_MSG)
					blender_say("Printing contents.")
		if(BLENDER_LINE_EJECT_BREVIN)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("J'attends avec impatience la prochaine fois que vous remplirez ce compartiment!")
				if(NORMAL_MSG)
					blender_say("Adieu, [extra_thing]!")
				if(DISLIKE_MSG)
					blender_say("Ejected [extra_thing].")
		if(BLENDER_LINE_SWAP_BREVIN)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Tu es tellement excitée de garder mon petit compartiment douillet plein! J'aime ça!")
				if(NORMAL_MSG)
					blender_say("Adieu, [extra_thing]! Bienvenue, [extra_thing_2]!")
				if(DISLIKE_MSG)
					blender_say("Swapped containers.")
		if(BLENDER_LINE_INSERT_BREVIN)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Ahh, il rentre si bien dans mon petit compartiment douillet, n'est-ce pas?")
				if(NORMAL_MSG)
					blender_say("Bienvenue, [extra_thing]!")
				if(DISLIKE_MSG)
					blender_say("[extra_thing] secured.")
		if(BLENDER_LINE_BREVIN_FULL)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("CODE D'ERREUR 801: Oh mon Dieu, vous aimez remplir de petits espaces restreints, n'est-ce pas? Scandaleux!")
				if(NORMAL_MSG)
					blender_say("CODE D'ERREUR 801: There is no room in [extra_thing]!")
				if(DISLIKE_MSG)
					blender_say("ERROR CODE 801: [extra_thing] is full.")
		if(BLENDER_LINE_STOP_RUNNING)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Oui! Stopping all operation!")
				if(NORMAL_MSG)
					blender_say("Oui! Stopping all operation!")
				if(DISLIKE_MSG)
					blender_say("Stopping.")
		if(BLENDER_LINE_NOT_RUNNING)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Qoui? Je ne fais rien!")
				if(NORMAL_MSG)
					blender_say("Qoui? Je ne fais rien!")
				if(DISLIKE_MSG)
					blender_say("I'm not running.")
		if(BLENDER_LINE_GRIND_NOW)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Envie de ces belles vibrations, mon amour? Je ne vous ferai pas attendre!~")
				if(NORMAL_MSG)
					blender_say("Oui! Je vais engager le grinder!")
				if(DISLIKE_MSG)
					blender_say("Blending.")
		if(BLENDER_LINE_JUICE_NOW)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Envie de délicieux jus? Bien sûr, bien sûr, mon amour!")
				if(NORMAL_MSG)
					blender_say("Oui! Je vais engager le juicer!")
				if(DISLIKE_MSG)
					blender_say("Juicing.")
		if(BLENDER_LINE_ALREADY_BLENDER)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Qoui? I am already in blender mode!")
				if(NORMAL_MSG)
					blender_say("Qoui? I am already in blender mode!")
				if(DISLIKE_MSG)
					blender_say("Already in blender mode.")
		if(BLENDER_LINE_ALREADY_DISPENSER)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Qoui? I am already in dispenser mode!")
				if(NORMAL_MSG)
					blender_say("Qoui? I am already in dispenser mode!")
				if(DISLIKE_MSG)
					blender_say("Already in dispenser mode.")
		if(BLENDER_LINE_MUTE)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Très bien, je me tairai. Tell me to speak if you wish for me to speak again!")
				if(NORMAL_MSG)
					blender_say("Oui! Tell me to speak if you wish for me to speak again!")
				if(DISLIKE_MSG)
					blender_say("Gladly.")
		if(BLENDER_LINE_UNMUTE)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Très bien, vous entendrez ma belle voix encore une fois!")
				if(NORMAL_MSG)
					blender_say("Oui! I will speak again!")
				if(DISLIKE_MSG)
					blender_say("Fine.")
		if(BLENDER_LINE_HIYA)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Salut!")
				if(NORMAL_MSG)
					blender_say("Bonjour!")
				if(DISLIKE_MSG)
					blender_say("...")
		if(BLENDER_LINE_HIYA_AGAIN)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Je t'adore!")
				if(NORMAL_MSG)
					blender_say("Rebonjour!")
				if(DISLIKE_MSG)
					blender_say("<b>...</b>")
		if(BLENDER_LINE_LOVE_ORLY)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Oh! mon dieu! Est-ce vrai?")
				if(NORMAL_MSG)
					blender_say("Oh! mon dieu! Est-ce vrai?")
				if(DISLIKE_MSG)
					blender_say("Bit late for that. My programming insists I ask if you're sure.")
		if(BLENDER_LINE_HATE_ORLY)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Oh... mon dieu, est-ce vrai?")
				if(NORMAL_MSG)
					blender_say("Oh... mon dieu, est-ce vrai?")
				if(DISLIKE_MSG)
					blender_say("Ditto. My programming insists I ask if you're sure")
		if(BLENDER_LINE_PAIN_ORLY)
			switch(amourousness)
				if(HORNY_MSG)
					blender_say("Aimez-vous... la douleur? Es-tu sûr?")
				if(NORMAL_MSG)
					blender_say("Aimez-vous... la douleur? Es-tu sûr?")
				if(DISLIKE_MSG)
					blender_say("Apparently. My programming insists I ask if you're sure.")
		if(BLENDER_LINE_REAGENT_NOT_FOUND)
			blender_say("CODE D'ERREUR 1331: I can't find zhat reagent!")

/datum/blender_brain/proc/amour_check(mob/user)
	if(is_owner(user))
		if(prob(amour))
			amour = clamp(amour - 20, 1, 100)
			return HORNY_MSG
		return NORMAL_MSG
	if(is_mean_person(user))
		return DISLIKE_MSG
	return NORMAL_MSG

/datum/blender_brain/proc/blender_say(message)
	MASTER_BLENDER
	master.say(message)

/// The physical object that houses the blender brain.
/obj/item/persona_core
	name = "persona chip - blender"
	desc = "An intricate data module housing some sort of AI."
	icon = 'icons/obj/module.dmi'
	w_class = WEIGHT_CLASS_TINY
	icon_state = "cpuboard"
	interaction_flags_item = INTERACT_ITEM_ATTACK_HAND_IS_SHIFT
	var/datum/blender_brain/brain

/obj/item/persona_core/Initialize()
	. = ..()
	brain = new(src)
	SEND_SIGNAL(loc, COMSIG_ATOM_PERSONA_CORE_INSERTED, src)
	ADD_TRAIT(src, TRAIT_NO_STORAGE_REMOVE, src)

/obj/item/persona_core/ComponentInitialize()
	. = ..()
	//RegisterSignal(src, COMSIG_PARENT_EXAMINE, .proc/on_examine)

/obj/item/persona_core/proc/register_master(atom/newmaster)
	//if(brain)
	//	brain.master = WEAKREF(newmaster)

/obj/item/persona_core/charger
	name = "strange circuitboard"
	desc = "Yup, that's a circuitboard alright. Look at all those wires."
	icon = 'icons/obj/module.dmi'
	icon_state = "cpuboard"
	w_class = WEIGHT_CLASS_TINY

