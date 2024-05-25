//Fallout 13 animal hides directory

/obj/item/stack/sheet/animalhide/gecko
	name = "gecko skin"
	desc = "The perfect material for crafting clothing and armor."
	singular_name = "gecko skin piece"
	icon = 'icons/fallout/objects/items.dmi'
	icon_state = "sheet-geckohide"
	merge_type = /obj/item/stack/sheet/animalhide/gecko
	custom_materials = list(/datum/material/geckohide=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/sheet/animalhide/molerat
	name = "giant rat skin"
	desc = "A smelly piece of hide, mostly used as a doormat."
	singular_name = "giant rat skin piece"
	icon = 'icons/fallout/objects/items.dmi'
	icon_state = "sheet-molerat"
	merge_type = /obj/item/stack/sheet/animalhide/molerat
	custom_materials = list(/datum/material/molerathide=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/sheet/animalhide/aethergiest
	name = "aethergiest skin"
	desc = "A glorious hunting trophy."
	singular_name = "aethergiest skin piece"
	icon = 'icons/fallout/objects/items.dmi'
	icon_state = "sheet-aethergiest"
	merge_type = /obj/item/stack/sheet/animalhide/aethergiest
	custom_materials = list(/datum/material/aethergiesthide=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/sheet/animalhide/wolf
	name = "dog skin"
	desc = "Once upon a time, there lived a dog.<br>It was not a usual dog, because it lived out in the wild wasteland, where little kids are not allowed to play.<br>One day, the dog got mad and got into a fight with an adventurer.<br>The adventurer was stronger, and the dog was no more.<br>But some say a little part of this dog lives on to this day, still roaming the wild wasteland..."
	singular_name = "dog skin piece"
	icon = 'icons/fallout/objects/items.dmi'
	icon_state = "sheet-skin"
	merge_type = /obj/item/stack/sheet/animalhide/wolf
	custom_materials = list(/datum/material/wolfhide=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/sheet/animalhide/radstag
	name = "radstag hide"
	desc = "A raw pelt taken from a radstag."
	singular_name = "radstag hide piece"
	icon_state = "sheet-hide"
	merge_type = /obj/item/stack/sheet/animalhide/radstag
	custom_materials = list(/datum/material/radstaghide=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/sheet/animalhide/brahmin
	name = "brahmin skin"
	desc = "The by-product of brahmin farming."
	singular_name = "brahmin skin piece"
	icon_state = "sheet-hide" //ToDo: Brahmin Mat
	merge_type = /obj/item/stack/sheet/animalhide/brahmin
	custom_materials = list(/datum/material/brahminhide=MINERAL_MATERIAL_AMOUNT)
