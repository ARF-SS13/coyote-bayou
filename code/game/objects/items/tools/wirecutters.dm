/obj/item/wirecutters
	name = "wirecutters"
	desc = "This cuts wires, and can repair damaged wires in robots."
	icon = 'icons/obj/tools.dmi'
	icon_state = "basicwire"
	inhand_icon_state = "basicwire"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT
	force = 16
	force_unwielded = 16
	force_wielded = 22
	throw_speed = 3
	throw_range = 7
	var/praying = FALSE
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=500)
	attack_verb = list("pinched", "nipped")
	hitsound = 'sound/items/wirecutter.ogg'
	usesound = 'sound/items/wirecutter.ogg'
	reskinnable_component = /datum/component/reskinnable/wirecutters
	tool_behaviour = TOOL_WIRECUTTER
	toolspeed = 1
	armor = ARMOR_VALUE_GENERIC_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf
	block_parry_data = /datum/block_parry_data/bokken

/obj/item/wirecutters/attack(mob/living/M, mob/living/user)
	if(user.a_intent == INTENT_HARM)
		return ..()

	var/mob/living/carbon/human/target = M
	if(!target || !isrobotic(target))
		return FALSE

	if(praying)
		to_chat(user, span_notice("You are already using [src]."))
		return

	user.visible_message(span_info("[user] kneels[M == user ? null : "next to [M]"] and begins to fix their burns."), \
		span_info("You kneel[M == user ? null : " next to [M]"] and begin repairing their burns."))

	praying = TRUE
	if(!target || !isrobotic(target))
		praying = FALSE
		return FALSE
	if(do_after(user, 1 SECONDS, target = M)) 
		to_chat(M, span_notice("[user] finished fixing your burns!")) //Wirecutters if for burns
		M.adjustFireLoss(-5, include_roboparts = TRUE) 
		praying = FALSE
		playsound(get_turf(target), 'sound/items/Deconstruct.ogg', 100, 1)
	else
		to_chat(user, span_notice("You were interrupted."))
		praying = FALSE

/obj/item/wirecutters/proc/colorize(set_color)
	update_icon()

/obj/item/wirecutters/update_overlays()
	. = ..()
	cut_overlays()
	var/datum/reskin/colorable_tool/myskin = get_current_skin()
	if(!myskin)
		return
	icon_state = myskin.icon_state
	if(!myskin.colorize)
		return
	add_atom_colour(myskin.get_color(src), FIXED_COLOUR_PRIORITY)
	. += myskin.get_overlays(src)

/obj/item/wirecutters/attack(mob/living/carbon/C, mob/user)
	if(istype(C) && C.handcuffed && istype(C.handcuffed, /obj/item/restraints/handcuffs/cable))
		user.visible_message(span_notice("[user] cuts [C]'s restraints with [src]!"))
		qdel(C.handcuffed)
		return
	else
		..()

/obj/item/wirecutters/brass
	name = "brass wirecutters"
	desc = "A pair of eloquent wirecutters made of brass. The handle feels freezing cold to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon_state = "cutters_clock"
	toolspeed = 0.5
	reskinnable_component = null

/obj/item/wirecutters/bronze
	name = "bronze plated wirecutters"
	desc = "A pair of wirecutters plated with bronze."
	icon_state = "cutters_brass"
	toolspeed = 0.95 //Wire cutters have 0 time bars though
	reskinnable_component = null

/obj/item/wirecutters/abductor
	name = "ultracite wirecutters"
	desc = "Extremely sharp wirecutters, made out of a silvery-green metal."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "cutters"
	toolspeed = 0.1
	reskinnable_component = null

/obj/item/wirecutters/cyborg
	name = "wirecutters"
	desc = "This cuts wires."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "wirecutters_cyborg"
	toolspeed = 0.5
	reskinnable_component = null

/obj/item/wirecutters/power
	name = "jaws of life"
	desc = "A set of jaws of life, compressed through the magic of science. It's fitted with a cutting head."
	icon_state = "jaws_cutter"
	inhand_icon_state = "jawsoflife"
	reskinnable_component = null

	custom_materials = list(/datum/material/iron=150,/datum/material/silver=50,/datum/material/titanium=25)
	usesound = 'sound/items/jaws_cut.ogg'
	toolspeed = 0.25

/obj/item/wirecutters/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_jaws.ogg', 50, 1)
	var/obj/item/crowbar/power/pryjaws = new /obj/item/crowbar/power(drop_location())
	pryjaws.name = name
	to_chat(user, span_notice("You attach the pry jaws to [src]."))
	qdel(src)
	user.put_in_active_hand(pryjaws)

/obj/item/wirecutters/power/attack(mob/living/carbon/C, mob/user)
	if(istype(C))
		if(C.handcuffed)
			user.visible_message(span_notice("[user] cuts [C]'s restraints with [src]!"))
			qdel(C.handcuffed)
			return
		else if(C.has_status_effect(STATUS_EFFECT_CHOKINGSTRAND))
			var/man = C == user ? "your" : "[C]'\s"
			user.visible_message(span_notice("[user] attempts to remove the durathread strand from around [man] neck."), \
								span_notice("You attempt to remove the durathread strand from around [man] neck."))
			if(do_after(user, 15, null, C))
				user.visible_message(span_notice("[user] succesfuly removes the durathread strand."),
									span_notice("You succesfuly remove the durathread strand."))
				C.remove_status_effect(STATUS_EFFECT_CHOKINGSTRAND)
			return
	..()

/obj/item/wirecutters/advanced
	name = "advanced wirecutters"
	desc = "A set of reproduction alien wirecutters, they have a silver handle with an exceedingly sharp blade."
	icon = 'icons/obj/advancedtools.dmi'
	icon_state = "cutters"
	toolspeed = 0.2
	reskinnable_component = null

//DR2 TOOLS

/obj/item/wirecutters/crude
	name = "crude cutters"
	desc = "Literally just a piece of bent and scraped junk metal, enough to cut something, but extremly unwieldly and worthless. Mainly just ripping with weight behind it."
	inhand_icon_state = "crudewire"
	icon_state = "crudewire"
	toolspeed = 4
	reskinnable_component = null

/*
/obj/item/wirecutters/basic
	name = "basic cutters"
	desc = "Almost sharpened cutters, maded of sharpened rusted metal and multiple parts."
	icon_state = "basicwire"
	inhand_icon_state = "basicwire"
	toolspeed = 2
	reskinnable_component = null
*/

/obj/item/wirecutters/hightech
	name = "prefall wirecutters"
	desc = "A set of high quality machined cutters."
	icon_state = "cutters_map"
	inhand_icon_state = "cutters"
	toolspeed = 0.1
	reskinnable_component = null
