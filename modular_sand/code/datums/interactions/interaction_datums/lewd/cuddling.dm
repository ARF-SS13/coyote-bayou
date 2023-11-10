/datum/interaction/cuddle
	description = "Partner/Body - Cuddle with them."
	help_messages = "USER cuddles TARGET."
	simple_span = "lewd"
	needs_physical_contact = TRUE

/datum/interaction/cuddle/interaction_message(mob/living/user, mob/living/target)
	var/static/list/possible_messages = list(
		"USER cuddles TARGET.",
		"USER passionately cuddles TARGET.",
		"USER affectionately cuddles TARGET.",
		"USER lovingly cuddles TARGET.",
		"USER nuzzles TARGET.",
		"USER passionately nuzzles TARGET.",
		"USER lovingly nuzzles TARGET.",
		"USER embraces TARGET.",
		"USER embraces TARGET in a soft cuddle.",
		"USER passionately embraces TARGET.",
		"USER lovingly embraces TARGET.",
	)
	var/use_message = replacetext(pick(possible_messages), "USER", "\the [user]")
	use_message = replacetext(use_message, "TARGET", "\the [target]")
	user.visible_message("<span class='[simple_span]'>[capitalize(use_message)]</span>")
