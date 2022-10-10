/* not a caves of qud ripoff
technically mad shitcode for rn
plan is to ultimately have it pull from cargo export datum for how valuable stuff is

https://discord.com/channels/986779026205073408/999170698029305946/1028944558928703488
*/


GLOBAL_LIST_INIT(sacredwellitems_low, typecacheof(/obj/item/gun/energy/laser))

GLOBAL_LIST_INIT(sacredwellitems_mid, typecacheof(	/obj/item/gun/energy/laser/scatter))

/obj/structure/sacredwell
	name = "sacredwell"
	desc = "Toss yo shit in here, young'n"
	var/sacredmeter = 400
	var/cooling = 0


/obj/structure/sacredwell/attackby(obj/item/W, mob/user)
	while(src.cooling == 0)

		if(W.type in GLOB.sacredwellitems_mid)
			sacredmeter += 200
			update_meter()
			qdel(W)
			return

		else if(W.type in GLOB.sacredwellitems_low)
			sacredmeter += 100
			update_meter()
			qdel(W)
			return

		else
			to_chat(user, span_danger("This item is not advanced enough for the sacred well. It rejects you."))
			return

		while(src.cooling == 1)
			to_chat(user, span_danger("The well is recharging. Give it a minute, you greedy lil' shit."))
			return



/obj/structure/sacredwell/proc/update_meter()

	while(src.sacredmeter <= 800)
		visible_message(span_notice("The well flares!"))
		playsound(src, 'sound/mecha/mech_shield_drop.ogg', 80, 0, -1)
		return

	while(src.sacredmeter >= 800)
		visible_message(span_notice("The well barks!"))
		sacredmeter = 0
		playsound(src, 'sound/mecha/mech_shield_raise.ogg', 80, 0, -1)
//		dontspam()
		return

	return