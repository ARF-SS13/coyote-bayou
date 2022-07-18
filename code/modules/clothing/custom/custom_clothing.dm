// In this document: Custom clothing for patreons and others as of august 2021 on Fortune 13. Items must be labeled with the name of the person they
// are intended for and have the correct icon path included.


// WHISKEY //

/obj/item/clothing/suit/armor/medium/combat/desert_ranger/whiskey
	name = "weathered ranger combat armor"
	desc = "An original suit of pre-war combat armor used by elite military units, passed down through generations to where it is today. Though it's not lined with kevlar, this suit's still lightweight and easy to move around in."
	icon = 'icons/fallout/clothing/custom/custom.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/custom/custom.dmi'
	icon_state = "desert_ranger"
	item_state = "desert_ranger"
	armor = list("melee" = 20, "bullet" = 30, "laser" = 10, "energy" = 20, "bomb" = 30, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/armor/medium/combat/desert_ranger/whiskey/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/* New system version replace when switch
/obj/item/clothing/suit/armor/light/whiskey_desert
	name = "weathered ranger combat armor"
	desc = "A original suit of pre-war combat armor used by elite military units, passed down through generations to where it is today. Though it's not lined with kevlar, this suit's still lightweight and easy to move around in."
	icon_state = "desert_ranger"
	item_state = "desert_ranger"
	armor = list("melee" = 20, "bullet" = 30, "laser" = 10, "energy" = 20, "bomb" = 30, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
*/

// YEEHAWGYVNAH/"Trinity Kemble" //
/obj/item/clothing/suit/armor/trailranger/kemble
	name = "riot vest"
	desc = "An armored chestplate ripped out of old riot gear."
	icon_state = "kemble"
	item_state = "kemble"

/obj/item/clothing/head/f13/trailranger/kemble
	name = "ranger's slouch hat"
	desc = "A comfortable slouch hat, reinforced with ballistic fibres. Although it has the remnants of a pair of night vision goggles still strapped to it, they're non-functional..."
	icon_state = "kemble"
	item_state = "kemble"
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/head/f13/trailranger/kemble/attack_self(mob/user)
	weldingvisortoggle(user)
	icon_state = "kembleup"
	item_state = "kembleup"

/obj/item/storage/belt/holster/kemble
	name = "ranger overcoat"
	desc = "An insulated coat taken from a set of riot gear. This one is apparently reversible (alt-click to toggle colours)."
	icon_state = "kemblecoat_green"
	item_state = "kemblecoat_green"
	alternate_worn_layer = HAIR_LAYER-1

/obj/item/storage/belt/holster/kemble/AltClick(mob/user)
	..()
	if(icon_state == "kemblecoat_green")
		icon_state = "kemblecoat_tan"
		item_state = "kemblecoat_tan"
		to_chat(user, "You reverse the coat to show the tan side.")
	else
		icon_state = "kemblecoat_green"
		item_state = "kemblecoat_green"
		to_chat(user, "You reverse the coat to show the green side.")
