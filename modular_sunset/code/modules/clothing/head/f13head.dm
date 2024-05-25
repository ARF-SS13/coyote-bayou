/*
Just leaving this here for quick copy-pasting, for future contributors.
	icon = 'modular_sunset/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_sunset/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_sunset/icons/mob/clothing/head_muzzled.dmi'
	mutantrace_variation = STYLE_MUZZLE
	!!If your hat/helmet covers face and don't have snout-adapted sprites, then use `mutantrace_variation = NONE` instead. Should hide snout sprite when helmet is worn.
	!!Or if your sprite covers the snout part anyway, use `mutantrace_variation = STYLE_NO_ANTHRO_ICON` instead.
*/

/obj/item/clothing/head/helmet/f13/goner
	name = "dev-marked generic helmet"
	desc = "A non-existent cheap-looking helmet.<br><b>If you see it, then it means universe broke <u>even more</u>.</b>"
	icon = 'modular_sunset/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_sunset/icons/mob/clothing/head.dmi'
	icon_state = "goner_helmet"
	armor = ARMOR_VALUE_LIGHT
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/head/helmet/f13/goner/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/goner/red
	name = "red-marked generic helmet"
	desc = "A cheap-looking helmet with red paint applied from front to back.<br>Perfect-shaped for small moths to sit on."
	icon_state = "goner_helmet_r"

/obj/item/clothing/head/helmet/f13/goner/green
	name = "green-marked generic helmet"
	desc = "A cheap-looking helmet with green paint applied from front to back.<br>Will not protect you much from the bombs, and especially not while in cardboard box."
	icon_state = "goner_helmet_g"

/obj/item/clothing/head/helmet/f13/goner/blue
	name = "blue-marked generic helmet"
	desc = "A cheap-looking helmet with blue paint applied from front to back.<br>Seems to be a perfect fit for the wasted people."
	icon_state = "goner_helmet_b"

/obj/item/clothing/head/helmet/f13/goner/yellow
	name = "yellow-marked generic helmet"
	desc = "A cheap-looking helmet with yellow paint applied from front to back.<br>Doesn't seem superior than other helmets."
	icon_state = "goner_helmet_y"

/obj/item/clothing/head/helmet/f13/goner/officer
	name = "peaked dev cap"
	desc = "A non-existent militaristic cap.<br><i>Zee Captain would be not pleased...</i>"
	icon_state = "goner_offcap"
	flags_inv = NONE

/obj/item/clothing/head/helmet/f13/goner/officer/red
	name = "peaked red cap"
	desc = "A militaristic cap with red pin on the front.<br>Best headwear to give out promotions based on ones kill count."
	icon_state = "goner_offcap_r"

/obj/item/clothing/head/helmet/f13/goner/officer/green
	name = "peaked green cap"
	desc = "A militaristic cap with green pin on the front.<br>Ideal for a commander of the extinct army."
	icon_state = "goner_offcap_g"

/obj/item/clothing/head/helmet/f13/goner/officer/blue
	name = "peaked blue cap"
	desc = "A militaristic cap with blue pin on the front.<br>You probably want to keep your head low with this on."
	icon_state = "goner_offcap_b"

/obj/item/clothing/head/helmet/f13/goner/officer/yellow
	name = "peaked yellow cap"
	desc = "A militaristic cap with yellow pin on the front.<br>Might be not the best thing to wear if you are lost in the enemy territory..."
	icon_state = "goner_offcap_y"
