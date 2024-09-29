#define EMOTE_SPECIAL_STR "Strength"
#define EMOTE_SPECIAL_PER "Perception"
#define EMOTE_SPECIAL_END "Endurance"
#define EMOTE_SPECIAL_CHA "Charisma"
#define EMOTE_SPECIAL_INT "Intelligence"
#define EMOTE_SPECIAL_AGI "Agility"
#define EMOTE_SPECIAL_LCK "Luck"
#define EMOTE_SPECIAL_GEN "Flat Roll"
#define EMOTE_SPECIAL_SUF "Crit"

GLOBAL_LIST_INIT(special_skill_list, list(
	EMOTE_SPECIAL_STR,
	EMOTE_SPECIAL_PER,
	EMOTE_SPECIAL_END,
	EMOTE_SPECIAL_CHA,
	EMOTE_SPECIAL_INT,
	EMOTE_SPECIAL_AGI,
	EMOTE_SPECIAL_LCK,
	EMOTE_SPECIAL_GEN))

GLOBAL_LIST_INIT(special_triggers, list(
	EMOTE_SPECIAL_STR = list(
		"s",
		"str",
		"strength",
		"strangth",
		"strong",
		"strongth",
		"might",
		"power"),
	EMOTE_SPECIAL_PER = list(
		"p",
		"per",
		"perception",
		"preception",
		"look",
		"see",
		"peep"),
	EMOTE_SPECIAL_END = list(
		"e",
		"end",
		"endurance",
		"endurence",
		"toughness",
		"tough",
		"grit",
		"beef",
		"beefiness"),
	EMOTE_SPECIAL_CHA = list(
		"c",
		"cha",
		"charisma",
		"charesma",
		"charm",
		"moxie",
		"smarm",
		"wink",
		"char"),
	EMOTE_SPECIAL_INT = list(
		"int",
		"i",
		"intelligence",
		"inteligence",
		"intelligance",
		"inteligance",
		"intel",
		"intell",
		"intelect",
		"intellect",
		"smart",
		"smartness",
		"nerd",
		"nerdiness",
		"dork",
		"dorkiness",
		"dweeb",
		"dweebishness"),
	EMOTE_SPECIAL_AGI = list(
		"agi",
		"a",
		"agility",
		"agillity",
		"quick",
		"quickness",
		"fast",
		"fastness",
		"dex",
		"speed",
		"speediness",
		"initiative",
		"athleticism",
		"acrobatics",
		"escape",
		"dodge",
		"evade",
		"evasion",
		"cat"),
	EMOTE_SPECIAL_LCK = list(
		"l",
		"lck",
		"luck",
		"lick",
		"lock",
		"lunk",
		"link",
		"chance",
		"fortune",
		"dice",
		"luk",
		"luc"),
	EMOTE_SPECIAL_GEN = list(
		"x",
		"non",
		"none",
		"generic",
		"something",
		"else",
		"smth",
		"?",
		"rand",
		"huh",
		"stuff",
		"roll")))

