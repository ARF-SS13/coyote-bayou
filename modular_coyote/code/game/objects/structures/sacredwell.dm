/* not a caves of qud ripoff
technically mad shitcode for rn
plan is to ultimately have it pull from cargo export datum for how valuable stuff is
*/


GLOBAL_LIST_INIT(sacredwellitems_low, typecacheof(/obj/item/gun/energy/laser))

GLOBAL_LIST_INIT(sacredwellitems_mid, typecacheof(	/obj/item/gun/energy/laser/scatter))

/obj/structure/sacredwell
	name = "sacredwell"
	desc = "Toss yo shit in here, young'n."
	var/sacredmeter = 0
	var/sacredmeter_max = 800 //how much charge it needs before it does the thing
	var/cooling = 0


/obj/structure/sacredwell/attackby(obj/item/W, mob/user)
	while(src.cooling == 0)

		if(W.type in GLOB.sacredwellitems_mid)
			qdel(W)
			sacredmeter += 200
			update_meter()
			return

		else if(W.type in GLOB.sacredwellitems_low)
			qdel(W)
			sacredmeter += 100
			update_meter()
			return

		else
			to_chat(user, span_danger("This item is not advanced enough for the sacred well. It rejects you."))
			return

		while(src.cooling == 1)
			to_chat(user, span_danger("The well is recharging. Give it a minute, you greedy lil' shit."))
			return



/obj/structure/sacredwell/proc/update_meter()

	if(src.sacredmeter < src.sacredmeter_max)
		visible_message(span_notice("The well flares!"))
		playsound(src, 'sound/mecha/mech_shield_drop.ogg', 80, 0, -1)
		desc = "Toss yo shit in here, young'n. Has [sacredmeter] out of 800 charge."
		return


	else if(src.sacredmeter >= src.sacredmeter_max)
		visible_message(span_notice("The well thrums with energy!"))
		sacredmeter -= src.sacredmetermax
		playsound(src, 'sound/mecha/mech_shield_raise.ogg', 80, 0, -1)
		dontspam()
		return

	return


/obj/structure/sacredwell/proc/dontspam()

	desc = "Toss yo shit in here, young'n. Has [sacredmeter] out of [sacredmeter_max] charge.<br><span class='notice'>It is currently cooling down.</span>"
	cooling = 1
	sleep(1000)
	cooling = 0
	desc = "Toss yo shit in here, young'n. Has [sacredmeter] out of [sacredmeter_max] charge.<br>"
	return