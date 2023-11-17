/// Quickly check if the FERAL flag is in this carbon's species traits
/mob/living/carbon/proc/IsFeral()
	var/is_feral = FALSE
	if(FERAL in dna?.species?.species_traits)
		is_feral = TRUE
	return is_feral
