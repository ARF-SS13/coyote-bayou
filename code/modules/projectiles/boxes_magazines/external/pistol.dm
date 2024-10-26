//////////////////////
// PISTOL MAGAZINES //
//////////////////////

/obj/item/ammo_box
	var/special_ammo = FALSE

/obj/item/ammo_box/update_overlays()
	. = ..()
	if(special_ammo)
		. += ("[initial(icon_state)]_x")

//.22
/obj/item/ammo_box/magazine/m22
	name = "pistol magazine (.22lr)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "pistol22"
	ammo_type = /obj/item/ammo_casing/a22
	caliber = list(CALIBER_22LR)
	max_ammo = 16
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_SMALL_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/m22/empty
	start_empty = 1

//.22 extended
/obj/item/ammo_box/magazine/m22/extended
	name = "carbine magazine (.22lr)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "22carbine"
	ammo_type = /obj/item/ammo_casing/a22
	caliber = list(CALIBER_22LR)
	max_ammo = 32
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/m22/extended/empty
	start_empty = 1

//9mm


//9mm
/obj/item/ammo_box/magazine/m9mm
	name = "pistol magazine (9mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "9mmp"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 10
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_SMALL_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/m9mm/empty
	start_empty = 1

/obj/item/ammo_box/magazine/rubee
	name = "pistol hive (9mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "9mmp"
	ammo_type = /obj/item/ammo_casing/bee
	caliber = list(CALIBER_BEE, CALIBER_9MM)
	max_ammo = 10
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_SMALL_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/mousegun
	name = "pistol nest (9mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "9mmp"
	ammo_type = /obj/item/ammo_casing/mouse
	caliber = list(CALIBER_MOUSE, CALIBER_9MM)
	max_ammo = 10
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_SMALL_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

//9mm doublestack
/obj/item/ammo_box/magazine/m9mm/doublestack
	name = "doublestack pistol magazine (9mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "m9mmds"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 15
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)

/obj/item/ammo_box/magazine/m9mm/doublestack/empty
	start_empty = 1

//10mm template
/obj/item/ammo_box/magazine/m10mm
	name = "pistol magazine (10mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	desc = "A gun magazine."
	caliber = list(CALIBER_10MM)
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

//10mm small
/obj/item/ammo_box/magazine/m10mm/adv
	name = "10mm pistol magazine (10mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "m10mm"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 12
	multiple_sprites = 2

/obj/item/ammo_box/magazine/m10mm/adv/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m10mm/adv/simple

/obj/item/ammo_box/magazine/m10mm/adv/simple/empty
	start_empty = 1

//10mm extended
/obj/item/ammo_box/magazine/m10mm/adv/ext
	name = "10mm extended magazine (10mm)"
	icon_state = "smg10mm"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 24
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_SMG)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/m10mm/adv/ext/empty
	start_empty = 1

//.45
/obj/item/ammo_box/magazine/m45
	name = "handgun magazine (.45)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = list(CALIBER_45ACP)
	max_ammo = 8
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)

/obj/item/ammo_box/magazine/m45/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m45/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[round(ammo_count(),4)]"

//.45 rubber
/obj/item/ammo_box/magazine/m45/rubber
	name = "handgun magazine (.45 rubber)"
	ammo_type = /obj/item/ammo_casing/c45/rubber

/obj/item/ammo_box/magazine/m45/rubber/empty
	start_empty = 1

//.45 socom
/obj/item/ammo_box/magazine/m45/socom
	name = "socom magazine (.45)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "45socom"
	ammo_type = /obj/item/ammo_casing/c45
	max_ammo = 12
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/m45/socom/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m45/socom/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[stored_ammo.len ? "[max_ammo]" : "0"]" // I hate this system

//.44 Magnum
/obj/item/ammo_box/magazine/m44
	name = "handgun magazine (.44 magnum)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "50ae"
	ammo_type = /obj/item/ammo_casing/m44
	caliber = list(CALIBER_44)
	max_ammo = 8
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_HEAVY_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/m44/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m44/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[round(ammo_count(),4)]"

/obj/item/ammo_box/magazine/m44/automag
	name = "automag magazine (.44 magnum)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "magnum"
	ammo_type = /obj/item/ammo_casing/m44
	max_ammo = 7
	multiple_sprites = 2

/obj/item/ammo_box/magazine/m44/automag/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m44/automag/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[stored_ammo.len ? "[max_ammo]" : "0"]"

//14mm
/obj/item/ammo_box/magazine/m14mm
	name = "handgun magazine (14mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "50ae"
	ammo_type = /obj/item/ammo_casing/p14mm
	caliber = list(CALIBER_14MM)
	max_ammo = 7
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_HEAVY_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/m14mm/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m14mm/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[round(ammo_count(),4)]"

/obj/item/ammo_box/magazine/m5mmcustom
	name = "handgun magazine (5mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "5mmmag"
	ammo_type = /obj/item/ammo_casing/m5mm
	caliber = list(CALIBER_5MM)
	max_ammo = 20
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_HEAVY_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/m5mmcustom/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m47pistol
	name = "handgun magazine (4.7mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "pistol47"
	ammo_type = /obj/item/ammo_casing/caseless/g11
	caliber = list(CALIBER_CASELESS)
	max_ammo = 18
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_HEAVY_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/m47pistol/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m14mmcustom
	name = "handgun magazine (14mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "14mmmagnum"
	ammo_type = /obj/item/ammo_casing/p14mm
	caliber = list(CALIBER_14MM)
	max_ammo = 5
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_HEAVY_PISTOL_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/m14mmcustom/empty
	start_empty = 1

// BETA STUFF // Obsolete
/obj/item/ammo_box/magazine/testbullet
	name = "Bulletcrate"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "m9mmds"
	ammo_type = /obj/item/ammo_casing/testcasing
	caliber = list(CALIBER_9MM)
	max_ammo = 100


/obj/item/ammo_box/magazine/needlercapsule
	name = "Capsule filled with needlers"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "needlerpack"
	ammo_type = /obj/item/ammo_casing/caseless/needle
	caliber = list(CALIBER_NEEDLE)
	max_ammo = 24
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_LIGHT_RIFLE_MAGAZINE)
	w_class = WEIGHT_CLASS_TINY
	multiload = TRUE
