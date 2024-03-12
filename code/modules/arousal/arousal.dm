/mob/living
	var/mb_cd_length = 5 SECONDS						//5 second cooldown for masturbating because fuck spam.
	var/mb_cd_timer = 0									//The timer itself

/mob/living/carbon/human
	var/saved_underwear = ""//saves their underwear so it can be toggled later
	var/saved_undershirt = ""
	var/saved_socks = ""
	var/hidden_underwear = FALSE
	var/hidden_undershirt = FALSE
	var/hidden_socks = FALSE
	var/underwear_oversuit = FALSE
	var/undershirt_oversuit = FALSE
	var/socks_oversuit = FALSE

//Mob procs
/mob/living/carbon/human/verb/underwear_toggle()
	set name = "Toggle undergarments"
	set category = "IC"

	var/confirm = input(src, "Select what part of your form to alter", "Undergarment Toggling") as null|anything in list("Top", "Bottom", "Socks", "All")
	if(!confirm)
		return
	if(confirm == "Top")
		toggle_undies_visibility(PHUD_SHIRT)

	else if(confirm == "Bottom")
		toggle_undies_visibility(PHUD_PANTS)

	else if(confirm == "Socks")
		toggle_undies_visibility(PHUD_SOCKS)

	else if(confirm == "All")
		var/on_off = (hidden_undershirt || hidden_underwear || hidden_socks) ? FALSE : TRUE
		toggle_undies_visibility(PHUD_SHIRT, on_off)
		toggle_undies_visibility(PHUD_PANTS, on_off)
		toggle_undies_visibility(PHUD_SOCKS, on_off)

	update_body(TRUE)

/mob/living/carbon/human/proc/toggle_undies_visibility(slut, onoff)
	var/newvis = FALSE
	switch(slut)
		if(PHUD_PANTS)
			if(onoff)
				hidden_underwear = onoff
			else
				TOGGLE_VAR(hidden_underwear)
			newvis = hidden_underwear
		if(PHUD_SHIRT)
			if(onoff)
				hidden_undershirt = onoff
			else
				TOGGLE_VAR(hidden_undershirt)
			newvis = hidden_undershirt
		if(PHUD_SOCKS)
			if(onoff)
				hidden_socks = onoff
			else
				TOGGLE_VAR(hidden_socks)
			newvis = hidden_socks
	SSpornhud.update_visibility(src, slut, !newvis)


/mob/living/carbon/human/proc/adjust_arousal(strength,aphro = FALSE,maso = FALSE) // returns all genitals that were adjust
	var/list/obj/item/organ/genital/genit_list = list()
	if(!client?.prefs.arousable || (aphro && (client?.prefs.cit_toggles & NO_APHRO)) || (maso && !HAS_TRAIT(src, TRAIT_MASO)))
		return // no adjusting made here
	for(var/obj/item/organ/genital/G in internal_organs)
		if(G.genital_flags & GENITAL_CAN_AROUSE && !G.aroused_state && prob(strength*G.sensitivity))
			G.toggle_arousal(TRUE)
			G.update_appearance()
			if(G.aroused_state)
				genit_list += G
	return genit_list

/obj/item/organ/genital/proc/climaxable(mob/living/carbon/human/H, silent = FALSE) //returns the fluid source (ergo reagents holder) if found.
	if(CHECK_BITFIELD(genital_flags, GENITAL_FLUID_PRODUCTION))
		. = reagents
	else
		if(linked_organ)
			. = linked_organ.reagents
	if(!. && !silent)
		to_chat(H, span_warning("Your [name] is unable to produce it's own fluids, it's missing the organs for it."))

/mob/living/carbon/human/proc/do_climax(datum/reagents/R, atom/target, obj/item/organ/genital/G, spill = TRUE)
	if(!G)
		return
	if(!target || !R)
		return
	var/turfing = isturf(target)
	G.generate_fluid(R)
	if(spill && R.total_volume >= 5)
		R.reaction(turfing ? target : target.loc, TOUCH, 1, 0)
	if(!turfing)
		R.trans_to(target, R.total_volume * (spill ? G.fluid_transfer_factor : 1))
	G.last_orgasmed = world.time
	R.clear_reagents()

