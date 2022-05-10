//////////////////////////
// Salvaged Power Armor //
//////////////////////////

/obj/item/clothing/head/helmet/f13/heavy/salvaged_t45b
	name = "salvaged T-45b helmet"
	desc = "It's a salvaged T-45b power armor helmet."
	icon_state = "t45bhelmet"
	item_state = "t45bhelmet"
	armor = list("melee" = 65, "bullet" = 70, "laser" = 55, "energy" = 45, "bomb" = 45, "bio" = 60, "rad" = 30, "fire" = 60, "acid" = 20, "wound" = 30)
	slowdown = 0.1

/obj/item/clothing/head/helmet/f13/heavy/salvaged_t45b/raider
	name = "raider T-45b power helmet"
	desc = "a raider's attempt to duplicate a power armor helmet. The result is a fuzed mass of metal and ceramic that nonetheless provides protection"
	icon_state = "raiderpa_helm"
	item_state = "raiderpa_helm"
	armor = list("melee" = 60, "bullet" = 65, "laser" = 50, "energy" = 40, "bomb" = 40, "bio" = 55, "rad" = 25, "fire" = 55, "acid" = 15, "wound" = 25)
	slowdown = 0.05

/obj/item/clothing/head/helmet/f13/heavy/salvaged_t45b/ncr
	name = "ncr salvaged T-45b helmet"
	desc = "It's an NCR salvaged T-45b power armor helmet, better repaired than regular salvaged PA, and decorated with the NCR flag and other markings for an NCR Heavy Trooper."
	icon_state = "t45bhelmet_ncr"
	item_state = "t45bhelmet_ncr"

/obj/item/clothing/head/helmet/f13/heavy/salvaged_t45b/hotrod
	name = "hotrod T-45b power helmet"
	desc = "This power armor helmet is so decrepit and battle-worn that it have lost most of its capability to protect the wearer from harm."
	icon_state = "t45hotrod_helm"
	item_state = "t45hotrod_helm"
	armor = list("melee" = 55, "bullet" = 55, "laser" = 55, "energy" = 30, "bomb" = 40, "bio" = 50, "rad" = 30, "fire" = 80, "acid" = 10, "wound" = 30)

/obj/item/clothing/head/helmet/f13/heavy/salvaged_t45b/tribal
	name = "tribal t-45b headdress"
	desc = "A salvaged T-45b powered armor, with the servos removed and a feathered headdress. Certain bits of plating have been stripped out to retain more freedom of movement."
	icon_state = "tribal_PA_helmet"
	item_state = "tribal_PA_helmet"
	armor = list("melee" = 65, "bullet" = 55, "laser" = 55, "energy" = 20, "bomb" = 30, "bio" = 40, "rad" = 20, "fire" = 40, "acid" = 0, "wound" = 25)
	slowdown = 0
	resistance_flags = LAVA_PROOF | FIRE_PROOF
