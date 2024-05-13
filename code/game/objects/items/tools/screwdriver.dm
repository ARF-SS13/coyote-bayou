/obj/item/screwdriver
	name = "screwdriver"
	desc = "A long, pointy rod with a handy knob on the base. Used to screw things. This can be used for general robot repairs"
	icon = 'icons/obj/tools.dmi'
	icon_state = "basicscrew"
	item_state = "basicscrew"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT
	force = 15
	force_unwielded = 15
	force_wielded = 20
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	var/praying = FALSE
	custom_materials = list(/datum/material/iron=75)
	attack_verb = list("stabbed")
	hitsound = 'sound/weapons/bladeslice.ogg'
	usesound = list('sound/items/screwdriver.ogg', 'sound/items/screwdriver2.ogg')
	tool_behaviour = TOOL_SCREWDRIVER
	toolspeed = 1
	armor = ARMOR_VALUE_GENERIC_ITEM
	reskinnable_component = null
	wound_bonus = -10
	bare_wound_bonus = 5

/obj/item/screwdriver/attack(mob/living/M, mob/living/user)
	if(user.a_intent == INTENT_HARM)
		return ..()

	var/mob/living/carbon/human/target = M
	if(!target || !isrobotic(target))
		return FALSE

	if(target.health >= target.maxHealth)//quick but dirty way
		to_chat(user, span_notice("[target] doesn't seem to need fixing right now."))
		return FALSE

	if(user.heal_reservoir < 1) //You have no healing charges remaining.
		to_chat(user, span_notice("You just can't find anything to fix on [M] right now. Check again later and maybe have a drink of water."))
		return FALSE

	if(praying)
		to_chat(user, span_notice("You are already using [src]."))
		return

	user.visible_message(span_info("[user] kneels[M == user ? null : "next to [M]"] and begins to tighten their bits."), \
		span_info("You kneel[M == user ? null : " next to [M]"] and begin tightening their bits."))

	praying = TRUE
	if(!target || !isrobotic(target))
		praying = FALSE
		return FALSE
	if(do_after(user, clamp(toolspeed*10, 0.5 SECONDS, 2 SECONDS), target = M))
		if(user.heal_reservoir >= 1)//Check for charges again because we might've used them up while waiting.
			user.heal_reservoir--
			M.adjustBruteLoss(-2.5, include_roboparts = TRUE) //Screwdriver is for healing both, but not well
			M.adjustFireLoss(-2.5, include_roboparts = TRUE)
			to_chat(M, span_notice("[user] provided general repairs to you!"))
			praying = FALSE
			playsound(get_turf(target), 'sound/items/screwdriver.ogg', 100, 1)
			if(target.health < target.maxHealth)
				attack(target, user)
		else
			to_chat(user, span_notice("You can't find anything to fix on [target] right now. Check again later and maybe have a drink of water."))
			praying = FALSE
	else
		to_chat(user, span_notice("You were interrupted."))
		praying = FALSE


/obj/item/screwdriver/Initialize()
	. = ..()
	if(prob(75))
		pixel_y = rand(0, 16)

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

/obj/item/screwdriver/worn_overlays(isinhands = FALSE, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(isinhands)
		var/mutable_appearance/M = mutable_appearance(icon_file, "screwdriver_head")
		M.appearance_flags = RESET_COLOR
		. += M

/obj/item/screwdriver/get_belt_overlay()
	var/datum/reskin/colorable_tool/myskin = get_current_skin()
	if(myskin?.colorize)
		var/mutable_appearance/body = mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "screwdriver")
		var/mutable_appearance/head = mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "screwdriver_head")
		body.color = color
		head.add_overlay(body)
		return head
	else
		return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', icon_state)

/obj/item/screwdriver/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(!istype(M))
		return ..()
	if(user.zone_selected != BODY_ZONE_PRECISE_EYES && user.zone_selected != BODY_ZONE_HEAD)
		return ..()
	return eyestab(M,user)

/obj/item/screwdriver/brass
	name = "brass screwdriver"
	desc = "A screwdriver made of brass. The handle feels freezing cold."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon_state = "screwdriver_clock"
	item_state = "screwdriver_brass"
	toolspeed = 0.5

/obj/item/screwdriver/bronze
	name = "bronze screwdriver"
	desc = "A screwdriver plated with bronze."
	icon_state = "screwdriver_brass"
	item_state = "screwdriver_brass"
	toolspeed = 0.95

/obj/item/screwdriver/abductor
	name = "ultracite screwdriver"
	desc = "An ultrasonic screwdriver."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "screwdriver_a"
	item_state = "screwdriver_nuke"
	usesound = 'sound/items/pshoom.ogg'
	toolspeed = 0.1
	reskinnable_component = null

/obj/item/screwdriver/abductor/get_belt_overlay()
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "screwdriver_nuke")

/obj/item/screwdriver/power
	name = "hand drill"
	desc = "A simple powered hand drill. It's fitted with a screw bit."
	icon_state = "drill_screw"
	item_state = "drill"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	custom_materials = list(/datum/material/iron=150,/datum/material/silver=50,/datum/material/titanium=25) //done for balance reasons, making them high value for research, but harder to get
	force = 8 //might or might not be too high, subject to change
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 8
	throw_speed = 2
	throw_range = 3//it's heavier than a screw driver/wrench, so it does more damage, but can't be thrown as far
	attack_verb = list("drilled", "screwed", "jabbed","whacked")
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 0.25
	reskinnable_component = null

/obj/item/screwdriver/power/attack_self(mob/user)
	playsound(get_turf(user),'sound/items/change_drill.ogg',50,1)
	var/obj/item/wrench/power/b_drill = new /obj/item/wrench/power(drop_location())
	to_chat(user, span_notice("You attach the bolt driver bit to [src]."))
	qdel(src)
	user.put_in_active_hand(b_drill)

/obj/item/screwdriver/cyborg
	name = "automated screwdriver"
	desc = "An electrical screwdriver, designed to be both precise and quick."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "screwdriver_cyborg"
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 0.5
	reskinnable_component = null

/obj/item/screwdriver/advanced
	name = "advanced screwdriver"
	desc = "A classy silver screwdriver with a polymer alloy tip, it works almost as well as the real thing." //Fortuna edit: alien alloy -> polymer
	icon = 'icons/obj/advancedtools.dmi'
	icon_state = "screwdriver_a"
	item_state = "screwdriver_nuke"
	usesound = 'sound/items/pshoom.ogg'
	toolspeed = 0.2
	reskinnable_component = null

//DR2 TOOLS

/obj/item/screwdriver/crude
	name = "crude screwdriver"
	desc = "A piece of junk metal sharpened to a point, worthwile as a shiv or crude turning device."
	icon_state = "crudescrew"
	item_state = "crudescrew"
	toolspeed = 4
	reskinnable_component = null

/*
/obj/item/screwdriver/basic
	name = "basic screwdriver"
	desc = "A refined tip of a jerry-rigged screwdriver, pretty accurate."
	icon_state = "basicscrew"
	item_state = "basicscrew"
	toolspeed = 2
	reskinnable_component = null
*/

/obj/item/screwdriver/hightech
	name = "prewar screwdriver"
	desc = "An excellent quality prewar screwdriver, made of sturdy high carbon machined steel."
	icon_state = "screwdriver_map"
	item_state = "screwdriver"
	toolspeed = 0.1
	reskinnable_component = /datum/component/reskinnable/screwdriver
