/datum/brain_trauma/abductee
	name = "abductee mindsnapped"
	desc = "The patient's brain has been scrambled by experimental procedures."
	scan_desc = "brain scrambling"
	gain_text = span_danger("Your mind snaps.. you feel fragmented.")
	lose_text = span_boldnotice("Your mind heals itself and you feel whole again.")
	random_gain = FALSE
	clonable = TRUE

/datum/brain_trauma/abductee/on_gain()
	. = ..()
	if(owner.mind)
		if(!owner.mind.has_antag_datum(/datum/antagonist/abductee))
			owner.mind.add_antag_datum(/datum/antagonist/abductee)

/datum/brain_trauma/abductee/on_lose()
	. = ..()
	owner.mind?.remove_antag_datum(/datum/antagonist/abductee)
