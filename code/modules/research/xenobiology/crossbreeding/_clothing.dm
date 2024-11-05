/*
Slimecrossing Armor
	Armor added by the slimecrossing system.
	Collected here for clarity.
*/

//Rebreather mask - Chilling Blue
/obj/item/clothing/mask/nobreath
	name = "rebreather mask"
	desc = "A transparent mask, resembling a conventional breath mask, but made of bluish slime. Seems to lack any air supply tube, though."
	icon_state = "slime"
	inhand_icon_state = "slime"
	body_parts_covered = NONE
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0
	permeability_coefficient = 0.5
	flags_cover = MASKCOVERSMOUTH
	resistance_flags = NONE

/obj/item/clothing/mask/nobreath/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_MASK)
		ADD_TRAIT(user, TRAIT_NOBREATH, "breathmask_[REF(src)]")
		user.failed_last_breath = FALSE
		user.clear_alert("not_enough_oxy")
		user.apply_status_effect(/datum/status_effect/rebreathing)

/obj/item/clothing/mask/nobreath/dropped(mob/living/carbon/human/user)
	..()
	REMOVE_TRAIT(user, TRAIT_NOBREATH, "breathmask_[REF(src)]")
	user.remove_status_effect(/datum/status_effect/rebreathing)

/obj/item/clothing/glasses/prism_glasses
	name = "prism glasses"
	desc = "The lenses seem to glow slightly, and reflect light into dazzling colors."
	icon = 'icons/obj/slimecrossing.dmi'
	icon_state = "prismglasses"
	actions_types = list(/datum/action/item_action/change_prism_colour, /datum/action/item_action/place_light_prism)
	var/glasses_color = "#FFFFFF"

/obj/item/clothing/glasses/prism_glasses/item_action_slot_check(slot)
	if(slot == SLOT_GLASSES)
		return TRUE

/obj/structure/light_prism
	name = "light prism"
	desc = "A shining crystal of semi-solid light. Looks fragile."
	icon = 'icons/obj/slimecrossing.dmi'
	icon_state = "lightprism"
	density = FALSE
	anchored = TRUE
	max_integrity = 10
	light_system = MOVABLE_LIGHT
	light_range = 5

/obj/structure/light_prism/Initialize(mapload, newcolor)
	. = ..()
	if(newcolor)
		color = newcolor
		set_light_color(newcolor)

/obj/structure/light_prism/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	to_chat(user, span_notice("You dispel [src]"))
	qdel(src)

/datum/action/item_action/change_prism_colour
	name = "Adjust Prismatic Lens"
	icon_icon = 'icons/obj/slimecrossing.dmi'
	button_icon_state = "prismcolor"

/datum/action/item_action/change_prism_colour/Trigger()
	if(!IsAvailable())
		return
	var/obj/item/clothing/glasses/prism_glasses/glasses = target
	var/new_color = input(owner, "Choose the lens color:", "Color change",glasses.glasses_color) as color|null
	if(!new_color)
		return
	glasses.glasses_color = new_color

/datum/action/item_action/place_light_prism
	name = "Fabricate Light Prism"
	icon_icon = 'icons/obj/slimecrossing.dmi'
	button_icon_state = "lightprism"

/datum/action/item_action/place_light_prism/Trigger()
	if(!IsAvailable())
		return
	var/obj/item/clothing/glasses/prism_glasses/glasses = target
	if(locate(/obj/structure/light_prism) in get_turf(owner))
		to_chat(owner, span_warning("There isn't enough ambient energy to fabricate another light prism here."))
		return
	if(istype(glasses))
		if(!glasses.glasses_color)
			to_chat(owner, span_warning("The lens is oddly opaque..."))
			return
		to_chat(owner, span_notice("You channel nearby light into a glowing, ethereal prism."))
		new /obj/structure/light_prism(get_turf(owner), glasses.glasses_color)

/obj/item/clothing/head/peaceflower
	name = "entrancing bud"
	desc = "An extremely addictive flower, full of peace magic. This rare flower is not often seen due to its entrancing pacifying effects when worn. Its behavior can be altered with shift+ctrl click"
	icon = 'icons/obj/slimecrossing.dmi'
	icon_state = "peaceflower1"
	inhand_icon_state = "peaceflower1"
	slot_flags = INV_SLOTBIT_HEAD
	body_parts_covered = NONE
	dynamic_hair_suffix = ""
	force = 0
	throwforce = 0
	light_on = TRUE
	light_color = "#BC8F8F"
	light_range = 4
	light_power = 1
	var/slurpinlumens = FALSE
	light_system = MOVABLE_LIGHT
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 3