GLOBAL_LIST_INIT(special_phrases, list(
	EMOTE_SPECIAL_STR = list(
		"initial" = list(
			"tests their strength...",
			"flexes their arm(s)...",
			"prepares to lift...",
			"puts their back into it..."),
		"success" = list(
			"is strong!",
			"is beefy!",
			"has some serious guns!",
			"had some strength behind it!"),
		"failure" = list(
			"was too weak.",
			"was a little wet noodle.",
			"would loose an arm wrestling match with a mouse.",
			"has some serious atrophy. it's a wonder they can move at all.")),
	EMOTE_SPECIAL_PER = list(
		"initial" = list(
			"takes a good, long look...",
			"squints...",
			"looks around...",
			"focuses in..."),
		"success" = list(
			"was perceptive!",
			"noticed things!",
			"has eyes like a hawk!",
			"could find Doc Mitchell's keys!",
			"noticed whatever they were trying to see!"),
		"failure" = list(
			"was totally oblivious.",
			"forgot their glasses.",
			"didn't see anything.")),
	EMOTE_SPECIAL_END = list(
		"initial" = list(
			"tests their toughness...",
			"braces themself..."),
		"success" = list(
			"was tough!",
			"was one tough cookie!",
			"doesn't even flinch!",
			"is solid as an oak!",
			"endured!"),
		"failure" = list(
			"is a floppy lil' noodle.",
			"is made of paper.",
			"would be torn to shreds by a light breeze.",
			"crumpled up and blew away.")),
	EMOTE_SPECIAL_CHA = list(
		"initial" = list(
			"starts to be charismatic...",
			"puts on the charm..."),
		"success" = list(
			"was charismatic!",
			"is an absolute charmer!",
			"was good and charming!"),
		"failure" = list(
			"was totally uncharismatic.",
			"isn't fooling anyone.",
			"put their foot in their mouth.",
			"could hear a pin drop.",
			"miiiiight have some frontal lobe damage.",
			"had their charms fall flat.")),
	EMOTE_SPECIAL_INT = list(
		"initial" = list(
			"thinks hard...",
			"ponders hard...",
			"takes a moment to think...",
			"furrows their brow..."),
		"success" = list(
			"was clever!",
			"is a genius!",
			"has a mind sharp as a whip!",
			"had a thought!"),
		"failure" = list(
			"was dumb as a doornail.",
			"burned their last braincell years ago.",
			"is running low on braincells.",
			"was dense as a brick.")),
	EMOTE_SPECIAL_AGI = list(
		"initial" = list(
			"tries to get agile...",
			"prepares their moves...",
			"starts to get limber..."),
		"success" = list(
			"was very flexible!",
			"had some excellent footwork!",
			"was in perfect control!",
			"was agile as a cat!",
			"was agile as a fox!"),
		"failure" = list(
			"fell flat on their face.",
			"fell flat on their back.",
			"triped over themself.",
			"has two left feet.",
			"was clumsy as a cat.",
			"was clumsy as a fox.")),
	EMOTE_SPECIAL_LCK = list(
		"initial" = list(
			"tries their luck...",
			"takes a chance...",
			"puts it all on red..."),
		"success" = list(
			"lucked out!",
			"was the luckiest son-of-a-gun in the wasteland!",
			"could make a bullet turn right around and climb back into the gun!",
			"got lucky!"),
		"failure" = list(
			"was unlucky.",
			"realized their game was rigged from the start.",
			"showed that the house always wins.")),
	EMOTE_SPECIAL_GEN = list(
		"initial" = list(
			"tests their skills...",
			"tries their skills...",
			"attempts to do a thing...",
			"puts their skills to the test..."),
		"success" = list(
			"succeeded!",
			"did it!"),
		"failure" = list(
			"was really bad at whatever they did.",
			"just really sucked.",
			"messed up real bad.")),
	EMOTE_SPECIAL_SUF = list(
		"initial" = list(
			"shouldnt see this lol"),
		"success" = list(
			"Ring-a-ding baby!",
			"Wow!"),
		"failure" = list(
			"How could someone mess up so badly?",
			"The game was rigged from the start."))))

/mob/living/verb/emote_special_str()
	set name = "Roll Strength"
	set desc = "Roll for bicep circumfrence."
	set category = "Roleplaying"
	emote("special_strength")

/mob/living/verb/emote_special_per()
	set name = "Roll Perception"
	set desc = "Roll for eyeball circumfrence."
	set category = "Roleplaying"
	emote("special_perception")

/mob/living/verb/emote_special_end()
	set name = "Roll Endurance"
	set desc = "Roll for heart circumfrence."
	set category = "Roleplaying"
	emote("special_endurance")

/mob/living/verb/emote_special_cha()
	set name = "Roll Charisma"
	set desc = "Roll for beauty circumfrence."
	set category = "Roleplaying"
	emote("special_charisma")

/mob/living/verb/emote_special_int()
	set name = "Roll Intelligence"
	set desc = "Roll for brain circumfrence."
	set category = "Roleplaying"
	emote("special_intelligence")

/mob/living/verb/emote_special_agi()
	set name = "Roll Agility"
	set desc = "Roll for wiggly circumfrence."
	set category = "Roleplaying"
	emote("special_agility")

/mob/living/verb/emote_special_luc()
	set name = "Roll Luck"
	set desc = "Roll for some sort of circumfrence."
	set category = "Roleplaying"
	emote("special_luck")

/datum/emote/living/special
	key = "special"
	message = null
	cooldown = 2.5 SECONDS // longer than it takes for the emote to run
	stat_allowed = UNCONSCIOUS
	/// Delay between doing the emote and getting the results
	var/special_delay = 2 SECONDS
	/// So keybinds can use these emotes ezpz
	var/special_override

/datum/emote/living/special/s
	key = "special_strength"
	special_override = EMOTE_SPECIAL_STR

/datum/emote/living/special/p
	key = "special_perception"
	special_override = EMOTE_SPECIAL_PER

/datum/emote/living/special/e
	key = "special_endurance"
	special_override = EMOTE_SPECIAL_END

/datum/emote/living/special/c
	key = "special_charisma"
	special_override = EMOTE_SPECIAL_CHA

/datum/emote/living/special/i
	key = "special_intelligence"
	special_override = EMOTE_SPECIAL_INT

/datum/emote/living/special/a
	key = "special_agility"
	special_override = EMOTE_SPECIAL_AGI

/datum/emote/living/special/l
	key = "special_luck"
	special_override = EMOTE_SPECIAL_LCK

