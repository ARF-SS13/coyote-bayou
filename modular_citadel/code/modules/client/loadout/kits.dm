///Item boxes for custom loadouts transferred from Legacy.

/obj/item/storage/box/large/custom_kit
	name = "Custom Loadout"
	desc = "Your custom loadout items!"
	w_class = WEIGHT_CLASS_BULKY

//Crimson - Rigbe
/obj/item/storage/box/large/custom_kit/crimson/PopulateContents()
	new /obj/item/clothing/mask/bandana/skull(src)
	new /obj/item/clothing/glasses/sunglasses/big(src)

//Cas - Killergryphyn
/obj/item/storage/box/large/custom_kit/cas/PopulateContents()
	new /obj/item/clothing/under/f13/agent47(src)
	new /obj/item/clothing/gloves/modif_patrol(src)
	new /obj/item/storage/belt/military/assault(src)
	new /obj/item/storage/belt/holster/legholster(src)
	new /obj/item/clothing/mask/gas/hunter(src)
	new /obj/item/clothing/suit/armor/f13/herbertranger(src)
	new /obj/item/clothing/shoes/f13/military/desert(src)
	new /obj/item/clothing/head/helmet/f13/herbertranger(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/storage/backpack/satchel/enclave(src)

//Whiskey - WhiskeyXL
/obj/item/storage/box/large/custom_kit/whiskey/PopulateContents()
	new /obj/item/clothing/head/helmet/f13/ncr/rangercombat/desert/whiskey(src)
	new /obj/item/clothing/suit/armor/f13/rangercombat/desert/whiskey(src)
	new /obj/item/clothing/shoes/cowboyboots(src)
	new /obj/item/gun/ballistic/revolver/revolver44(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/clothing/under/f13/ranger(src)
	new /obj/item/storage/belt/waistsheath(src)
