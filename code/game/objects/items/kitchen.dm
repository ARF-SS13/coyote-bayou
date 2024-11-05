/* Kitchen tools
 * Contains:
 *		Fork
 *		Kitchen knives
 *		Ritual Knife
 *		Bloodletter
 *		Butcher's cleaver
 *		Combat Knife
 *		Rolling Pins
 */

/obj/item/kitchen
	icon = 'icons/fallout/objects/kitchen.dmi'
	lefthand_file = 'icons/fallout/onmob/tools/kitchen_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/kitchen_righthand.dmi'
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK

/obj/item/kitchen/fork
	name = "fork"
	desc = "Pointy."
	icon_state = "fork"
	force = 14
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron=80)
	flags_1 = CONDUCT_1
	attack_verb = list("attacked", "stabbed", "poked")
	hitsound = 'sound/weapons/bladeslice.ogg'
	armor = ARMOR_VALUE_GENERIC_ITEM
	sharpness = SHARP_POINTY
	var/datum/reagent/forkload //used to eat omelette

/obj/item/kitchen/fork/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(!istype(M))
		return ..()

	if(forkload)
		if(M == user)
			M.visible_message(span_notice("[user] eats a delicious forkful of omelette!"))
			M.reagents.add_reagent(forkload.type, 1)
		else
			M.visible_message(span_notice("[user] feeds [M] a delicious forkful of omelette!"))
			M.reagents.add_reagent(forkload.type, 1)
		icon_state = "fork"
		forkload = null

	else if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
		return eyestab(M,user)
	else
		return ..()

/obj/item/kitchen/knife
	name = "kitchen knife"
	desc = "A simple knife, best suited to cut stuff that doesn't cut back."
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	icon_state = "knife_kitchen"
	inhand_icon_state = "knife"
	flags_1 = CONDUCT_1
	force = WEAPON_FORCE_SLASH_SMALL
	w_class = WEIGHT_CLASS_SMALL
	throwforce = WEAPON_FORCE_SLASH_SMALL
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 6
	custom_materials = list(/datum/material/iron=4000)
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_POINTY
	armor = ARMOR_VALUE_GENERIC_ITEM
	var/bayonet = FALSE	//Can this be attached to a gun?
	wound_bonus = -5
	bare_wound_bonus = 10
	custom_price = PRICE_NORMAL
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/kitchen/knife/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 80 - force, 100, force - 10) //bonus chance increases depending on force

/obj/item/kitchen/knife/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
		return eyestab(M,user)
	else
		return ..()

/obj/item/kitchen/knife/butcher
	name = "butcher's cleaver"
	icon_state = "knife_butcher"
	desc = "Keep hackin' and whackin' and smackin'."
	flags_1 = CONDUCT_1
	force = 25
	throwforce = 15
	custom_materials = list(/datum/material/iron=6000)
	attack_verb = list("cleaved", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	w_class = WEIGHT_CLASS_NORMAL
	custom_price = PRICE_EXPENSIVE


/obj/item/kitchen/rollingpin
	name = "rolling pin"
	desc = "Used to knock out the Bartender."
	icon_state = "rolling_pin"
	force = 16
	throwforce = 5
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 1.5)
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "whacked")
	custom_price = PRICE_ALMOST_CHEAP
	

/obj/item/melee/onehanded/club/fryingpan/pot
	name = "Small Pot"
	desc = "A small black pot!"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "small_pot"
	force = 15
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron=80)
	flags_1 = CONDUCT_1
	attack_verb = list("bonked", "thwaked", "smacked")
	hitsound = 'sound/weapons/bladeslice.ogg'
	armor = ARMOR_VALUE_GENERIC_ITEM

/obj/item/weapon/copperpot
	name = "Copper Pot"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "copperpot1"
	desc = "A dull copper pot"

/obj/item/weapon/copperpot2
	name = "Copper Pot"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "copperpot2"
	desc = "A dull copper pot"

/obj/item/weapon/spatula
	name = "spatula"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "spatula"
	desc = "Come on and flip it! Flip it real good!"