/datum/emote/living/special/run_emote(mob/user, params, type_override, intentional = FALSE)
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE
	if(jobban_isbanned(user, "emote"))	// emote ban
		to_chat(user, "You cannot send emotes (banned).")
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)	// muted
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE

	if(isnull(user.special_a))
		to_chat(user, span_phobia("You arent special."))
		to_chat(user, span_notice("Mainly because you're playing a mob withough any special skills. This is probably a bug~"))
		return FALSE

	var/special_noun = null
	var/special_phrase_input = special_override ? lowertext(special_override) : lowertext(params)

	for(var/which_special in GLOB.special_skill_list)
		/// if the thing we said after the emote is in one of these lists, pick the corresponding key
		if(special_phrase_input in GLOB.special_triggers[which_special])
			special_noun = which_special

	if(!(special_noun in GLOB.special_skill_list) || !special_noun)
		to_chat(user, span_alert("That's not a valid SPECIAL stat!"))
		to_chat(user, span_notice("To use this emote, type '*special' followed by a SPECIAL stat. For instance, '*special luck' will do a (luck*10)% roll and say if you passed or not."))
		var/valid_specials
		for(var/word in GLOB.special_triggers)
			valid_specials += "[GLOB.special_triggers[word][1]], "
			valid_specials += "[GLOB.special_triggers[word][2]]. "
		to_chat(user, span_notice("Some of the valid SPECIAL keywords are:[valid_specials]."))
		return

	var/special_skill = null
	switch(special_noun)
		if(EMOTE_SPECIAL_STR)
			special_skill = user.special_s
		if(EMOTE_SPECIAL_PER)
			special_skill = user.special_p
		if(EMOTE_SPECIAL_END)
			special_skill = user.special_e
		if(EMOTE_SPECIAL_CHA)
			special_skill = user.special_c
		if(EMOTE_SPECIAL_INT)
			special_skill = user.special_i
		if(EMOTE_SPECIAL_AGI)
			special_skill = user.special_a
		if(EMOTE_SPECIAL_LCK)
			special_skill = user.special_l
		if(EMOTE_SPECIAL_GEN) // generic random 50% chance
			special_skill = 5

	var/first_phrase = pick(GLOB.special_phrases[special_noun]["initial"])
	var/message_first = span_notice("\[[special_noun], [special_skill]0%] <b>[user]</b> [first_phrase].")	// [Luck, 100%] User tests their Luck.

	user.visible_message(
		message = message_first,
		self_message = message_first,
		blind_message = message_first)
	user.emote_for_ghost_sight(message_first)

	playsound(get_turf(user), 'sound/effects/statroll.ogg', 75, TRUE)

	spawn(special_delay)
		if(!user)
			return
		if(!can_run_emote(user, TRUE,intentional))
			return

		var/message_second
		if(prob(special_skill * 10))
			var/success_phrase = pick(GLOB.special_phrases[special_noun]["success"])
			if(prob(5)) // crit success!
				success_phrase += " [pick(GLOB.special_phrases[EMOTE_SPECIAL_SUF]["success"])]"
			message_second = span_green("\[Success\] <b>[user]</b> [success_phrase]") // [Success] User is pretty lucky!
		else
			var/fail_phrase = pick(GLOB.special_phrases[special_noun]["failure"])
			if(prob(5)) // crit fail!
				fail_phrase += " [pick(GLOB.special_phrases[EMOTE_SPECIAL_SUF]["failure"])]"
			message_second = span_red("\[Failure\] <b>[user]</b> [fail_phrase]") // [Failure} User isn't very lucky...

		user.visible_message(
			message = message_second,
			self_message = message_second,
			blind_message = message_second)
		user.emote_for_ghost_sight(message_second)



/datum/emote/living/rollfor
	key = "rollfor"

