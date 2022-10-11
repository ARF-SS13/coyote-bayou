/* not a caves of qud ripoff
technically mad shitcode for rn
plan is to ultimately have it pull from cargo export datum for how valuable stuff is
*/


GLOBAL_LIST_INIT(sacredwellitems_components, typecacheof(/obj/item/advanced_crafting_components/flux,
	/obj/item/advanced_crafting_components/lenses,
	/obj/item/advanced_crafting_components/conductors,
	/obj/item/advanced_crafting_components/receiver,
	/obj/item/advanced_crafting_components/assembly,
	/obj/item/advanced_crafting_components/alloys))

GLOBAL_LIST_INIT(sacredwellitems_low, typecacheof(/obj/item/gun/energy/laser/pistol))

GLOBAL_LIST_INIT(sacredwellitems_mid, typecacheof(	/obj/item/gun/energy/laser))

GLOBAL_LIST_INIT(sacredwellitems_high, typecacheof(	/obj/item/gun/energy/laser/scatter))



/obj/structure/sacredwell
	name = "sacred well"
	density = 1
	var/sacredmeter = 0
	var/sacredmeter_max = 1000 //how much charge it needs before it does the thing
	var/cooling = 0
	desc = "A well leading down into the deeper layer of the bunker, where the Brotherhood is busy excavating the armory and supply caches. Toss in artefacts for spare parts and safe-keeping, and occasionally get something in return as they discover hidden items."
	icon_state = "wellwheel-filling"
	icon = 'icons/obj/Ritas.dmi'

/obj/structure/sacredwell/attackby(obj/item/W, mob/user)
	icon_state = "wellwheel-filling" //this makes the animation play. this is technically the most elegant way to do this. lmao
	if(src.cooling <= 0)

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

		else if(W.type in GLOB.sacredwellitems_components)
			qdel(W)
			sacredmeter += 100
			update_meter()
			return

		else
			to_chat(user, span_danger("Why would you waste the crew's time with this?"))
			return

	else
		to_chat(user, span_danger("The crew is resting. Hold your horses, cowboy."))
		return



/obj/structure/sacredwell/proc/update_meter() //checks if sacredmeter is above max, if it is, minuses sacredmeter_max from current amnt to simulate 'overflow'

	if(src.sacredmeter < src.sacredmeter_max)

		visible_message(span_notice("The well creaks as it delivers its material!"))
		playsound(src, 'sound/mecha/mech_shield_drop.ogg', 80, 0, -1)
		desc = "A well leading down into the deeper layer of the bunker, where the Brotherhood is busy excavating the armory and supply caches. Toss in artefacts for spare parts and safe-keeping, and occasionally get something in return as they discover hidden items.<br><span class='notice'> The crew has [sacredmeter] out of [sacredmeter_max] spare parts.</span>"
		return


	else if(src.sacredmeter >= src.sacredmeter_max)
		visible_message(span_notice("The well creaks and hums!"))
		sacredmeter -= src.sacredmeter_max
		playsound(src, 'sound/mecha/mech_shield_raise.ogg', 80, 0, -1)
		new /obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/garbagetomid(src.loc)
		dontspam()
		return

	return


/obj/structure/sacredwell/proc/dontspam() //might need to fiddle w/ this......

	desc = "A well leading down into the deeper layer of the bunker, where the Brotherhood is busy excavating the armory and supply caches. Toss in artefacts for spare parts and safe-keeping, and occasionally get something in return as they discover hidden items.<br><span class='notice'> The work crew has signalled they are resting.</span>"
	cooling = 1
	sleep(1000)
	cooling = 0
	desc = "A well leading down into the deeper layer of the bunker, where the Brotherhood is busy excavating the armory and supply caches. Toss in artefacts for spare parts and safe-keeping, and occasionally get something in return as they discover hidden items.<br><span class='notice'> The crew has [sacredmeter] out of [sacredmeter_max] spare parts.</span>"
	return
