GLOBAL_DATUM_INIT(ssd_indicator, /mutable_appearance, mutable_appearance('modular_sand/icons/mob/ssd_indicator.dmi', "default0", FLY_LAYER))

/mob/living/proc/set_ssd_indicator(state)
	if(state && stat != DEAD)
		add_overlay(GLOB.ssd_indicator)
		log_message("<font color='green'>has went SSD and got their indicator!</font>", LOG_ATTACK)
	else
		cut_overlay(GLOB.ssd_indicator)
		log_message("<font color='green'>is no longer SSD and lost their indicator!</font>", LOG_ATTACK)
	return state

/mob/living/Login()
	. = ..()
	set_ssd_indicator(FALSE)

/mob/living/Logout()
	lastclienttime = world.time
	set_ssd_indicator(TRUE)
	. = ..()

//This proc should stop mobs from having the overlay when someone keeps jumping control of mobs, unfortunately it causes Aghosts to have their character without the SSD overlay, I wasn't able to find a better proc unfortunately
/mob/living/transfer_ckey(mob/new_mob, send_signal)
	. = ..()
	set_ssd_indicator(FALSE)
