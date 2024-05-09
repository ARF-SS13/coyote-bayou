/obj/item/crowbar
	name = "crowbar"
	desc = "This handy tool is useful for lots of things, such as prying floor tiles or opening unpowered doors. Just holding it makes you feel like a free man. This can help robots repair critical damages."
	icon = 'icons/obj/tools.dmi'
	icon_state = "basicbar"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	usesound = 'sound/items/crowbar.ogg'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT
	force = 25
	force_unwielded = 25
	force_wielded = 35
	throwforce = 7
	var/praying = FALSE
	w_class = WEIGHT_CLASS_SMALL
	reskinnable_component = null

	custom_materials = list(/datum/material/iron=450)
	weapon_special_component = /datum/component/weapon_special/single_turf

	attack_verb = list("attacked", "bashed", "battered", "bludgeoned", "whacked")
	tool_behaviour = TOOL_CROWBAR
	toolspeed = 1
	armor = ARMOR_VALUE_GENERIC_ITEM

	wound_bonus = -10
	bare_wound_bonus = 5

/obj/item/crowbar/attack(mob/living/M, mob/living/user)
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

	user.visible_message(span_info("[user] kneels[M == user ? null : " next to [M]"] and begins messing with their covers."), \
		span_info("You kneel[M == user ? null : " next to [M]"] and begin messing with their covers. This will increase their healing rate."))

	praying = TRUE
	if(!target || !isrobotic(target))
		praying = FALSE
		return FALSE

	if(do_after(user, clamp(toolspeed*20, 0.5 SECONDS, 2 SECONDS), target = M))
		if(user.heal_reservoir >= 1)//Check for charges again because we might've used them up while waiting.
			user.heal_reservoir--
			M.reagents?.add_reagent(/datum/reagent/medicine/medbotchem, 10) //Crowbar heals the most, but only when heavily damaged
			to_chat(M, span_notice("[user] finished emergancy repairs on your body!"))
			praying = FALSE
			playsound(get_turf(target), 'sound/items/Crowbar.ogg', 100, 1)
			if(target.health < target.maxHealth)
				attack(target, user)
		else
			to_chat(user, span_notice("You can't find anything to fix on [target] right now. Check again later and maybe have a drink of water."))
			praying = FALSE

	if(do_after(user, 2 SECONDS, target = M)) 
		M.reagents?.add_reagent(/datum/reagent/medicine/medbotchem, 10) //Crowbar heals the most, but only when heavily damaged
		to_chat(M, span_notice("[user] finished emergancy repairs on your body!"))
		praying = FALSE
		playsound(get_turf(target), 'sound/items/Crowbar.ogg', 100, 1)
	else
		to_chat(user, span_notice("You were interrupted."))
		praying = FALSE

/obj/item/crowbar/red
	icon_state = "crowbar_red"
	toolspeed = 0.9

/obj/item/crowbar/brass
	name = "brass crowbar"
	desc = "A brass crowbar. It feels faintly warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon_state = "crowbar_clock"
	toolspeed = 0.5
	reskinnable_component = null

/obj/item/crowbar/abductor
	name = "ultracite crowbar"
	desc = "A hard-light crowbar. It appears to pry by itself, without any effort required."
	icon = 'icons/obj/abductor.dmi'
	usesound = 'sound/weapons/sonic_jackhammer.ogg'
	icon_state = "crowbar"
	toolspeed = 0.1
	reskinnable_component = null

/obj/item/crowbar/cyborg
	name = "hydraulic crowbar"
	desc = "A hydraulic prying tool, compact but powerful. Designed to replace crowbar in construction cyborgs."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "crowbar_cyborg"
	usesound = 'sound/items/jaws_pry.ogg'
	force = 10
	toolspeed = 0.5
	reskinnable_component = null

/obj/item/crowbar/power
	name = "jaws of life"
	desc = "A set of jaws of life, compressed through the magic of science. It's fitted with a prying head."
	icon_state = "jaws_pry"
	item_state = "jawsoflife"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	custom_materials = list(/datum/material/iron=150,/datum/material/silver=50,/datum/material/titanium=25)
	reskinnable_component = null

	usesound = 'sound/items/jaws_pry.ogg'
	force = 15
	toolspeed = 0.25

/obj/item/crowbar/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_jaws.ogg', 50, 1)
	var/obj/item/wirecutters/power/cutjaws = new /obj/item/wirecutters/power(drop_location())
	cutjaws.name = name
	to_chat(user, span_notice("You attach the cutting jaws to [src]."))
	qdel(src)
	user.put_in_active_hand(cutjaws)

/obj/item/crowbar/advanced
	name = "advanced crowbar"
	desc = "A scientist's almost successful reproduction of an abductor's crowbar, it uses the same technology combined with a handle that can't quite hold it."
	icon = 'icons/obj/advancedtools.dmi'
	usesound = 'sound/weapons/sonic_jackhammer.ogg'
	icon_state = "crowbar"
	toolspeed = 0.2
	reskinnable_component = null

//DR2 TOOLS

/obj/item/crowbar/crude
	name = "crude crowbar"
	desc = "A flattened piece of rusted pipe, barely enough to squeeze under most things, but helps get a firm grip."
	icon_state = "crudebar"
	toolspeed = 4
	reskinnable_component = null

/*
/obj/item/crowbar/basic
	name = "basic crowbar"
	desc = "A flattened and reinforced piece of rebar, bent a to a firm point and pretty flat."
	icon_state = "basicbar"
	toolspeed = 2
	reskinnable_component = null
*/

/obj/item/crowbar/hightech
	name = "prewar crowbar"
	desc = "A high carbon steel crowbar, very durable."
	icon_state = "crowbar"
	toolspeed = 0.1
	reskinnable_component = /datum/component/reskinnable/crowbar
