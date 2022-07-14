//////////////////////////
// Salvaged Power Armor //
//////////////////////////

/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa
	name = "salvaged power helmet"
	desc = "It's a salvaged power armor helmet of what..? YOU CAN'T SEE ME! STOP! REPORT TO CODERS!!"
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_SALVAGE

// T-45B
/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b
	name = "salvaged T-45b helmet"
	desc = "It's a salvaged T-45b power armor helmet."
	icon_state = "t45bhelmet"
	item_state = "t45bhelmet"

/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b/raider
	name = "raider T-45b power helmet"
	desc = "a raider's attempt to duplicate a power armor helmet. The result is a fuzed mass of metal and ceramic that nonetheless provides protection"
	icon_state = "raiderpa_helm"
	item_state = "raiderpa_helm"

/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b/ncr
	name = "ncr salvaged T-45b helmet"
	desc = "It's an NCR salvaged T-45b power armor helmet, better repaired than regular salvaged PA, and decorated with the NCR flag and other markings for an NCR Heavy Trooper."
	icon_state = "t45bhelmet_ncr"
	item_state = "t45bhelmet_ncr"

/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b/hotrod
	name = "hotrod T-45b power helmet"
	desc = "This power armor helmet is so decrepit and battle-worn that it have lost most of its capability to protect the wearer from harm."
	icon_state = "t45hotrod_helm"
	item_state = "t45hotrod_helm"
	armor_tokens = list(ARMOR_MODIFIER_UP_FIRE_T3)

/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b/tribal
	name = "tribal t-45b headdress"
	desc = "A salvaged T-45b powered armor, with the servos removed and a feathered headdress. Certain bits of plating have been stripped out to retain more freedom of movement."
	icon_state = "tribal_PA_helmet"
	item_state = "tribal_PA_helmet"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2, ARMOR_MODIFIER_DOWN_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T2)
	slowdown = 0
	resistance_flags = LAVA_PROOF | FIRE_PROOF

// T-45D
/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45d
	name = "salvaged T-45d helmet"
	desc = "It's a salvaged T-45d power armor helmet."
	icon_state = "t45dhelmet0"
	item_state = "t45dhelmet0"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1)

// Midwest
/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/midwest
	name = "salvaged midwestern T-51b power helmet"
	desc = "This helmet belongs to the Midwestern branch of the Brotherhood of Steel. Its electronics appear to have been stripped out."
	icon_state = "midwestgrey_helm"
	item_state = "midwestgrey_helm"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T2)

// Hardened Midwest
/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/midwest/hardened
	name = "salvaged hardened midwestern T-51b power helmet"
	desc = "This helmet belongs to the Midwestern branch of the Brotherhood of Steel. Its electronics appears to have been stripped out."
	icon_state = "midwestpa_helm"
	item_state = "midwestpa_helm"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_LASER_T2)

// T-51B
/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t51b
	name = "salvaged T-51b power armor"
	desc = "It's a salvaged T-51b power armor helmet."
	icon_state = "t51bhelmet0"
	item_state = "t51bhelmet0"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T2)

// T-60A
/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t60
	name = "salvaged T-60a helmet"
	desc = "It's a salvaged T-60a power armor helmet."
	icon_state = "t60helmet0"
	item_state = "t60helmet0"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_LASER_T2)

// X-02
/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/x02
	name = "salvaged Enclave helmet"
	desc = "It's a salvaged X-02 power armor helmet."
	icon_state = "advanced"
	item_state = "advanced"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T3, ARMOR_MODIFIER_UP_BULLET_T3, ARMOR_MODIFIER_UP_LASER_T3)

