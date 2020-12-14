/obj/item/ammo_box/magazine/internal/cylinder/rev38
	name = "detective revolver cylinder"
	ammo_type = /obj/item/ammo_casing/c38
	caliber = list("38")
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/rev762
	name = "\improper Nagant revolver cylinder"
	ammo_type = /obj/item/ammo_casing/n762
	caliber = list("n762")
	max_ammo = 7

/obj/item/ammo_box/magazine/internal/cylinder/rus357
	name = "\improper Russian revolver cylinder"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = list("357")
	max_ammo = 6
	multiload = 0


/obj/item/ammo_box/magazine/internal/cylinder/rev6520
	name = "6520 10mm cylinder"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = list("10mm")
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/zhurong
	name = "zhurong 10mm cylinder"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = list("10mm")
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/rev4570
	name = "4570 cylinder"
	ammo_type = /obj/item/ammo_casing/c4570
	caliber = list("4570")
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/revneedler
	name = "needler internal mag"
	ammo_type = /obj/item/ammo_casing/caseless/needle
	caliber = list("needle")
	max_ammo = 10

/obj/item/ammo_box/magazine/internal/rus357/Initialize()
	stored_ammo += new ammo_type(src)
	. = ..()
/obj/item/ammo_box/magazine/internal/cylinder/improvised9mm
	name = "improvised internal magazine"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = list("9mm")
	max_ammo = 4

/obj/item/ammo_box/magazine/internal/cylinder/improvised10mm
	name = "improvised internal magazine"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = list("10mm")
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/thatgun
	name = ".223 pistol cylinder"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = list("a556")
	max_ammo = 5

/obj/item/ammo_box/magazine/internal/cylinder/rev44
	name = "44 magnum cylinder"
	ammo_type = /obj/item/ammo_casing/m44
	caliber = list("44")
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/rev357
	name = "357 magnum cylinder"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = list("357")
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/shotgunrevolver
	name = "revolver shotgun cylinder"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = list("shotgun")
	max_ammo = 3