/mob/living/carbon/human/proc/mob_climax_outside(obj/item/organ/genital/G, mb_time = 30) //This is used for forced orgasms and other hands-free climaxes
	var/datum/reagents/fluid_source = G.climaxable(src, TRUE)
	//if(!fluid_source)
		//to_chat(src,span_userdanger("Your [G.name] cannot cum."))
		//return
	if(mb_time) //as long as it's not instant, give a warning
		to_chat(src,span_userlove("You feel yourself about to orgasm."))
		if(!do_after(src, mb_time, target = src) || !G.climaxable(src, TRUE))
			return
	to_chat(src,span_userlove("You climax[isturf(loc) ? " onto [loc]" : ""] with your [G.name]."))
	do_climax(fluid_source, loc, G)

/mob/living/carbon/human/proc/mob_climax_partner(obj/item/organ/genital/G, mob/living/L, spillage = TRUE, mb_time = 30) //Used for climaxing with any living thing
	var/datum/reagents/fluid_source = G.climaxable(src)
	if(!fluid_source)
		return
	if(mb_time) //Skip warning if this is an instant climax.
		to_chat(src,span_userlove("You're about to climax with [L]!"))
		to_chat(L,span_userlove("[src] is about to climax with you!"))
		if(!do_after(src, mb_time, target = src) || !in_range(src, L) || !G.climaxable(src, TRUE))
			return
	if(spillage)
		to_chat(src,span_userlove("You orgasm with [L], spilling out of them, using your [G.name]."))
		to_chat(L,span_userlove("[src] climaxes with you, overflowing and spilling, using [p_their()] [G.name]!"))
	else //knots and other non-spilling orgasms
		to_chat(src,span_userlove("You climax with [L], your [G.name] spilling nothing."))
		to_chat(L,span_userlove("[src] climaxes with you, [p_their()] [G.name] spilling nothing!"))
	SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/orgasm)
	do_climax(fluid_source, spillage ? loc : L, G, spillage)

/mob/living/carbon/human/proc/mob_fill_container(obj/item/organ/genital/G, obj/item/reagent_containers/container, mb_time = 30) //For beaker-filling, beware the bartender
	var/datum/reagents/fluid_source = G.climaxable(src)
	if(!fluid_source)
		return
	if(mb_time)
		to_chat(src,span_userlove("You start to [G.masturbation_verb] your [G.name] over [container]."))
		if(!do_after(src, mb_time, target = src) || !in_range(src, container) || !G.climaxable(src, TRUE))
			return
	to_chat(src,span_userlove("You used your [G.name] to fill [container]."))
	do_climax(fluid_source, container, G, FALSE)

/mob/living/carbon/human/proc/pick_climax_genitals(silent = FALSE)
	var/list/genitals_list
	var/list/worn_stuff = get_equipped_items()

	for(var/obj/item/organ/genital/G in internal_organs)
		if(CHECK_BITFIELD(G.genital_flags, CAN_CLIMAX_WITH) && G.is_exposed(worn_stuff)) //filter out what you can't masturbate with
			LAZYADD(genitals_list, G)
	if(LAZYLEN(genitals_list))
		var/obj/item/organ/genital/ret_organ = input(src, "with what?", "Climax", null) as null|obj in genitals_list
		return ret_organ
	else if(!silent)
		to_chat(src, span_warning("You cannot climax without available genitals."))

/mob/living/carbon/human/proc/pick_partner(silent = FALSE)
	var/list/partners = list()
	if(pulling)
		partners += pulling
	if(pulledby)
		partners += pulledby
	//Now we got both of them, let's check if they're proper
	for(var/mob/living/L in partners)
		if(!L.client || !L.mind) // can't consent, not a partner
			partners -= L
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			if(!C.exposed_genitals.len && !C.is_groin_exposed() && !C.is_chest_exposed()) //Nothing through_clothing, no proper partner.
				partners -= C
	//NOW the list should only contain correct partners
	if(!partners.len)
		if(!silent)
			to_chat(src, span_warning("You cannot do this alone."))
		return //No one left.
	var/mob/living/target = input(src, "With whom?", "Sexual partner", null) as null|anything in partners //pick one, default to null
	if(target && in_range(src, target))
		to_chat(src,span_notice("Waiting for consent..."))
		var/consenting = input(target, "Do you want [src] to climax with you?","Climax mechanics","No") in list("Yes","No")
		if(consenting == "Yes")
			return target
		else
			message_admins("[src] tried to climax with [target], but [target] did not consent.")
			log_consent("[src] tried to climax with [target], but [target] did not consent.")

