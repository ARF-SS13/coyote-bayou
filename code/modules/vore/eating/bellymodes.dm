// Process the predator's effects upon the contents of its belly (i.e digestion/transformation etc)
/obj/vore_belly/process()
	if(!owner)
		qdel(src)
		STOP_PROCESSING(SSvore, src)
		return

	if(loc != owner)
		if(isliving(owner)) //we don't have machine based bellies. (yet :honk:)
			forceMove(owner) // put it back in!!!
		else
			STOP_PROCESSING(SSvore, src)
			qdel(src)
			return

/////////////////////////// Auto-Emotes ///////////////////////////
	auto_emote()

///////////////////// Prey Loop Refresh/hack //////////////////////
	refresh_vore_sounds()

//////////////////////// Absorbed Handling ////////////////////////
	handle_absorbed()

//////////////////////// Anti-grenade measure, or something ////////////////////////
	var/list/inner_stuff = get_vored_items() // just the top level items
	for(var/tries in 1 to 5) // lets try again!
		if(!LAZYLEN(inner_stuff))
			break
		var/obj/item/T = pick(inner_stuff)
		if(SEND_SIGNAL(T, COMSIG_VORE_ATOM_DIGESTED, src, owner))
			break
		inner_stuff -= T
		if(prob(25))
			play_digest()

////////////////////////// Do the Digest /////////////////////////////
	var/list/vored_folk = get_vored_mobs()
	switch(digest_mode)
		if(DM_HOLD) // hold!
			return

		if(DM_DIGEST, DM_DRAGON)
			if(HAS_TRAIT(owner, TRAIT_PACIFISM)) //obvious.
				digest_mode = DM_NOISY
				return
			for(var/mob/living/living_prey in vored_folk)
				if(living_prey.stat == DEAD)
					continue
				if(!can_digest_living(living_prey))
					continue
				if(prob(25))
					play_digest()
				digest_living(living_prey)

		if(DM_HEAL)
			for(var/mob/living/living_prey in vored_folk)
				if(!can_healbelly_living(living_prey))
					continue
				if(prob(25))
					play_digest()
				healbelly_living(living_prey)
	
		if(DM_NOISY) //for when you just want people to squelch around
			if(prob(35))
				for(var/mob/living_prey in vored_folk)
					play_digest()

		if(DM_ABSORB)
			for(var/mob/living/living_prey in vored_folk)
				if(prob(10))//Less often than gurgles. People might leave this on forever.
					play_digest()
				if(!can_absorb_living(living_prey))
					continue
				absorb_act(living_prey)

		if(DM_UNABSORB)
			for(var/mob/living/living_prey in vored_folk)
				if(!can_unabsorb_living(living_prey))
					continue
				unabsorb_living(living_prey)

	SEND_SIGNAL(src, COMSIG_VORE_UPDATE_PANEL)
	if(COOLDOWN_FINISHED(src, recalc_slows))
		trigger_slowdown_update()
		COOLDOWN_START(src, recalc_slows, 10 SECONDS)