/datum/emote/living/rollfor/run_emote(mob/user, params, type_override, intentional = FALSE)
	if(!can_run_emote(user, TRUE, intentional))
		return FALSE
	if(jobban_isbanned(user, "emote"))	// emote ban
		to_chat(user, "You cannot send emotes (banned).")
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)	// muted
		to_chat(user, "You cannot send IC messages (muted).")
		return FALSE

	if(isnull(user.special_a))
		to_chat(user, span_phobia("You arent special."))
		to_chat(user, span_notice("Mainly because you're playing a mob withough any special skills. This is probably a bug~"))
		return FALSE

	var/paramlist = splittext(params, " ")
	var/skill_name

	for(var/which_special in GLOB.special_skill_list)
		/// if the thing we said after the emote is in one of these lists, pick the corresponding key
		if(paramlist[1] in GLOB.special_triggers[which_special])
			skill_name = which_special

	if(!(skill_name in GLOB.special_skill_list) || !skill_name)
		to_chat(user, span_alert("That's not a valid SPECIAL stat!"))
		to_chat(user, span_notice("To use this emote, type '*special' followed by a SPECIAL stat. For instance, '*special luck' will do a (luck*10)% roll and say if you passed or not."))
		var/valid_specials
		for(var/word in GLOB.special_triggers)
			valid_specials += "[GLOB.special_triggers[word][1]], "
			valid_specials += "[GLOB.special_triggers[word][2]]. "
		to_chat(user, span_notice("Some of the valid SPECIAL keywords are:[valid_specials]."))
		return

	var/skill = null
	switch(skill_name)
		if(EMOTE_SPECIAL_STR)
			skill = user.special_s
		if(EMOTE_SPECIAL_PER)
			skill = user.special_p
		if(EMOTE_SPECIAL_END)
			skill = user.special_e
		if(EMOTE_SPECIAL_CHA)
			skill = user.special_c
		if(EMOTE_SPECIAL_INT)
			skill = user.special_i
		if(EMOTE_SPECIAL_AGI)
			skill = user.special_a
		if(EMOTE_SPECIAL_LCK)
			skill = user.special_l
		if(EMOTE_SPECIAL_GEN) // flat roll
			skill = 0

	var/dice = paramlist[2]
	if(!roll(dice))
		return

	var/first_phrase = pick(GLOB.special_phrases[skill_name]["initial"])
	var/message_first = span_notice("\[[skill_name], [dice]+[skill]\] <b>[user]</b> [first_phrase].") // [Luck, 1d20+5] Player tests their luck.
	user.visible_message(
		message = message_first,
		self_message = message_first,
		blind_message = message_first)
	user.emote_for_ghost_sight(message_first)

	playsound(get_turf(user), 'sound/effects/statroll.ogg', 75, TRUE)

	spawn(2 SECONDS)
		if(!user)
			return
		if(!can_run_emote(user, TRUE,intentional))
			return
	
		var/result_message = span_notice("[user] rolled [roll(dice)+skill]!")
		user.visible_message(
			message = result_message,
			self_message = result_message,
			blind_message = result_message)
		user.emote_for_ghost_sight(result_message)

/mob/living/verb/suggest_skillcheck(mob/living/target)
	set category = "OOC"
	set name = "Suggest Skillcheck"
	var/skill = input(usr, "Which skill?", "Skill Suggester 9000", null) as null|anything in GLOB.special_skill_list
	if(isnull(skill))
		return
	to_chat(target, span_info("[usr.name] would like you to perform a [skill] check."))

/mob/living/verb/skill_contest(mob/living/target)
	set category = "Roleplaying"
	set name = "Skill Contest"
	// decide skill
	var/skill = input(usr, "Which skill?", "Skill Chooser 9001", null) as null|anything in GLOB.special_skill_list
	if(isnull(skill))
		return

	// decide the contest
	var/dice = input(usr, "What kind of dice? (ex: 1d20) \nIf nothing happens, you probably typed this wrong.", null) as null|text
	if(!roll(dice))
		return
	// get consent
	var/consent = alert(target, "[usr.name] would like to compete in a [dice] [skill] contest.",, "Agree", "Deny")
	if(consent == "Deny")
		to_chat(usr, span_info("[target.name] doesn't seem like they want to participate in a contest."))
		return

	// run contest
	var/usr_skill = 0
	var/target_skill = 0
	switch(skill)
		if(EMOTE_SPECIAL_STR)
			usr_skill = usr.special_s
			target_skill = target.special_s
		if(EMOTE_SPECIAL_PER)
			usr_skill = usr.special_p
			target_skill = target.special_p
		if(EMOTE_SPECIAL_END)
			usr_skill = usr.special_e
			target_skill = target.special_e
		if(EMOTE_SPECIAL_CHA)
			usr_skill = usr.special_c
			target_skill = target.special_c
		if(EMOTE_SPECIAL_INT)
			usr_skill = usr.special_i
			target_skill = target.special_i
		if(EMOTE_SPECIAL_AGI)
			usr_skill = usr.special_a
			target_skill = target.special_a
		if(EMOTE_SPECIAL_LCK)
			usr_skill = usr.special_l
			target_skill = target.special_l

	var/usr_result = roll(dice) + usr_skill
	var/target_result = roll(dice) + target_skill


	var/winner
	var/winner_result
	var/loser
	var/loser_result

	if(usr_result > target_result)
		winner = usr
		winner_result = usr_result
		loser = target
		loser_result = target_result
	else
		winner = target
		winner_result = target_result
		loser = usr
		loser_result = usr_result

	to_chat(winner, span_green("You won the [skill] contest! ([winner_result] vs [loser_result])"))
	to_chat(loser, span_alert("You lost the [skill] contest! ([loser_result] vs [winner_result])"))
