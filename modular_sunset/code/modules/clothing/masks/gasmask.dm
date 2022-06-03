/*
Just leaving this here for quick copy-pasting, for future contributors.
	icon = 'modular_sunset/icons/obj/clothing/masks.dmi'
	mob_overlay_icon = 'modular_sunset/icons/mob/clothing/mask.dmi'
	anthro_mob_worn_overlay = 'modular_sunset/icons/mob/clothing/mask_muzzled.dmi'
	mutantrace_variation = STYLE_MUZZLE (it is usually set by default for gas-masks)
	!!If you don't have snout-adapted sprites, then use `mutantrace_variation = NONE` instead. It should hide snout sprite when mask is worn.
	!!Or if your sprite covers the snout part anyway, use `mutantrace_variation = STYLE_NO_ANTHRO_ICON` instead.
*/

/obj/item/clothing/mask/gas/goner
	name = "full gas mask"
	desc = "A close-fitting mask.<br>Such equipment, perhaps, is beloved by many trenchers, mooks and romantically apocalyptic people."
	icon = 'modular_sunset/icons/obj/clothing/masks.dmi'
	mob_overlay_icon = 'modular_sunset/icons/mob/clothing/mask.dmi'
	anthro_mob_worn_overlay = 'modular_sunset/icons/mob/clothing/mask_muzzled.dmi'
	icon_state = "goner_mask"
	flags_inv = HIDEEARS | HIDEEYES | HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT

/obj/item/clothing/mask/gas/goner/aesthetic
	name = "broken full gas mask"
	desc = "A close-fitting mask. Alas, this one have broken filter along with hose, and could be used only for the looks or to conceal your identity."
	gas_transfer_coefficient = 0.8
	clothing_flags = NONE // Disables internals.
