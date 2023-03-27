// Motion Tracker!
// Alien-escue but instead every pulse will do a green overlay of the mob 

/obj/item/motiontracker
	name = "motion tracker"
	desc = "ae"
	icon = 'modular_coyote/icons/items/items.dmi'
	icon_state = "firebow0"

/obj/item/motiontracker/attack_self(mob/user)
	if(user.stat)
		return

	PulseOverlay(user)

/obj/item/motiontracker/proc/PulseOverlay(mob/user)
	var/list/mobMA = list()
	var/list/hearing = hearers(7, user) - user
	
	for(var/mob/M in hearing)
		var/mutable_appearance/mobIcon = new /mutable_appearance(M)
		mobMA |= mobIcon


	for(var/mutable_appearance/I in mobMA)

		animate(I, alpha = 0, time = 1.5 SECONDS)

		user.client.images |= mut
		addtimer(CALLBACK(src, .proc/RemoveOverlay, user, mut), 1.5 SECONDS)
		QDEL_IN(mut, 2 SECONDS)
		
/obj/item/motiontracker/proc/RemoveOverlay(mob/user, mutable_appearance/i)
	if(!i)
		return
	
	user.client.images.Remove(i)

