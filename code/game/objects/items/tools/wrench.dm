/obj/item/wrench
	name = "wrench"
	desc = "A wrench with common uses. Can be found in your hand. This can repair dents in robots."
	icon = 'icons/obj/tools.dmi'
	icon_state = "basicwrench2"
	item_state = "basicwrench"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT
	force = 25
	force_unwielded = 25
	force_wielded = 30
	throwforce = 7
	var/praying = FALSE
	w_class = WEIGHT_CLASS_SMALL
	usesound = 'sound/items/ratchet.ogg'
	custom_materials = list(/datum/material/iron=500)
	reskinnable_component = null

	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")
	tool_behaviour = TOOL_WRENCH
	toolspeed = 1
	armor = ARMOR_VALUE_GENERIC_ITEM
	wound_bonus = -10
	bare_wound_bonus = 5
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/wrench/attack(mob/living/M, mob/living/user)
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

	user.visible_message(span_info("[user] kneels[M == user ? null : " next to [M]"] and begins repairing their dents."), \
		span_info("You kneel[M == user ? null : " next to [M]"] and begin repairing any dents."))

	praying = TRUE
	if(!target || !isrobotic(target))
		praying = FALSE
		return FALSE

	if(do_after(user, clamp(toolspeed*10, 0.5 SECONDS, 2 SECONDS), target = M))
		if(user.heal_reservoir >= 1)//Check for charges again because we might've used them up while waiting.
			user.heal_reservoir--
			M.adjustBruteLoss(-5, include_roboparts = TRUE) //Wrench is for brute
			to_chat(M, span_notice("[user] finished repairing your dents!"))
			praying = FALSE
			playsound(get_turf(target), 'sound/items/trayhit2.ogg', 100, 1)
			if(target.health < target.maxHealth)
				attack(target, user)
		else
			to_chat(user, span_notice("You can't find anything to fix on [target] right now. Check again later and maybe have a drink of water."))
			praying = FALSE
	else
		to_chat(user, span_notice("You were interrupted."))
		praying = FALSE

/obj/item/wrench/afterattack(atom/A, mob/living/user, proximity)
	. = ..()
	if(!proximity || !wielded || IS_STAMCRIT(user))
		return
	if(istype(A, /obj/structure) || istype(A, /obj/machinery))
		var/obj/W = A
		W.take_damage(force, BRUTE, "melee", 0, attacked_by = user)

/obj/item/wrench/cyborg
	name = "automatic wrench"
	desc = "An advanced robotic wrench. Can be found in construction cyborgs."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "wrench_cyborg"
	toolspeed = 0.5

/obj/item/wrench/brass
	name = "brass wrench"
	desc = "A brass wrench. It's faintly warm to the touch."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon_state = "wrench_clock"
	toolspeed = 0.5

/obj/item/wrench/bronze
	name = "bronze plated wrench"
	desc = "A bronze plated wrench."
	icon_state = "wrench_brass"
	toolspeed = 0.95

/obj/item/wrench/abductor
	name = "ultracite wrench"
	desc = "A polarized wrench. It causes anything placed between the jaws to turn."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "wrench"
	usesound = 'sound/effects/empulse.ogg'
	toolspeed = 0.1

/obj/item/wrench/power
	name = "hand drill"
	desc = "A simple powered hand drill. It's fitted with a bolt bit."
	icon_state = "drill_bolt"
	item_state = "drill"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	usesound = 'sound/items/drill_use.ogg'
	custom_materials = list(/datum/material/iron=150,/datum/material/silver=50,/datum/material/titanium=25)
	//done for balance reasons, making them high value for research, but harder to get
	force = 8 //might or might not be too high, subject to change
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 8
	attack_verb = list("drilled", "screwed", "jabbed")
	toolspeed = 0.25

/obj/item/wrench/power/attack_self(mob/user)
	playsound(get_turf(user),'sound/items/change_drill.ogg',50,1)
	var/obj/item/wirecutters/power/s_drill = new /obj/item/screwdriver/power(drop_location())
	to_chat(user, span_notice("You attach the screw driver bit to [src]."))
	qdel(src)
	user.put_in_active_hand(s_drill)

/obj/item/wrench/medical
	name = "medical wrench"
	desc = "A medical wrench with common(medical?) uses. Can be found in your hand."
	icon_state = "wrench_medical"
	force = 2 //MEDICAL
	throwforce = 4

	attack_verb = list("wrenched", "medicaled", "tapped", "jabbed", "whacked")

/obj/item/wrench/advanced
	name = "advanced wrench"
	desc = "A wrench that uses the same magnetic technology that abductor tools use, but slightly more ineffeciently."
	icon = 'icons/obj/advancedtools.dmi'
	icon_state = "wrench"
	usesound = 'sound/effects/empulse.ogg'
	toolspeed = 0.2
	reskinnable_component = null

//DR2 TOOLS

/obj/item/wrench/crude
	name = "crude wrench"
	desc = "A bent bar, finnicky to use and requires a lot of effort for consant adjustments, better than your bare hand though."
	icon_state = "crudewrench"
	item_state = "crudewrench"
	toolspeed = 4
	reskinnable_component = null

/*
/obj/item/wrench/basic
	name = "basic wrench"
	desc = "A pipe with an old, wrench head on it."
	icon_state = "basicwrench"
	item_state = "basicwrench"
	toolspeed = 2
	reskinnable_component = null
*/

/obj/item/wrench/hightech
	name = "prewar wrench"
	desc = "A drop forged wrench, very durable and well made."
	icon_state = "wrench"
	item_state = "wrench"
	toolspeed = 0.1
	reskinnable_component = /datum/component/reskinnable/wrench

// Sledgehammer			Keywords: Damage 25/45, Blacksmithing
/obj/item/wrench/sledgehammer
	name = "buster wrench"
	desc = "An unusually large wrench that appears equally adept at bashing skulls and turning bolts. Why it has to be so damn big is anyone's guess, but you can't deny that it feels satisfying to swing."
	item_state = "altevian-wrench"
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK

	icon = 'icons/obj/revwrench.dmi'
	icon_state = "altevian-wrench"
	wielded_icon = "altevian-wrench"
	mob_overlay_icon = 'icons/obj/revwrenchback.dmi'
	lefthand_file = 'icons/obj/revwrenchleft.dmi'
	righthand_file = 'icons/obj/revwrenchright.dmi'
	toolspeed = 1
	force = 30
	throwforce = 20 // Huge hammers aren't that great for throwing
	sharpness = SHARP_NONE
	attack_verb = list("bashed", "pounded", "bludgeoned", "pummeled", "thrashed")
	force_wielded = 70
	force_unwielded = 30
	attack_speed = CLICK_CD_MELEE * 1.8 //14.4

/obj/item/wrench/sledgehammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/jousting/sledge)



