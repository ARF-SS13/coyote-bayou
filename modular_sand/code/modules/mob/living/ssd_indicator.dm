GLOBAL_DATUM_INIT(ssd_indicator, /mutable_appearance, mutable_appearance('modular_sand/icons/mob/ssd_indicator.dmi', "default0", FLY_LAYER))

/mob/living/proc/set_ssd_indicator(state)
	if(state && stat != DEAD)
		add_overlay(GLOB.ssd_indicator)
	else
		cut_overlay(GLOB.ssd_indicator)
	return state

//This proc should stop mobs from having the overlay when someone keeps jumping control of mobs, unfortunately it causes Aghosts to have their character without the SSD overlay, I wasn't able to find a better proc unfortunately
/mob/living/transfer_ckey(mob/new_mob, send_signal)
	. = ..()
	set_ssd_indicator(FALSE)
