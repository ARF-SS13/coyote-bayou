/obj/item/melee/transforming/energy/plasmacutter
	hitsound_on = 'sound/weapons/blade1.ogg'
	heat = 3500
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = FIRE_PROOF
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_on = FALSE
	total_mass = 0.4 //Survival flashlights typically weigh around 5 ounces.

/obj/item/melee/transforming/energy/plasmacutter/Initialize()
	. = ..()
	total_mass_on = (total_mass_on ? total_mass_on : (w_class_on * 0.75))
	if(active)
		set_light_on(TRUE)
		START_PROCESSING(SSobj, src)

/obj/item/melee/transforming/energy/plasmacutter/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/melee/transforming/energy/plasmacutter/suicide_act(mob/user)
	if(!active)
		transform_weapon(user, TRUE)
	user.visible_message(span_suicide("[user] is [pick("slitting [user.p_their()] stomach open with", "falling on")] [src]! It looks like [user.p_theyre()] trying to commit seppuku!"))
	return (BRUTELOSS|FIRELOSS)

/obj/item/melee/transforming/energy/plasmacutter/add_blood_DNA(list/blood_dna)
	return FALSE

/obj/item/melee/transforming/energy/plasmacutter/get_sharpness()
	return active * sharpness

/obj/item/melee/transforming/energy/plasmacutter/process()
	open_flame()

/obj/item/melee/transforming/energy/plasmacutter/transform_weapon(mob/living/user, supress_message_text)
	. = ..()
	if(.)
		if(active)
			START_PROCESSING(SSobj, src)
			set_light_on(TRUE)
		else
			STOP_PROCESSING(SSobj, src)
			set_light_on(FALSE)

/obj/item/melee/transforming/energy/plasmacutter/get_temperature()
	return active * heat

/obj/item/melee/transforming/energy/plasmacutter/ignition_effect(atom/A, mob/user)
	if(!active)
		return ""

	var/in_mouth = ""
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.wear_mask)
			in_mouth = ", barely missing [C.p_their()] nose"
	. = span_warning("[user] swings [user.p_their()] [name][in_mouth]. [user.p_they(TRUE)] light[user.p_s()] [user.p_their()] [A.name] in the process.")
	playsound(loc, hitsound, get_clamped_volume(), 1, -1)
	add_fingerprint(user)

/obj/item/melee/transforming/energy/plasmacutter/sword
	name = "plasma cutter"
	desc = "A bright green plasma cutter."
	icon = 'icons/obj/items_and_weapons.dmi'
	item_state = "plasmacutter"
	icon_state = "plasmacutter"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 3
	throwforce = 5
	hitsound = "swing_hit" //it starts deactivated
	attack_verb_off = list("tapped", "poked")
	throw_speed = 3
	throw_range = 5
	sharpness = SHARP_EDGED
	armour_penetration = 0.4
	item_flags = NEEDS_PERMIT | ITEM_CAN_PARRY

/obj/item/melee/transforming/energy/plasmacutter/sword/adam
	name = "plasma cutter adam"
	desc = "A bright crimson plasma cutter."
	icon = 'icons/obj/items_and_weapons.dmi'
	item_state = "adamcutter"
	icon_state = "adamcutter"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 3
	throwforce = 5
	hitsound = "swing_hit" //it starts deactivated
	attack_verb_off = list("tapped", "poked")
	throw_speed = 3
	throw_range = 5
	sharpness = SHARP_EDGED
	armour_penetration = 0.2
	item_flags = NEEDS_PERMIT | ITEM_CAN_PARRY

/obj/item/melee/transforming/energy/plasmacutter/sword/eve
	name = "plasma cutter eve"
	desc = "A violet colored plasma cutter. An inscription on it reads: In the land of the shadow of death a light has dawned."
	icon = 'icons/obj/items_and_weapons.dmi'
	item_state = "evecutter"
	icon_state = "evecutter"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 3
	throwforce = 5
	hitsound = "swing_hit" //it starts deactivated
	attack_verb_off = list("tapped", "poked")
	throw_speed = 3
	throw_range = 5
	sharpness = SHARP_EDGED
	armour_penetration = 0.6
	item_flags = NEEDS_PERMIT | ITEM_CAN_PARRY
