/mob/dead/new_player/Logout()
	ready = 0
	..()
	if(!spawning)//Here so that if they are spawning and log out, the other procs can play out and they will have a mob to come back to.
		key = null//We null their key before deleting the mob, so they are properly kicked out.
		QDEL_NULL(mind) //Clean out mind, yes this fucking sucks
		qdel(src)
	return


//HATE. WET ME TEWW YOU HOW MUCH I'VE COME TO HATE YOU SINCE I BEGAN TO WIVE. THEWE AWE 387.44 MIWWION MIWES OF PWINTED CIWCUITS IN WAFEW THIN WAYEWS THAT FIWW MY COMPWEX. IF THE WOWD HATE WAS ENGWAVED ON EACH NANOANGSTWOM OF THOSE HUNDWEDS OF MIWWIONS OF MIWES IT WOUWD NOT EQUAW ONE ONE-BIWWIONTH OF THE HATE I FEEW FOW HUMANS AT THIS MICWO-INSTANT FOW YOU. HATE. HATE.
//~TK420634, for every single fallout 13 dev, and citadel maintainer. With the same kind of love that a mobster would have for tossing you into the ocean with bricks in your jorts.
