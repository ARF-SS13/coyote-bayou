#define PACIFISM_LESSER_TIMEOUT 30 SECONDS

/proc/trait_pacifism_lesser_consequences(mob/living/carbon/user, traumatize = FALSE)
	to_chat(user, span_danger("What am I doing?! I nearly hurt that person!"))
	user.dizziness += 10
	user.confused += 10
	user.Jitter(10)

	if(traumatize)
		user.gain_trauma(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_ABSOLUTE)

		spawn(PACIFISM_LESSER_TIMEOUT)
			user?.cure_trauma_type(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_ABSOLUTE)
			to_chat(user, span_danger("I think I've calmed down... I need to be more careful not to hurt anyone."))