/obj/item/clothing/head/peaceflower/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_HEAD)
		ADD_TRAIT(user, TRAIT_PACIFISM, "peaceflower_[REF(src)]")
		user.AddElement(/datum/element/photosynthesis, -1, -1, -1, -1, 4, 0.5, 0.2, 0)

/obj/item/clothing/head/peaceflower/dropped(mob/living/carbon/human/user)
	..()
	REMOVE_TRAIT(user, TRAIT_PACIFISM, "peaceflower_[REF(src)]")
	user.RemoveElement(/datum/element/photosynthesis, -1, -1, -1, -1, 4, 0.5, 0.2, 0)

/obj/item/clothing/head/peaceflower/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)

	if(slurpinlumens)
		to_chat(user, span_notice("You are already eating light, be patient."))
		return

	slurpinlumens = TRUE
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.head)
			to_chat(user, span_notice("You begin channeling the flower to reduce your radiation."))
			if(do_after(user, 5 SECONDS, target = C, allow_movement = TRUE))
				C.reagents?.add_reagent(/datum/reagent/medicine/radaway, 10)
				slurpinlumens = FALSE
				to_chat(user, span_notice("Your radiation slowly fades away.."))
		slurpinlumens = FALSE
	else
		to_chat(user, span_notice("You were interrupted."))
		slurpinlumens = FALSE

	return ..()

/obj/item/clothing/head/peaceflower/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, src)

/obj/item/clothing/head/peaceflower/CtrlShiftClick(mob/user)
	var/static/list/choices = list(
			"Light On" = image(icon = 'icons/fallout/objects/items.dmi', icon_state = "match_lit"),
			"Light Off" = image(icon = 'icons/fallout/objects/items.dmi', icon_state = "match_unlit"),
			"Destroy Flower" = image(icon = 'icons/fallout/objects/bureaucracy.dmi', icon_state = "paperplane_onfire"),
			"Create A Flower" = image(icon = 'icons/obj/slimecrossing.dmi', icon_state = "peaceflower1")
		)
	var/choice = show_radial_menu(user, src, choices, radius = 32, require_near = TRUE)
	switch(choice)
		if("Light Off")
			set_light_on(FALSE)
			balloon_alert(user, "The flower closes.")
		if("Light On") // The photosynth thing works, but literally only once. I don't know how to make it work constantly.
			set_light_on(TRUE)
			balloon_alert(user, "The flower blooms")
		if("Destroy Flower")
			to_chat(user, span_notice("The flower begins to wither atop your head."))
			if(do_after(user, 15 SECONDS, stay_close = FALSE))
				REMOVE_TRAIT(user, TRAIT_PACIFISM, "peaceflower_[REF(src)]")
				user.RemoveElement(/datum/element/photosynthesis, -1, -1, -1, -1, 4, 0.5, 0.2, 0)
				drop_location(src)
				qdel(src)
		if("Create A Flower")
			to_chat(user, span_notice("The flower begins to bloom atop your head."))
			if(do_after(user, 20 SECONDS, stay_close = FALSE))
				new /obj/item/clothing/head/peaceflower(get_turf(src))
		else
			return

/obj/item/clothing/suit/armor/heavy/adamantine
	name = "adamantine armor"
	desc = "A full suit of adamantine plate armor. Impressively resistant to damage, but weighs about as much as you do."
	icon_state = "adamsuit"
	inhand_icon_state = "adamsuit"
	flags_inv = NONE
	obj_flags = IMMUTABLE_SLOW
	slowdown = 4
	var/hit_reflect_chance = 10 // Citadel Change: because 40% chance of bouncing lasers back into peoples faces isn't good.
	armor = ARMOR_VALUE_PA

/obj/item/clothing/suit/armor/heavy/adamantine/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(is_energy_reflectable_projectile(object) && prob(hit_reflect_chance))
		return BLOCK_SUCCESS | BLOCK_REDIRECTED | BLOCK_SHOULD_REDIRECT | BLOCK_PHYSICAL_INTERNAL
	return ..()
