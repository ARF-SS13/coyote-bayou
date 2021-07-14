///Item boxes for custom loadouts transferred from Legacy.

/obj/item/storage/box/large/custom_kit
	name = "Custom Loadout"
	desc = "Your custom loadout items!"
	w_class = WEIGHT_CLASS_BULKY

//Crimson - Rigbe
/obj/item/storage/box/large/custom_kit/crimson/PopulateContents()
	new /obj/item/clothing/mask/bandana/skull(src)
	new /obj/item/clothing/glasses/sunglasses/big(src)

//Cas - KillerGryphon
/obj/item/storage/box/large/custom_kit/cas/PopulateContents()
	new /obj/item/clothing/under/f13/agent47 
	new /obj/item/clothing/gloves/modif_patrol
	new /obj/item/storage/belt/military/assault
	new /obj/item/storage/belt/holster/legholster
	new /obj/item/clothing/mask/gas/hunter
	new /obj/item/clothing/suit/armor/f13/herbertranger
	new /obj/item/clothing/shoes/f13/military/desert
	new /obj/item/clothing/head/helmet/f13/herbertranger
	new /obj/item/flashlight/seclite
	new /obj/item/storage/backpack/satchel/enclave
