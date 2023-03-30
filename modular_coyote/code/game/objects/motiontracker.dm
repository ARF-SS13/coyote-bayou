// Motion Tracker! Author: Gremling
// Alien-escue but instead every pulse will do a green overlay of the mob every pulse.

/obj/item/motiontracker
	name = "motion tracker"
	desc = "ae"
	icon = 'modular_coyote/icons/items/items.dmi'
	icon_state = "firebow0"

	var/setLayer = ABOVE_MOB_LAYER
	var/setPlane = PLANE_MASTER

/obj/item/motiontracker/attack_self(mob/user)
	if(user.stat)
		return

	PulseOverlay(user)

/obj/item/motiontracker/proc/PulseOverlay(mob/user)
	var/list/hearing = range("19x15", get_turf(user)) - user

	for(var/mob/M in hearing)
		//mut.alpha = 255
		//mut.layer = setLayer
		//mut.plane = setPlane
		
		// After some stupid diagnosing, appearances' loc is stored on the mob, so we use the mob's x and y for the offset.
		// This subtraction gets the x and y coordinates of the mob to the user.
		var/offsetX = (M.x - user.x) * 32
		var/offsetY = (M.y - user.y) * 32

		var/mutable_appearance/mut = new /mutable_appearance(M) // god forgive my sins please

		mut.x = user.x // please, I beg you
		mut.y = user.y // with every fibre of my being
		mut.loc = user.loc // Please just let my code work for once.

		mut.color = "#00FF00" // I know, you hate colors, but, I'll let this one slide.
		mut.layer = ABOVE_ALL_MOB_LAYER // But please make this icon more important than all the other ones.

		var/matrix/matrix = matrix() // You didn't like my previous attempt to move their pixel values? Well I guess it's time for me to bring out the big guns.
		// Don't fuck with me god-
		matrix.Translate(offsetX, offsetY) // please god
		mut.transform = matrix // I beg, I was wrong to try to fight back your judgement.

//		animate(mut, alpha = 0, time = 1.5 SECONDS)
//		flick_overlay(mut, user, 1.5 SECONDS)
		user.client.images.Add(mut)
		addtimer(CALLBACK(src, .proc/RemoveOverlay, user, mut), 3 SECONDS)

/obj/item/motiontracker/proc/RemoveOverlay(mob/user, mutable_appearance/i)
	if(!i)
		return
	
	user.client.images.Remove(i)

