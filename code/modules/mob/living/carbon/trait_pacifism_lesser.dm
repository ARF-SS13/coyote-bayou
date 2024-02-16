//-->Pacifism lesser trait and its cursed mechanics
//Coder: Leonzrygin - if broken feel free to yell at me
//<--

#define PACIFISM_LESSER_TIMEOUT 30 SECONDS


/proc/check_pacifism_lesser(obj/item/projectile/P, atom/movable/firer, atom/target)
	//-->Pacifism Lesser Trait, most important section of it
	if(iscarbon(target))
		if(iscarbon(firer))  //is our firer a carbon that can have traits?
			if(!P.nodamage)  //if the projectile is harmless by definition then there's no need for the trait to even trigger
				var/mob/living/carbon/C = target
				if(HAS_TRAIT(firer, TRAIT_PACIFISM_LESSER) && C.last_mind)  //does the firer actually has the PACIFISM_LESSER trait? And is the target sapient?
					trait_pacifism_lesser_consequences(firer, TRUE)
					to_chat(firer, span_warning("\the [P] almost hits [C], but [firer] purposely misses their target!"))
					return 1

	return 0
	//<--


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

