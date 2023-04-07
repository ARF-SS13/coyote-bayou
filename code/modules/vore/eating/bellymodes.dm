// Process the predator's effects upon the contents of its belly (i.e digestion/transformation etc)
/obj/vore_belly/process(var/times_fired,var/wait) //Passed by controller
	if(!owner)
		qdel(src)
		STOP_PROCESSING(SSbellies, src)
		return SSBELLIES_PROCESSED

	else if(loc != owner)
		if(isliving(owner)) //we don't have machine based bellies. (yet :honk:)
			forceMove(owner) // put it back in!!!
		else
			STOP_PROCESSING(SSbellies, src)
			qdel(src)
			return SSBELLIES_PROCESSED

	var/play_sound //Potential sound to play at the end to avoid code duplication.
	var/to_update = FALSE //Did anything update worthy happen?

/////////////////////////// Auto-Emotes ///////////////////////////
	auto_emote()

///////////////////// Prey Loop Refresh/hack //////////////////////
	refresh_vore_sounds()

//////////////////////// Absorbed Handling ////////////////////////
	handle_absorbed()

////////////////////////// Sound vars /////////////////////////////


	switch(digest_mode)
		if(DM_HOLD) // hold!
			return SSBELLIES_PROCESSED

		if(DM_DIGEST, DM_DRAGON)
			if(HAS_TRAIT(owner, TRAIT_PACIFISM)) //obvious.
				digest_mode = DM_NOISY
				return
			for(var/mob/living/living_prey in get_vored_mobs())
				if(!can_digest_living(living_prey))
					continue
				if(prob(25))
					play_digest()
				//Person just died in guts!
				if(living_prey.stat == DEAD)
					send_voremessage(
						living_prey,
						digest_messages_owner,
						digest_messages_prey,
						VOREPREF_TEXT
						)
					play_death()
					digestion_death(living_prey)
					owner.update_icons()
					continue
				digest_living(living_prey)

			//Contaminate or gurgle items
			var/obj/item/T = pick(get_vored_items())
			if(istype(T,/obj/item/reagent_containers/food) || istype(T,/obj/item/organ))
				digest_item(T)

		if(DM_HEAL)
			for(var/mob/living/living_prey in get_vored_mobs())
				if(!can_healbelly_living(living_prey))
					continue
				if(prob(25))
					play_digest()
				healbelly_living(living_prey)
	
		if(DM_NOISY) //for when you just want people to squelch around
			if(prob(35))
				for(var/mob/living_prey in get_vored_mobs())
					play_digest()

		if(DM_ABSORB)
			for(var/mob/living/living_prey in get_vored_mobs())
				if(prob(10))//Less often than gurgles. People might leave this on forever.
					play_digest()
				if(!can_absorb_living(living_prey))
					continue
				absorb_act(living_prey)

		if(DM_UNABSORB)
			for(var/mob/living/living_prey in get_vored_mobs())
				if(!can_unabsorb_living(living_prey))
					continue
				unabsorb_living(living_prey)
	
	for(var/mob/living/living_prey in get_vored_mobs())
		living_prey.updateVRPanel()
	if(owner.client)
		owner.updateVRPanel()

	return SSBELLIES_PROCESSED
