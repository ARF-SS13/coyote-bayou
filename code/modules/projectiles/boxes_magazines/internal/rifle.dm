/obj/item/ammo_box/magazine/internal/boltaction
	name = "bolt action rifle internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 5
	multiload = 1

/obj/item/ammo_box/magazine/internal/boltaction/twentytwo
	ammo_type = /obj/item/ammo_casing/a22
	caliber = list(CALIBER_22LR)

/obj/item/ammo_box/magazine/internal/boltaction/enchanted
	max_ammo = 1
//	ammo_type = /obj/item/ammo_casing/a762/enchanted

/obj/item/ammo_box/magazine/internal/boltaction/enchanted/arcane_barrage
	ammo_type = /obj/item/ammo_casing/magic/arcane_barrage

//Fallout 13

/obj/item/ammo_box/magazine/internal/boltaction/enfield
	max_ammo = 10
	multiload = 1
	
/obj/item/ammo_box/magazine/internal/boltaction/hunting
	ammo_type = /obj/item/ammo_casing/a3006
	caliber = list(CALIBER_3006)
	max_ammo = 5
	multiload = 1
	
/obj/item/ammo_box/magazine/internal/boltaction/hunting/paciencia
	max_ammo = 2 //with 1 in the tube = 3 shots

/obj/item/ammo_box/magazine/internal/boltaction/antimaterial
	ammo_type = /obj/item/ammo_casing/a50MG
	caliber = list(CALIBER_50MG)
	max_ammo = 4
	multiload = 0 //one bullet at a time

/obj/item/ammo_box/magazine/internal/salvaged_eastern_rifle
	name = "salvaged eastern rifle internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/m5mm
	caliber = list(CALIBER_556, CALIBER_5MM)
	max_ammo = 25
	multiload = FALSE // one at a time~

/obj/item/ammo_box/magazine/internal/mauserinternal
	name = "C96 Mauser internal magazine"
	desc = "Pew pew pew pew!"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 9
	multiload = FALSE

/obj/item/ammo_box/magazine/internal/needlerammo
	name = "magazine filled with needlers"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "needlerpack"
	ammo_type = /obj/item/ammo_casing/caseless/needle
	caliber = list(CALIBER_NEEDLE)
	max_ammo = 24
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = TRUE

/obj/item/ammo_box/magazine/internal/needlesvd
	name = "magazine filled with needlers"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "needlerpack"
	ammo_type = /obj/item/ammo_casing/caseless/needle
	caliber = list(CALIBER_NEEDLE)
	max_ammo = 10
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = TRUE

/obj/item/ammo_box/magazine/internal/needleshmg
	name = "magazine box filled with needlers"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "needlerpack"
	ammo_type = /obj/item/ammo_casing/caseless/needle
	caliber = list(CALIBER_NEEDLE)
	max_ammo = 48
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = TRUE

/obj/item/ammo_box/magazine/internal/needlessmg
	name = "magazine box filled with needlers"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "needlerpack"
	ammo_type = /obj/item/ammo_casing/caseless/needle
	caliber = list(CALIBER_NEEDLE)
	max_ammo = 35
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = TRUE

/obj/item/ammo_box/magazine/internal/mausereight
	name = "magazine box filled with mauser ammo"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "mauser"
	ammo_type = /obj/item/ammo_casing/a50MG
	caliber = list(CALIBER_50MG)
	max_ammo = 8
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = TRUE

/obj/item/ammo_box/magazine/internal/gewehreight
	name = "magazine box filled with mauser ammo"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "mauser"
	ammo_type = /obj/item/ammo_casing/a3006
	caliber = list(CALIBER_3006)
	max_ammo = 5
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = TRUE

/obj/item/ammo_box/magazine/internal/giantgun
	name = "magazine box filled with K bullets"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "mauser"
	ammo_type = /obj/item/ammo_casing/a50MG
	caliber = list(CALIBER_50MG)
	max_ammo = 1
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = FALSE

/obj/item/ammo_box/magazine/internal/grenadeshotgun
	name = "magazine filled with 40mm mike-mikes ouch ouchs"
	ammo_type = /obj/item/ammo_casing/a40mm/buck
	caliber = list(CALIBER_40MM)
	max_ammo = 8
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = FALSE

/obj/item/ammo_box/magazine/internal/gewehrinternal
	name = "magazine filled with 5mm."
	ammo_type = /obj/item/ammo_casing/m5mm
	caliber = list(CALIBER_5MM)
	max_ammo = 15
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = FALSE

/obj/item/ammo_box/magazine/internal/gewehrinternal/tox
	name = "magazine filled with mauser ammo(308)."
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 9
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = FALSE

/obj/item/ammo_box/magazine/internal/speedinglee
	name = "magazine filled with 308."
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 4
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = FALSE

/obj/item/ammo_box/magazine/internal/no3pistol //4+1 mechanic
	name = "magazine filled with Bergmann 6.5mm(5mm closest)."
	ammo_type = /obj/item/ammo_casing/m5mm
	caliber = list(CALIBER_5MM)
	max_ammo = 4
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = FALSE

/obj/item/ammo_box/magazine/internal/selfloaderinternal //4 because the weird 4+1 mechanic
	name = "magazine filled with mauser ammo(.30-06)."
	ammo_type = /obj/item/ammo_casing/a3006
	caliber = list(CALIBER_3006)
	max_ammo = 4
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = FALSE

/obj/item/ammo_box/magazine/internal/ptrs //4 because the weird 4+1 mechanic
	name = "magazine filled with 14.7mm ammo(50.cal)"
	ammo_type = /obj/item/ammo_casing/a50MG
	caliber = list(CALIBER_50MG)
	max_ammo = 4
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = FALSE

/obj/item/ammo_box/magazine/internal/boltaction/hebe
	ammo_type = /obj/item/ammo_casing/a50MG
	caliber = list(CALIBER_50MG)
	max_ammo = 2 // +1 = 3!
	multiload = 0 // One at a time, honey.
