/* not a caves of qud ripoff
technically mad shitcode for rn
plan is to ultimately have it pull from cargo export datum for how valuable stuff is

/obj/structure/fence/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/wirecutters))

*/

/obj/structure/sacredwell
	name = "sacredwell"
	desc = "Toss yo shit in here, young'n"
	var/sacredmeter = 400
	var/cooling = 0


/obj/structure/sacredwell/attackby(obj/item/W, mob/user)
	while(src.cooling == 0)

		if(istype(W, /obj/item/gun/energy/laser/))
			sacredmeter += 200
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