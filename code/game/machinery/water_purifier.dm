/obj/machinery/water_purifier
	name = "water purifier"
	desc = "An advanced piece of machinery that purifies irradiated or otherwise contaminated water."
	icon = 'icons/obj/waterpurifier.dmi'
	icon_state = "purifier"

	flags_1 = NODECONSTRUCT_1
	move_resist = INFINITY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	use_power = NO_POWER_USE
	density = TRUE

	/// The beaker/container currently in the machine
	var/obj/item/reagent_containers/output = null
	/// How many units it adds per tick
	var/speed = 5
	/// What reagent it adds?
	var/datum/reagent/reagent_type = /datum/reagent/water/purified

/obj/machinery/water_purifier/Destroy()
	QDEL_NULL(output)
	return ..()

/obj/machinery/water_purifier/process()
	if(!is_operational())
		return

	if(!output || output.reagents.total_volume >= output.reagents.maximum_volume)
		return

	output.reagents.add_reagent(reagent_type, speed)
	update_icon()

/obj/machinery/water_purifier/attackby(obj/item/O, mob/user, params)
	if(user.a_intent == INTENT_HARM)
		return ..()

	if(istype(O, /obj/item/reagent_containers))
		. = TRUE //no afterattack
		if(output)
			to_chat(user, "<span class='warning'>Remove [output] from the machine first.</span>")
			return
		if(!user.transferItemToLoc(O, src))
			return
		to_chat(user, "<span class='notice'>You install [O] in the slot and [lowertext(initial(reagent_type.name))] starts to fill it.</span>")
		output = O
		update_icon()
		return

	to_chat(user, "<span class='warning'>You cannot install [O] into the machine.</span>")
	return

/obj/machinery/water_purifier/on_attack_hand(mob/living/carbon/user)
	if(output && user && Adjacent(usr))
		output.forceMove(drop_location())
		if(user.can_hold_items())
			user.put_in_hands(output)
		output = null
		update_icon()
		return
	return ..()

/obj/machinery/water_purifier/update_overlays()
	. = ..()
	if(output)
		if(output.reagents.total_volume)
			var/mutable_appearance/filling_overlay = mutable_appearance(icon, "output")

			var/percent = round((output.reagents.total_volume / output.volume) * 100)
			switch(percent)
				if(0 to 12)
					filling_overlay.icon_state = "output-0"
				if(13 to 24)
					filling_overlay.icon_state = "output-12-5"
				if(25 to 37)
					filling_overlay.icon_state = "output-25"
				if(38 to 49)
					filling_overlay.icon_state = "output-37-5"
				if(50 to 62)
					filling_overlay.icon_state = "output-50"
				if(63 to 74)
					filling_overlay.icon_state = "output-62-5"
				if(75 to 87)
					filling_overlay.icon_state = "output-75"
				if(88 to 99)
					filling_overlay.icon_state = "output-87-5"
				if(100 to INFINITY)
					filling_overlay.icon_state = "output-100"

			filling_overlay.color = list(mix_color_from_reagents(output.reagents.reagent_list))
			. += filling_overlay

/obj/machinery/water_purifier/examine(mob/user)
	. += ..()
	var/percent = round((output.reagents.total_volume / output.volume) * 100)
	if(output)
		. += "<span class='notice'>[output] is [percent]% full.</span>"
	else
		. += "<span class='notice'>[src] has no reagent container installed.</span>"

