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

/datum/gear/donator/kits/midgetdragonvest
	name = "Great Beat Vest Bundle"
	path = /obj/item/clothing/under/f13/bearvest
	category = LOADOUT_CATEGORY_UNIFORM
	subcategory = LOADOUT_SUBCATEGORY_UNIFORM_GENERAL
	ckeywhitelist = list("midgetdragon")


/datum/gear/donator/kits/cayce
	name = "Jett Lowe's belongings"
	path = /obj/item/storage/box/large/custom_kit/cayce
	category = LOADOUT_CATEGORY_BACKPACK
	subcategory = LOADOUT_SUBCATEGORY_BACKPACK_TOYS
	ckeywhitelist = list("cayce")

/obj/item/storage/box/large/custom_kit/cayce
	name = "Jett Lowe's belongings"
	desc = "Some things they've left behind for themselves."
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/large/custom_kit/cayce/PopulateContents()
	new /obj/item/clothing/suit/armored/medium/steelbib(src)
	new /obj/item/clothing/head/helmet/armyhelmet/heavy(src)
	new /obj/item/twohanded/sledgehammer(src)
	new /obj/item/pda(src)

