/datum/gear/donator/kits/mrmannstealthsuit
	name = "Stealth Suit Bundle"
	path = /obj/item/storage/box/large/custom_kit/mrmannstealthsuit
	category = LOADOUT_CATEGORY_UNIFORM
	subcategory = LOADOUT_SUBCATEGORY_UNIFORM_GENERAL
	ckeywhitelist = list("plaugewalker")

/obj/item/storage/box/large/custom_kit/mrmannstealthsuit
	name = "Stealth Suit Bundle"
	desc = "An old chinese stealth suit and helmet rendered inoperable."
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/large/custom_kit/mrmannstealthsuit/PopulateContents()
	new /obj/item/clothing/under/f13/chinasuitcosmetic(src)
	new /obj/item/clothing/head/f13/chinahelmetcosmetic(src)
