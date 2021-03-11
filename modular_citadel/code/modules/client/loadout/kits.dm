///Item boxes for custom loadouts transferred from Legacy.

/obj/item/storage/box/large/custom_kit
	name = "Custom Loadout"
	desc = "Your custom loadout items!"
	w_class = WEIGHT_CLASS_BULKY

//Terry Klip - luckydente
/obj/item/storage/box/large/custom_kit/terryklip/PopulateContents()
	new /obj/item/clothing/mask/bandana/skull(src)
	new /obj/item/clothing/glasses/sunglasses/big(src)

//Stephanie Moui - xerdies
/obj/item/storage/box/large/custom_kit/stephaniemoui/PopulateContents()
	new /obj/item/pda(src)
	new /obj/item/stack/f13Cash/aureus(src)

//Dana Seshata - s1lv3rv1x3n
/obj/item/storage/box/large/custom_kit/danaseshata/PopulateContents()
	new /obj/item/modkit/shank(src)
	new /obj/item/clothing/under/syndicate/tacticool(src)
	new /obj/item/clothing/shoes/f13/explorer(src)
	new /obj/item/clothing/gloves/f13/leather/fingerless(src)

//Ashton Fox - superballs
/obj/item/storage/box/large/custom_kit/ashtonfox/PopulateContents()
	new /obj/item/modkit/riotgear/fox(src)
	new /obj/item/modkit/riotgear_helmet/fox(src)
	new /obj/item/clothing/under/f13/ranger/vet/foxflannel(src)

//Rigs - topbirb
/obj/item/storage/box/large/custom_kit/rigs/PopulateContents()
	new /obj/item/modkit/riotgear/rigs(src)
	new /obj/item/modkit/riotgear_helmet/rigs(src)

//Avery Amadeus - topbirb
/obj/item/storage/box/large/custom_kit/averyamadeus/PopulateContents()
	new /obj/item/modkit/riotgear(src)
	new /obj/item/modkit/riotgear_helmet(src)

//Sangarinus Of Kanab - topbirb
/obj/item/storage/box/large/custom_kit/sangarinusofkanab/PopulateContents()
	new /obj/item/modkit/custom_excess(src)
	new /obj/item/modkit/custom_excess_helmet(src)

//John Thaxton - svenja
/obj/item/storage/box/large/custom_kit/johnthaxton/PopulateContents()
	new /obj/item/modkit/thax_patrol(src)
	new /obj/item/clothing/under/f13/ranger/vet/thaxflannel(src)
