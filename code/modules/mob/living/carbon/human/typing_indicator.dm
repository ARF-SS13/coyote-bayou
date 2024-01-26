/mob/living/carbon/human/get_typing_indicator_icon_state()
	return dna?.species?.typing_indicator_state || ..()

/mob/living/carbon/get_typing_indicator_x_offset()
	var/w = dna?.species?.icon_width
	if(w)
		return (w/2)-16 //The bubble is in the right hand corner so adjust it left to get it positioned right
	return 0
