/obj/item/ammo_box/magazine/wt550m9
	name = "wt550 magazine (4.6x30mm)"
	icon_state = "46x30mmt-20"
	ammo_type = /obj/item/ammo_casing/c46x30mm
	caliber = "4.6x30mm"
	max_ammo = 32

/obj/item/ammo_box/magazine/wt550m9/update_icon()
	..()
	icon_state = "46x30mmt-[round(20*(ammo_count()/max_ammo),4)]"

/obj/item/ammo_box/magazine/wt550m9/wtap
	name = "wt550 magazine (Armour Piercing 4.6x30mm)"
	icon_state = "46x30mmtA-20"

/obj/item/ammo_box/magazine/wt550m9/wtap/update_icon()
	..()
	icon_state = "46x30mmtA-[round(20*(ammo_count()/max_ammo),4)]"

/obj/item/ammo_box/magazine/wt550m9/wtic
	name = "wt550 magazine (Incendiary 4.6x30mm)"
	icon_state = "46x30mmtI-20"
/obj/item/ammo_box/magazine/wt550m9/wtic/update_icon()
	..()
	icon_state = "46x30mmtI-[round(20*(ammo_count()/max_ammo),4)]"

/obj/item/ammo_box/magazine/uzim9mm
	name = "uzi magazine (9mm)"
	icon_state = "uzi9mm-32"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 32

/obj/item/ammo_box/magazine/uzim9mm/update_icon()
	..()
	icon_state = "uzi9mm-[round(ammo_count(),4)]"

/obj/item/ammo_box/magazine/uzim9mm/empty
	start_empty = 1

/obj/item/ammo_box/magazine/smgm9mm
	name = "SMG magazine (9mm)"
	icon_state = "smg9mm-42"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 21

/obj/item/ammo_box/magazine/smgm9mm/update_icon()
	..()
	icon_state = "smg9mm-[ammo_count() ? "42" : "0"]"

/obj/item/ammo_box/magazine/smgm9mm/ap
	name = "SMG magazine (Armour Piercing 9mm)"
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/ammo_box/magazine/smgm9mm/fire
	name = "SMG Magazine (Incendiary 9mm)"

/obj/item/ammo_box/magazine/smgm45
	name = "SMG magazine (.45)"
	icon_state = "c20r45-24"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 24

/obj/item/ammo_box/magazine/smgm45/update_icon()
	..()
	icon_state = "c20r45-[round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/tommygunm45
	name = "drum magazine (.45)"
	icon_state = "drum45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 50

/obj/item/ammo_box/magazine/tommygunm45/empty
	start_empty = 1

/*
---Fallout 13---
*/

/obj/item/ammo_box/magazine/cg45
	name = "Carl Gustaf magazine (10mm)"
	icon_state = "cg45"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 36
	multiple_sprites = 2

/obj/item/ammo_box/magazine/greasegun
	name = "45 submachine gun magazine (.45)"
	icon_state = "grease"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 30
	multiple_sprites = 2

/obj/item/ammo_box/magazine/greasegun/empty
	start_empty = 1

/obj/item/ammo_box/magazine/pps9mm
	name = "ppsh magazine (9mm)"
	icon_state = "ppshDrum"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 71
	multiple_sprites = 2

/obj/item/ammo_box/magazine/pps9mm/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m10mm_p90
	name = "toploader magazine (10mm)"
	icon_state = "5.56m"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 50
	multiple_sprites = 2

/obj/item/ammo_box/magazine/m10mm_p90/empty
	start_empty = 1

/obj/item/ammo_box/magazine/m22smg
	name = "toploader magazine (.22lr)"
	icon_state = "smg22"
	ammo_type = /obj/item/ammo_casing/a22
	caliber = ".22lr"
	max_ammo = 180
	multiple_sprites = 2

/obj/item/ammo_box/magazine/m22smg/empty
	start_empty = 1
