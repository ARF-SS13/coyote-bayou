#define DEFAULT_TASTE_SENSITIVITY 15

/mob/living
	var/last_taste_time
	var/last_taste_text

/mob/living/proc/get_taste_sensitivity()
	return DEFAULT_TASTE_SENSITIVITY

/mob/living/carbon/get_taste_sensitivity()
	var/obj/item/organ/tongue/tongue = getorganslot(ORGAN_SLOT_TONGUE)
	if(istype(tongue) && !HAS_TRAIT(src, TRAIT_AGEUSIA))
		. = tongue.taste_sensitivity
	else
		. = 101 // can't taste anything without a tongue

// non destructively tastes a reagent container
/mob/living/proc/taste(datum/reagents/from, atom/thing_licked)
	if(last_taste_time + 50 > world.time)
		return FALSE
	var/taste_sensitivity = get_taste_sensitivity()
	var/text_output = generate_taste_message(taste_sensitivity, thing_licked, from)
	// We dont want to spam the same message over and over again at the
	// person. Give it a bit of a buffer.
	if(hallucination > 50 && prob(25))
		text_output = pick("spiders","dreams","nightmares","the future","the past","victory",\
		"defeat","pain","bliss","revenge","poison","time","space","death","life","truth","lies","justice","memory",\
		"regrets","your soul","suffering","music","noise","blood","hunger","the american way")
	if(text_output != last_taste_text || last_taste_time + 100 < world.time)
		to_chat(src, span_notice("You can taste [text_output]."))
		// "something indescribable" -> too many tastes, not enough flavor.
		last_taste_time = world.time
		last_taste_text = text_output
	return TRUE

//FermiChem - How to check pH of a beaker without a meter/pH paper.
//Basically checks the pH of the holder and burns your poor tongue if it's too acidic!
//TRAIT_AGEUSIA players can't taste, unless it's burning them.
//taking sips of a strongly acidic/alkaline substance will burn your tongue.
/mob/living/carbon/taste(datum/reagents/from, atom/licked)
	var/obj/item/organ/tongue/T = getorganslot("tongue")
	if (!T)
		return
	.=..()
	if(!.)
		return
	if(!istype(from))
		return
	if ((from.pH > 12.5) || (from.pH < 1.5))
		T.applyOrganDamage(5)
		to_chat(src, span_warning("You taste chemical burns!"))
	if(istype(T, /obj/item/organ/tongue/cybernetic))
		to_chat(src, span_notice("Your tongue moves on it's own in response to the liquid."))
		say("The pH is approximately [round(from.pH, 1)].")
		return
	if (!HAS_TRAIT(src, TRAIT_AGEUSIA)) //I'll let you get away with not having 1 damage.
		switch(from.pH)
			if(11.5 to 12.5)
				to_chat(src, span_warning("You taste a strong alkaline flavour!"))
			if(8.5 to 11.5)
				to_chat(src, span_notice("You taste a sort of soapy tone in the mixture."))
			if(2.5 to 5.5)
				to_chat(src, span_notice("You taste a sort of acid tone in the mixture."))
			if(1.5 to 2.5)
				to_chat(src, span_warning("You taste a strong acidic flavour!"))

/proc/generate_taste_message(minimum_percent=15, atom/thing_tasted, datum/reagents/reagent_thing)
	// the lower the minimum percent, the more sensitive the message is.
	var/list/out = list()
	var/list/flavors = istype(thing_tasted) ? SSlistbank.get_tastes(thing_tasted) : list() //descriptor = strength
	var/datum/reagents/reagents_in = reagent_thing
	if(minimum_percent <= 100)
		if(reagents_in)
			for(var/datum/reagent/R in reagents_in.reagent_list)
				if(!R.taste_mult)
					continue

				if(istype(R, /datum/reagent/consumable/nutriment))
					var/list/taste_data = R.data
					for(var/taste in taste_data)
						var/ratio = taste_data[taste]
						var/amount = ratio * R.taste_mult * R.volume
						if(taste in flavors)
							flavors[taste] += amount
						else
							flavors[taste] = amount
				else
					var/taste_desc = R.taste_description
					var/taste_amount = R.volume * R.taste_mult
					if(taste_desc in flavors)
						flavors[taste_desc] += taste_amount
					else
						flavors[taste_desc] = taste_amount
		//deal with percentages
		// TODO it would be great if we could sort these from strong to weak
		var/total_taste = counterlist_sum(flavors)
		if(total_taste > 0)
			for(var/taste_desc in flavors)
				var/percent = flavors[taste_desc]/total_taste * 100
				if(percent < minimum_percent)
					continue
				var/intensity_desc = "a hint of"
				if(ISINRANGE(percent, minimum_percent * 2, minimum_percent * 3)|| percent == 100)
					intensity_desc = ""
				else if(percent > minimum_percent * 3)
					intensity_desc = "the strong flavor of"
				if(intensity_desc != "")
					out += "[intensity_desc] [taste_desc]"
				else
					out += "[taste_desc]"

	return english_list(out, "something indescribable")


#undef DEFAULT_TASTE_SENSITIVITY
