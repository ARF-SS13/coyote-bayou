// In this document: Custom clothing for patreons and others as of august 2021 on Fortune 13. Items must be labeled with the name of the person they
// are intended for and have the correct icon path included.


// WHISKEY //

/obj/item/clothing/suit/armor/f13/rangercombat/desert/whiskey
	name = "weathered ranger combat armor"
	desc = "(II) An original suit of pre-war combat armor used by elite military units, passed down through generations to where it is today. Though it's not lined with kevlar, this suit's still lightweight and easy to move around in."
	icon = 'icons/fallout/clothing/custom/custom.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/custom/custom.dmi'
	icon_state = "desert_ranger"
	item_state = "desert_ranger"
	armor = list("tier" = 2, "energy" = 20, "bomb" = 20, "bio" = 20, "rad" = 20, "fire" = 20, "acid" = 20)

/obj/item/clothing/suit/armor/f13/rangercombat/desert/whiskey/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/* New system version replace when switch
/obj/item/clothing/suit/armored/light/whiskey_desert
	name = "weathered ranger combat armor"
	desc = "A original suit of pre-war combat armor used by elite military units, passed down through generations to where it is today. Though it's not lined with kevlar, this suit's still lightweight and easy to move around in."
	icon_state = "desert_ranger"
	item_state = "desert_ranger"
	armor = list("tier" = 2, "energy" = 20, "bomb" = 20, "bio" = 20, "rad" = 20, "fire" = 20, "acid" = 20)
*/
