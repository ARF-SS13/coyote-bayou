// Motion Tracker!
// Alien-escue but instead every pulse will do a green overlay of the mob 

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
	var/list/mobMA = list()
	var/list/hearing = range(world.view, get_turf(user)) - user
	
	for(var/mob/M in hearing)
		var/mutable_appearance/mobIcon = new /mutable_appearance(M)
		mobMA |= mobIcon


	for(var/mutable_appearance/mut in mobMA)
		mut.alpha = 255
		mut.ColorTone(rgb(90, 174, 70))
		mut.layer = setLayer
		mut.plane = setPlane
		animate(mut, alpha = 0, time = 1.5 SECONDS)
		flick_overlay(mut, user, 1.5 SECONDS)	
/obj/item/motiontracker/proc/RemoveOverlay(mob/user, mutable_appearance/i)
	if(!i)
		return
	
	user.client.images.Remove(i)

