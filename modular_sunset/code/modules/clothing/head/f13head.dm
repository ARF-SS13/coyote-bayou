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
	desc = "A non-existent cheap-looking helmet."
	icon = 'modular_sunset/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_sunset/icons/mob/clothing/head.dmi'
	icon_state = "goner_helmet"
	armor = list("melee" = 25, "bullet" = 10, "laser" = 10, "energy" = 15, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0, "wound" = 30)
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/head/helmet/f13/goner/red
	name = "red-marked generic helmet"
	desc = "A cheap-looking helmet with red paint applied from front to back."
	icon_state = "goner_helmet_r"

/obj/item/clothing/head/helmet/f13/goner/green
	name = "green-marked generic helmet"
	desc = "A cheap-looking helmet with green paint applied from front to back."
	icon_state = "goner_helmet_g"

/obj/item/clothing/head/helmet/f13/goner/blue
	name = "blue-marked generic helmet"
	desc = "A cheap-looking helmet with blue paint applied from front to back."
	icon_state = "goner_helmet_b"

/obj/item/clothing/head/helmet/f13/goner/yellow
	name = "yellow-marked generic helmet"
	desc = "A cheap-looking helmet with yellow paint applied from front to back."
	icon_state = "goner_helmet_y"

/obj/item/clothing/head/helmet/f13/goner/officer
	name = "peaked dev cap"
	desc = "A non-existent militaristic cap."
	icon_state = "goner_offcap"
	flags_inv = NONE

/obj/item/clothing/head/helmet/f13/goner/officer/red
	name = "peaked red cap"
	desc = "A militaristic cap with red pin on the front."
	icon_state = "goner_offcap_r"

/obj/item/clothing/head/helmet/f13/goner/officer/green
	name = "peaked green cap"
	desc = "A militaristic cap with green pin on the front."
	icon_state = "goner_offcap_g"

/obj/item/clothing/head/helmet/f13/goner/officer/blue
	name = "peaked blue cap"
	desc = "A militaristic cap with blue pin on the front."
	icon_state = "goner_offcap_b"

/obj/item/clothing/head/helmet/f13/goner/officer/yellow
	name = "peaked yellow cap"
	desc = "A militaristic cap with yellow pin on the front."
	icon_state = "goner_offcap_y"
