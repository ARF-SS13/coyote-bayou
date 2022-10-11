/* not a caves of qud ripoff
technically mad shitcode for rn
plan is to ultimately have it pull from cargo export datum for how valuable stuff is
GLOBAL_LIST_INIT(sacredwellitems_components, typecacheof(list(/obj/item/advanced_crafting_components/flux,
	/obj/item/advanced_crafting_components/lenses,
	/obj/item/advanced_crafting_components/conductors,
	/obj/item/advanced_crafting_components/receiver,
	/obj/item/advanced_crafting_components/assembly,
	/obj/item/advanced_crafting_components/alloys)))
*/

// global lists

GLOBAL_LIST_INIT(sacredwellitems_components, typecacheof(list(/obj/item/stock_parts/capacitor/simple,
				/obj/item/stock_parts/scanning_module/simple,
				/obj/item/stock_parts/manipulator/simple,
				/obj/item/stock_parts/micro_laser/simple,
				/obj/item/stock_parts/matter_bin/simple,
				/obj/item/stock_parts/cell)))

GLOBAL_LIST_INIT(sacredwellitems_low, typecacheof(list(/obj/item/gun/energy/laser/pistol,
	/obj/item/stock_parts/cell/ammo,
	)))

GLOBAL_LIST_INIT(sacredwellitems_mid, typecacheof(	/obj/item/gun/energy/laser))

GLOBAL_LIST_INIT(sacredwellitems_high, typecacheof(	/obj/item/gun/energy/laser/plasma))


// objects

/obj/effect/spawner/lootdrop/f13/sacredwell
	lootcount = 1
	lootdoubles = FALSE
	loot = list(/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/tribal


// sacred items

/obj/item/gun/energy/laser/pistol/sacred
	name = "Blessed AEP7"
	desc = "Scorch the darkness of the Old World away. It is wrapped in ropes and braids, and has beads attached to it. A broken multicolored crystal at the front sends two weak beams skewing outwards to scorch."
	icon_state = "bAEP7"

	burst_size = 2


















/obj/structure/sacredwell
	name = "sacred well"
	density = 1
	anchored = 1
	var/sacredmeter = 0
	var/sacredmeter_max = 1000 //how much charge it needs before it does the thing
	var/cooling = 0
	desc = "A deep well that hums and thrums with power and unknown energies. Despite the fact it is hot to the touch, the geiger counter stays quiet. This is where the mistakes of the old world go to be cleansed. And with enough sacrifice comes gifts."
	icon = 'icons/obj/Ritas.dmi'
	icon_state = "wellwheel-filling"

/obj/structure/sacredwell/attackby(obj/item/W, mob/user)
	icon_state = "wellwheel-filling" //this makes the animation play. this is technically the most elegant way to do this. lmao
	if(src.cooling <= 0)

		if(W.type in GLOB.sacredwellitems_high)
			qdel(W)
			sacredmeter += 200
			update_meter()
			return

		if(W.type in GLOB.sacredwellitems_mid)
			qdel(W)
			sacredmeter += 150
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
			to_chat(user, span_danger("This is not appropriate for the well."))
			return

	else
		to_chat(user, span_danger("The spirits rest. The well is quiet."))
		return



/obj/structure/sacredwell/proc/update_meter() //checks if sacredmeter is above max, if it is, minuses sacredmeter_max from current amnt to simulate 'overflow'

	if(src.sacredmeter < src.sacredmeter_max)

		visible_message(span_notice("The well creaks as it delivers its material!"))
		playsound(src, 'sound/mecha/mech_shield_drop.ogg', 80, 0, -1)
		desc = "A deep well that hums and thrums with power and unknown energies. Despite the fact it is hot to the touch, the geiger counter stays quiet. This is where the mistakes of the old world go to be cleansed. And with enough sacrifice comes gifts.<br><span class='notice'> The well has [sacredmeter] out of [sacredmeter_max] charge.</span>"
		return


	else if(src.sacredmeter >= src.sacredmeter_max)
		visible_message(span_notice("The well creaks and hums- and out spews forth an item, blessed by the spirits. It is sanctified and safe."))
		sacredmeter -= src.sacredmeter_max
		playsound(src, 'sound/mecha/mech_shield_raise.ogg', 80, 0, -1)
		new /obj/effect/spawner/lootdrop/f13/sacredwell(src.loc)
		dontspam()
		return

	return


/obj/structure/sacredwell/proc/dontspam() //might need to fiddle w/ this......

	desc = "A deep well that hums and thrums with power and unknown energies. Despite the fact it is hot to the touch, the geiger counter stays quiet. This is where the mistakes of the old world go to be cleansed. And with enough sacrifice comes gifts.<br><span class='notice'> The well is currently resting.</span>"
	cooling = 1
	sleep(1000)
	cooling = 0
	desc = "A deep well that hums and thrums with power and unknown energies. Despite the fact it is hot to the touch, the geiger counter stays quiet. This is where the mistakes of the old world go to be cleansed. And with enough sacrifice comes gifts.<br><span class='notice'> The well has [sacredmeter] out of [sacredmeter_max] charge.</span>"
	return





