/mob/living/carbon/human/proc/pick_climax_container(silent = FALSE)
	var/list/containers_list = list()

	for(var/obj/item/reagent_containers/C in held_items)
		if(C.is_open_container() || istype(C, /obj/item/reagent_containers/food/snacks))
			containers_list += C
	for(var/obj/item/reagent_containers/C in range(1, src))
		if((C.is_open_container() || istype(C, /obj/item/reagent_containers/food/snacks)) && can_reach(C))
			containers_list += C

	if(containers_list.len)
		var/obj/item/reagent_containers/SC = input(src, "Into or onto what?(Cancel for nowhere)", null)  as null|obj in containers_list
		if(SC && can_reach(SC))
			return SC
	else if(!silent)
		to_chat(src, span_warning("You cannot do this without an appropriate container."))

//Here's the main proc itself
/mob/living/carbon/human/proc/mob_climax(forced_climax=FALSE) //Forced is instead of the other proc, makes you cum if you have the tools for it, ignoring restraints
	if(mb_cd_timer > world.time)
		if(!forced_climax) //Don't spam the message to the victim if forced to come too fast
			to_chat(src, span_warning("You need to wait [DisplayTimeText((mb_cd_timer - world.time), TRUE)] before you can do that again!"))
		return

	if(!client?.prefs.arousable || !has_dna())
		return
	if(stat == DEAD)
		if(!forced_climax)
			to_chat(src, span_warning("You can't do that while dead!"))
		return
	if(forced_climax) //Something forced us to cum, this is not a masturbation thing and does not progress to the other checks
		for(var/obj/item/organ/genital/G in internal_organs)
			if(!CHECK_BITFIELD(G.genital_flags, CAN_CLIMAX_WITH)) //Skip things like wombs and testicles
				continue
			var/mob/living/partner
			var/check_target
			var/list/worn_stuff = get_equipped_items()

			if(G.is_exposed(worn_stuff))
				if(pulling) //Are we pulling someone? Priority target, we can't be making option menus for this, has to be quick
					if(isliving(pulling)) //Don't fuck objects
						check_target = pulling
				if(pulledby && !check_target) //prioritise pulled over pulledby
					if(isliving(pulledby))
						check_target = pulledby
				//Now we should have a partner, or else we have to come alone
				if(check_target)
					if(iscarbon(check_target)) //carbons can have clothes
						var/mob/living/carbon/C = check_target
						if(C.exposed_genitals.len || C.is_groin_exposed() || C.is_chest_exposed()) //Are they naked enough?
							partner = C
					else //A cat is fine too
						partner = check_target
				if(partner) //Did they pass the clothing checks?
					mob_climax_partner(G, partner, mb_time = 0) //Instant climax due to forced
					continue //You've climaxed once with this organ, continue on
			//not exposed OR if no partner was found while exposed, climax alone
			mob_climax_outside(G, mb_time = 0) //removed climax timer for sudden, forced orgasms
		//Now all genitals that could climax, have.
		//Since this was a forced climax, we do not need to continue with the other stuff
		mb_cd_timer = world.time + mb_cd_length
		return
	//If we get here, then this is not a forced climax and we gotta check a few things.

	if(stat == UNCONSCIOUS) //No sleep-masturbation, you're unconscious.
		to_chat(src, span_warning("You must be conscious to do that!"))
		return

	//Ok, now we check what they want to do.
	var/choice = input(src, "Select sexual activity", "Sexual activity:") as null|anything in list("Climax with partner")
	if(!choice)
		return

	mb_cd_timer = world.time + mb_cd_length

/* /mob/living/carbon/human/verb/climax_verb()
	set category = "IC"
	set name = "Climax"
	set desc = "Lets you choose a couple ways to ejaculate."
	mob_climax()
 */ // Just until the darn verb actually works =3
